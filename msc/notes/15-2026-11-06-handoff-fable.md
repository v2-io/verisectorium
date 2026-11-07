# Handoff: where the v2 model work stands (Fable session, 2026-11-06)

*To whoever picks this up cold, including a later me. Written near the end of the session's context. Nothing in `preparations/v2/` or `preparations/research/` from 11-05 and 11-06 is committed; Joseph decides when. One file is not to be made public without his say: `research/joseph-messages-2026-10-28--11-05.md`.*

## What this session was for

Joseph asked a Fable session to take over, as a collaborator, the effort to get the spine of the new verisectorium engine ("v2") and its vocabulary right, with AAT as the first store. It began as a reconciliation of three earlier documents into a building-blocks model and became a rethink of the model itself. The reconciliation document named in `../BRIEF-reconciliation-1.md` was never written, on purpose: the model moved under it.

## Read these, in this order

1. `joseph-on-provisional-promised-gaps-2026-11-06.md`. His most recent statement, verbatim.
2. `thoughts-dsl-2026-11-06.md`. The current high-level shape: a small core, a library of patterns with behaviour, short store definitions. Joseph: "an excellent, superb higher-level abstraction for verisectoria."
3. `thoughts-math-heavy-model-2026-11-06.md`, with its addendum of Joseph's words on why the claim is central and on the two regimes.
4. `../research/asf-inline-labels-2026-11-06.md`. What 790 inline labels and 62 Epistemic Status sections actually say. Evidence for items 2 and 3.
5. `../research/missed-error-case-2026-11-06.md`. The stopped-bound case, with pointers into ASF.
6. `model-and-lexicon.md` and `def/`. The model as written on 11-05 and the morning of 11-06. **Partly superseded; see below.**

## What is settled between Joseph and this session

- "Projection" for a chosen, ordered grouping of segments (confirmed 11-05).
- Numeric credence and weight of evidence are a special case a store may declare, as in relata. The core is acts and judgments.
- Belief rightly rises with each act, by an amount that depends on how independent the act is; a claim held at high credence that later fails is not a malfunction.
- For theory, the claim is central. The body states what is currently held true, flatly. Doubt goes beside the claim as a thing to check.
- Two regimes: theory claims (true or false) and empirical facts or proposed models (adequate by degree, built on by decision). They join at the hypothesis.
- The inbox is in the core. Rows of the canonical projection are provisional, promised or present. A gap is a kind of segment.
- Next: write two store definitions by hand, mathematical theory for AAT and formal spec for udon, each as if from scratch with all existing material arriving as influx. Extract the language from what they share. The more it resembles Ash and Rowan, the better for migration.

## What in `model-and-lexicon.md` and `def/` is now known to be wrong or thin

- **The value group** (`def/def-value.yaml`, section 2.2). "Three forms of value" contradicts "how sure is kept apart". Not yet rewritten. The replacement idea: what is claimed, what has been done, what is thereby warranted, kept apart; and for theory, uncertainty as a list of open checks.
- **"Claimed level"** as a single field. The label reading says it is several separate things: conditions, sharpness, forced or chosen, kind of support, whose. See `thoughts-math-heavy-model`.
- **ASF's `status:` is not a ladder.** Eight words answering five questions.
- **Epistemic Status is not a rendering.** It is written content about the claim.
- **No planned state, no gap kind, no provisional mark, no low-fidelity kinds.**
- **References** carry no account of use (which hypotheses of the target are met, and by what).

## Open with Joseph

- Whether to take ASF's existing 247-row outline as a provisional skeleton for routing only. I asked; he has not answered.
- Two levels of content (veritoid, segment) and the write rule: he said he was "still not sure".
- Whether a veritoid has an identity of its own.
- Whether a known defect may show on a steady state before it is worked through.

## Other things on disk from this session

- `model-store.dot`, `model-definition.dot` (+ `.svg`), and three `.dbml` files: pictures of the 11-05 model.
- `bin/defs`: checks, draws and lists the definition groups.
- `animation/`: a walkthrough artifact built by a fork, at https://claude.ai/artifact/JhUgcNT6DAB25KcLWkuioL. By the fork's own account it is its own restatement of the model, not a rendering of the definitions (`animation/SOURCES.md`). Do not take feedback on it as feedback on the model.
- `model-and-lexicon-denovo-1.md`: a cold review of the 11-05 document, most of which was worked in.
- `../research/reading-fable-2026-11-05/`: reading notes on every source, with predictions and surprises.

## Not read by this session

The address theory's content (only the form of its definition files); `research/knowledge-graphs.md`; `research/plan-review-1.md`; 158 of 220 Epistemic Status sections; Rowan; most ASF segments.
