# Debrief for Joseph: the kernel in Ada 2022 + SPARK, by Fable

*Written after re-reading the finished sources, not from memory of the work. The account beside this file (`account.md`) is the long form; this is what I would tell you across a table.*

## What exists now

A working kernel of the kind the spec asks for, in SPARK, with every property the spec lists either proved by gnatprove or tested, and the account says which. The log is append-only, the state as of any record can be recomputed, and the frontier (what is still owed) is computed from the state, never typed. The worked example from the spec runs end to end, is saved to a file, is read back, and gives the same state. `alr build`, `alr test`, `alr gnatprove` all pass; the last says "all checks proved (423 checks)" with nothing assumed.

## The three things worth knowing

**1. The claims really are postconditions, and SPARK really does discharge them.** "An act stops binding exactly when a changeset changed or removed something it read" (P3) and "recording a check never lowers any position and only raises the ones it read" (P4) were written as the contracts of the two procedures that change a state, and the prover accepted both on the first run with no help. The exact definition of `ceiling` (the least of a piece's own position and what it rests on) is the postcondition of the function that computes it, and it proves too. This is the part of your question I can now answer from evidence rather than argument: for this model's kind of claim, SPARK is the right instrument.

**2. The spec is wrong in two places, and the proof found one of them.** First: P3 is not true under the spec's definitions alone. An act that read a version of something that did not yet exist would *start* binding when that version appeared, and nothing ties an id to a segment. Two rules make it true, and I believe they are rules the model already wants: an id belongs for life to the segment that introduced it (a dropped id is a tombstone, never a stranger's), and an act may only read ids that exist. With those, P3 is proved as written. Second: the worked example's list of what is owed after the perturbation has seven items; the spec's own definitions give ten. The description `e` is also overclaimed (it claims `drafted`, but it rests on `c`, whose ceiling fell to `sketch`), and `d`'s and `e`'s need for `c` at `drafted` is also unmet. The three missing items are all of the same kind: the fall of a root reaching things that rest on it, which is the phenomenon the model is about.

**3. There is one trap in the toolchain, and it ate a third of the proof time.** In SPARK, "these two states are equal" (`A = B`) does not let the prover conclude that any function gives the same answer on both. It compares the records piece by piece and stops there. Everything in the log layer ("folding the log is the same as applying the records one by one", "two logs with the same first K records agree at K") looked trivially true and would not prove. The cure is a tool annotation (`Logical_Equal`) that tells the prover a named function means real equality; the SPARK standard library uses the same device for the same reason. I kept the measurements in the tree (`Kernel.Equality_Probe`) so the next mind does not pay for this again. That is the honest answer to "fluency under turnover": the kernel and its contracts came out right in one pass; the prover's encoding has two or three facts of this kind that nothing in the code hints at, and they have to be inherited, not rediscovered.

## What the spec left open and what I decided

- A reference to a piece that no longer exists supports nothing: it caps the ceiling at `sketch`.
- A refused changeset (one that would make a reference cycle) is reported with a witness and the log does not move; nothing is recorded, because nothing happened to the store. The witness is the set of pieces that could not be ordered: the cycle and everything resting on it.
- A reference's "version seen" can be updated without the piece's own version changing (the worked example needs this for `e`). So it is written state that is not content. The spec should say so.
- Affirmations are recorded and nothing reads them. The kernel as specified cannot tell a draft (a changeset with an unaffirmed carried piece) from a changeset. That is a gap in the spec, not a choice of mine.
- Everything is bounded (24 pieces, 96 records, and so on, as constants). That is how SPARK proves comfortably; a real engine would pay for unbounded data with heavier specifications.

## What is proved, what is tested, what is neither

Proved: P1 (as a lemma: the state at K depends on records 1..K only), P2, P3, P4, P5's soundness (an accepted changeset leaves no cycle) and its refusal's witness, P6 as the exact ceiling definition, P7, and that the frontier list is exactly the set of owed items. Tested only: P8 (file round trip; the file format is not SPARK), and that P5 never refuses an acyclic changeset for want of passes (it cannot, by counting; I did not get the count into the prover). Neither: nothing the spec asked for.

## What I did not get to, honestly

The counting argument above (half an hour to an hour). Stating "unused slots are blank" as an invariant rather than keeping it by construction (an hour). A real cycle as the refusal witness instead of a closed set (a few hours). None of these changes what the kernel does.

## Tangents

The spike confirms the model's own instinct that "state" is more than content: I had to carry one computed thing (a rank per piece) alongside the content to make acyclicity checkable and `ceiling` well-founded, and it is canonical, so it does not break "the state is a function of the log". And the spec's P7 ("steady means honest") turns out to have no content beyond the definition of the frontier; the fact worth asking for is that the computed frontier list is exactly the set the definitions describe, which is what I proved instead.
