//! Kani proof harnesses: bounded model checking of the kernel's own code
//! (`state.rs`, `log.rs`), not of a re-model of it. Each harness proves its
//! assertion for *every* input within its stated bounds; CBMC also checks
//! every panic, overflow and out-of-bounds index on the way. Under kani, ids
//! are `u8` (see `model::Name`). Run: `cargo kani --harness <name>`.
//!
//! The bounds (the honest scope of "proved" here): ids drawn from IDS = 2 values,
//! segments from 2, versions from {1, 2}; a changeset holds at most 2
//! veritoids with at most 2 references each; an act reads at most 2 ids and
//! concerns any subset of them; logs of the lengths each harness states.


use crate::model::*;
use crate::state::*;

/// Ids drawn from 0..IDS. At 3, the smallest step harness had not finished
/// after ~6.5 minutes (kani-logs/p5_step.ids3.*); at 2 they do.
const IDS: u8 = 2;

fn any_rung() -> Rung {
    let r: u8 = kani::any();
    kani::assume(r < 4);
    Rung::ALL[r as usize]
}
fn any_id() -> VeritoidId {
    let i: u8 = kani::any();
    kani::assume(i < IDS);
    VeritoidId(i)
}
fn any_version() -> Version {
    let v: u64 = kani::any();
    kani::assume((1..=2).contains(&v));
    Version(v)
}

fn any_written() -> Written {
    let mut references = Map::new();
    let k: u8 = kani::any();
    kani::assume(k <= 2);
    for _ in 0..k {
        references.insert(any_id(), Reference { needed: any_rung(), seen: any_version() });
    }
    Written { version: any_version(), claimed: any_rung(), references }
}

fn any_changeset() -> SegmentChangeset {
    let s: u8 = kani::any();
    kani::assume(s < 2);
    let mut veritoids = Map::new();
    let k: u8 = kani::any();
    kani::assume(k <= 2);
    for _ in 0..k {
        veritoids.insert(any_id(), any_written());
    }
    SegmentChangeset { segment: SegmentId(s), author: String::new(), veritoids }
}

fn any_act() -> Act {
    let mut reads = Map::new();
    let k: u8 = kani::any();
    kani::assume(k <= 2);
    for _ in 0..k {
        reads.insert(any_id(), any_version());
    }
    let mut concerns = Set::new();
    for id in reads.keys() {
        if kani::any() {
            concerns.insert(id.clone());
        }
    }
    let kind = if kani::any() { ActKind::Affirmation } else { ActKind::Check { rung: any_rung() } };
    Act { actor: String::new(), criterion: String::new(), kind, reads, concerns }
}

fn any_record() -> Record {
    if kani::any() { Record::Changeset(any_changeset()) } else { Record::Act(any_act()) }
}

/// A state reached by folding `n` arbitrary records.
fn any_state(n: usize) -> State {
    let mut s = State::default();
    for _ in 0..n {
        s.apply(&any_record());
    }
    s
}

/// P5: every state reachable in 3 records has an acyclic reference graph.
#[kani::proof]
#[kani::unwind(5)]
fn p5_acyclic() {
    let s = any_state(3);
    assert!(find_cycle(s.veritoids()).is_none());
}

/// P6: for every state reachable in 3 records, every veritoid's ceiling is at
/// most its position and at most every held target's ceiling; a missing
/// target caps it at sketch.
#[kani::proof]
#[kani::unwind(5)]
fn p6_ceiling_bound() {
    let s = any_state(3);
    let pos = s.positions();
    let ceil = s.ceilings();
    for (v, h) in s.veritoids() {
        assert!(ceil[v] <= pos[v]);
        for t in h.written.references.keys() {
            match ceil.get(t) {
                Some(tc) => {
                    assert!(ceil[v] <= *tc)
                }
                None => {
                    assert!(ceil[v] == Rung::Sketch)
                }
            }
        }
    }
}

/// P4 (strong form): from every state reachable in 2 records, appending any
/// act lowers no position, raises only positions of what it concerns, and
/// adds nothing to the frontier.
#[kani::proof]
#[kani::unwind(5)]
fn p4_monotone_under_acts() {
    let before = any_state(2);
    let a = any_act();
    let mut after = before.clone();
    after.apply(&Record::Act(a.clone()));
    let (p0, p1) = (before.positions(), after.positions());
    for (v, r0) in &p0 {
        assert!(p1[v] >= *r0);
        if p1[v] != *r0 {
            assert!(a.concerns.contains(v));
        }
    }
    assert!(after.frontier().is_subset(&before.frontier()));
}

/// P3: from every state reachable in 2 records, for any changeset that is
/// applied, an act that bound before stops binding iff it read an
/// (id, version) the changeset changed or removed; an act reading nothing in
/// the segment keeps its binding.
#[kani::proof]
#[kani::unwind(5)]
fn p3_lapse_exact() {
    let before = any_state(2);
    let a = any_act();
    let cs = any_changeset();
    let mut after = before.clone();
    let applied = after.apply(&Record::Changeset(cs.clone())) == Outcome::Applied;
    if !applied {
        assert!(after.veritoids() == before.veritoids());
        return;
    }
    let read_gone = a.reads.iter().any(|(k, v)| before.current_version(k) == Some(*v) && after.current_version(k) != Some(*v));
    if before.binds(&a) {
        assert!(after.binds(&a) != read_gone);
    }
    let in_segment = |k: &VeritoidId| {
        before.veritoids().get(k).is_some_and(|h| h.segment == cs.segment)
            || after.veritoids().get(k).is_some_and(|h| h.segment == cs.segment)
    };
    if a.reads.keys().all(|k| !in_segment(k)) {
        assert!(before.binds(&a) == after.binds(&a));
    }
}

/// P7: every steady state reachable in 3 records is honest.
#[kani::proof]
#[kani::unwind(5)]
fn p7_steady_is_honest() {
    let s = any_state(3);
    if s.steady() {
        let ceil = s.ceilings();
        for (v, h) in s.veritoids() {
            assert!(h.written.claimed <= ceil[v]);
        }
    }
}

// ---------------------------------------------------------------------------
// Step harnesses: start from an ARBITRARY pre-state within the bounds (not
// only those reachable by a short log), so the result holds for every
// reachable state within the bounds, at any log length. Acyclicity of the
// pre-state is assumed via `naive_acyclic`, which is independent of the
// kernel's `find_cycle` (so P5 is not checked against itself).

/// Acyclic by brute force: with at most IDS nodes, a cycle exists iff some
/// node reaches itself in at most IDS steps.
fn naive_acyclic(m: &Map<VeritoidId, Held>) -> bool {
    let edges = |v: &VeritoidId| -> Vec<VeritoidId> {
        m.get(v).map(|h| h.written.references.keys().filter(|t| m.contains_key(*t)).cloned().collect()).unwrap_or_default()
    };
    for start in m.keys() {
        let mut frontier = vec![start.clone()];
        for _ in 0..IDS {
            let mut next = Vec::new();
            for v in &frontier {
                for t in edges(v) {
                    if &t == start {
                        return false;
                    }
                    next.push(t);
                }
            }
            frontier = next;
        }
    }
    true
}

/// An arbitrary map of at most `IDS` held veritoids (ids 0..IDS, each in one
/// of 2 segments), acyclic.
fn any_held_map() -> Map<VeritoidId, Held> {
    let mut m = Map::new();
    for i in 0..IDS {
        if kani::any() {
            let s: u8 = kani::any();
            kani::assume(s < 2);
            m.insert(VeritoidId(i), Held { segment: SegmentId(s), written: any_written() });
        }
    }
    kani::assume(naive_acyclic(&m));
    m
}

/// The `written` history of a pre-state: what is held now (an invariant of
/// every reachable state), plus, for every other (id, version) key in the
/// bounds, optionally some earlier writing of it. Every reachable history
/// within the bounds is one of these.
fn any_history(m: &Map<VeritoidId, Held>) -> Map<(VeritoidId, Version), Map<VeritoidId, Reference>> {
    let mut w: Map<_, _> = m.iter().map(|(k, h)| ((k.clone(), h.written.version), h.written.references.clone())).collect();
    for i in 0..IDS {
        for v in 1..=2u64 {
            let key = (VeritoidId(i), Version(v));
            if !w.contains_key(&key) && kani::any() {
                w.insert(key, any_written().references);
            }
        }
    }
    w
}

/// Up to 3 recorded acts. At IDS = 2 this realizes every computed value a
/// state can have (positions need at most one check per id; at most one
/// (v, target) pair can be reconciled, since a<->b would be a cycle), so a
/// property of computed values proved here holds whatever the act count.
/// (That reduction is an argument in account.md, not machine-checked.)
fn any_acts() -> Vec<(usize, Act)> {
    let mut acts = Vec::new();
    for i in 0..3 {
        if kani::any() {
            acts.push((i, any_wellformed_act()));
        }
    }
    acts
}

fn any_wellformed_act() -> Act {
    let a = any_act();
    kani::assume(!a.concerns.is_empty());
    a
}

/// P5, inductive step: from ANY acyclic pre-state, applying ANY changeset
/// leaves the graph acyclic; and a cycle refusal is given only when the
/// changeset really would have closed a cycle. With the empty state as base
/// case, this is P5 for every log of any length, within the id/size bounds.
#[kani::proof]
// unwind 8: find_cycle's DFS loop runs up to ~7 times at 2 ids
#[kani::unwind(8)]
fn p5_step() {
    let m = any_held_map();
    let hist = any_history(&m);
    let mut s = State::from_parts(m.clone(), Vec::new(), hist);
    let cs = any_changeset();
    let out = s.apply(&Record::Changeset(cs.clone()));
    assert!(naive_acyclic(s.veritoids()));
    if let Outcome::Refused(Refusal::Cycle { .. }) = out {
        let mut hypo = m.clone();
        hypo.retain(|_, h| h.segment != cs.segment);
        for (k, w) in &cs.veritoids {
            hypo.insert(k.clone(), Held { segment: cs.segment.clone(), written: w.clone() });
        }
        assert!(!naive_acyclic(&hypo));
    }
}

/// P3, step: for ANY acyclic pre-state, ANY act (recorded or not; binding
/// does not depend on other acts), ANY changeset: lapse is exact.
#[kani::proof]
// unwind 8: find_cycle's DFS loop runs up to ~7 times at 2 ids
#[kani::unwind(8)]
fn p3_step() {
    let m = any_held_map();
    let hist = any_history(&m);
    let before = State::from_parts(m, Vec::new(), hist);
    let a = any_act();
    let cs = any_changeset();
    let mut after = before.clone();
    if after.apply(&Record::Changeset(cs.clone())) != Outcome::Applied {
        assert!(after.veritoids() == before.veritoids());
        return;
    }
    let read_gone = a.reads.iter().any(|(k, v)| before.current_version(k) == Some(*v) && after.current_version(k) != Some(*v));
    if before.binds(&a) {
        assert!(after.binds(&a) != read_gone);
    }
    let in_segment = |k: &VeritoidId| {
        before.veritoids().get(k).is_some_and(|h| h.segment == cs.segment)
            || after.veritoids().get(k).is_some_and(|h| h.segment == cs.segment)
    };
    if a.reads.keys().all(|k| !in_segment(k)) {
        assert!(before.binds(&a) == after.binds(&a));
    }
}

/// P6 and P7 over ANY acyclic state, with up to 3 recorded acts (see `any_acts`).
#[kani::proof]
#[kani::unwind(5)]
fn p6_p7_any_state() {
    let m = any_held_map();
    let hist = any_history(&m);
    let s = State::from_parts(m, any_acts(), hist);
    let pos = s.positions();
    let ceil = s.ceilings();
    for (v, h) in s.veritoids() {
        assert!(ceil[v] <= pos[v]);
        for t in h.written.references.keys() {
            match ceil.get(t) {
                Some(tc) => {
                    assert!(ceil[v] <= *tc)
                }
                None => {
                    assert!(ceil[v] == Rung::Sketch)
                }
            }
        }
    }
    if s.steady() {
        for (v, h) in s.veritoids() {
            assert!(h.written.claimed <= ceil[v]);
        }
    }
}

/// P4 (strong form), step: from ANY acyclic state with up to 3 recorded
/// acts (see `any_acts`), appending ANY act lowers no position, moves only what it concerns,
/// and adds nothing to the frontier.
#[kani::proof]
#[kani::unwind(5)]
fn p4_step() {
    let m = any_held_map();
    let hist = any_history(&m);
    let before = State::from_parts(m, any_acts(), hist);
    let a = any_act();
    let mut after = before.clone();
    after.apply(&Record::Act(a.clone()));
    let (p0, p1) = (before.positions(), after.positions());
    for (v, r0) in &p0 {
        assert!(p1[v] >= *r0);
        if p1[v] != *r0 {
            assert!(a.concerns.contains(v));
        }
    }
    assert!(after.frontier().is_subset(&before.frontier()));
}
