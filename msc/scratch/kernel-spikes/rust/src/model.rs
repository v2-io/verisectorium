//! The written objects of the kernel: what a record can say.
//!
//! Everything here is *written* (set by an author or an actor). Nothing here is
//! computed; the computed things (binds, position, ceiling, frontier, steady)
//! live in `state.rs` and are never stored.

use std::collections::{BTreeMap, BTreeSet};
use std::fmt;

/// The one ladder of the one dimension: `sketch < drafted < checked < rederived`.
/// The derived `Ord` *is* the ladder order (declaration order).
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub enum Rung {
    Sketch,
    Drafted,
    Checked,
    Rederived,
}

impl Rung {
    pub const ALL: [Rung; 4] = [Rung::Sketch, Rung::Drafted, Rung::Checked, Rung::Rederived];

    /// The bottom of the ladder: what anything is with nothing done to it.
    pub const BOTTOM: Rung = Rung::Sketch;

    pub fn name(self) -> &'static str {
        match self {
            Rung::Sketch => "sketch",
            Rung::Drafted => "drafted",
            Rung::Checked => "checked",
            Rung::Rederived => "rederived",
        }
    }

    pub fn parse(s: &str) -> Option<Rung> {
        Rung::ALL.into_iter().find(|r| r.name() == s)
    }
}

impl fmt::Display for Rung {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(self.name())
    }
}

/// What ids are made of. A `String` everywhere except under `cargo kani`,
/// where it is a `u8` so that the bounded model checker is not spending its
/// effort inside string comparison. The fold and the computed things
/// (`state.rs`, `log.rs`) use ids only through `Eq`, `Ord` and `Clone`, so they
/// are the same source under either; see account.md, proof section.
#[cfg(not(kani))]
pub type Name = String;
#[cfg(kani)]
pub type Name = u8;

/// A veritoid's id. Unique across the whole store (not per segment).
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct VeritoidId(pub Name);

/// A segment's id.
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct SegmentId(pub Name);

/// A content version. Opaque: the kernel only ever asks whether two versions
/// are *equal*. (`Ord` is derived so versions can sit in ordered containers;
/// no computation reads that order.) The writer's contract: equal version means
/// identical content. With content hashes that holds by construction; with
/// counters it is a promise the kernel cannot check (see account.md).
#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct Version(pub u64);

impl fmt::Display for VeritoidId {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.0)
    }
}
impl fmt::Display for SegmentId {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.0)
    }
}
impl fmt::Display for Version {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        write!(f, "{}", self.0)
    }
}

/// One reference of a veritoid, keyed by its target in `Written::references`
/// (so a veritoid has at most one reference to any given target).
/// "This piece is predicated on the target, needs it at least at `needed`, and
/// was written against version `seen` of it."
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Reference {
    pub needed: Rung,
    pub seen: Version,
}

/// What a segment changeset writes for one veritoid.
///
/// `references` are part of what the content version covers: a changeset may
/// not change a veritoid's references while keeping its version (refused as
/// `Refusal::VersionReused`, checked against every earlier writing of that version). `claimed` is not covered: a
/// claimed level may be lowered (softened) or raised without a new version,
/// and the frontier compares it with what is computed either way.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Written {
    pub version: Version,
    pub claimed: Rung,
    pub references: BTreeMap<VeritoidId, Reference>,
}

/// A whole new written state of one segment, replacing the old one at one
/// logical instant. Ids absent from `veritoids` that the segment used to hold
/// are removed. An empty changeset empties the segment.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct SegmentChangeset {
    pub segment: SegmentId,
    /// Who wrote it. Not in the spec's tuple; carried because an affirmation is
    /// "by the segment's author" and the record should say who that was.
    pub author: String,
    pub veritoids: BTreeMap<VeritoidId, Written>,
}

/// What kind of act. The spec's tuple gives every act a rung; an affirmation
/// "never counts toward a rung", so here only a check has one.
#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ActKind {
    Check { rung: Rung },
    Affirmation,
}

/// One recorded act.
///
/// `reads` is everything the act read, one version per id; the act binds
/// exactly while all of them are current. `concerns` is what the act attests
/// (for a check: the veritoids whose position it raises; for an affirmation:
/// the veritoids it says are still right). `concerns ⊆ keys(reads)`, checked at
/// fold time. The spec's tuple has no `concerns`; its prose does ("the rung the
/// act attests for the veritoid(s) it concerns"), and without it, reading a
/// piece as context would raise that piece's position. See account.md §spec.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Act {
    pub actor: String,
    pub criterion: String,
    pub kind: ActKind,
    pub reads: BTreeMap<VeritoidId, Version>,
    pub concerns: BTreeSet<VeritoidId>,
}

/// One entry of the log.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Record {
    Changeset(SegmentChangeset),
    Act(Act),
}

// ---- small constructors, used by the example, the CLI and the tests ----

#[cfg(not(kani))]
pub fn vid(s: &str) -> VeritoidId {
    VeritoidId(s.to_string())
}
#[cfg(not(kani))]
pub fn sid(s: &str) -> SegmentId {
    SegmentId(s.to_string())
}

impl Written {
    pub fn new(version: u64, claimed: Rung) -> Written {
        Written { version: Version(version), claimed, references: BTreeMap::new() }
    }
    #[cfg(not(kani))]
    /// Builder: add a reference to `target`, needed at `needed`, written against `seen`.
    pub fn refs(mut self, target: &str, needed: Rung, seen: u64) -> Written {
        self.references.insert(vid(target), Reference { needed, seen: Version(seen) });
        self
    }
}

#[cfg(not(kani))]
impl SegmentChangeset {
    pub fn new(segment: &str, author: &str) -> SegmentChangeset {
        SegmentChangeset { segment: sid(segment), author: author.to_string(), veritoids: BTreeMap::new() }
    }
    pub fn with(mut self, id: &str, w: Written) -> SegmentChangeset {
        self.veritoids.insert(vid(id), w);
        self
    }
}

#[cfg(not(kani))]
impl Act {
    /// A check at `rung` reading `reads` and attesting all of them.
    pub fn check(actor: &str, criterion: &str, rung: Rung, reads: &[(&str, u64)]) -> Act {
        let reads: BTreeMap<_, _> = reads.iter().map(|(i, v)| (vid(i), Version(*v))).collect();
        let concerns = reads.keys().cloned().collect();
        Act { actor: actor.into(), criterion: criterion.into(), kind: ActKind::Check { rung }, reads, concerns }
    }
    /// An affirmation that `subject@version` is still right against the other reads.
    pub fn affirmation(actor: &str, criterion: &str, subject: (&str, u64), against: &[(&str, u64)]) -> Act {
        let mut reads: BTreeMap<_, _> = against.iter().map(|(i, v)| (vid(i), Version(*v))).collect();
        reads.insert(vid(subject.0), Version(subject.1));
        let concerns = [vid(subject.0)].into_iter().collect();
        Act { actor: actor.into(), criterion: criterion.into(), kind: ActKind::Affirmation, reads, concerns }
    }
}
