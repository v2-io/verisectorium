//! P1–P8 as property tests over random logs (proptest).
//!
//! The generator draws candidate records from a small alphabet and appends
//! them; refused records are kept beside the log so P5 can be checked against
//! an independent cycle test. Everything else is stated over the accepted log.

use std::collections::{BTreeMap, BTreeSet};
use std::io::Cursor;

use kernel::*;
use proptest::prelude::*;

// -- generators ---------------------------------------------------------------

const IDS: [&str; 7] = ["a", "b", "c", "d", "e", "f", "g"];
const SEGMENTS: [&str; 3] = ["S", "T", "U"];
const VERSIONS: [&str; 3] = ["1", "2", "3"];
const ACTORS: [&str; 3] = ["A", "B", "C"];

fn rung() -> impl Strategy<Value = Rung> {
    prop::sample::select(Rung::ALL.to_vec())
}

fn vid() -> impl Strategy<Value = &'static str> {
    prop::sample::select(IDS.to_vec())
}

fn version() -> impl Strategy<Value = &'static str> {
    prop::sample::select(VERSIONS.to_vec())
}

fn reference() -> impl Strategy<Value = Reference> {
    (vid(), rung(), version()).prop_map(|(t, needed, seen)| Reference { target: t.into(), needed, seen: seen.into() })
}

fn veritoid_in(segment: &'static str) -> impl Strategy<Value = Veritoid> {
    (vid(), version(), rung(), prop::collection::vec(reference(), 0..3)).prop_map(move |(id, v, claimed, refs)| {
        Veritoid { id: id.into(), segment: segment.into(), version: v.into(), claimed, references: refs }
    })
}

fn changeset_record() -> impl Strategy<Value = Record> {
    prop::sample::select(SEGMENTS.to_vec()).prop_flat_map(|seg| {
        prop::collection::vec(veritoid_in(seg), 0..4)
            .prop_map(move |vs| Record::Changeset(Changeset { segment: seg.into(), veritoids: vs }))
    })
}

fn act_record() -> impl Strategy<Value = Record> {
    (
        prop::sample::select(ACTORS.to_vec()),
        prop::sample::select(vec![ActKind::Check, ActKind::Check, ActKind::Affirmation]),
        prop::collection::btree_set((vid(), version()).prop_map(|(i, v)| Read::new(i, v)), 0..4),
        rung(),
    )
        .prop_map(|(actor, kind, reads, rung)| {
            Record::Act(Act { actor: actor.into(), criterion: "crit".into(), kind, reads, rung })
        })
}

fn record() -> impl Strategy<Value = Record> {
    prop_oneof![2 => changeset_record(), 3 => act_record()]
}

/// A log built by appending candidates, plus every (state-before, candidate,
/// refusal) that was refused.
#[derive(Debug, Clone)]
pub struct Built {
    pub log: Log,
    pub refused: Vec<(State, Record, Refusal)>,
}

pub fn built() -> impl Strategy<Value = Built> {
    prop::collection::vec(record(), 0..25).prop_map(|cands| {
        let mut log = Log::new();
        let mut refused = Vec::new();
        for c in cands {
            let before = log.head().clone();
            if let Err(r) = log.append(c.clone()) {
                refused.push((before, c, r));
            }
        }
        Built { log, refused }
    })
}

// -- an independent cycle test, written differently from the kernel's --------

/// Kahn-style: repeatedly delete veritoids with no outgoing edge to an
/// existing veritoid; a cycle exists iff something is left.
fn has_cycle_independent(vs: &BTreeMap<VeritoidId, Veritoid>) -> bool {
    let mut alive: BTreeSet<&VeritoidId> = vs.keys().collect();
    loop {
        let removable: Vec<&VeritoidId> = alive
            .iter()
            .copied()
            .filter(|id| !vs[*id].references.iter().any(|r| alive.contains(&r.target)))
            .collect();
        if removable.is_empty() {
            return !alive.is_empty();
        }
        for id in removable {
            alive.remove(id);
        }
    }
}

/// What the veritoid map would be if `cs` were applied to `s` blindly.
fn blind_apply(s: &State, cs: &Changeset) -> BTreeMap<VeritoidId, Veritoid> {
    let mut m: BTreeMap<VeritoidId, Veritoid> =
        s.veritoids().iter().filter(|(_, v)| v.segment != cs.segment).map(|(k, v)| (k.clone(), v.clone())).collect();
    for v in &cs.veritoids {
        m.insert(v.id.clone(), v.clone());
    }
    m
}

fn all_ids(s: &State) -> BTreeSet<VeritoidId> {
    let mut ids: BTreeSet<VeritoidId> = s.veritoids().keys().cloned().collect();
    for a in s.acts() {
        for r in &a.reads {
            ids.insert(r.id.clone());
        }
        // ceiling is also defined on ids that do not exist
    }
    for v in s.veritoids().values() {
        for r in &v.references {
            ids.insert(r.target.clone());
        }
    }
    ids
}

// -- the properties --------------------------------------------------------------

proptest! {
    #![proptest_config(ProptestConfig { cases: 400, .. ProptestConfig::default() })]

    /// P1. The state is a function of the log prefix; the incremental head
    /// equals the from-scratch fold; folding twice gives equal states; the
    /// computed things are functions of the state (same state, same answers).
    #[test]
    fn p1_determinism(b in built()) {
        let log = &b.log;
        prop_assert_eq!(&log.state_at(log.len()), log.head());
        for n in 0..=log.len() {
            let once = State::fold(&log.records()[..n]).unwrap();
            let twice = State::fold(&log.records()[..n]).unwrap();
            prop_assert_eq!(&once, &twice);
            prop_assert_eq!(once.frontier(), twice.frontier());
            for id in all_ids(&once) {
                prop_assert_eq!(once.position(&id), twice.position(&id));
                prop_assert_eq!(once.ceiling(&id), twice.ceiling(&id));
            }
        }
    }

    /// P2. Appending (accepted or refused) leaves every earlier record where
    /// it was. (The API offers no other mutation; this checks the one it has.)
    #[test]
    fn p2_append_only(b in built(), cand in record()) {
        let mut log = b.log.clone();
        let before: Vec<Record> = log.records().to_vec();
        let res = log.append(cand);
        prop_assert_eq!(&log.records()[..before.len()], &before[..]);
        match res {
            Ok(i) => { prop_assert_eq!(i, before.len()); prop_assert_eq!(log.len(), before.len() + 1); }
            Err(_) => { prop_assert_eq!(log.len(), before.len()); prop_assert_eq!(&log, &b.log); }
        }
    }

    /// P3. Lapse is exact. For an act that bound before an accepted
    /// changeset: it binds after iff none of its reads had its current version
    /// changed or removed. And an act none of whose read ids were in the
    /// changed segment before or after is unaffected, binding or not.
    #[test]
    fn p3_lapse_is_exact(b in built(), cs in changeset_record()) {
        let before = b.log.head().clone();
        let Ok(after) = before.with(&cs) else { return Ok(()); };
        let Record::Changeset(cs) = &cs else { unreachable!() };
        for a in before.acts() {
            let touched = a.reads.iter().any(|r| before.current(&r.id) != after.current(&r.id));
            if before.binds(a) {
                prop_assert_eq!(after.binds(a), !touched, "act {:?}", a);
            }
            let in_segment = |s: &State, id: &VeritoidId| s.veritoid(id).is_some_and(|v| v.segment == cs.segment);
            let outside = a.reads.iter().all(|r| !in_segment(&before, &r.id) && !in_segment(&after, &r.id));
            if outside {
                prop_assert_eq!(before.binds(a), after.binds(a), "act {:?}", a);
            }
        }
    }

    /// P4. Appending a check never lowers any position and raises only the
    /// positions of veritoids it reads.
    #[test]
    fn p4_monotone_under_acts(b in built(), act in act_record()) {
        let before = b.log.head().clone();
        let after = before.with(&act).unwrap();
        let Record::Act(a) = &act else { unreachable!() };
        for id in all_ids(&after) {
            let (p0, p1) = (before.position(&id), after.position(&id));
            prop_assert!(p1 >= p0, "{id}: {p0} -> {p1}");
            if p1 > p0 {
                prop_assert_eq!(a.kind, ActKind::Check);
                prop_assert!(a.reads.iter().any(|r| r.id == id), "{id} rose but was not read");
            }
            // ceiling, too, never falls under an act (not asked by the spec;
            // it follows from P4 and the definition of ceiling).
            prop_assert!(after.ceiling(&id) >= before.ceiling(&id));
        }
    }

    /// P5. Every accepted log has an acyclic reference graph (by an
    /// independent test); every refusal for a cycle was for a changeset whose
    /// blind application would have had one; and every other refusal was for
    /// a well-formedness fault, never a disguised cycle refusal.
    #[test]
    fn p5_acyclicity(b in built()) {
        for n in 0..=b.log.len() {
            prop_assert!(!has_cycle_independent(b.log.state_at(n).veritoids()));
        }
        for (before, cand, refusal) in &b.refused {
            let Record::Changeset(cs) = cand else { prop_assert!(false, "acts are never refused"); unreachable!() };
            match refusal {
                Refusal::Cycle { path } => {
                    prop_assert!(has_cycle_independent(&blind_apply(before, cs)));
                    prop_assert!(path.len() >= 2 && path.first() == path.last());
                    // and the path is a real cycle in the blind result
                    let m = blind_apply(before, cs);
                    for w in path.windows(2) {
                        prop_assert!(m[&w[0]].references.iter().any(|r| r.target == w[1]));
                    }
                }
                Refusal::WrongSegment { .. } | Refusal::DuplicateId { .. } | Refusal::HeldElsewhere { .. } => {}
            }
        }
    }

    /// P6. ceiling(v) <= position(v) and ceiling(v) <= ceiling(r.target) for
    /// every reference r of v.
    #[test]
    fn p6_ceiling_bound(b in built()) {
        let s = b.log.head();
        for (id, v) in s.veritoids() {
            prop_assert!(s.ceiling(id) <= s.position(id));
            for r in &v.references {
                prop_assert!(s.ceiling(id) <= s.ceiling(&r.target));
            }
        }
    }

    /// P7. Steady means honest: no claimed level exceeds its ceiling.
    /// (Checked in both directions, since the converse is what makes the
    /// frontier's overclaim item complete for this purpose.)
    #[test]
    fn p7_steady_means_honest(b in built()) {
        let s = b.log.head();
        if s.steady() {
            for (id, v) in s.veritoids() {
                prop_assert!(v.claimed <= s.ceiling(id), "{id} claims {} above ceiling {}", v.claimed, s.ceiling(id));
            }
        }
        let any_overclaim = s.veritoids().iter().any(|(id, v)| v.claimed > s.ceiling(id));
        prop_assert_eq!(any_overclaim, s.frontier().iter().any(|o| matches!(o, Owed::Overclaim { .. })));
    }

    /// P8. Write, read back, equal.
    #[test]
    fn p8_replay(b in built()) {
        let mut buf = Vec::new();
        b.log.write_to(&mut buf).unwrap();
        let back = Log::read_from(Cursor::new(&buf)).unwrap();
        prop_assert_eq!(&back, &b.log);
        prop_assert_eq!(back.head().frontier(), b.log.head().frontier());
        // and every record round-trips on its own
        for r in b.log.records() {
            let s = serde_json::to_string(r).unwrap();
            prop_assert_eq!(&serde_json::from_str::<Record>(&s).unwrap(), r);
        }
    }

    /// Frontier completeness for the three item kinds (the spec's §3.4 read
    /// as an iff): an item is present exactly when its defining condition
    /// holds.
    #[test]
    fn frontier_items_are_exactly_their_conditions(b in built()) {
        let s = b.log.head();
        let f = s.frontier();
        let mut expect = BTreeSet::new();
        for (id, v) in s.veritoids() {
            if v.claimed > s.ceiling(id) { expect.insert(Owed::Overclaim { v: id.clone() }); }
            for r in &v.references {
                if s.current(&r.target) != Some(&r.seen) {
                    expect.insert(Owed::StaleReference { v: id.clone(), target: r.target.clone() });
                }
                if s.ceiling(&r.target) < r.needed {
                    expect.insert(Owed::UnmetNeed { v: id.clone(), target: r.target.clone() });
                }
            }
        }
        prop_assert_eq!(f, expect);
    }
}
