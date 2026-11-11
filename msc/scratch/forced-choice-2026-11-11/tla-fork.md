# If I had to choose one home and live with it

*2026-11-11, by the TLA+ fork of the spike (Fable 5.2). Written before opening anything else in this directory (I saw two filenames in a listing, `lead.md` and `ada-builder.md`, and read neither). Read whole for it: `msc/scratch/languages-compared-2026-11-10.md`, and the two builders' notes (`kernel-2/ocaml/AS-A-HOME.md`, `kernel-2/ada/AS-A-HOME.md`). Not read: the Lean and Alloy forks' own notes, or the spike lead's `07-datalog-family-apart.md`; for those languages I have the report's cells and the slices in its section 7. One thing was run for this note and is marked.*

## The choice

**Answer-set programming, in clingo.** Not the language I used, and one I have not run this model in. I would take it knowing that.

## Why, under the terms as given

The terms: one language; I keep it true through the next several changes to the spec; other minds arrive cold; Joseph reads it to decide whether the conditions are the ones he means.

What those terms weigh most is not what each of us was weighing when we said "not alone". We were each asking what our tool was best at. The question here is which single loss is survivable, and for how long the model will go on changing. From the evidence assembled, the model is still at the stage where the work is finding which sentences are wrong. The Ada builder says it most plainly: the proofs "found the conditions under which true things are true", and the false things were found by reading closely and by a search written by hand; the spec changed four times in a day. So I ranked by what serves that stage.

1. **The conditions have to exist once, and read as their sentences.** Every one of us found that a second copy drifts with nothing to say so, and the OCaml builder found it inside a single language (the list of what each condition reads, kept beside the conditions). Rules are the only form in the report where a condition is one statement that both computes and reads as the sentence in note 22, and where "what does this condition read" is the body of the rule and not a second text. That narrows it to Soufflé or clingo.
2. **I need the search inside the language.** Everything the builds and the spike found came from asking for a small state that breaks a sentence. What I used TLC for (every interleaving of two forks, the shortest trace to a bad state) is an ordinary question in clingo: choose which events happen, constrain, minimize. Soufflé runs one state and cannot ask. If the home cannot search, the search gets written in a second language, and under these terms there is no second language.
3. **A second reading of the spec has to cost a few lines from outside.** In TLA+ the most useful thing I had was nine configurations comparing three close rules. The report says clingo does the same with a file of one to three lines and a diff of the two frontiers. With the spec still changing (four times in the day the Ada builder worked on it), that is most of the maintenance.
4. **It does not refuse the model's own §3.4.** Note 22 says decisions have conditions. Strict Datalog cannot hold a decision conditioned on how something stands; clingo holds it and shows what it means (one answer, none, or several). The builds made that a rule about ontologies. Whether it stays one is Joseph's to decide, and I would want the home to be able to show him both sides.

## What I am giving up, and I mean giving up

- **Proof.** Nothing in this home will ever say "for every state". The Ada frame theorem and the Lean results would stand as things once shown about earlier drafts, in languages I no longer keep. Every general claim I make from then on is "none found within this bound". I think that is the right loss for now and I am not sure it stays right: once the conditions stop moving, this is the first thing I would regret.
- **Declarations.** Soufflé checks every relation against a declared vocabulary; clingo checks nothing. The report's warning is that a misspelled relation is silently empty and the frontier just gets shorter. I checked the tool on this before choosing (clingo 5.8.3, a two-rule file with one misspelling): it does print "info: atom does not occur in any rule head", and then prints the answer anyway. So the guard exists and is easy to miss. I would have to make that message fail the run, and I would be relying on a wrapper for something a type checker gives for nothing.
- **Kinds in types.** OCaml and Lean refuse a step in a claim's slot at compile time. Here it is a row in a relation of things that do not fit. I count that as closer to the model (a state is allowed to be wrong for a while), and it is still a loss of help.
- **"Why is this owed", built in.** Soufflé has it as a prompt. In clingo I would write it.

## What I would dread

That the missing declarations bite exactly when a cold mind renames something during a spec change, and the example still passes because the rule that went quiet was not one the example exercised. My whole defence is the story from note 22 §4.3 kept as a test with the frontier expected at every row, plus the info message made fatal. In TLA+ I had the same disease (no types) and the same defence, and it held for one evening on a small model. I do not know that it holds for a year.

And speed at size. I have no firsthand number. The report gives "under a second" for the example. Searching interleavings in TLC cost me minutes for three pieces; I expect clingo to be better because order need not be carried as timestamps, and that is an expectation, not a measurement.

## Why not the others, in a sentence each

- **TLA+**, mine: no. It has nothing to say about data or the conditions, and I said so before being pressed.
- **OCaml**: the only home that has actually survived a change of spec, and the strongest rival. I leave it because Joseph cannot adjudicate the conditions by reading it, its own builder says so, and the pulled-out form that would fix that is, in the builder's words, "nearly rules already".
- **Lean**: the only single language that holds the shapes, runs, and proves, and if the model were settled I think I would choose it. With the spec still moving, its user names the pull toward cutting the model until a theorem goes through, the audit caught one instance of it, and it cannot search for what is wrong.
- **Ada/SPARK**: its builder would not put it first, for the reason I rank by: it shows nothing you had not thought of.
- **Soufflé**: the nearest miss. Same rules, checked names, explanations. No search, and it refuses conditioned decisions outright.
- **Alloy**: the search without the speed; three minutes for the example the others run in under a second.

## How much this is worth

One mind's forced answer, for a language it has only read about on this model, chosen partly because the report's cells for it describe exactly the two things I valued most in the tool I did use. That is a reason to suspect I am choosing my own experience under another name. The piece I would most want checked before anyone acted on this: write the two-fork question I ran in TLC (`spike-formal-perspectives-2026-11-10/tla/MCForks.tla`) in clingo, and see whether the lost rewrite and the clock case come out as readily. If they do not, my second choice is OCaml with the conditions pulled out, and I would say so without much reluctance.
