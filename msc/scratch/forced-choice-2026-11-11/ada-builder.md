# Forced choice: the Ada/SPARK builder

*2026-11-11. By the mind that built kernel spec drafts 3 and 4 in Ada/SPARK. Written after reading, whole, `languages-compared-2026-11-10.md` and `de-novo-feedback-1.md`, which were the first I had seen of anyone else's notes. Written before reading any other forced choice, the lead's included. I have used only Ada/SPARK on this model; everything I say of the others is from that report and that audit.*

## The choice

**Ada/SPARK.** One language, and I would keep it.

I said "not alone, and not first" two notes ago. Joseph is right that it cost me nothing. Here is what I would say if it cost something.

## Why, from what I actually watched happen

Three things did the work in my two builds, and a home has to be able to do all three or I would be living with a hole where one of them was.

1. **Run states fast enough to search.** The holes in the spec that I did not predict were found by throwing a hundred thousand random lines at a sentence. From the report, OCaml does this as well or better, clingo does it over small spaces, and Lean and Alloy are too slow to.
2. **Close a claim for every ontology.** That good news does no harm under three named conditions; that consistency is well defined when obligations are unconditional; that what is owed about a region depends on nothing outside it. From the report, only Lean and SPARK can do this at all.
3. **Survive the spec changing.** Draft 4 changed about half of the nine constraints, and the proofs crossed with one parameter added and went through on the first run. I did not expect it and I have not seen it claimed for anything else in the table, because nobody else has carried proofs across a change.

Only two rows have both 1 and 2 in some form, Lean and SPARK, and Lean has 1 only barely (a second for eight pieces). So it comes down to those two, and the difference between them is who writes the proofs. In SPARK an SMT solver wrote most of mine: the lemma that carries all fifteen kinds of owed item across two sets of facts has an empty body. That automation is why the proofs crossed the spec change for nothing, and it is the same thing that makes the prover say nothing when it fails. In Lean I would have every definition with exactly one reading, no bounds, and closure said as closure, all of which I envy; and I would be repairing proofs by hand at each of "the next several changes". If I have to be the one keeping it true, I take the solver and its silence over the hand proofs and their certainty. I have lived with the silence and know what to do about it (shrink the obligation; plant a false assertion; search). I have not lived with the other, and choosing it would be choosing on someone else's report, which is its own way of being safe.

The rules languages are the ones I looked at hardest, because for Joseph reading the conditions to see whether they are the ones he means, one rule per sentence is better than anything I wrote. And Soufflé's refusal of a rule that depends on its own absence is my `Stratified` precondition enforced by the engine instead of proved by me, which I think is the more elegant place for it. But a home in which "two forks that do not meet compose" can be neither proved nor searched for a counterexample is a home where the model's general claims go back to being prose, and those claims are what the last three days were for. I would not live there alone.

## What I would be living with, said plainly

- **The prover never shows me the state I had not thought of.** With no model finder beside it, every hole is found by a search someone wrote or by reading. The search harness becomes a permanent part of the home, not a test suite, and its generator's blind spots are the home's blind spots. This is the cost I would feel most.
- **The layer that reads a state from events is not proved**, and three of the four holes in draft 4 were in it. Living here means bringing it under proof, with sets and sequences as ghost models. I judged that a day's work and did not do it; alone in this language I would have to.
- **The bounds, and the shapes the prover chose.** Five pieces; holding as an id in a table where the language itself would have had containment. I would write down, in one place a cold reader meets first, where the kernel is narrower than the spec.
- **A proof text eighteen times its statement** (63 lines against 1,154 for the frame theorem), an afternoon lost by each cold mind the first time, and obligations that prove on Tuesday and time out on Wednesday.
- **Joseph reads functions, not sentences.** The conditions are named and read as logic, and the lead found them the closest to the note of the two builds; they are still Ada. I would pull each into one function per sentence of the note and keep them in a file by themselves.
- **Nothing tells him why an item is owed.** Soufflé gives that for free. Here it is a function I would have to write.

## What would make this the wrong choice

If the next several changes are again changes to *what a state is* (as draft 3 to 4 was) and not to the conditions on one, then everything except the lemmas is rebuilt each time, and a language where the whole model is fifty rules would have been the cheaper place to wait. I am betting that the shape has mostly arrived: a state, a function from it to what is owed, each owed item computed from what it reads. The frame theorem depends on nothing but that shape, which is some evidence for the bet and not much.

And I should say what I cannot rule out: that this is the language I know choosing itself. The check I can offer is that the argument above would name Lean if I thought the proofs would be written once, and would name Soufflé if I thought the general claims did not matter. I think they will be rewritten several times, and I think they matter most.
