```kdl
term "steady·state" pos=noun pl="steady·states" {
  synonyms "stationary"
  avoid "checkpoint" "a place passed through on the way somewhere else, and a moment of verification; a verisectorium at a steady state is not on the way anywhere, and the state is not the moment it was reached"
  avoid "stable" "suggests nothing is moving; a verisectorium at a steady state may be under heavy work in work time"
  avoid "main" "a branch name, one way of holding one"
  avoid "fixed point" "right as mathematics, wrong as a word for readers"
  rel reached-by term="changeset" card="{0,1}" note="the atomic changeset that closed on it; none for the first"
  rel conditions term="act" card="{0,N}" note="the acceptances that cover what is still owed" informal=#true
}
status provisional
```

# «steady·state»
A state whose frontier is empty, or every item on it is covered by an acceptance with a reason; the acceptances, and the determinant dimensions never asked, are its stated conditions. A verisectorium at a steady state is *stationary*: the adjective for the noun.

## Definition
There are two kinds of time. In **steady time** the verisectorium moves from one steady state to the next, each move at one logical instant; nothing exists between two steady states, and at each one the verisectorium is good or true, with stated conditions. In **work time** minds assemble that move over hours and days; while they do there is a working state, the last steady state plus what has been staged, and it is never the theory. A steady state is reached when an ‹atomic·changeset› closes: its «frontier» is empty, or what remains on it is covered by acceptances.

The steady state's **stated conditions** are: every acceptance covering an owed item, with its reason and its actor; and, for the ‹determinant› dimensions, every piece whose warrant is *never asked*. A rendering of a steady state carries them; a reader who sees a steady state sees what it is not yet claiming.

### Invariants
- At a steady state no piece asserts more than its acts warrant, every reference holds, and nothing is warranted above what it rests on, except by recorded acceptance.
- The steady states form a line. None exists between two neighbours. Only the last write to each segment in an atomic changeset is in the steady state it reaches.
- An acceptance is an attestation by an actor the ontology gives standing to accept, with a reason; it is visible in the conditions of every steady state while the item stays owed, and it is cleared by the repair that clears the item.
- A confirming check on a steady state reaches a new steady state at once, since nothing becomes owed.
- An acceptance is about the owed item it covers and warrants nothing about any piece's content; a steward's act covering a changeset is not a ratification of what the changeset says. Silence is not ratification either.

## Discussion
- Why "good or true, with stated conditions" needs the conditions. A verisectorium that only promised consistency could be consistent and silent about a known defect. The acceptances are where honesty about the not-yet lives; they are Joseph's known-defect mark and his "known honesty orthogonal to internal consistency" at once. A steady state promises two things, consistent and honestly current, and the conditions are what makes the second true.
- Why the never-asked determinants are conditions. A claim asserting nothing and never checked violates no constraint; it is simply unknown. For a determinant that unknown is part of what the steady state is not claiming, and a reader should see it beside the acceptances.
- Why two kinds of time. Without them, "the claim changed" and "the description was brought into line" are two records with a gap between them in which the corpus held something nobody meant. Steady time is where logical simultaneity lives; work time is where the honest record of how the move was assembled lives.

## Examples
- `scope-adaptive-system` on 2026-10-31 after check 8: validity warrants confirmed on every item at `9fde935e`; one narrowed check (C11, the cold-reader clause) and two findings (F1, corrected by its author; F5, small points) owed. A steady state there needs three acceptances or three repairs, and its conditions would name them.
- `deriv-sector-condition` at the pre-integration tag, under this model: no steady state from 2026-04-22 on without an acceptance of Prop A.1S(i)'s overclaim, which nobody would have written, because writing it is what would have prompted the check.

## Historical Context
### Etymology
From dynamical systems: a state that persists until something perturbs it, whatever activity goes on around it. Joseph's own "steady-state stability as a self-consistency check" and "stable checkpoints / states" (2026-11-05). *Checkpoint* was the term for a day (2026-11-08/09) and was dropped at his worry that it names a place passed through on the way somewhere else, and a moment of verification rather than a state; a verisectorium at a steady state is not on the way anywhere. *Stable* was declined because it suggests nothing is moving, while the acta may be busy in work time; *fixed point* is right as mathematics and wrong for readers; *main* is a branch name; the Latin stops on a road (*statio*, *mansio*) carry the connotation being left.

### Adjudication
- The two kinds of time were Joseph's correction of 2026-11-05 ("practical sequentialness but logical simultaneity") to a draft whose acta were a flat list of single-piece acts; `msc/notes/08/10` carries the correction and its worked table. The known-defect mark he weighed that day became the acceptance here once the frontier was computed.
- Adjudicated against msc/notes 05 (22:53Z), 08/10, 09 §3.1 and §4.4, 14, 19 §5 and §7, and Joseph's 11-08 words on frontier versus stable steady states.

## Working Notes
- Open (Joseph's, punted). Whether two steady states reached independently in two working copies combine into a steady state. The model says nothing.
- Open. Whether a working state is held as a branch, a separate corpus, or otherwise. The requirements are: steady states along the way, a diff against the last steady state, the frontier, a merge only when the frontier is empty or accepted, and detection of overlapping changesets before merge. Git gives the first two for files.
- The acceptance-warrants-nothing invariant was added 2026-11-09 from the estate's own experience of minds reading a signature or a ratified mark as a lock on content (`msc/scratch/research-live-docs-2026-11-09.md` §2.2 and §3 carry the production specimens).
- Open. How much warrant a small rewording should cost. Here acts lapse completely on any change to what they read; a verisectorium wanting a graded fall declares a *read as* that gives one.
