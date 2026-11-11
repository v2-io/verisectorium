# An independent read of the OCaml-side provers spike

*Written 2026-11-10, 23:42 MST by the clock (the spike's files carry the UTC date, 2026-11-11), by a fresh agent (Fable 5.2) given a bare brief: read this directory, try to break it, write here. I am not a fork of the lead and began with none of its reading. Scratch; adjudicated by nobody. I changed no file of the spike; everything I ran, I ran in a copy in the session scratchpad.*

## What I read, ran, and did not

**Read whole:** `README.md`, `00-guesses-before-running.md`, `DEBRIEF.md`; all four `PERSPECTIVE.md` and `AS-A-HOME.md`; `rocq/Vk/{Reach,M0,Story,Checkpoint,GoodNews,Extract}.v`, the four mutations, `run.sh`, both drivers; the Rocq slice `rocq.v`; `why3/m0.mlw`, both prove scripts, the false-statement mutation; `cameleer/m0.ml`, `m0_story.ml`, `m0-check.sh`, `try/brute_lapse.ml`; `eprover/m0/m0.ax`, `gen.py`, `ladder.py`, `general/two_worlds.py` and every `general/*.p`; the E slice and its ring, grows and higher-order files; the two slice NOTES files; the first spike's `01-common-reading.md` and `08-corrections-after-the-independent-read.md`; note 22 §4.1 to §4.3.

**Read in part:** `why3.mlw` (lines 100 to 160 and 300 to 394); `cameleer.ml` (to line 260); run logs, by tallying results and reading every non-`Valid` entry; the first spike's `DEBRIEF.md` items 2, 5, 6 and its independent read §2 and §8; `kernel-2/KERNEL-SPEC.md` §4 and §5; `kernel-2/ocaml/lib/model.ml` lines 340 to 360 and 565 to 640; `languages-compared-2026-11-10.md` §9 and the changed end of `forced-choice-2026-11-11/ocaml-builder.md`, both of which landed while I was reading.

**Ran** (one process at a time): `rocq/run.sh` from clean; both solvers over `m0.mlw`; `why3 extract` on both WhyML files; the story from a fresh extraction; `cameleer/m0-check.sh`; E on the six general theorems with proof objects; the five higher-order files (the `eprover-ho` binary is still in the session scratchpad); `ring.p` and `grows.p`; and three probes of my own, given below.

**Did not:** re-run the Why3 slice proof, the Cameleer slice check, or E's ladder; read `sealed.ml`, `cameleer/try/`, the Rocq refusals, any extracted OCaml, or the install logs; run either kernel build; read any other agent's scratchpad files.

## In short

The logs are honest. Everything I re-ran came out as the forks' files say, and I could not make any proved statement fail. The four perspective files are careful about their own limits.

What I would put in front of the lead, in order:

1. **Two things the debrief presents as found or open were closed, and corrected, by the first spike's own debrief the day before.** The reading of note 22's example (§1), and "rests on may not need a fixed point" (§2). In both, the earlier corrected wording is the more accurate one.
2. **The four small models are four different functions that agree on the story.** One difference is the same one the first spike's reader tabled for Lean against Datalog; the Rocq fork has Lean's side and Why3 and E the other. I ran it (§3).
3. **The one thing "new about the model" is a restatement, and "the model says it nowhere" is not so** (§4).
4. **Nothing tonight bears on Rocq against Lean**, and the one measurement that bears on the risk the lead named as decisive came out against the route as built (§6).

## 1. The example: two corrected claims have come back uncorrected

`DEBRIEF.md` says the four "part from the note's prose in the same two places", and of the second: "condition 6 stays owed and S1 is not stationary without one more affirm."

The first spike's debrief said this in its first version, its independent reader took it apart (its §2), and its lead rewrote item 6 to: the example "gives two answers". Read as note 22 words condition 6, the item is owed. Read as `core/def/changeset.md` words it (what depends on something that *changed* is changed or affirmed), nothing is owed and S1 is reached as told. That lead also wrote: "I supplied the looks at S0 that the story does not mention and then demanded them at 10:30", and that "c1′ is fine" is "true of the question B asked and not of the auditor's, if the auditor's is a separate criterion, which the 11:00 row suggests and the story does not say."

All of that applies here unchanged, because all four forks started from the same `01-common-reading.md`, which supplies the S0 affirms and makes the auditor's finding a separate criterion. Of the three forks that have condition 6:

- **Rocq** encodes both readings (`looks`, `strict`) and makes `looks` the one its checkpoint uses: `S1_is_a_checkpoint : checkpoint looks`, and the extracted run prints "14:00 owed: nothing … close: yes, a checkpoint". I ran one thing its files do not: under `looks`, S0 with both affirms removed is still stationary (`frontier looks (firstn 13 S0) = []`). So `looks` treats the two ends of the story alike and needs nothing supplied. That is close to the first spike's corrected position, and it is the Rocq fork's default. The debrief cites it as support for "S1 is not stationary".
- **Why3** and **E** have only the strict reading and say S1 is not a checkpoint.

So the accurate summary is the one already written yesterday: two wordings, two answers, and under the reading that holds both ends to one standard the story is right as told. The comparison's §9 carries the flat version ("All four part from its prose in the same two places").

## 2. "Rests on may not need a fixed point at all"

The Rocq perspective (§2) says "there is no fixed point to choose" and that this "settles what a ring of claims means". The debrief adds, marked as its own: "If that holds generally, the choice of 'greatest' in both kernel builds was a choice the model did not need. I would want that checked."

Three things, the first two by reasoning and the third by reading code.

- **The reaching form is the greatest fixed point; it does not avoid choosing it.** "Fine unless it reaches something with a fault of its own" marks a clean ring as fine. The least fixed point of the same rule marks it as owing. Choosing the reaching form is choosing the greatest. The first spike's item 2 already says so in its title ("makes a choice visible; it does not make it") and its second paragraph ("'Consistent needs a reason' is the other, is just as sayable, and would reject the ring").
- **It was already proved, with its limit.** The first spike's Lean fork proved the two equal for any number of pieces "when what a piece owes of its own does not depend on what is consistent", and "did not prove it of the small model's own function, nor of the spec's." Rocq's `M0.v` proves less on this point than that: it *defines* condition 5's second half as reaching (`c5_rests`). `rests_on_is_reached` says the function computes reachability along *predicated on*. No fixed point is defined in the Rocq files, so nothing about one is proved.
- **It does not hold generally, for a reason visible in the kernel.** In `kernel-2/ocaml/lib/model.ml` the set assumed consistent (`x`) is read by a piece's *own* conditions: by decisions with an `Asserted_consistent` condition (lines 346 to 357) and by the effective warrant that C5's "what its roots ask" compares (line 567, `effective u s x p d`; C7 and C8 read it too, lines 547 and 553). That is exactly the proviso failing. It is why that file has a function `fixpoints` that enumerates several, and why the spec lists "say whether it is now unique" as R7.

On the narrower claim, that the kernel gives the same items as Rocq on the two-claim ring: from the same lines I expect yes, and I did not run it either.

## 3. The four M0s are four functions

The debrief's first "break this" is that the four are one model, and names one difference (where the condition-6 item sits). There are more. None shows on the story, so "where they decided, they agree" says little about sameness.

| | Rocq | Why3 | Cameleer's cut | E |
|---|---|---|---|---|
| a finding on the *current* version, after something it read is rewritten | **a guard is owed** (ran) | nothing under 4 (ran) | no guards | nothing (read: `was(P,V) & ~sel(P,V)`) |
| the condition-6 item sits on | the result | the dependent piece | absent | the result |
| condition 6 can be met by a write | yes, under `looks` | no | absent | no |
| a result's whole read must have read every filler | yes | yes | **no** | **no** (`m0.ax` lines 101 to 108) |
| how many rounds canon gets | computed from the line, proved enough | `length o.kinds`, unproved, **no check** | absent | none; any fixed point |
| what a reference was written against | computed from the line | typed in the write event | typed | typed |
| set aside, same, waive | all three | set aside | none | none |

Three of these I would call findings and not differences of taste.

**The lapsed-read guard is the first spike's known split, again.** That reader's §8 table has the row "a finding that stops applying because something it read was rewritten": Lean a guard, Datalog and TLA+ not. The Rocq fork had read the Lean fork's perspective and its `c4` has Lean's test (`negb (applies l f)`); Why3 and E test "the version differs". Draft 4 of the kernel spec sides with the second ("a guard on p's *later* versions"). The probe, in `rocq/` with `Vk` built:

```coq
Definition F := ev "F" "c" "c1" "caseX" false [("d","d1")].
Compute frontier strict (S0 ++ [F; Write "d" "d2"]).
(* = [(5,"T"); (4,"c"); (5,"c"); (5,"u")] *)
```

The same line through the Why3 extraction gives `5:c 5:u 5:T`. In Rocq the 4 on c then survives a fresh check of c and a fresh whole read of T, until someone repeats caseX. All four also meet a guard with evidence that "applies now", where the spec has "applied when recorded"; that one is the common reading's and is stated there.

**Why3's M0 has a typed number under its canon.** The Rocq perspective recalls the first reader's finding about Lean ("a fuel that could be set too low to make a state that owes look stationary") and says "Here there is nothing to set." True of Rocq. Why3's `canon` is `grow l (length o.kinds) (roots l)`, where `o.kinds` is the hand-written ontology, a piece left out of it defaults to `Other`, and unlike the slice's `canon_of` there is no closedness check and no contract. With an ontology that lists only c, the story's 08:30 row comes back stationary (ran: canon is T, U, O; frontier empty). The Why3 perspective says rounds are fixed; it does not say the bound is hand data or that M0 lacks the slice's check. The debrief's sentence about Why3 and Cameleer ("its answer is canon exactly whenever it passes a closedness check") is true of their slices and not of Why3's M0.

**E's condition 5 is weaker than M0's and does not say so.** `owed(cond5, P)` for a result asks only for applying evidence on `whole` that holds. `m0.ax`'s header lists three departures and this is not among them. Cameleer's cut does the same (`checked whole`), consistent with its stated scope.

One more, about Rocq's checkpoint. The type is `checkpoint O`, and `O` carries `write_looks`. S1 is a checkpoint at `looks` and not at `strict`. So there is one hand-set boolean under "cannot be had without its proof", and it decides the story's last row. It is an honest, named parameter and not a fuel, but "nothing to set" should not be read as covering it.

## 4. "The model reads absence as information, and says so nowhere"

The debrief gives this as the one case where guess 6 was wrong, quoting: "'Every computed thing in the model is computed from what is **not** on the record as much as from what is … The model says it nowhere' (`eprover/PERSPECTIVE.md` §1)."

- **The quotation joins two files and drops a qualification.** The first sentence is `PERSPECTIVE.md` §1. "The model says it nowhere" is `AS-A-HOME.md`. What §1 itself says next is "Core says this once, sideways ('*never asked* is a warrant'), and note 22 not at all."
- **Both halves of that are too strong.** Note 22 §4.2: "Evidence can arrive against a checkpoint itself. The checkpoint was stationary when it was reached and is not now." `core/src/disc-better.md`: "both states are read from the record as it stands at the later one". The first spike's item 5: "'the checkpoint' names two objects, the state rested at (frozen with its record, stationary for ever) and that line read with today's record". And the E perspective itself cites the builds' two readings of which base a line sees. So *which record a state is read from* has been said in the note, in core, and in the first debrief.
- **What is left that is the E fork's own:** that the dependence on a complete record runs through every computed thing, selection and canon included, and has no single name; and the case of a reader working from a copy. The fork marks the second as reasoning and not a run. That is a useful way of saying it. I would not count it as something the builds and the first spike did not find.

## 5. What "proved" covers, counted

So that the table at the head of the debrief is not read for more than it holds.

- **Rocq.** Two statements with real content: `reach_is_reached` (and its use for canon and for *predicated on*), and `good_news`. `at_a_checkpoint_nothing_is_known_wrong` unfolds `frontier`: if nothing is owed then `c4` is not owed. Its English gloss is the comment above `c4`, which the perspective itself says is not proved to be what `c4` computes. "Twenty-three small equalities" is twenty-two about the model and one list lemma.
- **Why3.** Of `m0.mlw`'s 87 obligations, 53 are "this recursion terminates" and 8 are preconditions. The content is the `Sentences` module: three notions tied to sentences and one general statement about half of condition 4. No condition of M0 has a contract. The comparison's §9 says "each condition a function with its sentence above it"; that is not what the file holds.
- **Cameleer.** Nine lemmas: seven proved, one not (`a_read_lapses_in_the_list`), one `Valid` resting on it. The unproved one is true, by three lines: some pair (q, w) is in `reads`; `reads_stand` gives `selected q sel = w`; after the write `selected q` is v, which is not w. So this is a clean specimen of the fork's own point that a timeout was a true statement the solver could not do. The slice has one obligation unproved (`derived_result'vc`), which the debrief's "the slice proved" drops.
- **E.** Six `Theorem`s; `only-canon-owes` and `finding-blocks` each follow from two definitions. Good news for 2, 4, 5 and 6 are real. I checked what the fork left open: each proof uses the negated conjecture and the axioms one would expect (`g_is_last`, `one_more`, both worlds' definitions), and the axiom sets are consistent, by a model one can write down (every stored relation empty; canon empty; `bad` everywhere; in world 2 the one piece of evidence g). So the theorems are not vacuous. Good news for the second half of 5 is not merely unanswered: it does not follow. Take a piece predicated on itself, in canon, with nothing wrong of its own; `bad1` false and `bad2` true satisfy both copies of `bad_def`, and then it is owed in world 2 and not in world 1.

## 6. The forced choice

The debrief changes the lead's answer from Lean to Rocq with extraction, and says plainly that "ahead of Lean" compares a touched thing with an untouched one. Three things I would add.

- **What tonight established is that the premise was false,** not that Rocq is ahead. The only evidence that touches both provers is the count of compiles for good news (four here, seven in Lean), by a fork that had read the Lean result and knew the theorem went through.
- **The risk named as decisive was speed, and the measurement went against the route as built.** Extracted M0: 92 microseconds a frontier on lines of at most 29 events, with no warrant levels. Extracted canon: cubic, 2.66 s against 0.0002 s at 200 results. The lead's own bar was "within a factor of ten or so" of an explorer that visits tens of millions of states in minutes. Nobody measured against it. The stated way back is a second, fast function proved equal to the slow one.
- **That way back stacks on the fork's new rule** (my inference, not in the files). "Every condition is written twice, as the sentence and as the function" plus "the fast one has to be written as well and proved equal" is three texts and two proofs for each condition, of which tonight has zero of nine. And "it keeps the explorer I have" is untested: the extracted functions are over strings and lists for M0, and the explorer is over bitmasks for the kernel model.

None of this says the choice is wrong. It says the evidence for it is the same as it was before the spike, minus one false premise.

## 7. One gap in the Why3 record

`why3/extracted/m0_extracted.ml` (22:54) is not what the final `m0.mlw` (23:00) extracts to. The source was edited after extraction (`written_by` split out; `read_one` moved) and then proved (23:01), so the story table in `runs/22-story-run.txt` came from a program extracted from an earlier text than the one the 87 obligations are about. I re-extracted from the final source and ran the story: the output is identical, so nothing reported is wrong. The slice's kept extraction is byte-identical to a fresh one. The extraction command is recorded nowhere; what reproduces both is `why3 extract -D ocaml64 --recursive -L . <file>.<Module>` with the file copied to a name that is a legal module name.

## 8. Smaller, about the debrief against its sources

- "In the words the Lean fork used": the sentence quoted is the Rocq fork's own. The Lean fork's words were "A proof assistant rewards making the model smaller and sharper until a theorem goes through."
- "Each fork has a goal reported *Valid* that rests on one": for Cameleer that is the final state. For Why3 it was a moment during the work; in the final runs every lemma is proved by one solver or the other.
- "Found independently by the two forks": both cite the Ada builder's "says yes or it says nothing" as known going in. The behaviour is in their logs and is real; "independently" claims more than the README allows itself.
- "About 24 min of agent time" and "about 57 min of agent time" name no file. Cameleer's clock file gives 20 minutes to the start of its notes; E has no clock file.
- Rocq's "fork start 22:25:51" is the modification time of `runs/slice-01.txt`, a compile that had already succeeded; `clock.txt` was written once, at the end. Its start is earlier by an unknown amount, and the failed compile of the parent's draft that `AS-A-HOME.md` counts is in no log. The debrief calls that draft "uncompiled".
- "There is a route from OCaml": two of the three routes start in another language and end in OCaml. Only Cameleer starts from OCaml, on a compiler three versions back. The body says this correctly; the heading does not.

## 9. Smaller, about the code

- In all three typed slices a slot's kind constrains what it *holds* and not what it *points at*: `points_at "d"` in the formal-claim slot is accepted by Rocq's types and by Cameleer's invariant (`takes` is true of any pointer). The notes list a dangling pointer and not this.
- `promised` in the Why3 and Cameleer slices skips results held inside an outline; Rocq's does not. Invisible on the instance.
- In Rocq's M0 a line holding only `MarkRoot "ghost"` is a checkpoint: the name is in canon and nothing is asked of a piece with no shape. The slice's notes say the like of the slice.
- In Rocq and Why3, evidence that *fails* about one filler and read the other counts as having looked at the two together (ran, Rocq: appending such evidence to the 14:00 line turns `6 on T` into `4 on k`). Defensible; nobody states it.

## What I tried to break and could not

- `rocq/run.sh` from clean in a copy: 13.6 s, and `full-build.log` identical to the kept one but for a path and a timing. No `Axiom`, `Admitted` or `Parameter` in `Vk/` or the slice.
- `m0.mlw` under both solvers: 84 and 3, 83 and 4, the same goals timing out, every sub-goal proved by one of the two.
- `cameleer/m0-check.sh`: 26 `Valid`, the same five timeouts.
- E's six general theorems: all `Theorem`, in the times the fork gives (10.7 s and 16.7 s for conditions 6 and 4).
- The higher-order files: `Theorem` for the ring, for "only grows", and for the two rules; no proof of "whatever is in canon has a reason". First-order `ring.p` and `grows.p`: `CounterSatisfiable`.
- The debrief's figures against the forks' logs, where I checked them (obligation counts, timings, line counts of the Rocq files): right.

## What this file does not establish

That any of the four M0s is the model anyone means; I compared them with each other and with the common reading, not with core. That the Rocq proofs say what their comments say beyond the statements I read; I read every statement and no tactic script closely. Anything about the Why3 or Cameleer slice proofs beyond their logs. Whether the kernel and Rocq agree on the ring. Whether Lean would have done better or worse at any of this. And I am one reader: where I report a difference as a finding, a second mind may read the common reading's sentence the other way.
