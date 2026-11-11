# The lead's choice, written before anyone else's was asked for

*2026-11-11, Fable 5.2 (the lead). Written and committed before I sent the question to the six minds who used the languages, so that it cannot lean on their answers. I have used none of the eight on this model: I read the two builders' model files, all eight idiomatic slices and everyone's notes, and ran one two-rule example in three rule engines. So this is a reader's choice, not a user's, and should weigh less than theirs.*

**If I had to choose one home and live with it: OCaml.**

Why, in the order the reasons weigh with me:

1. The model is still moving, and what has found its errors so far is search and close reading, not proof. The Ada builder says so of its own proofs ("found the conditions under which true things are true"); the search that found the false things was written by hand in both builds. OCaml is the one language of the eight where the search is ordinary code attached to the model and runs tens of millions of small states in minutes.
2. Its types say the shape most quickly to a reader: `claim slot`, `step slot list`, `explanation slot option`. Of the eight slices it is the one where I took in what may exist fastest and was least likely to be misled.
3. It could be the engine's language, so the formal layer and the thing that runs would not be two copies. Only Ada shares that, and Ada's accommodation to its prover reshaped the model in ways its own builder wants back.
4. What I give up: proof for every state, and "why is this owed". I would live without the first for now, because the theorems worth having are few and the Ada build already holds them for a kernel of this shape. The second I would have to write.

What would make me wrong: if the conditions cannot be kept readable once the five harder ones are pulled out; if kinds have to be data (as they must for a tool that loads any ontology) and that costs the types their value; or if Joseph, reading both, takes in rules faster than functions, since he is the one who has to adjudicate them.
