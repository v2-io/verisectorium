# The model seen from Lean 4

*2026-11-10/11, by the Lean fork of the formal-perspectives spike (Fable 5.2). It started from `../01-common-reading.md` (the small model M0 and note 22's example) and the six G-L guesses in `../02-guesses-before-running.md`. Nothing here is a fact about the model until it is adjudicated in core, and nothing here proposes a mechanism.*

## Corrections after the independent read (added 2026-11-11)

`../de-novo-feedback-1.md` §9 makes four points about this directory. I accept all four. The text below is left as first written; read it with these.

- **§2 overstates the checkpoint.** `Written.fuel` bounds how far canon is followed and is a number someone fills in. With too small a number canon is cut short, the frontier under-reports, and a `Checkpoint` can then be had for a state that owes (the reader built one for the 08:30 state with `fuel := 1`; I did not re-run it, and it follows from the definition). So "cannot be built without a proof that its frontier is empty" is true of the frontier *as computed with that number*, and "computed, never typed" had one typed number under it. `good_news` and the story are unaffected. `msc/scratch/idiomatic-slice-2026-11-11/lean.lean` does canon the way it should have been done here: the bound is read from the store, and a theorem ties the computed list to canon's definition.
- **§4 is about an abstract step, not about `Model.lean`.** `Fault.lean` takes an arbitrary `own` and `rests`. `Model.lean` does not import it, and no theorem says that `Model.lean`'s bounded `faulty` is that reachability. "Not a fixed point that has to be chosen" is proved of the step as the spec states it, in the abstract, and is unproved of M0's own function and of the spec's (waivers, effective warrant).
- **§8's "forces one choice" returns its own premise.** The construction makes sameness an equality under a view, and Lean's quotient closes whatever relation it is given. So what is shown is: *if* sameness is equality under a view, chaining is free. It is not shown that a mind's attestation is of that kind, and "one attestation in the chain was wrong" does not answer the worry about carry upon carry, where each can be right of its two versions and the ends still differ. That worry stands.
- **Mutation 3 cannot fail to fail.** It shows only that the lemma has a hypothesis. The real counterexample is `more_record_can_owe_more`, in the build.

## What Lean is, in one paragraph

Lean is a language in which a statement is a type and a proof of it is a value of that type, checked by a small kernel. "Proved" below means the kernel accepted it. It is not a search and has no bound: a theorem here about "every state" is about lines and bases of any length over any set of pieces. Its cost is that every statement has to be made exact before anything can be said about it, and that is where most of what follows came from.

## What was run

Lean 4.35.0, core library only (no Mathlib), installed at user level with `elan-init --no-modify-path`. Seven files, 1,273 lines, built clean by `lake build`; whole output in `runs/10-full-build.log`. To re-run: `./run.sh` in this directory.

| file | what it holds | standing |
|---|---|---|
| `Vk/Model.lean` | M0 as a function: a state is a line and a base; the frontier is computed from it; a checkpoint is a value carrying a proof that its frontier is empty | definitions; compiled |
| `Vk/Story.lean` | note 22 §4.3, all ten rows, the frontier at each pinned as a statement | proved, by evaluation in the kernel |
| `Vk/GoodNews.lean` | recording evidence that holds adds nothing to the frontier | proved for M0, any number of pieces |
| `Vk/Fault.lean` | what kind of definition "consistent" is; the three small pathologies; the skeletons of the frame property and of good-news | proved, no state involved, any number of pieces |
| `Vk/Refusals.lean` | which definitions of "consistent" Lean accepts and refuses, each refusal pinned so the file stops compiling if Lean's answer changes | checked by the compiler |
| `Vk/View.lean` | "these two versions are the same, for this evidence" as a quotient | proved; a construction beside M0, not wired into it |
| `Vk/Tiers.lean` | note 22's `derived-result` kind as a type; where typing stops | proved; one kind only |

Three mutations in `mutations/`, each of which must fail and does (`runs/11-mutation-*.log`): a pinned frontier with one item removed; a checkpoint at 13:00; the good-news lemma used without "holds".

What was only argued or is a guess is marked so where it appears. Intermediate failed attempts were not kept as logs: `Fault.lean` went through on its first run, the story's pins on the second, `GoodNews.lean` on the seventh.

**What M0 in Lean leaves out** beyond what the common reading already cut: `same` events (they are in `View.lean` only), promises, waivers of anything but a named item. And four readings I had to take: a guard needs the finding's version to have been written on this line; a finding is answered by later evidence that applies *now* (no "applied when recorded"); a check that read a reference's target counts as having reconciled the reference; a write records what it was made beside, for inner dependencies as well as references.

## What the model looks like from here

### 1. Running the example found three places where the prose and the conditions disagree

The right-hand column of note 22's table was written by a mind and the conditions are a definition. Read mechanically, the conditions give that column exactly at 08:30, 10:00 ("as at 08:30": the two frontiers are equal, with one more fact in the base), 11:00, 11:30, 12:00, 13:00 and 14:00. They differ at two rows, and one thing is left open.

- **09:00, the first repair.** The note says "c1′ is fine." By the note's own rule (§3.3: a defect once found is presumed still there until looked for), it is not: the auditor's case was found in c1 and B's check of c1′ was a check that it follows, not a look for that case. Also owed there and not mentioned: e1 has not been looked at beside c1′, and T has not been read whole.
- **10:30, the second repair.** The note lists four things and the conditions give them. They give two more: the auditor's case has not yet been looked for in c2 (it is at 11:00), and u's check read c1 and so says nothing now.
- **Whether S1 is reached depends on something the story does not say.** The kind declares that the eli8 depends on the description. At 10:30 A rewrites the eli8 (k2) and affirms the description. Nothing says k2 was looked at beside e1. If writing k2 counts as having looked, S1 is reached at 14:00. If it does not, one item is left and the fork cannot close (`row9B`). Core's «changeset» asks for a look only at what depends on a piece that *changed*, and the description did not change, so by core nothing is owed here; note 22's condition 6 ("looked at together as they now are"), read as a condition on a state with no memory of what changed, does not say.

None of these is a fault in the model. They are what "computed, never typed" is for, seen on the model's own example.

### 2. A checkpoint as a type that cannot be filled in by hand

`Checkpoint` is a state together with a proof that its frontier is empty, and `close` is the only way to make one. There is no field in which the word "stationary" could be written. S0 and S1 exist; asking for a checkpoint at 13:00 is rejected by the compiler, because the proof it would need does not exist. This is the lead's guess G-L2 and it held without strain.

It also made one sentence of the model exact. A checkpoint's proof is about the state it was built from. S0 with the 08:30 finding in the base is *another state*, and it is proved not stationary (`S0_after_the_finding`), with no event on any line. S0 itself is still a checkpoint. So "the checkpoint was stationary when it was reached and is not now" is two statements about two states, both true, and the Ada account's G5 is how a typed reading says it without effort.

Asked what S1 rests on, Lean answers: the definitions, and one axiom of logic. The trust placed in B's checks is not in that answer, because B's checks are data the proof is *about*. That is «steady·state»'s sentence: it "promises that nothing in canon outruns the record, and does not promise that the record was enough."

### 3. Evidence is not proof, and Lean will not let it be

I expected (G-L5) that Lean would have no native way to say "owed". That was wrong: the frontier is an ordinary function on two lists and Lean says it easily. What Lean refuses is narrower and more useful.

In Lean, evidence for a statement is a proof of it, and proofs have two properties the model's evidence lacks. A proof cannot be wrong. And more hypotheses never unprove anything, whereas more on record can mean more owed (`more_record_can_owe_more`, proved from the story's first two rows). So the model's evidence cannot be put where Lean puts proofs. Everything a mind does, a check as much as a decision, lands as *data*: a record that someone said something. The only things that are propositions with proofs are the engine's own statements about that data (this evidence applies; this frontier is empty).

So from here the two atoms are not "proof" and "choice". Both are attested records, and they differ in what the computed layer does with them. And "the formal spec as types" certifies the bookkeeping and never a claim. I think that is the right ceiling to state plainly before anyone hopes for more from a typed core.

One line the base-and-line split leaves in the proofs: the first thirteen lemmas in `GoodNews.lean` have the proof `rfl`, which means "true by unfolding definitions". They say that selection, canon, what was written beside what, set-asides and waivers are read from the line alone. Canon by placement is, in this reading, a fact about what a function takes as input, not a rule.

### 4. "Consistent" is not a fixed point that has to be chosen

The spec defines consistency as a greatest fixed point, and both builds report that it exists and is not the only one (R7). In `Fault.lean`, with no state at all:

- Define **fault** the plain way: a piece is at fault when it has a violation of its own or rests on a piece at fault. Then fault is reachability: a piece is at fault exactly when something it transitively rests on has a violation of its own (`fault_iff_reach`).
- "Not at fault" is a fixed point of the spec's step, and the greatest one (`noFault_fixed`, `noFault_greatest`). Lean's own built-in greatest-fixed-point definition of the spec's sentence is proved equal to it (`cons_iff_noFault`).
- The other fixed points are real (`ring_empty_fixed`: two pieces resting on each other, nothing wrong with either, and "neither is consistent" is a fixed point). Read as fault, that one says: each is at fault because the other is. It is a fault with no reason behind it.

So when a piece's own violations do not depend on which pieces are consistent, which the spec's "obligations are unconditional" guarantees, nothing has to be chosen and nothing has to be proved to exist. Note 22's condition 5 already says it in the plain form's spirit; core's older wording ("unsettledness spreads along what rests on what") is the plain form. The fixed-point language came in with draft 3, where decisions could be conditioned on consistency, and outlived the reason for it. This is all for any number of pieces, and most of it uses no axioms.

### 5. What Lean demands before it will define consistency, and what that separates

When own violations *may* depend on consistency, Lean will define the greatest fixed point only if it can see that the definition is monotone. `Refusals.lean` pins what it does with the builds' cases:

| the case | what the builds found | Lean |
|---|---|---|
| a question in force while its own piece is consistent | no fixed point | **refused**, as a definition of fault (positivity) and of consistency (monotonicity) |
| two questions, each in force while the *other* piece is consistent | two fixed points, no greatest | **refused**, though fixed points exist (`mutual_raise_both_exist`) |
| a waiver in force while its own piece is consistent | lumped with the above by the rule | **accepted** |

The exact condition, proved in general (`gfp_fixed`): a greatest fixed point exists whenever assuming more pieces consistent never *creates* a violation. Questions and promises conditioned on consistency fail it. A waiver conditioned on consistency meets it.

So the spec's rule (a question, promise or waiver is unconditional) covers two different things. For questions and promises it is what well-definedness needs. For waivers it is not needed for that. But look at what is then accepted (`selfWaived_consistent`): a piece with a defect, consistent, on the strength of a waiver that holds because the piece is consistent. "Not consistent, and the waiver not in force" is a fixed point too, and the greatest fixed point picks the lenient one. Whether the model wants that is not Lean's to say. What Lean shows is that the reason to forbid a conditioned waiver, if there is one, is that a state should not stand on a circle, and not that the definition breaks. That is a different reason from the one on record, and I think it should be the one on record. (That the rule is blunter than well-definedness needs was the lead's guess G-D5 for the Datalog side; this is the same thing reached independently by a different check.)

Lean's test here is the monotonicity of a definition, which is a property of an ontology's rules and can be checked once, before any state exists.

### 6. Good news does no harm: the shape of the proof is the model's own table

`good_news`: for every set of pieces and criteria, every ontology and version table of M0's shape, every line and base, and every piece of evidence that holds, recording it puts nothing on the frontier that was not there. Proved; and a checkpoint therefore stays stationary under any amount of good news.

This is R6 at any size, which neither build has, but for a model much smaller than the spec. M0 has no warrant levels and no `same` events, and those are exactly the two things the builds' remaining conditions are about (`read_as` monotone; `same` only for good news). So no condition was needed here, which agrees with them and adds nothing about those two conditions.

What is worth seeing is how the proof goes. It has one case per kind of frontier item, and every case is one of three sentences:

- *it is read from the line, and evidence is not on the line* (a missing target; resting outside canon);
- *it only becomes more true as evidence is added* (looked at together; the root's ask; a guard answered; a question answered);
- *the new evidence holds, so it is not a finding*.

After that, fault and the frontier follow by induction with no further idea (`fault_mono` is the same step with no state). So "good news does no harm" is not one property. It is a column in a table of (kind of event) by (kind of item), saying which way each moves the other, and the table could be written for every event. A set-aside, which the Ada account found is not good news, would show in that table as moving items both ways.

### 7. The frame property has no content beyond the reading list

`frame` and `forks_compose` in `Fault.lean`: if two worlds agree, on a region closed under resting, about own violations and about what rests on what, they agree there about fault; and two forks that each agree with the merge on a region, the regions covering everything, merge fault-free. Proved for any number of pieces, no axioms, a few lines each.

This is only the skeleton of the Ada build's theorem. All of that theorem's work is in showing that each of fifteen kinds of item reads a named neighbourhood, and I did not redo that for M0. What the skeleton shows is that once consistency is reachability, nothing else is hidden in the composition of forks: the Ada agent's own judgment ("the list of what an instance reads is the one thing to re-check") is right, and exactly right.

### 8. "The same, for this evidence" is a quotient, and that forces one choice

G-L3 held as a construction (`View.lean`). Make evidence a family of types indexed by *what was seen*, not by the version it was seen in. Then:

- evidence found at one version *is* evidence at another whenever the two look the same; nothing is carried or copied (`same_type`);
- three things the model names separately are one thing with three ways of looking: a read that relies on existence only (every version looks the same, so such evidence never stops applying, which is why two repairs under one outline do not meet); normalization (sameness computed, nobody has to say it); and a recorded `same` fact (sameness on someone's say-so). The third uses Lean's primitive quotient;
- a recorded sameness runs backwards and chains with nothing more recorded (`attested_symm`, `attested_trans`). The spec's "reachable by same events" is what a quotient is, not an added rule;
- bad news travels along it exactly as good news does, and the type has no way to ask which it is (`carry_keeps_outcome`). Both builds found this by test;
- recording more sameness keeps everything already carried (`coarsen`). Setting a `same` fact aside has no such map, proved for the smallest case (`no_way_back`). So "un-carrying" is not an operation: the evidence is about something that is no longer one thing.

The choice it forces. If `same` means "do not differ in what matters", as note 22 has it, it is an equivalence and chains are free; core's worry about carry upon carry drifting far from what was checked is then a worry that some *attestation* in the chain was wrong, which is answered by setting that one aside. If `same` means "close enough", it does not chain, it is not a quotient, and evidence cannot be indexed by it at all. The model's words choose the first. I would hold the model to them.

This is a construction that type-checks beside M0. It is not wired into the model in `Model.lean`, and that the model's `same` *should* be read this way is my suggestion, not a result.

### 9. How far "as types instead of terms" goes

Tried on note 22's `derived-result` kind (`Tiers.lean`). Three tiers come out, as guessed (G-L1), with one thing I had not seen.

1. **Unsayable.** What kind of piece fills a slot, and how many, are in the type. An explanation in the claim slot is not a state that owes something; it is not a state. An id can carry its kind, so pointing at the wrong kind is unsayable too.
2. **Refused.** A checkpoint without a proof (§2).
3. **Owed.** Everything in the nine conditions. "Required" cannot be in the type, because a result whose claim is promised and not yet written is a state the model wants.

What I had not seen: **the states of an unfilled slot are what make the first tier possible at all.** Without *suggested*, *promised* and *gap* as values, a typed result could not exist until it was complete, and every draft would be outside the model. With them, the type can be strict about what goes where while the thing is still mostly empty. The same goes for an ontology change. Adding a required slot does not make existing results "owe"; they are not values of the new type, and somebody has to write the function that carries them over. The model's sentence ("adding a required slot makes every existing segment owe something") is true exactly because that function can fill the new slot with an empty state (`migrated_owes`).

Lean has this arrangement for its own proofs, and its middle is the model's *promised*. A proof may be left as a hole; the theorem is accepted and flagged; and asking what a later theorem rests on reports the hole, computed, with nobody having typed it (`built_on_it` rests on `sorryAx`). I found that reassuring about the slot states and the frontier both: a system built by people who care about nothing but proof ended up with the same three things.

Two limits. A *gap* whose kind is unknown cannot be a field of a record with fixed fields; it fits an outline (a list of slots of any kind) and not a kind with named slots. And this was one kind, shown, not M0 rebuilt on typed kinds and run through the story: `Model.lean` uses untyped pieces and a function that says each one's kind.

One renaming Lean would make. Versions here are values, and values are not created; the table of what each version says exists before any event. So a write does not make a version, it *selects* one, which is why evidence about a version no line has (the 09:00 check of c1′, after the rewind) is perfectly meaningful, and why core's "restoring earlier content restores the earlier version and every act that read it" needs no rule. What is not a fact about values, and so cannot be had this way, is anything about a line's past: the guard rule ("a version the line once selected") is the one place M0 has to consult history.

## What became of the guesses

| | guess | what happened |
|---|---|---|
| G-L1 | three tiers; nearly everything in the third | held; and the slot states are what make the first tier possible (§9) |
| G-L2 | a checkpoint cannot be built without a proof | held (§2) |
| G-L3 | `same` as a view; three things become one | held as a construction, not wired into M0; forces "equivalence, not closeness" (§8) |
| G-L4 | Lean refuses a question conditioned on consistency, two ways | held, both ways; and it refuses the two-question case too, and accepts the conditioned waiver (§5) |
| G-L5 | Lean has no native way to say "owed" | **wrong as stated.** It says it easily. What it refuses is evidence-as-proof (§3) |
| G-L6 | small theorems at unbounded size | held: fault as reachability, good news for M0, the frame skeleton |

## What Lean gave nothing on

Lines, forks and interleavings. A line is a list here and a fork is another list; rewinding is a filter. Lean checked what I wrote about them and suggested nothing. Whatever there is to see in two forks closing in either order is for a tool that explores orders. Likewise intake, "better", and who did anything.

## Not done

- `same` inside M0; promises; descent and retirement; warrant levels and `read_as`; several roots asking different things.
- The guard rules (the spec's R4 and R8) are run on the story and proved for nothing.
- The frame property for M0 itself: only its skeleton is proved.
- Forks composing, on M0: not attempted beyond the skeleton.
- M0 on typed kinds.
- Core's def files as Lean declarations (the KDL `rel` lines as fields). Not attempted; I do not know what it would show.

## If the formal layer of core were written in Lean

A guess, from a day's use. It would suit the part of the model that is a function from a state to a frontier, and it would be good at exactly the two jobs the OCaml account asked a proof assistant for (well-definedness by monotonicity; locality by what each item reads), since both are short here. It would be poor as the *engine*: kernel evaluation of the story took about a second for eight pieces, and nothing here is built to run at size. And it would keep doing what it did today, which is refuse to let a sentence stand until it has one reading. Three of the four findings above that I would most want Joseph to see (§1, §5, §8) came from that and not from any theorem.
