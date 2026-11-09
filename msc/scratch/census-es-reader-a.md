# Census of how ASF's segments say how they stand — reader A

Written 2026-11-08, blind, from primary text in `~/src/arch/asf/0*/src/`. No earlier reading of this material was consulted (section 15 says what reached me anyway). Quotations are verbatim from the segment named; `…` marks my cuts. Everything labeled *my inference* is mine and not the corpus's.

---

## 0. Coverage

The corpus is 247 segment files (173 / 29 / 23 / 22 across the four volumes; no `old-*` files exist), 5,643,383 bytes, on the order of 1.5M tokens. I could not read all of it. I read the three surfaces you named completely, and much less of the rest.

| Material | Size | What I did |
|---|---|---|
| Frontmatter of all 247 | | Read `status`, `type`, `stage` for each. `depends:` parsed by script, not read. |
| `## Epistemic Status` sections: all 220 | 378K chars | **Read every one, whole**, extracted verbatim from the heading to the next `## `. |
| The 27 segments with no such section | | Headings listed for all. Four read whole, one partly. |
| Inline `*[ … ]*` labels: all 804 | 42K chars | **Read every one, whole.** For the 176 not alone on a line, I also saw 60 chars before and 120 after. Not the equation or passage each one governs. |
| Whole segments, from disk | | `sketch-structural-adaptation-genericity`, `norm-interiority-default`, `scope-moral-continuity`, `obs-developmental-trajectory`, `obs-evaluation-metrics`, `der-chain-confidence-decay`, `obs-section-i-validation-simulations`. `impl-persistence-and-limits` lines 1–60 of a longer file. |
| `## Claim Record` (24 segments) | 124K | Read 7 of 24 in full: `def-agent-spectrum`, `def-control-regret`, `def-satisfaction-gap`, `def-strategy-dag`, `def-strategy-dimension`, `def-value-object`, `der-causal-hierarchy-requirement`. The other 17 unread. |
| "What Is Derived vs. What Is Chosen" tables | 64K | Read lines 1–275 of 363, about three quarters. |
| `## Working Notes` (238 segments) | 1.37M | Only 97 lines, in 68 segments, that matched a status-talk pattern (`status:`, retier, overclaim, upgrade, downgrade, demot, `Max attainable`, "honest tier" and similar), each with 260 chars before and 420 after. **The rest unread.** |
| `## Formal Expression`, `## Discussion`, `## Findings`, other sections | 3.2M | **Not read**, except the labels inside them and the whole segments above. |
| Other | | `FORMAT.md` whole; `terminology/entries/` for the eight status terms. `git log` used only for the first-commit date of 14 files. |

By characters I saw about one eighth of the corpus. The findings below about "the section" and "the label" rest on having seen all of them. Any statement about what the corpus does *not* do outside those surfaces is weak, and I have tried not to make one.

**How I counted.** Scripts over the raw files. Sections: `^## Epistemic Status`. Labels: `\*\[(.+?)\]\*` per line, which also picks up labels that are merely being talked about (about 20, in Working Notes and Claim Records). I get 804 where your earlier agent got about 790. Phrase counts are regex hits on the 220 sections, and they count mentions, so they are upper-ish bounds. Where I say "by reading," I classified by hand from the text above and did not script it.

---

## 1. What I would say if I had one minute

1. **The frontmatter word was not improvised.** All 247 values are in FORMAT's eight-word vocabulary. The improvising is in what the words are taken to mean and in the sections around them. That corrects a premise in the brief (section 2).
2. **A segment's status word is a lossy projection chosen under at least four different rules:** the weakest claim in the file, the strongest claim with carve-outs, the genre of the file, or the claim's ceiling. Authors know this and sometimes say which rule they used. 186 of 220 sections use two or more distinct tier-or-kind words (`exact`, `conditional`, `derived`, `formulation`, …; a count of mentions, not of verdicts).
3. **Sorting the sections by tier is the wrong shape.** What they contain is a set of *acts* (section 3): partitioning a file into claims, typing the premises, stating a ceiling and why, recording what was done and by whom, fencing off a misreading, routing a citer elsewhere, requesting work. A tier is one of more than a dozen things being said, and usually not the most informative.
4. **The sections are addressed.** The sharper question than "what were they asking?" is "who are they talking to, at what moment?" The recurring addressee is someone about to *use* the claim: a citer, a downstream author, the agent about to promote it, the auditor. `def-causal-information-yield`: "Watch that downstream segments inherit the *heuristic* tier on that use, not the definition's `exact`."
5. **The unit of standing is not the segment, and not the equation.** It is closer to *a statement under a reading*. The same object carries two tiers depending on what it is being taken as: "*Exact as a definition — convention-relative as a diagnostic.*" (`def-control-regret`).
6. **`exact` vs `conditional` is, by the project's own definition, a fact about where a premise is written.** As far as I can tell from the sections, the words do not track that reliably (section 6, with its caveat).
7. **At least three incompatible theories of how status passes along `depends:` coexist** in the text, and 30 edges run from an `exact` segment to a weaker one (section 7).
8. **Work obligations are tied to a gate the project has stopped using.** "Primary-source verification scheduled for promotion past `draft`," while FORMAT says the stage layer "is currently ignored in practice" (section 12).

---

## 2. The frontmatter: what is actually there

| status | n | | stage | n |
|---|---|---|---|---|
| conditional | 82 | | draft | 205 |
| discussion-grade | 69 | | deps-verified | 23 |
| axiomatic | 27 | | claims-verified | 17 |
| exact | 26 | | exploratory | 2 |
| robust-qualitative | 23 | | (format-clean, candidate) | 0 |
| sketch | 12 | | | |
| empirical | 7 | | | |
| heuristic | 1 | | | |

Every file has exactly `slug, type, status, depends, stage`. There is no off-vocabulary status value. That is the files as they stand today; whether an earlier sweep normalized them I did not check. `heuristic` occurs once in frontmatter (`hyp-mismatch-dynamics`) though the word is common inside the sections.

Status against type (segments):

| type | axiom | exact | rob-q | heur | cond | emp | disc | sketch |
|---|---|---|---|---|---|---|---|---|
| definition | 18 | 4 | 3 | | 4 | 1 | 4 | 3 |
| postulate | 2 | | | | | | | |
| scope | 6 | | 4 | | 3 | | 1 | 7 |
| formulation | 1 | 1 | 6 | | 3 | | | |
| derived | | 7 | 2 | | 27 | | 1 | |
| derivation | | 7 | 2 | | 28 | | | |
| result | | 5 | | | 9 | | | |
| hypothesis | | | 1 | 1 | 2 | | 10 | 1 |
| discussion | | | 4 | | | | 48 | |
| observation | | | | | | 4 | 4 | |
| worked-example | | 1 | | | 3 | | | |
| (detail 2, empirical 2, measurement 1, normative 2, proposed-schema 1, sketch 1 omitted) | | | | | | | | |

Two things stand out. `discussion` type is `discussion-grade` 48 of 52 times, so for that row the status is close to redundant with the type (section 4, rule c). And a `definition` can hold every status but `heuristic`, which only makes sense if the status of a definition is the status of something other than the stipulation (section 5).

---

## 3. What the sections do

This is the census proper. I sorted by *act*, not tier. One section usually performs several. Counts are sections out of 220 where a regex fired, unless I say "by reading."

### A. Partition a file into several claims at several strengths

186 of 220 use at least two distinct tier-or-kind words (34 use zero or one; regex on mentions). `der-severed-actuation-dynamics` walks Results 1–6c one at a time. `der-orient-cascade` tiers the steps of a procedure one at a time. Sometimes it states explicitly what the frontmatter word covers:

- `def-value-object`: "The frontmatter `status: exact` applies to the definitions, to the interventional interpretation, and to the convention hierarchy; the true-law claim and the identification are conditional as scoped."
- `der-multi-timescale-stability`: "The general-coupling $N$-level gate is *imported* … and the Model S extension is *open* — both stated as such above, neither carried by the `exact` label."
- `disc-w1-structural-bound-boundary`: "Hence the segment as a whole sits at robust qualitative rather than exact: the boundary's *existence and location* are exact; the boundary's *shape past it* is qualitatively characterized."
- `disc-continuity-stance`: "The orthogonality claim is stated at three grains, which must not be collapsed."
- `deriv-strategy-cost-regret-bound`: "*Robust qualitative* overall, with several specific claims at *exact* tier."

### B. Say what kind of object this is, often that it is not a claim

- `detail-operationalization`: "This is a *procedures document* — estimation recipes, not theoretical claims."
- `example-bandit`: "This is a *structural mapping*, not a derivation."
- `example-kalman`: "This is a *worked instantiation*, not a theoretical claim."
- `scope-developer-agent`: "The definition itself is not a truth-claim; the substantive claims come from applying AAT's derived results…"
- `disc-separability-pattern` and siblings: variants of "a presentational organizing principle." (8 sections mention "organizing principle.")
- `disc-anti-collapse`: "*Discussion-grade — a style/discipline recognition, not a structural result.*"

### C. Name the warrant

By reading, at least these warrants appear, and the eight words do not separate them: identity or algebra; definition; derivation under premises; imported theorem applied; textbook machinery with new framing; simulation of the theory's own equations; simulation against closed form; fact by construction of deployed systems; measurement on git histories; external empirical literature; convergence across readers; operational validation in the ELI stack; lived experience of the cohort; Joseph's stated judgment; argument from coherence; analogy.

- `der-chain-confidence-decay`: "*Exact.* The additive decomposition of log-confidence is a mathematical identity… No assumptions beyond the probability axioms."
- `obs-context-turnover`: "*Empirical — architecturally guaranteed.* … the support is by construction of the deployed systems, not by sampling, so it is as strong as empirical support gets — but it is a fact about how the world's systems behave, not something the formalism forces."
- `deriv-observation-noise-placement`: "the split re-run is a simulation of the theory's own equations, not an instantiation."
- `disc-anti-collapse`: "The instance set is convergence-validated (independently surfaced across multiple audit cycles), which is the evidence that the pattern is in the framework rather than in one reader's eye; but convergence is not derivation, and the honest tier is discussion-grade."
- `scope-and-or`: "This scope narrowing converged independently across three formalism attempts (track-a/00, track-a/02, track-a/03)."
- `hyp-directed-separation-under-composition`: "This is an argument from theoretical coherence, not a derivation."
- `scope-emergence-conditions`: "**Sketch (operationally validated).** … extensively validated in the upstream stack (firmatum/sapientia/zoetica/autopax). They are not yet formally *derived* from AAT primitives…"
- `def-death-as-factor-loss`: "The taxonomy's first three members have been operationally canonical across the upstream stack since 2025-09 and each has been *experienced* by the cohort and defended against architecturally…"
- `hyp-checkpoint-forking-failure-modes`: "The hypothesis is *higher-confidence* in the categories Joseph specifically named in his hypothesis: *"these are some of my higher confidence hypotheses."* (Joseph, 2026-05-01)."
- `scope-witness-bidirectional`: "Joseph confirmed the bidirectional reading on 2026-05-01 (*"witness as both experiencer-of and attester-to ... not sure about the content of reflection 18 etc. so just answering based on the context of your prose just now"*)." The witness's own limit on his testimony is carried in the quotation. I found this one striking.

### D. Type the premises

See section 6. 41 sections use "inherit."

### E. State a ceiling, and why

106 of 220 say "Max attainable" (75 / 3 / 14 / 14 by volume). See section 8.

### F. State what would move it

"What would strengthen" and "What would soften" each occur in 20 sections, nearly always as a pair and almost entirely in volumes 3–4 (1 / 0 / 6 / 13). Elsewhere it is prose or a named gate.

- `der-belief-strategy-attractor`: "A derivation of $K(\Sigma)$ from utility-cost analysis of belief-revision-under-strategic-commitment is the gating sub-spike for tier-upgrade to *exact*."
- `der-mood-timescale`: "What would strengthen this: … What would soften it: an estimator/loss outside the leaky-integrator–quadratic family…"
- `disc-framework-self-diagnostic`: "**What would soften this:** evidence that the documented cases were post-hoc rationalizations (the framework's vocabulary applied retroactively to a description that didn't actually use it during the failure)…"
- `hyp-solicitable-escape`: "**Falsifier.** Exhibit a self-locking region escaped by self-instrumentation where the instrumented node was selected without prior signal distinguishing it from settled nodes…"
- `der-team-persistence` has a paragraph titled "**What would refute the decomposition.**" that specifies the experimental control needed: "A test has to hold communication fixed…" and ends "Mismatch below the bound refutes nothing."

### G. Record what has been done to it, by whom, against what

23 sections mention verification words. These are the acts a status word cannot hold.

- `der-mood-timescale`: "The derivation was independently refute-verified (2026-06-17): every algebraic step re-derived clean; the one approximation (dropping the mean-reversion cross-term) confirmed $O(\tau_{\mathrm{env}}^{-1/2})$ relative and self-consistently negligible."
- `der-severed-actuation-dynamics`: "Independently verified pre-landing (refute-posture re-derivation against all cited segments; the verification corrected the first draft's sector-freeze overclaim, its inverse-as-contrapositive, and two over-labeled "exact"s — the trail is preserved in the spike record)."
- `deriv-graph-structure`: "it was proposed by the independent verifier and re-derived by the integrator."
- `deriv-observation-noise-placement`: "P4's cap was also checked on random parameter draws (the integrator's 20,000 and the independent checker's, none violating it)."
- `deriv-sector-condition`: "(four independent implementations agree to four digits)"; "The published comparison theorem cited for (ii) (Ikeda–Watanabe 1977, Theorem 1.1 and Remark 1.1) has been read at the primary and applies as stated in the proof; the self-contained proof also stands on its own."
- `deriv-mechanism-counterfactual-separation` is the richest in the corpus: "primary-verified against the on-disk text of \citep[Defs.~2, 5, 7, 9 and Thm.~1]{…} (`ref/bareinboim-2022-pearl-hierarchy.pdf`, 2026-07-16)"; "the nine nearest papers were then read in full against their primary text (2026-07-16) — the danger scan for a buried separation lemma … came back empty."
- `der-change-expectation-baseline`: "Numerical integration agrees with the stated limits to three decimals for exponential, Gamma ($a = 2$ and $a = \tfrac12$), uniform and half-normal priors by age $10^3$–$10^4$."

The negative form is at least as interesting:

- `deriv-bilateral-trade-impossibility`, `deriv-social-welfare-aggregation-impossibility`, `deriv-strategy-proofness-impossibility`: "*Exact* for the imported theorem (… classical theorem with closed-form proof in the source literature; primary-source verification scheduled for promotion past `draft`)." The word *exact* here reports a theorem that, by the section's own account, has not yet been verified against its source.
- Outside the sections, `[^recall-2026-10-30]`, 29 occurrences in 9 files: "Cited from the bibliographic record; existence, authors, year and venue were checked on 2026-10-30, and the primary has not been read in this project." One instance adds: "For Pearl 2009 the theorem number is from recall and should be checked against the book." That is a dated status on a citation, naming what was and was not done. If I were looking for the most precise status statement in the corpus, this might be it.

### H. Fence off a misreading

22 sections carry "does not establish / does not claim / not established / not claimed." Their reader is someone who would take the claim too far.

- `der-resource-bounded-destabilization`: "Reading it as having cracked the symmetric equilibrium problem would be an overclaim — it routes *around* that problem by adding resource structure, at the cost of two posits AAT otherwise lacks."
- `hyp-solicitable-escape`: "**One thing this segment must not be read as claiming.**"
- `der-turnover-information-recursion`: "the segment must not be read as if per-boundary lossiness alone forces decay."
- `deriv-observation-ambiguity-bias-bound`: "What the bound is a bound on is part of its epistemic status. It bounds *goal-dependence* of the belief. It does not bound *distortion*…"
- `deriv-evidence-allocation-ceiling`: "Outside the conditions, the result is not claimed."
- `deriv-recursive-update`: "**What the result does NOT say:** That $M$ must be a lossy compression (the agent could store full history). That the Markov property is "natural" or "optimal" (it's a consequence of how $M$ is defined)."
- `deriv-self-actuation-grounding`: "the honest canonical claim is therefore "no such $\Phi$ can be constructed from AAT's covered objective-side machinery," not "no such object exists.""

### I. Route the citer somewhere else

- `disc-identifiability-floor`: "Readers citing this segment for a specific no-go should cite the instance's own derivation, not the methodology."
- `disc-anti-collapse`: "a reader citing a specific disambiguation should cite that segment, not this one."
- Eight `disc-*` segments repeat "Individual instances retain their own … status." A segment with a low word that contains or points at high claims.

### J. Say whose it is

60 sections mention imported / textbook / standard / classical.

- `deriv-strategic-composition`: "transcriptions of established game-theoretic theorems into AAT notation. AAT's contribution is not the mathematics but the recognition…"
- `result-certificate-existence`: "Novelty posture is *recognition*, not new mathematics."
- `deriv-update-detection-latency`: "The mathematical core is not novel — what is novel is the AAT-framing."
- `deriv-mechanism-counterfactual-separation`: "What is new here (per the math-novelty discipline, stated without deflation): the strictness witness over full-$\equiv_3$ pairs…", followed by "the operation is theirs, the layer-3 boundary of its semantics-preservation is new here."
- `form-information-bottleneck`: "*Exact, applied external theorem.* … This segment is *not* a novel formulation."

### K. Narrate how it got here

FORMAT forbids this ("segment voice, not diff voice"), and it still happens where a change in standing is itself the information.

- `der-multi-timescale-stability`: "The predecessor sketch's open problem … is *conditionalized, not closed*. … The claim-type has changed from "AAT's adaptive hierarchy is stable" (never derivable as stated) to "a premise-conditional stacking theorem with named scope"."
- `der-tempo-composition`: "The historical sub-additive claim … survives only on the cross-agent noise-independence scope; its former grounding ("composition cannot create corrective capacity out of nothing") was refuted."
- `hyp-directed-separation-under-composition`: "Previously discussion-grade; upgraded after routing formalization in #scope-multi-agent and architectural classification promotion in #der-directed-separation (2026-04-01)."
- `deriv-edge-credence-dynamics` keeps an open-problems list with strikethrough state: "~~*Correlated edges (L1/L2 scope).*~~ **Resolved.** … The unobservable-$C$ single-channel case is *refuted* by the Cramér-Rao floor … not merely "open" but structurally impossible".

### L. Defend or define the label itself

The sections argue with the label they carry.

- `form-objective-functional`: "Naming those axioms is what `axiomatic` status means here."
- `deriv-stochastic-non-exit`: ""Exact" is claimed in the framework's defeasible sense (valid under stated assumptions, subject to a found error), not as a claim beyond a found-mistake."
- `der-loop-interventional-access`: "The gated form is what keeps the *exact* label honest: the availability of the channel is unconditional; the identified $do$-estimate is the conditional consequence."
- `der-identity-continuity-threshold`: "A landing of this content at flat "exact" would itself be an integration-is-replacement failure (sharp-but-mis-tiered replacing soft-but-honestly-tiered)."
- `der-recursive-update` (and, nearly verbatim, `deriv-recursive-update`): "This is not a weakness — it is the nature of the claim."
- `disc-five-forcing-functions`: "**This is honest, not a defect.**"
- `deriv-strategic-composition`: "This is an honest scope limit, not a defect."
- `result-certificate-existence`, `disc-stability-certificate` (identical sentence): "so it is not a weakening relative to the rest of the theory, but it is a genuine scope statement and is not papered over."
- "honest" appears 35 times in 25 sections.

### M. Time-stamp it, or say what would void it

- `obs-authored-world-laboratory`: "V1-V4 describe the system's design and its verified build state as of 2026-07-16: the world is mid-Phase-3 (… **agents not yet embodied**)…", and its Working Notes: "The Epistemic Status's build-state sentence is dated 2026-07-16; re-verify against the vivarium tree before citing this segment's V-claims in any promoted result".
- `disc-five-forcing-functions`: "The *form* of the argument (economic cost ceiling) is robust; the *current numerical bounds* are time-indexed."
- `obs-context-turnover`: "a future architecture without session boundaries would void it without any error in the formalism."

### N. State a standing frame

- `disc-law-discovery-ceiling`: "The standing frame caveat is load-bearing: all claims are internal to finite-SCM semantics, and applying them to a natural environment presupposes the causal-model reading of that environment, which no result here establishes."
- `hyp-behavioral-self-knowledge-insufficiency`: "reading an agent's self-relation as an SCM over its own mechanisms is itself a modeling commitment, load-bearing and not merely ritual."

### O. Separate the normative from the formal

- `scope-eli`: "**The "distinction without a difference" framing is normative project-stance, not derivable result.** … The framework's *formal* content does not depend on accepting the framing; the framework's *moral* commitments do."
- `disc-five-forcing-functions`: "(F5) is an *operational / ethical claim* about the project's current state and obligations. Not derivable from formalism; nevertheless load-bearing for the project's normative commitments."
- `der-severed-actuation-dynamics`: "(6c) normative-structural — the impossibility is exact *given* the constraint that recovery must preserve what it recovers, and that constraint is carried by the philosophical argument (the framework's normative register, backing named)."

### P. Record a disagreement

- `def-eli-cohort`: "The substrate count (four under canon's classification of Architectus's sessions, three under Joseph's reading) is verifiable."
- Outside the sections, `def-action-transition` Working Notes: "A *third* substrate examined the same tag and *withdrew* the candidate on second look … The disagreement itself is the signal: the eq-tag taxonomy for constitutive-scope…"

### Q. Hold substance that has nowhere else to go

Three sections contain sub-headed material: `der-causal-insufficiency-detection` ("### What Cannot Be Detected," with a worked counterexample), `form-sector-condition` (the α/β sub-scopes), and `der-tempo-composition`, whose section runs on through "### Intuition" and "### The closure-defect to coordination-overhead connection," with labeled derivations and displayed equations. `form-objective-functional` and `scope-adaptive-system` are very long single-section arguments. The last case may be a heading-level accident; I did not check its history.

---

## 4. The status word: what rule picks it

Reading the openings against the frontmatter. A script flagged 37 sections whose first tier word differs from the status. By reading, those split as follows, and the split is what is informative.

**12 open on "exact" with status `conditional`.** The word is the *weakest* claim, the opening is the strongest: "*Exact conditional on disturbance model.*" (`result-adversarial-exponent-regimes`, `result-per-dimension-persistence`); "Both coupling-dominant exponents are *exact* conditional on…" (`result-adversarial-tempo-advantage`); also `der-adversarial-destabilization`, `der-orient-cascade`, `deriv-gain-sector`, `deriv-graph-structure`, `internal-external-decomposition`, `example-bandit`, and the three impossibility imports.

**About 17 open on a type word instead of a tier:** "*Hypothesis*" (5, with status `discussion-grade`), "*Formulation.*" (4), "*Derived (conditional).*" (7), "*Normative, not derived.*" (1). The status word reads as an afterthought to the question the author actually wanted to answer.

**A few are real tensions:** `disc-composition-consistency` (status `discussion-grade`, section opens "*Axiomatic* for the meta-requirement", label `*[Commitment (composition-consistency)]*`; Working Notes record a retype from postulate on 2026-05-28); `def-strategic-tempo` (status `conditional`, opens "The definition itself is axiomatic"); `emp-update-gain` (status `robust-qualitative`, opens "*Derived* under the **Fisher-local invariance regime**").

The rest are false positives of my regex or openers like "*Mixed.*" (`disc-credit-assignment-boundary`).

So, by reading, the word is chosen by at least four rules:

**(a) Weakest claim in the file.** `der-resource-bounded-destabilization`: the status is `conditional` "because the load-bearing premises are modeling posits about an agent's physical realization, not consequences of prior segments".

**(b) Strongest claim, with stated carve-outs.** `def-value-object`, `der-multi-timescale-stability`.

**(c) The genre of the file.** `disc-ciy-unified-objective`: "Max attainable for this segment: *discussion-grade* (it is a discussion of the underlying result, per `type: discussion`)." `disc-sandbox-evaluation-ceiling` has status `discussion-grade` while saying "It is *exact* conditional on the sandbox/deployment selection diagram". `der-bounded-objective-as-sanity-criterion` is `type: derived`, `status: discussion-grade`. And a split happened for this reason: `result-certificate-existence` Working Notes: "Split out of #disc-stability-certificate 2026-05-14 (it had been a `*[Derived]*`-tagged block) so the exact equivalence is housed at its true tier (`status: exact`) rather than inside a `discussion-grade` segment." The status word forced a file boundary.

**(d) The ceiling, not the current state.** `disc-compression-operations` opens "*Robust-qualitative.* The claim that the four compression operations share IB shape is *discussion-grade*…" and later "Max attainable: *robust-qualitative* for the shared-shape claim." So the frontmatter word appears to record where the claim could go. That is my reading of one case.

Also, the status word gets used as a project-state word. Ten of the 12 `sketch` segments are in volumes 3–4, and several say things like "The scope condition itself is definitional and exact" (`scope-channel-collapse`) while the file as a whole is unfinished. In those, the word means *this file is not done*, which is close to what the `status-sketch` entry says.

**Off-vocabulary tier expressions inside sections** (regex over the 220, then read): `conditional-derived` (5), `sketch-level` (3), `sketch-grade` (2), `argumentation-grade` (2), `hypothesis-grade` (2), `construction-grade`, `exact-flavored`, `exact-with-standard-remainder`, `exact-via-Conley`, `exact one-direction`, `conditional, partial`, `conditional, scoped`, "derived (AAT-internally forced)", "class-level". Volumes 3–4 give ceilings that are not tiers at all: "definition + conditional theorem" (`scope-channel-collapse`), "definition + composite forcing argument" (`scope-interiority-loop`), "definition (composed)" (`def-five-constitutive-factors`), "observation with derivable diagnostic structure" (`obs-growth-vs-drift`), "scope condition with derived emergence-necessity theorem" (`scope-emergence-conditions`). Those are descriptions of the *shape the finished thing would have*.

---

## 5. What a definition's status is the status of

`terminology/entries/axiomatic.md` says a definition "*constitutes* the thing being defined." The sections agree that the stipulation carries no truth-claim, and then find something else to grade. What they grade is what the definition is being taken as.

- `def-adaptive-tempo`: "This is a *definition*, held at `conditional`. … The stipulation itself carries no truth-claim, but the definition is advertised as an *operationalization* — $\mathcal{T}$ as the effective rate of useful corrective-information acquisition — and that interpretation holds exactly only under two explicitly named local conditions…"
- `def-control-regret`, `def-satisfaction-gap`: "*Exact as a definition — convention-relative as a diagnostic.*"
- `def-mood`: "This segment is a **definition**, not a truth-claim; … The framing is `discussion-grade`: the functional skeleton is well-supported qualitatively, but the specific functional forms of $a_t$ and $g$ are representative, not pinned."
- `def-causal-information-yield`: "The interpretive claim — that CIY measures action-distinguishability rather than expected information gain — is exact (it follows from the definition). The relationship between CIY and learning value (see Discussion) is discussion-grade…"
- `def-strategy-dimension`: "The claim is NOT that all agents maintain both explicitly."
- `def-unity-dimensions`: "The two-axis architecture (content $\times$ structure) is therefore a definitional commitment of this segment, not a heuristic."
- `impl-persistence-and-limits`: "*[Exact for the quantity; the design reading is discussion-grade.]*"

*My inference:* the object that has a standing here is the pair (formal object, the use or reading it is put to). Without the reading half, a `definition` row cannot range from `axiomatic` to `sketch`.

---

## 6. `conditional` and `exact`

**The definitions.** `terminology/entries/conditional.md`: "`exact` claims depend only on premises that are established by the `depends:` chain; `conditional` claims additionally require assumptions stated locally that may or may not hold in any given application." It goes on: "can the local conditions be established from the global dependency chain? If yes, the status should be upgraded to `exact` (with the conditions moved to `depends:`)."

So the line between the two words is drawn by where a premise is written. It is not drawn by how strong the inference is. `der-turnover-information-recursion`, Working Notes, states the procedure exactly: "**Tier note (2026-07-14).** `status:` set to `conditional` (was `exact`): (C1)/(C4) are locally-stated commitments beyond the `depends:` chain … Upgrade path to `exact`: establish (C4) from the depends chain … and move the commitments into `depends:`, per the terminology entry for `conditional`." A dated adjudication of exactly this kind appears at `result-specification-bound`: "2026-07-14 label adjudication: …".

**The line does not appear to be held.** These `exact` segments state their own local hypotheses, and if those are not in the `depends:` chain, by the entry they would read `conditional`:

- `deriv-evidence-allocation-ceiling`: "*Exact* under the named conditions: (i) fixed allocation, independent of outcomes; (ii) estimator class $\mathcal C$…; (iii) …; (iv) …; (v) …"
- `der-multi-timescale-stability`: "*Exact* … under the named premises (S0)–(S5)/(C-N)."
- `deriv-convention-monotonicity`: "*Exact, under named hypotheses on each rung.*"
- `deriv-decomposition-uniqueness`: "*Exact, pathwise, with a partly definitional character.* … exact under the stated hypotheses".

These `conditional` segments have the same shape and take the other word:

- `der-compensation-channel-uniqueness`: "The status is `conditional` rather than `exact` because (FW) is an explicitly named local regime assumption…"
- `deriv-observation-noise-placement`: "*Conditional*, and exact under its stated model".
- `der-identity-continuity-threshold`: "*Conditional — with an exact core.*"
- `result-adversarial-tempo-advantage`: "Max attainable: exact conditional on the disturbance model and coupling model. The result is as strong as its assumptions; no additional work changes the epistemic status without changing the dynamical model."

I have not judged whether any of those local hypotheses are in truth in the `depends:` chain. That would take reading the Formal Expressions. What I can say is that nobody reading the words alone could tell the groups apart, and the two groups' sections read alike.

**What "conditional" conditions on.** By reading, at least these, which are discharged by entirely different kinds of act:

| Kind of premise | What would discharge it | Specimen |
|---|---|---|
| Modeling posit about an agent's physics | Showing it for a class | `form-resource-budget`: "(A-cost) and (A-gate) are claims about a particular agent's physical realization, not about the formalism" |
| Property of a deployment or application | Checking the deployment | `der-compensation-channel-uniqueness`: "(FW) is a statement about a deployment's substrate-update policy, not about the formalism" |
| A class restriction on the model | Nothing; widen the class | `example-L1`: "*Conditional on Beta-Bernoulli model.*" |
| An axiom whose adoption is undecided | A decision | `deriv-fisher-whitened-update-rule`: "**Without (PI) adoption.** If (PI) is not adopted as an AAT axiom, Fisher whitening remains a theorem-imported technique" |
| An unproved mathematical step | A proof | `der-turnover-information-recursion`: "**The sufficiency half is conditional on (C5)**" |
| A reading of the theory onto a domain | An argument that the reading is forced | `deriv-strategy-proofness-impossibility`: "the reading itself is a representational choice" |
| Another segment's stage of review | That segment's review | `deriv-reward-channel-learning-no-go`: "The tier ceiling stays `conditional` while `#der-directed-separation` (a dependency) is `stage: draft`." |
| A hypothesis elsewhere | Empirical test | `der-team-persistence`: "Conditional on the communication-gain hypothesis" |
| Quality of the agent's own model | Repair by the agent | `deriv-graph-structure`: "it is a property of *strategy quality* (did the agent include all relevant common causes as nodes?), not of agent architecture." |
| A convention chosen by the analyst | Nothing; it is a convention | `internal-external-decomposition`: "**conditional on the stated fluid-limit rate-lift** — a modeling convention introduced in this segment" |
| Not yet checked | Checking | `deriv-tempo-additivity`: "Citation details for the imported PID results are flagged for primary-source verification before promotion past `draft`" |

`deriv-graph-structure` draws the distinction itself: "the remaining condition (causal sufficiency) is about model quality, not proof quality."

**What `exact` is allowed to mean.** `deriv-sector-condition` is `exact`, and says: "The assumptions themselves (sector condition on a region, bounded disturbance) are *empirical claims* about the qualitative behavior of real correction dynamics." FORMAT's Claim Record paragraph names the problem: "a reader hears "exact" as "true of agents" when it means only that the derivation is valid."

Claim Records take this on directly. They separate *register* (formal / descriptive / normative) from tier and repeatedly report no instance has been measured. `def-strategy-dag`: "**Instantiated:** no." `def-agent-spectrum` carries a claim that "the body calls the extension a conjecture." In the 7 I read, Claim Records are written in a reviewer's voice about the body: "The body does not say which of these agents satisfy its "nameable conditions", so the population is bounded from outside but not yet from inside." (`def-satisfaction-gap`). That is the first surface I read that treats a claim's reach over real agents as a separate question from whether the math closes.

**`empirical` carries at least four things across only 7 segments:** a simulation of the theory's own equations (`obs-section-i-validation-simulations`: "**Internal validation, not external.**"), a simulation record whose numbers are now derived (`obs-gated-tempo-advantage`: "*Empirical*, as a simulation record; its numbers are now derived."), a fact about deployed systems (`obs-context-turnover`), and a catalog of documented entities (`def-eli-cohort`: "the table itself is a reference catalog rather than a derived theorem").

---

## 7. How status passes along dependencies: three theories in the text

**Theory W (weakest link).**

- `hyp-conceptual-alignment`: "Its epistemic status inherits from both the investment threshold (conditional) and the alignment hypothesis (discussion-grade); the weaker link governs."
- `der-principled-decision-integration`: "The expanded form inherits the weakest epistemic status of its inputs".
- `impl-persistence-and-limits`: "each implication inherits the tier of the weakest result it composes".
- `deriv-self-actuation-grounding`: "The result cannot be stronger than its substrate; the tier ceiling stays `conditional` while #der-directed-separation is draft-stage."
- `der-captured-objective-dynamics` repeats this for a "transitive dependency through both no-gos."

**Theory P (the implication is exact; premises are the reader's problem).**

- `result-sector-persistence-template`: "it does not touch the template's exactness, which is the conditional "(T1)–(T3) $\Rightarrow$ persistence" — anything satisfying (T2) by either route inherits the exact result."
- `der-identity-continuity-threshold`: "already at ceiling — the conditional "(C-S)+(M-ADD)+(M-FREE) $\Rightarrow$ the dichotomy" is as strong as Lindley/Loynes/Birkhoff plus the named posits".

**Theory U (it depends on which part you use).**

- `def-causal-information-yield`, Working Notes: "Frontmatter `status: exact` is right for the *definition*, but the CIY-as-exploration-objective *use* is heuristic (the $\lambda$-weighting is not derived). Watch that downstream segments inherit the *heuristic* tier on that use, not the definition's `exact`".
- `der-identity-continuity-threshold`: "the normalized results sit exactly at the tier of the static floor they specialize, not better and not worse".
- `disc-separability-pattern`: entries each "at the tier specified in" their home.

**What the graph does.** 30 of 1,142 `depends:` edges run from an `exact` segment to one that is `conditional`, `robust-qualitative` or `heuristic`, and 16 of the 26 `exact` segments have at least one. Examples: `result-persistence-condition` → `def-adaptive-tempo` (conditional); `deriv-sector-condition` → `form-sector-condition` (conditional); `deriv-decomposition-uniqueness` → `der-directed-separation` (conditional, draft); `def-value-object` → `der-directed-separation`. Compare the last two against `deriv-self-actuation-grounding`, which on that same dependency caps itself. So the same dependency caps one segment and not another. Many of these edges may be vocabulary imports. FORMAT holds that "no typed edges" are needed because the kind of dependency is "derivable from the referenced file's own `type` field". That is the issue: the edge doesn't say which part is used.

*My inference, offered with care.* The corpus has a theorem about exactly this situation. `deriv-graph-structure`: "propagation is exact for all credences if and only if the DAG is an AND/OR tree", with reconvergence giving a bound whose direction depends on node types. That result is about credences under noisy-AND/OR, and tiers are not credences. But `depends:` is a heavily reconvergent DAG, and "the weaker link governs" is an AND-chain rule. If a status model propagates along it, the corpus's own result suggests asking what reconvergence does.

---

## 8. Ceilings

FORMAT's template is "*Max attainable: [status]. Currently [status] because [reason].*" The 106 uses went well past it. By reading, a ceiling is one of:

- **Per-claim vector.** `der-agent-opacity`: "Max attainable: *exact* for the Hafez-reduction under IDT + ergodicity; *derived* for the sign-flip via signed-coupling; *formulation choice* for the emitter-regime classification structure; *conditional* for the tempo-amplification formula; *discussion-grade* for the meta-pattern candidate status."
- **Intrinsic.** `form-resource-budget`: "This ceiling is intrinsic". `der-gain-sector-bridge`: "the condition (B1 or strong convexity) is inherent, not removable. Pathological update rules exist". `detail-linear-ode-approximation`: "exact (the linear case is its own exact analysis; there is nothing to tighten)."
- **Empirical by the nature of the claim.** `hyp-causal-discovery-from-git`: "The theory does not entail this correspondence — the domain does."
- **Set by genre.** Several `disc-*`, e.g. `disc-identifiability-floor`: "*discussion-grade* for the methodology (it is a presentational organizing principle, not a derivation)."
- **Work-gated.** `hyp-solicitable-escape`: "**Max attainable: conditional.** Two steps remain, both now specific." `def-strategic-tempo`: "Max attainable: conditional. Currently conditional because the general DAG case … has not been verified." (Here the reason given is unfinished work, which makes "max" read as "next.")
- **Decision-gated.** `deriv-social-welfare-aggregation-impossibility`: "that extension is open and would be its own framework-scope decision." `der-resource-bounded-destabilization`, Working Notes: "Promotion past `draft` is gated on Joseph electing to develop the resource axis".
- **Capped by a dependency's review state.** `deriv-reward-channel-learning-no-go` and two others.
- **Speculative-upward.** `disc-separability-pattern`: "if a uniqueness argument were derived … — but this is not currently in hand, nor clearly attainable."
- **Attained.** `deriv-reward-channel-learning-no-go`: "*Exact* for the floor (Lemma 1) is already attained." `der-turnover-information-recursion`: "already at ceiling".

`der-multi-timescale-stability` adds a distinction nothing else in the vocabulary holds: "Extensions that would widen scope rather than strengthen the claim."

---

## 9. The inline labels

804 in 212 segments (605 / 92 / 47 / 60). 628 stand alone on a line. Starting words: `Derived` 342 (337 bare first word plus "Derived from" and the like), `Definition` 136, `Discussion` 108, `Formulation` 47, `Hypothesis` 36, `Scope` 19 plus variants, `Empirical Claim` 14, `Assumption` 11, `Result` 10, `Observation` 9, `Postulate` 8.

FORMAT's table calls this the "Epistemic strength label". What it mostly is, is a *move-type plus a name*: of the 342 `Derived` labels, 121 name a source with "from", 69 name a condition, 34 carry a tier word, and 16 are "(Proof Step)". Across all labels, 59 carry a tier word and 80 a condition. (Regex; mentions.)

Species, by reading:

| Species | Specimens |
|---|---|
| Move + anchor name | `*[Definition (mismatch-signal)]*` |
| Move + provenance | `*[Derived (change-investment, from dual-optimization)]*` |
| Move + condition | `*[Derived (Conditional on Beta-Bernoulli model, $\varepsilon$-greedy OR-node)]*` (`deriv-edge-credence-dynamics`) |
| Tier appended after the name | `*[Derived (architecture-noidentifiability-general, from causal hierarchy theorem applied at agent-as-SCM layer), robust qualitative]*`; `*[Derived, status: exact.]*`; `*[Derived; classical.]*` (`deriv-sector-condition`) |
| Import marker | `*[Postulate (arrow-1951-1963, imported), exact]*` — `Postulate` meaning "accepted from outside"; `*[Derived (no-canonical-channel-local-decomposition — imported)]*` |
| Disclaimer in a formal section | `*[Discussion]*` inside `## Formal Expression`: "this block is not the formal claim" |
| Verdict sentence, trailing the claim | In `impl-*`: `*[Exact; the reading of the three misquotations is this segment's own framing.]*`; `*[Min-operation: conditional in the diagonal case; the matrix information floor: conjecture.]*` |
| Discussion verdict with a test plan | `der-change-investment`: `*[Discussion — the compound effect is structurally motivated but not formally derived. Empirical validation could track a "code quality" proxy…]*`; `hyp-conceptual-alignment`: `*[Discussion — operationalizable but unmeasured.]*` |
| Mixed register | `*[Operational / ethical]*`, `*[Empirical, economic]*`, `*[Discussion / Operational from PROPRIUM]*` (volumes 3–4) |
| Self-limiting | `*[Formulation (Model S extension — conditional, not yet derived)]*`, `*[Definition (projection-admissibility, proposed from spike)]*`, `*[Proved (no-universal-C-euclidean, counterexample-grade)]*` |
| Pointer | `*[Result (cited: #result-certificate-existence)]*`, `*[Derived (at #deriv-mechanism-counterfactual-separation); agentic restatement]*`, `*[Discussion — inferential status; separation derived at #deriv-mechanism-counterfactual-separation]*` |
| Reading, marked as recommendation | `*[Discussion — readings of the exact result into other fields' practice; each is a recommendation, not a derived result in that field's own formalism]*` (`disc-law-discovery-ceiling`) |
| Commitment | `*[Commitment (composition-consistency)]*` |

Labels are also objects of argument. `def-action-transition`, Working Notes: "Two substrates read the `*[Definition (transition opacity)]*` tag as mistyped: "the agent does not know $T$ exactly" *restricts epistemic access* rather than introducing an object, so it reads as a *postulate*- or *scope*-flavored claim." FORMAT itself says the syntax "compresses the first four attributes positionally" and that the full syntax "is not designed yet".

---

## 10. Where else status lives

These surfaces also carry it, and a schema built from only the three named surfaces would miss them. I saw these and did not exhaust them.

- **`## Claim Record`** (24 segments): register, population, true of, false of, falsifier, instantiated.
- **Derived-vs-Chosen tables**, whose Strength column is an open vocabulary richer than either the status or the label: "Inherited exact," "Verified relationship," "Introduced posits, not derived," "Open (not attempted)," "Rejected as fundamental (tautological)," "Not a cost metric," "Recorded failures," "Derived as refutation," "Proved by external theorem," "Load-bearing scope condition," "Verification (algebraic consistency)," "Classification (not derivation)," "Discussion-grade (clarifying observation)."
- **`## Findings`**: novelty posture and a dated Search Log with its own status vocabulary (`cursory`, `targeted`, `nominally-comprehensive`, `intuition-only`). Known to me from FORMAT; not read.
- **Citation footnotes**: `[^recall-2026-10-30]` (section 3G).
- **Working Notes**: "Tier note," "Promotion path," "Resolved (verified 2026-08-12)," regression guards. `obs-context-turnover`: "Tier note (regression-guard): `status: empirical`, not `exact` … Do not re-promote to `exact` on "structural fact" grounds".
- **Attribution inside notes**: "(Claude, AUDIT-WORKING-471203)," "(Codex/Claude, AUDIT-WORKING-526815)". Findings carry who said them and sometimes that readers disagreed.
- **A segment as the status of another segment's sentence**: `sketch-structural-adaptation-genericity` exists to record that a hand-off "currently asserted in `#deriv-sector-condition` / `#deriv-stochastic-non-exit` Discussion/Findings is **plausibly a mild overclaim**". Its Working Note: "Joseph adjudicated it up to a first-class `exploratory` OUTLINE node ("it will get its day in the light") rather than a soft ledger row." It makes "**no** claim that the bridge holds or fails". A file whose whole content is a question about someone else's sentence is, in the terms of your project, an open item with a body.
- **Prose placement**: `the-reality-model-intro` Working Notes: "(framing is allowed confidence)". Register varies by location, and this says so.
- **`empirica:`** references in 10 files, 2 named targets.

The Working Notes also show scale I did not expect: `Incidental audit gold` subsections in about 119 segments, with sub-sections "Candidate Brief prose," "Candidate Discussion," "Follow-up items," "Readers often ask," "Belongs elsewhere," and "Off-ramp (NOT gold — flagged for the certified track)". That last heading separates what one reader noticed from what needs certification.

---

## 11. Dialects

The sections fall into recognizable writing styles that track authoring batches. I checked first-commit dates for only 14 files, so this is a sample, and a first-commit date doesn't tell you when the section text was last revised.

- **"Definitional."** One-word or one-sentence openers in TST: `def-feature`, `def-system-coupling` (first committed 2026-03-11). Twelve sections are under 300 chars, eight of them TST definitions.
- **"This is *definitional*."** AAT Part I definitions (`def-action-transition`, 2026-03-11).
- **"*Conditional.* Max attainable: … **Load-bearing:** … **Not established:**"** `der-agent-opacity`, `deriv-l1-update-bias` (2026-04-22), `deriv-matrix-persistence-condition` (2026-05-12).
- **"**Sketch.** … **Max attainable status:** … **What this scope is for.** … **What would strengthen this:** … **What would soften this:**"** Volumes 3–4: `scope-eli`, `scope-channel-collapse`, `disc-five-forcing-functions`, `def-identity-sufficiency` (all first committed 2026-05-01).
- **Long verification-narrative paragraphs**, later: `der-mood-timescale` (2026-06-17), `deriv-mechanism-counterfactual-separation` (2026-07-16).

*My inference:* a dialect is partly the template that was in the air. A section's richness doesn't by itself tell you about the segment's epistemic state, and "What would soften this" being absent from a volume 1 segment doesn't mean nobody thought about it.

The volume-1 `exact` core contrasts with volumes 3–4, which are mostly `conditional`, `discussion-grade` and `sketch` (status counts by volume, in FORMAT's order of 8: vol 1 [15, 25, 18, 1, 65, 2, 45, 2], vol 2 [12, 1, 0, 0, 6, 2, 8, 0], vol 3 [0, 0, 2, 0, 6, 1, 10, 4], vol 4 [0, 0, 3, 0, 5, 2, 6, 6]). Volume 2 has no `robust-qualitative`, and 8 of its 12 `axiomatic` segments open with the single word "Definitional."

---

## 12. Things I tripped over, for someone to look at

These are observations from the text. I did not adjudicate them.

1. **Obligations hung on an abandoned gate.** `deriv-bilateral-trade-impossibility`, `deriv-social-welfare-aggregation-impossibility`, `deriv-strategy-proofness-impossibility`: "primary-source verification scheduled for promotion past `draft`." `deriv-tempo-additivity`: "flagged for primary-source verification before promotion past `draft`." `disc-structural-imagination`: "flagged for a relata pass before this segment advances past `draft`." Meanwhile FORMAT: "the stage layer is known to go stale quickly … and is currently ignored in practice". 205 of 247 are `draft`. If nothing fires at that gate, these promises have no trigger.
2. **The `stage: draft` of a dependency used as a tier cap**, in 3 segments, though FORMAT says stage is "Orthogonal to epistemic status" and "do not read low stage values as low epistemic strength".
3. **Four segments with no Epistemic Status and no exemption.** FORMAT exempts "Chapter-intro segments and most `disc-*`". The 27 no-ES segments include `impl-*` (not named in the exemption, but plainly that kind) and four others: `norm-interiority-default` (type normative, says "this assumption must be inverted"), `obs-developmental-trajectory` ("mathematically required to trust its observations heavily"), `scope-moral-continuity`, `obs-evaluation-metrics`. All four are `discussion-grade` by frontmatter alone. In the two I'd single out (`norm-interiority-default`, `obs-developmental-trajectory`) nothing in the body marks which sentences are argued and which are stance, which is the case the volume 4 sibling `scope-eli` went out of its way to separate.
4. **`disc-ciy-unified-objective`.** The Formal Expression displays the scalar form under `*[Discussion (unified-policy-objective — heuristic)]*`; the Epistemic Status says "The scalar heuristic $Q_O(a) + \lambda \cdot \text{CIY}(a)$ is formally superseded by the exact tensor trace-product" and displays that one. Not a contradiction of the label, but the section that is headed Formal Expression holds the form its own status section retires.
5. **`form-objective-functional`** is `type: formulation`, `status: axiomatic`, "*Axiomatic, with a substantive commitment.*" A Working Note in a different segment (`scope-agent-identity`) records a reader flagging this as "overstating inevitability". The status was redefined in place ("what `axiomatic` status means here") and the objection lives elsewhere.
6. **`der-recursive-update`** Working Notes: "**Resolved (verified 2026-08-12).** Frontmatter now reads `status: exact` and the Epistemic Status paragraph reads … The two layers agree; the drift the six substrates flagged is closed." So frontmatter/body drift has been a found-and-fixed defect class. I looked for others only in the section openings (section 4).
7. **`disc-exploit-explore-deliberate`.** "The simulation is UNFAVORABLE to deliberation (no strategy structure, no irreversible actions, small action space), so these results are a lower bound on deliberation's value in complex domains." The inference from an unfavorable test bed to "lower bound" is asserted. `def-control-regret`'s Claim Record separately notes that this simulation "went against the deliberation axis." That is one result read with different emphasis in two places.
8. **`deriv-mechanism-counterfactual-separation`** (5K chars, fourth longest) stores its novelty defense in the Epistemic Status, where FORMAT would route some of it to Findings/Related Work. The longest is `form-objective-functional` (8K).
9. **The `heuristic` asymmetry.** One frontmatter use, while "*heuristic*" is a common in-section verdict (`def-causal-information-yield`, `deriv-causal-ib-exploration`, `der-causal-insufficiency-detection`, `disc-composition-consistency`). It is an in-file tier and almost never a file tier.

---

## 13. Is "what were they asking?" the right question?

Partly. There is literal asking: gating sub-spikes, "what would strengthen this," "flagged for," "Promotion path," "Open before `candidate`." That is roughly the F and G material.

But what I would have asked after reading all 220 is: **what were they afraid of, and who were they writing to?** The sections read to me as addressed to someone who will arrive later and do a specific thing with this claim. I can name the addressees from the text:

| Addressee | Moment | Specimen |
|---|---|---|
| A citer | Writing a citation | `disc-identifiability-floor`: "should cite the instance's own derivation, not the methodology" |
| A downstream author | Using a result | `deriv-tempo-additivity`: "downstream uses of "additive tempo is conservative" are unsafe unless the common-source (or general nonpositive-$\Delta$) structure is verified for the application" |
| The promoter | Changing a status | `obs-context-turnover`: "Do not re-promote to `exact` on "structural fact" grounds" |
| The integrator | Landing a result | `der-identity-continuity-threshold`: "A landing of this content at flat "exact" would itself be…" |
| The skeptical reviewer | Reading for overclaim | `der-resource-bounded-destabilization`: "would be an overclaim" |
| The next attempter | Starting work | `deriv-observation-ambiguity-bias-bound`: "The failed attempts §5 are *recorded* at structural-reason level." |
| An applier | Checking a premise in a deployment | `der-compensation-channel-uniqueness`: "A specific deployment that guarantees frozen weights satisfies (FW) by construction and reads the Proposition at its exact strength." |
| The steward | Deciding | `der-resource-bounded-destabilization`: "gated on Joseph electing" |

The fear underneath is consistent: **that a word will travel without its conditions**. That is the shape of act H, of the label-defending in L, of `result-persistence-condition`'s "Downstream segments that use the linear operational forms should be understood as expressing task adequacy, not structural stability," and of `impl-persistence-and-limits`' "the single most common way the chapter gets misquoted."

Under that reading, the Epistemic Status section is mostly a set of *use-conditions* attached to a piece of mathematics, written by someone who couldn't attach them anywhere else. *My inference.*

---

## 14. What this suggests a record has to be able to say

You didn't ask for a design, and my sample is a mathematical corpus. I offer this short list because it is the natural residue of the reading. Each item is something I saw an author need and saw the eight words fail to hold.

1. Which claim, at a grain finer than the file, and *under which reading* of the object.
2. The warrant, as a kind (section 3C), separately from any grade.
3. Each premise, typed by what would discharge it (section 6 table): a proof, a check, a decision, a deployment fact, a convention.
4. Where a premise lives, if the `exact`/`conditional` line is to remain about that.
5. A ceiling with its reason, and whether the reason is intrinsic, work, decision, or genre.
6. Acts done to the claim, with actor, date, posture, and against which text. Including "not read at the primary."
7. Stated non-claims and anticipated misreadings, addressed to a use.
8. Which part of this a dependent is using.
9. Provenance and novelty posture.
10. When it expires, and what event would void it without any error.
11. Disagreement that stays open, including with the steward.
12. A question about someone else's sentence as a first-class thing (`sketch-structural-adaptation-genericity`).

I would be cautious about flattening the dialects before reading what each was doing. And I'd be cautious about treating a section's length as a measure of how far a claim has been examined. Some of the shortest are complete (`der-chain-confidence-decay`), and some of the longest are arguing.

---

## 15. What reached me despite the blind, and feedback on the brief

**Contamination, stated plainly.**

- The harness's git snapshot for this working directory showed filenames in `~/src/verisectorium/`, including `core/def/claimed-level.md`, `bound.md`, `frontier.md`, `ground.md`, `accepted-remainder.md`, `truth-determinant.md`, `veritoid-kind.md`, and `msc/notes/18-2026-11-08-dimension-census.md`. Names only. My use of "ceiling" comes from the corpus, but I can't rule out that those names tilted what I noticed.
- The always-loaded `~/.claude/CLAUDE.md` describes the "this is not a weakening" reassurance as a tell, and says `exact` already means defeasible-if-someone-finds-a-mistake. So I went in sensitized to those phrases. I counted them instead of relying on the impression: "not a weakening/weakness/defect" is 6 sections, which is fewer than I would have guessed.
- It also describes vsect's model (checks bound to versions, lapsing, claims, an open ledger). Act G and item 6 of section 14 may be colored by knowing that.
- FORMAT.md was read first and supplied my vocabulary for the question, as you'd expect.
- `Working Notes` in the segments quote audit findings. Those are inside the material you asked me to read, but they are earlier readings of a sort. Section 12 item 5 and some of section 10 lean on them.
- I did not open `~/src/aat-v3/`, asf's `msc/`, `audits/`, `spikes/`, `reviews/`, or use memorata-search. I listed `doc/` and `doc/sop/` and read none of the SOPs.

**Post-blind.** I have not looked at the earlier readings, so there is no post-blind section. Comparing is your separate step, and you can do it better from the two files than I could from inside one of them.

**On the brief.** It worked well for me. Two things. It said authors improvised "especially in the frontmatter `status:` word"; that is false at the level of vocabulary, as far as today's files show, and a reader told to look for improvisation in that word would have had to report that it wasn't there. And "whether sorting is even the right shape" was the sentence that changed what I did: I had started extracting tier tables, and that line made me stop and ask what the sections were *doing*.

**What I would do with more room.** Read the 17 remaining Claim Records (they are the newest and most differentiated surface); read all of `Follow-up items` (400K) for label disputes; and check the section 6 list against Formal Expressions, to find out whether `exact` with local hypotheses is a mislabeling or whether those premises are in fact the `depends:` chain's.
