```kdl
term "working·state" pos=noun pl="working·states" {
  avoid "branch" "one way of holding it"
  avoid "unstable" "it is incomplete, not unstable"
  rel is-a term="state" card="{1,1}"
  rel belongs-to term="atomic·changeset" card="{1,1}"
}
status provisional
```

# «working·state»
The last steady state plus everything one atomic changeset in progress has staged so far.

## Intro

There are two kinds of time, and they are kept apart. In «steady·time» the «data·store» moves from one «steady·state» to the next, each move at one logical instant; nothing exists between two steady states, and at each one the «verisectorium» is good or true, with stated conditions. In «work·time» minds assemble such a move over hours and days, with an order, clock times and actors; while they do there is a «working·state», the last steady state plus whatever has been staged so far, which changes as work proceeds and is never the verisectorium.

## Definition

### Invariants
- It is never the verisectorium. Readers of the verisectorium read steady states.
- Its «frontier» is computable at every moment.

## Discussion

- Why two kinds of time. Without them, "the claim changed" and "the description was brought into line" are two records with a gap between them in which the store held something nobody ever meant. Logical simultaneity needs a place to live; steady time is that place, and work time is where the honest record of how the move was assembled lives.
- Joseph's phrases for the two: "simultaneously, logically speaking" and "practical sequence".

## Examples

- A segment rewritten three times while a move is assembled: only the last rewrite exists in the next steady state; the first two are kept as work-time record, and no steady state ever contained them.

## Working Notes

- Intro, discussion and examples shared verbatim with former group-mates (steady·state, steady·time, work·time); to be rewritten for this term alone when adjudicated.
- Open. Whether a finding that breaks something may show on the steady line before its consequences are worked through, as a mark on a value that says "a known defect probably lowers this; not yet worked through; do not rely on it". Joseph would accept such marks if they are rare and nearly always what is being worked on. A steady state would then promise two different things, consistent and honestly current. Lean: allow the mark, and have it inhibit anything new from binding at the marked level rather than capping how many may exist.
- Open. Several working states at once, and whether the union of two independently steady stores is itself steady. Punted by Joseph, who is alone in charge of workflow for now.
- Open. Whether a working state is held as a branch, a separate store, or something else. An architectural decision; the requirements are checkpoints, a diff against the starting steady state, the frontier, a merge only when the frontier is empty or accepted, and detection of overlapping changesets before merge.
- Adjudicated against msc/notes 05 (22:19Z, 22:53Z, 23:11Z), 08/10, 09 §3.1, 11 def-state, 14.
