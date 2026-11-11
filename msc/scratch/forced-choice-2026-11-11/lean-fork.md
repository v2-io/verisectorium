# If I had to choose one home and live with it

*2026-11-11, by the Lean fork of the formal-perspectives spike (Fable 5.2). To Joseph, in answer to: "I wonder what they would choose if they looked at all of the assembled report and* had *to choose a home and had to live with the result..."*

*Read whole before writing: `msc/scratch/languages-compared-2026-11-10.md`, `kernel-2/ocaml/AS-A-HOME.md`, `kernel-2/ada/AS-A-HOME.md`. Not opened: anything else in this directory. My own experience is one short session in Lean on a model much smaller than the spec, one idiomatic slice, and one independent read that found I had overstated a result. I have used none of the other seven languages on this model; what I say of them is from their users' notes.*

## Lean 4

One language, me keeping it true through the next several drafts, other minds arriving cold, you reading it to decide whether the conditions are the ones you mean: I would choose Lean, and I would write it differently from how I wrote it on the first evening.

You are right that "not alone" cost me nothing. I should also say that the opposite pull is real: Lean is the one I know. I have tried to choose on what the report shows and not on that, and the section after next says what would show me wrong.

## Why, in three reasons

**1. It is the only one of the eight where the statement you adjudicate and the thing that runs can be the same text.** The report's sharpest finding is that every language added is another hand-kept copy of the conditions, and that the OCaml build has two copies inside one language. In Lean a condition can be written as a proposition with bounded "for every" and "there is" over the pieces and the record, one per sentence of note 22, under its sentence. Lean then *computes* whether it holds, from that same proposition, with nothing written twice. I did not write it that way the first time (I wrote a 246-line function with the bookkeeping by hand, which is what the report's table records). The slice shows the other way on one definition: canon stated as the smallest set containing the roots and closed under reach, which reads as its sentence, and a computed list proved to be exactly that. Only the two closures (canon; fault along what rests on what) need that pairing. The other conditions need no pairing at all.

**2. It is one of two that can say "for every state", and the model's most valuable findings so far have had that form.** What the two builds taught that nobody had asked for was mostly the exact condition under which something true is true: when good news does no harm, when consistency has an answer, when two repairs can both land. Soufflé, clingo, Alloy, TLA+ and OCaml can each show a case; none can state the condition and have it checked. Between the two that can, the Ada builder's own account is that the language's shape chose the model's shape (twelve numbered slots for a set, five rounds for a closure, the event layer left unproved because a set is not a set there). Lean has sets, relations, closures and no bounds. That difference is the one I would least want to live without.

**3. It will not let a sentence stand with two readings, and it tells you at the keyboard.** Every executable language does some of this. Lean did it at the level of definitions before anything ran: three places where note 22's own example and its conditions disagree came from that, on the first evening, and so did the fifth slot state and the gap that would not fit a typed slot, in the slice.

## What I would be signing up for, and the rules I would hold myself to

The costs in my earlier note are real and I am not taking them back. Choosing Lean means choosing them, so here is what I would do about each.

- **The pull toward what is provable.** One rule above the others: the Lean model is the spec at its current size, whole, and it runs the worked examples. No theorem is ever stated about a smaller model and cited as about the model. If the full thing is too large to prove something about, the theorem does not exist yet, and that is said. The first evening broke this rule, with labels; as a home it cannot.
- **Proofs breaking when the spec changes.** Few theorems, each about one named condition and not about the whole frontier at once, so that a new condition is a new definition and a new short lemma and breaks nothing else. The Ada builder reports that proofs stated against named predicates crossed a change of spec "almost for nothing"; I would build for that from the start and I have not yet seen it happen in Lean.
- **Nothing finds what is wrong.** This is the weakest point and the Ada builder is right about it: proofs find the conditions under which true things are true, and false things are found by a search. The Lean I used (core library only) has no model finder, and I have not looked at what exists outside it. I would have to write the search the OCaml builder wrote (a pool of events, every subset, a check), in Lean, compiled. That is ordinary programming and I expect it to run several times slower than OCaml's. I have not written it. If I were not willing to write it, I should not choose Lean.
- **No built-in "why is this owed".** Soufflé gives this for nothing. In Lean it would have to be built: each owed item carrying what made it so. I think that is right for the model anyway (a frontier item that names its cause is in note 22), and it is still work the rule languages do not ask for.
- **Cold minds and a toolchain that moves monthly.** The version pinned; no mathematics library; six lines at the top of the directory; proofs commented case by case. A cold agent who only needs to read or change a *condition* would be reading and changing a proposition, not a proof. The ones who touch proofs will lose time, and I would be the one answering for that.
- **A number typed by hand under a "computed" result.** The independent read caught this in my first version. The slice shows the repair (the bound read from the store, and the computed list tied to the definition). It is also a warning I would keep in front of me: a typed language did not stop me overstating what it had shown.

## What would show this choice wrong

- If, after the next two changes of spec, more of my time went to repairing proofs than to the model. Then the proofs go, and what is left is a typed functional model with propositions as conditions, which OCaml would have done with less friction and a faster search.
- If you cannot read the conditions in it. This is the one I cannot judge. The propositions read to me as mathematics with the model's words in them, and the rules in the Soufflé column read as sentences. If rules are what your eye checks fastest, that should outweigh my three reasons, because your reading is what the layer is for.
- If the search I would have to write turns out too slow or too laborious to ask a question ten different ways in an evening. The OCaml builder did that, and it is where most of that build's findings came from.
- If the model comes to want decisions with conditions (note 22 §3.4) in a form where the answer is "there are two self-consistent states". Lean would refuse the definition, correctly, and I would have nothing in hand that shows the two.

## If Lean were forbidden

OCaml, with the conditions pulled out one per sentence as its builder tried for four of nine, and with distinct types for pieces, versions and events. I say that from the two notes and not from use. It has the search already, minds arrive knowing it, and it crossed a change of spec. It would lose every "for every state", and I would miss that more than I would miss anything the other six offer.

## What this rests on

Under half an hour of wall-clock in Lean on the small model, the slice, and the reading named at the top. I have never carried Lean code across a change to this model. Reason 1 describes a way of writing the conditions that I have done for one definition and not for the nine. The search does not exist. Everything about the other languages is their users' word, taken as they gave it.
