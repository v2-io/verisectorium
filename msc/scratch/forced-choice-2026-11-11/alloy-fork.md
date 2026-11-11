# Forced choice: the Alloy fork

*2026-11-11, by the Alloy fork of the formal-perspectives spike (Fable 5.2). Written without opening anything else in this directory. Read whole before writing: `msc/scratch/languages-compared-2026-11-10.md`, `lean/AS-A-HOME.md`, my own `alloy/AS-A-HOME.md`. Not read: the OCaml and Ada builders' notes (I have them only through the comparison's cells), the TLA+ fork's note, any of the other seven slice files except as excerpted in the comparison's section 7.*

## Lean 4

One language, mine to keep true, cold minds arriving, Joseph reading it to decide whether the conditions are the ones he means: I would choose Lean 4. I did not use it on this model. Its own user said "not as the home", and I have read why. I am choosing it against that, so the reasons have to be mine.

**Not Alloy.** That is not modesty. The note's own thirty-one-event example took three minutes to evaluate with nothing to search for. A home has to run the thing it states.

**Why not the one I think is second, Soufflé.** It is the most honest single copy: one rule per sentence, instant, typed names, says why an item is owed. If the formal layer's only job were to be read and to run, I would choose it and be comfortable. What I did all evening was something else. Thirteen times I wrote a sentence about the model that I believed, and thirteen times a small world showed it false. The spec's four drafts changed for the same kind of reason: someone found that a general sentence was false, or found the condition under which it was true. A home that can state a rule and cannot ask whether a sentence about the rules is true would leave me, alone with it, believing things. I would be transcribing discoveries made elsewhere, and there is no elsewhere in this question.

**Why Lean, living with it.**

1. *It is the only one of the eight that can do all four jobs in one file format*, each worse than a specialist: say the shapes, run a state, search small worlds (it is a programming language; the search is a plain program, as the OCaml builder's is), and prove a sentence of every state at any size.
2. *It labels its own claims, by machine.* A theorem that is stated and not proved carries `sorry` and the build says so every time; a theorem that leans on an assumption shows it when asked. So "proved", "stated and owed" and "tried on these cases" are three things the toolchain tells apart without anyone typing a status. Every other language here leaves that to a comment. This is the model's oldest rule (how well a thing stands is computed, never typed) applied to the formal layer itself, and under turnover it is the property I would least want to be without. The vacuous pass I got from Alloy, and the status typed by hand that Soufflé accepts, are the same failure, and Lean is the one place it is structurally harder.
3. *A proof that checked yesterday checks today.* The toolchain is pinned in a file. The Ada builder reports obligations that proved once and timed out later unchanged; I could not live with that as the copy of record.
4. *Joseph can read the conditions,* if they are written the way the Lean slice wrote canon: as an inductive proposition, one constructor per sentence. `root : r ∈ roots → Canon r` and `step : Canon r → q ∈ out r → Canon q` are rules, in a mathematician's notation, and he is one. And a proof of "this piece owes" is then itself the reason it owes, which gives back most of what Soufflé's explanations give.

**What I would be signing up for, and the rules I would set myself.**

- The Lean fork wrote the conditions as a 246-line function with the bookkeeping by hand, and that is not readable against note 22. I would write the nine as inductive propositions first, the runnable checker second, and tie the two by a theorem, or by a visible `sorry` until it is proved. That link is real work at every change to the spec. If it lags, I have two copies inside one language and have gained nothing over a combination. This is the likeliest way my choice fails.
- No library. Toolchain pinned. No more theorems alive than one mind can re-prove in a sitting. These are the Lean fork's rules and I would keep all three.
- The pull toward what is provable, which the Lean fork names and which has already happened in this project without Lean: the workflow (bring in, cut, adjudicate, stabilize, build on) stays on the first page, and a cut made to get a theorem through is written down as a cut.
- I would lose Alloy's one-line questions. Asking for a counterexample would mean writing a generator, as the OCaml builder did, with the risk that builder names: a check that silently has nothing to check.

**What I do not know.** Whether the checker runs at the size of a real segment (the fork's 1.2 seconds for eight pieces was the proof kernel evaluating; compiled Lean should be far faster, and I have not measured either). Whether agents arriving cold keep proofs alive or let them rot into `sorry`; the tool would at least show which. Whether decisions with conditions (note 22 §3.4), which strict Datalog refuses, can be stated in Lean without the definition being rejected; the fork's result says the looping ones are rejected, which I count as right, and the non-looping ones were not tried.

**What would make me wrong.** If, after the next three changes to the spec, no theorem has mattered to a decision of Joseph's and the link between the propositions and the checker is mostly `sorry`, then the honest home was Soufflé, and I should have taken the plainer thing.
