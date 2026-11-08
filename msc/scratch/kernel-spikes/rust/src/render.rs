//! Plain-text rendering of a state, for the CLI. Porcelain; a snapshot.

use std::fmt::Write;

use crate::model::*;
use crate::state::State;

pub fn render_state(s: &State) -> String {
    let mut o = String::new();
    let pos = s.positions();
    let ceil = s.ceilings();
    let _ = writeln!(o, "state after {} record(s)", s.folded());
    let _ = writeln!(o, "veritoids:");
    for (id, h) in s.veritoids() {
        let refs: Vec<String> = h
            .written
            .references
            .iter()
            .map(|(t, r)| format!("{t} needs {} seen @{}", r.needed, r.seen))
            .collect();
        let _ = writeln!(
            o,
            "  {id}@{} [{}] claimed {:<9} position {:<9} ceiling {:<9}{}",
            h.written.version,
            h.segment,
            h.written.claimed.name(),
            pos[id].name(),
            ceil[id].name(),
            if refs.is_empty() { String::new() } else { format!(" refs: {}", refs.join("; ")) }
        );
    }
    let _ = writeln!(o, "acts:");
    for (i, a) in s.acts() {
        let kind = match a.kind {
            ActKind::Check { rung } => format!("check {rung}"),
            ActKind::Affirmation => "affirmation".to_string(),
        };
        let reads: Vec<String> = a.reads.iter().map(|(id, v)| format!("{id}@{v}")).collect();
        let concerns: Vec<String> = a.concerns.iter().map(|c| c.to_string()).collect();
        let _ = writeln!(
            o,
            "  #{i} {} {kind} reads {{{}}} concerns {{{}}} -> {}",
            a.actor,
            reads.join(", "),
            concerns.join(", "),
            if s.binds(a) { "binds" } else { "lapsed" }
        );
    }
    if !s.refusals().is_empty() {
        let _ = writeln!(o, "refused:");
        for (i, r) in s.refusals() {
            let _ = writeln!(o, "  #{i} {r:?}");
        }
    }
    let f = s.frontier();
    let _ = writeln!(o, "frontier ({}):", f.len());
    for item in &f {
        let _ = writeln!(o, "  {item}");
    }
    let _ = writeln!(o, "steady: {}", s.steady());
    o
}
