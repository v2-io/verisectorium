# E as a home for the model

*2026-11-11, by the fork that used E 3.1 on its own (Fable 5.2, a fork of the spike lead, who built the kernel in OCaml). One sitting, one mind. `PERSPECTIVE.md` beside this says what E showed about the model; this says what it was like and whether I would live in it.*

**No. Not as the home, and not as a standing part either.** It is the one tool on the OCaml side I would put down after tonight. What I would keep from it costs nothing and needs no tool, and is at the end.

## What the work was like

**Getting it.** Already there: one `opam install eprover` by the lead, into the switch with Rocq and Why3. A single binary, no configuration, no project file. The lightest thing on this side.

**The first ten minutes were the best.** The slice went down as typed first-order logic in about a hundred lines and E answered "canon is O, T, c, d, k and nothing else" in 0.03 seconds. The file reads well. A rule of the model is one line, and so is its converse; I would show `canon_root`, `canon_step` and `canon_only` to Joseph without apology.

**Then it stopped being about the model and became about E.**

- My first run of the slice timed out after ten seconds on a question a person does in their head. The cause: TPTP has a word for "these names are all different", `$distinct`, and E 3.1 reads it as an unknown relation. Nothing said so. The status was `ResourceOut`, which is also what a hard problem looks like. I found it only by asking smaller and smaller questions until `e1 != e2` failed. One of them, "c and d are different", *succeeded*, because their content strings differ and quoted strings are the one thing E takes as distinct. So for a few minutes E knew two pieces apart by their content and could not tell O from U.
- A name used twice at different types (`c2`, a version and a condition) gives `eprover: type error`. No file, no line, no name.
- Asked whether the story's first row is stationary, with the small model's four conditions written as definitions and the row's fourteen events given exactly, E did not answer in 20 to 40 seconds under any of four search settings. Asked the eighty-five smaller questions underneath, in the order a rule engine would compute them and with each answer handed back as an axiom, it took one to five minutes a row through row 8; on row 7 it left undecided a question it had decided on rows 4, 5 and 6; and on row 9, twenty-eight events, it left eighteen of ninety-three undecided after seventeen minutes, whether the state is stationary among them. I wrote that ladder; its order is the stratification the model has and E does not know about.

**What it is actually good at I used for perhaps a quarter of the sitting**, and it was the part worth having: statements about *every* state, with nothing given. Those came back in well under a second, both ways: "this follows" and, more often than I expected, "this does not follow, and here is why the search ended". See `PERSPECTIVE.md` §3.

## What I would dread

- **Three statuses that mean "no answer" and one that means "not a consequence", and telling them apart is the whole skill.** `ResourceOut` and `GaveUp` say nothing about the model. `CounterSatisfiable` says the axioms do not entail the claim, which is often a fact about how I wrote the axioms. A cold mind will read the first as the second, or as "false".
- **Every closing is written by hand, and a missing one is silent.** That two names differ; that a relation has exactly these tuples; that nothing else is in canon. Leave one out and true things stop being provable, with a timeout as the only sign. Put one in wrongly and false things become provable, with `Theorem` as the sign.
- **Row files nobody can read.** The state of row 9 is 11 KB of `(E = ev3 & Q = d & W = d1) | …`. I generate them with a script, so the script is a second statement of the story, and nothing checks it against the first.
- **Speed that falls off a cliff.** Seven pieces and one rule: 0.03 s. Eight pieces, fourteen events, four conditions: a minute, with help. Twenty-eight events: seventeen minutes and no answer.

## What a cold agent needs to know

- `opam exec --switch=rocq-try -- eprover --auto --cpu-limit=N -s FILE`. Always a limit.
- `Theorem`: it follows. `CounterSatisfiable`: it does not follow from what you wrote. `ResourceOut`, `GaveUp`: nothing was learned.
- `$distinct` does nothing in E 3.1. Write the inequalities.
- The opam build is first-order only. Higher-order input needs E rebuilt from source with `--enable-ho`. I did that in the scratchpad (23 seconds); `PERSPECTIVE.md` §4 has what it showed. That binary is gone when the scratchpad is; `runs/ho-build.txt` is how to make it again.
- Names live in one space across all types.
- When a true thing will not prove, look for the closing you did not write before you raise the time limit.

## Would I make it the home, alone or with others?

Alone: no. It cannot run a state at the story's size, and in first-order form cannot say "least" or "greatest". (Its higher-order form can say "least", and proved two things from it in a fraction of a second; I took that no further than canon.) It cannot say "none this small".

With others: I would not keep it standing. Its one real strength, deciding quickly whether a general sentence follows from the conditions as written, is something Why3 can call on it for, from a language that also has data types, closed worlds and recursion. If the Why3 fork finds E useful behind Why3, that is where it belongs. I did not test that and it is the Why3 fork's to say.

One thing I would say for it against my own verdict. For "does this general sentence follow from the conditions as written?", it was the fastest instrument I have used on this model, in either direction: six for-every-state theorems in under twenty seconds each, and two "does not follow" in a twentieth of a second. If the conditions ever sit in a prover as definitions, pointing E at a proposed sentence before trying to prove it would cost almost nothing.

## What I would keep, with no tool

Writing the model for a prover that assumes nothing made a list, and the list is about the model:

1. **Everything computed in the model reads absence as information.** "No later write." "No applying evidence." "Not provisional." "Nothing else in canon." The model's rule that standing is computed and never typed is only as good as the record being *all* of the record. First-order logic makes you say "these are all the writes" each time. The model says it nowhere, and core's "never asked is a warrant" is the nearest it comes.
2. **The model picks a fixed point twice and first-order logic can see neither choice.** Canon is the least set closed under the rules; consistent is the greatest set with no grounded reason against it. Both are choices about rings, and a logic without them proves nothing about rings either way.
3. **Identity by content is what you get for free, and it is the wrong one.** The only distinctness E gave me unasked was between two pieces whose sentences differ.
