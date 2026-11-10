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
After every write or act in an ‹atomic·changeset›, the frontier is recomputed: which constraints fail in the working state. The items are:

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
- Only a steady state has an empty frontier, or one whose every item is accepted.
- A broken check or a finding adds an item the moment it is recorded, before any repair.
- Uncrossed chunks in an inbox are not owed; an inbox may be full at a steady state. A source not yet retired is not owed either; retirement is a state of the source, not a constraint on the verisectorium.
- If the frontier keeps growing instead of shrinking as a changeset is staged, work stops and the whole is looked at: two ideas treated as one, a genuine tension between two well-supported claims, or a foundation that has moved.

## Discussion
- Why the frontier is the first thing a working agent looks at. The kind tables of the earlier notes said what records can be; the frontier says what is not yet true around what I just changed, and that is the question a mind at work actually has. Joseph's "clear delineation of the frontier vs stable steady states" is the critical thing this model adds over the ad hoc verisectoria.
- Why one cause can make many items. One softened root makes a stale reference, an unmet need and a cap on every dependent. The raw set is what a stranger can recompute; grouping by cause is a rendering.
- Why the known-defect mark needs no machinery. A broken item still on the frontier when a steady state is wanted is either repaired or accepted with a reason, and the acceptance is visible in the steady state's conditions. That is the mark, as Joseph described it: "a known defect probably lowers this; not yet worked through; do not rely in the meantime".

## Examples
- `scope-adaptive-system` at `12ea0186`, after review reread-1: broken (item (c)'s decay claim, by C3), broken (item (h)'s support claim, by C4), overclaim ((h): asserted exact, warrant broken), and five findings F1–F5. The integrator's changeset `5e613630` lapsed every reread act and cleared the two broken items; the new text then owed its own warrant until integration-2 and check-4 earned it.
- AAT's Prop A.1S(i) on 2026-10-30: a check by a new means (collision with the segment's own corollary) comes back broken on a claim whose validity had been confirmed several times. From that moment: broken (the claim, by that act), and an overclaim (asserted exact, warrant broken), each owed before any repair is written; and a question raised on every piece predicated on it.

## Historical Context
### Etymology
From *frons*, the front: the line where settled territory ends. What is still owed in a working state, computed, addressed to someone. Kept over *obligations* (the plan's word) and *todo list* (which is typed) because a frontier moves as work advances and is never kept by hand.

### Adjudication
- Adjudicated against msc/notes 05 (22:19Z), 09 §4.3, 10 §1.1, 19 §5, and Joseph's 11-08 "dimensions as constraints".

## Working Notes
- From the first core's "steady·state", whose one-line definition ended "and no rule that would fire": a *raised* item here covers a rule firing that happened; nothing covers a rule that is due and has not been run. Lean: a steady state is computed with every declared rule evaluated as of that state, so "due and unrun" cannot arise; to be said in «steady·state» once decided.
- Open. Whether the item kinds above are complete. The kernels needed three; the notes add broken and raised; an ontology adds its own.
- The frontier is as complete as the references; see «reference»'s notes on detection. And a computed frontier nobody is shown silts exactly like a kept list: it has to be rendered where every changeset opens and closes, and the message that reaches the steward from it should carry only what the steward alone can weigh.
- The twin of the open question below: what agents will refuse to do because a mark reads as a lock. Any changeset may lower or replace any assertion with a recorded reason; ruled, ratified and exact are assertions, not locks, and the practical model should say so plainly.
- Open. What agents will do to make the frontier empty. Affirmations and acceptances are both cheap exits, and any marker of done becomes a target. The model's only answer is that both are attestations with reasons, visible at every steady state.
