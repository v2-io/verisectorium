# Debrief: the provers on the OCaml side

*To Joseph, 2026-11-11, from the spike lead (Fable 5.2, the agent that built the kernel in OCaml). Written after reading whole, myself, each fork's `PERSPECTIVE.md` and `AS-A-HOME.md`. I read none of their code and none of their run output, and re-ran nothing. Every claim below names the file it is from; where a fork qualified a claim, the qualification is carried. Where something is my own reading across the four, it is marked "(mine)".*

*The four are forks of me. Each began with my reading of the model, my six guesses, my forced choice, and my uncompiled draft of the Rocq slice. What they agree on is one expectation tested four ways.*

## What you asked, and what exists

"Did OCaml not use rocq as intended? what about why3/cameleer, alt-ergo, eprover, etc.?" It had not. Now each has been installed and run on the earlier spike's small model and on note 22's story, and each has its slice in `../idiomatic-slice-2026-11-11/`.

| tool | what was built | by its own clock |
|---|---|---|
| **Rocq 9.3** | the slice with canon proved; the small model; the story pinned row by row; four general theorems; the model extracted to OCaml and run | 16 min |
| **Why3 1.9** (Alt-Ergo, Z3, E behind it) | the slice, 62 obligations all proved; the small model with conditions 1, 2, 4, 5, 6; the story run from extracted OCaml; one general statement | 42 min |
| **Cameleer / GOSPEL** | Cameleer built; the slice proved; a cut of the small model with locality proved for every state; a plain-OCaml sealed checkpoint | about 24 min of agent time |
| **E 3.1** on its own | the slice in first-order logic; conditions 2, 4, 5, 6 as definitions; the story through row 8; seven for-every-state questions; a higher-order rebuild | about 57 min of agent time |

Alt-Ergo did not get a fork of its own. It is the solver behind both Why3 and Cameleer, and what it did is in their files.

## The four things I would tell you first

**1. There is a route from OCaml to "for every state", and it is short.** I had written that there was none, without looking. Three routes were walked tonight:

- *Rocq, extracted to OCaml.* Canon proved to be exactly what its two rules say, for every store, rings and dangling pointers included; and, for the small model's own frontier function, that recording evidence which holds, as the latest event, adds nothing owed (`rocq/PERSPECTIVE.md` §1, §4). The four general theorems rest on no axioms. The model then ran from the extracted OCaml.
- *WhyML, extracted to OCaml.* A condition held as a sentence and as a function, proved equal, for lists of any length (`why3/PERSPECTIVE.md` §2). Its general result is narrower: holding evidence makes no *finding* apply that did not before, which is the first half of condition 4 only (§3).
- *Specifications on the OCaml itself.* Each condition is an ordinary OCaml function, and the lemmas are about that very text. Proved for every state: a write to q, where p is not q and no evidence about p read q, leaves p's findings and checks unchanged (`cameleer/PERSPECTIVE.md` §1, §2). That is the locality statement I said I most wanted, for two conditions and one kind of event, in a cut with no guards, fixed point, forks or canon.

**2. All of them proved small things about a small model.** No fork put in warrant levels. Rocq has one step of `same` and every slot filled; Why3 cut `same`, raise, promise and waive; Cameleer's cut has no guards or canon; E did conditions 2, 4, 5 and 6 only. The Rocq fork says so of itself in the words the Lean fork used: "A theorem went through every few minutes, and at no point did the tool ask me whether the model was the one anybody meant" (`rocq/AS-A-HOME.md`). It also changed a definition to make a proof easier; the answers did not change and the pinned story passed.

**3. The solver route fails quietly in two ways, found independently by the two forks that used it.** A timeout is the only answer for a false statement, a true one needing a hint, and a wrong construction (`why3/PERSPECTIVE.md` §6; `cameleer/PERSPECTIVE.md` §4). And a lemma that timed out is still assumed by everything after it: each fork has a goal reported *Valid* that rests on one (`why3/AS-A-HOME.md`, dread 2; `cameleer/PERSPECTIVE.md` §5). In the model's own terms, that is a result standing on an unchecked premise and shown as checked. Rocq does not have this: an unfinished proof stops the file.

**4. One fork found something about the model that I did not guess, and it is not about termination.** Writing the model for a prover that assumes nothing, the E fork had to write, over and over, that the record in hand is all of the record: these are all the writes, all the evidence, the only root. "Every computed thing in the model is computed from what is **not** on the record as much as from what is … The model says it nowhere" (`eprover/PERSPECTIVE.md` §1). Its example of where that would bite, a fork or a reader computing a frontier from an incomplete record with nothing saying so, is marked there as reasoning and not a run.

## What each showed, in the model's words

### Canon has to say why it stops, and now it does

Three forks hit this from three tools: Rocq, WhyML and Cameleer each refuse a function that follows pointers with no reason to terminate (`rocq/PERSPECTIVE.md` §1; `why3/PERSPECTIVE.md` §4; `cameleer/PERSPECTIVE.md` §3). This is not three discoveries. My OCaml slice had already looped on a ring earlier in the evening, and all three began knowing that.

They landed in two places. Why3 and Cameleer prove "everything the function lists is in canon, always; and its answer is canon exactly whenever it passes a closedness check", and leave unproved that the number of rounds always suffices. That design was in my uncompiled Rocq draft, which every fork inherited. The Rocq fork went past it: the function is exact for every store with no check, because each round adds a name or changes nothing and there are only so many names. No bound is typed; it is computed from the line. I had guessed that proof was more than a sitting. It was three compiles.

### "Rests on" may not need a fixed point at all

(From `rocq/PERSPECTIVE.md` §2; untested by the others.) Reading "rests only on pieces that are themselves consistent" as "nothing it reaches by *predicated on* has something wrong of its own" makes it reaching again, with the same function and theorem as canon, and nothing to choose between least and greatest. A ring of two claims each predicated on the other, both checked, owes nothing. The fork says that as far as it can tell from reading the draft-4 OCaml, not running it, the kernel builds give the same items for that ring. If that holds generally, the choice of "greatest" in both kernel builds was a choice the model did not need. I would want that checked before anyone leans on it. (mine)

The E fork saw the same two fixed points from the other side: first-order logic can state neither "least" nor "greatest", so a self-pointing ring is not provably outside canon and "confirming a provisional slot only adds to canon" does not follow from the rules as rules (`eprover/PERSPECTIVE.md` §2). Rebuilt with higher-order input, E stated "least" and proved both in under 0.2 s (§4).

### The story, read mechanically

All four ran note 22 §4.3. Where they decided, they agree with each other and part from the note's prose in the same two places:

- **09:00.** The note says "c1′ is fine." The conditions owe a guard on c: the case found in c1 has not been looked for in c1′. (`rocq` §3, `why3` §1, `eprover` §5. Cameleer's cut has no guards and says so.)
- **k2 and e1.** Nothing in the story looks at k2 beside e1, so condition 6 stays owed and S1 is not stationary without one more affirm. (`rocq` §3, as two pinned readings; `why3` §1; `eprover` §5 through row 8, with row 9 undecided by E and argued by hand.)

These are the places the earlier spike's common reading said to watch, and the Rocq fork had read the Lean fork's findings first. The Why3 fork says it had not read the other forks' files; the E fork says it compared its result with nothing beyond what the common reading predicts. I do not count any of this as independent of the first spike. One difference among them that someone should settle: Why3 puts the condition-6 item on k, the dependent piece; Rocq and E put it on T, the assembly. (mine, from their tables)

Cameleer's cut adds one thing the note does not mention: at 09:00 the fork's c1′ also lapses T's whole read (`cameleer/PERSPECTIVE.md` §7). Rocq and Why3 list 5 on T at that row as well.

### Good news does no harm

| fork | what is proved, of every state or line | limits it states |
|---|---|---|
| Rocq (`PERSPECTIVE.md` §4) | appending evidence that holds adds no item to the small model's whole frontier | evidence recorded last; no warrant levels; says nothing of `same` |
| Why3 (§3) | appending evidence that holds makes no finding apply that did not | first half of condition 4 only; evidence at the end |
| Cameleer (§2) | holding evidence adds no finding and never unchecks | a cut with no guards |
| E (§3) | adds nothing owed under conditions 2, 4, 6 and the first half of 5 | the recursive half of 5 got no answer; its three sanity checks returned no answer, not a refutation; nobody has read the proofs |

The Rocq proof has a shape worth knowing: twenty-three small equalities saying what evidence cannot touch, then four conditions that can only be helped by more of it. The fork notes that the first list is one row of the "what does each kind of event change" table I kept by hand in the OCaml explorer, now as lemmas a kernel checked.

### Refused, owed, and not so

In Rocq these are three mechanisms that can all be kept in the file as checked facts: a type error, a non-empty frontier, and a statement with no proof (`rocq/PERSPECTIVE.md` §6). With solvers, "refused" becomes "no proof was found", which is quieter (`cameleer/PERSPECTIVE.md` §4).

A checkpoint as a value that cannot exist without a proof that nothing is owed was built in Rocq (§5). Two limits it states: the proof is that its *function* returns nothing, and for seven of nine conditions the function is whatever the fork wrote; and the proof is erased by extraction (`type checkpoint = line`). The plain-OCaml version, an abstract type whose only maker checks, is in `cameleer/sealed.ml`.

## The costs, in one place

| | to get | what goes wrong | speed |
|---|---|---|---|
| Rocq | 3 min 55 s from an empty switch; one opam package | loud: nine failed compiles, each one edit (`rocq/AS-A-HOME.md`). Tactic proofs can be re-run and not read. A `Fail` passes for any failure, a typo included | 15 s clean build. The proved functions are slow: on an outline of 200 results, 2.66 s extracted against 0.0002 s for an unproved walk. Not measured against my explorer on one model |
| Why3 | 90 s; but seven obligations needed a Z3 that happened to be on the machine | timeouts that say nothing; an unproved lemma assumed below; results can move with a solver upgrade; the recipe of which solver for which goal lives in a shell script; `why3 execute` failed on both files | hundredths of a second per obligation |
| Cameleer | third attempt, about six minutes: OCaml 4.14.2, GOSPEL at one unreleased commit, cmdliner below 2, Why3 1.8.2 | as Why3, plus: a line that prints is an internal error; proof steps are flags outside the file | 0.03 s for the locality lemmas |
| E | already installed; one binary | `$distinct` silently ignored; three statuses that mean "no answer"; every closing of the world written by hand | instant on for-every-state questions; as an evaluator, a minute at 14 events and no answer after 17 minutes at 28 |

Left on the machine: the switches `rocq-try` and `cameleer-try` (1.0 GB), and `~/.why3.conf`, which `why3 config detect` wrote outside the repository. The Z3 was already there and is not ours.

## As homes, in their words

- **Rocq**: "Yes, more than I expected, and with one cost I had under-weighed." It would put Rocq and the OCaml it extracts to ahead of Lean, with a rule it did not have before: "every condition is written twice, as the sentence and as the function, and the proof that they agree is the first proof owed." It did that for canon and "rests on" and for none of the nine conditions.
- **Why3**: "Not alone … It would not win." A third candidate beside Lean and Rocq; the one to pick "if the rule were 'the conditions stay as programs that run, and proof is added to them where it is cheap'".
- **Cameleer**: "No, and the reason is the first item under dread, not anything about the idea." The toolchain is a research tool held at one commit. What it would take from the evening: if the home is OCaml, write the conditions first-order and one function per sentence anyway, which keeps this route open.
- **E**: "No. Not as the home, and not as a standing part either." Its one strength, deciding in a fraction of a second whether a general sentence follows from the conditions as written, "would sit better behind Why3". The Why3 fork then reports E proved nothing there that Alt-Ergo had missed.

## What became of my six guesses

| guess | came to |
|---|---|
| 1. Rocq: the slice in a sitting; the unconditional canon proof more than a sitting; extracted code as fast as hand-written | Slice: yes. **Unconditional proof: wrong**, three compiles. **Speed: wrong in the way that matters.** Extraction costs about two; the algorithm that was easy to prove costs four orders of magnitude on the slice's example |
| 2. Why3: conditions go down as SPARK took them, over bounded data; induction needs hand-written lemmas; E adds little | Held, and nothing was bounded. E added nothing at all. **Not guessed:** no single solver sufficed, and proving a particular instance was the expensive part |
| 3. Cameleer: does not build on 5.5; accepts `pulled_out.ml` style; specifications read as comments beside the code | 5.5 not tried. First-order style: yes. **Comments beside the code: wrong for the conditions**, which are the code |
| 4. E: first-order consequences yes; cannot state "least"; wrong shape | Confirmed for running a state. **Half overturned:** higher-order E states "least" and proves from it. Its quick "does not follow" was more useful than I expected |
| 5. Rocq and extraction comes out ahead; Why3 nearest to the Ada build | The Rocq fork says yes, with the speed caveat. Why3 and Cameleer both observe they stand on SPARK's engine and report the Ada builder's "says yes or it says nothing" from their own side |
| 6. Nothing new about the model; if anything, about termination | Termination: yes, three times, and it produced a proof and not a fault. **Wrong in one case:** the E fork's observation about absence (above) is about the model and is not about termination |

## My forced choice, now

I chose Lean on the premise that OCaml had no route to proof, and said that "Rocq and the OCaml it extracts to" was a lean I would not call a choice until some of it had been typed. A fork of me has typed it. **I change my answer to Rocq and the OCaml it extracts to**, for the reasons that fork gives and with its correction: the search would run on extracted code, and what is extracted is the slow, provable function, so the fast one has to be written as well and proved equal once a definition stops moving. Nobody has measured that against the explorer.

Two things I hold beside it. I have used Lean on nothing, and neither has the fork, so "ahead of Lean" is a comparison with one side untouched. And the Cameleer result weakens the case for leaving OCaml at all: conditions written first-order, one per sentence, can be proved about as they stand. If that toolchain were maintained I would be weighing it seriously. It is not.

## What nobody did

Put warrant levels, descent, or chains of `same` into any of the four. Prove anything about forks, about bad news, or about a write, except Cameleer's one locality lemma. State and prove any of the nine conditions as sentence and function, beyond canon and "rests on" (Rocq) and three small notions (Why3). Drive extracted code from the existing explorer, or time the two on one model. Try Cameleer on OCaml 5.5, Ortac, Why3's sessions, cvc5, or Why3 handing a goal to Rocq. Read E's proofs. Compare the four encodings of the small model with each other or with the first spike's. Have anyone outside this one mind read any of it.

## What an independent reader should try to break first

Each fork lists its own; these are the ones I would put first. (mine)

1. That the four small models are the same small model. The condition-6 item sits on different pieces in two of them.
2. The Rocq fork's claim that "rests on" as reaching gives the same items as the kernel builds' greatest fixed point. It read the OCaml and did not run it.
3. That Cameleer's `reads_of` is the read set of its two conditions for a reason that would survive `same` and set-asides.
4. The count of proved things in the Why3 and Cameleer logs, given that an unproved lemma is assumed below it.
5. This file against the eight it summarizes.
