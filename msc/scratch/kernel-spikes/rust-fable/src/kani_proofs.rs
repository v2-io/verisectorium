//! Bounded model checks of P3, P4, P5, P6, P7 with Kani (CBMC underneath).
//!
//! These run the *real* kernel code on symbolic inputs drawn from a tiny
//! alphabet: every id is one of `a`/`b`/`c`, every version one of `1`/`2`,
//! every rung and act kind is any value. The bounds are the honest part of the
//! claim: what is checked is "for every state reachable from the empty store
//! by at most N records over this alphabet", not "for every state". The
//! account says what N was reached and how long each took.
//!
//! Run: `cargo kani --harness <name>` (or all: `cargo kani`).

use super::*;

const IDS: [&str; 3] = ["a", "b", "c"];
const VERSIONS: [&str; 2] = ["1", "2"];
const SEGMENTS: [&str; 2] = ["S", "T"];

fn pick<const N: usize>(xs: [&'static str; N]) -> &'static str {
    let i: usize = kani::any();
    kani::assume(i < N);
    xs[i]
}

fn sym_reference() -> Reference {
    Reference { target: pick(IDS).into(), needed: kani::any(), seen: pick(VERSIONS).into() }
}

fn sym_veritoid(segment: &str, refs: usize) -> Veritoid {
    let mut references = Vec::new();
    for _ in 0..refs {
        references.push(sym_reference());
    }
    Veritoid { id: pick(IDS).into(), segment: segment.into(), version: pick(VERSIONS).into(), claimed: kani::any(), references }
}

/// A changeset of `n` veritoids, each with up to `refs` references.
fn sym_changeset(n: usize, refs: usize) -> Changeset {
    let segment = pick(SEGMENTS);
    let mut veritoids = Vec::new();
    for _ in 0..n {
        let r: usize = kani::any();
        kani::assume(r <= refs);
        veritoids.push(sym_veritoid(segment, r));
    }
    Changeset { segment: segment.into(), veritoids }
}

fn sym_act(reads: usize) -> Act {
    let mut rs = BTreeSet::new();
    for _ in 0..reads {
        rs.insert(Read::new(pick(IDS), pick(VERSIONS)));
    }
    Act { actor: "A".into(), criterion: "k".into(), kind: kani::any(), reads: rs, rung: kani::any() }
}

/// A reachable state: one or two changesets, then up to `acts` acts.
/// Returns `None` when a symbolic record was refused (that path is dropped,
/// which is sound: the property is about reachable states).
fn sym_state(changesets: usize, acts: usize) -> Option<State> {
    let mut s = State::empty();
    for _ in 0..changesets {
        s = s.with(&Record::Changeset(sym_changeset(2, 1))).ok()?;
    }
    for _ in 0..acts {
        let n: usize = kani::any();
        kani::assume(n <= 2);
        s = s.with(&Record::Act(sym_act(n))).ok()?;
    }
    Some(s)
}

fn all_ids() -> [VeritoidId; 3] {
    [IDS[0].into(), IDS[1].into(), IDS[2].into()]
}

/// P6 on every reachable state within the bound.
#[kani::proof]
#[kani::unwind(6)]
fn p6_ceiling_bound() {
    let Some(s) = sym_state(1, 1) else { return };
    for (id, v) in s.veritoids() {
        assert!(s.ceiling(id) <= s.position(id));
        for r in &v.references {
            assert!(s.ceiling(id) <= s.ceiling(&r.target));
        }
    }
}

/// P7: if steady then claimed <= ceiling everywhere.
#[kani::proof]
#[kani::unwind(6)]
fn p7_steady_means_honest() {
    let Some(s) = sym_state(1, 1) else { return };
    if s.steady() {
        for (id, v) in s.veritoids() {
            assert!(v.claimed <= s.ceiling(id));
        }
    }
}

/// P4: one more act never lowers any position and raises only read ids.
#[kani::proof]
#[kani::unwind(6)]
fn p4_monotone_under_acts() {
    let Some(before) = sym_state(1, 1) else { return };
    let n: usize = kani::any();
    kani::assume(n <= 2);
    let act = sym_act(n);
    let after = before.with(&Record::Act(act.clone())).unwrap();
    for id in all_ids() {
        let (p0, p1) = (before.position(&id), after.position(&id));
        assert!(p1 >= p0);
        if p1 > p0 {
            assert!(act.kind == ActKind::Check);
            assert!(act.reads.iter().any(|r| r.id == id));
        }
    }
}

/// P3: for an act binding before an accepted changeset, it binds after iff
/// none of its reads changed current version.
#[kani::proof]
#[kani::unwind(6)]
fn p3_lapse_is_exact() {
    let Some(before) = sym_state(1, 1) else { return };
    let cs = sym_changeset(1, 1);
    let Ok(after) = before.with(&Record::Changeset(cs)) else { return };
    for a in before.acts() {
        if before.binds(a) {
            let touched = a.reads.iter().any(|r| before.current(&r.id) != after.current(&r.id));
            assert!(after.binds(a) == !touched);
        }
    }
}

/// P5: no reachable state has a reference cycle, by an independent
/// (reachability-matrix) test rather than the kernel's DFS.
#[kani::proof]
#[kani::unwind(6)]
fn p5_reachable_states_are_acyclic() {
    let Some(s) = sym_state(2, 0) else { return };
    let ids = all_ids();
    // adjacency among existing ids
    let mut adj = [[false; 3]; 3];
    for (i, id) in ids.iter().enumerate() {
        if let Some(v) = s.veritoid(id) {
            for r in &v.references {
                for (j, t) in ids.iter().enumerate() {
                    if &r.target == t && s.veritoid(t).is_some() {
                        adj[i][j] = true;
                    }
                }
            }
        }
    }
    // transitive closure (Warshall)
    for k in 0..3 {
        for i in 0..3 {
            for j in 0..3 {
                if adj[i][k] && adj[k][j] {
                    adj[i][j] = true;
                }
            }
        }
    }
    for i in 0..3 {
        assert!(!adj[i][i]);
    }
}

// ---------------------------------------------------------------------------
// Second family: concrete ids, symbolic everything else.
//
// With symbolic ids every BTreeMap insertion branches on string comparison
// and CBMC's path count explodes before it reaches the property. Here the
// ids present are fixed (`a`, `b` in S; `c` in T) and what stays symbolic is:
// every version, every claimed level, every reference target and needed rung
// and seen version, every act's kind, rung and reads. That is still the whole
// space of *values* the properties quantify over, on a fixed shape.
// ---------------------------------------------------------------------------

fn fixed_veritoid(id: &str, segment: &str, refs: usize) -> Veritoid {
    let mut references = Vec::new();
    for _ in 0..refs {
        references.push(sym_reference());
    }
    Veritoid { id: id.into(), segment: segment.into(), version: pick(VERSIONS).into(), claimed: kani::any(), references }
}

/// S holds a, b (one symbolic reference each); T holds c (one symbolic
/// reference). Then `acts` symbolic acts of up to two reads.
fn fixed_state(acts: usize) -> Option<State> {
    let mut s = State::empty();
    s = s
        .with(&Record::Changeset(Changeset {
            segment: "S".into(),
            veritoids: vec![fixed_veritoid("a", "S", 1), fixed_veritoid("b", "S", 1)],
        }))
        .ok()?;
    s = s
        .with(&Record::Changeset(Changeset { segment: "T".into(), veritoids: vec![fixed_veritoid("c", "T", 1)] }))
        .ok()?;
    for _ in 0..acts {
        let n: usize = kani::any();
        kani::assume(n <= 2);
        s = s.with(&Record::Act(sym_act(n))).ok()?;
    }
    Some(s)
}

#[kani::proof]
#[kani::unwind(6)]
fn fixed_p6_ceiling_bound() {
    let Some(s) = fixed_state(1) else { return };
    for (id, v) in s.veritoids() {
        assert!(s.ceiling(id) <= s.position(id));
        for r in &v.references {
            assert!(s.ceiling(id) <= s.ceiling(&r.target));
        }
    }
}

#[kani::proof]
#[kani::unwind(6)]
fn fixed_p7_steady_means_honest() {
    let Some(s) = fixed_state(1) else { return };
    if s.steady() {
        for (id, v) in s.veritoids() {
            assert!(v.claimed <= s.ceiling(id));
        }
    }
}

#[kani::proof]
#[kani::unwind(6)]
fn fixed_p4_monotone_under_acts() {
    let Some(before) = fixed_state(1) else { return };
    let n: usize = kani::any();
    kani::assume(n <= 2);
    let act = sym_act(n);
    let after = before.with(&Record::Act(act.clone())).unwrap();
    for id in all_ids() {
        let (p0, p1) = (before.position(&id), after.position(&id));
        assert!(p1 >= p0);
        if p1 > p0 {
            assert!(act.kind == ActKind::Check);
            assert!(act.reads.iter().any(|r| r.id == id));
        }
    }
}

#[kani::proof]
#[kani::unwind(6)]
fn fixed_p3_lapse_is_exact() {
    let Some(before) = fixed_state(1) else { return };
    // T is rewritten: c at a symbolic version, or removed.
    let keep: bool = kani::any();
    let veritoids = if keep { vec![fixed_veritoid("c", "T", 1)] } else { vec![] };
    let Ok(after) = before.with(&Record::Changeset(Changeset { segment: "T".into(), veritoids })) else { return };
    for a in before.acts() {
        if before.binds(a) {
            let touched = a.reads.iter().any(|r| before.current(&r.id) != after.current(&r.id));
            assert!(after.binds(a) == !touched);
        }
        // reads entirely outside T are unaffected
        let outside = a.reads.iter().all(|r| r.id != VeritoidId::from("c"));
        if outside {
            assert!(before.binds(a) == after.binds(a));
        }
    }
}

#[kani::proof]
#[kani::unwind(6)]
fn fixed_p5_reachable_states_are_acyclic() {
    let Some(s) = fixed_state(0) else { return };
    let ids = all_ids();
    let mut adj = [[false; 3]; 3];
    for (i, id) in ids.iter().enumerate() {
        if let Some(v) = s.veritoid(id) {
            for r in &v.references {
                for (j, t) in ids.iter().enumerate() {
                    if &r.target == t && s.veritoid(t).is_some() {
                        adj[i][j] = true;
                    }
                }
            }
        }
    }
    for k in 0..3 {
        for i in 0..3 {
            for j in 0..3 {
                if adj[i][k] && adj[k][j] {
                    adj[i][j] = true;
                }
            }
        }
    }
    for i in 0..3 {
        assert!(!adj[i][i]);
    }
}
