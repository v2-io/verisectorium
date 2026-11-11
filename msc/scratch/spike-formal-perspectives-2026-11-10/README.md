# Spike: what other formal languages see in the model

*2026-11-10/11. A spike commissioned by the verisectorium lead for Joseph, done by a Fable 5.2 agent and three forks of it. Scratch: nothing here is part of core, nothing here has been verified by anyone but its maker, and nothing here is a fact about the model until it is adjudicated in core.*

## The ask

Joseph, 2026-11-10: "Would you launch a fable agent to do the research and understand core/ and your kernel spec and write up exemplars in a spike directory for at least Lean 4 and Datalog, then one of Alloy or TLA+? A few examples of what can be done with the languages / proof mechanisms etc. might be good but I'm even more interested in each language's perspective on the model we have..." And, a little later: "give it allowance to research/find/incorporate other things as well".

So the product is not four encodings. It is what each language's native way of seeing shows about the model: what it makes obvious, what it refuses, what it cannot say, what it would rename.

## Read in this order

1. **`DEBRIEF.md`**: to Joseph. What was found, in the model's words. Start here; everything else is behind it.
2. `01-common-reading.md`: the small model (M0) and the one story every instrument ran. M0 is my reduction of `msc/notes/22` Parts 2 to 4 and kernel spec draft 4; the story is note 22 §4.3.
3. One perspective per instrument, each self-contained, each saying what was run, what was read and what is a guess, with the commands to re-run it:
   - `datalog/PERSPECTIVE.md`: rules and facts (clingo, Soufflé, SWI-Prolog).
   - `lean/PERSPECTIVE.md`: types and proofs (Lean 4).
   - `alloy/PERSPECTIVE.md`: relations, and a solver that looks for counterexamples (Alloy 6).
   - `tla/PERSPECTIVE.md`: states and steps (TLA+ with the TLC model checker).
4. `03-other-bodies-of-work.md`: five fields that already hold parts of this model (databases, truth maintenance, build systems, logic programming, and smaller ones), with how well each claim about them was checked.
5. `02-guesses-before-running.md` and `05-what-the-guesses-came-to.md`: what I expected before any tool was installed, and what became of each expectation. Three were wrong.
6. `proposed-integration-plan.md`: suggestions, with reasons, and first of all what an independent reader should try to break.

## What exists

| directory | made by | what |
|---|---|---|
| `datalog/` | the spike lead | M0 as 55 rules; the story; six small looping programs under three semantics; a reader of the rule graph; two forks; a conditioned acceptance; M0 again with no rule reading the clock; 18 run outputs |
| `lean/` | a fork | M0 as functions, the story pinned row by row, seven files of definitions and proofs (1,273 lines), three mutations that must fail |
| `alloy/` | a fork | M0 as relations with no recursion; the story as one fixed world; fixed points against reachability; a long sequence of attempts to say when two forks do not meet, each with the world that defeated it |
| `tla/` | a fork | M0 as a specification; the story; a two-fork universe; 21 configurations and their outputs |

The forks were forks of the lead: they began with everything the lead had read and with the lead's guesses. Agreement between two instruments here is one mind's expectation surviving two different tests, not two minds agreeing.

## What was installed, and how to get it back

All at user level; nothing was added to the repository except this directory; no shell profile was changed.

- Homebrew: `elan-init`, `clingo`, `souffle`, `openjdk` (`brew install elan-init clingo souffle openjdk`; log in `runs/00-brew-install.log`). The JDK is keg-only: `/opt/homebrew/opt/openjdk/bin/java`.
- Lean 4.35.0 through elan, in `~/.elan` (`lean/PERSPECTIVE.md` has the command).
- Two jars, fetched by the forks and not tracked: Alloy 6 and `tla2tools.jar` (each perspective has the fetch command).
- Already present and used: SWI-Prolog, Python 3.

## What this spike did not touch

Intake, "better", who did anything, delivery. Every instrument ran the *stabilize* part of the workflow, because that is where the kernel is. That is a limit of the spike and is said once here.

Nothing in `core/`, the kernel spec, or the two builders' directories was changed.
