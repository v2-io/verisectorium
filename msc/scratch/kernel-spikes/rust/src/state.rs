//! State: the fold of a log prefix, and the five computed things.
//!
//! A `State` can only be produced by folding records (`fold`, `Log`); there is
//! no public constructor that takes veritoids directly, so every state a caller
//! can hold is the state of some log prefix. Its private invariant, maintained
//! by `apply` and relied on by `ceilings`: the reference graph among held
//! veritoids is acyclic.

use std::collections::{BTreeMap, BTreeSet};
use std::fmt;

use crate::model::*;

/// A veritoid as held in a state: which segment holds it, and what was written.
#[derive(Debug, Clone, PartialEq, Eq)]
pub struct Held {
    pub segment: SegmentId,
    pub written: Written,
}

/// Why a record did not take effect. Computed at fold time from the prefix
/// state, never stored as a verdict: the log holds the attempted record, and
/// replay recomputes the refusal.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Refusal {
    /// The changeset names a veritoid another segment holds. (Moving a
    /// veritoid between segments is the model's open "identity under recut".)
    ForeignVeritoid { id: VeritoidId, owner: SegmentId },
    /// The changeset keeps a veritoid's version but changes its references.
    ReferencesChangedWithoutNewVersion { id: VeritoidId },
    /// The changeset would make the reference graph cyclic. `cycle` lists the
    /// ids around one cycle, first repeated at the end.
    Cycle { cycle: Vec<VeritoidId> },
    /// The act attests nothing.
    ActConcernsNothing,
    /// The act attests a veritoid it did not read.
    ActConcernsUnread { id: VeritoidId },
}

/// What happened to a record when it was folded.
#[derive(Debug, Clone, PartialEq, Eq)]
pub enum Outcome {
    Applied,
    Refused(Refusal),
}

/// One owed item on the frontier.
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub enum Owed {
    /// claimed level of `v` > ceiling(v)
    Overclaim { v: VeritoidId },
    /// `v`'s reference to `target` is not reconciled with target's current
    /// version (or the target no longer exists)
    StaleReference { v: VeritoidId, target: VeritoidId },
    /// ceiling(target) < the rung `v` needs it at
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

/// The store as of one point in its log.
#[derive(Debug, Clone, PartialEq, Eq, Default)]
pub struct State {
    veritoids: BTreeMap<VeritoidId, Held>,
    /// Every act that took effect, with its log index.
    acts: Vec<(usize, Act)>,
    /// Every record that did not take effect, with its log index and why.
    refusals: Vec<(usize, Refusal)>,
    /// How many records have been folded.
    folded: usize,
}

/// Fold records from the empty state.
pub fn fold(records: &[Record]) -> State {
    let mut s = State::default();
    for r in records {
        s.apply(r);
    }
    s
}

impl State {
    // ------------------------------------------------------------ reading

    pub fn veritoids(&self) -> &BTreeMap<VeritoidId, Held> {
        &self.veritoids
    }
    pub fn acts(&self) -> &[(usize, Act)] {
        &self.acts
    }
    pub fn refusals(&self) -> &[(usize, Refusal)] {
        &self.refusals
    }
    pub fn folded(&self) -> usize {
        self.folded
    }
    pub fn current_version(&self, id: &VeritoidId) -> Option<Version> {
        self.veritoids.get(id).map(|h| h.written.version)
    }
    /// The ids a segment currently holds.
    pub fn segment_members(&self, seg: &SegmentId) -> BTreeSet<VeritoidId> {
        self.veritoids.iter().filter(|(_, h)| &h.segment == seg).map(|(i, _)| i.clone()).collect()
    }

    // ------------------------------------------------------------ folding

    /// Fold one record into this state. Crate-private: a caller reaches states
    /// only through `fold` and `Log`, so every state is a log prefix's state.
    pub(crate) fn apply(&mut self, rec: &Record) -> Outcome {
        let index = self.folded;
        self.folded += 1;
        let outcome = match rec {
            Record::Changeset(cs) => self.apply_changeset(cs),
            Record::Act(a) => self.apply_act(a),
        };
        match &outcome {
            Outcome::Applied => {
                if let Record::Act(a) = rec {
                    self.acts.push((index, a.clone()));
                }
            }
            Outcome::Refused(r) => self.refusals.push((index, r.clone())),
        }
        outcome
    }

    fn apply_act(&self, a: &Act) -> Outcome {
        if a.concerns.is_empty() {
            return Outcome::Refused(Refusal::ActConcernsNothing);
        }
        if let Some(id) = a.concerns.iter().find(|c| !a.reads.contains_key(*c)) {
            return Outcome::Refused(Refusal::ActConcernsUnread { id: id.clone() });
        }
        // An act may read versions that are not current, or ids that do not
        // exist: it was performed in work time against something; it is
        // recorded honestly and simply does not bind.
        Outcome::Applied
    }

    fn apply_changeset(&mut self, cs: &SegmentChangeset) -> Outcome {
        for (id, w) in &cs.veritoids {
            if let Some(h) = self.veritoids.get(id) {
                if h.segment != cs.segment {
                    return Outcome::Refused(Refusal::ForeignVeritoid { id: id.clone(), owner: h.segment.clone() });
                }
                if h.written.version == w.version && h.written.references != w.references {
                    return Outcome::Refused(Refusal::ReferencesChangedWithoutNewVersion { id: id.clone() });
                }
            }
        }
        let mut next = self.veritoids.clone();
        next.retain(|_, h| h.segment != cs.segment);
        for (id, w) in &cs.veritoids {
            next.insert(id.clone(), Held { segment: cs.segment.clone(), written: w.clone() });
        }
        if let Some(cycle) = find_cycle(&next) {
            return Outcome::Refused(Refusal::Cycle { cycle });
        }
        self.veritoids = next;
        Outcome::Applied
    }

    // ------------------------------------------------------------ the five computed things

    /// (1) binds(act): every (id, version) the act read is the current version
    /// of an id that still exists.
    pub fn binds(&self, a: &Act) -> bool {
        a.reads.iter().all(|(id, ver)| self.current_version(id) == Some(*ver))
    }

    /// Positions of every held veritoid: the greatest rung among binding
    /// `check` acts that concern it; `sketch` if none.
    pub fn positions(&self) -> BTreeMap<VeritoidId, Rung> {
        let mut pos: BTreeMap<VeritoidId, Rung> =
            self.veritoids.keys().map(|k| (k.clone(), Rung::BOTTOM)).collect();
        for (_, a) in &self.acts {
            if let ActKind::Check { rung } = a.kind
                && self.binds(a) {
                    for c in &a.concerns {
                        // binds + concerns ⊆ reads  ⇒  c is held
                        if let Some(p) = pos.get_mut(c) {
                            *p = (*p).max(rung);
                        }
                    }
                }
        }
        pos
    }

    /// (2) position(v); `None` if `v` is not held.
    pub fn position(&self, v: &VeritoidId) -> Option<Rung> {
        self.positions().get(v).copied()
    }

    /// Ceilings of every held veritoid:
    /// ceiling(v) = min(position(v), min over references r of ceiling(r.target)),
    /// where a reference to a target that is not held contributes `sketch`
    /// (nothing can rest on what is not there).
    pub fn ceilings(&self) -> BTreeMap<VeritoidId, Rung> {
        let pos = self.positions();
        let mut memo: BTreeMap<VeritoidId, Rung> = BTreeMap::new();
        for id in self.veritoids.keys() {
            self.ceiling_into(id, &pos, &mut memo);
        }
        memo
    }

    fn ceiling_into(&self, id: &VeritoidId, pos: &BTreeMap<VeritoidId, Rung>, memo: &mut BTreeMap<VeritoidId, Rung>) -> Rung {
        if let Some(c) = memo.get(id) {
            return *c;
        }
        let Some(h) = self.veritoids.get(id) else { return Rung::BOTTOM };
        let mut c = pos[id];
        for t in h.written.references.keys() {
            // Terminates: the reference graph is acyclic (invariant of `apply`).
            c = c.min(self.ceiling_into(t, pos, memo));
        }
        memo.insert(id.clone(), c);
        c
    }

    /// (3) ceiling(v); `None` if `v` is not held.
    pub fn ceiling(&self, v: &VeritoidId) -> Option<Rung> {
        self.ceilings().get(v).copied()
    }

    /// Whether `v`'s reference to `target` is reconciled with target's current
    /// version: either `v` was written against it (`seen` == current), or a
    /// binding affirmation concerning `v` read the target at its current
    /// version. An affirmation never counts toward a rung; this is its whole
    /// computed effect.
    pub fn reconciled(&self, v: &VeritoidId, target: &VeritoidId) -> bool {
        let Some(h) = self.veritoids.get(v) else { return false };
        let Some(r) = h.written.references.get(target) else { return false };
        let Some(cur) = self.current_version(target) else { return false };
        r.seen == cur
            || self.acts.iter().any(|(_, a)| {
                a.kind == ActKind::Affirmation
                    && a.concerns.contains(v)
                    && a.reads.get(target) == Some(&cur)
                    && self.binds(a)
            })
    }

    /// (4) frontier(state): every owed item.
    pub fn frontier(&self) -> BTreeSet<Owed> {
        let ceil = self.ceilings();
        let mut out = BTreeSet::new();
        for (v, h) in &self.veritoids {
            if h.written.claimed > ceil[v] {
                out.insert(Owed::Overclaim { v: v.clone() });
            }
            for (t, r) in &h.written.references {
                if !self.reconciled(v, t) {
                    out.insert(Owed::StaleReference { v: v.clone(), target: t.clone() });
                }
                let tc = ceil.get(t).copied().unwrap_or(Rung::BOTTOM);
                if tc < r.needed {
                    out.insert(Owed::UnmetNeed { v: v.clone(), target: t.clone() });
                }
            }
        }
        out
    }

    /// (5) steady(state) iff the frontier is empty.
    pub fn steady(&self) -> bool {
        self.frontier().is_empty()
    }
}

/// A cycle in the reference graph among `held` (edges only to held targets),
/// as a path whose first id is repeated at the end; `None` if acyclic.
pub fn find_cycle(held: &BTreeMap<VeritoidId, Held>) -> Option<Vec<VeritoidId>> {
    #[derive(Clone, Copy, PartialEq)]
    enum Mark {
        Open,
        Done,
    }
    let mut mark: BTreeMap<&VeritoidId, Mark> = BTreeMap::new();
    for root in held.keys() {
        if mark.contains_key(root) {
            continue;
        }
        // Iterative DFS: stack of (node, its targets, next target index).
        let mut path: Vec<&VeritoidId> = vec![root];
        let mut stack: Vec<(&VeritoidId, Vec<&VeritoidId>, usize)> = Vec::new();
        mark.insert(root, Mark::Open);
        stack.push((root, held[root].written.references.keys().filter(|t| held.contains_key(*t)).collect(), 0));
        while let Some((node, targets, i)) = stack.last_mut() {
            if *i < targets.len() {
                let t = targets[*i];
                *i += 1;
                match mark.get(t) {
                    Some(Mark::Open) => {
                        let start = path.iter().position(|p| *p == t).expect("open node is on the path");
                        let mut cyc: Vec<VeritoidId> = path[start..].iter().map(|p| (*p).clone()).collect();
                        cyc.push(t.clone());
                        return Some(cyc);
                    }
                    Some(Mark::Done) => {}
                    None => {
                        mark.insert(t, Mark::Open);
                        path.push(t);
                        let ts = held[t].written.references.keys().filter(|x| held.contains_key(*x)).collect();
                        stack.push((t, ts, 0));
                    }
                }
            } else {
                mark.insert(node, Mark::Done);
                path.pop();
                stack.pop();
            }
        }
    }
    None
}
