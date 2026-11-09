# Census of the August 2026 surveys: what was being adjudicated

*Written 2026-11-08 by a Claude (Opus 5.5) subagent, for the model work in `core/`. First reader: the agent folding this into a wider census. Second: Joseph, reading cold and going after specimens. This is one reader's organization of an archive that is itself almost wholly `proposed`. Quotations are verbatim and located as `file:line` at this date. Where I am speaking for myself rather than for the archive, I say so.*

## 0. How to read this

**Path keys.**

- `TH/` = `.archive/prior-incarnation/theory/`
- `I/` = `TH/influx/`
- `SR/` = `I/segment-research/`
- `XO/` = `SR/external-ontologies/`
- `M14/` = `I/model-2026-08-14/`
- `RC/` = `I/segments-model-rc1/`
- `VS/` = `~/src/aat-v3/.archive/msc/vsect/`
- `method-evidence-tiers.md` alone = `I/instrumenta/bridges/method-evidence-tiers.md`
- `…verbatim.md` alone = `M14/steward-failure-modes-2026-08-14.verbatim.md`

**Registers, carried from the archive.** Nothing in it is ratified. Within that:

- **[steward]** is Joseph's own words or attested corrections.
- **[coord]** is a coordinating agent's synthesis.
- **[QUARANTINED]** marks the four 2026-08-14 files bannered as premature synthesis: `SR/foundation-axis-…`, `SR/distilled-model-…`, `SR/asf-implications-…`, `SR/securing-contract-…`. Their banner: "Treat as one agent's dated testimony — usable as input, never as synthesis-of-record." The later adversarial read (`M14/03-ADVERSARIAL-READ.md`) adopted four amendments from them anyway and judged asf-implications' observational half to stand on its own reads.
- **[REGISTER-RULING]** marks anything from the udon-needs gather. Joseph ruled: "Same-author agreement is coherence — evidence about design intent, real and load-bearing — never corroboration" and "do not inherit udon-needs' assigned epistemic values" (`I/instrumenta/REGISTER-RULING.md:9,11`).
- External precedents carry the grade their sweep gave them, because the sweeps were explicit about it: *primary*, *secondary*, *recalled*.

**A slip of mine, stated first.** Your brief asked me not to read `msc/notes/18-*` until this file existed. While checking the "dropped since" question I ran a grep whose exclude flag failed (zsh did not split my variable), and it printed about a dozen lines of file 18, each cut at 210 characters: table rows labelled A10, A11, D3, E3, F5, G7, H4, and short fragments including the phrase "Fidelity is three things." My question list in §3 was already drafted before that output and I have not changed its shape, but you should know the exposure happened. I used nothing from those lines. If you want a clean check, the place to look is whether my Q6/Q17/Q24 boundaries look bent toward them. I also excluded `msc/notes/00-INDEX.md` from my searches because it might summarize file 18.

**Privacy and names.** Per the brief, the Nov-2025 design work in another estate project (ennaos VERA) and the estate's ELI material are described and located here, not quoted. I also left out the name of the family member who built live_docs and the name of a client that appears in the same file; both are at `I/verisect-and-ldocs.md`. See §10 for a related adjacent finding.

## 1. What I read

From the tool log, not from how oriented I feel.

**Read whole.**

- Front matter: `README.md`, `CHANGELOG.md`, `PRACTICA.ud`, `TH/OUTLINE.md`, `I/00-INDEX.md`, and `CLAUDE.md` + `TH/sop/ORIENT.md` (delivered to me on entry).
- `I/verisect-and-ldocs.md`, `I/segment-research-notes-2026-08-09.md`, `I/terminology-survey.md`, `I/TERM.term.ud`.
- `SR/`: every markdown file, including the four dives and the four quarantined files; and the sketch `SR/sketch-2026-03-epistemic-foundation-scale.jpeg`, viewed.
- `XO/`: all twelve files (index, REASSEMBLED-MODEL, ten sweeps).
- `M14/`: `00`, `01`, `02`, `03`, `04`, `06`, `steward-failure-modes-…verbatim.md`, `net/NOTES.md`, `net/steward-truthification-sketch-…verbatim.md`.
- `RC/`: `00`, `01`, `02`, `03`, `04`, `06`, `07`, `08`, `09`, `10`, `11`, `90`, `95`, `SPECIMEN`.
- `I/rc1-denovo-read-…`, `I/rc1-grok-read-…`, `I/rc1-coord-wanderings-…`, `I/rc1-working-praxes.md`, `I/outline-review-…`.
- `I/.archive/`: all three (`NOTE-TO-SUCCESSOR`, `05-CONCLUDING`, `reflections-coord`).
- `I/synthesis/`: all four. `I/instances/`: all three.
- `I/instrumenta/`: `00-MAP.md`, `REGISTER-RULING.md`, `bridges/method-evidence-tiers.md`, `bridges/counter-register.md`.
- `I/steward-brainstorms/discussion-thoughts-crossmap-…`; `I/.integrated/feedback-from-misfire.md`.
- `TH/sop/influx/`: `survey-census-and-law-filter`, `glance-vs-extract`, `tracking-register`, `deploy-3-founding-feedback`, `drafting-method-feedback`.
- `TH/src/` (12 of 35): `claim-truth-over-proxy`, `claim-strengthen-first`, `claim-absence-vs-conflict`, `form-state-flags-not-gates`, `form-slug-form-kinds`, `form-influx-membrane`, `form-standing-verification`, `form-decision-records`, `def-verisectorium`, `def-integration-replacement`, `disc-ladder-reconciliation`, `obs-truth-failure-manifestations`.
- `VS/`: all seven files.

**Read in part.** `RC/lang/rc1-in-udon.ud` (lines 1–120 and 250–342). `I/steward-brainstorms/realization-model-v1.md` (lines 1–60). `TH/src/claim-clocked-drains.md` (lines 1–25). `core/model.outline.md` whole, but `core/def/*` only the header of each file, with a little more of `ground.md` and `veritoid-kind.md`.

**Skipped, and why it might matter.**

- `I/vera/ennaos-*.md` (spec 1,257 lines, chat 711): read only through `SR/vera-read-notes-2026-08-10.md`.
- `I/tribunal/` apart from `synthesis-scatter-…`.
- `I/evidence/truth-over-proxy/` apart from the manifest (about 2,700 lines of verbatim extracts; the richest specimen vein I did not open).
- `I/asf-sops/` (reached only through the coordinator's reading notes and the dives).
- 18 of 20 `I/instrumenta/bridges/`; `agentic-ux-principles`.
- The other 22 `TH/src/` segments; `template/`.
- `M14/net/*` code and renders; `RC/lang/` other than the file above.
- `.archive/theory-misfire/`, which carries a standing avoidance advisory and was not in scope.
- `~/src/aat-v3/.archive/msc/vsect-audits/` and the two `~/src/aat-refactored/scratch/vsect-*` sketches, which exist and feed `VS/` but which I did not open.

## 2. The carves, in order

The period did not have one list of questions. It had a sequence of carves, each partly undoing the last. Dates are from the files.

| Date | Surface | The carve | Register |
|---|---|---|---|
| 2026-07-22 | `I/instrumenta/bridges/method-evidence-tiers.md` | Trio system: support-kind × strength × register, convergent lock, transmission lock, event log | REGISTER-RULING |
| 08-06 | `TH/OUTLINE.md:66` | Type ⊥ status ⊥ process-state, with the trio as candidate; epistemology "deliberately open" (`:238`) | proposed |
| 08-10 | `SR/epistemic-map.md` | Five registers keyed off form-kind | coord + steward |
| 08-10 | `SR/synthesis-v0-2026-08-10.md` | 11 families, 18 axes, titled "NOT a taxonomy" | coord, dive-based |
| 08-10 | `SR/TAXONOMY-FILL-v1.md` | 11 kind families, 18 axis rows, want-mode | coord, proposed |
| 08-10 | `XO/REASSEMBLED-MODEL.md` | 8 cross-field laws, 5 state-tracks plus edges | coord, per-element grades |
| 08-14 | `SR/distilled-model-…`, `SR/securing-contract-…` | Three questions; the record as promise | QUARANTINED |
| 08-14 | `M14/01-MODEL.md` | 8 "adjudication currencies", 9 derivation questions | coord, proposed |
| 08-14 | `M14/06-COUPLING-LOCK-AND-RECORDING.md` | Commitment law, coupling map with forbidden edges | coord, proposed |
| 08-14 | `RC/01`–`RC/08` | 8 namespaces of epistemic dimension; every catalogued axis routed dimension / bound / machinery / gate | coord + steward, proposed |
| 08-30 | `RC/11`, `RC/95`, `RC/10` working notes | Identity as maintained binding; projection as generator; the episode gap; the Q1 strain | proposed |
| 10-28 | `VS/model.md`, `VS/core.md` | Statement as atom ("one fate"), six evidence lines, computed standing, 14 typed edges | proposed, three audits |

The charge that ran through all of it [steward]: "The ultimate objective is for any agent creating a verisectorium to look at the kinds of things they need to create and see clearly what they need to track and where and how it enters and upgrades and gets refined for their verisectorium's needs, and what it can then certify etc." (`M14/00-README.md:11`).

And the survey's standing caveat [steward]: "I have *zero* confidence that the survey will hand us the taxonomy. Every single instance, no matter how rigorous and authoritative it sounds or how closely it is adhered to, is nothing more than an evolved/evolving guess with inertia and momentum." (`SR/synthesis-v0-2026-08-10.md:5`).

## 3. The questions

Grouped by me, for finding things. The grouping is not the archive's. Each entry gives what the period called it, how it told it from its neighbours, where it saw it, and what happened to it. Where a question was found only implicitly in practice, I say so.

### A. About what a claim asserts

**Q1. How strongly is it held?**

- *Named:* asf `status` with eight values and the explicit ban "Do NOT use 'Solid,' 'Confident,' or 'Plausible' as tier labels" (`SR/dive-asf-lineage.md:28`); trio `strength`, seven rungs (`method-evidence-tiers.md:59-67`); neurips rung tags (Q3); terminology `canon`/`weak`. The zoo: "exact, FALSE, conditional, axiomatic, hypothesis, sketch, draft, pending, partial, gathered, full, established, design…" (`SR/glimpse-2026-08-10.md:11`).
- *Told apart:* from kind and from process. udon FORMAT: "`verified` in particular is a stage, not a strength — the two were once one column elsewhere" and "`status: exact, stage: draft` is coherent and common" (`SR/dive-udon-trees.md:94-95`). asf's own field proved fused: "`status:` is two axes plus leakage — and 'empirical' is the smoking gun … **'empirical' appears on both axes**, meaning kind in one file and grounding in another" (`SR/asf-implications-2026-08-14.md:21`, QUARANTINED, observational half).
- *In principle:* whether strength is ordered at all. Trio: "The ladder is not a ranking to climb" (`method-evidence-tiers.md:69`). FILL: "choosing the ordering *is* the epistemology decision PRACTICA holds as deliberately open" (`SR/TAXONOMY-FILL-v1.md:119`).
- *Outside:* GRADE, four levels, bound per outcome not per study (primary-verified after the annotation pass, `XO/REASSEMBLED-MODEL.md:108`). Walley's same-estimate-different-backing argument against one scalar (`XO/sweep-formal-epistemology-argumentation.md:131`, verified at SEP).
- *Fate:* never decided. RC1 excludes it: "The Evidence MECE decision — deliberately open, steward-paced" (`RC/00-OUTLINE.md:46`). A maturity-ramp reading (channels → ledger → width → calibration) was offered and held (`M14/02-GROUNDING.md:33`).

**Q2. What kind of support does it stand on?**

- *Named:* trio six kinds "each defined by its **repair**": design, observational, testimonial, theoretic, measured, synthetic (`method-evidence-tiers.md:40-49`); RC1 as separate dimensions `evidence/derivation`, `in-vivo`, `wild-empirical`, `instance`, `testimony`, `carriage` (`RC/04-CYCLE.md:33-38`); `VS/model.md:39-46` as lines.
- *Told apart:* by what would repair it, not by surface. "Kind is routed by repair, not by surface — a numeral does not force `measured`" (`method-evidence-tiers.md:51`).
- *In principle:* support-kinds are unranked. "GUM explicitly refuses: Type A is not better than Type B, only differently produced" (`XO/REASSEMBLED-MODEL.md:49`; convergent secondaries). Below the trio's floor sits Joseph's March 2026 sketch (Q13).
- *Register:* a real reinvention datum: support-as-bag appeared in neurips adjudicated "uncoordinated" (`SR/dive-papers-and-roots.md:33`). Same-estate.

**Q3. How does support compose, and what does a summary mean?**

- *Seen:* neurips `adjudicated/OUTLINE.md`: "`[PROVED]`, `[TESTED]`, `[PROVED]+[TESTED]`, `[PROVED]+[TESTED] 3×`, `[TESTED]+[JUDGMENT]`, `[PROVED]/[TESTED]`, and in a claim body: **'Rung: [TESTED, rigorous in the negative direction] (3× verified)'**", naming "Composability", "Multiplicity", "Directionality" (`SR/dive-papers-and-roots.md:31-35`).
- *Steward:* "the truth level itself is something like the max(orthogonal evidence lines)…." (`M14/steward-failure-modes-2026-08-14.verbatim.md:48`) and "max(lines) vs gcd(all-lines) or something might be two very worthwhile but distinct patterns/metrics to know about in aggregate" (`:58`).
- *Told apart:* three declared projections, strongest-line, every-line-sustains, shown-independent-agreement (`RC/02-RECORD-OBJECT-MODEL.md:58`), with formal ancestry claimed in Dung's preferred and grounded semantics (`M14/net/NOTES.md:56`). "A claim's status is limited by its weakest *necessary* premise" (`method-evidence-tiers.md:148`).
- *Open:* no rule was ever stated for how a record's headline composes from its parts (Q7).

**Q4. Do agreeing supports actually share a source?**

- *Named:* convergent lock → coherence default. The lock's discipline: "`convergent` is **not a rung on the strength ladder** … within-kind corroboration … does **not** arm the lock" (`method-evidence-tiers.md:91-93`). Live specimen: an `observational` leg that was "mostly one influential design copied" (`:97`).
- *The steward collapse* [steward, as recorded]: "assume things around here are coherence rather than convergence" (`CHANGELOG.md:21`). RC1: "agreement between lines adds weight exactly to the degree they can be shown not to share descent — and the default assumption is that they do share it" (`RC/01-SPINE.md:60`).
- *Told apart from corroboration:* "same-author agreement across projects is *coherence*"; and "convergence does measure something real — **reachability** … it still is not truth" (`TH/src/claim-truth-over-proxy.md:30`).
- *Held open* [steward]: mid-audit instruction "mark convergence as corroboration", unresolved against §0 (`claim-truth-over-proxy.md:83`).

**Q5. Was what counts as passing fixed before the outcome was seen?**

- *Named:* commitment law; field `criterion-commitment (pre-committed | post-hoc)`.
- *Told apart:* "Contact between lines is legitimate — usually obligatory — through **question and design channels**; contamination is contact through the **verdict channel**" (`M14/06-COUPLING-LOCK-AND-RECORDING.md:13`). Tells at `:19-22`: pre-committed criterion; "a nailed divergence leaves a root-cause finding; a tuned-away divergence leaves only the agreement"; agreement by mutual adjustment "measures the reconciliation process, not the world"; descent tracing.
- *Specimens:* vivarium pre-registration, two-shot delegation, independent-verify gate, de-novo audit (`:15`).
- *Register:* coord synthesis "from named estate mechanisms" (`:3`). A cheap restoration: "one fresh *committed* run of each line's final form" (`:21`).

**Q6. Was it checked at its source, and is our carrying of it faithful?**

- *Named:* transmission lock; `evidence/carriage`; "imported" in vsect. Ladder: "recall-marked-as-recall → search-corroborated → verified-via-secondary → primary-verified" (`M14/06-COUPLING-LOCK-AND-RECORDING.md:30`).
- *Told apart:* "defeasible on **two independent grounds**: the source could be wrong, *or* our carriage of it could be infidelious" (`method-evidence-tiers.md:101`). "Transmission is a wrapper, not a family": the lock looks through to the source's method (`M14/net/NOTES.md:40`, steward-caught).
- *Steward:* "(or, I would probably say: adjudicated/calibrated/qualified ambient prior)" (`M14/net/steward-truthification-sketch-….verbatim.md:63`).
- *Evidence, from the survey about itself:* "even canonical standards are mostly *transmitted through unverified secondary paraphrase*" (`XO/REASSEMBLED-MODEL.md:74`). Three walls were found open on re-fetch, "a small argument for re-checking blocked-primary claims on a schedule rather than treating a 403 as permanent" (`:170`).

**Q7. What exactly does it say, of what scope, at what grain?**

- *Seen:* vivarium, one segment: "**Max attainable: robust-qualitative** for the general method (FE §1); **exact** for the water-world instance (FE §2)" with deciders per clause (`SR/dive-papers-and-roots.md:17`). asf equation tags `*[Derived (…)]*` at statement grain; 42 Findings sections with search-depth axes; 122/170 "Incidental audit gold" sub-records (`SR/asf-implications-2026-08-14.md:17`, QUARANTINED, observational).
- *Named failure* [steward]: "Failure of containment/scope or to specify conditions", "Incorrect scoping of a prerequisite/dependency (common)", "(ofen these failures and more only become noticable in the seams)" (`M14/steward-failure-modes…verbatim.md:20-22`).
- *The headline problem:* "The frontmatter scalar has no declared projection rule — it means different things per segment" (`SR/asf-implications-2026-08-14.md:23`). The RC1 coordinator's nag: "this record is `exact (sub-scope); robust-qualitative generally` — which cell do I audit?" (`I/rc1-coord-wanderings-2026-08-14.md:18`).
- *Told apart:* a narrowed scope is a result, not a failure (`RC/04-CYCLE.md:36`). Honest edge: "the prose-first system may be load-bearing for truthfulness. The regime-partitioned Epistemic Status prose is *more* truthful than any enum" (`SR/asf-implications-2026-08-14.md:42`).
- *Fate:* grain was given a parameter but no projection rule; unresolved.

**Q8. How far could it ever get, and what would raise it?**

- *Named:* Max, ceiling, max-attainable, evidence-action. Trio: "name the **evidence-action** that would move the claim, not just the ceiling value" (`method-evidence-tiers.md:142`).
- *Told apart:* per axis (FILL WN-5), assignable from kind before work. Ground of why ceilings exist: "epistemic gaps have no principled ceiling, aleatory gaps *are* the ceiling" (`RC/07-DISPOSITION-AND-GAP-ECONOMICS.md:35`). Template: "Max is FROM THE DEPLOYMENT'S PERSPECTIVE" (`SR/epistemic-map.md:45`). vsect made it derived: "a declared function of its statement-kind, its declared form, its lines, and the ceilings of its premises" (`VS/core.md:123`).
- *Honest label the survey demanded:* the combination has no surveyed precedent: "*invention until that follow-up runs; build and label it that way*" (`XO/REASSEMBLED-MODEL.md:63`; audit finding that the model had dropped this label: `M14/04-EXERCISE-AUDIT.md:84`).

**Q9. Is it claiming less than it has?**

- *Steward:* "'underclaim' has been just as much a problem, as has 'underspecify'" (`M14/steward-failure-modes…verbatim.md:39`). Under-recording "just as dishonest as an unwarranted lift" (`RC/08-CERTIFICATION-AND-AUDIT.md:27`).
- *Told apart:* its distinctive harm is to absence. A reader cannot distinguish "*unrun* from *ran-and-unrecorded* from — worst — *'did they see a mistake in this that caused them to not upgrade the epistemic claim?'*" (`RC/08:28`).
- *Instrument:* decline-events. Also the expressive remedy [steward]: "There should always be a way for agents (including humans) to get their intuitions and tentative results known so they can be adjudicated" (`RC/08:30`).

### B. About whether it validly exists

**Q10. Did this come into being, as its declared kind, at all?**

- *Named:* Standing; misfire vs abuse; power/liability. "A gate, never a rung: a 'decision' recorded by someone without the power to decide is not a weak decision; it never existed as one" (`M14/01-MODEL.md:42`).
- *Told apart:* "Misfire ≠ wrong-content." Three external traditions: Austin (verified at SEP), Hohfeld (reliable secondary, with Kocourek's critique), chain of custody (NIST definition). "Three independent systems … converge on treating 'who has the power to act in this way' as orthogonal to 'how strong is the content once acted'" (`XO/sweep-authority-deontic-speech-acts.md:182`).
- *Wild specimen:* a prohibition nobody issued. "Reserved for Joseph+lead joint review" written into trackers bound agents for days; "a Standing/Authority failure at the record level — a restriction whose decided-by was never marked, operating as `ruled` while actually being an agent's register accident" (`TH/sop/influx/tracking-register-2026-08-10.md:9`).
- *Fate within August:* demoted in `M14/02-GROUNDING.md:27`, restored as Q0 in `M14/03-ADVERSARIAL-READ.md:15`. See §8 for what the word means now.
- *Unexercised half:* Hohfeld's first-order vs second-order decisions, "a Decision that *exercises* existing authority vs a Decision that *creates or alters* authority" (`M14/04-EXERCISE-AUDIT.md:49`).

### C. About choices

**Q11. Who stands behind it, and how firmly?**

- *Named, in several generations:* `decided-by` seven values steward/ratified/council/supported/defacto/proposed/transition (`I/verisect-and-ldocs.md:59`); vivarium `:by joseph/us/claude`, with `council-accepted` "strictly between proposed and decided" that "**never upgrades `:by`**" (`:57`); FILL ladder proposed → supported → ratified → ruled with rejected/superseded terminals (`SR/TAXONOMY-FILL-v1.md:80-87`).
- *Told apart* [steward]: "'ruled' by Josph implies Joseph might have a reason that wasn't stated. 'ratified' means he thought through it and would like to know if someone feels differently. 'supported' means he had no objections at that time. All very different statements about who knows, what kind of grounds there are, and what the remediation is." (`M14/steward-failure-modes…verbatim.md:70`).
- *Honesty states:* `defacto` ("'decided' without really being decided; recorded so the record exists"), `transition` (`I/verisect-and-ldocs.md:59`). vivarium's authority-inflation diagnosis: it fails at the end of an agent's context, "tying off loose ends FEELS like diligence" (`:57`).
- *Hard failure seen outside:* a 19-doc run recorded "user-stated claims … weak/agent-attributed… **inverting the record**" (`I/verisect-and-ldocs.md:77`).

**Q12. Who knows about it, and who had the chance to object?**

- *Steward:* "Who *knows* about this decision? (which is usually a proxy for 'Who understands and is ready to act on this decision?')", "Who has been given the opportunity to give feedback" (`M14/steward-failure-modes…verbatim.md:63-64`).
- *Named:* `decision/consultation` rungs unannounced → announced-to-affected → feedback-collected (`RC/04-CYCLE.md:47`). Failure [steward]: assuming "backwards compatibility with that ruling is critical, without realizing that that's based on the assumption that there are deployments using the old ruling" (`…verbatim.md:74`).
- *Fate:* attested, instantiated in one specimen, never exercised on real records.

**Q13. What was this choice derived from?**

- *Named:* groundedness; "Design/Architectural Epistemic Foundation Scale" (sketch, March 2026): Axiomatic/First Principles → Mathematically Grounded → Constitutive (eg speech act) → Empirical/Emergent → Well-Modeled (instance) → Model Grounded in Analogy → Informed Hypothetical, the gradient branching into Speculative, Random, Cargo cult/Unprincipled, annotated "Most certainly true" and "May still be true, but least certainty / probability" (`SR/sketch-2026-03-epistemic-foundation-scale.jpeg`, my transcription; compare `SR/foundation-axis-2026-08-14.md:11`).
- *Told apart:* from who stands behind it. "a `ruled` decision can be cargo-cult-grounded, a `proposed` one first-principles-grounded … (that conflation is exactly how authority launders groundedness)" (`M14/01-MODEL.md:36`).
- *Failure* [steward]: "Agents arguing historic authority instead of underlying grounding of the historic authority" (`…verbatim.md:85`).
- *Open:* per decision-event or per record (`M14/02-GROUNDING.md:37`). Instrument-follows-rung adopted from a quarantined file (`M14/03-ADVERSARIAL-READ.md:14`).

**Q14. What would make this require a revisit, and by what path?**

- *Steward:* "What would make this decision *require* a revisit/review?" and "What is the path for revisiting this decision?" (`…verbatim.md:68-69`).
- *Named:* `decision/falsifiers`; revisit-when, expires-on; decided-is-not-terminal; reopen brief "states *what changed since he last decided*" (`I/segment-research-notes-2026-08-09.md:75`).
- *Steward-primary source:* O3, "reasonless-rulings-are-recheckable" (`I/steward-brainstorms/discussion-thoughts-crossmap-2026-08-06.md:32`). "a schema without reasons can only be obeyed or defied; with reasons it can be argued with" (`:26`).
- *The field's shape:* "default-expiry beats default-limbo" (`XO/REASSEMBLED-MODEL.md:38`, IETF drafts, primary).

**Q15. Is this actually the steward's to decide?**

- *Named:* reserved calls; valve; four admission criteria "irreversible | authoring-voice | cross-project | provenance-check" (`I/segment-research-notes-2026-08-09.md:74`); closer classes (Q30).
- *Steward:* "A big one-- Agents see that there were decisions made that I ratified or ruled on or supported, and assume I am the decision-maker. This becomes a way for them to avoid the hard thoughtful big-picture work" (`…verbatim.md:88`). And the steward-side pole: "often controlling behavior and dogmatic or coercive insistance on lines of authority are instead proxy for lack of understanding or principledness in the first place" (`:98`).
- *Evidence:* valve "built 2026-06-02 … leaked within ~4 weeks (0 of 6 July forks reached it; verified by grep)" (`I/segment-research-notes-2026-08-09.md:73`).

**Q16. Does evidence license action, and does action imply evidence?**

- *Named:* L3 evidence-certainty and action-strength separate and non-mechanically coupled.
- *Told apart:* "strong recommendations on low-certainty evidence and weak on high-certainty are both legitimate, expected cells" (`XO/REASSEMBLED-MODEL.md:17`; GRADE Handbook, primary). Law: standard-of-proof vs admissibility vs what the evidence shows.
- *Used:* in the forbidden-edge list (`M14/06…:79-80`). The audit's best unexercised find: GRADE's Evidence-to-Decision structure as external warrant for the assertion/decision split (`M14/04-EXERCISE-AUDIT.md:57-58`), recall-grade, never fetched.

### D. About accounts of what happened

**Q17. Is this faithful to what happened, and who stands between the reader and the event?**

- *Named:* witness position `attested · reconstructed · secondhand`, `:date-confidence` (comproprium, `SR/dive-comproprium-kin.md:66`). "Nothing higher than `reconstructed` is available to an instance working from a transcript, however complete."
- *Told apart:* "a claim's job is to be presently true, an account's job is to be what happened" (`:68`), hence append-only. Position vs credibility (steward-caught, `M14/02-GROUNDING.md:47`): corroboration raises credibility, never position.
- *Steward:* "infidelity by ommission vs fidelity by fabrication vs fidelity by misrepresentation are all very different failure modes I think (and there may be more...)" (`…verbatim.md:112`).
- *Outside:* isnād/matn "genuinely dual-axis", typed chain breaks (muʿallaq, mursal, muʿḍal, munqaṭiʿ), "*per-instance not just per-source grading*" (`XO/sweep-provenance-testimony-source-criticism.md:173-175`; secondary quoting primaries). The audit's verdict after the steward's probe: "one genuinely generative clause … two corroborative-or-ornamental citations" (`M14/02-GROUNDING.md:47`).
- *In principle:* reductionism vs anti-reductionism about testimony, "a genuinely unresolved, still-debated question in the field" (`XO/sweep-provenance…:97`, recalled).

**Q18. Is the record of it intact, and is intact the same as adequate?**

- *Named:* chain integrity, traceability; "Fidelity underlies everything" (`RC/01-SPINE.md:62`).
- *Told apart:* "a perfect chain certifies lineage, never fitness" (VIM NOTE 5, primary, `XO/REASSEMBLED-MODEL.md:152`). RC1 coordinator's unresolved hypothesis: substrate Fidelity is really "chain-integrity — a gate", a different thing from witness position (`I/rc1-coord-wanderings-2026-08-14.md:11`).
- *Evidence:* the natural experiment. comproprium's checker went "3/109 quoted spans locate in a primary" after a directory move while "all 18 outline `#slug` refs survived the same move" (`I/synthesis/live-state-field-reports-2026-08-05.md:15-21`).

### E. About practices

**Q19. Does it fire when its moment comes, and for whom?**

- *Named:* efficacy; comproprium ladder "`fired · fired-once · proposed · failed-to-fire · retired`", "about *demonstrated firing*, not about whether the practice is a good idea" (`SR/dive-comproprium-kin.md:47`).
- *Told apart:* "a probe firing for its author is evidence it is well-aimed; a probe that fires for an inheritor is evidence it *transmits* — and only the second is what a corpus is for" (`:49`). Forbidden: "Backing ↛ Efficacy: endorsement cannot move the firing ladder" (`RC/03-DIMENSIONS.md:40`).
- *Register:* failure modes interpolated, "*steward illumination pending*" (`RC/03:24`), never given.

### F. About teaching

**Q20. Does it land in a reader's mind?**

- *Named:* Comprehension, added under steward catch (`M14/02-GROUNDING.md:43`). Instruments: misconception-keyed quiz misses, "agent confusion = reader confusion = defect", experiential walks, Feynman-with-perturbation (`M14/01-MODEL.md:29`).
- *Seen:* vivarium's gate: sealed quiz, "**Compaction invalidates the pass**" (`I/instances/vivarium-orientation-gate.md:23`). Also: experiential reading protocol, "the LLM cannot attend to future segment content" (`I/segment-research-notes-2026-08-09.md:52`).
- *Outside:* FCI distractors "keyed to specific, empirically documented student misconceptions"; Miller's founding datum that knows ≠ does (`XO/sweep-pedagogy-comprehension-ladders.md:132,185`).
- *The founding miss:* see §5.3 (the Exposition deletion). *Register:* interpolated (`RC/03:25`). RC1 addendum: vivarium's tooling "already emits reader events" and could ground the row (`RC/95-ADDENDUM…:37`).

**Q21. May this prose assert anything of its own?**

- *Named:* Claim License, "none / summarize-only / generalize-over-referents / original-claims; the outward dual of Usage License" (`SR/TAXONOMY-FILL-v1.md:59`).
- *Told apart:* definition vs gloss, "letting them share a slot launders register upward" (`SR/dive-udon-trees.md:237`). asf hazard: previews "should read as signposts, not as independent support" (`SR/asf-implications-2026-08-14.md:27`, QUARANTINED). SKOS note-typing: definition / scopeNote / editorialNote / changeNote / historyNote (`XO/sweep-knowledge-org-design-rationale.md:69-79`, primary). And ∅-instrument: "recorded intent ('this is a sketch; treat accordingly') is enforceable where repair is not" (`SR/TAXONOMY-FILL-v1.md:122`).

**Q22. Does it still say what the things it narrates say?**

- *Named:* referent-coupled freshness; `narrates` edge; teaching "goes stale when any statement it speaks about changes" (`VS/model.md:23`).
- *Told apart* (a real split inside one word): "`disc-anti-collapse` is a *claim about the framework* … `cooperative-adversarial-intro` is a pure narrating bridge … One fails by being wrong; the other fails by referent-drift. Same type, same status." (`SR/asf-implications-2026-08-14.md:27`, QUARANTINED).

### G. About commitments

**Q23. Is the commitment borne out?**

- *Named:* Conviction, "a declaration that cannot fail a build is a wish" (`M14/01-MODEL.md:30`); commissive gap from Searle (`XO/REASSEMBLED-MODEL.md:52`).
- *Dishonesty modes:* "silent divergence of the built from the committed; silent abandonment; the imaginary demand" (`RC/03-DIMENSIONS.md:26`, interpolated).
- *Seen:* vivarium "compliance debt, named, per clause" (`I/verisect-and-ldocs.md:225`). A question held open: "PRACTICA `:next` lines are commissives. Are they a family?" (`I/.archive/reflections-coord-2026-08-10.md:25`).

### H. About currency and trackers

**Q24. Is it still current?**

- *Named:* own vs referent currency; era-keys; recalibration; decay; never ratchets.
- *Told apart:* "`stale_reason`" style reasons in the VERA design (described, `SR/vera-read-notes-2026-08-10.md:10`); three decay families in RC1: "edit, referent change, era bump" (`RC/02:66`). Git recency is not status: "rename sweeps poison recency-ordering" (`TH/src/claim-truth-over-proxy.md:31`).
- *Seen:* vivarium "a no-go measured on one kernel was later *inverted* by code drift and honestly re-opened ('family live again')" (`I/verisect-and-ldocs.md:57`); the search log's dated sufficiency note (§3N).
- *Derived:* RC1 §11, "A status cached in a file is … an evaluation carrying its moment, never a standing fact" (`RC/02:56`); certificate decay follows.

**Q25. Does a tracker tell the truth about what it tracks, and who loses on disagreement?**

- *Named:* label-lie; lagging index; conflict precedence; charter sentence.
- *Seen:* NOTATION.md: "This file is a lagging index, not the arbiter … When this index and a segment's own definition/derivation disagree, the [segment wins]"; vivarium ETHICS, opposite pole: "where the body and Appendix A disagree, **Appendix A wins and the body is the bug**" (`SR/dive-papers-and-roots.md:51,53`). "the INDEX label was wrong in both pilot cases, in opposite directions" (`TH/src/claim-truth-over-proxy.md:68`).
- *Told apart:* authority host vs authority locus ("so its authority does not derive from this document", `SR/dive-papers-and-roots.md:57`).
- *Survey observation:* "The **maintenance-stance sentence** is the most consistent structural element across all classes" (`SR/dive-papers-and-roots.md:121`).

**Q26. How much of it does this actually carry?**

- *Named:* coverage ("silent-full forbidden", `SR/TAXONOMY-FILL-v1.md:41`); `Read-status honesty` sections; graduation completeness; delete-test.
- *The delete-test:* "assume the item disappears entirely; is every piece of its information either landed in the population or truly disposable?" (`TH/src/def-integration-replacement.md:28`), ratified in reversion.
- *Outside origin:* relata `coverage:` (`I/synthesis/relata-methods-…:192-196`).

### I. About who may use it and how

**Q27. What may a reader do with this?**

- *Named:* usage license. Residue: "Allowed use: [TESTED] kill-direction + mechanism as [HYPOTHESIS] for the full law; not claim-grade 'iff.'" (`SR/dive-papers-and-roots.md:27`). TBX/ISO: "Forbidden is not the same as deprecated" (`I/terminology-survey.md:118`).
- *Told apart:* journalism, license vs corroboration, kept independent "the hard way" (`XO/sweep-provenance…:122`, secondary). Refuted-but-kept is a kind: "Do not resurrect in claims, strategy, or response text … they are not softened ghosts in the claims tree" (`SR/dive-papers-and-roots.md:25`). Wikidata retention (primary).

**Q28. Who may safely read this?**

- *Named:* audience safety; priming; README vs `README-auditor.md`; publication membrane. "PRACTICA itself is **auditor-safe** … but linked entries … are priming-heavy" (`SR/dive-papers-and-roots.md:45`). Publication: "the distinction is publication, not validity" (`SR/dive-comproprium-kin.md:85`).
- *Later, on glances:* "shape facts … are auditor-safe; provenance-of-work facts (heat, age, recency order, deltas) carry exactly the signal a de-novo pass must not inherit" (`I/verisect-and-ldocs.md:263`).

### J. About what is not known

**Q29. Is this gap a known unknown, and of what shape?**

- *Named:* quantified spread → scenario → recognized ignorance; "total ignorance is assignable only by an external auditor" (`RC/07:35`; Walker, medium/secondary; the un-self-reportability is the sweep author's inference, `XO/REASSEMBLED-MODEL.md:134`).
- *Told apart:* "Cannot be judged" ≠ worst rung (Admiralty F/6); "not-proven ≠ proven-false"; Wikidata normal "explicitly 'provides no judgement or evaluation,' deliberately *not* 'pending'" (`XO/REASSEMBLED-MODEL.md:23,102`). `outcome: n/a` in relata (`SR/dive-asf-lineage.md:141`); typed `--GAP--` vs bare missing rows (`I/synthesis/live-state-field-reports-2026-08-05.md:51,71-73`).
- *Laws:* "Absence claims carry their search" (udon FORMAT §0b, `SR/dive-udon-trees.md:98`); instruments distinguish "empty ≠ failed ≠ unrun".

**Q30. Who may close this, and was it already answered?**

- *Named:* question classes `WAIT-DEMAND · STEWARD / fact · agent-suggested (open)` ("*what kind of event would close this and who may close it*", `SR/dive-udon-trees.md:182`); closers steward-fact, awaiting-ground, agent-open (`RC/07:16`); `steward-purpose` in vsect (`VS/model.md:70`).
- *Failure named:* re-billing. "asked-and-answered is recorded" (`RC/07:18`). "Silent loss is the deep failure" (`:19`).

**Q31. Which gap is worth closing first?**

- *Named:* EVI/EOL/EVPI (Hubbard; medium, secondary); decision-inflection [steward]: "(where a decision needs to be made often before hypotheses are even formed)" (`M14/net/steward-truthification-sketch…verbatim.md:51`).
- *Counterweight* [steward-attested]: "cheap truth is run, not triaged" (`RC/07:31`). An estate formula, never built (`SR/vera-read-notes-2026-08-10.md:15`).

**Q32. Is it where it can exert its due influence?**

- *Named:* Disposition; salience folded in as a falsifiable hypothesis. "exciting the work it should, inhibiting what it should" (`RC/07:7`). `|should-come-to-mind-when`, split `|before-acting`/`|on-reading`; "empty is a finding, not a hole" (`SR/dive-comproprium-kin.md:76`).
- *Register:* steward hypothesis, adopted, doubted by its adopter: "I can't currently say what a Disposition *ladder* certifies to a consumer" (`I/rc1-coord-wanderings-2026-08-14.md:13`). Stranger read named it the weakest row (`I/rc1-denovo-read-2026-08-14.md:37`).

### K. About relations

**Q33. What happens along this reference when its target changes?**

- *Named:* typed edges. "an edge kind earns its place exactly when some consuming operation routes it differently" (`RC/06-EDGES.md:3`).
- *Told apart:* rebut (attacks the conclusion, hard cascade) vs undercut (attacks support, soft re-price) (`RC/06:35-37`; Pollock, verified at SEP). Composability per kind: "`closeMatch` … to avoid the possibility of 'compound errors'" (`XO/sweep-knowledge-org-design-rationale.md:62`, primary). `seeded-by` transitive "the one edge where propagation is the point" (`RC/06:13`). `vsect` table of consequences `VS/core.md:53-68`.
- *Reach, not just meaning:* designator vs description, "a binding fails through its maintenance, a match through the world's motion" (`RC/11-LEXICAL-CORE.md:37`). Intended cardinality gives a miss its meaning (`RC/06:25`).
- *Steward demand:* "this theorem's epistemology just got upgraded and this theorem just got disproved and is now this no-go. All affected segments will now be fixed in turn as a cascade automatically." (`I/verisect-and-ldocs.md:194`).
- *The field's center of gravity:* "the state that matters most in the literature surveyed here is edge-shaped … not node-shaped" (`XO/sweep-formal-epistemology-argumentation.md:187`).

**Q34. What replaced this, how much of it, and why?**

- *Told apart:* "supersession wants *grain* (partial vs whole) and *kind* (revised vs invalidated vs alternate), not one flag" (`XO/REASSEMBLED-MODEL.md:25`; IETF Obsoletes/Updates, PROV, primary). Terminal states carry reasons and neither is deletion: "both keep the record answering 'was this ever considered?' at zero search cost" (`SR/TAXONOMY-FILL-v1.md:94`).

**Q35. Is this the same thing restated, or a different thing?**

- *Seen:* comproprium `:family`: "two segments are duplicates only when they resolve to the same span in the same primary" (`SR/dive-comproprium-kin.md:72`); relata `same_work_as`, "link, never silent merge" (`I/synthesis/relata-methods-…:186`).
- *Told apart:* FRBR grain (one-hop secondary); `restates` with exact composing and near not chaining: "near-plus-near drifts" (`RC/06:15`). Discriminator never stated (`RC/06:51`).

### L. About records, kinds and work

**Q36. Where does one record end and another begin?**

- *Named:* grain invariant; adjudication grain = record grain; RC1 fail-apart; "one fate, one atom".
- *Told apart:* "can this piece fail — be refuted, rot, reopen — while that piece stands?" (`RC/10-FOUNDING-QUESTIONS.md:28`). "An atom is the thing with one fate … Ask of any piece: could this be refuted, superseded or ratified while that piece carries on unaffected?" (`VS/model.md:9`, endorsed by Joseph 2026-08-31).
- *Named pathology:* the undeclared mixed composite (`M14/01-MODEL.md:85`). And the Q1 strain [steward, verbatim in substance]: "most decisions in most projects have a combination of assertions, decisions, prescriptions, how to teach them, commitments… I'm still stuck on Q1" (`RC/10:26`).

**Q37. What kind of thing is this, and what follows from that?**

- *Told apart:* three-way split of what asf's `type:` carries: "stable form-kinds … mutable trajectory-kinds … exposition-weight kinds" (`SR/synthesis-v0-2026-08-10.md:48`). Form-kind in the slug only, because renaming on promotion means "every reference to the old slug dangles *because the corpus learned something*" (`TH/src/form-slug-form-kinds.md:45`). vsect: "`hypothesis`, derived and empirical are stages of one kind" (`VS/model.md:25`). And `register:` taking lists (`SR/dive-udon-trees.md:166`).
- *The counter-pole held open:* one node type with properties (`I/.archive/reflections-coord-2026-08-10.md:13`, `SR/vera-read-notes-2026-08-10.md:29`).
- *See §4 for the retracted individuation law and §5.3 for what it cost.*

**Q38. What work has been done on it?**

- *Named:* process flags; stage; `state`.
- *Told apart:* independent, resettable, each naming its reset. "updating a well-verified atom must feel like advancement, not regression" (`TH/src/form-state-flags-not-gates.md:25`). "A ladder that only promotes accumulates falsehood" (udon FORMAT).
- *Seen:* asf's own spec "'as warnings only … the stage layer is known to go stale quickly … and is currently ignored in practice'" (`SR/dive-asf-lineage.md:29`). See §5.4 on the evidence's scope.

**Q39. Who maintains this text?**

- *Named:* ownership; template maintenance axis (steward, 2026-08-10): verisectorium- / other-project- / target-maintained (`SR/epistemic-map.md:51-58`); ceiling derives from it: "you can ratify adopting what you don't own, not rule its text" (`RC/03:68`). Live conflation: `state:` multiplexed process and maintenance (`SR/dive-udon-trees.md:206`).

**Q40. What can be said of a whole built from parts?**

- *Named:* composites; four closure shapes reify / view-ify / cluster / exempt-visibly; "certification of any legitimate composite is **inherited through edges, never averaged**" (`M14/01-MODEL.md:87`). Emissions as "the hard legitimate composite".
- *Seen:* a frozen artifact pinned under "a stem no manifest owns, so `bin/build` cannot overwrite it" (`SR/dive-papers-and-roots.md:89`); vsect container rows never get one grade (`VS/model.md:29`), and its moments carry `+dirty` (`VS/core.md:45`).

### M. About the acts of checking

**Q41. Who checked, and were they independent enough?**

- *Named:* certification; grader; independent-verify gate; per-rung grader authority.
- *Told apart:* "Certification strength is bounded by grader independence, never by effort" (`RC/08:9`). Wikipedia's three governance tiers (primary). Verification ≠ validation (`RC/08:11`; ASME: "a model can be perfectly *verified* … yet completely *invalid*", `XO/sweep-uncertainty-about-uncertainty.md:172`).
- *Seen:* "self-certified 'fully clean' honesty-sweep that wasn't" (`TH/src/claim-truth-over-proxy.md:65`). Admiralty's leak despite two columns (`M14/04-EXERCISE-AUDIT.md:52`, recalled).
- *Sharper in vsect:* independence as a predicate over declared `read` and `descends-from` (`VS/core.md:113`).

**Q42. Is the status a computation someone can redo, and where does trust bottom out?**

- *Named:* status-as-projection; "The only status a stranger can trust is one they can recompute" (`RC/01-SPINE.md:11`); trusted base, three layers: reproducibility, tamper-evidence, identity, then "named trust for the remainder" (`RC/08:21`).
- *Told apart:* "Four different things, kept apart": someone *says* an act happened; it is *reproducible*; the actor was *independent enough*; the *trail is unaltered* (`VS/core.md:112`).
- *Lineage:* neurips/refs `verifications/<key>/<ts>-<actor>-<verdict>.md`; terminology decisions; udon-needs `verified:` lists; relata (see §5.4 on this count).

**Q43. What may a consumer conclude from this?**

- *Named:* license served; "a rung that changes nothing a consumer may do or rely on is not a rung" (`SR/securing-contract-2026-08-14.md:78`, QUARANTINED). SERVE stage: "a `supported` decision licenses acting-on-it with easy revisit, never arguing-from-it-as-law" (`RC/04-CYCLE.md:17`). Acceptance test: "is it immediately obvious to a de-novo auditor, given nothing but the outlines and segments, exactly what things should be audited?" (`SR/TAXONOMY-DRAFT.md:10`, steward).

**Q44. How deeply is this discipline carried?**

- *Named:* inculcation ladder conscious → habitual → reflexive → instinctive (sketch; `M14/01-MODEL.md:74`). "a discipline's rung on this ladder is the honest statement of how much it can be relied on under turnover". The dangerous cell [QUARANTINED]: "instinctive × unfounded" (`SR/distilled-model-2026-08-14.md:83`).

**Q45. Is this line of work healthy over time?**

- *Named:* Lakatos progressive/degenerating; "the line as a first-class object … unused anywhere downstream so far" (`M14/net/NOTES.md:57`).

### N. Questions the survey found once and did not carry

These are single-sighting in the dives. Implicit adjudications, each with a live surface.

- **Search sufficiency.** Findings Search Log: dated entries each with "a status and 'why this depth was right at this point'" (`SR/dive-asf-lineage.md:35,138`).
- **Second-order confidence on concerns.** logos FEEDBACK items, "*My confidence* (high/medium/low — where the concern itself lands)" (`SR/dive-papers-and-roots.md:61`).
- **Emulated authority.** Method norm "modeled after canonical papers" (`:90`).
- **Usage conformance.** "both ASF and vivarium stores can be perfectly maintained and entirely ignored" (`I/terminology-survey.md:782`), and the paths tooling beginning on definition-drift.
- **A standing dissent register.** `counter-register`: "a thesis can be no stronger than the counter-evidence standing against it is weak" (`I/instrumenta/bridges/counter-register.md:32`, REGISTER-RULING).
- **Marginalia.** `<!-- remove -- … -->`, `<!-- salvageable -- … -->` inline verdicts (`SR/dive-asf-lineage.md:50,147`).
- **Priority and modify-frequency as declared columns** (`SR/dive-udon-trees.md:62,226`); `consumers:` (`:169`).
- **Designation vs concept status.** ISO/MultiTerm "*Is this concept accepted?*" vs "*Is this spelling the preferred designation?*" (`I/terminology-survey.md:190-191`); recognition markers (`:828-834`).
- **Deliberately unrecorded classification.** "the three rings … 'not part of segment frontmatter — an analytical stance the reviewer takes'" (`SR/dive-asf-lineage.md:37,137`): axes real but withheld from a cell to avoid false authority.
- **Divergence-only rule files**, whose freshness is "does the upstream still say what I diverge from" (`SR/dive-comproprium-kin.md:103`).
- **Scheduled-death and uninstantiated states.** `defs.source.ud` "retired by delete-test"; template seeds (`SR/dive-udon-trees.md:41,211`).

## 4. How the period told things apart

The instruments for separating two things, roughly by how much weight they took.

- **Failure-and-repair.** "do the two fail differently, and are they repaired/adjudicated differently?" (`SR/pre-taxonomy-synthesis.md:15`). Its first form, "distinct iff failure mode + adjudication instrument differ," was retracted because "the 'iff' was this session's addition, claimed by neither source" and "deleted the Exposition family" (`:17`). Redeemed as a forcing function [steward]: "'what **should** its failure mode be? what **should** adjudicate and repair it?' — and hold the kind open until the discussion produces answers." The disposition that travels with it: "a gap declaration needs no argument, and an exclusion that argues is the tell of a gap in costume."
- **Fusion test.** "a ladder whose values are unrolled permutations of independently-movable parts (`ruled-groundless | consulted-independent-agent-grounded | …`) is two dimensions sharing a field" (`RC/01-SPINE.md:32`, steward). A dimension: "the thing that is orthogonal as it is created" (`RC/02:23`).
- **Fate test.** Q36.
- **Consumer test.** An edge kind earns its place when "some consuming operation routes it differently" (`RC/06:3`); a rung that changes nothing a consumer may do is no rung (`SR/securing-contract…:78`). RFC 6410's stated reason for killing a rung: "there is no longer a useful distinction between the top two tiers" (`XO/sweep-document-lifecycle-standards.md:13`, primary).
- **Direction of fit.** word-to-world / world-to-word (hearer or speaker) / word≡world / null (`XO/sweep-authority…:32`). Commissives named as a gap.
- **Wambaugh's inversion test** for what is load-bearing in a text: "ask whether the decision would have been different, had the statement been omitted" (`XO/sweep-authority…:88`). Verified via secondary. Not used downstream that I found.
- **Instrument follows the ground.** "grounded in proof → re-derive it; in declaration → ratify it; in reality → measure it; in a proven model → check the instance; in analogy → break the analogy; a practice, any ground → watch it fire" (`RC/01-SPINE.md:48`).
- **Admission adjudication.** Every axis routed dimension / bound / universal machinery / gate (`RC/03-DIMENSIONS.md:52-74`). A *bound* is "declared, consulted-at-a-moment, not warranted by degrees" (`:107`).
- **Forbidden substitutions.** The never-substitute list, each "a failure already paid for" (`M14/06…:77-87`, `RC/03:36-44`).
- **Discriminator for intrinsic variation.** "variation is intrinsic when it traces to the atom's truth-conditions, drift when it traces to who built the instance first" (`TH/OUTLINE.md:242`).
- **De-novo auditor criterion** (Q43).
- **Exercised vs cited**: "cited prior art is ornament; *exercised* prior art is an instrument" (`M14/02-GROUNDING.md:47`), with a third bin added by the audit, corroboration (`M14/04-EXERCISE-AUDIT.md:7-11`).
- **Claim vs instrument boundary:** `bin/check-corpus` "deliberately does not check: whether a claim is true, whether a status is honest, or whether a practice ever fired … pretending otherwise would make this a proxy wearing verification's clothes" (`SR/dive-comproprium-kin.md:85`).

## 5. What the evidence was, and how good

### 5.1 Internal evidence

Estate only, and one steward. The period said so repeatedly, e.g. "the record is structurally biased toward the agreements that got written down" (`RC/95-ADDENDUM…:43`), and `M14/02-GROUNDING.md:7-22` for each element's trace. The strongest kinds it had:

- Near-natural experiments: the comproprium move (Q18); limen's founding from one sentence, where "the **praxes transferred at high fidelity** … The **organs did not transfer**" (`I/verisect-and-ldocs.md:62`).
- Counted corpora: asf type censuses; asf terminology action census "canonicalize 137, weak 6, add-cite 5, rename 4, **nuance-flag** 4, update-gloss 2, add-alias 2" (`SR/dive-asf-lineage.md:89`); relata `2,277 entries` (`I/synthesis/live-state-field-reports…:58`).
- Steward attestation across "thousands of sessions" (`TH/src/obs-truth-failure-manifestations.md:13`), openly unmeasured.
- Dated caught specimens, per trap, with the rule "do not let the trap list grow entries that lack a caught, dated specimen" (`TH/src/claim-truth-over-proxy.md:86`).

### 5.2 External evidence

Ten sweeps, each grading itself per entry; the coordinator's annotation pass re-fetched and changed grades openly. Which legs held what:

- Primary-verified: IETF, W3C (2005 snapshot), Wikidata, Wikipedia assessment, SKOS, PROV, nanopublications, VIM, ADR; and after annotation GRADE Handbook, IPCC guidance note.
- Verified at a strong secondary: Walley, Pollock, Austin's misfire/abuse (SEP); hadith, Hohfeld, ratio/obiter, journalism, Admiralty (Wikipedia/Wikisource), Dung, Miller.
- Medium or convergent-secondary: GUM (convergent), Walker, NUSAP, Hubbard, TRL.
- Recalled and labelled so: historiography, proof-assistant kernels, Toulmin ("flagged here as the single most important item in the whole sweep still needing primary verification", `XO/sweep-knowledge-org…:234`), ISO stage codes, ICD-203's non-conflation rule (reported-not-read).

The sweep's own corrections are specimens. Two: "The W3C Rescinded/Obsolete two-cause split — which read as one of the most directly useful findings in the original search pass — did not survive a primary-source check" (`XO/sweep-document-lifecycle…:174`); and "That sweep says 'six verified systems' but only four of its seven entries are actually primary-verified" (`XO/REASSEMBLED-MODEL.md:106`).

Named as open follow-ups, unrun: safety-case frameworks, COPE retraction states, Bradford Hill, Gage R&R, canon-law promulgation, contract conditions, git as supersession, Robert's Rules precedence (`XO/REASSEMBLED-MODEL.md:70`).

### 5.3 The survey's own central error

Worth reading whole: `TH/sop/influx/survey-census-and-law-filter-2026-08-10.md:5-7` and `SR/TAXONOMY-FILL-v1.md:121`. The first fill deleted the Exposition family because it failed the candidate law; "a count would have made the family undeletable." Steward: "You assumed that because the survey found that the existing corpus hadn't answered them meant that it wasn't a category — that's a very different thing — filtering what we'll ponder and make principled, vs. how we know our pondering and generative output is complete or sufficient yet." The direction became praxis: "**design → survey** is legitimate … **survey → design** is the sin." Two more of the same day: "A kind survey without a count census is an inventory wearing a distribution's name" (`:7`), and 05-CONCLUDING's "The under-weighting bias has a direction … audit the non-assertion rows hardest" (`I/.archive/05-CONCLUDING-2026-08-14.md:17`).

The method lesson that came out of it: "agent reports from survey fan-outs are maps, not synthesis inputs" (`TH/sop/influx/glance-vs-extract-2026-08-10.md:20`).

### 5.4 Things in the archive that disagree with themselves

Mine, from reading it. Small, but they are the kind of thing a specimen-hunter would want.

- **"Majority."** The FILL says exposition is "the majority of many corpora by count" (`SR/TAXONOMY-FILL-v1.md:23`) and PRACTICA calls it the "majority family" (`PRACTICA.ud:63`). The later census found 47/170 ≈ 28% of asf vol-1 and "*not* a majority anywhere counted" (`SR/distilled-model-2026-08-14.md:160`), and the correction was recorded as a label-lie specimen (`M14/03:9`). The FILL's cell was not changed.
- **"The promotion ladder has never run anywhere."** The field report's headline (`I/synthesis/live-state-field-reports-2026-08-05.md:23`) shares a file with asf's "real promotion history (128 draft / 22 deps-verified / 18 claims-verified)" (`:49`). `TH/src/form-state-flags-not-gates.md:29` then cites "the inherited promotion ladder never operated". What the evidence shows is narrower: the terminal gate never fired and vivarium's ladder sat at the first rung. The formulation's motivating evidence is stated more strongly than its source.
- **Four generations.** The lineage is named two ways: `neurips/refs → asf/terminology → logos/refs → relata` (`I/instances/deployments.md:33`) and "neurips/refs verifications → terminology decision-events → udon-needs `verified:` lists → relata" (`M14/01-MODEL.md:13`).
- **Currency count.** 05-CONCLUDING says "nine currencies incl. the degenerate Disposition row" (`:7`). The table has eight (`M14/01-MODEL.md:23-30`).
- **"Lock" after its retirement.** RC1's `90` still narrates "the model's own lock arming on itself" (`RC/90:41`), and its claim that the two stranger reads are "the first descent-independent agreement" reads differently under its own coherence default: both read the same text. Their agreement is about how the document reads.

### 5.5 What was never exercised

The period knew this and said so. Unrun as of the last write-up: the de-novo-auditor walk over a corpus (FILL WN-9, `RC/08:38`, "still its most important unrun test"); the founding dry run; the EtD and safety-case checks; SPECIMEN #3 (one multi-record episode), a teaching-record specimen, a failure specimen; vsect's five-segment test (`VS/open.md:22`). "Round 2's mechanisms have been traced through the porcelain on paper, not run" (`VS/open.md:140`).

The failure-mode series stopped at Fidelity. `M14/steward-failure-modes…verbatim.md` holds Evidence, Backing, Fidelity; `RC/03:104` records Efficacy, Comprehension, Conviction, Freshness and Disposition as "interpolated", and I found no later bursts in what I read.

## 6. Retired during the period, with the verdict

- **"Generative law" / iff-form individuation.** Retracted 08-10 (§4).
- **The promise primitive.** "It is not wrong — it is *equivalent* to the failure-and-repair form for everything both cover — but it claims derivational power … the graft structure doesn't support" (`M14/03:7`); removed from RC1's spine after a letter-vs-intent catch (`I/outline-review-2026-08-14.md:32`).
- **Lock → coherence default** ("no cap, no bonus, no noun needed", `RC/00:49`).
- **"Currency" as the spine name; "currency" as the freshness row.** `RC/00:49`.
- **FAMILY object.** One commit (`RC/02:74`): "organization keeps trying to become ontology."
- **"Point"** → "refers", 08-30.
- **Stage-as-ladder; `Stage` the column** (`TH/OUTLINE.md:236`).
- **The `term` noun and `sponsio`.** Retired for definition/lexicon and for professio (`CHANGELOG.md:56,62`).
- **Hadith vocabulary in working terms.** Kept in provenance only (`M14/02-GROUNDING.md:47`).
- **Executable nets as carrier.** "formalism capture" (`I/outline-review-2026-08-14.md:11`); kept as `RC/lang/` spike.

The RC1 coordinator's closing observation about all of these: "the model got *smaller* every time it got truer, all day, without exception" (`I/rc1-coord-wanderings-2026-08-14.md:38`).

## 7. A summary of the distinctions most often repeated

Mine, and offered only as a pointer. Across dives, sweeps and models, these recur most: support separate from source-trust (Joseph flagged this one by name, "how all mature epistemic systems track fact-support separately from origin-credibility", `I/.archive/NOTE-TO-SUCCESSOR-2026-08-14.md:29`); kind gating which questions may be asked; uncertainty kept out of the lifecycle slot (`XO/REASSEMBLED-MODEL.md:19`); null and terminal states off-ladder; status computed from itemized acts; top rungs event-gated.

## 8. What has happened to it since

**Scope of this comparison.** Against `core/model.outline.md` and the def headers as they stand today (uncommitted), and greps over `msc/notes/` excluding `00-INDEX` and `18`. Pattern-based, so "absent" means my pattern did not hit. I did not read the notes. Treat these as prompts.

**Carried forward, reshaped.** Ground (= declared foundation, "The instrument follows the ground", `core/def/ground.md:21`); bound; dimension generalized to "a «ladder» … an unordered set, or a number"; acts bound to what they read; "recording too little is as dishonest as claiming too much"; the delete-test as source retirement; projection/rendering; roll-ups; `known defect on a steady state` as a gap. The episode gap of `RC/95` appears answered by the log and the atomic changeset: `core/def/log.md` avoids "trail" as "an earlier word for one piece's part of the log, which left no place for an act that spans several pieces".

**Moved meaning, worth a second look.**

- **Standing.** August: whether a record validly came into being as its kind (Q10). Now: "Whether a given actor's act of a given sort counts at all; yes-or-no before any question of quality" (`core/model.outline.md:96`). The act-level reading is in the vsect line of descent, but the record-level misfire (a decision by someone without power, a restriction nobody issued) has no row I could find. Possibly it's the `veritoid` kind's job now; I could not tell.
- **Kind individuation.** `core/def/veritoid-kind.md` avoids "speech act" with the reason "an earlier model individuated kinds by how they fail; here by what is asked of them". That is a reversal of the period's most defended move, and the Exposition episode is the record of why it was defended so hard. Probably deliberate; the archive's reason for the old form is at `SR/pre-taxonomy-synthesis.md:17`.
- **Ceiling.** `core/def/bound.md` avoids "ceiling" for "the most a piece could ever earn"; ceiling language survives at `core/def/reference.md:34`. August's evidence-action ("names the action that would raise it") I did not find in the model rows.

**No hits in `core/`, present in notes.** Value of information and decision-inflection (`msc/notes/02`); descent (12 files); rebut/undercut (8); era (8); disposition and salience (11); defacto/transition (11); closers and asked-and-answered (11); claim license (6); carriage (7). These are still in play at the planning layer.

**No hits in `core/`, and thin in notes.** Two-column credibility vs what-the-act-showed: only in the reading notes (`msc/notes/08-…/09-rc1.md:100`). Conflict precedence: same file. The declared-ignorance vocabulary, recognized ignorance and aleatory: only that file. Conviction: named in a plan line and a draft's working note (`msc/notes/02:175`, `msc/notes/11-…/def-dimension.yaml:59`).

**No hits anywhere I searched.** Inculcation ladder (Q44). Support directionality and multiplicity (Q3's `3×`, "rigorous in the negative direction"). Maintenance-stance charter and artifact fixity (Q25, Q40). Typed or partial supersession (my pattern was narrow; `supersedes` as a plain relation exists at `msc/notes/09:169`). Lakatos line-health (Q45).

## 9. Owed, by the archive's own account

Beyond §5.5: the steward failure-mode series for five dimensions; the Evidence MECE call; the `claim-` prefix and wikilink-form calls, both parked; the VERA joint session (marked waiting, enabling intent, `PRACTICA.ud:129`); `@{moment}` undefined in two corpora (`RC/11:60`); the Q1 repair, unlanded (`RC/10:32`); the exercise-audit worklist (`M14/04:86-92`); whether Fidelity is a dimension or a gate (`I/rc1-coord-wanderings-2026-08-14.md:11`).

## 10. Feedback and adjacent findings

**On the brief.** It worked. Naming what not to read, why, and who reads the result was what made this tractable; the location-with-verbatim request shaped the file more than anything else. One thing I would flag: "what questions … being adjudicated" is itself a lens, and it tends toward one row per question, which is the shape this file has and the shape the archive warned about. The archive's most useful items resist it: §5.3, the failure-mode bursts, and `I/.archive/NOTE-TO-SUCCESSOR`.

**Reading paths I would give Joseph, in order.** `M14/steward-failure-modes…verbatim.md` (his own words on Backing, 114 lines); `SR/dive-papers-and-roots.md` Part I (the misfits); `SR/dive-comproprium-kin.md` §1; `TH/sop/influx/survey-census-and-law-filter-2026-08-10.md` (7 lines); `I/verisect-and-ldocs.md` §3.2 (a production failure catalog with thin descent from this estate, the external evidence closest to home).

**The most useful thing in the archive that I think got under-used.** `RC/08:30`'s expressive remedy, that under-recording is often "the symptom of a missing register," and the observation from comproprium and asf that the prose layer is often truer than any field. Both bear on what a computed-values design has to leave room for.

**Public remote.** The brief says this repository has a public remote. `.archive/prior-incarnation/` is tracked, and `origin/main` contains `theory/influx/vera/` (4 files) among others. Several tracked files name ELI work directly (`I/terminology-survey.md:68,139,430`, `I/vera/*`, `I/tribunal/discovery-internal-architecture-2025-09-21.md`), and `I/verisect-and-ldocs.md` names a family member and a client. If that exposure was not deliberate, it is for Joseph to look at. I changed nothing.

**A stale pointer.** `VS/README.md:15` and `VS/open.md:117` point at `~/src/arch/firmatum/verisectorium/...`; the theory now lives in this repository's `.archive/`. The sweeps' `arch/firmatum/...` paths have the same age.

I'm happy to stay on the line for follow-up questions.
