//! The spec's worked example (§6), as a log, with named stages.
//!
//! Reading choices made explicit here (see account.md §"The worked example"):
//! - "A submits a segment changeset on T: c@2, d@2, e@1 affirmed" is recorded
//!   as the changeset (A rewrote d against c@2, so d@2's reference says
//!   `seen = 2`; e is carried unchanged, `seen = 1`) followed by A's
//!   affirmation act reading e@1 and c@2.
//! - "A fixes step 3 (d@3)" is a changeset on T carrying c@2 and e@1 unchanged.
//! - "B re-derives again" reads c@2 and d@3 (it must re-read c: B's previous
//!   re-derivation read d@2 too, so it lapsed for c as well as for d).
//! - Every act in the example attests everything it read (`concerns = reads`),
//!   which is the spec's own position rule.

use crate::model::*;
use Rung::*;

pub struct Stage {
    pub name: &'static str,
    pub records: Vec<Record>,
}

fn cs(c: SegmentChangeset) -> Record {
    Record::Changeset(c)
}
fn act(a: Act) -> Record {
    Record::Act(a)
}

pub fn stages() -> Vec<Stage> {
    vec![
        Stage {
            name: "S0: T and U written, three checks recorded",
            records: vec![
                cs(SegmentChangeset::new("T", "A")
                    .with("c", Written::new(1, Rederived))
                    .with("d", Written::new(1, Rederived).refs("c", Drafted, 1))
                    .with("e", Written::new(1, Drafted).refs("c", Drafted, 1))),
                cs(SegmentChangeset::new("U", "C").with("u", Written::new(1, Rederived).refs("c", Rederived, 1))),
                act(Act::check("B", "rederive", Rederived, &[("c", 1), ("d", 1)])),
                act(Act::check("A", "draft-review", Drafted, &[("e", 1)])),
                act(Act::check("B", "rederive", Rederived, &[("u", 1)])),
            ],
        },
        Stage {
            name: "perturbation: A rewrites c and d (c@2, d@2), carries e@1",
            records: vec![cs(SegmentChangeset::new("T", "A")
                .with("c", Written::new(2, Rederived))
                .with("d", Written::new(2, Rederived).refs("c", Drafted, 2))
                .with("e", Written::new(1, Drafted).refs("c", Drafted, 1)))],
        },
        Stage {
            name: "A affirms e@1 against c@2",
            records: vec![act(Act::affirmation("A", "affirm", ("e", 1), &[("c", 2)]))],
        },
        Stage {
            name: "B re-derives c@2, d@2",
            records: vec![act(Act::check("B", "rederive", Rederived, &[("c", 2), ("d", 2)]))],
        },
        Stage {
            name: "A fixes step 3 (d@3)",
            records: vec![cs(SegmentChangeset::new("T", "A")
                .with("c", Written::new(2, Rederived))
                .with("d", Written::new(3, Rederived).refs("c", Drafted, 2))
                .with("e", Written::new(1, Drafted).refs("c", Drafted, 1)))],
        },
        Stage {
            name: "B re-derives c@2, d@3",
            records: vec![act(Act::check("B", "rederive", Rederived, &[("c", 2), ("d", 3)]))],
        },
        Stage {
            name: "C changes U (u@2 against c@2)",
            records: vec![cs(SegmentChangeset::new("U", "C").with("u", Written::new(2, Rederived).refs("c", Rederived, 2)))],
        },
        Stage {
            name: "S1: B re-derives u@2",
            records: vec![act(Act::check("B", "rederive", Rederived, &[("u", 2)]))],
        },
    ]
}

/// The whole example as one log's records.
pub fn records() -> Vec<Record> {
    stages().into_iter().flat_map(|s| s.records).collect()
}
