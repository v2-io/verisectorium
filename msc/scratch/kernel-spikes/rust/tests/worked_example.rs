//! The spec's §6 worked example, as a required test, plus the tests that pin
//! down where the spec's own expected lists disagree with its contracts.

use std::collections::BTreeSet;

use kernel::*;
use Rung::*;

fn ov(v: &str) -> Owed {
    Owed::Overclaim { v: vid(v) }
}
fn stale(v: &str, t: &str) -> Owed {
    Owed::StaleReference { v: vid(v), target: vid(t) }
}
fn unmet(v: &str, t: &str) -> Owed {
    Owed::UnmetNeed { v: vid(v), target: vid(t) }
}
fn set(items: &[Owed]) -> BTreeSet<Owed> {
    items.iter().cloned().collect()
}

/// Log length at the end of each stage of `example::stages()`.
fn stage_ends() -> Vec<usize> {
    let mut n = 0;
    example::stages().iter().map(|s| { n += s.records.len(); n }).collect()
}

fn example_log() -> Log {
    Log::from_records(example::records())
}

#[test]
fn every_record_of_the_example_takes_effect() {
    assert!(example_log().state().refusals().is_empty());
}

#[test]
fn s0_is_steady() {
    let log = example_log();
    let s0 = log.state_at(stage_ends()[0]);
    assert!(s0.steady(), "{:?}", s0.frontier());
    assert_eq!(s0.position(&vid("c")), Some(Rederived));
    assert_eq!(s0.position(&vid("e")), Some(Drafted));
}

/// The spec's stated expectations after the perturbation that are consistent
/// with its contracts, all of which hold here.
#[test]
fn after_perturbation_the_stated_values_hold() {
    let log = example_log();
    let ends = stage_ends();
    for at in [ends[1], ends[2]] {
        // just after the changeset, and after A's affirmation
        let s = log.state_at(at);
        let b_first = &log.state().acts()[0].1; // B's check reading c@1, d@1
        assert_eq!(b_first.reads.keys().map(|k| k.0.as_str()).collect::<Vec<_>>(), vec!["c", "d"]);
        assert!(!s.binds(b_first), "B's check no longer binds");
        assert_eq!(s.position(&vid("c")), Some(Sketch));
        assert_eq!(s.ceiling(&vid("d")), Some(Sketch));
        assert_eq!(s.ceiling(&vid("e")), Some(Sketch));
    }
}

/// What the contracts compute, exactly, after the perturbation. This is the
/// corrected expected list (account.md §"The worked example").
#[test]
fn after_perturbation_the_frontier_is_what_the_contracts_compute() {
    let log = example_log();
    let ends = stage_ends();
    // Just after the changeset, before A's affirmation is recorded:
    assert_eq!(
        log.state_at(ends[1]).frontier(),
        set(&[
            ov("c"), ov("d"), ov("e"), ov("u"),
            stale("e", "c"), stale("u", "c"),
            unmet("d", "c"), unmet("e", "c"), unmet("u", "c"),
        ])
    );
    // After the affirmation: e's reference to c is reconciled.
    assert_eq!(
        log.state_at(ends[2]).frontier(),
        set(&[
            ov("c"), ov("d"), ov("e"), ov("u"),
            stale("u", "c"),
            unmet("d", "c"), unmet("e", "c"), unmet("u", "c"),
        ])
    );
}

/// The spec's §6 expected frontier, compared with the contracts' frontier at
/// both readings of "after it". The disagreement is a property of the spec,
/// not of this implementation: `overclaim(e)`, `unmet-need(d, c)` and
/// `unmet-need(e, c)` follow from §3 and the values §6 itself states
/// (ceiling(e) = sketch < drafted = claimed(e); ceiling(c) = sketch < drafted =
/// what d and e need), and `stale-reference(d, c)` cannot hold once d has been
/// rewritten against c@2.
#[test]
fn the_spec_expected_list_is_inconsistent_with_its_own_contracts() {
    let spec_list = set(&[
        ov("c"), ov("d"),
        stale("d", "c"), stale("e", "c"), stale("u", "c"),
        ov("u"), unmet("u", "c"),
    ]);
    let log = example_log();
    let computed = log.state_at(stage_ends()[1]).frontier();
    let missing_from_spec: BTreeSet<_> = computed.difference(&spec_list).cloned().collect();
    let not_computed: BTreeSet<_> = spec_list.difference(&computed).cloned().collect();
    assert_eq!(missing_from_spec, set(&[ov("e"), unmet("d", "c"), unmet("e", "c")]));
    assert_eq!(not_computed, set(&[stale("d", "c")]));

    // ceiling(e) = sketch is stated by the spec itself, and claimed(e) = drafted:
    let s = log.state_at(stage_ends()[1]);
    assert_eq!(s.ceiling(&vid("e")), Some(Sketch));
    assert_eq!(s.veritoids()[&vid("e")].written.claimed, Drafted);
}

#[test]
fn s1_is_steady_and_the_log_keeps_the_first_rederivation_binding_to_nothing() {
    let log = example_log();
    let s1 = log.state();
    assert!(s1.steady(), "{:?}", s1.frontier());
    // B's first re-derivation of d@2 is still in the log and binds to nothing.
    let first_rederivation = log
        .records()
        .iter()
        .find_map(|r| match r {
            Record::Act(a) if a.reads.get(&vid("d")) == Some(&Version(2)) => Some(a),
            _ => None,
        })
        .expect("recorded");
    assert!(!s1.binds(first_rederivation));
    assert!(s1.acts().iter().any(|(_, a)| a == first_rederivation));
    // A's drafted check on e@1 still binds: nothing it read changed.
    assert_eq!(s1.position(&vid("e")), Some(Drafted));
}

/// The literal reading of the spec, in which an affirmation has no computed
/// effect at all: drop A's affirmation and the narrative cannot reach S1,
/// because nothing else in it ever reconciles e (written against c@1) with
/// c@2. This is why the affirmation is given its one effect here.
#[test]
fn without_the_affirmation_s1_is_unreachable() {
    let records: Vec<Record> = example::records()
        .into_iter()
        .filter(|r| !matches!(r, Record::Act(a) if a.kind == ActKind::Affirmation))
        .collect();
    let log = Log::from_records(records);
    assert_eq!(log.state().frontier(), set(&[stale("e", "c")]));
}

/// The reads/concerns finding. If B's check of u honestly records that it read
/// c (u rests on c, so a re-derivation of u reads c), then under the spec's
/// position rule ("checks whose reads include v") that check raises c's
/// position, though it checked u. With `concerns` separated from `reads`, the
/// honest record is possible and does the right thing: it raises only u, and
/// it lapses when c changes, so u loses its position at the perturbation
/// rather than keeping `rederived` on a re-derivation done against a premise
/// that has since changed.
#[test]
fn reading_as_context_does_not_attest() {
    let honest_u_check = Act {
        actor: "B".into(),
        criterion: "rederive".into(),
        kind: ActKind::Check { rung: Rederived },
        reads: [(vid("u"), Version(1)), (vid("c"), Version(1))].into_iter().collect(),
        concerns: [vid("u")].into_iter().collect(),
    };
    let base: Vec<Record> = vec![
        Record::Changeset(SegmentChangeset::new("T", "A").with("c", Written::new(1, Rederived))),
        Record::Changeset(SegmentChangeset::new("U", "C").with("u", Written::new(1, Rederived).refs("c", Rederived, 1))),
    ];
    let mut log = Log::from_records(base.clone());
    log.append(Record::Act(honest_u_check.clone()));
    assert_eq!(log.state().position(&vid("c")), Some(Sketch), "checking u does not raise c");
    assert_eq!(log.state().position(&vid("u")), Some(Rederived));

    // The spec's rule (concerns = reads) on the same honest reads raises c too:
    let mut spec_rule = honest_u_check.clone();
    spec_rule.concerns = spec_rule.reads.keys().cloned().collect();
    let mut log2 = Log::from_records(base);
    log2.append(Record::Act(spec_rule));
    assert_eq!(log2.state().position(&vid("c")), Some(Rederived), "under the spec's rule, it does");

    // And the honest check lapses when c changes:
    log.append(Record::Changeset(SegmentChangeset::new("T", "A").with("c", Written::new(2, Rederived))));
    assert_eq!(log.state().position(&vid("u")), Some(Sketch));
}

#[test]
fn the_example_log_round_trips_through_text() {
    let log = example_log();
    let text = codec::encode_log(log.records());
    let back = Log::from_records(codec::decode_log(&text).unwrap());
    assert_eq!(back, log);
}

#[test]
fn a_cycle_is_refused_and_the_attempt_is_recorded() {
    let mut log = example_log();
    let before = log.state().clone();
    // c (in T) comes to rest on u (in U), which rests on c.
    let out = log.append(Record::Changeset(
        SegmentChangeset::new("T", "A")
            .with("c", Written::new(3, Rederived).refs("u", Drafted, 2))
            .with("d", Written::new(3, Rederived).refs("c", Drafted, 2))
            .with("e", Written::new(1, Drafted).refs("c", Drafted, 1)),
    ));
    match out {
        Outcome::Refused(Refusal::Cycle { cycle }) => {
            assert_eq!(cycle.first(), cycle.last());
            assert!(cycle.contains(&vid("c")) && cycle.contains(&vid("u")));
        }
        other => panic!("expected a cycle refusal, got {other:?}"),
    }
    assert_eq!(log.len(), example::records().len() + 1, "the attempt is in the log");
    assert_eq!(log.state().veritoids(), before.veritoids(), "and changed nothing");
    assert_eq!(log.state().frontier(), before.frontier());
    // Replay recomputes the refusal; it is not stored as a verdict.
    let replayed = Log::from_records(codec::decode_log(&codec::encode_log(log.records())).unwrap());
    assert_eq!(replayed.state().refusals(), log.state().refusals());
}

#[test]
fn other_refusals() {
    let mut log = example_log();
    // T may not write u, which U holds.
    assert!(matches!(
        log.append(Record::Changeset(SegmentChangeset::new("T", "A").with("u", Written::new(9, Sketch)))),
        Outcome::Refused(Refusal::ForeignVeritoid { .. })
    ));
    // Keeping e@1 while changing what it references is a new version, not e@1.
    assert!(matches!(
        log.append(Record::Changeset(
            SegmentChangeset::new("T", "A")
                .with("c", Written::new(2, Rederived))
                .with("d", Written::new(3, Rederived).refs("c", Drafted, 2))
                .with("e", Written::new(1, Drafted).refs("c", Drafted, 2))
        )),
        Outcome::Refused(Refusal::ReferencesChangedWithoutNewVersion { .. })
    ));
    // Softening (lowering a claimed level) at the same version is allowed.
    assert_eq!(
        log.append(Record::Changeset(
            SegmentChangeset::new("T", "A")
                .with("c", Written::new(2, Rederived))
                .with("d", Written::new(3, Rederived).refs("c", Drafted, 2))
                .with("e", Written::new(1, Sketch).refs("c", Drafted, 1))
        )),
        Outcome::Applied
    );
    let mut a = Act::check("B", "x", Checked, &[("c", 2)]);
    a.concerns.insert(vid("d"));
    assert!(matches!(log.append(Record::Act(a)), Outcome::Refused(Refusal::ActConcernsUnread { .. })));
    let mut a = Act::check("B", "x", Checked, &[("c", 2)]);
    a.concerns.clear();
    assert!(matches!(log.append(Record::Act(a)), Outcome::Refused(Refusal::ActConcernsNothing)));
}
