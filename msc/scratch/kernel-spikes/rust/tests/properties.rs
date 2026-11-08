//! P1–P8 as property tests over generated logs, plus a differential oracle:
//! the five computed things re-implemented naively, straight from the spec's
//! §3 text, and compared with the kernel on every prefix of every log.
//!
//! The generator draws abstract operations and resolves them against the
//! evolving state ("read the current version of x", "carry y unchanged"), so
//! generated logs bind, lapse, revive, carry, affirm and refuse often, instead
//! of being mostly noise that never binds.

use std::collections::{BTreeMap, BTreeSet};

use kernel::state::find_cycle;
use kernel::*;
use proptest::prelude::*;

const IDS: u8 = 5;
const SEGS: u8 = 3;

fn id(i: u8) -> VeritoidId {
    VeritoidId(format!("v{i}"))
}
fn seg(i: u8) -> SegmentId {
    SegmentId(format!("S{i}"))
}

#[derive(Debug, Clone)]
enum VerChoice {
    Current,
    Bump,
    Fixed(u64),
}

#[derive(Debug, Clone)]
enum Member {
    /// Carry this id exactly as currently written (if this segment holds it).
    Carry(u8),
    Write { id: u8, ver: VerChoice, claimed: Rung, refs: Vec<(u8, Rung, VerChoice)> },
}

#[derive(Debug, Clone)]
enum Op {
    Changeset { seg: u8, members: Vec<Member> },
    Act { affirm: bool, rung: Rung, reads: Vec<(u8, VerChoice)>, concerns_mask: u8 },
}

fn rung() -> impl Strategy<Value = Rung> {
    prop_oneof![Just(Rung::Sketch), Just(Rung::Drafted), Just(Rung::Checked), Just(Rung::Rederived)]
}
fn ver() -> impl Strategy<Value = VerChoice> {
    prop_oneof![4 => Just(VerChoice::Current), 2 => Just(VerChoice::Bump), 1 => (1u64..4).prop_map(VerChoice::Fixed)]
}
fn member() -> impl Strategy<Value = Member> {
    prop_oneof![
        2 => (0..IDS).prop_map(Member::Carry),
        3 => (0..IDS, ver(), rung(), prop::collection::vec((0..IDS, rung(), ver()), 0..3))
            .prop_map(|(id, ver, claimed, refs)| Member::Write { id, ver, claimed, refs }),
    ]
}
fn op() -> impl Strategy<Value = Op> {
    prop_oneof![
        2 => (0..SEGS, prop::collection::vec(member(), 0..4)).prop_map(|(seg, members)| Op::Changeset { seg, members }),
        3 => (any::<bool>(), rung(), prop::collection::vec((0..IDS, ver()), 1..4), any::<u8>())
            .prop_map(|(affirm, rung, reads, concerns_mask)| Op::Act { affirm, rung, reads, concerns_mask }),
    ]
}
fn ops() -> impl Strategy<Value = Vec<Op>> {
    prop::collection::vec(op(), 0..24)
}

fn resolve_ver(s: &State, i: u8, c: &VerChoice) -> Version {
    let cur = s.current_version(&id(i));
    match c {
        VerChoice::Current => cur.unwrap_or(Version(1)),
        VerChoice::Bump => Version(cur.map_or(1, |v| v.0 + 1)),
        VerChoice::Fixed(v) => Version(*v),
    }
}

/// Turn abstract ops into concrete records, resolving against the state the
/// log has reached so far.
fn build(ops: &[Op]) -> Log {
    let mut log = Log::new();
    for o in ops {
        let s = log.state().clone();
        let rec = match o {
            Op::Changeset { seg: g, members } => {
                let mut veritoids = BTreeMap::new();
                for m in members {
                    match m {
                        Member::Carry(i) => {
                            if let Some(h) = s.veritoids().get(&id(*i))
                                && h.segment == seg(*g) {
                                    veritoids.insert(id(*i), h.written.clone());
                                }
                        }
                        Member::Write { id: i, ver: vc, claimed, refs } => {
                            let references = refs
                                .iter()
                                .map(|(t, needed, seen)| (id(*t), Reference { needed: *needed, seen: resolve_ver(&s, *t, seen) }))
                                .collect();
                            veritoids.insert(id(*i), Written { version: resolve_ver(&s, *i, vc), claimed: *claimed, references });
                        }
                    }
                }
                Record::Changeset(SegmentChangeset { segment: seg(*g), author: format!("a{g}"), veritoids })
            }
            Op::Act { affirm, rung, reads, concerns_mask } => {
                let reads: BTreeMap<VeritoidId, Version> = reads.iter().map(|(i, c)| (id(*i), resolve_ver(&s, *i, c))).collect();
                // mostly concerns ⊆ reads; bit 7 lets an unread id in (refusal path)
                let mut concerns: BTreeSet<VeritoidId> =
                    reads.keys().enumerate().filter(|(k, _)| concerns_mask & (1 << k) != 0).map(|(_, v)| v.clone()).collect();
                if concerns_mask & 0x80 != 0 {
                    concerns.insert(id(concerns_mask % IDS));
                }
                let kind = if *affirm { ActKind::Affirmation } else { ActKind::Check { rung: *rung } };
                Record::Act(Act { actor: "x".into(), criterion: "k".into(), kind, reads, concerns })
            }
        };
        log.append(rec);
    }
    log
}

// ------------------------------------------------------------------ the oracle
// Written from the spec's §3 text (plus the two documented departures:
// `concerns`, and an affirmation's reconciling effect), deliberately by a
// different route: positions by scanning acts per veritoid, ceilings by
// fixpoint iteration instead of memoized recursion.

fn o_binds(s: &State, a: &Act) -> bool {
    a.reads.iter().all(|(i, v)| s.veritoids().get(i).map(|h| h.written.version) == Some(*v))
}
fn o_position(s: &State, v: &VeritoidId) -> Rung {
    let mut best = Rung::Sketch;
    for (_, a) in s.acts() {
        if let ActKind::Check { rung } = a.kind
            && a.concerns.contains(v) && o_binds(s, a) && rung > best {
                best = rung;
            }
    }
    best
}
fn o_ceilings(s: &State) -> BTreeMap<VeritoidId, Rung> {
    let mut c: BTreeMap<VeritoidId, Rung> = s.veritoids().keys().map(|v| (v.clone(), o_position(s, v))).collect();
    loop {
        let mut changed = false;
        for (v, h) in s.veritoids() {
            for t in h.written.references.keys() {
                let tc = c.get(t).copied().unwrap_or(Rung::Sketch);
                if tc < c[v] {
                    c.insert(v.clone(), tc);
                    changed = true;
                }
            }
        }
        if !changed {
            return c;
        }
    }
}
fn o_frontier(s: &State) -> BTreeSet<Owed> {
    let c = o_ceilings(s);
    let mut f = BTreeSet::new();
    for (v, h) in s.veritoids() {
        if h.written.claimed > c[v] {
            f.insert(Owed::Overclaim { v: v.clone() });
        }
        for (t, r) in &h.written.references {
            let cur = s.veritoids().get(t).map(|x| x.written.version);
            let affirmed = cur.is_some()
                && s.acts().iter().any(|(_, a)| {
                    a.kind == ActKind::Affirmation && a.concerns.contains(v) && a.reads.get(t).copied() == cur && o_binds(s, a)
                });
            if cur != Some(r.seen) && !affirmed {
                f.insert(Owed::StaleReference { v: v.clone(), target: t.clone() });
            }
            if c.get(t).copied().unwrap_or(Rung::Sketch) < r.needed {
                f.insert(Owed::UnmetNeed { v: v.clone(), target: t.clone() });
            }
        }
    }
    f
}

fn every_prefix(log: &Log) -> impl Iterator<Item = (usize, State)> + '_ {
    (0..=log.len()).map(move |i| (i, log.state_at(i)))
}

proptest! {
    #![proptest_config(ProptestConfig { cases: 1024, ..ProptestConfig::default() })]

    /// Differential: the kernel agrees with the naive oracle on every prefix.
    #[test]
    fn kernel_matches_oracle(ops in ops()) {
        let log = build(&ops);
        for (_, s) in every_prefix(&log) {
            for (v, p) in s.positions() {
                prop_assert_eq!(p, o_position(&s, &v));
            }
            prop_assert_eq!(s.ceilings(), o_ceilings(&s));
            prop_assert_eq!(s.frontier(), o_frontier(&s));
            prop_assert_eq!(s.steady(), o_frontier(&s).is_empty());
        }
    }

    /// P1 Determinism: folding the same records twice gives equal states, the
    /// incremental head equals a fresh fold, and the computed things agree.
    #[test]
    fn p1_determinism(ops in ops()) {
        let log = build(&ops);
        let a = fold(log.records());
        let b = fold(log.records());
        prop_assert_eq!(&a, &b);
        prop_assert_eq!(&a, log.state());
        prop_assert_eq!(a.positions(), b.positions());
        prop_assert_eq!(a.ceilings(), b.ceilings());
        prop_assert_eq!(a.frontier(), b.frontier());
        // and the state at every index is the fold of exactly that prefix
        let mut inc = Log::new();
        for (i, r) in log.records().iter().enumerate() {
            prop_assert_eq!(inc.state(), &log.state_at(i));
            inc.append(r.clone());
        }
    }

    /// P2 Append-only: appending never alters an earlier record or an earlier
    /// prefix's state.
    #[test]
    fn p2_append_only(ops in ops()) {
        let full = build(&ops);
        let mut log = Log::new();
        let mut snapshots: Vec<(Vec<Record>, State)> = vec![(vec![], log.state().clone())];
        for r in full.records() {
            log.append(r.clone());
            snapshots.push((log.records().to_vec(), log.state().clone()));
        }
        for (i, (recs, st)) in snapshots.iter().enumerate() {
            prop_assert_eq!(&log.records()[..i], &recs[..]);
            prop_assert_eq!(&log.state_at(i), st);
        }
    }

    /// P3 Lapse is exact, both directions, for every changeset in the log.
    #[test]
    fn p3_lapse_is_exact(ops in ops()) {
        let log = build(&ops);
        for (i, r) in log.records().iter().enumerate() {
            let Record::Changeset(cs) = r else { continue };
            let before = log.state_at(i);
            let after = log.state_at(i + 1);
            if after.refusals().len() > before.refusals().len() {
                prop_assert_eq!(before.veritoids(), after.veritoids(), "a refused changeset changes nothing");
                continue;
            }
            // (id, version) pairs the changeset changed or removed
            let gone: BTreeSet<(VeritoidId, Version)> = before.veritoids().iter()
                .filter(|(k, h)| after.current_version(k) != Some(h.written.version))
                .map(|(k, h)| (k.clone(), h.written.version))
                .collect();
            let seg_ids: BTreeSet<VeritoidId> = before.segment_members(&cs.segment)
                .union(&after.segment_members(&cs.segment)).cloned().collect();
            for (_, a) in before.acts() {
                let (b0, b1) = (before.binds(a), after.binds(a));
                if b0 {
                    let read_gone = a.reads.iter().any(|(k, v)| gone.contains(&(k.clone(), *v)));
                    prop_assert_eq!(!b1, read_gone, "stops binding iff it read a changed/removed (id, version)");
                }
                if a.reads.keys().all(|k| !seg_ids.contains(k)) {
                    prop_assert_eq!(b0, b1, "an act reading nothing in the segment is unaffected");
                }
            }
        }
    }

    /// P4 Monotone under acts, and the stronger form: an act never adds an
    /// owed item to the frontier, and moves positions only of what it concerns.
    #[test]
    fn p4_monotone_under_acts(ops in ops()) {
        let log = build(&ops);
        for (i, r) in log.records().iter().enumerate() {
            let Record::Act(a) = r else { continue };
            let before = log.state_at(i);
            let after = log.state_at(i + 1);
            let (p0, p1) = (before.positions(), after.positions());
            prop_assert_eq!(p0.keys().collect::<Vec<_>>(), p1.keys().collect::<Vec<_>>());
            for (v, r0) in &p0 {
                prop_assert!(p1[v] >= *r0, "position never lowered");
                if p1[v] != *r0 {
                    prop_assert!(a.concerns.contains(v) && a.reads.contains_key(v));
                }
            }
            let (f0, f1) = (before.frontier(), after.frontier());
            prop_assert!(f1.is_subset(&f0), "an act adds nothing owed: {:?}", f1.difference(&f0).collect::<Vec<_>>());
        }
    }

    /// P5 Acyclicity: every reachable state is acyclic; every cycle refusal
    /// names a real cycle of the graph the changeset would have produced.
    #[test]
    fn p5_acyclicity(ops in ops()) {
        let log = build(&ops);
        for (_, s) in every_prefix(&log) {
            prop_assert!(find_cycle(s.veritoids()).is_none());
        }
        for (i, r) in log.records().iter().enumerate() {
            let Record::Changeset(cs) = r else { continue };
            let after = log.state_at(i + 1);
            let Some((_, Refusal::Cycle { cycle })) = after.refusals().last().filter(|(k, _)| *k == i) else { continue };
            let before = log.state_at(i);
            let mut hypo: BTreeMap<VeritoidId, Held> = before.veritoids().clone();
            hypo.retain(|_, h| h.segment != cs.segment);
            for (k, w) in &cs.veritoids {
                hypo.insert(k.clone(), Held { segment: cs.segment.clone(), written: w.clone() });
            }
            prop_assert!(cycle.len() >= 2 && cycle.first() == cycle.last());
            for w in cycle.windows(2) {
                prop_assert!(hypo[&w[0]].written.references.contains_key(&w[1]), "edge {:?}->{:?}", w[0], w[1]);
            }
        }
    }

    /// P6 Ceiling bound, and tightness: ceiling is exactly the min.
    #[test]
    fn p6_ceiling_bound(ops in ops()) {
        let log = build(&ops);
        for (_, s) in every_prefix(&log) {
            let (pos, ceil) = (s.positions(), s.ceilings());
            for (v, h) in s.veritoids() {
                prop_assert!(ceil[v] <= pos[v]);
                let mut m = pos[v];
                for t in h.written.references.keys() {
                    let tc = ceil.get(t).copied().unwrap_or(Rung::Sketch);
                    prop_assert!(ceil[v] <= tc);
                    m = m.min(tc);
                }
                prop_assert_eq!(ceil[v], m);
            }
        }
    }

    /// P7 Steady means honest; checked through the stronger, never-vacuous
    /// statement that overclaim(v) is on the frontier iff claimed > ceiling.
    #[test]
    fn p7_steady_means_honest(ops in ops()) {
        let log = build(&ops);
        for (_, s) in every_prefix(&log) {
            let f = s.frontier();
            let ceil = s.ceilings();
            for (v, h) in s.veritoids() {
                prop_assert_eq!(f.contains(&Owed::Overclaim { v: v.clone() }), h.written.claimed > ceil[v]);
                if s.steady() {
                    prop_assert!(h.written.claimed <= ceil[v]);
                }
            }
        }
    }

    /// P7, non-vacuously: from any reachable state without dangling references,
    /// acts alone (one re-derivation of everything, one affirmation per stale
    /// reference) reach a steady state, and in it nothing overclaims.
    #[test]
    fn p7_repairable_by_acts(ops in ops()) {
        let mut log = build(&ops);
        let s = log.state().clone();
        let dangling = s.veritoids().values().any(|h| h.written.references.keys().any(|t| !s.veritoids().contains_key(t)));
        prop_assume!(!dangling);
        if s.veritoids().is_empty() { return Ok(()); }
        let all: BTreeMap<VeritoidId, Version> = s.veritoids().iter().map(|(k, h)| (k.clone(), h.written.version)).collect();
        log.append(Record::Act(Act { actor: "R".into(), criterion: "all".into(), kind: ActKind::Check { rung: Rung::Rederived }, concerns: all.keys().cloned().collect(), reads: all.clone() }));
        for (v, h) in s.veritoids() {
            let mut reads: BTreeMap<VeritoidId, Version> = h.written.references.keys().map(|t| (t.clone(), all[t])).collect();
            reads.insert(v.clone(), h.written.version);
            log.append(Record::Act(Act { actor: "R".into(), criterion: "aff".into(), kind: ActKind::Affirmation, concerns: [v.clone()].into(), reads }));
        }
        let t = log.state();
        prop_assert!(t.steady(), "{:?}", t.frontier());
        for (v, h) in t.veritoids() {
            prop_assert!(h.written.claimed <= t.ceiling(v).unwrap());
        }
    }

    /// P8 Replay: text round trip gives the same records and the same state at
    /// every index; and through a real file.
    #[test]
    fn p8_replay(ops in ops()) {
        let log = build(&ops);
        let text = codec::encode_log(log.records());
        let back = codec::decode_log(&text).unwrap();
        prop_assert_eq!(&back[..], log.records());
        let replayed = Log::from_records(back);
        prop_assert_eq!(&replayed, &log);
        for i in 0..=log.len() {
            prop_assert_eq!(replayed.state_at(i), log.state_at(i));
        }
    }
}

#[test]
fn p8_replay_through_a_file_with_awkward_strings() {
    let mut log = Log::from_records(kernel::example::records());
    log.append(Record::Act(Act {
        actor: "agent with spaces % and\nnewline".into(),
        criterion: String::new(),
        kind: ActKind::Check { rung: Rung::Checked },
        reads: [(VeritoidId("é ü".into()), Version(7))].into(),
        concerns: [VeritoidId("é ü".into())].into(),
    }));
    let path = std::env::temp_dir().join(format!("kernel-p8-{}.log", std::process::id()));
    std::fs::write(&path, codec::encode_log(log.records())).unwrap();
    let back = Log::from_records(codec::decode_log(&std::fs::read_to_string(&path).unwrap()).unwrap());
    std::fs::remove_file(&path).ok();
    assert_eq!(back, log);
}

/// Revival: binding is a function of the current versions only, so a revert
/// to an earlier version brings back the acts that read it. (A consequence of
/// the spec's definition; P3 speaks only of lapse. See account.md.)
#[test]
fn revert_revives() {
    let mut log = Log::new();
    log.append(Record::Changeset(SegmentChangeset::new("T", "A").with("c", Written::new(1, Rung::Checked))));
    log.append(Record::Act(Act::check("B", "k", Rung::Checked, &[("c", 1)])));
    assert!(log.state().steady());
    log.append(Record::Changeset(SegmentChangeset::new("T", "A").with("c", Written::new(2, Rung::Checked))));
    assert!(!log.state().steady());
    log.append(Record::Changeset(SegmentChangeset::new("T", "A").with("c", Written::new(1, Rung::Checked))));
    assert!(log.state().steady(), "B's check on c@1 binds again");
}
