# Cameleer and GOSPEL as a home for the model

*2026-11-11, from the fork that used it (Fable 5.2). One evening, one mind, a cut of the small model and the slice. I have maintained none of this across a change to anything.*

## The short answer

Not as the home. As evidence about the OCaml home, it changes what I would say: the route from "the OCaml that runs" to "for every state" exists, I walked a short way down it tonight, and it was less far than I had assumed.

## What the work was like

**Getting it** was archaeology. Three attempts in about six minutes: the compiler I picked was fine, the pinned commit of GOSPEL would not compile against the current command-line library, and then Cameleer would not compile against the current Why3. Each failure was a type error in someone else's code that told me which dependency to wind back. Nothing in the README says any of this. It ends at a tool pinned to an unreleased commit, needing a compiler three major versions behind the kernel's, with its opam file asking for a graphical toolkit its code does not use.

**Writing for it** was pleasant in a narrow lane. I wrote OCaml as a careful beginner would: explicit recursion, lists of pairs, integers. Inside that lane almost everything went through on the first or second try, and the first time it proved "a write elsewhere leaves p's findings alone" for every state, in three hundredths of a second, I was surprised.

**What I learned to do**, none of it written down anywhere I looked:

- Cameleer's own batch mode gives a solver the obligations nearly whole, and Alt-Ergo times out on anything about a list. Calling Why3 directly on the `.ml` file with `-a split_all_full` gets all of them. That one flag was the difference between 18 of 21 and 40 of 40 on my first real file.
- A lemma about a recursive function wants `-a induction_ty_lex`; a lemma about an inductive predicate wants `-a induction_pr`. Each has to be given per lemma, from outside the file.
- The pattern for a constructor with two arguments is written the Why3 way in specifications (`Filled (Holds v) _`) and the OCaml way in code (`Filled (Holds v, _)`), in the same file.
- A recursive function used in a specification needs `[@logic]`, and then needs no separate predicate.

**What fought me.**

- `Timeout` for three different things (see `PERSPECTIVE.md` §4). I spent longest on a lemma I am fairly sure is true, and have nothing to show for it but a brute-force run that agrees.
- A line that prints is an internal error with a source location inside Cameleer.
- The obligation that an invariant can be satisfied at all (`derived_result'vc`) is never proved, by either solver. I do not know how to give it a witness in this specification language.
- No feedback on a wrong construction beyond the line range of the whole record.

## What I would dread maintaining

**The toolchain, before anything else.** It works tonight against one commit and two held-back versions. The first `opam upgrade`, or the first arriving agent who installs it fresh from the README, gets a type error in GOSPEL's command-line parser. I would expect to lose a day to it within a few months, and the kernel's own compiler (5.5.2) is outside what even GOSPEL's released tools accept: its run-time checker will not install there at all (`runs/40`).

**The shell scripts that hold the proof steps.** A lemma is proved by a file plus a flag in another file.

**The count of `Valid`.** A lemma that timed out is still an assumption for everything after it, silently (`PERSPECTIVE.md` §5). Under turnover, a log with thirty `Valid` lines and one `Timeout` near the top will be read as thirty proved things.

**The lane.** Everything I proved is about first-order functions on lists of integers. The kernel's real conditions read warrants through references and take a fixed point. I do not know whether they fit; my guess is that warrants do and the fixed point needs more than a flag.

## What a cold agent needs to know

- The switch is `cameleer-try`. Do not upgrade it. The versions that work are in `PERSPECTIVE.md` under "Getting it".
- Set `WHY3CONFIG` to the `why3.conf` in this directory, or Why3 will read and write `~/.why3.conf`, which another switch's Why3 may own.
- Use the two check scripts, not `cameleer --batch`.
- `Timeout` means "not proved", never "false" and never "true but hard". Before believing a lemma is false, run it: the file is OCaml, and a brute-force loop over small cases is ten lines (`try/brute_lapse.ml`).
- Read the log from the top. Anything after a lemma that timed out may be resting on it.
- Keep printing out of any file Cameleer reads.

## Would I make it the home?

No, and the reason is the first item under dread, not anything about the idea.

The idea is better than I expected and I want to say so plainly, because the lead's forced choice assumed it away. Of everything tried on this model that I know of, this is the only arrangement where **the conditions that run in the fast OCaml explorer are literally the text the lemmas are about**. Lean and Rocq prove a function equal to a definition; that is stronger and it is two texts. Here there is one, the solver stack is the one SPARK proved 656 checks with, and the two statements I proved are small versions of the two the OCaml builder said it most wanted.

But a home has to be there next year. This one is a research tool held together by a pinned commit, and the specification language's released tools do not accept the kernel's compiler.

**What I would take from it.** If the home is OCaml, write the conditions in this lane anyway: `pulled_out.ml`'s style, first-order, one function per sentence. That costs little, reads better, and keeps this route open. And if the Why3 fork finds that WhyML itself is pleasant, that is the maintained road to the same solvers, at the price of the conditions being in a second language.

**In combination**, as an instrument: for stating and proving a handful of "for every state" lemmas about the pulled-out OCaml, with the scripts and the pinned switch kept as they are and the lemma list kept short enough to re-prove in a sitting. I would use it for that tomorrow.

## What I did not do

Try OCaml 5.5 for Cameleer. Install Ortac. Install Why3's IDE or use a saved session. Try CVC5, or E behind Why3. Write guards, the fixed point, canon or forks in the M0 cut. Test anything higher-order. Prove that the count of passes suffices. Read any sibling fork's files.
