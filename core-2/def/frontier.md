```kdl
term "frontier" pos=noun pl="-s" {
  avoid "todo list" "a frontier is computed, never typed, and lies only as much as the state it is computed from"
  avoid "obligations" "an earlier word; the items are violated constraints, each with a clearer"
  rel of term="changeset" card="{1,1}" note="the atomic changeset in progress whose working state it is computed over"
  rel names term="dimension" card="{0,N}" note="per item: the dimension whose constraint is violated and whose producer can clear it" informal=#true
}
status provisional
```

# «frontier»
Everything owed in a working state: every violated constraint, computed fresh after each write or act, each item naming its cause and who can clear it.

## Definition
After every write or act in an ‹atomic·changeset›, the store recomputes which constraints fail in the working state. The items are:

| item | the constraint it violates | cleared by |
|---|---|---|
| **overclaim** (piece, dimension) | assertion ≤ warrant | the dimension's producer raising the warrant, or the author lowering the assertion or narrowing the content |
| **stale** (reference) | the target is at the version the reference saw | the author reconciling or re-pointing it, after answering "did I rely on what changed?" |
| **dangling** (reference) | the target exists | re-pointing to a descendant, or dropping |
| **unmet** (reference) | the target's warrant ≥ what the reference needs | the target earning it, or the author needing less |
| **broken** (piece, act) | what a check or finding found broken has been dealt with | a repair that lapses the breaking act, or an acceptance |
| **raised** (piece, dimension) | a question a rule firing or outside change put to a piece has been answered | the dimension's producer |
| whatever the ontology's own constraints add | | |

Each item carries its cause (which write or act made it owed) and, through the «dimension»'s *produced by*, who can clear it. The frontier is addressed to someone. Beside the owed items it shows, as information and not as owed, every piece whose *own* warrant exceeds its *effective* one: a well-checked claim resting on an unchecked premise. The cap is part of how the effective warrant is computed, so an assertion above it is already an overclaim; the cap itself is never a violation.

### Invariants
- It is computed, never kept. The same recorded things read in any order give the same frontier.
- Only a checkpoint has an empty frontier, or one whose every item is accepted.
- A broken check or a finding adds an item the moment it is recorded, before any repair.
- Uncrossed chunks in an inbox are not owed; an inbox may be full at a checkpoint. A source not yet retired is not owed either; retirement is a state of the source, not a constraint on the store.
- If the frontier keeps growing instead of shrinking as a changeset is staged, work stops and the whole is looked at: two ideas treated as one, a genuine tension between two well-supported claims, or a foundation that has moved.

## Discussion
- Why the frontier is the first thing a working agent looks at. The kind tables of the earlier notes said what records can be; the frontier says what is not yet true around what I just changed, and that is the question a mind at work actually has. Joseph's "clear delineation of the frontier vs stable checkpoints" is the critical thing this model adds over the ad hoc verisectoria.
- Why one cause can make many items. One softened root makes a stale reference, an unmet need and a cap on every dependent. The raw set is what a stranger can recompute; grouping by cause is a rendering.
- Why the known-defect mark needs no machinery. A broken item still on the frontier when a checkpoint is wanted is either repaired or accepted with a reason, and the acceptance is visible in the checkpoint's conditions. That is the mark, as Joseph described it: "a known defect probably lowers this; not yet worked through; do not rely in the meantime".

## Examples
- `scope-adaptive-system` at `12ea0186`, after review reread-1: broken (item (c)'s decay claim, by C3), broken (item (h)'s support claim, by C4), overclaim ((h): asserted exact, warrant broken), and five findings F1–F5. The integrator's changeset `5e613630` lapsed every reread act and cleared the two broken items; the new text then owed its own warrant until integration-2 and check-4 earned it.
- `deriv-sector-condition` under this model, from 2026-04-22 to 10-30: overclaim (Prop A.1S(i), validity: asserted exact, warrant never asked), because every recorded pass concerned a proof step and not the statement. See `examples/stopped-bound.md`.

## Working Notes
- Open. Whether the item kinds above are complete. The kernels needed three; the notes add broken and raised; an ontology adds its own.
- Open. What agents will do to make the frontier empty. Affirmations and acceptances are both cheap exits, and any marker of done becomes a target. The model's only answer is that both are attestations with reasons, visible at every checkpoint.
- Adjudicated against msc/notes 05 (22:19Z), 09 §4.3, 10 §1.1, 19 §5, and Joseph's 11-08 "dimensions as constraints".
