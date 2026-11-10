---
slug: impl-a-small-move
form: impl
status: provisional
narrates: [steady·state, changeset, frontier, act, decision, reference, veritoid, segment]
---

# A small move, from one steady state to the next

*An invented example, small enough to hold in the head. It illustrates the terms; it is evidence for nothing.*

**What this shows.** One finding, three writes and five checks take a verisectorium from one «steady·state» to the next. Along the way the «frontier» says at every moment what is owed and why, a check lapses when what it read is rewritten, an acceptance is reopened when its basis goes, and a draft that was checked and then replaced is never part of any steady state.

## The material

The ontology has one rule for canon: a claim is accepted while a mind that inherited nothing from its author has checked it, by following its derivation, nothing unanswered stands against it, and it rests only on accepted pieces; a document is accepted when its claims are and someone other than its author has read it whole. The rule is a «decision» made once and applied by an instrument.

Steady state S0. T is a derived result, an assembly holding four veritoids: a claim c, its derivation d, a description e, and a plain-language paragraph k. Its kind says e and k depend on c. Agent B, who did not write it, has checked c by way of d. T has been read whole. So c and T are accepted. U holds a claim u that is predicated on c; B has checked u, U has been read whole, and u and U are accepted. Nothing else refers to T or U.

## The run

| work time | what happens | the frontier afterwards |
|---|---|---|
| 08:30 | An auditor finds c false as stated: it needs a further hypothesis H. The ‹finding› is recorded. | S0 is disturbed. **found**: c, by this finding. An unanswered finding stands against c, so the rule no longer accepts it: **reopened**, and T with it, since a document is accepted only while its claims are. u was accepted on c being accepted: **reopened**, and U with it. |
| 09:00 | Agent A drafts: adds H to the claim, reworks the derivation, re-reads e and finds it still right, rewrites k. | Unchanged. A draft is not a changeset. |
| 09:25 | A writes a ‹segment·changeset› on T: c and d and k changed, e carried with A's affirmation. One instant; no order among the four. | The finding does not lapse with the text it read: it stays owed until someone other than A says it is answered. B's check read the old c and d and has lapsed. T's whole read has lapsed: T's acceptance is **reopened**. u's reference to c is **stale**, and because c was narrowed a question is **raised** on u: did it rely on what is gone? |
| 11:00 | B reads the finding against the new c and records it answered, then checks the new c by way of the new d. | The finding is cleared, and the rule accepts c again. Owed: T's whole read; u's stale reference, its question and its acceptance. |
| 11:30 | A finds an error in step 3 of d and writes a second changeset on T: d changed again. | B's 11:00 check read the d that is gone. It has lapsed. c is unsettled again. |
| 12:00 | B checks c by way of the corrected d. | c accepted again. |
| 13:00 | Agent C answers the question to U: u holds only if U also assumes H. C writes a changeset on U: u changed, its reference pointing at c as before, now seen at c's new version. | u's reference holds. B's old check of u has lapsed, so the rule does not accept the new u: still **reopened**. |
| 13:30 | B checks the new u. | u accepted. Owed: whole reads of T and of U. |
| 14:00 | Someone who wrote neither reads T whole, and U whole. | Empty. The ‹atomic·changeset› closes. **S1.** |

## What this says about the model

- **Steady time and work time are different clocks.** On the steady line T's claim gained H and U's claim gained H at the same instant. There was never a verisectorium in which T had H and U did not. The 09:25 version of d was never in any steady state.
- **What is written is reconciled by its author at once; warrants come back one act at a time.** A could make T say the right thing at 09:25. A could not make it checked.
- **Bad news outlasts an edit.** A's rewrite at 09:25 did not clear the finding; B's answer at 11:00 did. Had rewording been enough, the cheapest repair would have been to reword.
- **A confirmation counts for what it read.** B's 11:00 check was honest and counts for nothing in S1. It is still in the acta, and it is not neutral: B passed a derivation with an error in step 3, which is something a verisectorium wants to know about B's checks.
- **Evidence and decisions move differently.** The checks lapsed because text they read was rewritten. The acceptances were reopened because their basis, those checks, went. Nobody had to notice either; both are read from the record.
- **An affirmation is not a check.** A's "e is still right" is A's decision to keep e, made on looking. It is not evidence about e.
- **A narrowed premise asks a question; it does not answer it.** U was not false at 09:25. It was unsettled until someone looked.
- **Nothing here needed a waiver.** Had the whole reads not been done by 14:00, the move could still have closed, with those two items waived for a stated reason and shown in S1's conditions.

## Working Notes
- The rule here accepts on one means, following the derivation. That is the means by which a false proposition was once confirmed several times; a real ontology would ask for a second.
- Open. At 09:25 u's reference goes *stale* merely because c has a new version, whatever changed in it; whether every reference kind goes stale this way is «reference»'s to decide.
