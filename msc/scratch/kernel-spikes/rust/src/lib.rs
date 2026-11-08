//! The smallest kernel of a verisectorium engine (spec: ../KERNEL-SPEC.md).
//!
//! An append-only log of records (segment changesets and acts); the state as of
//! any prefix of it; and five things computed from a state, never stored:
//! `binds`, `position`, `ceiling`, `frontier`, `steady`. Where this crate
//! departs from the spec, the departure and its reason are in ../account.md.

pub mod codec;
pub mod example;
pub mod log;
pub mod model;
pub mod render;
pub mod state;

pub use log::Log;
pub use model::*;
pub use state::{fold, Held, Outcome, Owed, Refusal, State};

#[cfg(kani)]
mod proofs;
