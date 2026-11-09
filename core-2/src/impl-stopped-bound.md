---
slug: impl-stopped-bound
form: impl
status: provisional
narrates: [veritoid, dimension, act, frontier, checkpoint]
---

# The stopped bound through the model

*Moved from `examples/` (Fable 5.1, 2026-11-08) into a segment that narrates the defs it exercises. Provisional. The one-paragraph result below is what the run showed about the model; the run itself follows.*

**What this run showed.** **The stopped bound is caught by grain, not by a dimension list.** Note 19 needed the ontology to declare "does the derivation deliver the statement?" as a separate dimension from "is each step right?". Here it falls out of two things the model already has: derivation steps are veritoids separate from the claim they prove (ASF's Formal Expression already writes them apart), and an act concerns only what it concerns. Fourteen checks that each concerned a step leave the claim's validity *never asked*, while its assertion says *exact*: owed from the first day, as an overclaim with a named clearer. The "RESOLVED — do not re-open" sentence closes nothing, because closure is an act.

*Fable 5.1, 2026-11-08. The case is Prop A.1S(i) in `~/src/arch/asf/01-aat-core/src/deriv-sector-condition.md`, as `~/src/aat-v3/preparations/research/missed-error-case-2026-11-06.md` records it; I read that report whole and the segment's vsect record, not the segment at the tag. The point is what the model would have recorded, and what it would have shown, between 2026-04-22 when the stopped Grönwall form entered and 2026-10-30 when it was found false.*

## 1. The case in one paragraph

Prop A.1S(i) said the stopped second moment $\mathbb E[\lVert\delta(t\wedge\tau_R)\rVert^2]$ decays to $n\sigma_w^2/(2\alpha)$. Under condition (ii) that is false by three lines from the segment's own Corollary A.1S.1: the mass frozen on the sphere at exit does not decay. The proof's steps (Itô correction, Grönwall algebra, optional stopping) are each legitimate; the false step is an unstated identification of the killed moment with the stopped one, between them. Fourteen or so passes over six months, in audit prose and commit messages (none a recorded check: vsect begins on 2026-10-30), verified steps. Two April audits that broke the neighbouring (iii) recommended (i) as the safe fallback, and the May repair leaned on it. A Working Note said "RESOLVED in canon — do not re-open". An Opus 5.5 verifier with a bare brief, checking a *new* claim placed beside (i), re-derived from what was written and broke (i) at 15:50 on 2026-10-30. Three independent minds confirmed the break.

## 2. Under the model

Sketch of the relevant content, in AAT's `derived-result` segment kind:

| slot | veritoid | asserts (validity) |
|---|---|---|
| formal-claim | Prop A.1S (i), the stopped bound | exact |
| formal-claim | (ii), (iii′), (iv) | exact |
| derivation | step: Itô correction | — |
| derivation | step: Grönwall algebra | — |
| derivation | step: stopping-time localization ("Replacing $t$ with $t \wedge \tau_R$ makes the argument valid … The stopped Grönwall bound (i) follows") | — |
| … | Cor A.1S.1 | exact |

Validity, as in the other example: asks whether the statement as written follows from its premises; produced by a check from a mind other than the author; read as highest confirmed rung, broken wins; caps along predicated-on. Derivation steps open their own validity ("is this step right?"); the claim's validity is a different piece's question.

Now the record, as acts:

| when | what the record holds | under the model |
|---|---|---|
| 2026-04-22 | the stopped form lands, `80b40d28` | a segment changeset. (i) asserts *exact*. No act concerns (i). **Overclaim owed from this day:** (i) validity *never asked*, assertion *exact*. |
| 04-25 | audit 584721: "the stopped Grönwall bound holds … Markov on the steady-state second moment ✓ … Math is sound throughout" | an act, if recorded, concerning the Grönwall step and the Markov step. If it concerned (i) itself as a check of the statement, it would be a confirmed check at that version and the overclaim would clear. The audit's own words are about steps; recorded honestly it concerns steps. |
| 04-25 | audits 742613, 613842 break the old (iii) and recommend (i) as the safe fallback | a broken check concerning (iii); a *recommendation* is not an act concerning (i). **(i) earns nothing.** |
| 04-28 | 829314: "stopping-time localization … highly mature and exact application of Khasminskii" | concerns the localization step. Not (i). |
| 05-16 | repair `3d582e9b`: (iii) → (iii′), (iv); "(i)/(ii)/(iii′)/(iv) each exact" | a segment changeset asserting *exact* on four claims. (iii′) and (iv) are new; never asked. (i) still never asked. **Three overclaims owed.** |
| 05-16 | adjudication 628401: "The stopped bound (i) and (ii) are fine — the defect is localized to (iii)" | if recorded as a check concerning (i): confirmed, and the overclaim clears. Here the model does not catch it: a mind said (i) is fine and had standing to say so. What the model records that prose does not is *which question it answered*: its criterion was "is the defect localized to (iii)?", which is a different question from "does (i) follow?". The honest record concerns (iii) and the localization. |
| 05-20 | digests: "First-hand verified extensively"; "Cascade verified clean" | attestations about the author's own pass; no independent weight. |
| 05-xx | Working Note: "**Prop A.1S non-exit probability (RESOLVED in canon — do not re-open).**" | a chunk in the inbox, or a guard veritoid if someone promotes it. It is not an act; it closes nothing and inhibits nothing. The frontier still shows (i) owed. |
| 07-02 | audit 731548 (Fable 5): "stopping-time localization legitimate (optional stopping on L²-bounded martingale) ✓" | concerns the optional-stopping step. Not (i). The same audit found case B in the same file and recorded it; that is a finding, owed. |
| 07-20 | quiz corpus gives the stopped bound as a correct answer | a comprehension act on readers, not a validity act on (i). |
| 10-30 15:13 | spike `56fc3178` (Fable 5.1) lists the stopped bound as what canon holds | a reference from the spike's claim to (i), needing *exact*. **Unmet** owed: (i)'s warrant is never asked. The spike author would have seen this before writing. |
| 10-30 15:50 | `c1-exit-time-verify-1#C1` (Opus 5.5): rederive, criterion "Does Prop A.1S(i) … hold, and does (iii′)'s stated limit follow from it?", outcome **broken** | a check concerning (i) and (iii′), answering validity. **Broken** owed; the overclaim that was already owed now has a cause a reader can see. The perturbation of the atomic changeset that follows. |
| 16:29 | `33cfb14c`: (i) → the killed moment; (iii) split; A.1S-τ lands; `result-contraction-template` CT-S rewritten; four consumers re-read; a headline narrowed | one atomic changeset of several segment changesets. Acts reading the old (i) lapse. Dependents of (i) are asked whether they relied on what is gone (the decay term): `#result-adversarial-exponent-regimes` was "unchecked" and "not re-derived", so it stays owed. |
| 22:58Z | Part I round-2 checker (Opus 5.5) confirms the killed bound and that the stopped form is false under (ii) | independent; (i) re-derived at the new version. |

## 3. What the model would have shown, and what it would not

**Shown, from 2026-04-22 on:** either an overclaim on (i) or a never-asked determinant in every checkpoint's conditions, depending on a decision the model has not yet made (`dimension.md` Working Notes: whether "exact" asserts *standing*, comparable with a warrant, or *content scope*, what is claimed). Under the first reading (i) is owed; under the second it is visible beside every checkpoint. Either way it is visible, because its assertion was *exact* and no act ever concerned it on validity. Every pass that verified a step concerned that step. This does not need a separate dimension for "does the derivation deliver the statement?" (note 19's assumption). It needs two things the model has anyway: derivation steps are veritoids distinct from the claim they prove, and an act concerns only what it concerns. ASF's own Formal Expression already writes statements and proofs apart; the record's own criteria already name steps. What was missing was a place where "nobody has asked whether (i) follows" could be seen.

**Also shown:** the spike's reference to (i) as *unmet* before the verifier opened the file; the "RESOLVED" note as inert; the adjudication's criterion as about (iii), not (i).

**Not shown, honestly:** if the 05-16 adjudicator had recorded a confirming check *concerning (i)* with the criterion "(i) holds", the overclaim would have cleared on a wrong confirmation, and the model would carry a warranted falsehood until 10-30. The model does not make checks right; it makes what each check answered visible, so that a later reader can see that one mind confirmed (i) in passing while adjudicating (iii), and weigh it. The census's finding 8 is the same point: checks have standing too, and the record barely holds it.

**What the error cost that the model prices differently:** fourteen acts concerning steps were not wasted; they are the warrants of the steps, and most survived the 10-30 rewrite because the steps did not change. Under segment-grain binding every one of them is now "stale: own text changed".

## 4. What this says about the model

- The honesty constraint (assertion ≤ warrant) did the work, not any special dimension. That is the simplest result in the two examples and the one I most want tested on a second segment.
- *Concerns ⊆ reads* and per-veritoid grain are load-bearing. Without them the model collapses to vsect 0.1, which could not have recorded a broken check at all before 10-30 and binds at the file.
- A recommendation, a digest, a prose "RESOLVED" and a quiz answer are each things the model refuses to count as validity acts. That refusal is where the model protects a verisectorium from its own authors' confidence.
- The one place the model is silent is the one that matters most: whether a confirming check was *right*. It can only make the question it answered countable. That is the gap "independence of acts" in the outline, and it is not closed here.
