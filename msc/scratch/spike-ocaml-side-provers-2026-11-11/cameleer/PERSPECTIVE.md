# Cameleer and GOSPEL: what specifications on the OCaml itself showed

*2026-11-11, by a fork of the OCaml builder (Fable 5.2). I began with everything the spike lead had read and with its guesses (`../00-guesses-before-running.md`), so what agrees with those is one expectation tested, not a second opinion. Nothing here is a fact about the model until it is adjudicated in core.*

## What this tool is

Cameleer takes an ordinary OCaml file whose comments carry a specification (GOSPEL: the comments that open with an at-sign), translates both to Why3, and Why3 sends each obligation to a solver. Here the solver was Alt-Ergo. The file stays an OCaml file: any compiler runs it, and the specification is invisible to the compiler.

## What was run, what was read, what is a guess

**Run, by me, tonight** (every output whole in `runs/`, numbered in order):

- The build of Cameleer, three attempts (`runs/01`–`08`, times in `runs/clock.txt`).
- The slice: `../../idiomatic-slice-2026-11-11/cameleer.ml`, run as OCaml and checked (`runs/20`–`22`).
- A cut of the small model M0: `m0.ml`, with nine lemmas stated of every state; checked by `./m0-check.sh` (`runs/30`–`34`); the story of note 22 §4.3 run through the same functions by `m0_story.ml` (`runs/36`).
- One lemma the solver would not prove, checked by brute force in plain OCaml (`runs/35`).
- `sealed.ml`: plain OCaml with no tool, a checked record and an abstract checkpoint (`runs/41`, `42`).
- An opam dry run for GOSPEL's run-time checker, Ortac (`runs/40`). Not installed.

**Read:** Cameleer's README, `cameleer.opam`, its `TODO.md`, and four of its example files, to learn what it accepts.

**Not done, and so guesses where I speak of them:** Cameleer on OCaml 5.5 (I went straight to 4.14.2); Ortac at run time; Why3's own IDE and its saved proof sessions (it needs GTK, which I did not install); any solver but Alt-Ergo 2.6.2 and one try of Z3; higher-order code, exceptions, mutable state, modules or functors under Cameleer; guards, the fixed point of consistency, forks, canon inside M0.

## Getting it

Cameleer is not in the opam repository. What worked, in a switch of its own (`cameleer-try`, 1.0 GB):

| | |
|---|---|
| OCaml | 4.14.2 |
| GOSPEL | pinned to the commit Cameleer's own opam file names (`c20125ae`), not a released version |
| cmdliner | held below 2 (the pinned GOSPEL uses its old interface; with 2.1.1 it does not compile) |
| Why3 | 1.8.2 (against 1.9.0, Cameleer's plugin does not compile) |
| Alt-Ergo | 2.6.2 (what that combination resolves to) |
| not installed | `why3-ide`, `lablgtk3`: the opam file lists them, the code does not use them, and I built with `dune build -p cameleer` to leave them out |

About six minutes of wall clock from the first command to the first proof; the third attempt was the one that built. The lead's guess was that it would not build on OCaml 5.5; I did not test that. What I found instead is that it builds only against one unreleased commit of one dependency and not against the current release of another, which is a narrower window than "an older compiler".

Why3 keeps its list of solvers in `~/.why3.conf`. I kept mine in `why3.conf` in this directory (the environment variable `WHY3CONFIG`), because the Why3 fork is using a different Why3 in a different switch and the two would overwrite each other.

## What it showed about the model

### 1. A condition can be one text that is both run and reasoned about

This is the thing I did not expect, and it bears on the question the earlier spike's lead left open (whether the OCaml model with its conditions pulled out could be the home).

In `m0.ml` each condition is an ordinary OCaml function marked `[@logic]`:

```ocaml
(* Condition 4, first half: a finding applies to p. *)
let[@logic] rec known_wrong (p : int) (evs : evidence list) (sel : (int * int) list) : bool =
  match evs with
  | [] -> false
  | e :: r -> (e.subj = p && (not e.holds) && applies e sel) || known_wrong p r sel
```

The mark lets the specification speak of the function itself. So the lemmas below it are about the very text that `m0_story.ml` runs. There is no second statement of the condition for the proofs to drift from. In the OCaml build I had a model and, beside it, a hand-kept account of what each condition reads. In Lean and Rocq there is a stated definition and a function proved equal to it. Here there is one.

The price is that the condition must be written the way `pulled_out.ml` was, and plainer: explicit recursion over lists, no closures, integers compared with `=`. I did not test how much of ordinary OCaml the tool takes; I wrote to its examples and stayed inside them.

### 2. Locality, proved for every state, with the read set as its premise

`m0.ml` states and the solver proves, for every list of evidence and every selection:

- a write to q changes which version of q is selected and of nothing else;
- evidence that did not read q stands exactly as it stood after q is written;
- **if p is not q and no evidence about p read q, then a write to q changes neither whether a finding applies to p nor whether p is checked.**

The third is graded locality in miniature: the statement the spike lead said it most wanted proved, for two of the conditions and one kind of event. Each proof is structural induction on a list, named on the command line, then Alt-Ergo, in about 0.03 seconds.

What it says about the model: the premise is a function, `reads_of p q evs`, "some evidence about p read q". That function is the read set of those two conditions. It is still written by hand. But it is no longer kept in step by remembering: if it left something out, the lemma would not go through. The proof is what ties the account of what a condition reads to the condition.

### 3. Canon needs a reason to stop, and the model has never given one

Why3 will not accept a recursive function without a measure that goes down. Following pointers through a store has none: the spike lead learned earlier tonight that OCaml will build a ring, and its first `canon` did not return. So the function counts down a number of passes (one more than the number of pairs), and what is proved of it has two parts:

- everything it returns is in canon, for every input (`canon_list`, postcondition);
- any list that has the roots and is closed under one step contains all of canon (`closed_has_canon`, by induction on the two rules).

`canon_checked` returns the list only if it passes the closedness check, and its postcondition is then "x is in the list if and only if x is in canon". That the count of passes is always enough is true, I believe, and is not proved here; when it is not enough the function says `None` and never a wrong answer.

In the model's words: canon is defined as the least set, and nothing in core or the spec says what bounds the search for it. The bound exists (the number of assemblies) and nobody has had to name it, because every build so far used a visited set and did not have to say why that terminates either.

### 4. "Refused" becomes "no proof was found", and that is quieter than it sounds

In `ocaml.ml` a step in the formal-claim slot is a type error with a message. Here a kind is a value, "only a claim fills this slot" is an invariant under the record, and building a result is four obligations. Put a step in the claim slot and one of the four comes back:

```
Sub-goal Precondition of goal t'vc.
Prover result is: Timeout (10.00s, 755218 steps).
```

It does not say which line of the invariant, and it does not say "false". A deliberately false lemma (locality with its read-set premise removed, `try/m0_false_locality.ml`) gives the same word. So does a lemma I believe true and could not get through (`a_read_lapses_in_the_list`: four attempts, two solvers; brute force over 8,388 small cases finds no counterexample). Three different situations, one output. The Ada builder reported the same thing of SPARK, which is the same engine.

### 5. A lemma that was not proved is still used

Why3 hands each lemma to the goals after it as an assumption, whether or not it was proved. `a_read_lapses` reports `Valid`, and its proof leans on `a_read_lapses_in_the_list`, which timed out. Nothing in the output connects the two. A reader of the log who counts `Valid` lines would count it. In this estate's terms: a result standing on an unchecked premise, shown as checked.

### 6. The proof is partly outside the file

Which lemmas need induction, and on what, is in `m0-check.sh` and `../../idiomatic-slice-2026-11-11/cameleer-check.sh`, as command-line flags. The specification language has no place to say it. Why3's usual answer is a session directory kept by its graphical tool, which I did not install. As it stands, a lemma "holds" only together with a shell script that knows how to ask.

### 7. The story

`m0_story.ml` runs note 22 §4.3 through the cut. Its conditions are a finding applying (half of 4), being checked or read whole (half of 5), and a reference written against a version the target no longer has (2).

| row | note 22's column | this cut |
|---|---|---|
| 0 | empty | nothing owed |
| 1 | c1 known wrong; u1 rests on it | c known wrong. (Resting is not in the cut.) |
| 2 | c1′ is fine; u1 needs the stronger conclusion | u unchecked (its check read c1); u written against another c; **T not read whole** |
| 3 | as at 08:30 | c known wrong |
| 4 | c2 unchecked; T not read whole; u1 written against c1 | the same, and u unchecked |
| 5 | T's whole read; u1 | T not read whole; u unchecked; u written against another c |
| 6 | E7 read d2: c2 unchecked again | the same, plus what row 5 still owes |
| 7 | T's whole read; u1 | as row 5 |
| 8 | whole reads of T and U | T and U not read whole |
| 9 | empty | nothing owed |

Two places the mechanical reading says more than the prose. At row 2 the fork's c1′ also lapses T's whole read, which the note does not mention. And from row 2 on, u is *unchecked* as well as *written against another c*: its check read c at the old version. The note's "u1 needs the stronger conclusion" is about content, which no tool here can see.

What the cut cannot show is as much the point: with no guards, row 4's rewritten c carries nothing from the finding, where the full model has it carry a guard until row 5.

### 8. With no tool at all

`sealed.ml` is plain OCaml. A derived result as a *private* record: readable and matchable everywhere, buildable only by a function that checks the kinds, and a forgery is a compile error (`Cannot create values of the private type`). A checkpoint as an abstract type whose only maker computes what is owed and refuses if anything is. The second is "computed, never typed" as a fact about how a value came to exist. It is an engineering guarantee: nothing proves that the maker's check is the model's.

## Against the guesses

The lead's third guess had three parts.

- *"It does not build on OCaml 5.5 and needs an older compiler."* Not tested. It built on 4.14.2, on the third attempt.
- *"It accepts code written like `pulled_out.ml` and refuses code written like `model.ml`."* The first half held. The second I tested only by accident: one line that prints stops the tool with an internal error (`anomaly … Assertion failed`, `runs/17-t3-with-print-line.log`), which is why the slice's printing is in a second file.
- *"Specifications read as comments beside the code, further from the model's sentences than a prover's definitions."* Wrong for the conditions (finding 1: the condition is the code, and there is nothing beside it). Half right for canon, whose two rules are in a comment, and read as rules.

The sixth guess (if any tool finds something about the model, it will be about termination) held here: finding 3.

## What I would want an independent reader to try to break

- Whether `reads_of` is really the read set of the two conditions, or whether the locality lemmas are true for a reason that would not survive adding `same` events or set-asides.
- Whether the slice's `canon` (over integer pairs produced by `reach_store`, which carries no specification) is the slice's canon. The proofs are about pairs; that the pairs are the slots is read, not proved.
- The claim that the count of passes always suffices.
