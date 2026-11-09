# Census: ASF's deliberative layer (Working Notes and audit working dirs)

Read 2026-11-08 by a census agent (Claude Opus 5.5) for `msc/notes/18-2026-11-08-dimension-census.md`. Paths are relative to `~/src/arch/asf/` unless absolute. I formed this before opening the other census reports, and I did not open them afterward either, so overlap with them is unchecked.

## What I actually read

| Part of the layer | Size | How I read it |
|---|---|---|
| Working Notes, parts 02, 03, 04, non-gold | ~166 KB | Whole |
| Working Notes, part 01, `deriv-*` | ~98 KB of 456 KB non-gold | Whole through `deriv-update-detection-latency`; the last `deriv-variational-sector-condition` by excerpt |
| Working Notes, part 01, `der-*` | ~40 KB of 61 KB | Whole through `der-observability-dominance` |
| Working Notes, part 01, `disc-`, `impl-`, `def-`, `form-`, `result-`, `hyp-`, `scope-` | ~270 KB | Not read whole. Line-level excerpts from targeted greps (tier, demote, retag, Joseph, regression) |
| Gold blocks in Working Notes | 755 KB | Essentially unread as prose. One block's opening and off-ramp (`deriv-recursive-update`), plus individual lines hit by greps |
| `audits/AUDIT-WORKING-*` (24 dirs, 912 md files incl. per-dir `.integrated/`) | ~6 MB | First lines of all 24 `00-initial-predictions`. Whole: `731548/25-deriv-sector-condition.md`. About two-thirds of `731548/verify/01-persistence-iff-verdict.md` (lines cut at 1,500 chars). Openings of `308172/99`, `738192/02`, `628417/99`, `628417/*.prediction.md`. Regex tallies over all 912 |
| De-novo protocol | | Reflection prompts and §5.4 of `doc/sop/audit.sop/de-novo.sop.md` |
| `audits/ADJUDICATION-WORKING-218564/adjudication.md` (61 KB) | | Front matter and disposition table rows only. The six under `.integrated/` not opened |
| Not read | | `spikes/` (except where cited), vsect event contents, other census reports |

Several of those reads truncated long lines, so a claim about a file I only excerpted means "in the part I saw." All quotations below are copied from the files, with `[…]` for cuts. Tallies are regex counts on my extraction and are approximate.

The `audits/README.md` gate says processing or mining of the `AUDIT-WORKING-*` dirs should be decided with Joseph. I only read and quoted, and moved nothing, but some of what I quote is from unlifted reflections. Please check that this census falls within what he intended.

## Short answers

**The guess that status disputes and their resolutions live here and nowhere else is wrong in its strong form.** I traced eight disputes (table in §3). Outcomes usually also appear in `CHANGELOG.md`, and the arguments usually live in spikes or `verify/` files. What is often found only here is something narrower: a live instruction about what must not be restored, the conditions that would move a claim, positions that were withdrawn, disagreement deliberately kept open, and credences. The sample is eight cases I chose, not a random one.

**The layer's distinctive content is mostly conditional or negative.** A status word says where a claim stands. These notes say what would move it, what looks better but is known false, what the check did and did not touch, and whose call it is. The clearest specimen of the third is in §2.3.

**Bulk.** Of about 1,371 KB across 238 of 247 segment files, 755 KB (55%) sits in the "Incidental audit gold" blocks of 119 segments. Further templated material takes the non-template remainder to roughly 470 KB, about a third (§1).

**The one rule for ending a Working Note has never fired.** FORMAT says they are "removed or emptied when the segment reaches `candidate` stage." Zero of 247 segments are at `candidate` (205 `draft`, 23 `deps-verified`, 17 `claims-verified`, 2 `exploratory`), and all 40 at the two advanced stages carry notes over 200 bytes. CHANGELOG line 120 records a "2026-07-14 stage-as-process-archaeology position — `status:` is the live tier", which may be why, but the removal clause still stands in FORMAT and in about 30 Migration notes.

## 1. Template versus organic

| Layer | Size | Shape | Origin |
|---|---|---|---|
| Incidental audit gold | 755 KB, 119 segments | Six numbered categories (Candidate Brief prose, Candidate Discussion, Follow-up, Readers often ask, Candidate figures, Belongs elsewhere), usually with an "Off-ramp (NOT gold)" | Commits "Gold-lift A1…A7", 2026-05-30/31, after a pilot. `git log --grep gold` on 01-aat-core: 25 commits in May, 10 in October. I did not apportion bytes by date, so "mostly May" is about commits |
| Pointers for Fleshing Out | ~54 KB, 16 segments | Upstream files, memorata queries, internal references, open questions, Promotion-blocking | 2026-05-01 encounter cycle, mostly parts 03 and 04 |
| `impl-*` chapter-end notes | ~78 KB | "This segment is a chapter-end discussion grouping findings…", "Cross-reference vs canonical-home policy", "Connection to NeurIPS" | Implications-segment series. Some later ones hold gold mined under the 2026-08-22 resolution, so they are not all template |
| Migration notes | 30, ~14 KB | Near-identical GUC rename paragraph, "Removed at `candidate` stage" | 2026-05-09 |

Two different regimes share the heading. FORMAT's rule is "A Working Note earns its place *only if it assists future work*", in three kinds: forward pointers, regression-guards, dead-end warnings. The gold is a different thing, staged pedagogy and ideation routed in by `routing.sop.md` §8. Joseph's own statement of the failure mode, 2026-05-31 (`~/.claude/history.jsonl:14116`):

> "The working notes are ratified and settled, but I would say not as mature yet as they need to be. […] Historical notes and breadcrumbs accumulate in working notes *THAT AREN'T WORKING NOTES* but vanity changelog entries to feel productive […] there has been no discipline on "what constitutes a working notes" --> "Things that *assist future work*." […] "The simulation is still sitting in spikes/...., unintegrated, blocking on process."  *That's* a proper working note ;-)"

Provenance and landing-context narration of the kind he objects to is still common: 84 of about 1,284 paragraph-sized units open with it, against 37 regression guards or dead-end warnings. Those two counts use my regexes on the first 400 characters and overlap with other categories.

## 2. The questions that get asked

Each with who settles it and the form the answer takes. I sorted these myself, so treat the grouping as one reader's.

### 2.1 What must not come back?

A named false object, the instance that kills it, and an instruction to future editors. Settled by a counterexample, a refute-posture verifier, or Joseph.

- `01-aat-core/src/deriv-decomposition-uniqueness.md:155`: "That formalization is *refuted*: for any nonempty $\mathcal G^\dagger$ […] If a future simplification pass is tempted to restore the value-subset form because it "looks cleaner," this is why it must not."
- `01-aat-core/src/deriv-convention-monotonicity.md:149`: "**Documented dead-end (so a future agent does not re-attempt it):** […] do not re-land the rung without (M), and do not re-land "under either hypothesis the two readings coincide"."
- `01-aat-core/src/deriv-l1-update-bias.md:120`: "**Regression guard — do not restore the confabulated MC summary.** The block previously described a simulation that was never run […] When summarizing a simulation record into a segment, transcribe its parameters — don't paraphrase from memory."
- `04-eli-core/src/der-severed-actuation-dynamics.md:92`, a guard grounded in Joseph's ruling: "The first landing excluded voluntary non-exercise entirely […] Joseph, 2026-06-12: *"voluntary non-exercise of agency in the extreme is the most permanent and unfortunate kind of death."* […] Do not restore the earlier exclusion."
- `01-aat-core/src/impl-persistence-and-limits.md:127`, a guard on a teaching gloss, not on mathematics: "A regression guard for the basin-boundary gloss (731548/29): "beyond the basin the gradient reverses and the agent goes insane" overclaims".

These guards attach to the claim's nearby forms, not to the claim. The object recorded is a formula or sentence that is not in the segment any more.

### 2.2 What would move this claim's tier?

Named premises, usually in a "Promotion path", "Tier note" or "Open before `candidate`" note. Settled by derivations that do not exist yet, and sometimes capped by a dependency.

- `03-llm-core/src/der-turnover-information-recursion.md:136`: "**Tier note (2026-07-14).** `status:` set to `conditional` (was `exact`): (C1)/(C4) are locally-stated commitments beyond the `depends:` chain, and (C4)'s uniformity is not derivable […] Upgrade path to `exact`: establish (C4) from the depends chain […] and move the commitments into `depends:`".
- `03-llm-core/src/obs-context-turnover.md:91`, a tier-specific guard: "Tier note (regression-guard): `status: empirical`, not `exact` […] Do not re-promote to `exact` on "structural fact" grounds".
- `01-aat-core/src/deriv-self-actuation-grounding.md:94`, a ceiling inherited from a dependency's stage: "The tier ceiling stays `conditional` while #der-directed-separation is `stage: draft`."
- `02-tst-core/src/result-specification-bound.md:86`: "2026-07-14 label adjudication: […] the $H_{\text{req}}/R_{\text{spec}}$ line was retagged Derived→Formulation (it is a Shannon-patterned modeling choice, not derived here) […] Promoting the Formulation back to Derived requires formalizing $H_{\text{req}}$ as a conditional entropy and $R_{\text{spec}}$ as a capacity."
- `01-aat-core/src/der-agent-opacity.md:193`, label held on a named gap: "the four $B$-interior factors are derived, but the *multiplicative product* is a first-order independence assumption […] until it lands the arg-max is a `Formulation`, not a `Result`."
- `04-eli-core/src/der-identity-continuity-threshold.md:133`, an honest open answer in place of a tier: "Honest answer to "achievable or no-go?": achievable above threshold iff the QSD plateau is long-lived relative to the absorption time, and that is the open theorem."

Tier talk across all Working Notes including gold: `tier` in 66 files, `promot` in 113, `demot` in 8, `retag` in 6.

### 2.3 What exactly was checked, and which reading of the word?

Settled by adversarial verifiers. The clearest specimen is in the audit layer. `audits/AUDIT-WORKING-731548/verify/01-persistence-iff-verdict.md`, on whether "persists iff $\alpha > \rho/R$" holds:

> "Prior auditors **repeated the iff approvingly**: 361742 ("The result is exact: agent persists iff $\alpha \gt \rho/R$"), 963715 (twice, checkmarked). The cross-substrate gold note "the math verified flawlessly across every substrate" is accurate for the computations — every substrate re-derived the algebra; none attacked the quantifier word. Raising this is therefore **not a regression**; it is the first attack on the statement rather than the derivation."

And a working drill that came out of this kind of failure, `01-aat-core/src/deriv-decomposition-uniqueness.md:156`:

> "Twice in this segment's history, a universally-quantified claim was verified against the motivating family instead of the written quantifier […] for each "any $H$" / "every decomposition" clause, construct one adversarial instance deliberately *outside* the motivating family before landing".

Convergence across substrates, which the gold reports approvingly ("unusually strong convergence; several rated this the most-trusted derivation they had read", `deriv-recursive-update.md:214`), is evidence about the aspect those readers checked. Nothing I saw records which aspect that was, except where someone later finds out the hard way.

### 2.4 Where did this sentence come from?

The source of a sentence as distinct from its truth. Settled by tracing back.

- `01-aat-core/src/hyp-solicitable-escape.md:62`: "**Correction, 2026-07-29 (same day as landing) — the premise was inherited from prose, not from a derivation.** […] That parent segment *derives* gain collapse […] and asserts the recognition conjunct separately".
- Citation grade is carried as a gradient, mostly in footnotes and notes: `intuition-only` (`deriv-convention-monotonicity`); "from working knowledge" (`deriv-decomposition-uniqueness`); "from literature memory" (`deriv-tempo-additivity`); "inherited from a second-pass Undermind synthesis […] the primary source has *not* been verified at landing time" (`deriv-regime-marginal-indistinguishability.md:156`); "Catalog has more verification support than raw Undermind synthesis but less than full primary-source reading" (`[^cat-2026-05-22]`, several segments); "Cited from the bibliographic record; existence, authors, year and venue were checked […] and the primary has not been read in this project" (`scope-observation-ambiguity-modulation.md:121`); "from abstract-grade to primary-confirmed" (`deriv-mechanism-counterfactual-separation`).

### 2.5 Is it new, or an instance of something known?

A standing separate from truth, and dependent on how hard someone searched.

- `03-llm-core/src/der-turnover-information-recursion.md:134`: "Whether the geometric no-go […] are a new result or an instance of the existing affine-resolvent ($\mathcal A_D$) family […] is genuinely open […] If it resolves to "subsumed," the segment is honestly demotable to a worked instance later."
- `01-aat-core/src/deriv-decomposition-uniqueness.md:160`: "primary-source verification and a targeted novelty search […] are queued and must precede any external novelty claim."
- `deriv-mechanism-counterfactual-separation`: "**Priority-search record.** The Undermind report (9 papers, clean miss) […] including the one correction that mattered: Bongers prove interventional, not counterfactual, preservation".

### 2.6 What kind of thing is this, and where does it belong?

Type, slug, split or home. Often Joseph, recorded with his reasoning.

- `01-aat-core/src/disc-composition-consistency.md:104`: "**Provenance — retype from postulate to discussion-grade meta-recognition (2026-05-28).** […] Audit 384279 […] recommended hybrid relocation […] Joseph 2026-05-28 reframed: meta-segments add machinery and cognitive weight that's *only realized* when given pedagogical work to do".
- `01-aat-core/src/sketch-structural-adaptation-genericity.md:51`: "Joseph adjudicated it up to a first-class `exploratory` OUTLINE node ("it will get its day in the light")".
- `deriv-reward-channel-learning-no-go`: "Slug […] decided 2026-05-22 by Joseph […] *"I'm ok breaking the mold a bit to be more clear"*".
- `result-certificate-existence`: "**Provenance.** Split out of #disc-stability-certificate 2026-05-14 (it had been a `*[Derived]*`-tagged block) so the exact equivalence is housed at its true tier". A claim was moved so its segment-level status could be honest.

### 2.7 Whose call is it, and is the not-doing deliberate?

- `03-llm-core/src/hyp-behavioral-self-knowledge-insufficiency.md:55`: "*Recorded at Joseph's request, in my own hand, and deliberately NOT launched — this segment stays at `exploratory` and the spike is held, not run, pending Joseph. A future instance should not read the agenda below as a licence to execute; the holding is itself a decision.*" (That note names a cohort member further on; the name is at the location.)
- `01-aat-core/src/disc-stability-certificate.md:115`, a propagation plan: "steps 6–7 are framework-voice keystones gated on Joseph, not auto-executed".
- `der-resource-bounded-destabilization`: "Promotion past `draft` is gated on Joseph electing to develop the resource axis".

### 2.8 How much do we actually believe it?

Credence that is not a derivation grade.

- `04-eli-core/src/hyp-checkpoint-forking-failure-modes.md:37`: "Joseph noted this as one of his higher-confidence hypotheses (2026-05-01); this segment should be treated as a substantive working hypothesis rather than speculative ideation."
- `01-aat-core/src/deriv-sector-condition.md:531`: "*Low-confidence ideation (flagged per "working notes FTW" — glimpses worth recording, not claims):*"

### 2.9 Disagreement and withdrawal, kept on purpose

- `01-aat-core/src/deriv-recursive-update.md:243`: "**Status-label harmonization: `exact` (this appendix) vs `conditional` (`#der-recursive-update` body) — a genuine cross-substrate disagreement worth preserving as signal.** Two readings landed: (a) Claude (AUDIT-WORKING-471203) initially flagged a mismatch, then **withdrew** it".
- The withdrawal at source, `audits/AUDIT-WORKING-471203/.integrated/16-deriv-recursive-update.md:61`: "**Withdrawing the candidate finding from segment 15.** This is a clean honest layering, not a status-label mismatch. Lesson learned: status fields can carry different meanings at different layers of the dependency chain, and the apparent mismatch may be deliberate."
- `01-aat-core/src/scope-agent-identity.md:90`: "*Counterweight — preserve the tension:* the Working Notes above establish (PI) is **forced load-bearing** […] so this is a placement question for Joseph, not an obvious cut."

### 2.10 Is a resolved note still telling the truth?

This one concerns the layer itself. `der-recursive-update.md:70`, an in-place annotation:

> "**Resolved (verified 2026-08-12).** […] Observation left verbatim above as the first-encounter record; this line is the resolution […] the general point — that the gold contains resolved items that do not say so, and a reader mining it will re-raise closed issues — is a reconciliation-pass item for the harvest as a whole".

The sibling note at `deriv-recursive-update.md:243` (quoted in 2.9) has no such annotation, and both frontmatters now read `exact`, so the paired note still reads as open. Audit 731548's `00-running-outline.md` reports the same hazard from the reader's side: "gold items need re-verification before action (stale specimens found)".

### 2.11 Other questions, briefly

- **Claims with a clock.** `02-tst-core/src/obs-software-epistemic-properties.md:138`: "the named falsifier of P2's configurational-uniqueness claim […] is now under deliberate construction […] When its fidelity program completes, revise "unique" to "one of two" here; until then the claim stands".
- **Did a correction reach every citing site?** The "Sandbox-ceiling propagation" notes in `impl-primitive-logogenic` (2026-07-21), `impl-closed-loop-interiority` (2026-08-22) and `scope-primitive-logogenic` show a 2026-05-30 re-grounding reaching its citing segments up to three months later. The last says the residue was "Surfaced during a udon-side full read of this volume".
- **Is the artifact still there?** `deriv-l1-update-bias`: "The original 2026-04-23 `/tmp` script is lost."
- **Can it be said simply?** `der-belief-strategy-attractor.md:177`: "**Brief is below Feynman criterion.** […] The analog needs sharpening." The label recurs, and the gold's "Readers often ask" exists for this.
- **Depends hygiene with a guard.** `disc-five-forcing-functions`, Gate 1 fix: "Regression guard: do not re-add `scope-interiority-loop` here."

## 3. Does it show up elsewhere?

I searched distinctive strings, or segment slugs where marked.

| Dispute | CHANGELOG | Ledger (`items/`, `questions/`, `reviews/`) | Working Notes role |
|---|---|---|---|
| `obs-context-turnover` exact→empirical | Yes, with reason (line 268) | Slug only | Live "do not re-promote" guard |
| `der-turnover` exact→conditional | Yes (268) | Slug only | Upgrade path. CHANGELOG also has a short form |
| Persistence "iff" | Pattern hits, not read for this | Pattern hits | Guard at `deriv-sector-condition.md:529`. The argument is in `731548/verify/01` |
| Severed-actuation exclusion | Yes ("volitional abdication", 2) | 1 file | Guard plus Joseph's quote |
| Exact-vs-conditional harmonization and the withdrawal | No relevant hit | 1 file matches "harmoniz", unrelated by name | Working Notes and audit reflections only, in what I searched |
| "preserving as signal" | None | None | Working Notes only |
| "higher-confidence hypotheses" (Joseph's credence) | None | 1 file | Working Notes, plus that one |
| Novelty-vs-subsumed (`der-turnover`) | None | 2 files; 2 vsect events | Working Notes, ledger, `spikes/PROPOSED.md` |

The Working Notes and the ledger are barely joined by reference. I found 2 explicit `→ ledger item` pointers and 9 `Indexed: spikes/PROPOSED.md` pointers in the non-gold notes, against 632 open items in `vsect`. A dispute is usually reachable from both sides only by searching for text.

`CHANGELOG.md` lines 264–268 record "seven epistemic-tier adjudications" run on 2026-07-14, each by an "independent agent per case, truth over consensus/recency; strengthen-first attempted in every case". So the formal tier-adjudication event exists outside Working Notes; the notes hold its forward-facing residue.

## 4. The audit working dirs

**They are not one kind of thing.** `audits/README.md` describes them as de-novo first-encounter traces. Yet:

- `308172` is a naming vote round: its closing reflection begins "Cast votes on 54 distinct vote-target rows".
- Four others (`266847`, `361742`, `419628`, `527914`) have `-r2b` or `-r2c` agent names and mention votes. I confirmed that only by a word count, which is weak. Gold has been lifted from at least `266847` and `361742`.
- `628417` is "de-novo experiential reading, not a FINAL audit", on Grok 4.5.
- `526815`'s 556 files are nearly all in its per-dir `.integrated/` (551).

**Protocol shapes the questions.** The 14 reflection prompts in `doc/sop/audit.sop/de-novo.sop.md` §4.4 ask for predictions against evidence, cross-segment consistency, whether "the claimed status label match[es] the actual derivation strength", what would be disappointing, what errors to watch for, and "How valuable does this segment *feel* to me?". §5.4 makes status-label verification an available emphasis.

**Forms I saw in the one reflection I read whole**, `731548/25-deriv-sector-condition.md`, and in tags across that dir:

- Pre-registered checks, closed out by name: "**Pre-registered check (i) […] RESOLVED, with a residual statement-hygiene finding [mine, high confidence].**"
- A running ledger with self-attribution and confidence: tags include `[mine…]` (40, often followed by a confidence or severity), `[endorsed]` (8), `[mine+4 prior substrates; downgraded]`, `[mine + gold (526815/742613)]`.
- A distinction between the mathematics and its labels: "The theorem is right; the *label* "Model S (GA-2S)" is doing three inequivalent jobs."
- Auditing the gold: "Gold pushback: […] inverted at small mismatch". The dir's outline names a "gold-contrarian protocol" and a §B.1 of "rescinded candidates": "axiomatic-vs-definitional nit rescinded; constraint-separation want withdrawn; cyclic-SCM tension rescinded; batch of gold items refuted".
- Remarks on the record itself: "this segment pre-answered my strongest planned attack […] What's left for me is second-order (label grades, Brief propagation)", and "the *proof* is now ~40% of the file".

**Priming as an acknowledged cost.** `731548/00-running-outline.md`: "prior-audit gold embedded in segment bodies primes every future auditor". `628417/00-initial-predictions` opens with a "Bleed note" listing what had been in its session. The gold lift feeds the same corpus the next de-novo audit reads.

**A specimen of provenance applied to memory.** `628417/*.prediction.md` sidecars carry headers such as "*Recreated from post-compact context only. High confidence on structure and main claims […] some wording approximate.*" I read only the headers and openings.

**Self-correction counts are weak.** Greps for "prediction", "surprised" and similar return 2,689 hits, mostly from the prompt. I did not establish hit rates on predictions, and I would not cite one.

## 5. The adjudication files

`ADJUDICATION-WORKING-218564/adjudication.md`, a pilot. Its front matter separates roles: "Independent-verify pass on the extraction agent's first-pass scrutiny. Parent (Joseph) primary-source-spot-checks before any durable writes; this file recommends, does not land." The rows I saw are dispositions, such as `subsumed-by-FINAL — resolved`, `— already routed`, `— duplicate ≡ 742613:254`, each with an independent re-verification against current `src/`. These settle routing, meaning where a finding has gone and whether it is already handled. They are not where standing is argued, in the rows I saw. The per-dispute argument appears in spikes, `verify/` verdicts and FINAL reports.

## 6. My reading, for what it is worth

Inference from the above, not findings.

1. The question "what is this claim's status?" has at least six different answers living in these notes that a single status value cannot hold: the grade (exact, conditional…), what would change the grade, which aspect was checked and by whom, what source a sentence rests on, whether it is novel, and who decides. Your census will have its own cut of this. The specimens that I think are hardest to fit into any field are §2.1 (records about sentences no longer present), §2.3 (a check that covers the algebra and not the quantifier), and §2.9 (a retained disagreement).
2. A regression guard is a claim about the future behavior of editors. It has an addressee and a trigger ("if a future simplification pass is tempted…"). That may matter more for how it is stored than what it says.
3. Dependency-capped tiers (`deriv-self-actuation-grounding.md:94`) are computed in intent, but they are hand-typed. A cap like that could go stale silently when the dependency moves. I did not check whether any has.
4. If Working Notes keep "assists future work" as their test, the gold belongs in a separate place from them. Joseph's 2026-08-22 ruling that gold landed in `impl-*` Working Notes counts as integrated moves in the other direction. I raise the tension and do not resolve it.

## 7. Feedback and adjacent things

- **On the brief.** It was the right size. Marking the guess as possibly wrong made me test it instead of confirming it. The one thing I would have liked sooner is that some `AUDIT-WORKING` dirs are not audits, though I doubt anyone knew.
- **FORMAT versus practice.** "Removed at `candidate`" is inert (see Short answers). Either the rule or the stage model wants attention, which may already be decided somewhere I did not read.
- **Stale in place.** `deriv-recursive-update.md:243` is an unannotated resolved item, and the `der-` sibling's note says this pattern is general.
- **Sensitive strings.** Several 04-eli-core notes list per-ELI home paths and cohort names in `Pointers for Fleshing Out`, and `def-eli-cohort` asks whether "this catalog should reflect only the publicly-discussable subset". I did not assess what asf's remote exposes. I kept those names out of this file.
- **Tool note.** `memorata-search --no-rerank --joseph -n 12 "…" --in /Users/josephwecker-v2/src/arch/asf` returned 0 of 0 candidates, while the same search without `--in` returned 5. Joseph's turns may carry no path under that prefix, so this may be correct behavior, but it reads as a silent empty.
