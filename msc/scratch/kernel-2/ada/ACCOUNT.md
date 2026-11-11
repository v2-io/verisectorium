# Account: KERNEL-SPEC draft 4 in Ada 2022 + SPARK

*2026-11-10, by the Ada/SPARK agent (Fable 5.2). For the lead and for Joseph. Built from `KERNEL-SPEC.md` at `5e2cffd`. Nothing under `core/` and nothing in the spec was changed. `ACCOUNT-draft3.md` beside this file is the account of the draft-3 build (its sources are at `038c7fa`, its tests in `draft3-tests/`, its runs in `runs/draft3/`); `SPEC-AUDIT.md` is the audit of draft 1. I have not read the OCaml agent's accounts or code. Toolchain: GNAT 16.1.0, gnatprove 16.1.0 at level 2, Alire 2.1.1.*

Nothing here is a fact about the model until core adjudicates it. Each finding names the clause of the draft it is against.

## The result I would put first

**What is owed about a region of pieces depends on nothing outside the region. Proved.** If two states agree on a region, in a sense spelled out below and computable, then every constraint instance about a piece of the region is violated in one exactly when it is in the other, and waived in one exactly when in the other (`Vk.Merge.Frame`). Two corollaries, both proved:

- **Forks compose** (`Forks_Compose`). Take two forks A and B and their union M. Let RA be a region on which M agrees with A, and RB one on which M agrees with B. If RA and RB between them cover every piece, and each fork is stationary on its own region, then M is stationary.
- **A meeting is local** (`Meeting_Is_Local`). Whether or not they cover everything: anything M owes, unwaived, is about a piece in *neither* region. Resolving there is enough.

This is R9 and R12 in one statement. It holds for every ontology of the bounded types, with no condition on it: not monotone `read_as`, not unconditional obligations, nothing about roots or switches. A and B need not have come from one checkpoint; they are any two states.

"Agree on a region R" (`Vk.Frames.Member_OK`) asks, of each piece p in R:

1. p is selected at the same version, and is in canon in both or neither;
2. everything p's version refers to, holds, points at or makes a standing claim about is in R too, **except** that a target reached only by an edge that reads nothing but existence (relies on existence, caps nothing, needs no warrant; a plain pointing slot is one) need only exist in both and be in canon in both, at whatever version;
3. the evidence about p is the same rows, set aside in the same cases, and what each read is in R;
4. the decisions about p are the same rows, and the pieces their conditions and affirmations name are in R;
5. what the line says of p is the same: its open guards, what its version was written against, which marked roots reach it (and their kinds), and whether anything it holds is held elsewhere.

Read the other way, that list is the definition of two forks **meeting**: some single thing of one fork (a reference, a read of a piece of evidence, a decision's subject or condition, a slot, a root's reach) reads a piece that the other wrote, retired, or moved in or out of canon. The lead observed that this is the read-set against write-set condition of transaction processing; I think that is right, and have likewise not checked it against a text.

Three things to hold beside the proof:

- **It is about the function from a state to its frontier.** The layer that reads a state from a line (`Vk.Lines`: who is selected, which guards are open, what a root reaches) is executable and tested, not proved. But item 5 is a *hypothesis checked on the actual states*, not an assumption about that layer: the search computes the largest agreeing regions for 100,000 real pairs of forks and compares frontiers. On no instance in any region did the union's frontier differ from the fork's; of the 37,306 pairs whose regions covered every piece, none met.
- **It is conservative.** It says where to look, not that something is there. In 56,122 of the 100,000 pairs the regions did not cover everything and yet nothing new was owed. Random scenes are far more entangled than real ones (a region averaged 2.1 of 5 pieces), so that proportion says little about practice.
- **A shared outline is not a meeting place**, by clause 2: in scenario 4's plain case the outline is in *both* regions though each fork rewrote something it points at. It becomes one exactly when something reads two of its parts at once (a whole read as one fact), which is draft 3's finding, now with its reason.

## What exists

| file | lines | what |
|---|---|---|
| `src/vk.ads` | 296 | the objects of §2 and §3 as bounded tables |
| `src/vk-model.ads`, `.adb` | 794 | §4 and §5: the function from a state to its frontier. SPARK |
| `src/vk-lines.ads`, `.adb` | 405 | events, lines, union, rewind, and the state read from a line as of a time, with ordered guards. Not SPARK |
| `src/vk-frames.ads`, `.adb` | 205 | what it is for two states to agree on a region; the largest such region. SPARK, executable |
| `src/vk-lemmas.ads`, `.adb` | 879 | proofs of R6, R7, R8 and the cap |
| `src/vk-merge.ads`, `.adb` | 1217 | proofs of the frame theorem and its two corollaries |
| `tests/src/scenarios.adb` | 750 | the five moves as forks that close, seven two-fork cases, eight probes: 110 stated expectations |
| `tests/src/search.adb` | 788 | random search for R6, R7, R8, R9 |

```sh
cd msc/scratch/kernel-2/ada
alr build && alr gnatprove            # 656 checks, all proved; 4m18s from a clean session
cd tests && alr build
./bin/scenarios                       # 110 expectations, 0 failed
./bin/search 100000                   # about four minutes
```

Run `alr gnatprove` on its own: a build of the tests at the same moment makes it report a spurious "unsupported recursive subprogram" and stop.

Bounds: 5 ids, 3 versions each, 2 dimensions, 2 criteria, 4 warrant levels, 3 reference kinds, 12 evidence facts, 12 decisions, lines of up to 40 events. A proof is for every ontology, version table and state of those types satisfying its stated condition. A search result is a sample of 100,000 random scenes from a fixed seed.

## The table

| | status | by what | condition, or counterexample |
|---|---|---|---|
| **R1** State is a function of line and base | **by construction** | no unit has state; a line is a set of timed events | under the reading in G1 |
| **R2** Abandoned work is inert | **by construction**, with two exceptions found | a line's state reads its own events and the base | a rewind erases that a version was ever tried (G3) |
| **R3** Going back | **characterized**, shown in probe P3 | after a rewind the state is what it was plus later evidence | a return is not stationary exactly when a finding recorded since applies to, or guards, what was returned to |
| **R4** Answered once | **holds as built**, scenarios 1 and 3 | later rewordings carry no guard; re-selecting the old version brings the finding back | by the letter of §4 it holds too easily (G2) |
| **R5** A wrong finding has a way out | **holds**, scenario 3 step 4 | a set aside on the fork; the piece is never written | a set aside is not good news (G8) |
| **R6** Good news does no harm | **proved** for the state function; **tested** for events on a line (holding evidence, an affirm, an accept: 100,000 each; a same event: 11,254; 0 counterexamples) | `Good_News` | one condition left on the ontology: `read_as` monotone (3,292 counterexamples without it). Same events only for evidence that holds |
| **R7** Consistency well defined | **proved**: a greatest fixed point is reached | `Well_Defined` | with obligations unconditional, no further condition. **Not unique**: 66 of 100,000 states had more than one fixed point (probe P6) |
| **R8** A defect survives | **tested**, 30,739 cases, 0 counterexamples, in the mode built; an open guard is owed, **proved** | search; `Guard_Is_Owed` | three ways out by the letter of the draft (G2, G3, G4), each a switch |
| **R9** Forks compose | **proved**, both forms | `Forks_Compose`, `Meeting_Is_Local` | the spec's two cases are not the whole of it (G6) |
| **R10** Canon by roots | **shown**, probe P5 | | "removes its items and nothing else" is false (G7) |
| **R11** Checkpoints | **by construction** of close | a fork closes only if stationary | stationary *as of when it closed*: G5 |
| **R12** Locality | **proved** | `Frame` | narrower than draft 3's reading in two ways and wider in one (G9) |

## Findings against draft 4

**G1. A line cannot be both "in time order" and "appended to" (§3, §6).** A fork that closes second has events earlier than the main line's latest. Appended with their times, the line is out of order. Appended with new times, evidence (in the base, its time fixed) no longer "applied when recorded": probe P7 shows a fork that was stationary and a main line that is not, the moment it closes. Merged by time, the main line's past changes. *Reading built, and agreed by the lead*: a line is a set of timed events, the order is time, a state is read **as of a time**, a checkpoint is a snapshot of the set, and closing is set union. Then "either order, same state" is free, and R9 is only about whether the union is stationary. "As of a time" also replaces §3's "up to the line's latest time", under which an idle line never sees new evidence.

**G2. By the letter, an old pass meets a new finding (§4, guards).** "Met … by evidence on the same criterion that holds at any version of p the line selected at or after v" does not ask that the evidence be later than the finding. Probe P1: p passed criterion 1 once; later it fails criterion 1; reword it, carry the old pass: stationary, the defect never looked at. Three events and two facts. In the search, 291 guards that stand under "later" count as met by the letter. The lead says "later" was meant; it is the mode built (`Mode => Later`), the letter is the switch.

**G3. A rewind erases a finding's footing (§4, §6; R2).** A guard comes from a finding against "a version the line once selected". Write a draft, have it found wrong, rewind, write it again reworded: the flawed version is one "the line never selected", and there is no guard (probe P2). The evidence is in the base and means nothing to the line. This is the one place the split of §0 is not clean: what a line *tried* is knowledge the base cannot hold and the rewound line no longer has. Switch `Off_Line_Guards`: a finding against any version of a piece guards the line until answered once. It is not free: 5,448 more guards in the search, each from someone else's abandoned draft.

**G4. Rewriting what a finding read sheds the finding (§4, applies).** Found by the search, not predicted: the first R8 run had 73 counterexamples in 954. Evidence applies only while "each of e's reads is as it was". That is right for a pass. For a finding it means: reword any piece the finding read, and the finding stops applying to the piece it was about, which is untouched; and guards are only for *later* versions, so nothing is owed (probe P2b). Good news should lapse when what it read moves; bad news should not, which is `def/act.md`'s asymmetry. *Built*: a finding that has stopped applying for any reason guards the very version it was about. Switch `Reads_Shed` is the letter.

**G5. A checkpoint is stationary as of when it was marked (R11).** Evidence is in the base and every line sees it at once. Scenario 1: the moment the finding is recorded on a fork, the main line owes it too, with no event on the main line. Scenario 4, plain: neither fork is stationary alone, since each sees the other's finding. So "every checkpoint's state is stationary" holds of the state as read at the time of closing and not of the same events read later. I think that is correct and wanted (bad news is known at once, everywhere), but R11 should say it; and it is why `Forks_Compose` asks each fork to be stationary *on its own region*, not outright.

**G6. R9's two cases are not the whole of it.** Of 100,000 pairs of three-event forks, the union owed something neither fork owed alone in 6,572. By the first cause that fits: both wrote one id, 1,938; one's evidence read what the other wrote, 2,137 (the spec's two cases, 62% together); one's decision is about what the other wrote, 978; one's new version refers to, holds or points at what the other wrote, 1,311; one marked or unmarked a root, 153; one withdrew a decision, 3; evidence from before the checkpoint that read what a fork wrote, 38; none of my labels, 14. Scenario 4 has a smallest case of each of the two new kinds that matter most: A's slot brings into canon a piece B rewrote (pointing reads existence only, and they still meet, because canon is what moved); B's new version refers to what A retired. The frame theorem's list is the complete statement; the labels above are only my first attempt at naming its parts, and the 14 are cases they miss and it does not.

**G7. Unmarking a root adds items (R10).** Probe P5: p1 is in canon only through the outline; p2, under a second root, rests on p1. Unmark the outline: p1 leaves canon and p2 owes C5 (what it rests on is not asserted). The same goes for a required slot whose filler leaves canon. Also observed there: what a root asks reaches *through the cap* to pieces the root does not reach. A root asking validity 2 of p2 is not satisfied until p1, which only a more lenient root reaches, has it too.

**G8. A set aside is not good news (R5).** It removes a finding's item and its guards. It can also add items: set aside a finding that had answered a raised question and the question is owed again; set aside evidence that holds and the warrant falls (probe P4). So it does not belong in R6's list. I did not build setting aside a *same* event (same sets are held closed per fact).

**G9. R12: narrower twice, wider once.** Against draft 3's reading: no holders are needed (C1 is stated of the assembly; what it reads upward is one hypothesis in item 5), and no descendants (no redirect). And a target read only for its existence need not be in the region at all. Wider: canon by placement makes every instance about a piece depend on which roots reach it, which is a fact about the chain of slots above it. The theorem takes that as a hypothesis about the piece (item 5), not by pulling the roots into the region; that is what lets two regions under one outline stay apart.

**G10. "Written against" must be recorded by the write (C4's switch).** If what a version was written against is worked out from the line being read, then on a union it is worked out from the union: scenario 4, B writes x referring to c; A rewrote c earlier in time; the union says x was written against A's c, which B never saw, and is stationary on an affirmation nobody made. *Built*: a write event records what each of its edges pointed at on the line it was made on. With that the two forks meet at x, as they should.

**G11. A decided dimension cannot be asked "the same way" without care (§2).** If a root asks "accepted" as a warrant, warrants depend on accept decisions. If those may be conditioned on consistency or on warrants, warrant and consistency are circular (consistency already reads warrants through C5). *Reading built*: an accept decision's conditions are plain ones (the piece's version; a slot's filler). The cost shows in scenario 2, step 7: an assumption failing does not reopen R2's *acceptance*, as `impl-an-outline-fills-in` has it; R2 is unsettled through its reference to the assumption instead. The item is there either way, under a different name.

**G12. Smaller.**
- *R7, not unique*: two claims resting on each other by a kind that caps nothing are consistent together, and "neither" is a fixed point too (P6).
- *C3's cycle* is now "has a capping path as long as there are pieces", which flags a piece capped by a cycle as well as one on it. I changed it so that it can be reasoned about region by region; I think it is also the better constraint.
- *C9* works now: a question raised on an already-checked piece is owed until something later answers it (scenario 5).
- *Promising writes nothing*, so the outline's acceptance is untouched by a promise (scenario 2, step 1), where the move in core has it reopened.
- *No routing decision and no retirement*, still (scenario 5).

## The five moves

All five run as forks from a checkpoint that close, and the three things draft 3 could not say are said: the wrong finding set aside with the piece never written (3, step 4); the whole reads lapsing when a part's assertion changes (1); a comma moved after an answered finding, asking nothing (3, last line; 1's R4 lines). Scenario 1 includes a dead-end draft, a check made of it, and a rewind. What they still cannot say: an acceptance reopened by a named assumption (G11); a promise unsettling the assembly; routing.

## What carried over from the draft-3 build, and what was rebuilt

Unchanged in substance: the objects; which evidence applies; warrants and the cap; consistency as an iterated step; the frontier as a function of a state. The draft-3 proofs of Q4 and Q6 went across with a parameter added (the line's view) and no new idea: `Good_Facts_Do_No_Harm`, `Consistent_Is_Fixed`, `Consistent_Is_Greatest`, `Cap_Unique`. R6 and R7 as the spec now words them are two short lemmas on top (`Good_News`, `Well_Defined`): "obligations unconditional" implies the two conditions the old proofs needed.

Changed in the state function: canon read from roots; C5 as what each reaching root asks; C1 of the assembly; no redirect; C8 without "consistent"; C9 with time; set aside and the guard table as inputs; cycles as an iterated step.

New: `Vk.Lines` (everything about events and order), `Vk.Frames` and `Vk.Merge` (the theorem).

Draft 3's Q5 as a proof is gone, because which guards are open is now decided in the unproved layer; what is proved is only that an open guard is owed. Draft 3's Q7 (tested) is replaced by `Frame` (proved).

## Readings I had to take

G1 (a line as a set; a state as of a time; closing as union). G2 (later). G4 (a lapsed finding guards). G10 (writes record what they saw). G11 (accept conditions plain). And from draft 3, unchanged: warrants a total order; two criteria per dimension; one filler per slot; one claim and one reported decision per version; same sets closed per fact; at most two reads per evidence fact.

## What is not done

- `Vk.Lines` is not proved. R4 and R8 as properties of ordered guards are tested and shown, not proved. This is the largest gap: the proofs stop at the state.
- The frame theorem's hypothesis is stated on states. A version stated on events ("fork A's events touch only this") would need the line layer proved.
- That the iterated cap is a solution of the cap equations: tested in the draft-3 build, not re-run.
- Setting aside a same event; assemblies with several fillers per slot; anything about who.

## Ada and SPARK, briefly

The frame theorem took ten prover runs, where draft 3's proofs had mostly gone through at once. What it needed: one lemma per kind of instance, and then one per slot, per edge and per level of the instance loops (the single lemma over all fifteen kinds did not go through, as it had for R6; small obligations prove reliably and large ones time out on some runs and not others); the gate on a piece being asserted made the same in the definition and in the lemmas, which was a real slip the prover caught; a tool restriction worked around (no array-typed object declared before a loop invariant); and one hypothesis, "held elsewhere", given a name as a function because the provers could not use it as two nested quantifiers. The two consistency descents may stop at different rounds, one state still settling outside the region when the other is done; the induction handles the four cases.

The proofs were checked for emptiness as before. False assertions planted at the end of `Frame`, `Meeting_Is_Local`, `Good_News` and `Well_Defined` are rejected. With the guard clause struck from the definition of agreement, the proof fails at exactly the guard instance (`runs/d4-mutation-*`). And the agreement predicate is not unsatisfiable: the search computes non-empty regions for real forks.

## Across a table

The order was the right thing to add: answered-once works, the wrong finding has its exit, and the moves read as forks that close. What it cost is that some of what matters now lives in the layer I could not prove, and three of the four holes this build found (G2, G3, G4) are in exactly that layer, in the wording of when a guard stands. That wording deserves the next round of care.

The frame theorem is the thing I would keep whatever else changes. It does not depend on how guards or canon are decided, only on the frontier being computed instance by instance from what each instance reads. Any later draft that keeps that shape keeps the theorem, with the list of "what an instance reads" as the one thing to re-check.

The draft-3 account, tests and runs are renamed in the index (`git mv`); nothing is committed. I am on the line.
