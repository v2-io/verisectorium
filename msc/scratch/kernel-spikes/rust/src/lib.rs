//! The smallest v2 kernel, in Rust, built against `../KERNEL-SPEC.md`.
//!
//! An append-only [`Log`] of records (segment changesets and acts); a
//! [`State`] computed by folding a prefix of the log; and, on a state, the
//! five computed things: [`State::binds`], [`State::position`],
//! [`State::ceiling`], [`State::frontier`], [`State::steady`].
//!
//! Everything a state answers is computed from the records, never stored
//! beside them. The one cached thing, [`Log::head`], is the fold of the whole
//! log and is checked against a from-scratch fold by the tests (P1).
//!
//! Where this crate departs from or sharpens the spec, the departure is
//! marked `SPEC:` in a comment at the place it happens and gathered in
//! `account.md`.

use std::collections::{BTreeMap, BTreeSet};
use std::fmt;

use serde::{Deserialize, Serialize};

// ---------------------------------------------------------------------------
// Identifiers and the ladder
// ---------------------------------------------------------------------------

macro_rules! string_newtype {
    ($(#[$m:meta])* $name:ident) => {
        $(#[$m])*
        #[derive(Clone, Debug, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize, Deserialize)]
        #[serde(transparent)]
        pub struct $name(pub String);

        impl From<&str> for $name {
            fn from(s: &str) -> Self {
                $name(s.to_owned())
            }
        }

        impl fmt::Display for $name {
            fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
                f.write_str(&self.0)
            }
        }
    };
}

string_newtype!(
    /// The id of one veritoid. Unique across the whole store.
    VeritoidId
);
string_newtype!(
    /// The id of a segment, the whole a veritoid belongs to.
    SegmentId
);
string_newtype!(
    /// An opaque content version: a hash or a counter. Only equality is used.
    Version
);
string_newtype!(
    /// Who performed an act.
    Actor
);
string_newtype!(
    /// What an act was performed against.
    Criterion
);

/// The one ladder: `sketch < drafted < checked < rederived`.
///
/// `Ord` is derived, and the derivation follows declaration order, so the
/// order of these variants *is* the ladder.
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum Rung {
    Sketch,
    Drafted,
    Checked,
    Rederived,
}

impl Rung {
    /// The bottom of the ladder; what a veritoid has when nothing binds to it.
    pub const BOTTOM: Rung = Rung::Sketch;
    /// Every rung, in ladder order.
    pub const ALL: [Rung; 4] = [Rung::Sketch, Rung::Drafted, Rung::Checked, Rung::Rederived];
}

impl fmt::Display for Rung {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        f.write_str(match self {
            Rung::Sketch => "sketch",
            Rung::Drafted => "drafted",
            Rung::Checked => "checked",
            Rung::Rederived => "rederived",
        })
    }
}

// ---------------------------------------------------------------------------
// The objects
// ---------------------------------------------------------------------------

/// "This piece is predicated on `target`, needs it at least at `needed`,
/// and was last reconciled against `seen` of it."
#[derive(Clone, Debug, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize, Deserialize)]
pub struct Reference {
    pub target: VeritoidId,
    pub needed: Rung,
    pub seen: Version,
}

/// One piece of content, as written by its segment's author.
#[derive(Clone, Debug, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize, Deserialize)]
pub struct Veritoid {
    pub id: VeritoidId,
    pub segment: SegmentId,
    pub version: Version,
    pub claimed: Rung,
    #[serde(default)]
    pub references: Vec<Reference>,
}

/// One `(id, version)` an act read.
#[derive(Clone, Debug, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize, Deserialize)]
pub struct Read {
    pub id: VeritoidId,
    pub version: Version,
}

impl Read {
    pub fn new(id: impl Into<VeritoidId>, version: impl Into<Version>) -> Self {
        Read { id: id.into(), version: version.into() }
    }
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize, Deserialize)]
#[serde(rename_all = "lowercase")]
pub enum ActKind {
    /// Counts toward `position` of everything it read, while it binds.
    Check,
    /// The segment author saying an unchanged veritoid is still right against
    /// changed siblings. Recorded; never counts toward a rung.
    Affirmation,
}

/// One recorded thing an actor did against a state.
#[derive(Clone, Debug, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize, Deserialize)]
pub struct Act {
    pub actor: Actor,
    pub criterion: Criterion,
    pub kind: ActKind,
    pub reads: BTreeSet<Read>,
    pub rung: Rung,
}

/// A whole new written state for one segment, replacing the old one at one
/// logical instant.
#[derive(Clone, Debug, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize, Deserialize)]
pub struct Changeset {
    pub segment: SegmentId,
    pub veritoids: Vec<Veritoid>,
}

/// One entry of the log.
#[derive(Clone, Debug, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize, Deserialize)]
#[serde(tag = "record", rename_all = "lowercase")]
pub enum Record {
    Changeset(Changeset),
    Act(Act),
}

// ---------------------------------------------------------------------------
// Refusals
// ---------------------------------------------------------------------------

/// Why a record was not appended. A refused record leaves the log untouched.
///
/// SPEC (P5): the refusal is *reported*, not recorded. See `account.md` for
/// why: every record in the log is one that was applied, so a fold never has
/// to skip, and P1/P8 stay simple statements about the record sequence.
#[derive(Clone, Debug, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize, Deserialize)]
pub enum Refusal {
    /// A veritoid in the changeset names a segment other than the changeset's.
    WrongSegment { id: VeritoidId, named: SegmentId, changeset: SegmentId },
    /// The same id appears twice in one changeset.
    DuplicateId { id: VeritoidId },
    /// The id is currently held by another segment. (The model has not yet
    /// decided what moving a veritoid between segments means, so the kernel
    /// does not let it happen by accident.)
    HeldElsewhere { id: VeritoidId, by: SegmentId },
    /// Applying the changeset would create a cycle in the reference graph.
    /// `path` is the cycle, first id repeated at the end.
    Cycle { path: Vec<VeritoidId> },
}

impl fmt::Display for Refusal {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Refusal::WrongSegment { id, named, changeset } => write!(
                f,
                "veritoid {id} names segment {named} inside a changeset for {changeset}"
            ),
            Refusal::DuplicateId { id } => write!(f, "veritoid {id} appears twice"),
            Refusal::HeldElsewhere { id, by } => {
                write!(f, "veritoid {id} is currently held by segment {by}")
            }
            Refusal::Cycle { path } => {
                let p: Vec<String> = path.iter().map(ToString::to_string).collect();
                write!(f, "reference cycle: {}", p.join(" -> "))
            }
        }
    }
}

impl std::error::Error for Refusal {}

// ---------------------------------------------------------------------------
// Owed items
// ---------------------------------------------------------------------------

/// One item of the frontier.
#[derive(Clone, Debug, PartialEq, Eq, PartialOrd, Ord, Hash, Serialize, Deserialize)]
#[serde(tag = "owed", rename_all = "kebab-case")]
pub enum Owed {
    /// `claimed(v) > ceiling(v)`.
    Overclaim { v: VeritoidId },
    /// `v` has a reference whose target has moved on from the version `v` was
    /// reconciled against, or whose target no longer exists.
    StaleReference { v: VeritoidId, target: VeritoidId },
    /// `v` has a reference whose target's ceiling is below what `v` needs.
    UnmetNeed { v: VeritoidId, target: VeritoidId },
}

impl fmt::Display for Owed {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Owed::Overclaim { v } => write!(f, "overclaim({v})"),
            Owed::StaleReference { v, target } => write!(f, "stale-reference({v}, {target})"),
            Owed::UnmetNeed { v, target } => write!(f, "unmet-need({v}, {target})"),
        }
    }
}

// ---------------------------------------------------------------------------
// State
// ---------------------------------------------------------------------------

/// The store as of one point in the log: the current veritoids and the acts
/// recorded so far.
#[derive(Clone, Debug, Default, PartialEq, Eq, Serialize, Deserialize)]
pub struct State {
    veritoids: BTreeMap<VeritoidId, Veritoid>,
    acts: Vec<Act>,
}

impl State {
    /// The empty store.
    pub fn empty() -> State {
        State::default()
    }

    /// Fold a sequence of records from the empty store.
    ///
    /// Fails only if some record would have been refused; a log that was
    /// built through [`Log::append`] never fails here.
    pub fn fold<'a>(records: impl IntoIterator<Item = &'a Record>) -> Result<State, Refusal> {
        let mut s = State::empty();
        for r in records {
            s = s.with(r)?;
        }
        Ok(s)
    }

    /// The state after one more record, or the refusal. `self` is untouched
    /// either way.
    pub fn with(&self, record: &Record) -> Result<State, Refusal> {
        match record {
            Record::Act(a) => {
                let mut next = self.clone();
                next.acts.push(a.clone());
                Ok(next)
            }
            Record::Changeset(cs) => self.with_changeset(cs),
        }
    }

    fn with_changeset(&self, cs: &Changeset) -> Result<State, Refusal> {
        // Well-formedness of the changeset on its own.
        let mut seen: BTreeSet<&VeritoidId> = BTreeSet::new();
        for v in &cs.veritoids {
            if v.segment != cs.segment {
                return Err(Refusal::WrongSegment {
                    id: v.id.clone(),
                    named: v.segment.clone(),
                    changeset: cs.segment.clone(),
                });
            }
            if !seen.insert(&v.id) {
                return Err(Refusal::DuplicateId { id: v.id.clone() });
            }
            if let Some(cur) = self.veritoids.get(&v.id)
                && cur.segment != cs.segment
            {
                return Err(Refusal::HeldElsewhere { id: v.id.clone(), by: cur.segment.clone() });
            }
        }

        // Replace the segment's set wholesale.
        let mut next = self.clone();
        next.veritoids.retain(|_, v| v.segment != cs.segment);
        for v in &cs.veritoids {
            next.veritoids.insert(v.id.clone(), v.clone());
        }

        // P5: refuse a cycle. References to ids that do not (yet / any more)
        // exist are not edges; they are reported as stale-reference instead.
        if let Some(path) = next.find_cycle() {
            return Err(Refusal::Cycle { path });
        }
        Ok(next)
    }

    /// A cycle in the reference graph among existing veritoids, if any.
    /// Iterative DFS with three colours; returns the cycle as a path whose
    /// first and last ids are equal.
    pub fn find_cycle(&self) -> Option<Vec<VeritoidId>> {
        #[derive(Clone, Copy, PartialEq)]
        enum Colour {
            White,
            Grey,
            Black,
        }
        let mut colour: BTreeMap<&VeritoidId, Colour> =
            self.veritoids.keys().map(|k| (k, Colour::White)).collect();

        for root in self.veritoids.keys() {
            if colour[root] != Colour::White {
                continue;
            }
            // Stack of (node, index of next reference to visit).
            let mut stack: Vec<(&VeritoidId, usize)> = vec![(root, 0)];
            colour.insert(root, Colour::Grey);
            while let Some(&(node, i)) = stack.last() {
                let refs = &self.veritoids[node].references;
                if i == refs.len() {
                    colour.insert(node, Colour::Black);
                    stack.pop();
                    continue;
                }
                stack.last_mut().unwrap().1 += 1;
                let target = &refs[i].target;
                match colour.get(target) {
                    None => {} // dangling reference: not an edge
                    Some(Colour::Black) => {}
                    Some(Colour::White) => {
                        colour.insert(target, Colour::Grey);
                        stack.push((target, 0));
                    }
                    Some(Colour::Grey) => {
                        let start = stack.iter().position(|(n, _)| *n == target).unwrap();
                        let mut path: Vec<VeritoidId> =
                            stack[start..].iter().map(|(n, _)| (*n).clone()).collect();
                        path.push(target.clone());
                        return Some(path);
                    }
                }
            }
        }
        None
    }

    // -- accessors ---------------------------------------------------------

    /// The current veritoids, by id.
    pub fn veritoids(&self) -> &BTreeMap<VeritoidId, Veritoid> {
        &self.veritoids
    }

    /// One current veritoid.
    pub fn veritoid(&self, id: &VeritoidId) -> Option<&Veritoid> {
        self.veritoids.get(id)
    }

    /// Every act recorded so far, in log order, binding or not.
    pub fn acts(&self) -> &[Act] {
        &self.acts
    }

    /// The current version of `id`, if it exists.
    pub fn current(&self, id: &VeritoidId) -> Option<&Version> {
        self.veritoids.get(id).map(|v| &v.version)
    }

    // -- the five computed things ------------------------------------------

    /// 1. An act binds while every `(id, version)` it read is still current.
    pub fn binds(&self, act: &Act) -> bool {
        act.reads.iter().all(|r| self.current(&r.id) == Some(&r.version))
    }

    /// 2. The greatest rung among binding `check` acts whose reads include
    ///    `v`; `sketch` if none. (A binding act that read `v` read its current
    ///    version, by the definition of binding.)
    pub fn position(&self, v: &VeritoidId) -> Rung {
        self.acts
            .iter()
            .filter(|a| a.kind == ActKind::Check)
            .filter(|a| a.reads.iter().any(|r| &r.id == v))
            .filter(|a| self.binds(a))
            .map(|a| a.rung)
            .max()
            .unwrap_or(Rung::BOTTOM)
    }

    /// 3. `min(position(v), min over references r of ceiling(r.target))`.
    ///
    /// SPEC: the spec leaves `ceiling` of a reference to a missing target
    /// undefined. Here a missing target contributes `sketch`: what rests on
    /// nothing is supported by nothing. The same holds for `ceiling` of an id
    /// that does not exist at all.
    ///
    /// Well-founded because every state reachable through [`State::with`] has
    /// an acyclic reference graph (P5). Recursion depth is bounded by the
    /// number of veritoids.
    pub fn ceiling(&self, v: &VeritoidId) -> Rung {
        let mut memo = BTreeMap::new();
        self.ceiling_memo(v, &mut memo)
    }

    fn ceiling_memo<'a>(&'a self, v: &'a VeritoidId, memo: &mut BTreeMap<&'a VeritoidId, Rung>) -> Rung {
        if let Some(&c) = memo.get(v) {
            return c;
        }
        let c = match self.veritoids.get(v) {
            None => Rung::BOTTOM,
            Some(vt) => {
                let mut c = self.position(v);
                for r in &vt.references {
                    c = c.min(self.ceiling_memo(&r.target, memo));
                }
                c
            }
        };
        memo.insert(v, c);
        c
    }

    /// 4. Everything owed in this state.
    pub fn frontier(&self) -> BTreeSet<Owed> {
        let mut owed = BTreeSet::new();
        let mut memo = BTreeMap::new();
        for (id, v) in &self.veritoids {
            if v.claimed > self.ceiling_memo(id, &mut memo) {
                owed.insert(Owed::Overclaim { v: id.clone() });
            }
            for r in &v.references {
                if self.current(&r.target) != Some(&r.seen) {
                    owed.insert(Owed::StaleReference { v: id.clone(), target: r.target.clone() });
                }
                if self.ceiling_memo(&r.target, &mut memo) < r.needed {
                    owed.insert(Owed::UnmetNeed { v: id.clone(), target: r.target.clone() });
                }
            }
        }
        owed
    }

    /// 5. Nothing is owed.
    pub fn steady(&self) -> bool {
        self.frontier().is_empty()
    }

    /// A readable rendering of the state: every veritoid with its claimed
    /// level, position and ceiling, then every act with whether it binds.
    pub fn render(&self) -> String {
        use std::fmt::Write as _;
        let mut out = String::new();
        for (id, v) in &self.veritoids {
            let _ = writeln!(
                out,
                "{id}@{} [{}] claimed={} position={} ceiling={}",
                v.version,
                v.segment,
                v.claimed,
                self.position(id),
                self.ceiling(id)
            );
            for r in &v.references {
                let _ = writeln!(out, "    -> {} needed={} seen={}", r.target, r.needed, r.seen);
            }
        }
        for (i, a) in self.acts.iter().enumerate() {
            let reads: Vec<String> = a.reads.iter().map(|r| format!("{}@{}", r.id, r.version)).collect();
            let _ = writeln!(
                out,
                "act#{i} {:?} by {} at {} [{}] reads {{{}}} {}",
                a.kind,
                a.actor,
                a.rung,
                a.criterion,
                reads.join(", "),
                if self.binds(a) { "binds" } else { "lapsed" }
            );
        }
        out
    }
}

// ---------------------------------------------------------------------------
// Log
// ---------------------------------------------------------------------------

/// The append-only log, with the fold of all of it cached as `head`.
///
/// P2 by construction: the only mutator is [`Log::append`], which pushes; the
/// records are reachable only by shared reference. Nothing in this crate can
/// remove or rewrite a record once it is in. (That is a property of this
/// crate's API, not of the file on disk.)
#[derive(Clone, Debug, Default, PartialEq, Eq)]
pub struct Log {
    records: Vec<Record>,
    head: State,
}

impl Log {
    pub fn new() -> Log {
        Log::default()
    }

    /// Append one record, or refuse it and leave the log unchanged.
    /// Returns the index of the new record.
    pub fn append(&mut self, record: Record) -> Result<usize, Refusal> {
        let next = self.head.with(&record)?;
        self.head = next;
        self.records.push(record);
        Ok(self.records.len() - 1)
    }

    /// Every record, in order.
    pub fn records(&self) -> &[Record] {
        &self.records
    }

    pub fn len(&self) -> usize {
        self.records.len()
    }

    pub fn is_empty(&self) -> bool {
        self.records.is_empty()
    }

    /// The state after all records.
    pub fn head(&self) -> &State {
        &self.head
    }

    /// The state after the first `n` records, folded from scratch.
    /// `n > len()` is clamped to the whole log.
    pub fn state_at(&self, n: usize) -> State {
        let n = n.min(self.records.len());
        State::fold(&self.records[..n]).expect("every record in a Log was once applied")
    }

    // -- serialization: JSON lines, one record per line --------------------

    /// Write the log as JSON lines.
    pub fn write_to(&self, mut w: impl std::io::Write) -> std::io::Result<()> {
        for r in &self.records {
            serde_json::to_writer(&mut w, r)?;
            w.write_all(b"\n")?;
        }
        Ok(())
    }

    /// Read a JSON-lines log, replaying every record through [`Log::append`]
    /// so that a file that would have been refused is refused on load.
    pub fn read_from(r: impl std::io::BufRead) -> Result<Log, LoadError> {
        let mut log = Log::new();
        for (i, line) in r.lines().enumerate() {
            let line = line?;
            if line.trim().is_empty() {
                continue;
            }
            let record: Record =
                serde_json::from_str(&line).map_err(|e| LoadError::Parse { line: i + 1, error: e })?;
            log.append(record).map_err(|r| LoadError::Refused { line: i + 1, refusal: r })?;
        }
        Ok(log)
    }
}

/// Why a log file could not be loaded.
#[derive(Debug)]
pub enum LoadError {
    Io(std::io::Error),
    Parse { line: usize, error: serde_json::Error },
    Refused { line: usize, refusal: Refusal },
}

impl From<std::io::Error> for LoadError {
    fn from(e: std::io::Error) -> Self {
        LoadError::Io(e)
    }
}

impl fmt::Display for LoadError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            LoadError::Io(e) => write!(f, "io: {e}"),
            LoadError::Parse { line, error } => write!(f, "line {line}: {error}"),
            LoadError::Refused { line, refusal } => write!(f, "line {line}: refused: {refusal}"),
        }
    }
}

impl std::error::Error for LoadError {}

// ---------------------------------------------------------------------------
// Small builders, so tests and the worked example read like the spec
// ---------------------------------------------------------------------------

/// `veritoid("c", "T", "1", Rung::Rederived, [("d", Rung::Drafted, "1")])`
pub fn veritoid<const N: usize>(
    id: &str,
    segment: &str,
    version: &str,
    claimed: Rung,
    references: [(&str, Rung, &str); N],
) -> Veritoid {
    Veritoid {
        id: id.into(),
        segment: segment.into(),
        version: version.into(),
        claimed,
        references: references
            .into_iter()
            .map(|(t, needed, seen)| Reference { target: t.into(), needed, seen: seen.into() })
            .collect(),
    }
}

/// A changeset record for `segment` holding exactly these veritoids.
pub fn changeset(segment: &str, veritoids: impl IntoIterator<Item = Veritoid>) -> Record {
    Record::Changeset(Changeset { segment: segment.into(), veritoids: veritoids.into_iter().collect() })
}

/// A `check` act record.
pub fn check<const N: usize>(actor: &str, criterion: &str, rung: Rung, reads: [(&str, &str); N]) -> Record {
    act(actor, criterion, ActKind::Check, rung, reads)
}

/// An `affirmation` act record.
pub fn affirmation<const N: usize>(actor: &str, criterion: &str, reads: [(&str, &str); N]) -> Record {
    act(actor, criterion, ActKind::Affirmation, Rung::BOTTOM, reads)
}

fn act<const N: usize>(actor: &str, criterion: &str, kind: ActKind, rung: Rung, reads: [(&str, &str); N]) -> Record {
    Record::Act(Act {
        actor: actor.into(),
        criterion: criterion.into(),
        kind,
        reads: reads.into_iter().map(|(id, v)| Read::new(id, v)).collect(),
        rung,
    })
}

pub mod example;
