---
slug: impl-a-small-move
form: impl
status: provisional
narrates: [steady·state, changeset, frontier, act, reference, veritoid, segment]
---

# A small move, from one steady state to the next

*An invented example, small enough to hold in the head. It illustrates the terms; it is evidence for nothing.*

**What this shows.** One finding, three writes and five checks take a verisectorium from one «steady·state» to the next. Along the way the «frontier» says at every moment what is owed and why, a check lapses when what it read is rewritten, and a draft that was checked and then replaced is never part of any steady state.

## The material

Steady state S0. Segment T is a derived result with four veritoids: a claim c, its derivation d, a description e, and a plain-language paragraph k. Its kind says e and k depend on c. The claim asserts *exact*. Agent B, who did not write it, has re-derived c by way of d, so c's validity is warranted as *re-derived*. T has been read whole and found coherent. Segment U holds a claim u that is predicated on c and needs c to be at least re-derived. Nothing else refers to T or U.

## The run

| work time | what happens | the frontier afterwards |
|---|---|---|
| 08:30 | An auditor finds c false as stated: it needs a further hypothesis H. The ‹finding› is recorded. | S0 is disturbed. **broken**: c, by this finding. **overclaim**: c asserts exact and its warrant is broken. u's reference to c is **unmet**. |
| 09:00 | Agent A drafts: adds H to the claim, reworks the derivation, re-reads e and finds it still right, rewrites k. | Unchanged. A draft is not a changeset. |
| 09:25 | A writes a ‹segment·changeset› on T: c and d and k changed, e carried with A's affirmation. One instant; no order among the four. | The finding read the old c and no longer binds, so *broken* is cleared. B's re-derivation read the old c and d and no longer binds: c's validity is never asked at this version, and c still asserts exact, so the **overclaim** stays. T's whole read has lapsed. u's reference is **stale**, and because c was narrowed, u is asked whether it relied on what is gone; it is still **unmet**. |
| 11:00 | B re-derives the new c by way of the new d. | The overclaim on c is cleared. Owed: T's whole read; u's stale and unmet reference, and its question. |
| 11:30 | A finds an error in step 3 of d and writes a second changeset on T: d changed again. | B's 11:00 check read the d that is gone. It no longer binds. The overclaim on c is back. |
| 12:00 | B re-derives c by way of the corrected d. | Cleared again. |
| 13:00 | Agent C answers the question to U: u holds only if U also assumes H. C writes a changeset on U: u changed, its reference reconciled against the new c. | u's reference holds. u asserts exact and nobody has checked the new u: **overclaim** on u. |
| 13:30 | B re-derives the new u. | Cleared. Owed: whole reads of T and of U. |
| 14:00 | Someone who wrote neither reads T whole, and U whole. | Empty. The ‹atomic·changeset› closes. **S1.** |

## What this says about the model

- **Steady time and work time are different clocks.** On the steady line T's claim gained H and U's claim gained H at the same instant. There was never a verisectorium in which T had H and U did not. The 09:25 version of d was never in any steady state.
- **What is written is reconciled by its author at once; warrants come back one act at a time.** A could make T say the right thing at 09:25. A could not make it re-derived.
- **An act binds to what it read.** B's 11:00 check was honest and counts for nothing in S1. It is still in the acta, and it is not neutral: B passed a derivation with an error in step 3, which is something a verisectorium wants to know about B's checks.
- **An affirmation is not a check.** A's "e is still right" means only that e was not left as it was without someone looking.
- **A narrowed premise asks a question; it does not answer it.** U was not false at 09:25. It was unsupported until someone looked.
- **Nothing here needed an acceptance.** Had the whole reads not been done by 14:00, the move could still have closed, with those two items accepted for a stated reason and shown in S1's conditions.

## Working Notes
- Open. The 08:30 finding is visible only to those looking at the working state. Whether a reader of S0 should see it before 14:00 is «steady·state»'s open note on inhibiting reliance.
- Open. At 09:25 the model as written also makes U's reference *stale* merely because c has a new version, whatever changed in it; whether every reference kind goes stale this way is «reference»'s to decide.
