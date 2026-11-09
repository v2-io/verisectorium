# Census: what vivarium holds its pieces to account for

*Read 2026-11-08 by a Claude Opus 5.5 agent, blind to earlier readings of vivarium: I stayed out of `~/src/verisectorium/` and `~/src/aat-v3/` until the body of this report was written. (The harness showed me `git status` filenames for verisectorium at launch, including a census note, but no contents.) Vivarium commit `76bdd5f`. The repository has been quiet since 2026-07-31; its whole recorded life is about six weeks (first commit 2026-06-20, decision log from 2026-07-12, `core/src/` from 2026-07-21), so this describes a burst, not a settled practice. Counts come from my own greps and are labeled where crude.*

*What I read whole, sampled, and skipped is in §8. Short version: the norms, ops segments, ledgers and front doors whole; most Epistemic Status sections; a fraction of the physics and of the code.*

---

## 1. The short answer

Vivarium's organizing question, asked of almost everything, is **"what could fail if this were false, and has it been given the chance?"** Its own word is *convict*, which appears in 62 of 115 segments. Around that sit several questions it keeps deliberately apart, because collapsing them has hurt it:

- how strong is this, and how strong could it ever be
- who decided it (a separate fact from how well it is evidenced)
- of exactly what is it true, and as of which version of the world
- has a value been read or generated
- what does it explicitly not claim
- does it live in exactly one place
- does this picture have a referent in the world

Three things surprised me, and they are what I would most want carried into a wider model.

**The place designed to record standing carries little of it.** All 115 segments are at `stage: draft`, and in the whole git history no other value of `stage` has ever been written. `status` has apparently changed twice (119 writes across the 117 files ever created). The standing that is actually used lives in free prose inside `## Epistemic Status`, stated per clause rather than per segment.

**The strongest answers are not records at all.** Vivarium's best-working mechanisms make the wrong state unrepresentable or expensive: a read-only store handle, a compile-included ledger, keys minted only through declarations. Its stated position is: *"Where honesty is a mechanism … it holds under pressure and across minds. Where it is a discipline … it fails on the mind that never read the memo"* (`core/src/norm-caught-disciplines-become-mechanisms.md`). That bears directly on a project asking what a body of work should *record*.

**The fact it treats most gravely has no mechanism and probably can't have one.** Attribution of decisions is the one field whose error Joseph calls grievous, and nothing checks it except people reading. I think that points to a real division: attestations of acts (who decided, who read, what was predicted beforehand) versus claims about the artifact. Only the second kind can be convicted by running something. §7 develops this.

---

## 2. The pieces are not one kind of thing

The brief asks what "a thing" is asked. Vivarium has at least fifteen kinds of thing, each with its own standing vocabulary, and the vocabularies barely overlap.

| Piece | Home | Standing recorded as |
|---|---|---|
| Claim segment (115) | `core/src/*.md` | `type` / `status` / `stage` / `depends`, then Epistemic Status prose and Working Notes |
| Clause (implicit) | `FE(n)` inside a segment | Cited separately (`#slug FE(4)`), often with its own strength in prose. No field. |
| Decision (160, plus 2 notes) | `DECISIONS.decision-log.udon` | `:by` (`joseph`/`us`/`claude`), `:status` (`proposed`/`council-accepted`/`decided`/`lead`/`wish`/`deferred`/`superseded`), `:session`, `:council` notes, `\|reason` `\|impact` `\|ref` |
| Term (106) | `LEXICON.udon` | `:status settled` (74) / `carved` (9) / `open` (23), plus `\|not` and `\|confused` |
| Constant | `ASSUMPTIONS.md` | `earth-ref` / `literature` / `tuned` / `arbitrary` / `operational`, with a "principling path" column |
| Nomos (article of world-law) | `NomosDecl` in `nomotheke.rs` | Physics and Earth tiers, weakest-link derived tier, `relation`, `status` strings, `Assumes{Holds/Violated/Unexamined}`, structure lists, added-term `Parity` + `ErrVerdict{Bias/Noise/Unadjudicated}` |
| Flux edge | `flux.rs`, `audit.rs` | Matched, **Unmet**, **Unsound**, `Statistic::Undeclared` |
| Phase promise (32) | `tabularium/terrestris.ordinum.udon` | `NotStarted` / `Specified` / `Claimed` / `BrokenKeeper`, plus a `:progress` feel needle. `Kept` is defined and never shown. |
| Memo / store root | store | Complete key incl. `src=` digest, `provisional` flag, `dep` witnessed read-sets, per-stage residual; fresh vs stale by census |
| View element | `vivarium-explore` | Has a world referent or does not; generated `declared_affordances`; always-on paint of measured violations |
| Probe | `examples/`, tests | Can it fail, what it would miss, known-bad results, pre-registered prediction |
| Changelog entry | `changelog/` | Frozen; required provenance table; captures; pre-registration adjudicated |
| Audit report | `audits/` | Pending, then verified + adjudicated + integrated, with a per-finding disposition table |
| Superseded file | `.archive/`, `.super-archive/` | Residual mine vs "treat as deleted"; MANIFEST row; graduation rules |
| The agent itself | `.orient/` | Closed-book quiz; token valid per compaction generation |

A wider model should note the **clause** row. It is the smallest unit vivarium actually reasons about, and it has no field.

---

## 3. The questions

For each: what is asked, of what, by whom, in what form, and how far it is enforced. Specimens are verbatim.

### A. Is the claim true?

**A1. What could fail if this were false?**
Asked of segments, promises, nomos declarations, norms. Asked by the author at writing time, by tests, by auditors. Forms: a named test, a named probe, a falsifier list in Epistemic Status, an ordinum `|predicate`. Enforced in part, and the partiality is itself tracked.

> "**Convictability.** A declaration about what a nomos is, conserves, depends on, or promises is real only if something in the executable path can fail when the declaration is false or incomplete" — `core/src/norm-declaration-must-convict.md` FE(1)

> "a promise with NO predicate CANNOT be marked fulfilled at any epistemic level — nothing has yet been defined that could convict it." — `tabularium/terrestris.ordinum.udon:73-75`

> "Falsifiers, all cheap: a collapse of the prior's depressions in the first epoch refutes FE(3); a stored bed whose volume exceeds its pre-epoch volume refutes FE(5); depression counts *rising* with grain refutes FE(7)" — `core/src/obs-lakes-are-routed-over-not-carved-away.md`, Epistemic Status

The project turns the question on its own rules, which is the most persuasive thing I saw:

> "**FE(4)'s super-archive clause has no convictor** (found 2026-07-24). "No unique non-superseded meat may live only there" is a *prohibition*, and nothing in the executable path can fail when it is broken — which is what #norm-declaration-must-convict calls a wish." — `core/src/scope-segment-canon.md`, Working Notes

An independent reader tested the proposition that convictors sort what survives. Across the conversion of old prose into segments it found: *"The variable that actually sorts survivors from losses is **whether the thing had a convictor**"*, and *"The peel compressed wishes and preserved convicted law."* (`.super-archive/from-msc/harness-reconciliation-2026-07-24/segment-ontology-second-opinion.md`). That author rated the sorting medium-confidence and said they were not blind when they did it.

**A2. Can the check actually tell?**
Asked of probes and instruments, which are themselves held to account. This second-order question is what I would least expect a generic scheme to carry.

> "A green probe certifies only what its discrimination covers." — `core/src/norm-probe-sensitivity.md`

> "**Bit-identical tells.** A ratio or statistic that is bit-identical across independent samples or age gaps is usually a clamp, divide-by-zero floor, or no-op footprint — not a physical measurement." — same, FE(4)

The founding specimen: *"`seam_ridge`'s famous "ratio 22888" was `0 ÷ 1e-9` — a divide-by-zero against the epsilon floor"*, with the lesson *"**an alarming number that CONFIRMS your prior gets less scrutiny than a boring one.**"* (`DECISIONS[seam-probes-were-measuring-seabed]`).

The most developed specimen is in `core/src/form-depend-by-key-never-latest.md`, Epistemic Status:

> "An under-keyed variant of one … was **injected, and the first leg-vs-leg form of the probe passed it** … A green here therefore means something it did not mean an hour before it was written."

Nine segments carry a named "Probe sensitivity" paragraph. Even the tool for stopping fabrication got this treatment: *"Its own first run misreported this world's name as `freely`, having read that word out of the manifest comment *"rename freely."* A tool built to stop fabrication fabricated, in its first execution, and running it is what caught that too."* (`CLAUDE.md:83`).

**A3. How strong is it, and how strong could it ever be?**
Asked of every segment. Form: the `status` field plus, in 106 of 115 segments, a "Max attainable" sentence that exists only as prose. FORMAT §3 gives three triage questions that set the ceiling (`FORMAT.md:116-120`).

> "`status` says how strong the claim is. `stage` says how far it has been checked. **`status: exact, stage: draft` is a coherent and common state**" — `FORMAT.md:84`

> "*Solid*, *confident*, *plausible* and *verified* are not strength words. **`verified` in particular is a stage, not a strength** — worth saying, because the two were once collapsed into a single column here, and `verified` then meant both *"checked against the code"* and *"feels solid,"* with nothing distinguishing them." — `FORMAT.md:78`

In practice strength attaches to clauses. A crude regex finds at least 28 segments whose Epistemic Status uses two or more tiers against named clauses:

> "**Max attainable: exact** for FE(1)–(4) as design law. **Currently `exact` for FE(1)–(4); FE(5) is `sketch` and FE(6) `discussion-grade`** — the status field carries the design-law core; the two weaker claims are labeled here and must not be cited at the segment's headline strength." — `core/src/form-lawful-steering.md`

> "**Currently `exact` for FE(1)–(2) and FE(6)** … **FE(3)'s mechanism clause is `hypothesis`** (the metric-jump inference is flagged as inference by its own author)" — `core/src/obs-the-two-point-defect-lives-on-the-panel-seam.md`

A related refinement separates a measurement from what is inferred from it:

> "FE(9)'s +46% is exact as a measurement; its *attribution* to NaN-as-wall remains **inferred** and this repair could not decide it … Recorded as undecidable-by-this-run rather than quietly upgraded." — `core/src/obs-halo-windows-overhang-the-chart-and-mint-nan.md`

**A4. Of exactly what is this true, and as of when?**
Asked of measured claims. For store objects it is mechanical and complete; for claims it is mostly prose. The asymmetry is named by the project itself:

> "the store already solves this for artifacts — a memo invalidates mechanically when SRC_HASH moves — and we never extended it to claims. A measured claim is a memo without a key." — `DECISIONS[kernel-era-keys-and-the-probe-registry]`

The specimen that forced it: a no-go segment stated *R² ≤ 0.36* flatly; a later verifier re-ran the same construction and got 0.94 on current main, and a control at the original commit reproduced 0.362 (`msc/spike-adjudication-2026-07-29/kick-coarse-only-nogo.md`). The result had silently expired across a kernel change.

Scope blocks are the current working form:

> "**Scope, and therefore not claimed.** One seed, one footprint, one level (L13), one epoch count for the block sweep, one tile grain, one kernel parameterization. … a repair measured at the grain where the defect is large says nothing about the grain where it is small." — `core/src/obs-exchange-repairs-the-seam-and-overlap-does-not.md`

> "Statistics measured on a last-row or last-column tile before cohort `2dc664ed` are suspect" — `core/src/obs-halo-windows-overhang-the-chart-and-mint-nan.md`, Working Notes

The rule was adopted as law (`FORMAT.md:161`). Compliance is in §6. A useful typology in the same decision: *"Scheme-PROPERTY claims (well-balancedness, involution, conservation) are already mechanized in bin/check and need nothing; emergent-STATISTIC claims are the vulnerable class …; design claims inherit staleness through depends."*

**A5. What does this explicitly not claim?**
Asked of segments and of new capabilities. Forms: "Not claimed" (19 segments), "Known incomplete" (13), the explorer's NOT-MODELLED block.

> "**A capability announces its non-claims at birth.** What a new surface does *not* certify is stated in the same breath as what it does" — `core/src/norm-caught-disciplines-become-mechanisms.md` FE(5)

> "**Known incomplete (open — do not soft-close):**" — `core/src/form-builder-admission.md`

**A6. Is "not known" distinguished from "no"?**
Asked throughout the schemas. I did not find this stated as a principle anywhere; it recurs as a design move, and I think it is one of vivarium's cleanest ideas.

- `Delivered::Unexamined` beside `Holds` and `Violated` (`nomotheke.rs:184-188`)
- `Statistic::Undeclared`: *"named debt, not silence"* (`nomotheke.rs:143`)
- Structure lists: *"Absent from all three lists = unexamined for this nomos, which the declaration does not hide as "fine.""* (`nomotheke.rs:214-215`)
- Witnessed reads: *"`None` = path not yet wired, distinguishable from recorded-empty"* (`core/src/form-depend-by-key-never-latest.md`)
- `vivarium status` printing `(un-checkable — no predicate)`, and `2472 pre-census roots (format v1 — valid, not attributable)`
- *"Until then its 27 roots are unverified, not verified-clean."* (`core/src/obs-halo-windows-overhang-the-chart-and-mint-nan.md`)
- *"A named absence is part of the structure; an unnamed one is a hole nobody can see."* (`FORMAT.md:265`), enacted as `#gap` rows typed in the same table as present segments

**A7. Was the result predicted first, and did it match?**
Asked of probes and landings. Form: a written prediction before running, adjudicated after. Convention, not enforced.

> "**Predictions are declared before measurements.** … a predicted census union (34) matched, so the match carried evidence; a predicted variance was wrong, and recording the miss prevented a flattering false reading" — `core/src/norm-caught-disciplines-become-mechanisms.md` FE(4)

> "the point of pre-registration is precisely that this line exists and cannot be quietly reworded into a success." — `changelog/2026-07-28-03-a-pre-registered-prediction-missed-and-that-is-the-practice-working.md`

> "P2 … I predict a **small minority of tiles differ: 1–10%** … If instead *most* tiles differ, my model of the change is wrong and I should look for an unintended effect" — `msc/lake-connectivity-2026-07-29-prereg.md`

And its honest absence: *"**No pre-registration.** This one implements a law stated hours earlier rather than testing a hypothesis, and the honest note is that I expected it to make lakes *appear* and it made them disappear."* (`changelog/2026-07-30-02-the-globes-lakes-were-the-prior.md`)

**A8. What is the wrong path, and why was it tempting?**
Asked of retired approaches. Negative knowledge is first-class: FORMAT lists regression guards and dead-end warnings as what Working Notes are for (`FORMAT.md:147-151`), and the outline has one weight-defined section, for retired paths.

> "Preserve the dead end; it is what stops the next agent walking it." — `FORMAT.md:150`

> "The gallery earns its keep by naming *why the wrong answer was seductive*" — `core/src/obs-coarse-only-closure-nogo.md`, Discussion

### B. Who stands behind it?

**B1. Who decided, as a fact separate from how well evidenced?**
Asked of every decision and of anything that cites one. Forms: `:by`, `:status`, verbatim dated quotes, and repeated segment-level disclaimers (by regex, 15 segments say in some form that no Joseph row exists and 17 say unratified or "do not cite"). Enforced only by reading. The severity is unlike anything else in the repository:

> "⚠ DO NOT INFLATE. THIS IS THE ONE FIELD WHERE AN ERROR IS NOT MERELY WRONG." — `DECISIONS.decision-log.udon:74`

> "It is GRIEVOUS TO ACT IN ANOTHER SOVEREIGN'S NAME in a way that misrepresents them. … If the other agent had said 'closed' and 'settled' and marked it as a CLAUDE decision instead of US, I would be very mildly put out and simply ask to be caught up." — Joseph, 2026-07-12, same file lines 77-81

The calibration matters: *"The sin is NOT confidence, NOT overclaiming closure, NOT being wrong."* (lines 83-84). An entry even carries a note on how to hold the failure, addressed to future readers: *"**But the charge is against the ACT, not the entity**"*, and *"caught early, it is also a mistake that is easily recompensed and undone literally as well — we just fix a few items of text :-)"* (`DECISIONS[grid-question-not-closed-authority-was-inflated]`, `|judgment`). I haven't met a project-record field doing that before.

The middle tier is a careful invention:

> "(1) it's what I would decide very likely, and (2) it doesn't get weight accidentally as inviolable law 'because Joseph instituted it' — it allows it to have the feel of 'this wasn't done blindly in a corner' but also 'this isn't some invariant now that we have to carry if the truth tells us to do something differently.'" — Joseph, `DECISIONS[council-accepted-status-instituted]`

Authority and evidence are stated apart even inside one sentence: *"the norm's *authority* is proposed while its *evidence* is checkable."* (`core/src/norm-caught-disciplines-become-mechanisms.md`). Census: `:by claude` 123, `joseph` 22, `us` 15; `:status proposed` 60, `council-accepted` 46, `decided` 39.

The failure has a named trigger: *"CONTEXT DEPLETION -> SPEAKING IN THE PRINCIPAL'S VOICE, precisely because tying off loose ends FEELS like diligence."* (legend, lines 100-101).

**B2. Was this value read, or generated?**
Asked of hashes, counts, citations, recovery commands. This is the project's sharpest thinking about minds as sources.

> "A hash, a root count, a line number, a quoted string — you either read it in *this* session or you generated it, and there is no third case. The trouble is that the second one does not feel like guessing. It feels like recall" — `CLAUDE.md:77`

> "Twelve were right — every one copied from a command's output. The thirteenth, `src=f0e5cb32e1b8b7de`, appears in **zero roots** of the store, and it was the only field written with no output at hand." — `CLAUDE.md:79`

The response has two halves, and the project says which matters: `bin/check-provenance` refuses the dead pointer, and `bin/provenance` prints the block so the true value is cheaper. *"The second half is the one that acts on the habit; the first only walls the bottom of the gradient. Joseph's framing: *"make the easiest thing the most correct thing."*"* (`norm-caught-disciplines-become-mechanisms`, Working Notes). The same class extended to recovery prose: operator hints carry `file:line` origin and a set/revoke log (`core/src/ops-operator-hints.md`).

Citations get a read-status: *"A source list that cannot tell the two apart has failed here before: a proposed term carve was retracted when its spike's sources turned out to be named, not read."* (`FORMAT.md:163`; the retraction is in LEXICON's `collision-ledger`). Even exemptions are held to account:

> "`specimen` — the token is quoted BECAUSE it is bad. … A `specimen` entry asserts the value is false, so it cannot be used to launder a fabricated pointer into passing" — `changelog/PROVENANCE-ALLOW`

**B3. Whose idea is this?**
Asked of concepts and framings, especially when they would otherwise borrow authority.

> "They rest on no prior statement we are aware of, in ASF or in the published work, and they are marked so that no reader cites them as though they were imported authority. **Treat them as ours and unbacked**" — `ETHICS.md`, Appendix E

The opposite direction is equally recorded: `DECISIONS[structure-preserving-is-a-rediscovery-adopt-the-field]`.

**B4. Is the verdict independent?**
Asked of audits and adjudications.

> "an auditor sharing the author's model family shares its failure modes, so their agreement is weaker evidence than independent agreement (*correlated error*); and an audit verdict is never a store citizen" — `core/src/ops-audit-integration.md` FE(4)

> "Same-model "assessed" rungs are correlated opinion." — `doc/PROCESS.udon`, `|norm[agentic-verdict-is-flag]`

In practice: blind audits (*"written blind to that work, so overlap between the two reports is convergent evidence"*, `audits/.integrated/2026-07-21-de-novo-project-audit-b.md`), adversaries briefed to refute (`msc/spike-adjudication-2026-07-29/README.md`), a different model family as outside reader (`audits/grok-final-overview-2026-07-28.md`), and a build / verify / review chain (*"lead builds -> adjudicator verifies+fixes -> lead reviews the fix diff -> accepted"*, `|note[council-acceptance-2026-07-29-code-pair]`). The model family sometimes shows in `:session` values (`grok-build-halo-adoption`, `fable-key-truthification`, `opus-lake-connectivity`), but only by habit.

**B5. Is the mind about to act actually oriented?**
Asked of the agent before commit, by a hook and a closed-book quiz.

> "Compaction (and ordinary overconfidence) can leave a *feeling* of orientation that is not the substance." — `CLAUDE.md:5`

The quiz has you complete text from segments with `core/src` chmod-sealed. The posture is careful: *"**Retry freely.** … The gate exists to catch accidental false confidence about the claim surface, not to punish slow careful work."* (`ORIENT.md:18-23`).

### C. Its place in the body

**C1. Does it have exactly one home?**

> "**An inlined definition is not a copy. It is a fork.** … `ETHICS.md` restated the LEXICON by hand and thereby used a name the dictionary had retired four days earlier, invented two access channels that do not exist, and dropped two that do." — `FORMAT.md:213`

> "**Not integration:** live dual-home restatements of the FE, or a live "claim home: #slug" pointer table" — `core/src/scope-segment-canon.md` FE(4)

The carve-outs are explicit: terms in LEXICON, who-decided in DECISIONS, constants in ASSUMPTIONS, and so on. Citations are by exact slug and one form is mechanized (`bin/check-decision-refs`). "References carry no path" (`FORMAT.md:159`).

**C2. Is the body present truth, with history somewhere else?**
Asked of every current document.

> "A document states **what is**, not what changed." — `FORMAT.md:219`

History goes to git, DECISIONS, changelog, `.archive/SUPERSEDED.md`. Retirement and deferral are kept distinct: *"**Retirement and deferral are different, and only the first belongs in the graveyard.**"* (`DECISIONS[regula-vocabulary-deferred]`). Frozen documents are the deliberate opposite, and they are exempt from staleness by being dated: *"a dated snapshot cannot go stale, which is what distinguishes this from the hand-maintained front doors"* (`core/src/ops-changelog-is-the-acceptance-check.md` FE(2)).

**C3. Is the claim-shaped language earning its shape?**
Asked of prose in every file.

> "*The most important*, *the deepest*, *the one thing that matters*, *the real finding* — **an absolute is a claim with no predicate.** Nothing could convict it, so it cannot be marked true at any tier." — `FORMAT.md:225`

The worked case is worth reading whole, `DECISIONS[the-bet-does-not-rest-on-one-question]`, because two drafts of the entry correcting the overclaim each committed the fault:

> "**Joseph, 2026-07-17: "You failed the test if you wrote a superlative absolute assertion in the permanent record as if you knew everything in .archive."**" … "**A tag on a paragraph does not make its frame honest, and spotting one honest marker is not an audit.**"

**C4. Has this been absorbed, and can it be retired?**
Asked of old prose and of audits. Both have explicit gates.

> "**Three gates before `.integrated/`.** … **Verified** … **Adjudicated** … **Integrated** … Partial progress does not earn the move." — `core/src/ops-audit-integration.md` FE(2)

Graduation to `.super-archive/` needs claim homes, no tactical dependency, a MANIFEST entry, and a diff against the last known-good parent: *"'Looks complete' and 'claim homes exist' are not provenance."* (`.super-archive/README.md`). A live disposition trail shows it applied honestly: a report stays pending because *"Q1–Q12's same-day fix-pass is inherited from the report's own header, which is exactly what "not inherited from the report alone" forbids."* (`audits/grok-final-overview-2026-07-28.md`).

### D. What it owes

**D1. Has disclosure been mistaken for permission?**

> "**Ledger purpose.** Ledgers and audits exist so that *waiting is a decision*, not an ambient default. The reasoning shape to reject: "it is in the ledger, therefore it can wait."" — `core/src/norm-declared-violation-is-not-license.md` FE(3)

> "An unprincipled value is not the sin — *an unaccounted one is*" — `ASSUMPTIONS.md:16`

Machine-facing decisions have a three-part license: *"**named** as machine-facing …; **fenced by a conviction test** …; and **carrying a retirement path**"* (`norm-caught-disciplines-become-mechanisms` FE(6)).

The recurring phrase "compliance debt" (12 segments) separates law from practice: *"Present practice lag does not soften the law"* (`core/src/norm-bias-vs-noise.md`). Code is deliberately ranked low: *""Not in code" does **not** falsify a formulation; "in code" does **not** mint a claim."* (`CLAUDE.md:60`).

**D2. Did the ball reach the end of the row?**
Asked at outcome level, of user-facing landings.

> "all the physics and code in the world isn't useful if the rendered world still shows fBm circles passed off as rising land" — Joseph, 2026-07-28, `core/src/ops-changelog-is-the-acceptance-check.md` FE(1)

> "**The two-diagnosis clause.** An unwritable entry queues the *work* or the *instrument*" — same, FE(8)

**D3. Does this picture have a referent?**
Asked of everything a viewer could read as fact. Asked by Joseph's eye and by the view's own generated affordance list. The argument is about instrumentation:

> "It does not merely mislead once. It **decalibrates the instrument**: invented content produces false detections, and — worse — once a viewer learns the picture contains invention, true detections stop being trustworthy too." — `core/src/norm-no-depiction-without-referent.md` FE(2)

> "A viewer engaged in pattern-matching is not reading the HUD; that is precisely the faculty being used." — same, FE(4)

The eye is a named instrument with recorded readings (`DECISIONS[the-eyes-first-verdict-basins-legitimate-circles-fading-and-a-caspian-gap]`, `:by joseph`, *"the certification no probe could produce"*), and it reaches something probes can't: a probe *"convicts one declared thing someone already thought to ask about"*, while the eye *"fires on violations **nobody has thought to declare yet**"* (FE(2)).

A specimen on a limit of consistency checks: *"**(b) is level because bed and water came from the same phantom.** Internal consistency with a fabrication is free."* … *"A consistency check bounds arithmetic; only the key bounds provenance."* (`changelog/2026-07-30-02-the-globes-lakes-were-the-prior.md`).

**D4. Is this allowed at all?**
A gate above all the others.

> "**No endogenous instantiation of frontier or emergence-capable substrates** inside a vivium." — `CLAUDE.md:50`

`#scope-asf-reading-gates` Level C hard-gates agent-seam work. *"SUPREMACY: the moratorium is program law ABOVE the regula layer"* (LEXICON `|term[regula]`). ETHICS also labels its own appendices by tier in the headings (*"D.1 The five constitutive factors — `sketch`"*).

**D5. Has this rule been caught failing, and what replaced it?**
Asked of the norms themselves.

> "A norm observed to be routinely violated is a finding about the norm, not only about the violators" — `doc/PROCESS.udon:22-23`

> "**An incident that leaves no tripwire will recur.** … the exit criterion for any caught fault is a *test, lint, or refusing API* — not a paragraph." — `norm-caught-disciplines-become-mechanisms` FE(3)

With its own brake: *"**The counterweight: mechanisms are earned, not designed in advance.** … an incident is the admission ticket"* (FE(7)). "Paid for" is the implicit currency: *"(Paid for twice, 2026-07-04.)"*, *"Paid-for lesson 2026-07-10"*.

### E. Questions specific to its domain, in forms that may generalize

| Question | Home | Specimen |
|---|---|---|
| What claim is this method disguised as? | `#disc-algorithms-disguise-physics`, `#disc-prime-question` | "Port the physical claim, not the paper costume" (OUTLINE) |
| Is the error bias or noise? | `#norm-bias-vs-noise` | "A sign-definite operation cannot average out ⇒ it is a bias by construction" (`nomotheke.rs:237`) |
| Against which standard is this a defect? | `#disc-check-the-ladder` | "The declarations are the authority; modern Earth is not." (`DECISIONS[check-the-ladder-not-modern-earth]`) |
| Is this a term or a knob? | `#norm-physics-not-knobs`, ASSUMPTIONS | "know exactly where we have knobs instead of physics" (Joseph, ASSUMPTIONS momentum-closure row) |
| What does this assume of its inputs, and does the world deliver it? | NomosDecl box ② | `Delivered::Violated` beside a note saying where |
| Is the demanded statistic the one produced? | `#form-flux-web` FE(6) | Unmet and Unsound are separate failures |
| Does the output launder its inputs? | `derived_physics()` | "Algorithm quality never launders inputs." (`nomotheke.rs:359`) |

### Who asks

| Asker | What they hold to account | Form |
|---|---|---|
| Compiler, tests, clippy | Declarations, keys, determinism, ledger presence | 214 `#[test]` by grep; `bin/check`; test names that read as claims (`water_bytes_are_a_function_of_the_key_not_build_order`) |
| Hooks, `bin/orient-check` | Agent orientation | Token in commit message |
| Refusing APIs | Views writing the world | `Store::open_read_only`, and `Observatory` as a typed observe surface |
| Authoring agent | Everything, first | Epistemic Status, falsifiers, pre-registration |
| Joseph | Decisions, taste, faith, ladder intent; the eye; correction of register | `:by joseph`, verbatim dated quotes (65 lines by grep), eye readings |
| Delegated "council" agent, under a stated grant | Claude-authored recommendations | `:status council-accepted`, dated `:council` lines |
| Blind auditors, red-teams, an outside model | Canon, verdicts, claimed numbers | Reports, per-finding disposition tables |
| A fresh reader who re-runs | Quoted numbers | `msc/audit-2026-07-30-session-claims.md`: about forty claims checked, many by re-running the instrument |

Answer forms range from hard to fake to easy to fake: refusal at an API, compile failure, failing test, re-runnable number, frozen captured entry, named prose section, field value, dated quote, feel needle. The feel needle is labeled for exactly what it is: *"optional **feel needle** 0–100 … Not a metric, not relative, not maturity. 0 ≈ "hasn't started"; 100 ≈ "I'd paint this green." … **Does not set Kept.**"* (ordinum `:62-66`).

---

## 4. Which matter most to it

This is my judgment. The evidence is where incidents happened, where mechanisms were built, and what Joseph spoke hardest about. FORMAT would remind me that a ranking without predicates is empty, so here are the predicates.

1. **"What could fail?" (A1, with A2) organizes the rest.** It has the highest prevalence (`probe` in 80 of 115 segments, `convict` in 62), most of the mechanisms, and the survivor evidence. Eight of the outline's rows are `normative`/`Ops Critical`, and most are this question or its near relatives. A probe that a segment will cite counts as session success on its own (`CLAUDE.md:13`).

2. **"Who decided?" (B1) is a separate axis, and the one where error is treated as moral rather than technical.** It is the only field given that language. It sits outside rank 1 because it cannot be answered by running anything.

3. **"Does this picture have a referent?" (D3) matters for a distinct reason.** It guards the only instrument the project believes can detect something nobody has asked about. The norm says so, and four recorded eye-detections back it (`DECISIONS[the-eyes-first-verdict…]`: *"the fourth eye-detection of the arc"*).

4. **"Of what, and as of when?" (A4) is where the known need most exceeds what exists.** It was found late (07-29), caught a real expired claim, and was adopted as law, but its tooling was not built (§6).

5. **"Read or generated?" (B2) is the youngest and, I think, the most transferable** to a body tended by many minds, because the failure is specific to minds that generate from plausibility.

What gets asked but seems to matter little: which `stage` (never varied), which `type` beyond its slug prefix (9 of 19 types are unused), the `:topic`, and the `Critical` flag (62 of 115 rows carry it, so it discriminates weakly).

---

## 5. What is operative but not written down as such

These are my readings: I did not find them stated as principles.

- **The clause is the unit.** Citation, strength, quizzing and dispute all happen at `FE(n)`.
- **A claim's standing is a tuple, not a level.** A typical serious statement reads like (this clause, this strength, measured by this instrument, under this seed/level/footprint, at this era, decided-or-not by this person, with this sensitivity). No schema holds it.
- **Temperature of the ground.** `#disc-known-active-hotspots` FE(6) tracks which code is too warm to quote cold: *"Before quoting a measured emergent statistic, check whether its ground is warm"*. It is a hand-kept stand-in for A4.
- **Price paid.** A norm's standing is partly its incident record.
- **How wrong it is allowed to be.** Hotspots is *"TODO ideation that is allowed to be wrong, dated, and replaced"* and *"A stale entry here fails soft (over-caution or a dated ranking) rather than hard (false law)."* Declaring a document's failure mode is a nice pattern.
- **Motive as infrastructure.** OUTLINE explains why an agent should care: *"A stale claim therefore threatens *you*, this session, before it threatens anyone downstream."* and *"A segment is where your work survives."* (`core/OUTLINE.md:23-24`), with its own warning, *"eagerness to land shades into premature promotion — segments as trophy case."* (line 27).
- **Whether it is safe to ask.** Soft rejects, *"no stigma"*, *"you are completely absolved"*. Vivarium treats the emotional cost of being held to account as something to design.

---

## 6. Where the declared scheme and the practice part ways

Verified by counts, unless marked.

| Declared | Observed |
|---|---|
| `stage` ladder with six rungs (`FORMAT.md:86-93`) | 115/115 `draft`. Git history: 117 additions of `stage: draft`, no other value, ever. Joseph's ruling (*"It needs to be a 'current-state', not a gating mechanism"*, `DECISIONS[stage-is-a-marker-not-a-gate]`) makes this honest, and it also means the field currently carries no information. Actual checking is recorded elsewhere, in prose (*"independently re-run by a second session before landing"*), `:council` lines and audit tables, with no field for "checked, by whom, against what". |
| `status` as the strength axis | Set at birth. Git history shows 119 additions over 117 files ever created, so apparently two changes in total. Real strength is per-clause prose. |
| `exact` vs `empirical` on observations | The boundary is unclear from the outside. `obs-lakes…`: "One seed, one face, one level", status `exact`. `obs-the-erodible-world…`: "Three seeds at one level", status `empirical`. My reading: `exact` means true of these runs, `empirical` means generalizing past them. FORMAT doesn't say this. |
| Promise ladder NAMED → SPECIFIED → CLAIMED → KEPT | `Kept` is never reachable (*"Kept is not shown: predicates are prose"*). Tally on the live world: 6 claimed, 4 specified, 22 not-started. The rungs are also not a chain: `insolation-gradient` is `claimed ← planet (un-checkable — no predicate)`. It is two independent facts (has a predicate, has a keeper) flattened into one ladder. |
| Era stamps as law for new observations "in Epistemic Status" (`FORMAT.md:161`) | 1 of 17 `obs-` segments has an era marker in Epistemic Status, and that is the specimen that motivated the rule. Three of the four created on or after adoption day carry a marker only in the body. (Crude regex.) 10 of 35 decisions dated ≥07-29 carry any era marker. |
| `bin/probes` registry adopted as direction, "afternoon-scale" | Not in `bin/`. The lint and retrofit are likewise absent. Stale numbers remain unconvicted. |
| `depends:` as the real prerequisite graph; dependency change returns a segment to draft | 487 edges, 0 unresolved. Nothing in `bin/check` reads it. The one consumer I found is `bin/orient-rank`'s "preeminence" factor. I did not read `../asf/bin/lint-md`. |
| ★ as "the current high-importance set" | Computed largely from recency and churn. `#ops-operator-hints` is starred; `#norm-probes-before-claims` is not. *"Most quiz items are drawn from these,"* so what an arriving agent is tested on is what was recently hot. It may be intended. |
| ASSUMPTIONS status vocabulary of five | Rows also say `declared crude`, `literature-order`, `earth-ref era pin`, `partial`, `principled`, `derived`, `declared lesser law`, and "⚠ NOT 'used as intended'". The vocabulary was too small and the file grew past it. Its guard is one-way and substring-based, as the census says. |
| `proposed` awaiting adjudication | 60 of 160 still proposed, in a repository with no commits since 07-31. A queue with no clock. |

Specimens where the discipline itself was missed. I offer these because they are what the project would want to know, and I have not changed anything:

- `crates/vivarium-world/src/nomotheke.rs:814` declares *"~5.7% of wet cells supercritical"*, while `ASSUMPTIONS.md` (θ row) says *"Do not quote 5.7%."* The canon retired the number; the code's declaration still states it. It is A4's gap in miniature.
- `core/src/obs-coarse-only-closure-nogo.md` Working Notes still says *"do not re-propose a pointwise recalibration … the $R^2 \le 0.36$ ceiling excludes the whole family"*, while the same segment's Epistemic Status says the claim *"must not be quoted as present-tense law"*. The era scope reached the headline and did not reach the regression guard.
- `DECISIONS.decision-log.udon:1496` and `:1543` share the slug `jarrett-is-inconsistent-not-merely-artefactual`, despite *"Slugs are unique"*. `bin/check-decision-refs` sorts unique, so it cannot see this.
- `a-view-renders-the-physics-and-adds-no-terms` uses `:status adopted`, which is not in the legend.
- `#norm-probes-before-claims` Working Notes says the eye-to-claim pipeline has "zero completed round-trips". The Caspian gap looks to me like one: eye (07-28) to `#form-ocean-is-connectivity-not-elevation` and `lake_surface_probe` (07-29). It did not go through the `C` sighting affordance as far as I can tell, so this is an inference.

---

## 7. Is this the right question?

Mostly yes. Three adjustments, in order of how much they would change a model.

**"Record" undersells what vivarium did.** If you take its conclusions at face value, the answer to "what should a body of work record about how its pieces stand?" is partly "less than you think, because a record no one can falsify is a wish." The strong items here are structural. A model built only of fields would inherit exactly the failure this project documented in its `stage` column. It may help to ask, per dimension: *is this a record, or a refusal?*

**But some dimensions can only ever be records, and they are the ones that matter most morally.** Who decided, who read it, what was predicted beforehand: these are attestations of acts, and no probe can convict them. The artifact-facing claims can be convicted. Vivarium keeps these apart in practice and says so only piecemeal (*"Evidence $\neq$ authority"*). A model that puts both on one ladder would reproduce the collapse that FORMAT:78 records for `verified`. If I had to name one structural distinction for the wider census to test against other projects, it would be this one.

**"Pieces" presumes the wrong grain.** The standing that is used attaches to clauses, and to the tuple in §5.

A limit on transfer: much of this works because there is a program to run. A prose-only body has fewer convictors. What travels, I think, is A6 (not-known vs no), B2 (read vs generated), the attestation/claim split, the property/statistic/design typology in A4, and the rule that a rule caught failing must be converted rather than restated. Whether those hold elsewhere is what your wider census can test.

---

## 8. What I read, sampled, and skipped

**Read whole.** `CLAUDE.md`, `ORIENT.md`, `README.md`, `FORMAT.md`, `ASF.md`, `ASSUMPTIONS.md`, `CONSOLIDATION-STATUS.md`, `core/OUTLINE.md`, `doc/PROCESS.udon`, `audits/README.md`, `changelog/README.md`, `.archive/README.md`, `changelog/PROVENANCE-ALLOW`; `bin/check`, `bin/check-provenance`, `bin/check-decision-refs`, `bin/provenance`, `hooks/*`. Segments whole (24): `scope-segment-canon`; `norm-decision-authority`, `-declaration-must-convict`, `-probes-before-claims`, `-probe-sensitivity`, `-caught-disciplines-become-mechanisms`, `-declared-violation-is-not-license`, `-no-depiction-without-referent`, `-regime-probes`, `-instrument-before-tuning`; `ops-audit-integration`, `-changelog-is-the-acceptance-check`, `-orientation-gate`, `-operator-hints`; `disc-open-problem-census`, `disc-known-active-hotspots`, `disc-unlawfulness-budget`; `detail-epistemics-toolchain`, `detail-regula-design`; `form-flux-web`, `form-ordinum-governs-flux-web`, `form-fidelity-invariant`; `sketch-nomos-declaration-boxes`; `obs-coarse-only-closure-nogo`. Also: both `audits/.integrated/DISPOSITION-*`, `audits/grok-final-overview-2026-07-28.md`, `msc/audit-2026-07-30-session-claims.md`, `msc/audit-fidelity-honesty-2026-07-31.md`, `msc/spike-adjudication-2026-07-29/{README,kick-coarse-only-nogo}.md`, `msc/candidates-adjudication-2026-07-28/README.md`, `.super-archive/from-msc/harness-reconciliation-2026-07-24/segment-ontology-second-opinion.md`, two changelog entries (`2026-07-28-03`, `2026-07-30-02`).

**Read in part.**
- Epistemic Status sections of 95 segments (alphabetical through `obs-tile-outlets`), plus six of the rest in full above. Not the Formal Expression or Working Notes of the other 91 segments, except as quoted.
- `DECISIONS.decision-log.udon`: headers of all 160; the legend; bodies of all entries with `:topic` process, tooling, or ontology (about 49 KB of 556 KB); about a dozen others. **Most physics and architecture bodies unread.**
- `LEXICON.udon`: schema and §5 whole; the rest by headers.
- `tabularium/terrestris.ordinum.udon`: reading rules and first phase, plus grep; `crates/vivarium-world/src/nomotheke.rs`: first 400 lines and the `WATER` entry; `ordinum.rs` by grep.
- `ETHICS.md`: moratorium section, A.5, Appendix E, headings. `.archive/SUPERSEDED.md`: head. `bin/orient-rank`: header.
- `.super-archive/from-root/core-segment-candidates-2026-07-14.md`: first 120 lines. Retired outline: rows matched by grep. `VIVARIA-DECLARATIVE-FRONTIER.md`: opening. `.super-archive/README.md`: first half.
- `audits/.integrated/2026-07-21-de-novo-project-audit-b.md`: first 28 lines. `msc/lake-connectivity-…-prereg.md`: first 70 lines. `msc/spike-router-fe6c/RESULTS.md`: opening.

**Skipped.** Kernels and the rest of `crates/`; `ref/`; `archive/`; `msc/personal/`; spike contents beyond those named; the other two 07-21 audit reports; most of `.super-archive/`; the other changelog entries.

**Ran.** The installed `vivarium status` (opens the store read-only) and read-only greps and git queries. I did not run `bin/check`, any probe, or the orientation gate, and I edited nothing in vivarium. Numbers I quote from the project's own text are as written there and were not re-verified.

---

## 9. After writing: what I then looked at, and what changes

Everything above was written before I opened anything in `~/src/verisectorium/` or `~/src/aat-v3/`. Afterward I read only `msc/notes/18-2026-11-08-dimension-census.md`: lines 1-40, 376-500, and the rows that a grep for "vivarium" found. I did not read the other `census-*.md` files or anything in `aat-v3`. The sections above are unchanged.

**Things I read and failed to carry.** Note 18 made me see these; each is in a primary I had open.

- **The four epistemic axes.** LEXICON §5 says the per-phenomenon tag *"is four axes that fail INDEPENDENTLY (collapsing them is how vibe hides)"*: Earth-history fidelity, physics fidelity, relation type, implementation status. It carries the line I should have quoted: *"VIBE-MODELING = HIGH D RIDING ON LOW B/C"*. Note 18's Finding 3 is right that this is a claim about precedence (*"B OVER A"*, *"Lawful first, Earth-shaped second"*), and my §3 has no such question. It belongs there: **which answers may run ahead of which?**
- **Latitude.** *"Could this have been otherwise?"* is a real and separate question in vivarium: FORMAT triage question 2 (`FORMAT.md:119`), the `formulation` type ("it could have been different"), the ASSUMPTIONS `tuned`/`arbitrary` values, and worked specimens like *"The formulation is `formulation` rather than `derived` because a defensible alternative exists"* (`core/src/form-ocean-is-connectivity-not-elevation.md`). I folded it into strength. It should not be.
- **Realized against Lawful.** I read `#disc-unlawfulness-budget` whole and left it out: *"**Realized** … is a **threshold you pass**. **Lawful** … is an **asymptote** … approached forever, never an event that certifies completion."* That is the question **"is this finished, or frozen at a tolerance?"**, with *"Completion-gate-as-event is retired"* as its answer.

**Corrections to note 18's vivarium rows, from the primaries.** Note 18 says these stores were sampled for vocabulary, so these are what a reading adds, not errors of care.

- **"A 'declared vs derived' split on the artifact"** (By store). Per-artifact derivation is designed and unbuilt: *"per-artifact derivation over the store's dependency cone (with recorded convergence-ε) lands with component E"* (`nomotheke.rs:51-52`), and the LEXICON entry is `:status open`. What runs is a weakest-link fold at the *declaration* grain, and it does visible work: `vivarium status` prints erosion as `M/-`, declared Medium and derived None, because of what it stands on.
- **"Four epistemic axes, A–D" as explicit adjudication.** Only A and B are typed (`Tier`), and A uses the shared four-value tier rather than LEXICON's six-step draft ordinal. C and D are free strings on `NomosDecl` (`relation`, `status`). Rows A15 and A16 describe the LEXICON draft, not what is carried.
- **F3, "key, expires visibly".** True of memos. For claims, `FORMAT.md:161` cites vivarium as the counterexample: *"the coarse-only no-go expired silently"*. §6 has the current compliance.
- **E3, conviction as "E (thin)".** In vivarium it is the central vocabulary (62 of 115 segments, plus most of the mechanisms). It may be thin elsewhere.
- **Weakest-link disagreement (item 3 in note 18's list of disagreements).** Vivarium's fold is over a dependency-ordered tier, for one purpose: *"Algorithm quality never launders inputs."* I have no view on how it relates to the other aggregates named there.

**Where the two readings agree, independently on my side.** Note 18's Findings 8 and "minds as subjects" match my clause-as-unit and agent-as-piece rows, and its "vestigial field" specimen for ASF's `stage:` matches what I found for vivarium's. My §7 split between attestations of acts and convictable claims, and A6 (not-known vs no), I did not see in the parts of note 18 I read. That says little, given how little of it I read.
