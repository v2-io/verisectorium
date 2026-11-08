//! KERNEL-SPEC.md §6, step by step, plus unit tests of the refusals and of
//! the edges the spec leaves open.

use std::collections::BTreeSet;
use std::io::Cursor;

use kernel::Rung::*;
use kernel::*;

fn at(log: &Log, steps: &[example::Step], name: &str) -> State {
    let s = steps.iter().find(|s| s.name == name).unwrap_or_else(|| panic!("no step {name}"));
    log.state_at(s.index)
}

fn id(s: &str) -> VeritoidId {
    s.into()
}

#[test]
fn s0_is_steady_with_the_expected_positions() {
    let (log, steps) = example::build();
    let s = at(&log, &steps, "S0");
    for v in ["c", "d", "u"] {
        assert_eq!(s.position(&id(v)), Rederived, "{v}");
        assert_eq!(s.ceiling(&id(v)), Rederived, "{v}");
    }
    assert_eq!(s.position(&id("e")), Drafted);
    assert_eq!(s.ceiling(&id("e")), Drafted);
    assert!(s.steady());
}

#[test]
fn after_the_t_changeset_b_lapses_and_the_frontier_opens() {
    let (log, steps) = example::build();
    let s = at(&log, &steps, "after-T-changeset");

    // B's first check (c@1, d@1) no longer binds.
    let b_first = &s.acts()[0];
    assert_eq!(b_first.actor, "B".into());
    assert!(!s.binds(b_first));

    assert_eq!(s.position(&id("c")), Sketch);
    assert_eq!(s.ceiling(&id("d")), Sketch);
    assert_eq!(s.ceiling(&id("e")), Sketch);

    let f = s.frontier();
    // Everything §6 lists is owed...
    let listed = example::spec_listed_frontier_after_t_changeset();
    assert!(listed.is_subset(&f), "missing from frontier: {:?}", listed.difference(&f).collect::<Vec<_>>());
    // ...and so are three more items that §3's definitions force and §6 omits.
    assert_eq!(f, example::derived_frontier_after_t_changeset());
    let extra: BTreeSet<_> = f.difference(&listed).cloned().collect();
    assert_eq!(
        extra,
        [
            Owed::Overclaim { v: id("e") },
            Owed::UnmetNeed { v: id("d"), target: id("c") },
            Owed::UnmetNeed { v: id("e"), target: id("c") },
        ]
        .into_iter()
        .collect()
    );
}

#[test]
fn the_affirmation_does_not_count_toward_a_rung() {
    let (log, steps) = example::build();
    let s = at(&log, &steps, "after-T-changeset");
    // A's affirmation on e@1 binds but position(e) comes from A's *check*.
    let aff = s.acts().iter().find(|a| a.kind == ActKind::Affirmation).unwrap();
    assert!(s.binds(aff));
    // Remove the check on e and the affirmation alone yields sketch.
    let mut without = Log::new();
    for (i, r) in log.records()[..steps[1].index].iter().enumerate() {
        if i == 3 {
            continue; // skip A's check on e@1
        }
        without.append(r.clone()).unwrap();
    }
    assert_eq!(without.head().position(&id("e")), Sketch);
}

#[test]
fn the_repair_sequence_closes_the_frontier() {
    let (log, steps) = example::build();
    let f = |name: &str| at(&log, &steps, name).frontier();
    let s = |v: &str, t: &str| Owed::StaleReference { v: id(v), target: id(t) };

    assert_eq!(f("after-B-rederives-c2-d2"), [s("d", "c"), s("e", "c"), s("u", "c")].into_iter().collect());
    assert_eq!(f("after-B-rederives-c2-d3"), [s("u", "c")].into_iter().collect());
    assert_eq!(f("after-u2"), [Owed::Overclaim { v: id("u") }].into_iter().collect());

    let s1 = at(&log, &steps, "S1");
    assert!(s1.steady());
    // The log still holds B's first re-derivation of d@2, binding to nothing.
    let d2 = s1
        .acts()
        .iter()
        .find(|a| a.reads.contains(&Read::new("d", "2")))
        .expect("B's re-derivation of c@2, d@2 is still in the log");
    assert!(!s1.binds(d2));
    assert_eq!(log.len(), 12);
}

#[test]
fn p8_replay_of_the_example_gives_the_same_log() {
    let (log, _) = example::build();
    let mut buf = Vec::new();
    log.write_to(&mut buf).unwrap();
    let back = Log::read_from(Cursor::new(buf)).unwrap();
    assert_eq!(back, log);
    assert_eq!(back.head().frontier(), log.head().frontier());
}

// -- refusals ----------------------------------------------------------------

#[test]
fn a_self_reference_is_a_cycle() {
    let mut log = Log::new();
    let r = log.append(changeset("T", [veritoid("a", "T", "1", Sketch, [("a", Sketch, "1")])]));
    assert_eq!(r, Err(Refusal::Cycle { path: vec![id("a"), id("a")] }));
    assert!(log.is_empty());
}

#[test]
fn a_cross_segment_cycle_is_refused_and_leaves_the_log_untouched() {
    let mut log = Log::new();
    log.append(changeset("T", [veritoid("a", "T", "1", Sketch, [("b", Sketch, "1")])])).unwrap();
    let before = log.clone();
    let r = log.append(changeset("U", [veritoid("b", "U", "1", Sketch, [("a", Sketch, "1")])]));
    assert!(matches!(r, Err(Refusal::Cycle { .. })), "{r:?}");
    assert_eq!(log, before);
    // The dangling reference a -> b is allowed, and owed.
    assert_eq!(
        log.head().frontier(),
        [Owed::StaleReference { v: id("a"), target: id("b") }].into_iter().collect()
    );
}

#[test]
fn an_id_held_by_another_segment_is_refused() {
    let mut log = Log::new();
    log.append(changeset("T", [veritoid("a", "T", "1", Sketch, [])])).unwrap();
    let r = log.append(changeset("U", [veritoid("a", "U", "1", Sketch, [])]));
    assert_eq!(r, Err(Refusal::HeldElsewhere { id: id("a"), by: "T".into() }));
}

#[test]
fn malformed_changesets_are_refused() {
    let mut log = Log::new();
    let r = log.append(changeset("T", [veritoid("a", "U", "1", Sketch, [])]));
    assert_eq!(r, Err(Refusal::WrongSegment { id: id("a"), named: "U".into(), changeset: "T".into() }));
    let r = log.append(changeset("T", [veritoid("a", "T", "1", Sketch, []), veritoid("a", "T", "2", Sketch, [])]));
    assert_eq!(r, Err(Refusal::DuplicateId { id: id("a") }));
    assert!(log.is_empty());
}

#[test]
fn a_file_that_would_be_refused_is_refused_on_load() {
    let bad = r#"{"record":"changeset","segment":"T","veritoids":[{"id":"a","segment":"T","version":"1","claimed":"sketch","references":[{"target":"a","needed":"sketch","seen":"1"}]}]}"#;
    let r = Log::read_from(Cursor::new(bad));
    assert!(matches!(r, Err(LoadError::Refused { line: 1, refusal: Refusal::Cycle { .. } })));
}

// -- edges the spec leaves open -----------------------------------------------

#[test]
fn a_removed_target_counts_as_sketch_and_is_owed_twice() {
    let mut log = Log::new();
    log.append(changeset("T", [veritoid("a", "T", "1", Rederived, [])])).unwrap();
    log.append(changeset("U", [veritoid("b", "U", "1", Drafted, [("a", Drafted, "1")])])).unwrap();
    log.append(check("B", "x", Rederived, [("a", "1")])).unwrap();
    log.append(check("B", "x", Drafted, [("b", "1")])).unwrap();
    assert!(log.head().steady());
    // T is rewritten without a.
    log.append(changeset("T", [])).unwrap();
    let s = log.head();
    assert_eq!(s.ceiling(&id("b")), Sketch);
    assert_eq!(
        s.frontier(),
        [
            Owed::Overclaim { v: id("b") },
            Owed::StaleReference { v: id("b"), target: id("a") },
            Owed::UnmetNeed { v: id("b"), target: id("a") },
        ]
        .into_iter()
        .collect()
    );
}

#[test]
fn a_reverted_version_makes_an_old_act_bind_again() {
    // Not asked for by the spec; recorded because it is a consequence of
    // defining binding on (id, version) alone. Under hash versions this is
    // right (the content is identical to what was checked); under counters a
    // store would have to forbid reuse. See account.md.
    let mut log = Log::new();
    log.append(changeset("T", [veritoid("a", "T", "1", Checked, [])])).unwrap();
    log.append(check("B", "x", Checked, [("a", "1")])).unwrap();
    log.append(changeset("T", [veritoid("a", "T", "2", Checked, [])])).unwrap();
    assert_eq!(log.head().position(&id("a")), Sketch);
    log.append(changeset("T", [veritoid("a", "T", "1", Checked, [])])).unwrap();
    assert_eq!(log.head().position(&id("a")), Checked);
}

#[test]
fn an_act_recorded_against_a_stale_version_simply_does_not_bind() {
    let mut log = Log::new();
    log.append(changeset("T", [veritoid("a", "T", "2", Sketch, [])])).unwrap();
    log.append(check("B", "x", Rederived, [("a", "1")])).unwrap();
    assert!(!log.head().binds(&log.head().acts()[0]));
    assert_eq!(log.head().position(&id("a")), Sketch);
    // Reading nothing binds vacuously and moves nothing.
    log.append(check("B", "x", Rederived, [])).unwrap();
    assert!(log.head().binds(&log.head().acts()[1]));
    assert_eq!(log.head().position(&id("a")), Sketch);
}

#[test]
fn state_at_clamps_and_matches_the_head() {
    let (log, _) = example::build();
    assert_eq!(&log.state_at(usize::MAX), log.head());
    assert_eq!(log.state_at(0), State::empty());
}
