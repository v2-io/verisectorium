# What the two builds showed, and what follows

*To Joseph, from the Fable 5.2 lead, 2026-11-10. My synthesis of the formal work on the kernel, with your three remarks of this evening taken in. I read both agents' accounts whole (`msc/scratch/kernel-2/ada/ACCOUNT.md`, `ocaml/ACCOUNT.md`) and both of their earlier audits. I ran none of their code myself. The two agents are the same model working from one spec I wrote, so where they agree it is agreement, not independent confirmation; each did build separately and neither read the other.*

## 1. What was built

The same spec (draft 3: immutable versions, facts about them, a state as a free selection, nine consistency conditions) was built twice. In Ada/SPARK, with 328 proof obligations discharged and a random search beside them. In OCaml, as an executable model visited exhaustively over tiny universes, tens of millions of states per property. Both built the five invented moves from core as far as the spec could express them.

## 2. What is now known, and how well

| | what | how well |
|---|---|---|
| a | Whether a selection is consistent, and what it owes, can be a pure function of the selection and the record. | Built twice. It is what made everything else checkable. |
| b | Consistency is well defined (a greatest fixed point exists) **provided no question, promise or waiver is conditioned on whether something is consistent or how well it stands.** With such a condition, one piece and one decision have no answer at all. | Proved in Ada for every ontology of the bounded types; the counterexample found independently by both. |
| c | Adding good news (a check that holds; an acceptance; an affirmation) never makes anything newly owed, under three conditions: the reading of evidence is monotone; "these two versions are the same" is only ever said of good news; (b) holds. | Proved in Ada; each condition has a small counterexample when dropped; 118 million additions in OCaml without a failure. |
| d | A defect found in a piece cannot be shed by rewording, splitting or replacing it, **if the replacement is recorded as descending from it.** The same content entered as a new piece sheds it. | Proved for recorded descent; the hole shown by both. |
| e | Two repairs in different places do not interfere when the things each one reads do not meet. What a condition "reads" is wider than I had written: it includes everything a piece descends from and everything that could hold it. | Tested by both, zero failures on the wider reading; not proved. |
| f | Holding is not resting, confirmed from the other side: where a required slot is made to need a *consistent* filler, every document becomes a meeting place again. And one piece of evidence that read two parts of an outline joins two otherwise unrelated repairs there; evidence part by part does not. | Shown by example in both. |
| g | Of three ways to say what is canon: "placed in the outline" admits every state the other two admit. "Decided by someone" and "meets a rule" each admit states the other refuses. | Measured over 200,000 random cases (Ada) and 38 million states (OCaml). |

## 3. What draft 3 got wrong, which you had already said

I took "not append-only" too far and removed order altogether. Both builds found the cost independently.

- **Nothing can be answered once.** A selection has no "later", so a defect found at one version must be met again at every other version for ever: one new fact per old finding per edit. The Ada agent's words: "the guard is for ever, and I think that is the price of having no history."
- **A wrong finding cannot be undone.** With facts that only accumulate and no order among them, evidence against a finding is a standing conflict, never a correction. Core's own example of a wrong finding being set aside with the piece untouched could not be expressed.

Your statement this evening has both things draft 3 was missing and the thing it got right: "there should be causal ordering, fwiw, definitely a clock and an addative base--- event sourcing style ---  but one that allows multi-step serial parts to be part of a logically simultaneous change and that distinct from the steady-state checkpoints *AND* the ability to rewind / unstage / fork at a checkpoint".

Put together with what the builds showed, I think the shape is this, and it is not new machinery; it is how version control already works, with one addition.

1. **The base is events, ordered and only added to.** An event writes a version, records evidence, or records a decision. Each has a time.
2. **A checkpoint is a stationary state.** The verisectorium, at any moment, is its latest checkpoint.
3. **Work is a fork from a checkpoint.** Events on a fork are in order. The fork can be rewound to any earlier point on it, or abandoned. Nothing on a fork is the verisectorium.
4. **A fork that reaches a stationary state can become the next checkpoint.** From outside, that is one logical instant, however many events are inside it.
5. **A state is what its own line of events adds up to**, from the root through the checkpoints and along its fork. Events on abandoned forks are in the base and in nobody's line.
6. **The addition: evidence is about a version, so it can be taken from one fork to another.** What was learned on a dead end about a version that the live fork also has is still true there. That is the part of draft 3 worth keeping, and it is why going back loses work and not knowledge.

With order restored, a finding is answered once, by a later event on the same line, and a wrong finding is corrected by a later event. With forks, a half-finished repair can be backed out. With (6), (a) through (g) above carry over unchanged, because each of them is about the function from a state to what it owes, and that function is the same.

## 4. Canon, in your terms

You said: "canon is whatever the verisectorium says it is-- usually the main outline's non-provisional slots"; that sometimes more than one outline is marked as a canon root; and that a whole canon can be marked "not canon anymore --> influx to new corpus", which is what is intended for AAT.

That answers the question I had left for you. An asf segment sitting in a non-provisional slot of the main outline is canon, whatever its `stage:` field says. It also matches (g): placement is the weakest of the three standards and contains the other two. A decision by named people, or a rule over the evidence, is then something a verisectorium may ask *in addition*, as one more question about a piece, for the purposes that need it.

Three consequences, each of which I think is right and none of which I have tested:

- **What a piece is held to depends on which outline reaches it.** You said the determinants that matter come from the projection's purpose and audience. So the frontier is computed per canon root: a result can owe nothing as part of the theory and owe a citation check as part of a paper.
- **Marking a canon as no longer canon is an event like any other**, visible, and after it nothing there owes. Both agents flagged "un-assert it" as the one exit that always exists. As a deliberate, recorded act by whoever marks the roots, I think that is correct and not a hole.
- **The one real error in the first built instance was hidden because a strict standard kept the wrong piece out of canon.** Under placement that cannot happen: if it is in the outline, it owes.

## 5. Four rules that fell out, about what an ontology may declare

These are not mechanisms. They are things the builds showed an ontology must not do, each with a counterexample behind it.

1. A question, a promise or a waiver is unconditional. (b)
2. Evidence records what it read, and a check that needs two things read together is recorded as such, because it will not survive either changing. (f)
3. A slot may require that something fills it. It may not require that the something be consistent. (f)
4. A decision about a piece at a version holds only while the piece is at that version. (OCaml: otherwise an acceptance of a version nobody uses can be cited by anything.)

One hole neither build can close from inside: descent. If a piece is replaced and the replacement is entered as new, nothing ties them (d). Your rule that nobody edits by hand is what closes most of it, since the tool does the replacing and can record it. Material re-entered from outside with the same words is the remainder.

## 6. What this changes in what you have

- **Note 22, Part 4** says a state is a selection and only the sequence of changesets is added to. That is corrected by §3 above: there is an ordered base of events, and forks. The rest of note 22 stands as written, with (b), (f) and rule 4 as amendments to its nine conditions. I have put a dated line at its head saying so.
- **Core** is still the larger, older thing. Nothing from today's formal work has been written into it.
- **The kernel spec** is at draft 3 and is now known to be wrong about order. Both builds are parameterized, and the Ada proofs of (b), (c) and (d) are about the function from a state to what it owes, so they should carry over to a draft with events and forks. I have not asked either agent to do that.

## 7. What I would do next, and what I would not

One thing: revise the spec's account of change to §3 (events, checkpoints, forks, evidence portable between forks), keep everything else, and have both agents re-run. It is a small change to what they built and it tests the one part of this note that nothing has tested.

What I would not do: add anything to core, or answer the builds' remaining findings one by one. They are in the two accounts, and most of them are about wording in a spec that is about to change.

## 8. After the re-runs on draft 4

Both agents rebuilt on the spec with events, forks and checkpoints, and I read both new accounts whole. They did not read each other's.

**The result to keep.** What is owed about a set of pieces depends on nothing outside what those pieces read. In Ada this is proved (656 checks), for every ontology of the bounded types and with no condition on it, about the function from a state to what it owes. Two consequences are proved with it: if two forks each leave their own part stationary and the parts cover everything, the union is stationary; and whatever the union still owes is about a piece in neither part. In OCaml the same thing was tested on events directly: an event that changes nothing a piece reads left what that piece owes unchanged in 19.8 million checks; 690,000 pairs of forks that did not meet all closed; every one of 87,000 owed items in failed merges sat on a piece that read something from both forks. The Ada agent's judgment, which I share: this does not depend on how defects or canon are decided, only on each condition being computed from what one piece reads, so any later draft that keeps that shape keeps the theorem.

Three limits. The proof stops at the state: the layer that reads a state from a line of events is tested and not proved. The result says where to look after a merge, not that a repair confined there exists, and "a piece that reads both" can be far downstream of where two forks met. And it is conservative: most forks that meet can close anyway.

**What "meet" is.** Both builds arrived at the same thing from different sides: something of one fork reads a piece the other changed, where a piece can change in whether it exists, which version it is at, or what is recorded about it. An outline that reads of its parts only that they exist is not a meeting place for repairs to two of them. One that was read whole, as one fact about two parts, is.

**The split I was unsure of leaks in one place**, and both found it. Evidence is in the base and has one time; whether it counted *when recorded* is a question about a line. As I worded it, a check of a draft made before the fork has that draft does not count, where the identical check made after does; and a fork that writes, is checked, rewinds and writes the same thing again is not stationary. Core's own advice is to check a piece before accepting it, so the wording is wrong and the intent is clear: a check counts wherever its version is, whenever it was made.

**The wording of when a found defect still stands has four holes**, all in the layer that could not be proved. An old pass on a criterion answers a new finding at birth (my error; "later than the finding" was meant). A finding against a draft that was then rewound leaves nothing behind. Putting a defect back after it was answered, then editing, sheds it under one reading. And rewriting something a finding had read makes the finding stop applying. The last was found by search and not predicted. I have not tried to restate the rule; each builder offers a wording, and the right one should come from what the rule is for, not from patching four cases.

**Smaller things both found.** A checkpoint is stationary as of when it closed: evidence arrives everywhere at once, which I think is right. Un-marking a root can make other pieces owe. Setting a finding aside is a general exit and should be shown with a checkpoint as a waiver is. Consistency's fixed point is the greatest one and not the only one.

**Decisions that are the model's, not the spec's.** Whether two forks may close because the merged state happens to be stationary, or only because they do not meet: the first is cheaper and has a hole in which the answer turns on which of two writes has the later clock time. Whether what an outline reads of its parts is declared by its kind. Whether a slot marked provisional counts as filled because some other root reaches what is in it.

## What I have not done

Read the agents' code beyond a sample, or run it. Checked their counts. Read the two real-root runs against any of this. Tried §3 or §4 on anything.
