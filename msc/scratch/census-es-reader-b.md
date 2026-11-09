# Census of the epistemic-status apparatus in ASF — reader B

Written 2026-11-08 by a Claude Code agent (Fable 5.1), blind to earlier readings. All quotes are verbatim from `~/src/arch/asf/0*/src/*.md` as of commit `68f6864` (dirty tree); the slug after each quote is the segment.

## 0. What I read, how I counted, and what I did not read

**Corpus.** 247 segment files: 173 in `01-aat-core/src`, 29 in `02-tst-core/src`, 23 in `03-llm-core/src`, 22 in `04-eli-core/src`. No `old-*` files exist in any `0*/src/` today. Total 5.6 MB (lines are md-pressed, one paragraph per line), which is more than one context can hold.

**What I read whole, for every one of the 247 segments:** the YAML frontmatter; the full heading tree; the full `## Epistemic Status` section; the full `## Claim Record` section; and every line containing `*[` (which, because lines are paragraphs, means the whole paragraph around every inline label). I extracted these mechanically (Python, splitting on `##` headings) into five bundles totalling 858 KB and read every page of them. So every status word, every Epistemic Status section, every Claim Record, and every inline label in the corpus has been seen by me, in its paragraph.

**What I did not read whole:** the Formal Expression, Discussion, Findings and Working Notes bodies of most segments (about 4.7 MB). I read four segments end to end as a check on what lives there (`der-deliberation-cost`, `norm-interiority-default`, `def-feature`, and the back half of `deriv-graph-structure`), and I ran a vocabulary scan over the unread sections (§6.4). Treat the Working-Notes and Discussion findings below as sampled, not censused.

**Counts.** Unless I say otherwise, counts are `grep`/Python over the files, not hand tallies: `## Epistemic Status` headings (220), `*[...]*` regex matches (802; the brief's "about 790"), `## Claim Record` (24), `## Working Notes` (238), `## Findings` (48). Where a count is a judgement (e.g. "the opener restates the type"), I say so and give the rule I used.

**Blindness.** I stayed out of `~/src/verisectorium/` (except this file), `~/src/aat-v3/`, and asf's `msc/`, `audits/`, `spikes/`, `reviews/`, and did not use memorata-search. Partway through, a message arrived (relayed from Joseph) loosening the constraint. I chose not to use the loosened permissions before writing; nothing from earlier readings reached me. I did read `doc/sop/format.sop.md` §§ frontmatter / cadence / Claim Record / Epistemic Triage / Equation-Level Tags, since the brief allowed SOPs; it is referred to below as FORMAT.

---

## 1. The carriers — more than three

The brief named three carriers: the frontmatter `status:` word, the `## Epistemic Status` section, and the `*[ … ]*` label. Those are real and I census each below. But the authors improvised several more, and a model that only sees three will miss where some of the most careful status-talk actually went:

| Carrier | Count | Where it came from |
|---|---|---|
| frontmatter `status:` | 247 | FORMAT |
| frontmatter `stage:` | 247 (205 draft, 23 deps-verified, 17 claims-verified, 2 exploratory) | FORMAT; "currently ignored in practice" per FORMAT itself |
| `## Epistemic Status` | 220 | FORMAT |
| `*[…]*` inline labels | 802 across 214 segments | FORMAT (9 canonical forms) |
| `## Claim Record` | 24 segments, 79 claim entries | FORMAT, added 2026-10 |
| "Max attainable" line inside ES | 106 of 220 | FORMAT suggests the form; usage went far beyond it |
| `### What Is Derived vs. What Is Chosen` tables | 20 | FORMAT (modelled on `deriv-graph-structure`) |
| `## Honest Limits` / `## Honest failure modes` / `### §5 — Failed derivation routes (honest record)` headings | 8 | improvised |
| "What would strengthen this / What would soften this" paragraph pair | 20 | improvised in `der-mood-timescale`; became the template in 03/04 |
| "Load-bearing / Not established" (and "What this does not establish/claim") paragraph pair | 16 by my regex; more by hand | improvised |
| per-paragraph trailer label `*[Exact; …]*` at paragraph END | ~8 in `impl-persistence-and-limits` | improvised |
| citation-depth footnote markers `[^recall-2026-10-30]`, `[^cat-2026-05-22]`, `[^bg2-2026-05-21]` | 29 / 31 / ~15 uses | improvised |
| a whole segment whose job is to flag another's overclaim | 1 (`sketch-structural-adaptation-genericity`) | improvised |
| Working Notes "Incidental audit gold" blocks carrying auditors' status disputes | ~100 segments | audit cycles 2026-05-30/31 |

Each of the improvised carriers answers a question the three official ones could not. That is the first finding: *the vocabulary was never the problem; the authors kept needing more slots than the three carriers had.*

---

## 2. The frontmatter `status:` word

### 2.1 Distribution

`conditional` 82, `discussion-grade` 69, `axiomatic` 27, `exact` 26, `robust-qualitative` 23, `sketch` 12, `empirical` 7, `heuristic` 1. All eight FORMAT values are used; nothing off-vocabulary appears in frontmatter. Cross-tab against `type` (full table in my notes; the shape):

- `definition` × every status except heuristic: axiomatic 18, conditional 4, discussion-grade 4, exact 4, robust-qualitative 3, sketch 3, empirical 1.
- `scope` × axiomatic 6, sketch 7, robust-qualitative 4, conditional 3, discussion-grade 1.
- `derived`/`derivation` × conditional 55, exact 14, robust-qualitative 4, discussion-grade 1.
- `discussion` × discussion-grade 48, robust-qualitative 4.
- `hypothesis` × discussion-grade 10, conditional 2, robust-qualitative 1, heuristic 1, sketch 1.
- `observation` × empirical 4, discussion-grade 4. `empirical` type × robust-qualitative 1, empirical 1.

So the type word does not predict the status word, and the authors clearly meant them as two axes — but see §2.4 on where they leak into each other.

### 2.2 The line between `exact` and `conditional` — articulated at least five ways, applied inconsistently

This is the most load-bearing distinction in the corpus (108 of 247 segments carry one of the two words) and the authors wrote down their rule for it, in different words, in many places:

- *premises owned by the application, not the theory:* "neither condition is establishable from the global dependency chain — they are properties of the application — so the tier is `conditional` rather than `exact`." — `def-adaptive-tempo`
- *modeling posits vs. consequences of prior segments:* "The status is `conditional` rather than `exact` because the load-bearing premises are modeling posits about an agent's physical realization, not consequences of prior segments — inherited honestly from #form-resource-budget's own ceiling." — `der-resource-bounded-destabilization`; same shape in `der-compensation-channel-uniqueness`: "(FW) is an explicitly named local regime assumption and (REC) a named condition on what the store includes, neither a consequence of prior segments".
- *the FORMAT definition read back explicitly:* "The honest tier is therefore *conditional* per FORMAT's definition — exact strength under explicitly named local assumptions beyond the `depends:` chain: the conclusion is exact given the commitment, and the commitment is argued from structure rather than presented as an extracted theorem." — `der-turnover-information-recursion`
- *exact implication, world-side antecedent:* "The conditional claim (IF epistemic update is goal-blind, THEN the separation holds) is exact. Whether a particular agent satisfies the condition is determined by its processing architecture (GUC Class 1/2/3)." — `der-directed-separation`
- *model quality vs proof quality:* "the remaining condition (causal sufficiency) is about model quality, not proof quality." — `deriv-graph-structure`
- *independence assumptions as the dividing move:* "the six assumptions are the recurring modeling move that distinguishes AAT's exact-tractable results from its conditional results" — `disc-independence-audit`
- *derived-for-a-subscope, assumed-for-the-rest:* "The status is *conditional* because A2' is **derived** for one explicitly named sub-scope of AAT-in-scope agents and **assumed as a per-system empirical claim** for the complementary sub-scope." — `form-sector-condition`

And what `exact` means when it is claimed: "'Exact' is claimed in the framework's defeasible sense (valid under stated assumptions, subject to a found error), not as a claim beyond a found-mistake." — `deriv-stochastic-non-exit`; "the template's exactness, which is the conditional '(T1)–(T3) ⇒ persistence'" — `result-sector-persistence-template`.

But the rule is not applied uniformly. `exact` segments whose ES names *local, segment-specific* premises of exactly the kind the rule above says make a segment `conditional`:

- `der-multi-timescale-stability` (exact): "*Exact* for the two-timescale theorem … under the named premises (S0)–(S5)/(C-N)" and then "whether AAT's actual deeper levels satisfy them is exactly the question that remains open".
- `deriv-evidence-allocation-ceiling` (exact): "*Exact* under the named conditions: (i) fixed allocation … (v) …" — and its own label reads `*[Derived (Conditional on fixed allocation + estimator class $\mathcal C$ + Model D)]*`.
- `deriv-convention-monotonicity` (exact): "*Exact, under named hypotheses on each rung.*"
- `der-change-expectation-baseline` (exact): labels `*[Derived (Conditional on uniform feature rate)]*`, `*[Derived (conditional on a constant birth rate)]*`.
- `detail-linear-ode-approximation` (exact): "*Exact for the linear case.*" with labels `*[Hypothesis (linear-vector-ode)]*`, `*[Hypothesis (Linear Coupling Model)]*`.

Conversely, `conditional` segments whose ES opens by calling the content exact: `result-adversarial-exponent-regimes`, `result-per-dimension-persistence` ("*Exact conditional on disturbance model.*"), `result-adversarial-tempo-advantage` ("Both coupling-dominant exponents are *exact* conditional on their respective disturbance models"), `deriv-bilateral-trade-impossibility` / `deriv-social-welfare-aggregation-impossibility` / `deriv-strategy-proofness-impossibility` ("*Exact* for the imported theorem … *Conditional* for the AAT-side translation"), `der-compensation-channel-uniqueness` ("*Conditional — exact under the named regime.*"), `deriv-observation-ambiguity-bias-bound` ("*Conditional — exact under (H2) (Track 1) or (H1) (Track 2 …)*").

Reading these together, the word `conditional` in this corpus does not mean "weaker derivation than exact". It means "exact, with at least one premise the theory cannot discharge from inside," and the authors say so repeatedly. What varies is only whether a given author judged a premise as *inside the depends chain* or *outside it*. That judgement is what the status word is actually recording, and it is not recorded anywhere as a judgement — only its outcome is.

### 2.3 The one-word-per-segment problem, and the rule the authors used to pick the word

The ES sections are overwhelmingly per-component tierings (§3.2); the frontmatter forces one word. Authors wrote down how they chose it:

- *weakest load-bearing component:* "Hence the segment as a whole sits at robust qualitative rather than exact: the boundary's *existence and location* are exact; the boundary's *shape past it* is qualitatively characterized." — `disc-w1-structural-bound-boundary`; "The expanded form inherits the weakest epistemic status of its inputs … The integration structure itself is exact; the terms being integrated are approximate." — `der-principled-decision-integration`; "Its epistemic status inherits from both … the weaker link governs." — `hyp-conceptual-alignment`
- *what the frontmatter word covers, stated explicitly:* "The frontmatter `status: exact` applies to the definitions, to the interventional interpretation, and to the convention hierarchy; the true-law claim and the identification are conditional as scoped." — `def-value-object`; "The general-coupling $N$-level gate is *imported* … and the Model S extension is *open* — both stated as such above, neither carried by the `exact` label." — `der-multi-timescale-stability`
- *the segment word drove a file split:* "Split out of #disc-stability-certificate 2026-05-14 (it had been a `*[Derived]*`-tagged block) so the exact equivalence is housed at its true tier (`status: exact`) rather than inside a `discussion-grade` segment." — `result-certificate-existence` Working Notes

### 2.4 Places where the status word is doing something other than grading a derivation

- **Capped by type.** "Max attainable for this segment: *discussion-grade* (it is a discussion of the underlying result, per `type: discussion`). The underlying derivation's tier is the one `#deriv-causal-ib-lmi` carries (*conditional*; exact under its named conditions)." — `disc-ciy-unified-objective`. Yet `disc-approximation-tiering`, `disc-compression-operations`, `disc-independence-audit`, `disc-w1-structural-bound-boundary` are `type: discussion` at `robust-qualitative`, and `der-bounded-objective-as-sanity-criterion` is `type: derived` at `discussion-grade` with "**Max attainable status:** derived (under named conditions)". So "a discussion is capped at discussion-grade" is a rule some authors used and others did not.
- **Capped by a dependency's *stage*** (the axis FORMAT says is orthogonal): "The tier ceiling stays `conditional` while `#der-directed-separation` (a dependency) is `stage: draft`." — `deriv-reward-channel-learning-no-go`; "The result cannot be stronger than its substrate; the tier ceiling stays `conditional` while #der-directed-separation is draft-stage." — `deriv-self-actuation-grounding`; "The tier ceiling is `conditional` while #der-directed-separation (a transitive dependency through both no-gos) is `stage: draft`." — `der-captured-objective-dynamics`. Three segments bind their status to another segment's review stage.
- **Floored by a dependency's status:** "The other-observer route depends on #hyp-communication-gain, whose status is `discussion-grade`, so nothing this segment says about that route can be stronger than discussion-grade regardless of how the argument here is tightened" — `hyp-solicitable-escape`; "If a Part II result is itself discussion-grade (e.g., #def-strategic-calibration), its survival classification inherits that status." — `result-section-ii-survival`.
- **Scopes.** Three scopes are `axiomatic` ("the minimal conditions"), three `robust-qualitative`, two `conditional`, seven `sketch`, one `discussion-grade`. The authors explain: "#scope-composite-agent is a theoretical choice … Unlike them [#scope-adaptive-system, #scope-agency, both axiomatic — the minimal conditions]" and "Scope statements are not theorems; they specify what kind of object the theory applies to. Further formalization … could reach *exact* on the formal structure but would not change the scope content." — `scope-agent-identity`. All four `sketch` scopes in 03 say the opposite of their word about their core: "The scope condition itself is definitional and exact" (`scope-channel-collapse`), "The scope itself is exact" (`scope-primitive-logogenic`). For scopes the status word is grading the *consequences* or the *surrounding formalization*, not the scope condition.
- **`axiomatic` redefined locally:** "Naming those axioms is what `axiomatic` status means here" — `form-objective-functional` (a formulation at axiomatic). The 02-tst definitions use `axiomatic` to mean "Definitional." (eight one-word ES openers).
- **`empirical` as the *kind of record*, retained after derivation:** "*Empirical*, as a simulation record; its numbers are now derived." — `obs-gated-tempo-advantage`; "*Empirical — architecturally guaranteed.* … as strong as empirical support gets — but it is a fact about how the world's systems behave, not something the formalism forces." — `obs-context-turnover`.
- **`sketch` meaning "spike-like":** "*Sketch* — direction identified, formalization not begun (exploratory; closer to a spike than a claim)." — `hyp-truth-serving-loophole`; and "Until attempted, this stays `sketch`." — `sketch-structural-adaptation-genericity`.
- **`heuristic`** appears once in frontmatter (`hyp-mismatch-dynamics`) but ~10 times as a component tier inside ES ("the off-policy mixed-regime scaling is *heuristic*", `der-causal-insufficiency-detection`; "*heuristic* for non-Gaussian", `deriv-persistence-cost`) and as a label modifier ("*[Empirical Claim — heuristic tier; …]*", `emp-changeset-size-principle`).

### 2.5 A stale one

`disc-composition-consistency` has `status: discussion-grade`, `type: discussion`, but its ES opens "*Axiomatic* for the meta-requirement (cross-level compatibility). The postulate itself is …". Its Working Notes record the 2026-05-28 retype from `post-composition-consistency` (postulate/axiomatic) and the tag change to `*[Commitment (composition-consistency)]*`; the ES opener was not updated.

---

## 3. The `## Epistemic Status` section

220 present; 27 absent — all 27 are chapter intros (`*-intro.md`, 6), "Additional Implications & Discussion" segments (`impl-*`, 17), plus `obs-evaluation-metrics`, `norm-interiority-default`, `obs-developmental-trajectory`, `scope-moral-continuity` (the last four simply have no ES and no labels; `norm-interiority-default` I read whole — it is prose with no status apparatus of any kind). The intro/impl exemption is FORMAT's 2026-07-14 cadence exemption.

Length: 25 to 1,151 words, median 201, total ~50,000 words. The longest (`deriv-mechanism-counterfactual-separation`) is a primary-verification and priority record, not a tiering.

### 3.1 What the first sentence does

Rule I used: take the first italic/bold/backticked phrase, else the first clause. Result: in 160 of 220 the opener contains the frontmatter status word ("*Conditional.*", "*Exact.*", "*Discussion-grade* at the meta-pattern level"). In the other 60 the opener is one of:

- the **type** word rather than the status word (the dominant case, ~40): "This is *definitional*" (×7 in 01), "Definitional." (×8 in 02), "*Formulation.*" (`form-complete-agent-state`), "*Hypothesis.*" (×4), "*Derived* from #der-dual-optimization." (`der-change-investment`), "*Normative, not derived.*" (`norm-explicit-strategy-condition`), "This is a *postulate*" (×2), "This is a *worked instantiation*", "This is a *structural mapping*, not a derivation" (examples), "This is a *procedures document*" (`detail-operationalization`), "*Recapitulation of an external result.*" (`def-pearl-causal-hierarchy`).
- a **different tier word** than the frontmatter (§2.2): "*Exact* for the imported theorem" (×3 imported-theorem segments at `conditional`), "Both … thresholds are *exact*" (`der-adversarial-destabilization`, conditional), "*Derived* under the Fisher-local invariance regime" (`emp-update-gain`, type empirical, status robust-qualitative), "*Axiomatic*" (`disc-composition-consistency`, stale).
- a **structural opener** that refuses a single word: "The segment contains three distinct epistemic layers:" (`def-value-object`), "*Mixed.*" (`disc-credit-assignment-boundary`), "The result is correct but partly definitional." (`deriv-recursive-update`), "**Structural persistence** thresholds are *exact* …" (`result-persistence-condition`).

Also noticed: in 03/04 the opener is **bold** ("**Sketch.**", "**Discussion-grade (mixed).**", "**Empirical (with formal grounding).**") where 01/02 use italics; `der-mood-timescale` uses backticks (`` `Conditional` ``). Compound openers are common: "*Exact, with a partly definitional character.*", "*Exact, applied external theorem.*", "*Conditional, with an exact core.*", "*Conditional, partial*", "*Discussion-grade summary of a conditional derivation.*", "*Discussion-grade / hypothesis.*", "*Hypothesis*, on a *formulation*:", "*Exact as a definition — convention-relative as a diagnostic.*" (`def-satisfaction-gap`, `def-control-regret`), "*Robust qualitative* overall, with several specific claims at *exact* tier."

### 3.2 The dominant move: per-component tiering

155 of 220 ES sections use at least one tier word other than the frontmatter word. The typical shape names a component in bold or italics and assigns it a tier, several times over:

> "The **no-go theorem** is *exact* for shallow strict-prerequisite cases … *robust qualitative* for general DAG topology … The **aggregate residual** as a confirmatory signal is *exact* for the on-policy collapse …; the off-policy mixed-regime scaling is *heuristic* … The **detection-to-construction pipeline** is *discussion-grade*" — `der-causal-insufficiency-detection`

> "Three claims at distinct tiers travel out of this: the **exact** steady-state MSE for the model; the **conditional** $\sqrt{\tau_{\mathrm{env}}}$ scaling law; and a **robust-qualitative** core" — `der-mood-timescale`

> "Per-result: **Result 1** exact under …; **Result 2** exact for the stated split …; **Result 3** conditional on …; **Result 5a** exact in its truth-relative half …, conditional (inheriting Result 3) in its agent-relative half; … (6c) normative-structural …; (6d) discussion-grade." — `der-severed-actuation-dynamics`

> "*Conditional.* Four claims at different levels. **The log-ratio-range bound** is *exact* and model-free … **The fixed-gain tilt** is a *hypothesis* … **The domain classification** is *robust qualitative* conditional on the hypothesis … **The no-go on an ambiguity factor** is *exact*" — `scope-observation-ambiguity-modulation`

Tier words used at component level that are *not* FORMAT status values: *derived*, *formulation*, *formulation choice*, *proved*, *hypothesis*, *normative*, *observation*, *assumption*, *imported*, *open*, *sketch-level*, *sketch-grade*, *argumentation-grade* (`disc-dynamic-regime-axis`), *conditional-derived* / *derived conditional* / *derived-conditional* (≥6 segments), *exact-flavored* (`der-resource-bounded-destabilization`), *exact-with-standard-remainder* / *exact-via-Conley* (`disc-stability-certificate`, `result-certificate-existence`), *exact one-direction* (`deriv-gain-sector`), *empirical-by-construction* (`obs-authored-world-laboratory`), *hypothesis-grade*, *qualitatively derived*, *useful approximations*, *adjacent-family status* (`deriv-fisher-whitened-update-rule`), *AAT-internally forced* vs *preferred* (`der-gain-sector-bridge`), *recognition* ("Novelty posture is *recognition*, not new mathematics", `result-certificate-existence`), *truthful survey*, *positioning*. The eight-word vocabulary was never enough at component level and nobody pretended it was.

Meta-pattern segments (`disc-identifiability-floor`, `disc-constructive-impossibility-posture`, `disc-implementation-impossibility`, `disc-value-functional-grounding-floor`, `disc-modularity-state-dynamics`, `disc-separability-pattern`, `disc-additive-coordinate-forcing`) share a template: "*Discussion-grade* at the meta-pattern level … presentational organizing principle, not a derivation, and carries no theorem of its own." then "*Individual instances retain their own (higher) epistemic status.*" followed by a restatement of other segments' tiers, then "Readers citing this segment for a specific no-go should cite the instance's own derivation, not the methodology." (`disc-identifiability-floor`). These ES sections are *about other segments' statuses*, and would go stale when those change.

### 3.3 "Max attainable" — 106 of 220, and it means at least four things

FORMAT suggests "Max attainable: [status]. Currently [status] because [reason]." That exact form is rare. What authors actually wrote:

1. **A ceiling with a reason it is intrinsic:** "**Max attainable: `conditional`.** This ceiling is intrinsic: (A-cost) and (A-gate) are claims about a particular agent's physical realization, not about the formalism, so no amount of derivation promotes the formulation itself beyond conditional." — `form-resource-budget`; "Max attainable: *conditional* — the condition (B1 or strong convexity) is inherent, not removable." — `der-gain-sector-bridge`; "Max attainable: exact conditional on the disturbance model and coupling model. The result is as strong as its assumptions; no additional work changes the epistemic status without changing the dynamical model." — `result-adversarial-tempo-advantage`
2. **A per-component list, i.e. the tiering again under another name:** "*Conditional.* Max attainable: *exact* for the Hafez-reduction under IDT + ergodicity; *derived* for the sign-flip via signed-coupling; *formulation choice* for the emitter-regime classification structure; *conditional* for the tempo-amplification formula; *discussion-grade* for the meta-pattern candidate status." — `der-agent-opacity`; similar in `der-architecture-noidentifiability`, `deriv-adaptive-gain-dynamics`, `deriv-persistence-cost`, `deriv-update-detection-latency`, `der-interaction-channel-classification`, `form-consolidation-dynamics`, `result-unity-closure-mapping`.
3. **Ceiling equals current, with "why stuck":** "Max attainable: conditional. Currently conditional because the general DAG case (mixed AND/OR topologies, correlated edges) has not been verified." — `def-strategic-tempo`; "Max attainable: *exact* … (already at ceiling …)" — `der-turnover-information-recursion`, `der-identity-continuity-threshold`, `form-information-bottleneck`.
4. **A compound or type-valued ceiling (03/04 template, "Max attainable status:"):** "definition + conditional theorem" (`scope-channel-collapse`), "definition with conditional consequences", "definition + composite forcing argument", "robust qualitative or formal observation", "definition with derived structural conditions", "definition (composed)", "empirical (definitional in part)", "derived (under named conditions)", "robust qualitative or conditional theorem under specific scope", "observation with derivable diagnostic structure".

`def-identity-sufficiency` carries two different Max-attainable lines in one ES (one per-component, one type-valued). `der-team-persistence` uses it to imply a tier *ordering* — "Max attainable: *robust-qualitative* for the persistence condition … The coordination threshold could reach *conditional* with a concrete cost model" — i.e. conditional > robust-qualitative, an ordering FORMAT never states and `deriv-identity-sufficiency-rate-bound` ("as an inequality it is exact … The bound is not in general attained" → robust-qualitative) seems to contradict.

Promotion is gated on things other than derivation: on citation search ("would be promoted to *empirical* with named domain citations once a targeted prior-art search has been conducted", `disc-adversarial-coupling-pressure`), on an axiom-adoption decision elsewhere ("**Without (PI) adoption.** … This is the adjacent-family status.", `deriv-fisher-whitened-update-rule`; "this segment's status remains conditional on (PI) alone unless explicitly extended", `deriv-fisher-local-update-gain`), on another segment landing ("When (S-2) lands, the symbiogenic-limit result can be promoted to derived.", `deriv-critical-mass-composition`), and on a *pending decision* ("should be re-typed when SP-30 is decided", `disc-structural-imagination`).

### 3.4 Negative space: "what this does not establish / claim / say"

A recurring block, in many phrasings: "**What this does not establish:**" (`deriv-adaptive-gain-dynamics`, `deriv-matrix-persistence-condition`, `deriv-persistence-cost`, `deriv-strategic-composition`, `deriv-update-detection-latency`, `result-sector-persistence-template`), "**What the result does NOT say:**" (`deriv-recursive-update`), "**What this segment does not claim.**" (`form-consolidation-dynamics`, `disc-modularity-state-dynamics`), "**Not claimed:**" (`scope-adaptive-system`), "**What the classification does not claim.** (i)…(iii)" (`der-interaction-channel-classification`), "**One thing this segment must not be read as claiming.**" (`hyp-solicitable-escape`), "**The no-go is about *uniformly* lossy turnover.** … the segment must not be read as if per-boundary lossiness alone forces decay." (`der-turnover-information-recursion`), "**Scope honesty — what this does not do.** … Reading it as having cracked the symmetric equilibrium problem would be an overclaim" (`der-resource-bounded-destabilization`), "Outside the conditions, the result is not claimed." (`deriv-evidence-allocation-ceiling`), "AAT does not claim to predict …" (`deriv-strategic-composition`), "The claim that *all* of AAT's distinctive moves fit this shape is *not* made and would be false" (`disc-constructive-impossibility-posture`). Also the "Load-bearing: / Not established:" bullet pair (`der-agent-opacity`, `der-architecture-noidentifiability`, `deriv-l1-update-bias`, `deriv-variational-sector-condition`, `def-identity-sufficiency`, `hyp-substrate-transfer-asymmetry` — the last with three buckets "What is derived / What is hypothesized (not derived) / What is not established here").

Related and worth separating: **warnings to downstream readers** — "Downstream segments that use the linear operational forms should be understood as expressing task adequacy, not structural stability." (`result-persistence-condition`); "so downstream uses of 'additive tempo is conservative' are unsafe unless the common-source … structure is verified for the application." (`deriv-tempo-additivity`); "This distinction is load-bearing: downstream results that use … as an equality … are strictly correct only for $n = 1$ or for worst-case disturbance." (`detail-linear-ode-approximation`); "every statement of the threshold in this corpus is sufficiency-plus-class-tightness, never a fixed-agent iff." (`deriv-sector-condition`).

### 3.5 "What would strengthen this / What would soften this" — 20 segments

First appears in `der-mood-timescale` ("What would strengthen this: … What would soften it: …") and becomes a fixed paragraph pair in nearly every 03 and 04 segment, together with "**What this scope/discussion/definition is for.**" and "**Max attainable status:**". `disc-five-forcing-functions` adds "**This is honest, not a defect.**". These are the only carriers in the corpus that record *what evidence would move the status in each direction*; the Claim Record's "Falsifier" field (§5) does half of this for 24 segments.

### 3.6 Verification events and history recorded inside ES

FORMAT says ES is present-truth in segment voice, history belongs in CHANGELOG. In practice 22 ES sections record verification acts and 19 record history:

- "The derivation was independently refute-verified (2026-06-17): every algebraic step re-derived clean" — `der-mood-timescale`
- "independently re-derived and verified in full (spike trail 2026-06-10)" — `der-multi-timescale-stability`
- "Independently verified pre-landing (refute-posture re-derivation against all cited segments; the verification corrected the first draft's sector-freeze overclaim, its inverse-as-contrapositive, and two over-labeled 'exact's — the trail is preserved in the spike record)." — `der-severed-actuation-dynamics`
- "(four independent implementations agree to four digits)"; "has been read at the primary" — `deriv-sector-condition`
- "P4's cap was also checked on random parameter draws (the integrator's 20,000 and the independent checker's, none violating it)" — `deriv-observation-noise-placement`
- "it was proposed by the independent verifier and re-derived by the integrator." — `deriv-graph-structure`
- "primary-verified against the on-disk text of \citep[Defs.~2, 5, 7, 9 and Thm.~1]{…} (`ref/bareinboim-2022-pearl-hierarchy.pdf`, 2026-07-16) … a professional literature search (Undermind, 2026-07-16 …) found **no published statement or implication of the separation**" — `deriv-mechanism-counterfactual-separation`
- "primary-source verification scheduled for promotion past `draft`" — the three imported-theorem segments, which nonetheless call the import *exact*.
- History: "Previously discussion-grade; upgraded after routing formalization in #scope-multi-agent … (2026-04-01)." (`hyp-directed-separation-under-composition`); "The previous sketch argument … has been replaced by a rigorous chain" (`deriv-graph-structure`); "replaces an earlier Shannon-MI form … which had a Shannon-zero degeneracy" and "(commit `a14682e`)" (`form-strategy-complexity-cost`); "**Historical note on the presentation choice.**" (`disc-credit-assignment-boundary`); "Originally treated as a discussion-grade heuristic, the unified objective has now been formally derived" (`disc-ciy-unified-objective`); "The previously noted 'regime mixing' is resolved" (`result-per-dimension-persistence`); an open/resolved ledger with ~~strikethrough~~ and "**Resolved.**"/"**Partially resolved.**" (`deriv-edge-credence-dynamics`, "What remains open:"); "its former grounding … was refuted" (`der-tempo-composition`).

Verification *who/how/when* has no slot of its own, so it lands in ES prose, Working Notes, or in Claim Records ("The check is recorded in `reviews/` (the F72 verification).", `schema-strategy-persistence`).

### 3.7 Other things ES sections carry

- **Falsifiers in ES** (before Claim Records existed): "**What would refute the decomposition.**" (`der-team-persistence`), "**What would refute it.** Two predictions are testable …" (`hyp-communication-gain`), "**Falsifier.** Exhibit …" (`hyp-solicitable-escape`), "A row is refuted by an implementation in which …" (`def-proprium-mapping`).
- **Disconfirming evidence against the segment's own claim:** "The one measurement available (Discussion) finds total elapsed time per commit growing much more slowly than lines changed, so proportionality to lines cannot hold" (`emp-changeset-size-principle`); "The one non-circular measurement available bears on the count form only, and disfavors it" (`hyp-exponential-cognitive-load`); "The simulation is UNFAVORABLE to deliberation" (`disc-exploit-explore-deliberate`).
- **Confidence attributed to a person or to convergence:** "The hypothesis is *higher-confidence* in the categories Joseph specifically named … *'these are some of my higher confidence hypotheses.'* (Joseph, 2026-05-01)" (`hyp-checkpoint-forking-failure-modes`); "This scope narrowing converged independently across three formalism attempts" (`scope-and-or`); "The instance set is convergence-validated … but convergence is not derivation" (`disc-anti-collapse`); "the dominant structure … converged on across three independent attempts" (`def-strategy-dag`).
- **Reading-depth of citations:** "(abstract read 2026-10-30; the experimental setup is unread …)" (`der-causal-hierarchy-requirement` CR); "the result is cited from recall, the bibliographic record is checked" (`form-objective-functional` CR); "The body's characterization of Aguilera et al. is not recorded here as read at the primary." (`result-sector-persistence-template` CR).
- **Honesty vocabulary as a tier marker:** the word *honest* appears in 25 ES sections ("the honest tier is …", "honest scope", "honestly open", "stated without deflation", "not papered over", "is honest and limited"); `## Honest Limits` ×3 and `## Honest failure modes` ×3 as section headings; labels `*[Scope honesty — strategic-composition-failures]*`, `*[Scope honesty — variational-alpha-prime-limits]*`. Four ES sections contain "this is not a weakness / not a defect" (`der-recursive-update`, `deriv-recursive-update`, `deriv-strategic-composition`, `disc-five-forcing-functions`).
- **ES referring to project methodology by name:** "A landing of this content at flat 'exact' would itself be an integration-is-replacement failure (sharp-but-mis-tiered replacing soft-but-honestly-tiered)" — `der-identity-continuity-threshold`. "(a Gate-2 class concern …)" — `sketch-structural-adaptation-genericity`.
- **Status pinned to a date / build-state:** "V1-V4 describe the system's design and its verified build state as of 2026-07-16 … **agents not yet embodied** … Claims here about what the laboratory *will* offer … are forward-looking and marked so" — `obs-authored-world-laboratory`; "(F1) … the *current numerical bounds* are time-indexed." — `disc-five-forcing-functions`.

---

## 4. The inline `*[ … ]*` labels (802)

### 4.1 Kinds

First word of the bracket, mechanical: Derived 341, Definition 135, Discussion 110, Formulation 49, Hypothesis 36, Scope 29, Empirical 16, Assumption 14, Result 10, Operational 10, Observation 9, Postulate 8, Derivation 4, Exact 4, Template 4, Heuristic 2, Conditions 2, Sketch 2, Proposed 2, Commitment 2, Structural 2, Worked 2, and one each of Classification, Proved, Illustrative, Corollary, Conditional, Min, Normative, Measurement, Composition. By volume: 01: 604, 02: 92, 04: 60, 03: 46.

FORMAT's nine canonical forms account for Definition / Derived / Hypothesis / Empirical Claim / Formulation / Discussion / Assumption / Postulate. Everything else is improvised: `Scope`, `Scope Condition`, `Scope Narrowing`, `Scope note`, `Scope honesty`, `Proposed Scope`, `Result`, `Derivation`, `Template preconditions`, `Template result`, `Conditions`, `Classification`, `Sketch`, `Proved`, `Illustrative`, `Corollary`, `Commitment`, `Structural consequence`, `Structural argument`, `Operational Definition`, `Operational Criterion`, `Operational`, `Operational / ethical`, `Operational consequence`, `Empirical, economic`, `Empirical instances`, `Worked Quantity`, `Worked Objective`, `Measurement`, `Normative`, `Proposed Schema`, `Composition with audit §25 mathematical objection`, and the bare tier-trailers `[Exact; …]`, `[Conditional; …]`, `[Discussion-grade.]`, `[Min-operation: conditional …; the matrix information floor: conjecture.]`.

### 4.2 What goes inside the bracket — four different things

Reading the 802 I count four distinct things the parenthetical carries, often together, with no fixed order:

1. **a name/slug for the claim** — `*[Definition (strategy-dag)]*`, `*[Derived (chain-confidence-decay, mathematical identity)]*`; sometimes a descriptive phrase instead of a slug — `*[Derived (steady-state MSE)]*`, `*[Derived (Proof Step)]*` (16 of these), `*[Derived (Result 1 — strictness witness)]*`;
2. **provenance / what it follows from** — "from …" appears in 138 labels: `*[Derived (Hb-variance-decomposition; exact in linear-Gaussian sub-scope $\alpha$)]*`, `*[Derived (from Cox's theorem)]*`, `*[Derived (Kalman-tight, Duncan 1970; Mitter & Newton 2005)]*`, `*[Derived (at #deriv-mechanism-counterfactual-separation); agentic restatement]*`;
3. **the condition** — "Conditional on" in 65 labels: `*[Derived (Conditional on Beta-Bernoulli model, observable intermediate)]*`, `*[Derived (convention-monotonicity-right-rung, Conditional on (M) membership of the stitched replanner in $\Pi$, and (PC) prefix-closure of $\Pi$ or (SO) state-wise optimality of $\pi^\ast$; on the first-action reading of $A_O^{\text{B}}$)]*`;
4. **a tier** — 126 labels carry a tier word, in three syntaxes: inside the paren (`*[Derived (Super-additive witness, exact)]*`), after the paren (`*[Derived (fano-degeneracy-at-zero-information), exact]*`, `*[Postulate (myerson-satterthwaite-1983, imported), exact]*`, `*[Derived (…), robust qualitative]*`), or as `status:` (`*[Derived, status: exact.]*`, `*[Derived, status: exact scope-exit statement.]*` — FORMAT mentions this "C-BP4" form as hypothetical; it exists twice in `form-composition-closure` and once in `form-sector-condition`).

Plus free prose: 31 labels are 15+ words; the longest are full sentences — `*[Discussion-grade as an anchor — the leading-order scaling is stated, the constants are not derived here.]*` (`deriv-mismatch-budget-attribution`), `*[Formulation — stated fluid-limit convention, introduced here; not a pre-existing canon identity. The structural conclusion below is convention-robust: any $\nu \gt 0$ preserves additivity, since positive scaling of a sum is a sum.]*` (`internal-external-decomposition`), `*[Discussion — this convergence is structurally argued, not empirically demonstrated in full. … An empirical test: …]*` (`der-principled-decision-integration`), `*[Derived (what a constant aspiration layer does and does not secure; from the definition of Class 1 in #der-directed-separation, Theorem 1 and the selection-channel paragraph of #der-class-coercion-via-wrapping, conditional on the aspiration layer changing only at revision events, #der-temporal-nesting)]*` (`def-auxilia-hierarchy`). In 02-tst-core the `*[Discussion — …]*` form is routinely a one-clause epistemic annotation: "— empirically plausible, not derived.", "— taxonomy, not derived.", "— operationalizable but unmeasured.", "— well-established observation, not derived within AAT.", "— qualitative observation.".

100 labels are bare (no parenthetical, ≤2 words): `*[Discussion]*` ×~70, `*[Derived]*`, `*[Definition]*`, `*[Hypothesis]*`, `*[Assumption]*`, `*[Heuristic]*`, `*[Formulation]*`, `*[Operational Definition]*`, and the punctuated variants `*[Discussion.]*`, `*[Hypothesis.]*`, `*[Formulation.]*`, `*[Derived; classical.]*`.

### 4.3 Placement

FORMAT puts the tag "before equations". In practice: before display math (the majority in 01); at the head of a bold-led prose paragraph (`**Productive infeasibility — the aspiration hypothesis.** *[Hypothesis (aspiration-dominance)]* …`); mid-sentence (`… the gain-collapse pathology … *[Discussion]*.` in `deriv-tempo-additivity`; `*[Empirical Claim]* Simulation confirms: …` inside a Discussion paragraph, `def-adaptive-tempo`); at the END of a paragraph as a tier verdict (all of `impl-persistence-and-limits`: `*[Exact for the quantity; the design reading is discussion-grade.]*`, `*[Conditional; exact in the linear-Gaussian case.]*`); inside the ES section itself (`der-tempo-composition` has derivations with labels under `## Epistemic Status`); inside Claim Records as the identity of the tagged claim ("**Register:** formal — … (tag *[Derived (linear correction, Model S, white channel noise)]*)", `result-persistence-condition`); and inside Working Notes as auditors quote them (`def-action-transition`: "Two substrates read the `*[Definition (transition opacity)]*` tag as mistyped … the eq-tag taxonomy for constitutive-scope claims is genuinely ambiguous").

Two segments with substantial formal content carry zero labels: `deriv-recursive-update` (exact) and `def-proprium-mapping`. 33 segments have none.

### 4.4 Label vs frontmatter disagreements

The label is a claim-level status, the frontmatter a segment-level one, so disagreement is expected; the cases that look like defects rather than granularity: `exact` segments whose labels say `Conditional on …` (§2.2); `disc-ciy-unified-objective`'s `*[Discussion (unified-policy-objective — heuristic)]*` surviving an ES that says the heuristic is "formally superseded"; `der-change-expectation-baseline` Working Notes: "The former C-04.1 'Investment Scaling' corollary carried a *[Derived]* tag it could not support … is marked heuristic. Don't re-promote it without deriving the threshold." — a recorded label error and a guard against its recurrence, living in WN.

---

## 5. The `## Claim Record` (24 segments, 79 entries)

Fields as FORMAT prescribes: Register / Population / True of / False of / Falsifier / Instantiated. Registers: formal 51, descriptive 18, normative 10 — plus one improvised "**Register:** formal, imported" (`def-agent-spectrum`). "Instantiated" values: "not applicable" 38, "no" 33, and eight nuanced ones — "by an external study as reported, not by this project", "not by this project", "on humans, in the economics and decision-theory literature, yes for both halves, cited here from recall; not by this project", "no; the simulations are of the theory's own recurrence", "no, for every class the theory did not build". "True of" entries routinely end "(internal consistency, not instantiation)".

What the Claim Record turned out to do, beyond FORMAT's intent, is **audit the body and the ES from inside the segment**:

- "the body does not name the class by a defining property, so the claim is not yet checkable against a boundary." — `def-strategy-dimension`
- "**False of:** the segment's own window … The sentence 'structural failure requires changing the correction architecture entirely' is therefore false of retunable gains and of added information." — `result-persistence-condition`; and against its own ES: "**Register:** descriptive — Epistemic Status: 'The threshold's *existence* is *robust qualitative* …' **Population:** real correctors. Read as a statement about functions it does not hold … **False of:** $F = \mathcal T\bar\delta$, by the segment's own linear case."
- "in that sense the opening's 'a stability certificate exists for an agent exactly when the agent is exponentially stable' is false, and the equivalence holds for the (C) sense only." and "The Epistemic Status sentence … contradicts this instance unless it is read at $\mathcal M = I$" — `result-certificate-existence`
- "The body's further sentence that 'AAT's Lyapunov machinery … require[s] $C^1$ or better regularity' is not this population: Prop A.1S there needs only $F$ measurable and locally bounded" — `form-sector-condition`
- "the 'requiring' sentence is refuted as stated." — `result-sector-condition-stability`
- "the magnitude $\kappa \approx 1$ that `03-llm-core/` assumes for LLMs is unmeasured." and "humans are not placed … the classification of humans is a conjecture carried in two cells" — `der-directed-separation`
- "The body claims (A4) of no class; the value object's expectation (#def-value-object) uses it anyway, so for any target-class agent the cardinal form is a hypothesis this entry carries." — `form-objective-functional`
- "**Falsifier:** for the exact parts, a derivation error." — `der-loop-interventional-access`

So the newest carrier is already a second voice inside the file, with findings that in FORMAT's own terms belong in `reviews/` or in the body.

---

## 6. Carriers the brief did not name

### 6.1 Citation-depth footnotes
`[^recall-2026-10-30]` (29 uses, 9 segments): "Cited from the bibliographic record; existence, authors, year and venue were checked on 2026-10-30, and the primary has not been read in this project." with variants ("the theorem number is from recall and should be checked against the book"; "lemma unread"; "unverified beyond that scan's own status table"). `[^cat-2026-05-22]` (31 uses): "Citation surfaced 2026-05-22 from the Track E catalog at `ref/prior-art-analysis/` … more verification support than raw Undermind synthesis but less than full primary-source reading. Verification queued with the BG2 cluster." and "the characterization is verification-deferred." `[^bg2-2026-05-21]` similar. This is a *reading-depth status for a citation*, dated, with a named verification queue — a full status apparatus the authors built for a thing (citations) FORMAT has no slot for.

### 6.2 Headings as status
`## Honest Limits` (`der-agent-opacity`, `der-architecture-noidentifiability`, `deriv-strategic-composition`), `## Honest failure modes` / `## Honest Failure Modes` (`deriv-observation-ambiguity-bias-bound`, `deriv-variational-sector-condition`, `result-contraction-template`), `### §5 — Failed derivation routes (honest record)`, `### What is solid versus suggestive` (`disc-w1-structural-bound-boundary`), `### Tier` (`der-architecture-noidentifiability`), `### The No-Go Theorem (exact in the linear-Gaussian / Kalman sub-scope)`, `### Caveat on the (UO-mult) coupling assumption (audit §62 §3 surfacing)`, `## Mapping Quality Summary` (the three worked examples), `### Pointers for Fleshing Out` (16, all 03/04 Working Notes).

### 6.3 "What Is Derived vs. What Is Chosen" tables (20)
A table per derivation segment with a Strength column whose vocabulary is its own: `deriv-graph-structure`'s column reads "Proved / Proved / Proved / Derived / Proved under causal sufficiency (CMC theorem) / **Conditional on causal sufficiency — which is testable and repairable** / Proved: exact for all credences iff … / Hypothesis (binary outcomes only) / Formulation choice / Formulation choice". `deriv-critical-mass-composition`'s has a row "(UO-mult) … | Discussion-grade". `deriv-persistence-cost`: "Conditional (holds as lower bound; tightness requires the optimal linear-Gaussian filter)". Note "Proved" — the word FORMAT's naming note avoids at segment level — is the normal word at row level.

### 6.4 Status talk in the unread sections
A vocabulary scan (tier words, "max attainable", "epistemic status", "tier") over everything outside ES / Claim Record / label lines hits 237 of 247 segments: Working Notes 538 hits, Formal Expression 505, Discussion 251, Findings 90, other sections 774. Sampled lines show three kinds: the Derived-vs-Chosen tables (counted above); Findings tables with a relation column ("*formal antecedent*", "*adjacent*", "*adjacent literature*"); and Working Notes audit-gold items debating a label or status ("'Open questions' inside a `claims-verified` segment 'blurs the project convention slightly'", `der-deliberation-cost`; "**Equation-tag-vs-content typing of 'transition opacity.'**", `def-action-transition`; "Make the Model-D / Model-S split visually distinct … candidate to lift to separate equation tags", `hyp-mismatch-dynamics`). In the one segment I read whole (`der-deliberation-cost`), the Working Notes contain a resolved status dispute ("Resolved as heuristic-but-consistent under the segment's chosen rate-comparison framing (the `conditional` status and the 'design criterion, not real-time procedure' caveat already cover it)") and a scope-honesty follow-up routed from auditors — status adjudication that is neither in ES nor in any carrier a model would find.

### 6.5 Stage
`stage:` is 83% `draft`, and FORMAT says it "is currently ignored in practice". Yet three ES sections bind their *status* ceiling to a dependency's *stage* (§2.4), and `hyp-behavioral-self-knowledge-insufficiency`'s ES ends by quoting its own stage: "`stage: exploratory` — under active discussion; the derivation is stable but the premise, the taxonomy's exact boundary, and the placement of the moral reading (below) are open." The "ignored" axis is doing live work in a few places.

### 6.6 A segment that is a status flag on another segment
`sketch-structural-adaptation-genericity`: "This segment makes **no** claim that the bridge holds or fails; it records that the hand-off currently asserted in `#deriv-sector-condition` / `#deriv-stochastic-non-exit` Discussion/Findings is **plausibly a mild overclaim at the Discussion/Findings tier** … and that the resolution path is to attempt the bridge derivation. … Until attempted, this stays `sketch`." The segment system had no way to attach "possible overclaim, unadjudicated" to another file, so a file was created to hold it.

---

## 7. What were they saying, and what were they asking?

Reading all 220 ES sections in sequence, the authors were not mostly asking "which of eight bins is this segment in?" They answered that in the first word and then spent the median 200 words answering other questions the bin cannot hold. Pulling the questions apart, these are the ones that recur, each with the carrier that ended up (mis)holding it:

1. **What kind of statement is this?** (definition / formulation / scope / postulate / derived / hypothesis / normative / imported theorem / recapitulation / procedures document / structural mapping / worked instantiation / catalog). Officially `type:`; in practice re-asserted as the ES opener in ~40 segments, sometimes against `type:` ("*Recapitulation of an external result.*" for a `definition`; "This is a *definition*" for a `scope`), and improvised in labels (`Commitment`, `Scope Narrowing`, `Template result`, `Operational`). The authors also wanted *finer* kinds than FORMAT offers: "imported", "recognition, not new mathematics", "transcription of established theorems into AAT notation", "procedures document", "a research program, not a derivation", "a conceptual-engineering act".

2. **How strong is the derivation, per claim?** The eight-word `status:` scale, applied to components rather than segments (§3.2), plus a dozen improvised intermediate words. The segment-level word is then chosen by a "weakest load-bearing component" rule that is stated in three places and silently applied elsewhere.

3. **Which premises does this rest on, and who owns each one?** This is the question behind the exact/conditional line (§2.2) and it has three answers the authors kept distinguishing: a premise is *inside the theory's depends chain*; it is a *standing global assumption* (GA-1, "the global assumptions in NOTATION.md"); or it is *a property of the world / application / deployment* ("a statement about a deployment's substrate-update policy, not about the formalism"). FORMAT's `depends:` field records only slugs, so premise-ownership was pushed into prose — "(S0)–(S5)", "(R1)–(R5)", "(IS-A1)–(IS-A3)", "(C1)+(C4)", "(FW) and (REC)", "sub-scope α / β" — and the status word was asked to summarize it.

4. **What is the ceiling, and what would raise or lower the floor?** "Max attainable" (106) in four senses; "What would strengthen / soften" (20); promotion gates named as citation searches, axiom adoptions, pending decisions, other segments landing, or dependencies leaving draft.

5. **Who checked this, how, and when?** Independent re-derivation, refute-posture verification, four implementations agreeing, Monte Carlo against closed form, primary read on a dated day, simulation of the theory's own equations ("not an instantiation"). No slot; lands in ES prose, Working Notes, spike trails, `reviews/`.

6. **How well do we know the citations we lean on?** The `[^recall-…]`/`[^cat-…]` footnotes, "cited by their real names", "primary-source verification scheduled", "abstract read … the experimental setup is unread".

7. **What is this *not* claiming, and how should downstream readers use it?** Negative-space blocks and downstream warnings (§3.4), the "must not be read as" sentences.

8. **Of what is it true?** Population, True of, False of, Instantiated — the Claim Record's axis, which FORMAT introduced in October exactly because "a reader hears 'exact' as 'true of agents' when it means only that the derivation is valid"; 24 segments have it, and in them it has started correcting the other carriers.

9. **What happened to this claim over time?** History in 19 ES sections against FORMAT's present-truth rule; strike-through ledgers; "Previously discussion-grade; upgraded after …".

10. **How confident are *we*, and why?** Convergence across attempts, a person's stated confidence, "the intuition is …", "plausible but unverified", "highly plausible but requires empirical validation".

On the brief's own question — whether sorting is the right shape — what I saw suggests it is not, at the segment level. The one word per segment is the least informative artifact in the whole apparatus: 60 of 220 openers do not even repeat it, 155 ES sections immediately contradict it at component level, and the authors wrote the rule for compressing to it ("weakest load-bearing component") only because the field demanded a single value. What the authors were actually doing, consistently across four volumes and many hands, was recording *claims* (not segments) with, for each: a kind, a strength, a named premise set with ownership, a ceiling, a verification record, and a population. Everything improvised — the per-component ES, the tier suffixes on labels, the Derived-vs-Chosen tables, the Claim Record — is a move from segment-grain to claim-grain. The footnote markers are the same move applied to citations.

Two things the corpus does *not* have, and would need if claim-grain were made official: a stable identity for each claim (labels have slugs sometimes, descriptive phrases sometimes, nothing often; Claim Records key by heading sentence; Derived-vs-Chosen tables key by row text), and a place for a *judgement* to live separately from its *outcome* (why this premise was judged world-side; who judged; whether a later reader agrees — the Claim Record is starting to be that place by accident).

---

## 8. Tensions and probable defects worth a look (with slugs)

- `disc-composition-consistency` — ES opener "*Axiomatic*" against `status: discussion-grade` after the 2026-05-28 retype (§2.5).
- `exact` + local-premise labels: `deriv-evidence-allocation-ceiling`, `der-change-expectation-baseline`, `detail-linear-ode-approximation`, `der-multi-timescale-stability`, `deriv-convention-monotonicity` (§2.2). Either the rule or the word needs deciding.
- Imported classical theorems called *exact* while "primary-source verification scheduled": `deriv-bilateral-trade-impossibility`, `deriv-social-welfare-aggregation-impossibility`, `deriv-strategy-proofness-impossibility`.
- Status capped by a dependency's *stage*: `deriv-reward-channel-learning-no-go`, `deriv-self-actuation-grounding`, `der-captured-objective-dynamics` — FORMAT says stage is orthogonal and ignored.
- Scopes at `sketch` whose ES says the scope condition is exact: `scope-channel-collapse`, `scope-interiority-loop`, `scope-primitive-logogenic`, `scope-scaffolded-logogenic`, `scope-eli`.
- `type: discussion` at `robust-qualitative` (4) vs the "capped by type" rule stated in `disc-ciy-unified-objective`; `type: derived` at `discussion-grade` (`der-bounded-objective-as-sanity-criterion`).
- `emp-update-gain`: type empirical, status robust-qualitative, ES opener "*Derived*".
- Label survives its own supersession: `disc-ciy-unified-objective` "(unified-policy-objective — heuristic)".
- Meta-pattern ES sections restate other segments' tiers (`disc-identifiability-floor` and six siblings) — a staleness hazard with no mechanism.
- Claim Records that state a body or ES sentence is false (`result-persistence-condition`, `result-certificate-existence`, `result-sector-condition-stability`, `form-sector-condition`) with the sentence still standing in the body as far as the extracted text shows.
- Tier ordering implied in `der-team-persistence` (conditional above robust-qualitative) is nowhere stated and is contradicted in spirit by `deriv-identity-sufficiency-rate-bound`.
- Three segments carry no apparatus at all and are not intros/impls: `norm-interiority-default`, `obs-developmental-trajectory`, `scope-moral-continuity` (plus `obs-evaluation-metrics`).

---

## 9. Feedback on the brief, and adjacent things

- The ask was right-sized in one respect and mis-sized in another: "primary text, all of it" is not achievable in one context for 5.6 MB, and the brief did not say so. I chose to read the *apparatus* whole for every segment rather than whole segments for a subset; I think that was the better trade for this question, but a brief that knows the corpus size could say which trade it wants. The sampled read of bodies (§6.4) suggests a real second census would be of Working Notes, where auditors' status disputes and their resolutions live.
- The brief's three carriers undercount by about half (§1). The one most worth adding to any model is the dated citation-depth footnote, because it is the only carrier that already has the shape (date, what was checked, what was not, where verification is queued) the rest of the apparatus is groping for.
- The message loosening the blind constraint arrived mid-read. I did not act on it; if anything in the earlier readings contradicts §7, that comparison is still clean.
- Adjacent: FORMAT's own text says of the "What Is Derived vs. What Is Chosen" table, "Claim-level statuses inside equation tags (e.g., `*[Derived, status: exact]*`) would serve as the inline implementation" — "if adopted". It was adopted, three times, in `form-composition-closure` and `form-sector-condition`, without the SOP recording that.

## 10. After the blind part

Everything above §10 was written before I looked outside the corpus. After writing it I did one thing with the loosened permission: a keyword scan (not a full read) of `~/src/aat-v3/preparations/research/joseph-messages-2026-10-28--11-05.md` for status-related remarks. I did not read other agents' census files or memorata. Nothing above was changed; these are correspondences I can now name:

- Joseph: "there's only one epistemic label-- you can't simultaneously say 'used to be ______ with high certainty' -- that's a function of the log etc." The corpus violates this in 19 ES sections (§3.6) — but, read charitably, the authors were storing history there because the log layer did not yet exist for them as a place a reader would look.
- Joseph: "often it's two phase when a defect is discovered: 1. Honest-intermediate -- usually lowering a claim or claim's certainty (no longer exact, now conditional, ....) … 2. … a spike that is the strengthening attempt". The exact→conditional moves and promotions recorded inside ES (`hyp-directed-separation-under-composition`, `deriv-graph-structure`, `disc-ciy-unified-objective`, `der-multi-timescale-stability` "conditionalized, not closed") are exactly this two-phase cycle, with the phase recorded nowhere but in the prose.
- Joseph: "if a proposition has 4 or 5 upstream findings that it relies on, each with high epistemic value and a certainty that just barely keeps it on that label--- in aggregate it might cap that downstream proposition at an epistemic label one rung *lower*". The corpus already does downstream capping by hand (§2.4: "the weaker link governs"; floors from `#hyp-communication-gain`; caps from a dependency's *stage*). The stage-caps-status cases are the authors reaching for a certainty-on-the-upstream-label that had no slot, and using `stage: draft` as its proxy.
- Joseph (on novelty): "something that evolves from more of a soft tracker to a well-defined metric/ladder to an auditable value to one that has its history and deliberations as part of its record". The citation-depth footnotes (§6.1: `recall-…` → `cat-…` → "read at the primary") are a small instance of this evolution already happening in the corpus, by hand, for one aspect.
- Joseph: "Right now one of the most effective … higher-level mechanisms in ASF is the 'Working Notes' sections … that allows the accumulation of 'misc' and that is an influx". §6.4 agrees and adds the specific point that status *adjudications* (not just misc) are currently settled there.
- Joseph's distinction between a label and its separate certainty ("novelty: high (certainty: ...)"): §2.2's finding is that the exact/conditional word in ASF is carrying a *judgement* (is this premise inside or outside the theory) whose confidence is never recorded; that judgement is the thing a certainty would attach to.
