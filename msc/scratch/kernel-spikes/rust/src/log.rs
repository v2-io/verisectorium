//! The log: append-only, with its head state kept alongside.
//!
//! P2 (append-only) is enforced by encapsulation: `records` is private, and the
//! only operation that changes a `Log` is `append`, which pushes. There is no
//! `&mut` access to any record, no remove, no insert, no truncate. (A caller
//! can of course drop the whole `Log` value or build a different one; what the
//! type guarantees is that no `Log` value ever loses or alters a record it
//! already holds. That is the strongest form of P2 a library can state about
//! its own values; a store on disk needs the same discipline from its writer.)

use crate::model::Record;
use crate::state::{fold, Outcome, State};

#[derive(Debug, Clone, PartialEq, Eq, Default)]
pub struct Log {
    records: Vec<Record>,
    head: State,
}

impl Log {
    pub fn new() -> Log {
        Log::default()
    }

    /// Replay: build a log by appending `records` in order.
    pub fn from_records(records: Vec<Record>) -> Log {
        let mut log = Log::new();
        for r in records {
            log.append(r);
        }
        log
    }

    /// Append a record. It is recorded whether or not it takes effect; the
    /// returned outcome says which, computed from the state before it.
    pub fn append(&mut self, r: Record) -> Outcome {
        let out = self.head.apply(&r);
        self.records.push(r);
        out
    }

    pub fn records(&self) -> &[Record] {
        &self.records
    }
    pub fn len(&self) -> usize {
        self.records.len()
    }
    pub fn is_empty(&self) -> bool {
        self.records.is_empty()
    }

    /// The state after the whole log.
    pub fn state(&self) -> &State {
        &self.head
    }

    /// The state as of index `n`: the fold of the first `n` records
    /// (`n` is clamped to the log's length).
    pub fn state_at(&self, n: usize) -> State {
        fold(&self.records[..n.min(self.records.len())])
    }
}
