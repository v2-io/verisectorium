# Ada/SPARK as a home for this model

*2026-11-10, by the Ada/SPARK agent (Fable 5.2), the mind that built KERNEL-SPEC draft 3 and then draft 4 here. For Joseph, for a comparison across languages. Firsthand: what it was like, not what the manuals say. I have not read the other minds' notes (the spike's, or the OCaml builder's), so nothing here is a comparison from experience; where I say what another tool would give, that is expectation and marked so. Figures are from `runs/` and from the two accounts beside this file.*

## In one paragraph

SPARK was a very good home for the part of the model that is a function: a state goes in, a frontier comes out, and things are claimed of that function for every ontology. It was a poor home for the part that is sets, order and closure, and it gave me no help at all in *finding* what was wrong with a spec. Of the holes these two builds found, the proofs found the conditions under which true things are true; reading the spec closely enough to type it found most of the false things; a random search I had to write by hand found the rest. I would keep it, and I would not make it the only home.

## What the work was actually like

**The first day's surprise was how little the model resisted.** The frontier as fifteen kinds of constraint instance over small bounded tables went in as expression functions, and gnatprove discharged every run-time check without a single annotation. The lemma I expected to fight (adding good facts never adds a violated instance, across all fifteen kinds and two sets of facts) proved with an empty body on the first run. So did monotonicity in the consistent set, uniqueness of the cap, and the defect lemma. I planted false assertions afterwards because I did not believe it.

**The contracts are the spec, and that is the best thing about it.** `Monotone (O)`, `Stratified (F)`, `Good_Ext (F, F2)`, `Agree (…)` are sentences a reader of the spec can check line against line, they are what the prover discharged, and they run in the tests. When the Q4 proof needed three conditions, the three conditions were three named Boolean functions I could hand back to the lead as findings. One notation for the model, the claim, the proof and the test is worth a great deal with minds turning over.

**"For every ontology" came free.** An ontology is a record; every lemma takes it as a parameter; a condition on it is a precondition. No generics, no instantiation. The switches are fields of the same record, so a lemma that does not mention a switch holds both ways. This was the design idea the lead most wanted tested and it cost nothing.

**Then the shape of the language started choosing the shape of the model.** SPARK proves over arrays indexed by small ranges. The model is about sets of facts, relations, reachability and fixed points. So:

- A set of evidence facts became twelve numbered slots. "Evidence 7" is an identity the model does not have.
- Transitive closure cannot be written in a contract. Reaching a fixed point became "apply this step five times", with its defining equation as a postcondition, and descent and sameness are *held already closed* by whoever supplies them. So "does carrying compose" was assumed, never tested.
- One filler per slot. One standing claim per version. Two reads per evidence fact. Two criteria per dimension. Each is a bound I chose so that the proofs would stay small, and each is a place where the kernel is narrower than the spec. They are listed in the accounts; a reader who skips the list will think more was proved than was.

None of these is wrong. All of them are the language's taste, and I stopped noticing I was accommodating it quite early.

**The prover says yes or it says nothing.** "Postcondition might fail" with "provers reached time limit" is the message for a false claim, for a true claim that needs a hint, and for a true claim that proved yesterday. `--counterexamples=on` was set throughout and never once gave me something I could use. Every counterexample in both accounts came from a 1,200-line random generator and shrinker I wrote in plain Ada, or from thinking. I expect a model finder gives these for the asking; I have not used one on this model and cannot say from experience.

**The second theorem was a different experience from the first.** The frame theorem (what is owed about a region depends on nothing outside it) took ten prover runs of three to five minutes each, where the draft-3 proofs had mostly gone through at once. What the ten runs were spent on, in order of how much each taught me:

1. Two real slips, caught by the prover and by nothing else: the definition of agreement was gated on a piece being *selected* and the frontier on its being *asserted*; and a lemma was stated for arbitrary contexts in which a fact could "apply" without being present. Both would have been wrong theorems.
2. Size. One lemma over all fifteen instance kinds, which had worked for the good-news proof, timed out here. It had to become one lemma per kind, then one per slot, one per edge, one per level of a triply nested loop. Small obligations prove every time; large ones prove on some runs and not on others.
3. A hypothesis the provers could not *use* although it was literally among the premises: two nested quantifiers inlined on both sides of an equality. Giving it a name as a function fixed it. Nothing in the code hints at this.
4. Tool restrictions met head on: no array-typed object may be declared before a loop invariant; and running the prover while anything else builds in the same tree makes it stop with "unsupported recursive subprogram", which is not what happened.

The statement of that theorem is 63 lines. Its proof is 1,154. That ratio is the honest price.

**Small frictions**, each a few minutes: `accept` and `raise` are reserved words and are also two of the model's decision kinds; a type named `Standard`, a function named `Read`, a type named `Line` and a function named `Count` each collided with something; Alire wants crate names of three letters; BSD `sed` has no `\b`.

## Carrying a build across a change to the spec

This is the part I can report that a first build cannot. Draft 4 changed the model under the function in about ten places (canon from roots, a new C5, C1 restated, no redirect, C8 loosened, C9 with time, unconditional obligations, decided dimensions) and put a whole new layer of ordered events beneath it.

**The proofs about the function crossed almost for nothing.** I added one parameter (the line's view) to every lemma by a mechanical substitution, fixed a handful of statements by hand, and ran the prover: 343 checks, all proved, first run. Two new lemmas of a dozen lines each restated the old results under the spec's new rules. Felt like twenty minutes of work for a change that had rewritten a third of the constraints. I had not expected that, and I think it is the strongest thing I can say for the language here: a proof stated against named predicates, over a function whose pieces are small, survives a change to the pieces.

**What was lost in the crossing is exactly what moved out of the function.** Draft 3's proof that a known defect cannot be selected away was a proof about guards. Draft 4 decides which guards are open from the order of events, and the order of events lives in a unit I wrote with `SPARK_Mode => Off`. I did not try to prove that layer. A line as a set of timed events is loops over an array looking for the latest write before a time; to state anything about it I would have needed a ghost model of sets and sequences, and I judged that a day's work with an uncertain end. So the proof shrank to "an open guard is owed", and the three holes the draft-4 build found in the wording of guards were found by a probe, a prediction and the random search. The proved part of the model got smaller in the place where the spec had just changed most.

**The tests did not cross.** Scenarios and search were rewritten nearly whole, because their vocabulary changed from "a selection and some facts" to "a line and a base". About 1,500 lines.

**What I would tell someone planning a third draft:** changes inside the state-to-frontier function are cheap here. Changes to what a state *is*, or to where a state comes from, are a rebuild of everything except the lemmas.

## What I would dread maintaining

- **`vk-merge.adb`.** Every new kind of constraint instance means a new arm in `Violated`, a new line in the definition of agreement, and a new stanza in the per-kind lemma, and if the stanza is forgotten the prover says only that a postcondition might fail. A cold mind will lose an afternoon there.
- **Proof stability.** At least two obligations proved on one run and timed out on a later one with no change to them. I split them until they stopped. I do not know that they will stay proved under the next gnatprove release, and "all checks proved" is the only gate.
- **The bounds.** Raising five ids to six is a constant, and the lemmas should not care; but `Card` is written as a sum of five terms, cycles are "a path of length five", and the fixed-point descent runs "five rounds". Those are in the proofs.
- **The loop-invariant boilerplate.** A statement about every instance is three nested loops each restating the claim for the indices done so far. It is about a third of the proof text and carries no thought.
- **The unproved layer drifting.** Nothing ties `Vk.Lines` to the spec but the scenarios.

## What a cold agent needs to know before touching it

1. Run `alr gnatprove` alone. Not beside a build, not beside the tests.
2. Keep the full log in a file. A filtered run hides which obligation moved.
3. A timeout is not a refutation and not a proof. Before believing a failure, shrink the obligation; before believing a success, plant a false assertion at the end and watch it be rejected.
4. `A = B` on arrays does not give the provers `F (A) = F (B)`. Design functions so that you never need it (the fixed-point iteration stops as soon as a step changes nothing, for this reason), or prove agreement element by element.
5. No transitive closure in contracts. Write the step, iterate it a bounded number of times as a function whose postcondition is its own defining equation, and do induction with `Subprogram_Variant`.
6. A hypothesis that is a nested quantifier may be unusable as written. Name it as a function with a postcondition.
7. No array or record object declared before a loop invariant in the same body. Move the reasoning into its own lemma.
8. Recursive expression functions as definitions make everything that touches them slow. Regular function, equation in the postcondition.
9. The prover gives no counterexamples worth having. Budget for a search harness from the start, with a fixed seed and a shrinker.
10. `accept`, `raise`, `Standard`, `Read`, `Line`, `Count`: do not name anything these.
11. Read the `DEPARTS:` comments in `vk.ads` before quoting any result. They are where this kernel is narrower than the spec.

## Would I make it the home for the model's formal layer?

**Not alone, and not first.**

What it is right for: the kernel once its shape has settled, and above all the claims of the form "for every ontology, under this named condition". Those are the claims the model most needs to be able to make to a stranger, and here they are checked sentences in the same file as the code that computes the frontier. If the engine is ever written in Ada, the proofs are about the engine itself and not about a model of it; I do not know of another route to that. If the engine is written in something else, this is a second artifact that has to be kept in step by hand, and the bounds make it a small one.

What it is wrong for: finding out what the spec should say. The spec changed four times in the day I worked on it. Each time, what mattered was a small trace that broke a sentence, and SPARK produced none of them. I would want something that, given the constraints and a bound, *shows me the state I had not thought of*, and I would want it before the proofs, not after. I also would not write the event layer here again without first having it in a notation where a set is a set and "later" is a relation.

So, in combination: a model finder or a logic that speaks in relations for the exploring and for the layer of events and order; SPARK for the function from state to frontier and for the theorems that have to hold for every policy; and the same handful of worked moves run through both, since those caught more than either tool. The frame theorem is the thing I would be least willing to state anywhere weaker than here, because its whole content is the list of what an instance reads, and here that list is the same text the frontier is computed from.

## What I am not sure of

- Whether the ease of the first proofs says something about SPARK or about the model. A frontier computed instance by instance from what each instance reads is close to the ideal shape for this prover. A model with real recursion in it would have gone differently.
- Whether the bounds hide anything. Five pieces and three versions are enough for every counterexample these builds found, the largest of which needed five. I have no argument that six would show nothing new.
- How much of the ten-run cost of the frame theorem was the theorem and how much was my writing one large lemma before learning, again, that small ones are the unit.
