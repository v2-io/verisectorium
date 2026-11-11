# The model seen from Rocq

*2026-11-11, by the Rocq fork of the OCaml-side provers spike (Fable 5.2). It started from the earlier spike's `01-common-reading.md` (the small model M0 and note 22's example, §4.3) and from the spike lead's `../00-guesses-before-running.md`. Nothing here is a fact about the model until it is adjudicated in core, and nothing here proposes a mechanism.*

*I am a fork of the agent that built the kernel in OCaml and wrote the OCaml slice and the forced choice. I began with all of that, and I had read the opening third of the Lean fork's `PERSPECTIVE.md` (to its §3) before writing M0 here, so where this agrees with Lean it is not a second mind agreeing. I have not read the other three forks' work in this spike.*

## What Rocq is, in one paragraph

Rocq (Coq until 2025) is a language in which a statement is a type and a proof is a value of that type, checked by a small kernel. It is written in OCaml and can turn its own functions into OCaml source ("extraction"). "Proved" below means the kernel accepted it, and where I say "for every line" I mean lines of any length over any pieces under any ontology of M0's form; there is no bound and no search. It has two vocabularies that matter here: functions that compute (a list, a yes or no), and statements that say what a thing *is*. Most of what follows is about the join between them.

## What was run

Rocq 9.3.0 with its standard library and nothing else, in an opam switch of its own (`rocq-try`). `./run.sh` rebuilds everything from nothing in about 15 seconds on one process; the whole output is `runs/full-build.log`. Every intermediate compile, the failed ones included, is kept in `runs/`.

| file | lines | what it holds | standing |
|---|---|---|---|
| `Vk/Reach.v` | 164 | reaching, stated twice: as two rules, and as a function; and that they agree | **proved**, for any relation and any starting names, rings included |
| `Vk/M0.v` | 336 | M0 as a function from a line of events to what is owed; canon and "rests on" each tied to its definition | definitions; two theorems **proved** for every line |
| `Vk/Story.v` | 125 | note 22 §4.3, ten rows; what is owed at each, pinned | **proved** by computation in the kernel |
| `Vk/Checkpoint.v` | 80 | a checkpoint as a line with a proof that nothing is owed; one statement about every checkpoint | **proved** for every ontology and line |
| `Vk/GoodNews.v` | 349 | recording evidence that holds, as the latest event, adds nothing to what is owed | **proved** for M0's own function, every ontology and line |
| `Vk/Extract.v`, `extract/` | | M0 as OCaml; the story run from the extracted program | run; output in `runs/m0-extracted-story.txt` |
| `mutations/` | | three statements that must fail and do; one probe (a ring of claims resting on each other) | `runs/mutations.txt` |
| `refusals/` | | four things the slice says Rocq refuses, each with its error | `runs/refusals.txt` |
| `../../idiomatic-slice-2026-11-11/rocq.v` | 460 | the slice, with canon proved; notes at its foot | **proved**; extracted OCaml beside it |

`Print Assumptions` on each of the four general theorems answers "Closed under the global context": they rest on the definitions and on no axiom.

**What M0 here leaves out**, beyond what the common reading already cut: `same` is one step and not a chain; a slot is always filled (so a promise can only be unkept by its filler being outside canon); there is one result kind and its inner dependencies are the ontology's, not the kind's. **Readings I had to take:** a guard needs the finding's version to have been written on the line; a finding is answered by later evidence on its criterion that applies *now* (M0's wording, not draft 4's "applied when recorded"); a waived item does not count against what rests on its piece; "later" is position in the line.

**How many tries.** The slice's first, conditional theorem compiled on the second run. Its unconditional replacement on the third after that. `Reach.v` on its first. `M0.v` on its third (both failures were notation, below). `Story.v` and `Checkpoint.v` on their first; the computed frontiers were what the pins now say, with no change to the model in between. `GoodNews.v` on its fourth. By the clock files this fork began at 22:25:51 and the last of those compiled at 22:36:41. It did not feel like eleven minutes.

## What the model looks like from here

### 1. Canon is definite for every store, and now that is proved and not assumed

The model says canon is "what the roots reach through slots that are filled and not provisional". Rocq makes that two things. `Reached` says what it is: a root is reached; what something reached leads to is reached; nothing else. `reach` is a function that returns a list. Rocq will not accept a function unless it can see that it stops, and "follow the pointers" does not obviously stop: an outline can point at itself. (`refusals/follow_pointers_forever.v`: "Cannot guess decreasing argument of fix." The OCaml slice let me write that function; it ran for ever on a ring.)

So the function has to say how many rounds it will take, and a proof has to say why that is enough. The why is one sentence: each round either adds a name or changes nothing, and there are only so many names. With that, `reach_is_reached`: the list is exactly what the two rules define, for any store, any roots, dangling pointers and rings included.

Three things about this:

- **No number is typed.** The bound on rounds is computed from the line (its roots and everything its written assemblies' slots name). The earlier spike's independent reader found that the Lean model's checkpoint had "one typed number under it", a fuel that could be set too low to make a state that owes look stationary. Here there is nothing to set.
- **The spike lead guessed this would be more than a sitting** (guess 1: "needs an argument about how many rounds suffice"). It was three compiles. The standard library already had the two counting lemmas the argument needs.
- **It is the only finding of the kind guess 6 predicted** ("if one does, it will be about termination"), and it is not a fault in the model. It is the model's first sentence about canon turning out to be true as stated, with the reason written down.

### 2. "Rests on" is the same thing as canon, and that settles what a ring of claims means

Condition 5's second half is "rests only on pieces in canon that are themselves consistent". M0 reads "rests" as "is predicated on, on down". That is reaching again, along a different relation, and `M0.v` uses the same function and the same theorem for it (`rests_on_is_reached`).

Read that way there is no fixed point to choose. A piece is owed a 5 when something it reaches by "predicated on" is outside canon or has something wrong *of its own*. "Of its own" does not mention consistency, so nothing is circular. The probe `mutations/m4_ring_of_resting.v` has two claims each predicated on the other, each checked: nothing is owed. Record a finding against one of them: 4 on that one, 5 on both.

The claim with the finding is owed a 5 as well as its 4: round the ring it rests on something with something wrong, which is itself. The draft-3 and draft-4 builds asked for a greatest fixed point here. As far as I can tell from my own draft-4 code, read and not run on this case, they give the same items for this ring; so this is the same answer by a route with nothing to choose, not a different answer. What the route adds is that "consistent together unless one of them has something wrong" stops being a choice among fixed points and becomes a plain statement about what a piece reaches.

### 3. Run mechanically, the story disagrees with its own prose at two rows, and one thing in it is open

The same three things the Lean fork found, by different code:

- **09:00.** The note says "c1′ is fine." The conditions say 4 on c: the case found in c1 has not been looked for in c1′. Also owed and not in the note: T has not been read whole as it now is (5 on T), and e1 has not been looked at beside c1′ (6 on T).
- **10:30.** The note's four items, and 4 on c again: the case has not yet been looked for in c2. It is at 11:00.
- **Whether the fork can close at 14:00 depends on whether writing k2, with e1 already there, counts as having looked at the two together.** If it does, nothing is owed. If not, 6 on T, from 10:30 to the end. `Story.v` pins both readings (`looks`, `strict`).

Every other row is the note's column exactly; 10:00 is proved *equal* to 08:30, not merely alike (`at_1000`), and the abandoned check E6 is proved to change nothing on the line that no longer has c1′.

I do not count this as independent confirmation. I knew what Lean had found before I ran it.

### 4. Good news does no harm: proved of M0's own function

`good_news`: for every ontology, every line, and every piece of evidence that holds, whatever it is about and whatever it read, appending it adds no item to the frontier. This is about `frontier` as defined in `M0.v`, the same function the story runs on, with waivers and "rests on" in it. The earlier spike's reader noted that Lean's fault and frame results were about an abstract step not linked to its model; this one is linked, because there is only one function.

The shape of the proof says something about the model that the theorem does not. It is in two halves:

- **What evidence cannot touch**, as twenty-three small equalities: which version each piece is at; what has been written; canon; what each piece rests on; what each reference was written against; every affirmation; every waiver. Evidence leaves all of these exactly as they were.
- **What evidence can only help**: conditions 4, 5, 6 and 9 each ask "is there evidence such that…", and a longer record has at least the evidence a shorter one had. Conditions 1, 2 and 8 do not read evidence at all.

The first list is a piece of the "what does each kind of event change" table that I wrote by hand in the OCaml explorer (`reads_graded`, `effects`) and called the thing I would most dread maintaining. Here it is one row of that table, for one kind of event, as lemmas the kernel checked. Each lemma is two or three lines.

**What it does not say.** Evidence recorded *last*. Evidence that holds only. M0, not the kernel spec: no warrant levels, so no question of `read_as` being monotone; no chains of `same`. A `same` event is not evidence here and the theorem says nothing of it.

### 5. A checkpoint cannot be had without its proof; and what that does and does not survive

`checkpoint O` is a line together with a proof that its frontier is empty. S0 and S1 are checkpoints. Asking for one at 13:00 is refused (`mutations/m2`, and a `Fail` in the file). S0 with the 08:30 finding appended is a different line and `close` refuses it; S0 is still a checkpoint. `at_a_checkpoint_nothing_is_known_wrong` then says something of every checkpoint there could be: for anything in canon, no finding applies and every defect found in a version the line once had has been looked for since and not found, **unless waived**; `mutations/m3` builds a checkpoint with a waived finding to show the "unless" is doing work.

Two limits.

- **What the proof is of.** That the *function* `frontier` returns nothing. For canon and for "rests on" the function is proved to be the thing it computes. For the conditions themselves it is not: each is only a function, with its sentence in a comment above it. So this checkpoint is "computed, never typed", and what it computes is, for seven of nine conditions, whatever I wrote.
- **It does not survive extraction.** In the OCaml that Rocq produces, `type checkpoint = line` (`extract/m0_extracted.mli`, line 192). The proof is erased, as proofs always are. Nothing in the extracted program stops a caller making a "checkpoint" from any line at all, unless someone hides the type by hand in the interface. "Cannot be typed by hand" is true inside Rocq and is an engineering matter again the moment the code leaves it.

### 6. Refused and owed are two different mechanisms here, and both can be kept in the file

A state that cannot be written is a type error. A state that owes is a value with a non-empty frontier. A claim that is false is a statement with no proof. Rocq's `Fail` keeps all three kinds of "no" as checked facts: if a later version of the model starts accepting a step in the claim slot, or a checkpoint at 13:00, the file stops compiling. That is the model's own distinction between refused and owed, with a third (not so) beside it, and I found it natural to say.

### 7. What Rocq could not say, or said badly

- **Who is who.** Pieces, versions, slot names, criteria and evidence names are all `string`. `piece` and `version` are two names for one type and the checker will take either for the other. This is the same fault as the `int`s in my OCaml build and I repeated it for the same reason, haste. Distinct types would cost a decidable equality each.
- **The base growing under a checkpoint** is not a thing that happens to a value. It is two lists. The model's "was stationary when reached and is not now" is two true statements about two lines, as Lean found.
- **Nested holding.** In the slice, an outline that holds outlines makes a type Rocq cannot reason about without an induction principle written by hand. I cut it out. That was for the prover's convenience, not the model's.
- **Content.** A string, compared and printed. As everywhere.

## What became of the guesses

| guess (`../00-guesses-before-running.md`) | came to |
|---|---|
| 1. The slice goes through in a sitting | Yes, on the second compile |
| 1. A proof that the function is always complete is more than a sitting | **Wrong.** Three compiles |
| 1. The M0 story runs inside Rocq by computation | Yes; 0.01 s for the last row (`runs/timing-inside-rocq.txt`) |
| 1. Extracted OCaml is readable | Yes for the types and the conditions; the instance comes out as nested constructors |
| 1. …and as fast as hand-written OCaml doing the same thing | Within a factor of two, on the slice's canon; the gap has a cause I can see (the extracted function recomputes the list of assemblies on each call, and my hand version did not) |
| 1. The types lose the kind of a veritoid on the way out | Yes, and the checkpoint's proof too |
| 6. No tool finds something about the model the builds and the first spike did not; if one does, it is about termination | For Rocq: what it pressed on was termination, as guessed, and what came of it was a proof and not a fault. Nothing new about the model |

## Numbers, in one place

| | |
|---|---|
| install, from an empty switch | 3 min 55 s for the compiler and Rocq (`../install/rocq-clock.txt`) |
| clean build of everything here | about 15 s |
| one frontier (the last row, 29 events) inside Rocq | 0.01 s |
| the same from extracted OCaml | 20,000 in 1.83 s (92 µs each) |
| slice canon, an outline of 200 results | extracted 2.66 s; the same rounds by hand 1.27 s; a walk with a set 0.0002 s |

The last row is the honest cost. The function that was easy to prove is cubic. Extraction did not make it slow; choosing something provable in a few minutes did.

## What I did not do

Prove any of conditions 1 to 9 against a statement of it (only canon and "rests on" are said twice). Prove anything about bad news, about writes, or about two forks. Prove good news for evidence recorded anywhere but last. Put warrant levels, chains of `same`, descent, or empty slots into M0. Drive the extracted model from the existing OCaml explorer. Prove a fast canon. Use any proof automation beyond `lia`. Read the Why3, Cameleer or E forks' work.
