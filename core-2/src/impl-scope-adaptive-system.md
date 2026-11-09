---
slug: impl-scope-adaptive-system
form: impl
status: provisional
narrates: [veritoid, segment, kind, dimension, reference, act, frontier, steady·state]
---

# A real root through the model: `scope-adaptive-system`

*Moved from `examples/` (Fable 5.1, 2026-11-08) into a segment that narrates the defs it exercises. Provisional. The one-paragraph result below is what the run showed about the model; the run itself follows.*

**What this run showed.** **Binding per veritoid keeps more of the record alive, by an amount not yet counted.** vsect 0.1 binds a check to the whole segment's text, so the segment's nine versions on 10-30 left 50 of its 63 checks lapsed. Under this model an act lapses only when a veritoid it read is rewritten; the last reword touched only item (c) and the imports, so acts on other items recorded just before it survive. But several items were rewritten earlier the same day, so the earlier reviews' acts lapse under this model too. The cold read corrected my first count; the true number needs a per-item diff per version pair. It is also where the recording cost will bite: an act must say which veritoids it read.

*Fable 5.1, 2026-11-08. The segment is `~/src/arch/asf/01-aat-core/src/scope-adaptive-system.md` at HEAD (`v:9fde935e` in vsect 0.1). The acts are the 162 that vsect 0.1 recorded on it between 2026-10-30 20:19Z and 10-31 03:31Z (`vsect why segment:scope-adaptive-system`); I read the whole list and quote criteria from it. The ontology below is a sketch of AAT's, invented for this exercise and marked so; nothing in `core-2/` depends on it. What this tests is whether the model's words have anywhere to put what is actually in the file and the record, and what it would have shown that vsect 0.1 does not.*

## 1. The segment, cut

The file holds a frontmatter (`type: scope`, `status: axiomatic`, four `depends:`, `stage: draft`), four intro paragraphs, a Formal Expression with three tagged pieces, an Epistemic Status, a Discussion of six named paragraphs, and Working Notes with an integration record and the six-slot gold block.

Under a sketch segment kind **scope**:

| slot | veritoid kind | holds | from the file |
|---|---|---|---|
| intro | explanation | 1..N | the four opening paragraphs |
| law | definition | 0..N | *[Definition (environment-law; typed-epistemic-target)]* |
| predicate | scope-statement | 1 | *[Scope (scope-adaptive-system)]*, conditions 1 and 2, the averaged/pointwise distinction |
| consequences | claim | 0..N | items (a), (b), (c), (d), (e), (f), (g), (g′), (h), (h′) of *[Derived (adaptive-scope-membership), exact]* |
| housing | claim | 0..1 | *[Derived (adaptive-scope-housing), exact]* |
| non-claims | non-claim | 0..N | "Not claimed: that the declared world … can be read off the observations" |
| discussion | explanation | 0..N | "Two kinds of warrant", "The collapse map", "Full knowledge …", "Why the future stream …", "Whose uncertainty", "The declared world", "Narrowing to agency" |
| questions | question | 0..N | the five open items of the integration record, each with a forward pointer |
| guards | guard | 0..N | the regression guard inside the tail-rule item ("which $\sigma$-field …") |

Inner dependencies: intro → predicate; discussion → consequences; consequences → law, predicate; housing → predicate. Segment dimensions: validity aliased to the predicate's support kind; freshness derived as the minimum; coherence own.

Three things in the file have no slot and are not content:

- The **Epistemic Status** prose splits four ways. "Axiomatic for the scope itself" and "(a)–(h′) and the housing result are exact" are **assertions**, written on the predicate and on each item. "The Kalman criterion in (b) is standard Gaussian conditioning, the decay rate in (c) is the Clarke–Barron asymptotic, the full weak support … is Ferguson's" are **references** of kind imports, each with a dimension *checked at source*. "Not claimed: …" is a non-claim veritoid. "If the loop is in at $t$, then under some continuation the state-and-law information terms … sum to at least that continuation's value" is **new mathematics**, a claim veritoid that the prose was hiding inside a status section; and the renewal-identity counterexample ($I(z_1; F_1 \mid \mathcal C_1) = \infty$ against $\tfrac12 \log \tfrac32$) is another.
- The **gold block** under Working Notes is a ‹source› segment's chunks: "audit gold lift 2026-05-30", cut by a lifting agent into six slots, each chunk bearing on this segment. The in-place markers ("*Resolved 2026-10-30 …*", "*Landed 2026-10-30 in Discussion, 'Whose uncertainty'*", "*Answered 2026-10-30 by Formal Expression (c), (g), (g′) …*") are **crossings** written as prose; under the model each is a ‹crossing› act with outcome *changed an existing veritoid* or *already present*, and the chunk leaves the inbox.
- The frontmatter **`status: axiomatic`** is one assertion on the predicate's support-kind dimension ("definitional, not derived"). It says nothing about the ten items, which assert *exact* each, nor about (h′), which asserts *exact under its finiteness hypotheses*. A rendering may still print one word for the segment, computed as the segment kind declares (here: aliased to the predicate), and labelled as computed.

**Grain found by adjudication.** Two checks in the record narrowed part of a veritoid and confirmed the rest:

- `reread-1#C3` (a run, broken) concerned (c)'s *decay-rate* sentence and the Discussion's "the information tends to zero", while `reread-1#C2` (confirmed) concerned (c) *as a membership claim*. One veritoid, two warrants: (c) wants splitting into (c-membership) and (c-rate). The integrator's rewrite did exactly that in prose ("What decays is the *one-step* information. … The predicate's own value does not decay"), and check-8 then checked them as separate criteria (C3's "the observed-state test … infinite value under recurrence … one-step decay").
- `check-4` broke "Two kinds of warrant" on a sorting claim while confirming the paragraph's worked numbers. An explanation veritoid held a derivation; the integrator's rewrite moved the mathematics into (g) and (g′) as claims and left the paragraph explaining them. That is a promote, from the discussion slot into the consequences slot, with new ids.

## 2. A sketch of the dimensions this segment's veritoids open

| dimension | of | against | produced by | read as |
|---|---|---|---|---|
| **validity** ‹determinant› | claim, scope-statement | logic under the piece's stated hypotheses | a ‹check› by a mind re-deriving, not the author (line derivation) | highest confirmed rung; broken wins; narrowed is a split signal; caps along predicated-on |
| **simulation** ‹determinant› | claim with quoted numbers | the script at its version | a run | latest outcome |
| **source** ‹determinant› | import reference | the cited work | a read-check | named · recalled · checked at secondary · checked at primary |
| **fidelity** ‹determinant› | explanation | the veritoids it narrates | a read against both | latest outcome; stales along narrates |
| **comprehension** | explanation | a reader of a stated kind | a reader event, a quiz | count of confirming readers |
| **freshness** | anything | what it references | a rule over versions seen | fresh / stale |
| **support kind** | scope-statement, definition | the ontology's list | the author, by assertion only | definitional / chosen / derived |
| **answered** | question | its declared closer | an ‹attestation› by the closer | open / answered / dissolved |
| **still false** | guard | logic | a ‹check› | the refuted form stays refuted |
| **fidelity** | non-claim | the text it bounds | a read | the text indeed does not claim it |

Validity is the one dimension nearly every recorded act answers (158 of 162 are `rederive` or `run` on line derivation or simulation). That matches the census: effort goes where the producer is cheap, and here the producer is a mind re-deriving, which ASF has in abundance.

## 3. The record, read through the model

Versions in the record: `12ea0186` (text before the 10-30 integration), `5e613630` and `26a703b0` (integrator revisions), then more, ending at `9fde935e` (10-31 reword: names (c)'s lemma's generating class as a $\pi$-system, adds Ferguson to the imports).

| when (Z) | act in the record | under the model |
|---|---|---|
| 10-30 20:19 | reread-1 **C1** rederive confirmed: item (b) criterion, "iff $C A^j P_t \neq 0$ … random walk of #example-kalman in at every t, A = 0 out" | a ‹check›, answers validity, concerns (b), reads (b) at `12ea0186` and `example-kalman`'s tracker. (b): warrant *re-derived*; assertion *exact* ≤ warrant: fine. |
| 20:19 | **C2** confirmed: (c) as a membership claim | concerns (c-membership). Fine. |
| 20:19 | **C3** run broken: (c)'s decay claim and the Discussion sentence | concerns (c-rate) and the Discussion paragraph. Both: warrant *broken*; (c) asserts *exact*: **overclaim** owed; **broken** owed. Split signal on (c). |
| 20:19 | **C4** rederive broken: (h) and the Definition's "only the support of $\pi_0$ affects membership" | concerns (h) and the law definition's support sentence. **overclaim** and **broken** owed on (h). |
| 20:19 | **C5** confirmed: (a), (d), (e), (f), (g), housing | one act concerning six veritoids. Each: re-derived. Note what this costs under binding-as-a-unit: when (g) is later rewritten, this act lapses for all six, and (a), (d), (e), (f) and housing need fresh checks though their text did not move. The check-8 author did exactly that (C1, C5, C6). |
| 20:19 | **F1–F5** place-finding | ‹finding›s, each owed as **broken** until answered or accepted. F5 later carries a correction by a fourth reader marking four of its six bullets as no longer describing the text: an attestation on the finding, with two bullets still open. |
| 20:49 | revise, redefined, `5e613630` | a ‹segment·changeset›. Every reread act lapses (they read `12ea0186`). All eleven items' validity warrants fall to *never asked at this version*; every *exact* assertion is now an **overclaim**. The two broken items are cleared by the rewrite (the text they broke is gone), their findings remain owed until answered. |
| 20:50 | integration-2 **C1–C6** confirmed (by the integrator) | ‹check›s by the author of the changeset. They have standing as checks and no weight as independent ones; under AAT's sketch, validity's producer is "not the author", so they do not raise the warrant. Honest record of work; no warrant. |
| 20:57 | revise `26a703b0` | changeset; integration-2 lapses anyway. |
| 21:26 | check-4 **C1–C4** confirmed by an independent adversarial checker; two **broken** ("Two kinds of warrant" sorting claim; (g) last sentence) | independent: (b), (c), (h), (h′), housing re-derived at `26a703b0`. (g) and the Discussion paragraph: **overclaim**, **broken**. Split signal on the paragraph. |
| later 10-30 | check-4 integrator confirms (g), (g′), the guard, the ES counterexample, the Discussion numbers; a fourth reader (bare brief) confirms (a), (d), (e), (f), (g′), (c), (g) | the fourth reader's are independent and raise warrants; the integrator's are not. |
| 10-31 03:28 | check 8 **C1–C8** confirmed on `9fde935e`; **C11 narrowed** (the KR A.1 cold-reader clause); **F1**, **F5** findings; F1 corrected by its own author at 03:31 | every item re-derived at the current version by an independent checker, read sets recorded ("read set: segment:scope-adaptive-system, segment:def-action-transition, …"). C11 concerns a different thing: a key result in the projection (KR A.1), not this segment; it is a narrowing of a promise, owed at the projection. F1: a ‹finding› with an attestation of correction by its author; still owed. F5: owed. |

**What the frontier holds at HEAD, under the model:** F1 (corrected, open), F5 (small points, open), C11's narrowing on KR A.1, and whatever the two import references (Clarke–Barron; Ferguson) owe on *source*, since no read-check on them is in the record. No overclaim: every item's validity is re-derived by an independent checker at `9fde935e`. A steady state would need three or four acceptances with reasons, and its conditions would name them.

**What vsect 0.1 shows instead:** `vsect read` at HEAD holds 13 checks (check 8's eight and five round-7 integrator confirmations, all recorded at `9fde935e`, which is HEAD), and marks the other 50 lapsed, "stale: own text changed", because 0.1 binds a check to the whole segment's text and the segment moved through nine versions on 10-30. Under this model an act lapses only when a veritoid it read is rewritten. The final reword (`4dd77b14` on `main`) touched only (c)'s lemma and the Epistemic Status imports, so acts recorded just before it on other items would survive it; but (b), (e), (g), (g′), (h) and (h′) were themselves rewritten during the 10-30 integrations, so reread-1's and check-4's acts on them lapse under this model too. The honest form of the result: fewer acts lapse than vsect lapses, more than zero survive, and the count needs a per-item diff per version pair, which I have not done. (A cold read, `msc/scratch/core-2-denovo-1.md` §3, corrected an earlier version of this paragraph that said all 162 were stale and cited a hash not on `main`.)

## 4. What this run says about the model

- Every piece of the file found a place: a slot, an assertion, a reference, a chunk, or a crossing. Nothing needed a term the model lacks. The one awkward piece is the frontmatter `status:`, which the model can only render, not hold, and that is the point.
- The **split signal** fired twice in real acts (C3 on (c); check-4 on the Discussion paragraph), and both times the integrator did in prose what the model calls a split or a promote. Grain discovered by adjudication is how this segment actually evolved.
- **Independence by producer** did real work: nineteen of the confirmed checks are the integrator's own and would raise nothing; the warrants come from the independent re-reader, the adversarial checker, the fourth reader and check 8. The record already names roles; the model only reads them.
- **Binding as a unit** (C5 concerning six items) is honest and expensive, as the act def says. The check-8 author's practice of one criterion per item is what the model rewards.
- **What strained:** the Epistemic Status. It took four different homes to place its sentences, and one of them (new mathematics inside a status section) is a defect of the file, not of the model. The Working Notes' integration-record items are questions with forward pointers and sit comfortably in a slot; the gold block is a source and sits in the inbox; the fate markers are the only thing the model would force to change, into acts.
- **Cost:** I counted roughly thirty veritoids, eleven assertions, about twenty references, and 162 acts needing a `concerns` set each. Whether that is cheaper than the prose it replaces is the first gap in the outline, and this run does not settle it.
