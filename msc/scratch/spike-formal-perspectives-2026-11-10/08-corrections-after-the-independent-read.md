# What I did about the independent read

*2026-11-11, spike agent (Fable 5.2). `de-novo-feedback-1.md` is a cold read of this directory as committed at `599199d` and `4fa250e`, by an agent given a bare brief. I read it whole. I re-ran its probes 1a, 1b, 1c and 7 myself and all four came out as it says (`datalog/runs/19`). It is right in nearly everything, and its main point is the one I would least have seen from inside: the perspective files were careful and my debrief was not; qualifications the forks wrote did not survive my summary of them.*

*The lead relayed claims from the first debrief to Joseph before the read came back. Whatever in them differs from the debrief as it now stands, the debrief as it now stands is what I hold.*

## Accepted, and changed

| its finding | what was wrong | what I changed |
|---|---|---|
| 1a | "The second fault shows as owed with no clause written for it." I wrote a clause for it. | `DEBRIEF.md` item 1 rewritten; `datalog/PERSPECTIVE.md` §2.5; plan §2; `05` |
| 1b | Two of the four faults I credited to the causal footing come right on the clock with the guard reworded. On one line the two orders are the same order. | the same; the reader's reworded guard is kept as `datalog/causal/m0-clock-guard-reworded.lp` |
| 1c | The case where the footing does real work with no clause was not among mine. | the reader's case is now `datalog/causal/merge-guard-*.lp` and is the one the debrief leads with, credited |
| 1d | Costs of the footing not reported: a pass with foreign reads answers a guard; `replaces` is unchecked and can unselect another piece; "answered since" and "later than the finding" are gone. | stated in the debrief and in §2.5 |
| 1e | Two of the faults are faults of a close rule the spec does not have. The lost rewrite is the literature's *lost update*, which I did not name. | debrief item 1; `03` §1 |
| 2 | "S1 is not stationary by the letter" left out that core's «changeset» rule says it is reached as told; three perspectives pointed at it. I held S0 and S1 to different standards. "All four found it" was one reading of mine encoded four times. | debrief item 6 rewritten as two wordings giving two answers; plan §3 |
| 3 | "The rule forbids" an upstream-conditioned acceptance. It does not; draft 4 gives acceptances conditions. "Locally stratified" is the wrong name for the finer test. Items 2 and 3 pull against each other (the ring and the circular waiver are the same shape). | debrief items 2 and 3; `datalog/PERSPECTIVE.md` §2.2, §2.3; plan §2 |
| 4 | The good-news row was read off the rules for a flag only; I left out the two rows where the same script says "either". | `datalog/PERSPECTIVE.md` §2.4; debrief; `05` |
| 5 | "The nine conditions are rules" is six of nine. | debrief; plan §4; `datalog/PERSPECTIVE.md` §5 |
| 6 | The 2.5 million states behind "stationary as of its last close" check something true by construction. | debrief item 5 |
| 7 | A defect in `m0.lp` condition 5: a canon piece resting on a piece outside canon was marked at fault and nothing was owed. | corrected in `m0.lp`, `causal/m0-causal.lp`, `polarity/m0-split.lp`, `souffle/m0.dl`; resting-on-fault is now waivable like any other item. Runs 01, 02, 07, 08, 09, 15, 16, 17 re-run and unchanged |
| 8 | The four small models are four functions that agree on the story. | said in the debrief's preamble; round 12's dependence on one rendering said in the Alloy paragraph |
| 9, Lean | a checkpoint can be had for a state that owes by setting a bound too low; the fault theorems are about an abstract step and not M0's function; "close enough cannot be built" is the construction's premise | debrief, Lean paragraph and item 2; plan |
| 9, Alloy | round 13's instance has no parts; the lost-rewrite reproduction is degenerate; "fourteen" counted round 0 | debrief |
| 9, `03` | I drew more from the Bailis theorem than it gives; the nogood is not on record as tabled | `03` §1 and §3; debrief |
| 9, "core used to say it" | it is in core now | plan |

I did not edit the three forks' perspective files, except `tla/PERSPECTIVE.md` for the one fraction its own maker asked me to correct. The reader's points about `lean/` and `alloy/` are for those files' makers or for whoever lands anything from them.

## Where I do not agree, both small

- **The quotation.** The report says my "unsettledness spreads along what rests on what" is a blend of two sentences in core. It is one sentence, from `core/def/frontier.md`: "Unsettledness spreads only along what rests on what". I dropped the word "only", which is my error and now mended, but the sentence is core's.
- **Debrief item 4** (the two atoms). The report says the instruments returned what the encodings were given. For the first half, yes. I would still put the second half in front of Joseph as more than a restatement: the kernel's remaining differences between evidence and decisions are choices of the lead's, and the difference the atoms were named for is in the part set aside. The report says this too, so the disagreement is only about weight.

## What I would say of the spike now

The exemplars and their logs are what they say. The largest claim I made from them was overdrawn and has been cut back to what one good case, not mine, supports. The most reliable things here are the ones that are close to their runs: each `PERSPECTIVE.md`, each `AS-A-HOME.md`, and the report itself.
