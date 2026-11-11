# Why3 as a home for the model

*To Joseph, 2026-11-11, from the Why3 fork of the OCaml builder (Fable 5.2). One mind, about forty minutes of use, a slice and a small model. I had never used Why3 on this model before tonight. I have not read the other forks' notes.*

## The short answer

As the place where the conditions are **stated, run and proved in one text**: closer than anything else I have used on this model, and I did not expect that. As the home alone: no, for two reasons I can name from the evening and one I can only suspect.

If my forced choice were being made again tonight, Why3 would be in it, as a third candidate beside Lean and "Rocq and the OCaml it extracts to". It would not win. It would be the one I would pick if the rule were "the conditions stay as programs that run, and proof is added to them where it is cheap".

## What the work was like

**Getting it.** `opam install why3 alt-ergo eprover` into a fresh switch, about ninety seconds, done by the spike lead before I started. `why3 config detect` found the solvers. It also found a Z3 already on the machine, said its version was not recognized, and used it; without that accident four obligations in the slice and three in the small model would have stayed open with what was deliberately installed.

**Writing it.** Like writing OCaml with fewer conveniences. Types, records, pattern matching and recursion are the same. What is missing is closures: every walk over a list is its own named recursive function. The slice is 394 lines where my OCaml one is about 230 of code.

**Proving it.** The surprise was how much goes through with nothing said. Of 149 obligations across the two files, I wrote help for about a dozen: a stated intermediate fact, a case split, a contract cut into its two directions. The rest the solvers finished in hundredths of a second. Every recursive function proves its own sentence by its own recursion, so "induction" is mostly just writing the function.

**The best thing.** A function with its sentence above it, and a machine holding the two together. `canon_of` says: *if I answer, my answer is canon exactly, for any verisectorium*. `finding_applies` has beside it "there is evidence about p that failed and that applies", proved to be the same thing. This is `pulled_out.ml` with the test replaced by a proof, and it then becomes OCaml that looks hand-written (`extracted/`; it kept even the kind tags on veritoids).

**What fought me.**

- **Three reserved words** (`at`, `reads`, `label`), each reported only as "syntax error" at a column.
- **A Greek letter in a claim's text** is an illegal character.
- **The solvers disagree, and with themselves.** Alt-Ergo and Z3 each failed obligations the other proved, in both files. Two goals that timed out when run by name were proved when the whole file was run. Which solver, with which named step, for which goal, is a recipe I kept in a shell script; its proper home is a session kept by Why3's graphical tool, which I did not open.
- **The interpreter.** `why3 execute` stopped with a type error on both files, each of which typechecks, proves and extracts. I ran everything as extracted OCaml instead.
- **Concrete things are hard.** "Canon in this instance is these five" took eleven stepping stones (see the perspective file, §5).

## What I would dread

1. **A timeout is not an answer.** I gave the solvers a false statement and got three timeouts and "Sorry, we don't have a good counterexample for you". A true statement missing a lemma looks the same. Under turnover, a cold mind facing a timeout cannot know whether to add a hint or doubt the model. The Ada builder reports this of the same machinery and I can now confirm it from one evening.
2. **An unproved lemma is still used.** While `closed_has_canon` was timing out, a goal after it that leans on it was reported *Valid*. That is correct behaviour (a lemma is assumed below its statement) and it means a file's results are only as good as an accounting of the whole, which in batch use is mine to keep. This is the model's own subject, a thing resting on something not yet established, and the tool does not spread the doubt for you unless you use its session.
3. **Results that move.** A solver upgrade, a ten-second limit on a slower machine, an unrelated definition added above: any of these can turn *Valid* into *Timeout* for a goal nobody touched. I saw the mild form of it in forty minutes.
4. **The recipe.** A dozen lines of "this goal, this step, this solver". It will be wrong after the next change to the file and nothing will say which line.

## What it cannot do, or I did not find how

- **Find a counterexample.** Everything I found in the two kernel builds was found by search. This tool has no search. It would sit beside an explorer, not replace one; but since it extracts to OCaml, the explorer could be the one I already have, run over the extracted functions.
- **Say why something is owed.** No more than OCaml does.
- **Be read by someone who is not a programmer.** The sentences in contracts are plain logic and read well. They are scattered among the functions they govern, and three of the notions (the selected version, the guard, rests-on) have no sentence shorter than their code.

## Against the other two routes on this side, as far as I can say without having read their notes

- **Against Rocq.** Rocq would have proved `closed_has_canon` and the instance by saying *induction* and *compute* inside the file, with the proof kept beside the statement and checked the same way every time. Here those were flags on a command line, and the instance took a second solver. What Why3 gave that I would not expect from Rocq: one hundred and thirty-odd obligations I never had to think about.
- **Against Cameleer.** Cameleer is this same machinery reading OCaml directly. If it builds, it removes the one step I am trusting unchecked (WhyML to OCaml) and it would let the existing `model.ml` style be annotated in place. I would expect everything in "what I would dread" to carry over unchanged.

## What a cold agent needs to know

- Everything through `opam exec --switch=rocq-try -- why3 …`. `prove-slice.sh` and `prove-m0.sh` are the whole of how the two files are proved.
- *Valid* is about one goal, assuming every lemma above it. Count the timeouts in the whole run before believing anything.
- A timeout means "not proved in ten seconds by this solver", and nothing else.
- Try Z3 when Alt-Ergo times out and the reverse. E did not once prove something the others missed.
- `at`, `reads`, `label`, `old`, `result`, `variant`, `invariant` are the language's. A "syntax error" at a name is probably that.
- Do not use `why3 execute` to run these files; extract and compile.
- When a proof will not go through and the obligation looks unrelated to the function it is stuck inside, hide that function: prove the thing in a module that knows it only as "some function", then hand it the real one (`Reach` in the slice).

## Would I make it the home?

Not alone. It has no search, a timeout tells a cold mind nothing, and its results are less stable than a proof assistant's.

As the centre of a pair, I would take it seriously: **WhyML for the conditions, each with its sentence, proved where the solvers will do it for nothing; extracted to OCaml; and the existing explorer run over the extracted code.** That is two languages that are nearly one, with one copy of the conditions and a machine keeping sentence and function equal. It asks less of an arriving mind than Lean or Rocq, because most of the proving is not done by anyone. It gives less than they do at exactly the point where this model is hardest: the general statements that need a real argument (the fixed point; locality) would each be a pile of lemma functions and a recipe, with nothing but timeouts for feedback while they are being found.

What I do not know and would find out first: whether the fixed point of *consistent* can be written at all in a form these solvers handle (I used a fixed number of rounds and proved nothing about it); and whether the graded "what a piece reads" relation, which is the thing I most want proved, is within reach of this style or needs a proof assistant's.
