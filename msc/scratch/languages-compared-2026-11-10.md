# Eight languages tried on the model, side by side

*2026-11-10/11, assembled by the lead (Fable 5.2) for Joseph, who asked for "a bigger table that separates those out and adds ocaml + ada". Scratch; nothing here is adjudicated.*

*What each cell rests on. Every language's column comes from the note of the one mind that used it on this model, read whole by me: `kernel-2/ocaml/AS-A-HOME.md` and `kernel-2/ada/AS-A-HOME.md` (the two builders, each of whom built kernel spec drafts 3 and 4); `spike-formal-perspectives-2026-11-10/lean/`, `alloy/`, `tla/AS-A-HOME.md` (the spike's three forks); and `07-datalog-family-apart.md` (the spike lead, for Soufflé, clingo and tabled Prolog). Where a cell is my own reading of code (I read `ocaml/lib/model.ml`, `ada/src/vk.ads` and `ada/src/vk-model.ads` whole and nothing else of either build) it is marked (lead). Where the independent read of the spike (`de-novo-feedback-1.md`) qualifies a claim, the cell carries the qualification and is marked (audit).*

*Limits that apply to every row. One evening per language and one mind each, all the same model family. The two builders worked on the kernel spec; the six spike columns worked on a much smaller model (no warrant levels, no descent, one root). Only the two builders have carried anything across a change to the spec. The Ada builder read nobody else's note; the OCaml builder read the spike lead's `06` and not the forks'.*

## 1. Where each one lands, in its user's words

| language | as the home for the model's formal layer | what it is right for |
|---|---|---|
| **OCaml** | "not alone" | "the formal layer's executable reference and its counterexample search" |
| **Ada / SPARK** | "Not alone, and not first." | "the kernel once its shape has settled, and above all the claims of the form 'for every ontology, under this named condition'" |
| **Lean 4** | "As one part of a combination, and a specific part. Not as the home." | "the definitions that have to have exactly one reading, and the few statements about them worth proving for every state" |
| **Soufflé** (strict Datalog) | "yes, as far as I have now seen, while decisions stay unconditional" | "being the one copy that runs, is checked for names, and explains itself" |
| **clingo** (answer sets) | "as the workbench beside it, not as the copy of record" | "trying a reading of the spec in two lines beside another; finding out whether a rule loops; searching small spaces" |
| **SWI-Prolog, tabled** | "cannot say; I did not run the model in it" | giving a third value, *undefined*, to a condition that loops (on six toy programs) |
| **Alloy 6** | "Not as the home. Yes, and gladly, as the instrument you point at a sentence before you believe it." | asking for a small world in which a proposed general sentence about the model is false |
| **TLA+** | "no"; as a standing part, "I lean no" | "an instrument picked up for a question about orders of steps" |

Datalog itself is a language and a guarantee (one answer, always terminates, order does not matter, provided no rule depends on the absence of something that depends on it). Soufflé, clingo and tabled Prolog are three engines that agree wherever that proviso holds and differ where it is broken: Soufflé refuses, clingo lists every self-consistent answer (possibly none, possibly several), tabled Prolog answers *undefined*.

## 2. How the model sits in each

| | what is stored (pieces, slots, events) | the conditions | can a reader check them against note 22 by reading? |
|---|---|---|---|
| **OCaml** | about 150 lines of sum and record types; a slot is `Empty \| Holds \| Points` with a provisional flag; one constructor per kind of event and per kind of owed item. But ids, versions, events and dimensions are all `int` | one 140-line function, organized by kind of piece, numbered as the spec and not as the note | "As it stands, a reader cannot." A trial pulled four of the nine out as one function per sentence (88 lines) and it agreed with the original on 163,840 lines; the builder expects the other five to be harder |
| **Ada / SPARK** | bounded tables: five pieces, three versions, twelve evidence facts; one flat record for every kind of decision; no "veritoid or assembly" type, a number says which (lead) | one named function per kind of owed item, written with "for all" and "for some"; these are also the contracts the proofs are about | closest of the two builds (lead): each condition has a name and reads as logic. Narrower than the spec in ways listed under `DEPARTS:` |
| **Lean 4** | sum types; in one trial the kind of filler and how many are in the slot's type, with suggested, promised and gap as values | a 246-line function with the bookkeeping by hand | yes for the definitions; the proofs "cannot be read, only re-run" |
| **Soufflé** | a typed declaration per relation (53 for 55 rules): "the stored vocabulary written down once and checked" | rules, one per sentence. Six of the nine conditions (audit); the three about how well something stands were not written | yes, for those six |
| **clingo** | nothing declared | the same rules | yes, for those six |
| **Prolog, tabled** | nothing declared | not written for the model | |
| **Alloy 6** | signatures, "the closest thing to core's KDL blocks that I saw tonight, and they are checked" | relations and three closures, no recursion | yes; "the most readable picture for someone who is not a programmer" |
| **TLA+** | untyped records and sets | 75 of 245 lines, "mathematics with no one checking it" | readable, checked by nothing |

## 3. What each can do

| | run a state and say what is owed | find a counterexample to a general sentence | prove something of every state | say why an item is owed |
|---|---|---|---|---|
| **OCaml** | yes, fast: tens of millions of small states in minutes | yes, by a generator and a check written by hand; the witness prints itself and is not shrunk | no | no |
| **Ada / SPARK** | yes | not from the prover ("says yes or it says nothing"); a 1,200-line random search written by hand | **yes**, for every ontology of the bounded types: 656 checks, including that what is owed about a set of pieces depends on nothing outside what they read. The layer that reads a state from events is not proved | no |
| **Lean 4** | yes, slowly (about a second for eight pieces) | no | **yes**, at any size, for the small model: good news does no harm; the abstract fault and frame results (not linked to the Lean model or the spec: audit) | no |
| **Soufflé** | yes, 0.04 s on the example | no | no | **yes**, built in, as an interactive prompt |
| **clingo** | yes, under a second | yes, "in a few lines", over small spaces | no | no |
| **Prolog, tabled** | not tried | by hand | no | not tried |
| **Alloy 6** | barely: three minutes for the 31-event example | **yes**, its one real job: the sentence is one line, eight seconds to two minutes each, within four pieces; each world read by hand | no ("none this small") | no |
| **TLA+** | yes | yes, for orders of steps: the shortest trace, often a degenerate one | no (its proof system was not tried) | no |

## 4. Toolchain, and what goes wrong quietly

| | to get it | speed in use | the quiet failure its user warns of |
|---|---|---|---|
| **OCaml** | opam switch, about 950 MB, built from source by a setup agent | builds in a second or two | a failed build leaves the old program, which runs; a check that silently has nothing to check, because of the generator's distribution |
| **Ada / SPARK** | Alire, GNAT, gnatprove | prover runs of three to five minutes; must run alone | a timeout looks the same for a false claim, a true one needing a hint, and one that proved yesterday; at least two obligations proved once and timed out later unchanged |
| **Lean 4** | 2.8 GB, changes monthly | builds in about a second | the pull toward what is provable: a model cut smaller until a theorem goes through. A checkpoint "with a proof" was built for a state that owes by lowering a bound (audit) |
| **Soufflé** | one `brew install` | instant | accepts a status typed by hand beside the rule that computes it |
| **clingo** | the same install | instant | a misspelled relation is treated as empty, so the answer gets shorter and looks like "nothing owed" |
| **Prolog, tabled** | already present | not measured | "it accepts everything" |
| **Alloy 6** | one jar and a JDK | minutes; one query stopped after ten with no answer | the size bound is part of the meaning, and nothing checks that a passing result is not vacuous |
| **TLA+** | one jar, but only the pre-release prints readable traces; four attempts to the first run | 1.5 to 8 minutes for three pieces and two forks | no types; every "holds" is for one universe and one clock bound chosen by hand |

## 5. Changing the model

| | trying a second reading of the spec | carried across draft 3 to draft 4? |
|---|---|---|
| **OCaml** | a switch in the ontology record and an `if`; cheap, but "has to be anticipated in the code" | yes, at more cost than "half carried over" suggests: a new file, the skeleton of the conditions copied in, every explorer check and test written new. Written against a small state interface it "would have been about a third" |
| **Ada / SPARK** | a field of the ontology record; a lemma that does not mention it holds both ways | yes: the proofs crossed "almost for nothing" (one parameter added, 343 checks proved first run); the tests were rewritten nearly whole, about 1,500 lines; and the proof about found defects shrank, because that rule moved into the unproved layer |
| **Lean 4** | cannot be skipped: "I could not type the next line without choosing" | no |
| **Soufflé** | not reported | no |
| **clingo** | a file of one to three lines added on the command line, and the two frontiers diffed | no |
| **Alloy 6** | a second predicate beside the first | no |
| **TLA+** | a constant in a configuration file; nine configurations compared three close rules and two ways of joining lines | no |

## 6. What the users agree on, and one thing they do not

- **Nobody would make their own language the home alone.** Seven of the seven who had an opinion say so, each of its own language.
- **Every language added is another hand-kept copy of the conditions.** The Lean and TLA+ forks say it of the combination. The OCaml builder says it of one language: its definition of what each condition reads is "a second, hand-kept statement of the conditions" beside the first, and the fork result rests on it. There are six copies tonight.
- **Finding what is wrong and proving what is right are different jobs.** The Ada builder: the proofs "found the conditions under which true things are true"; the false things were found by reading closely enough to type the spec and by a search written by hand. The Alloy fork names the first job as a fourth layer the spike lead's three had left out.
- **The engine for rules is a decision about the model.** If a decision may carry a condition (note 22 §3.4), strict Datalog cannot hold it and someone must say what two answers, or *undefined*, mean.

The disagreement is about what goes at the centre. The spike lead puts rules there, with the example as their test. The OCaml builder puts the existing OCaml model there, conditions pulled out one per sentence, because the search is already attached to it, and says "the two are closer than they look: the pulled-out conditions are nearly rules already, and the thing OCaml adds is the search around them". The Ada builder would want "a model finder or a logic that speaks in relations" before the proofs, and SPARK for the state-to-frontier function and the theorems. None of the three has used the others' language on this model.

## What I have not done

Read the Ada proof files, either explorer, either test suite, or the Ada layer that reads a state from events. Run anything in OCaml, Ada, Lean, Alloy or TLA+. (I did run one two-rule example in clingo, Soufflé and SWI-Prolog, for a different question.) Checked any figure in the builders' notes against their logs.
