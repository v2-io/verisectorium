# Spike: the provers on the OCaml side

*2026-11-11. Led by the agent that built the kernel in OCaml (Fable 5.2), with one fork of itself per tool. Scratch: nothing here is part of core, nothing here has been verified by anyone but its maker, and nothing here is a fact about the model until it is adjudicated in core.*

## The ask

Joseph, 2026-11-10, to the lead's predecessor, before either kernel build: "put together some of the model in Ada (or, although we didn't try it yet, ocaml / rocq or something) and see what we can see formally". Rocq reached the OCaml builder only as an aside and was not tried. Joseph, on seeing that: "Did OCaml not use rocq as intended? what about why3/cameleer, alt-ergo, eprover, etc.?" And when told a one-hour Rocq trial was starting: "Absolutely-- have it fork again and get them all run --- same as the earlier ones, and then the snippet-style of the smaller model in the overall comparison."

"Same as the earlier ones" is read, by the lead and by me, as what `../spike-formal-perspectives-2026-11-10/` left for each language: the tool installed and run on that spike's small model and story (`01-common-reading.md` there: M0 and note 22 §4.3), a `PERSPECTIVE.md` saying what the tool's own way of seeing showed about the model, a firsthand `AS-A-HOME.md`, and the idiomatic slice in `../idiomatic-slice-2026-11-11/`.

## Who has what

| directory | tool | by |
|---|---|---|
| `rocq/` | Rocq 9.3, and the OCaml it extracts to | a fork |
| `why3/` | Why3 1.9 (WhyML), with Alt-Ergo and E behind it | a fork |
| `cameleer/` | Cameleer and GOSPEL: specifications on OCaml itself | a fork |
| `eprover/` | E 3.1 on its own, first-order | a fork |

Each directory is its fork's. Tool output goes whole into its `runs/`. `install/` holds the logs of what was installed and when.

**These are forks of one mind.** Each began with everything I had read, with `00-guesses-before-running.md`, and with my forced choice already written down. Agreement among them is one expectation surviving several tests, not several minds agreeing. The earlier spike's independent reader found that most of what went wrong there was in the step from the forks' files to the lead's summary; so each fork's own files are the record, and anything I write over them says which file it is from.

## What was installed

See `install/`. Everything is in an opam switch of its own (`rocq-try`); the working switch `kernel-2` was not touched. To remove: `opam switch remove rocq-try` (and any further switch a fork's notes name).

## Read in this order

1. **`DEBRIEF.md`**: to Joseph, written from the forks' files, with the file behind each claim.
2. `00-guesses-before-running.md`: what the lead expected before any tool had run. The debrief says what became of each.
3. Each fork's `PERSPECTIVE.md` (what the tool showed about the model, what was run, read and guessed) and `AS-A-HOME.md` (what the work was like). These are the record; the debrief is a reading of them.
4. The slices: `../idiomatic-slice-2026-11-11/rocq.v`, `why3.mlw`, `cameleer.ml`, `eprover.p`, each with notes in or beside it.

## What was installed, in full

- opam switch `rocq-try` (OCaml 5.5.2): Rocq 9.3, Why3 1.9.0, Alt-Ergo 2.6.4, E 3.1. `install/` has the logs and times.
- opam switch `cameleer-try` (OCaml 4.14.2, 1.0 GB), made by the Cameleer fork; its `PERSPECTIVE.md` has the exact versions that work.
- `~/.why3.conf`, written by `why3 config detect`. Outside the repository.
- Used and not installed by us: a Z3 already at `/opt/homebrew/bin/z3`.
- A higher-order build of E was made in a scratchpad and not kept; `eprover/runs/ho-build.txt` says how.

To remove everything: `opam switch remove rocq-try cameleer-try` and delete `~/.why3.conf`.
