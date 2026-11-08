//! Kani proof harnesses: bounded model checking of the kernel's own code
//! (`state.rs`, `log.rs`), not of a re-model of it. Each harness proves its
//! assertion for *every* input within its stated bounds; CBMC also checks
//! every panic, overflow and out-of-bounds index on the way. Under kani, ids
//! are `u8` (see `model::Name`). Run: `cargo kani --harness <name>`.
//!
//! The bounds (the honest scope of "proved" here): ids drawn from 3 values,
//! segments from 2, versions from {1, 2}; a changeset holds at most 2
//! veritoids with at most 2 references each; an act reads at most 2 ids and
//! concerns any subset of them; logs of the lengths each harness states.

use std::collections::{BTreeMap, BTreeSet};

use crate::model::*;
use crate::state::*;

const IDS: u8 = 3;

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
    let mut references = BTreeMap::new();
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
    let mut veritoids = BTreeMap::new();
    let k: u8 = kani::any();
    kani::assume(k <= 2);
    for _ in 0..k {
        veritoids.insert(any_id(), any_written());
    }
    SegmentChangeset { segment: SegmentId(s), author: String::new(), veritoids }
}

fn any_act() -> Act {
    let mut reads = BTreeMap::new();
    let k: u8 = kani::any();
    kani::assume(k <= 2);
    for _ in 0..k {
        reads.insert(any_id(), any_version());
    }
    let mut concerns = BTreeSet::new();
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
