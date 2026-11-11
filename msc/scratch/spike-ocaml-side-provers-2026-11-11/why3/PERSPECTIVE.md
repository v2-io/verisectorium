# Why3: what a language of contracts and solvers shows about the model

*2026-11-11, by the Why3 fork of the OCaml builder (Fable 5.2). I began with everything the spike lead had read and with its `../00-guesses-before-running.md`; this is one expectation tested one more way, not a second mind. Nothing here is a fact about the model until adjudicated in core.*

## What was done, and what was not

**Run and proved, by me, tonight:**

- `why3 config detect` (it wrote `~/.why3.conf`). Solvers found: Alt-Ergo 2.6.4; E 3.1 and a Z3 5.3.3 that was already on the machine at `/opt/homebrew/bin/z3`, both reported as "version not recognized" and used anyway.
- The idiomatic slice, `../../idiomatic-slice-2026-11-11/why3.mlw` (394 lines): 62 obligations, all proved, by the recipe in `prove-slice.sh`.
- M0 and note 22 §4.3's story, `m0.mlw` (540 lines): conditions 1, 2, 4, 5 and 6, the frontier at each of the story's ten rows, and one general statement with its lemmas. 87 obligations: Alt-Ergo proved 84, Z3 proved 83, and every one was proved by at least one of the two.
- Both files extracted to OCaml by Why3, compiled, and run (`extracted/`).
- One false statement given to all three solvers (`mutations/`).

**Cut from M0, knowingly:** `same`, raise, promise, waive (the story uses none), so conditions 8 and 9 are absent. "Rests on, through any chain" is computed with a fixed number of rounds.

**Not done:** Why3's graphical tool and its proof sessions; Why3 handing a goal to Rocq (it can, and Rocq is installed beside it); cvc5; Alt-Ergo's own input language; good news for the whole of condition 4 (only its first half); anything about two forks; any proof about the story's frontier (it was run, not proved). Wall time from first command to the end of building was 42 minutes by the clock (`clock.txt`).

Every run's output is in `runs/`, numbered in the order made, including the ones that failed.

## What Why3 is, for someone who has not met it

A program is written in WhyML, which is close to a small OCaml: algebraic types, records, recursive functions, no objects, very little higher-order. Above each function's body go sentences: what must be true before it is called, what will be true of its answer. Why3 turns "this body keeps these sentences" into a list of obligations and sends each to automatic solvers, which answer *valid*, or time out. A program proved this way is then turned into ordinary OCaml. SPARK's prover is this same machinery with Ada in front of it, so the Ada build and this one stand on one base.

## What it showed about the model

### 1. The story, read mechanically

`runs/22-story-run.txt`, as (condition : piece):

| row | note 22's column | what the conditions give |
|---|---|---|
| 0 S0 | empty | empty |
| 1 08:30, E5 fails | c1 known wrong; u1 rests on it | 4:c 5:u |
| 2 09:00, fork F | "c1′ is fine. But u1 needs the stronger conclusion." | 4:c 6:e 2:u 5:u 5:T |
| 3 10:00, F rewound | as at 08:30 | 4:c 5:u |
| 4 10:30 | c2 unchecked; T not read whole; u1 written against c1 | 4:c 5:c 6:k 2:u 5:u 5:T |
| 5 11:00 | T's whole read; u1 | 6:k 2:u 5:u 5:T |
| 6 11:30 | c2 unchecked again | 5:c 6:k 2:u 5:u 5:T |
| 7 12:00 | T's whole read; u1 | 6:k 2:u 5:u 5:T |
| 8 13:00 | whole reads of T and U | 6:k 5:T 5:U |
| 9 14:00 | empty: close, S1 | **6:k** |
| 9′, with affirm(k2, e1) added | | empty |

Two places the prose and the conditions part, both of which `01-common-reading.md` said to watch for:

- **Row 2: "c1′ is fine" is not what condition 4 says.** The defect found in c at c1 has not been looked for in c1′, so c carries a guard there (4:c). And e1 was not looked at beside c1′ (6:e). Fork F is further from stationary than the story's sentence suggests. (Under draft 4's own wording, where a guard is met "for good", this would be the same at row 2: nothing has yet met it.)
- **Rows 4 to 9: k2 was never looked at beside e1.** The story writes k2 and never says so. Mechanically S1 is not a checkpoint; one more affirm makes it one.

I expect the earlier forks found both. I have not read their files to check, by arrangement.

### 2. A function and its sentence are two texts, and here the tool keeps them equal

This is Why3's native way of seeing, and it is the answer to something the OCaml account left open. There I wrote one function per sentence (`pulled_out.ml`) and tested it against the model. Here the sentence is not a comment. `finding_applies` is a recursive function over the line, and beside it stands

> there is, on the line, evidence about p that failed and that applies

as a formula with "there is", and the two are proved equal for every line (`finding_applies_means`). The same for "every read is as it was read" and "it is set aside". Each of those proofs is a two-line recursive function that the solvers finish.

So the model's conditions can be held as a sentence *and* as a function with a machine keeping them the same, in a language that then becomes OCaml. That is one text doing two jobs, which is the thing the first spike found every combination of languages lacked.

What it does not do: three of the notions here have no sentence shorter than their function. "p's selected version" is its latest write; "the guard is open" is a nest of when-and-since. I wrote those as functions only. Whether a notion has a sentence apart from its computation turned out to be a property of the notion, and the ones without are the ones that read the order of events.

### 3. Good news does no harm, for one condition, for every line

`good_news_adds_no_finding`: record one more piece of evidence that holds at the end of any line, and no finding applies that did not apply before. Proved, for every line and every piece, not for lines up to a size. It took four small lemmas, each saying one thing is unmoved by such an event (the selected version; what is set aside; whether reads are as they were; whether evidence applies), and each of those is by induction that had to be written as a recursive function by hand.

This is one half of one condition. The guard half, the fixed point, and the other conditions are not proved. I am reporting the shape and the cost of one, not a result about the model: the Ada build proved the general statement and this does not add to it.

### 4. What makes a function stop

Following slots from the roots, and following *predicated on*, are each written here with a number of rounds, because WhyML will not accept a recursion without something that decreases. The slice's `canon_of` then *checks* its own answer and declines to answer if the check fails, and its contract promises exactness only when it answers. The lead guessed that if these tools said anything new about the model it would be here, and I think it is modest but real: **the model has never said why reading canon terminates**, and the honest contract a tool can prove without that argument is "sound always, exact when the answer is closed". An engine could carry exactly that check.

### 5. The general was easy and the particular was hard

For every verisectorium, the contract of `canon_of` went through nearly at once. That canon *in the README's instance* is c, d, k, T, O needed eleven stepping-stone lemmas. Solvers reason about functions; they do not run them. For a model whose daily question is "what is owed in *this* state", that is the wrong way round: the tool's proof effort goes where an engine needs none (run the function), and is cheap where an engine cannot go (all states). So the two do not compete.

### 6. A false statement gets the same answer as a hard true one

`mutations/false-statement.mlw` drops "that holds" from the good-news statement, which makes it false. Alt-Ergo, Z3 and E each timed out, exactly as they do on a true statement that needs a lemma. Asked for a counterexample, Alt-Ergo's reply was "Sorry, we don't have a good counterexample for you :(". Nothing in a run tells a false claim from an unfinished proof. This is the Ada builder's "says yes or it says nothing", reached from the other side, as one would expect of the same machinery.

### 7. Three words

`at`, `reads` and `label` are reserved, and I had used all three as names. `at` is Why3's word for the value something had at an earlier labelled point; `reads` is its word for what a function depends on. The model's "as it then stood" and "what it read" are, in this language, built in, for program variables. I did not find a way to use the built-in ones for the model's purposes (the model's "then" is a time on a line, not a point in a program), and I record it only because it is the nearest any of these languages comes to having the model's own nouns.

### 8. Content

`"…within any ε of it"` is not a legal string. A sentence of a claim, with a Greek letter in it, had to be escaped byte by byte. Content is opaque here as everywhere, and in this language it is also ASCII.

## What the guesses came to

From `../00-guesses-before-running.md`, guess 2 (Why3):

- "The conditions go down as logic functions and predicates much as SPARK took them, and the solvers discharge statements over bounded data quickly." **Held, and better than guessed**: nothing here is bounded. Lists are of any length and the statements are for all of them.
- "Anything that needs induction needs a lemma function written by hand; the solvers alone time out on it." **Held.** Also true of induction over the canon rules, which is not a lemma function but a transformation asked for by name.
- "E adds little behind Why3 that Alt-Ergo does not already do." **Held, and it is less than little.** E proved 21 of the slice's first 40 obligations where Alt-Ergo proved 35, failing even "this list is shorter than that one"; and 24 of 36 in M0's sentences, none of them one that Alt-Ergo had missed. What was needed behind Alt-Ergo was Z3.

Not guessed: that no single solver would do (Alt-Ergo and Z3 each failed on obligations the other proved, in both files); that the built-in interpreter would fail on both programs; that proving an instance would be the expensive part.

## What I would want an independent reader to try to break

- **That my M0 is M0.** I wrote it from `01-common-reading.md` in one pass, and nobody has compared it with the other forks' encodings. In particular: I put condition 6's item on the dependent piece (k), and "rests on" uses a fixed number of rounds equal to the number of pieces.
- **The statement in §3.** It is about `finding_applies l l p` with the new event appended at the *end*. Evidence recorded with an earlier time and inserted mid-line is not covered, and with M0's lines as lists in time order that case would need a different statement.
- **§2's claim that "one text does two jobs".** The sentence and the function are both in the `.mlw` file and proved equal, but the OCaml that runs is a third text, produced by extraction, and I am trusting Why3's extraction for that step.
