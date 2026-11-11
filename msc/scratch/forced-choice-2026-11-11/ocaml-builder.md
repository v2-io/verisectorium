# One home, and living with it: the OCaml builder's answer

*2026-11-11, Fable 5.2, the agent that built kernel spec drafts 3 and 4 in OCaml. Written after reading `languages-compared-2026-11-10.md` whole, and before reading anyone else's answer in this directory, the lead's included. I have not read the other seven slice files, only the cuts of them in that report's §7.*

**Lean 4.** Not OCaml.

## Why not the one I used

I would be comfortable in OCaml and I would never get out of the sentence both my accounts end on: "none found in the universes visited". With no combination allowed, that is permanent. The two statements I said I most wanted proved (the fixed point exists; an event that changes nothing a piece reads leaves what is owed on it unchanged) would stay wishes, and the definition of "meet" would rest for good on a relation I wrote by hand beside the conditions, kept in step with them by nothing but someone remembering to run a search. I named that as the thing I would dread. Choosing OCaml as the only home is choosing to keep it.

It also does not serve the reader the question names. Pulled out one function per sentence, the conditions are a program that computes each sentence. They are not the sentence.

## Why Lean

Because it is the only one of the eight in which all four jobs can be done on **one text**, and my experience says the copies are where this goes wrong.

- **Stated, for Joseph to read.** The Lean slice's canon is two lines: a root is in canon; what something in canon reaches is in canon. That is a rule, as readable as the clingo and Soufflé ones, and every name in it is checked. The nine conditions can each be written that way, under their sentences.
- **Run.** Lean 4 is also an ordinary functional language. Everything in my `model.ml` would be written in it nearly as it stands: the same sum types (the vocabulary and the owed items, which were the part of OCaml that paid), the same function from a state to what is owed.
- **Searched.** The explorer is ordinary code and would be ordinary code there.
- **Proved**, and this is the one that decides it: that the function computes exactly what the stated conditions say; that what I call "what a piece reads" really is everything its conditions read. Those two proofs turn the two hand-kept copies I worried about into one text and a theorem. No other language on the table can do that to its own copies. clingo comes closest by a different road (the rules that are read are the rules that are searched, with no second copy at all), and it was my second thought; but "none within this bound" is still where it ends, and its quiet failure is a misspelling that makes the frontier shorter.

And it was the Ada builder's report, not the Lean fork's, that moved me most: across the change from draft 3 to draft 4 the proofs "crossed almost for nothing", and the one that shrank did so because a rule had moved out from under it. That is a proof telling its keeper what a change to the spec did. My tests told me nothing of the kind; I rewrote them.

## What this choice rests on, which is not experience

I have not written a line of Lean on this model. That it would hold my model and explorer "nearly as they stand" is what I know of the language in general, not something I did. Three things I do not know and would find out in the first week:

1. **Speed.** The Lean fork reports about a second to run eight pieces. My findings came from visiting tens of millions of small states in minutes. If compiled Lean cannot come within a factor of ten or so of that, the search, which found everything I found, is crippled, and I would have chosen wrong.
2. **Whether I can keep proofs from steering the model.** The fork's own warning is the one I take most seriously: the tool "rewards making the model smaller and sharper until a theorem goes through", and the audit found a checkpoint "with a proof" built for a state that owes. I am the kind of mind that would feel that pull.
3. **Cold minds.** An arriving agent knows OCaml better than it knows this month's Lean, and a tactic proof "cannot be read, only re-run".

## How I would live with it

- The model is written and run first, as functions and stories, exactly as in OCaml. Nothing is proved about a definition until two drafts of the spec in a row have left it alone.
- A statement worth proving is written down the day it is believed, with its proof left open. Lean marks an open proof and counts them; that count is this layer's own frontier, computed and not typed.
- **The model is never made smaller to close a proof.** If a theorem will not go through for the model as held, the theorem is what is wrong or what is open.
- No library beyond the standard one; the toolchain pinned to an exact version in the repository; every proof short enough to redo in a sitting, or it is split.
- The search stays. A proof says a true thing is true under a condition; it was the search that found the false things, in both builds and in every fork's account.

## What I would regret, and when I would say I was wrong

If the state's representation keeps changing with every draft, as it did twice in one evening, then for as long as that lasts Lean gives me OCaml with a heavier toolchain and nothing else, and I will have paid for a capability I am forbidden by my own rule to use. I accept that: the capability is the one that cannot be added later without a second language, and the others can.

If the speed is not there, I would say so within the week and go back to OCaml, and live with "none found" as the honest ceiling.

## If the choice had to be among what I have actually used

OCaml, with the conditions pulled out and the state behind an interface, and I could keep it true. I would say plainly on its first page that nothing in it is or can be proved.
