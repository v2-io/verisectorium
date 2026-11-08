//! The worked example of KERNEL-SPEC.md §6, as a log built step by step.
//!
//! Each step is named so a test (or the CLI) can look at the state after it.
//! Where the spec's prose under-determines a record, the choice made is
//! marked `SPEC:` here and discussed in `account.md`.

use crate::*;

/// The steps of §6, in order. `index` is the log length after the step.
#[derive(Clone, Debug, PartialEq, Eq)]
pub struct Step {
    pub name: &'static str,
    pub index: usize,
}

/// Build the whole §6 log. Returns the log and the named checkpoints.
pub fn build() -> (Log, Vec<Step>) {
    let mut log = Log::new();
    let mut steps = Vec::new();
    let step = |log: &Log, name: &'static str, steps: &mut Vec<Step>| {
        steps.push(Step { name, index: log.len() });
    };
    let push = |log: &mut Log, r: Record| {
        log.append(r).expect("the worked example contains no refused record");
    };

    use Rung::*;

    // --- S0 -------------------------------------------------------------
    push(
        &mut log,
        changeset(
            "T",
            [
                veritoid("c", "T", "1", Rederived, []),
                veritoid("d", "T", "1", Rederived, [("c", Drafted, "1")]),
                veritoid("e", "T", "1", Drafted, [("c", Drafted, "1")]),
            ],
        ),
    );
    push(&mut log, changeset("U", [veritoid("u", "U", "1", Rederived, [("c", Rederived, "1")])]));
    push(&mut log, check("B", "rederive", Rederived, [("c", "1"), ("d", "1")]));
    push(&mut log, check("A", "read", Drafted, [("e", "1")]));
    push(&mut log, check("B", "rederive", Rederived, [("u", "1")]));
    step(&log, "S0", &mut steps);

    // --- The perturbation: c needs an extra hypothesis. -------------------
    // A submits a changeset on T: c@2, d@2, e@1 affirmed.
    // SPEC: d@2 is written against c as A saw it when d@1 was written (c@1);
    // the spec's expected frontier lists stale-reference(d, c), which forces
    // this. e@1 is carried unchanged with its reference as it was (seen c@1).
    push(
        &mut log,
        changeset(
            "T",
            [
                veritoid("c", "T", "2", Rederived, []),
                veritoid("d", "T", "2", Rederived, [("c", Drafted, "1")]),
                veritoid("e", "T", "1", Drafted, [("c", Drafted, "1")]),
            ],
        ),
    );
    // "e@1 affirmed": recorded as an affirmation act by the segment's author.
    push(&mut log, affirmation("A", "still-right", [("e", "1")]));
    step(&log, "after-T-changeset", &mut steps);

    // --- Repair ---------------------------------------------------------
    // B re-derives c@2, d@2 at rederived.
    push(&mut log, check("B", "rederive", Rederived, [("c", "2"), ("d", "2")]));
    step(&log, "after-B-rederives-c2-d2", &mut steps);

    // A fixes step 3 (d@3).
    // SPEC: for the frontier to empty, d's and e's references must be
    // reconciled against c@2. The spec names only d@3; this changeset
    // reconciles d (as part of d@3) and e's reference too, without changing
    // e's content version. See account.md on whether a reference change is a
    // content change.
    push(
        &mut log,
        changeset(
            "T",
            [
                veritoid("c", "T", "2", Rederived, []),
                veritoid("d", "T", "3", Rederived, [("c", Drafted, "2")]),
                veritoid("e", "T", "1", Drafted, [("c", Drafted, "2")]),
            ],
        ),
    );
    step(&log, "after-d3", &mut steps);

    // B re-derives again.
    push(&mut log, check("B", "rederive", Rederived, [("c", "2"), ("d", "3")]));
    step(&log, "after-B-rederives-c2-d3", &mut steps);

    // C changes U (u@2 referencing c@2).
    push(&mut log, changeset("U", [veritoid("u", "U", "2", Rederived, [("c", Rederived, "2")])]));
    step(&log, "after-u2", &mut steps);

    // B re-derives u@2.
    push(&mut log, check("B", "rederive", Rederived, [("u", "2")]));
    step(&log, "S1", &mut steps);

    (log, steps)
}

/// The frontier §6 says to expect after the T changeset, verbatim.
pub fn spec_listed_frontier_after_t_changeset() -> BTreeSet<Owed> {
    let o = |v: &str| Owed::Overclaim { v: v.into() };
    let s = |v: &str, t: &str| Owed::StaleReference { v: v.into(), target: t.into() };
    let n = |v: &str, t: &str| Owed::UnmetNeed { v: v.into(), target: t.into() };
    [o("c"), o("d"), s("d", "c"), s("e", "c"), s("u", "c"), o("u"), n("u", "c")].into_iter().collect()
}

/// The frontier §3's definitions actually yield after the T changeset.
/// SPEC: this is a strict superset of the list in §6; see account.md.
pub fn derived_frontier_after_t_changeset() -> BTreeSet<Owed> {
    let o = |v: &str| Owed::Overclaim { v: v.into() };
    let n = |v: &str, t: &str| Owed::UnmetNeed { v: v.into(), target: t.into() };
    let mut f = spec_listed_frontier_after_t_changeset();
    f.extend([o("e"), n("d", "c"), n("e", "c")]);
    f
}
