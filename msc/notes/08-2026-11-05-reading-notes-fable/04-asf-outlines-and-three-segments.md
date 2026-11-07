# 04 — ASF first-hand: outlines and three segments

## What I actually read (from the tool log, not from memory of reading)

- `asf/OUTLINE.md` whole (41 lines).
- `01-aat-core/OUTLINE.md`: lines 1–167 whole (through Part II ch. 3). Lines 168–404: every non-table line read (chapter headings, HTML comments, Part III preface, appendix prefaces); **table rows not read**, only counted by Type / Stage / slug prefix. So I have not read the claim cells for Part II ch. 4–5, Part III, or the appendices.
- `01-aat-core/OUTLINE-accepted.md` whole.
- Volumes 2–4 outlines: **only the census** (Type, Stage, prefix counts). Not read.
- Segments, whole including Working Notes: `def-agent-environment` (root, the standing specimen), `deriv-stochastic-non-exit`, `impl-persistence-and-limits`.
- Not yet read: any emp-, example-, hyp-, result-, scope-, form-, disc-, obs-, sketch-, norm-, post- segment.

## Against my predictions

- Right: frontmatter (slug, type, status, depends, stage); sections Formal Expression / Epistemic Status / Discussion / Working Notes.
- Right, and stronger than predicted: labels differ *inside* a segment. In `impl-persistence-and-limits` the label is per paragraph and sometimes per clause: `*[Exact; the reading of the three misquotations is this segment's own framing.]*`, `*[Min-operation: conditional in the diagonal case; the matrix information floor: conjecture.]*`, and a `*[Hypothesis]*` dropped mid-paragraph with the rest of the paragraph un-hypothetical. One paragraph, two claims, two labels, and a third thing: *which part is inherited from a source and which part is this segment's own composition*.
- Did not predict at all: **segments already contain filled templates.** `deriv-stochastic-non-exit` has
  - `## Claim Record` with three entries, each with the same six fields (Register, Population, True of, False of, Falsifier, Instantiated);
  - `## Findings` with one entry, fields Brief, Impact, Novelty Claim, Related Work (a table), Search Log (dated entries);
  - Working Notes "Incidental audit gold" with the same numbered sub-headings as in `def-agent-environment` (Candidate Brief prose / Candidate Discussion / Follow-up / Readers often ask / Candidate figures / Belongs elsewhere), though not identical: the deriv has "3. What the framework now contributes (field-level)" where the def has "3. Follow-up items".
  So ASF is already, by convention, a system of templates instantiated inside markdown. The words "template" and "instance" are not being imposed on it from outside.
- Did not predict: the outline is itself a typed table (§ / Type / N / Tag / Claim / Stage) with prose between tables that restates headline claims with their registers, HTML comments carrying editorial reasoning and "placement tensions", and a separate whitelist file of accepted dependency-ordering violations, each row a dated decision with a citable reason.

## The conflations, seen directly

1. **Three whole-file labels that are not the same thing, plus one per-part label.** Frontmatter `type:` (definition / derivation / discussion), `status:` (axiomatic / exact / discussion-grade), `stage:` (draft / deps-verified / claims-verified); outline `Type` column; slug prefix. And then inline bracket tags. For `deriv-stochastic-non-exit`: file status `exact`, but its third claim record is register "descriptive", "True of: no measured instance is cited", "Instantiated: no". The file-level `exact` is true of claims 1–2 and not of claim 3. A reader of frontmatter is told something false about a third of the claims.
2. **Slug prefix ≠ Type.** Census of 01-aat-core: `impl-*` are all Type Discussion (9); `scope-agent-identity` is Type Discussion; `def-*` appears once as Discussion and once as "Definition + Discussion"; `result-*` once as Observation; `obs-*` once as Detail; `der-*` as "Derived + Scope" (2) and "Derived (Conditional)" (1); four chapter intros have no prefix at all (`the-`, `strategy-`, `persistence-`, `causal-`, `cooperative-`). Volume 2 adds "Discussion + Hypothesis", "Derived + Hypothesis". The "+" types are the facet problem Appendix A worried about, already present in the outline, hand-written.
3. **`der-` vs `deriv-`**: 21 Derived vs 35 Derivation in vol 1. Two prefixes, two Types. From the scratch: old *trajectory* prefixes. I do not yet know the intended difference (a derived result vs a derivation companion that proves something stated elsewhere?). `deriv-stochastic-non-exit` says it is "the load-bearing proof step behind the Model-S half of Corollary A.1S.1 in #deriv-sector-condition". So a deriv can prove part of a corollary that lives in another deriv.
4. **Stage is almost uninformative at file grain**: 133 draft / 22 deps-verified / 17 claims-verified / 6 missing / 1 exploratory in vol 1; vols 2–4 nearly all draft or missing. A status column in which three quarters of rows say "draft" for a theory with this much checked mathematics is a label that has stopped tracking anything.
5. **Events written as prose inside content.** `*Qualified 2026-10-30: …*` and `*Answered 2026-10-30 in #scope-adaptive-system: …*` prefixed to Working Notes bullets. "(lift 2026-05-30)". "refuted 2026-05-30". "grep-verified 2026-08-22". These are trail entries with dates and sometimes actors, living in the body.
6. **Restatement with ownership elsewhere.** The def's opening gloss restates its own Formal Expression nearly sentence for sentence. The impl restates a dozen source results with their tiers. The impl's own Working Notes record the cost: "this segment once carried (a) one hop downstream of the corrected source while citing it by name; check the citing paragraph, not just the citation." That is the restated-ownership failure, observed and guarded by hand.

## Things the kind list (Appendix A) does not have, which are plainly here

- **Regression guard.** "do not restore the refuted forms. (a) … refuted 2026-05-30 … (b) Landauer floor 0.35 … a bit/nat slip … (d) τ* matches the autocorrelation timescale: refuted; the law is √." A refuted statement, kept on purpose, attached to the place it would be re-introduced. Neither a finding (closed) nor a no-go (it is not a theorem) nor a ghost (it does not soften the body). It is a *negative statement with standing*, and a mover reads it before editing.
- **Open — / Forward — items** with routing ("Tracked in TODO §2026-07-03", "staged at #result-persistence-condition WN") and one that records a lost delivery ("routed it to PROPOSALS and it never arrived (grep-verified 2026-08-22)"). That last one is a crossing with no receipt. Exactly what "every stock has an exit" and "one current crossing per chunk" are for.
- **Provenance-of-tier paragraph.** The impl's "*Proof provenance.*" paragraph: "each implication inherits the tier of the weakest result it composes". A hand-run projection rule, with the weakest-link form PLAN A2 says is too generous.
- **Related Work rows** with a typed relationship ("formal antecedent", "standard machinery") and **Search Log** entries. Evidence events for a *novelty* aspect, already kept as a dated log. PLAN's graduation level 3 example ("for novelty: near neighbors, search dates, the deliberations") is literally this section.
- **Figures** with long captions that make claims.
- **Headline restatements** in outline prose, tagged `<!-- headlines: H1, H2 · restates the volume introduction's Part I items -->`.
- **Accepted violations** (OUTLINE-accepted.md): a decision table bound to a (segment, depends-on) pair, with staleness detection when a slug is renamed.

## Wandering

- If I try the smallest-thing question on `deriv-stochastic-non-exit`: what can fail separately? The Theorem. The "why the natural route cannot work" argument (it could have a hole while the theorem stands, since P=1 has its own independent argument). The numerical table (a spectral solve; could be wrong while everything else holds). Each claim record's six fields (the Population could be mis-stated while the Falsifier is right; Line A found record checks "broke or narrowed" 21 of 31). The Novelty Claim. Each Related Work row. The Brief (fidelity to the theorem). The Working Notes glimpse. That is on the order of 20–30 separately-failing things in a 160-line file, of perhaps 8 different sorts, each sort with its own fields and its own ladders.
- And they are not a flat bag. The Brief is *about* the Theorem. Claim record 2 "stands or falls with" claim record 1 (it says so). The Discussion table *instantiates* claim 1 ("True of: the 1-D OU benchmark in the Discussion's table"). So inside one segment there is already a small typed graph.
- "Section" is the wrong grain in both directions. Formal Expression holds a setup, a theorem, and two arguments. Working Notes holds many items. But "Epistemic Status" as a section is one thing (a projection). So the section is a *slot in a template* that may hold one thing, many things, or a rendering. That is the sentence I expect the model to need.
- Joseph's point today, restated in my own words to check I have it: ladders attach to parts; markdown-with-frontmatter gives exactly one place to attach anything (the file); so everything got attached to the file, and file = segment = record = kind = atom collapsed into one word per era.

## Prediction for appendix-A-feedback-1.md

Joseph: "closer to AAT but not really verisectorium-RC1 and still not really addressing everything"; written by an agent with PLAN (and perhaps Appendix A) and no theory. I predict: it measures prefix/type/status distributions (as I just did), counts inline bracket tags, counts Working Notes sub-headings, and proposes: split statement into finer kinds, add claim-record and finding kinds from the sections it found, treat Working Notes sub-headings as influx categories, and map status/stage words to PLAN's position ladders ("stations" = stage values?). I predict its weakness is treating the *current sections and labels* as the ontology to be captured, i.e. deriving kinds from ASF's present markdown conventions, which are themselves the conflated thing. I just did some of that myself above, so I should watch for it in my own notes too.
