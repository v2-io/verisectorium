# What tools and papers have held their pieces to account for

*A reading of the hand-grown accounting in the estate's non-theory projects, written 2026-11-08 by an Opus 5.5 subagent at Joseph's request through the coordinating agent. First reader: the coordinator, folding this into a wider census. Second reader: Joseph, cold, looking for specimens. Everything under "What changed after I looked" was written after the rest and is the only part made with sight of `verisectorium/` or `aat-v3/`.*

*Paths are relative to `~/src/` unless they start with `~`. Quotes are verbatim. `[…]` marks my elision. Where I give a line number it is from the file as it stood today.*

## 0. What I read, what I did not, and what I kept out of this file

**Read whole.**

- limen: `VERDICTS.md`, `DEBTS.md`, `CLAUDE.md`, `PIPELINE.md`, `DIRECTION.md`, `RECOMMENDATIONS.md`, `README.md`, `inbox.md`, `impl/gt1-gate-speed.md`, `impl/kf1-kdl-frontmatter.md`.
- relata: `CLAUDE.md`, `BETTER-DATA-AND-CALIBRATION-TODO.md`, `docs/sessions/README.md`, `docs/sessions/2026-08-24.md`, `docs/sys/{evidence-ledger,verification-event,calibration-event,entry}.md`, `lib/relata/status_report.rb`.
- logos: `CLAUDE.md`, `refs/README.md`, `03-…/PROMISES.md`, `03-…/LOG.md`, `03-…/FEEDBACK.md`, `03-…/planning/signoff.md`, `01-…/SUBMISSION.md`, and in `04-…`: `FEEDBACK.md`, `feedback-fresh-read-2026-07-04.md`, `SEAM.md`, `prep-work/SIGNOFF-2026-05-29.md`, `scratch/verification-anchors-2026-05-31.md`, `scratch/contributions-log-2026-05-31.md`.
- neurips: `AGENTS.md`, `03-…/RC1-QUESTIONS.md`, `reviews/processing-flow.md`, `adjudicated-common/{OUTLINE,truthification-methodology,asf-backport-queue,voice-and-tactics,char-counts}.md`.
- ops: `CLAUDE.md`, `STATUS.md`, `papers/{README,SUBMISSIONS,format}.md` (private; see below).
- practica: `CLAUDE.md`, `docs/02-normative/{03-content-discipline,04-diagnostic-surfaces,05-failure-mode-defaults}.md`.

**Sampled** (a first screen, or by search; none of these should be taken as read).

- `relata/TODO-ingest.md` (5,018 lines): North Star through §2, §7.1–§7.10's opening, §16.29, §16.31, and all headings. The §11 decisions log and most of §16 went unread.
- relata's live data tree at `~/.local/share/relata/`: I counted all 443 verification events and all 74 calibration events, read the opening of all 33 `claim-supported` notes, and looked at a few entries and PDF-attempt records. I ran `relata show` and `relata lint`.
- limen: `spikes/audit-de-novo-2026-10-08.md` (§1–§5 of it), `design/harness.md` (first 60 lines).
- logos: `04-…/revision-dossier-2026-07-09.md` (first 110 of 269 lines), `01-…/FEEDBACK.md` (first 80 of 303), `LOG.md`, `04-…/OUT.*.md`, `04-…/prep-work/matrix.md`, `03-…/ARGUMENT-DIAGRAM.md`.
- neurips: `WATERFALL.md`, top of `LOG.md` and `01-…/LOG.md`, `03-…/TODO.md` (first 180 of 498 lines), `01-…/adjudicated/{OUTLINE,residue}.md`, one claim segment, `01-…/response-prep/{README,ISSUES}.md`, `spikes/occupancy-weighted-tv-regret/PARENT-VERIFICATION.md`, one citation audit, `common/checklist.tex`, `AUTHORING.md` (headings and §3.5–§3.7), the first lines of `adjudicated-common/reviewer-relationship-ledger.md`.
- ops: the frontmatter of one paper dossier, the convention lines of `FUNDING.md`, `VENUES.md`, `publications-log.md`, `outreach-log.md`, `papers/_legacy/crosswalk.md`.
- Beyond your list, for the same question: `causal-language/{EPISTEMIC,OPEN-WORK,HEADLINE-FINDINGS}.md`, `behavioral-floor/TODO.md`, `embeddings/{TODO,CLAUDE}.md`, `ai-risk-model/CLAUDE.md` and the header of `bin/check-quote`, `arch/vivarium/{ORIENT,ASSUMPTIONS,CONSOLIDATION-STATUS}.md` and the header of `DECISIONS.decision-log.udon`, `arch/firmatum/udon/CONSUMERS.md`, `arch/firmatum/utils/md-press/{STATUS,FEEDBACK-2026-10-30}.md`, `arch/firmatum/utils/aspectus/{PRACTICA,FEATURE-PIPELINE,inbox}.md`, `arch/firmatum/utils/project-heat/TAXONOMY-PLAN.md` and `projects -h`, a few `.practica` files, `nightfox.nvim/exemplars/VERDICTS.md`, and practica's `docs/02-normative.md`, `msc/operata-study.md`.

**Skipped.**

- `verisectorium/` and `aat-v3/`, as you asked, until this report was written.
- asf itself. It is the theory case and I took it to be someone else's reading; I know it only through what these projects say about it.
- `neurips/reviews/**` other than `processing-flow.md`, including every review and rebuttal draft. They are confidential. That means I did not read `TRUTHIFIED.md`, which several files I read treat as a key artifact.
- ops' relationship and funding dossiers, `PROFILE.md`, the fellowship and digital-minds directories, the LinkedIn archive.
- limen's `design/*` beyond `harness.md`, most of `impl/`, the other five de novo audits, `exemplars/`.
- logos' essays, draft guides, `STRATEGY.md`, the ACA companion documents.
- practica's `01-theory.md` body and its two long papers. relata's `IMPORT-ASF-TODO.md`, `FEATURE-REQUESTS.md`, and its code beyond the files above.
- The rest of the estate: `memorata`, `rowan`, `_core`, `arch/msc/councils`, and others.

**What I kept out, since this file sits in a public repository.**

- ops is private. I quote only its format conventions and describe the rest. Its relationship, funding and outcome content is not here.
- limen and relata are private repositories too. I chose quotes about project practice that carry nothing personal. If you'd rather those be paraphrased as well, say so and I'll redo them.
- Named-instance traces in logos (`SEAM.md`, `planning/signoff.md`, `prep-work/SIGNOFF-2026-05-29.md`) are described, not quoted, and session names of instances are elided from quotes.
- Paper 4 is, as far as `ops/papers/SUBMISSIONS.md` shows, still under double-blind review. I read one of its segments to see the form of what it does, and I quote none of its prose. Where a working note names what the paper cites, I elided the subject matter.
- No reviewer text, handles or scores are quoted. One private local project's decision vocabulary is quoted without its name; the path is in my reply to the coordinator.

**A caveat about independence.** These are not independent specimens. Almost all are one person's practice, carried by the same class of models, sharing memory files. limen's pipeline says it is "Modeled on the aspectus / verisectorium pattern". logos borrowed its refs machinery from neurips, and relata carries the same layout (its `verify` usage string, `exe/relata:647`, still says `refs`). The private project's decision ledger says it was "Adopted as shipped with the verisectorium template". So where two projects agree, the agreement is weak evidence that the idea is forced. I've tried to note where a practice arrived independently of the others (the clearest case is operata, per `arch/firmatum/practica/msc/operata-study.md`).

## 1. The short version

**"Is this true?" is one question among about sixteen, and rarely the one that hurt.** What these projects keep asking of a piece is mostly about the record around it: who actually opened the source, whether the check could have failed, what silence means here, what rests on this, what is owed and to whom, whether the person who has to read this can find it. §2 collects them, with specimens.

**Many of the things being held to account are not pieces.** They are relations and acts:

- a citation in one paper for one claim, as opposed to the cited work;
- a promise from a text to a companion text that may never exist;
- a verdict about one build in one browser engine as felt by one person;
- a weight, a constant, a decision;
- a check, whose own standing is at issue;
- the mind about to edit, which vivarium quizzes before it may commit.

If the model's subject is "a piece of the body", a large part of this practice will have nowhere to live. §5 gives the specific place this already fails.

**Tools, papers and registers differ most in what stands in for truth and who is able to answer.** A tool can be re-run, so its standing is cheap to recompute and short-lived, and the scarce commodity is a human's report of how it feels. A paper is frozen, addressed to a stranger, and judged once by an institution, so a true, proved, included result can still fail to stand because the reader did not find it. A register of outside facts decays by the calendar with nothing upstream changing. §3.

**The effort goes where the checking is cheap.** relata has 259 `bib-fields` events and 1 `page-ref` event. Its own North Star says the point is "what each work is and what it supports", yet its roll-up status does not include `claim-supported`. §4 ranks what I think matters most, by what it has cost these projects.

## 2. The questions, with specimens

Each entry gives who asks, what form the answer takes, and specimens. Grouping and naming are mine.

### A. Contact with something outside the text

#### A1. Does it say what its source says, for this use?

*Asked by citation verifiers, audit agents, lint, and a quote checker. Answered in per-event files, page pins, quotes beside claims, status enums.*

relata's vocabulary, the most formal in the estate (`arch/firmatum/relata/docs/sys/verification-event.md`; identical in `arch/logos/refs/README.md`):

> "bib-fields" => "Authors / year / title / venue match the published record."  
> "doi-resolves" => "DOI resolves to the cited paper (not redirected, not 404)."  
> "claim-supported" => "The cited paper's text actually supports the claim it's used for."  
> "page-ref" => "Specific page / section reference is correct."  
> "anonymization" => "Citing this entry does not violate anonymization (deny-list clean)."  
> "no-self-cite" => "Entry is not a self-citation (does not appear on the self-cite deny-list)."

A real sequence on one work, where what changed was the citing paper and not the cited one (`~/.local/share/relata/verifications/pearl-2009-causality/`):

> 20260507T084709Z, audit-2026-05-07, claim-supported, **uncertain**: "Citation 'Pearl 2009 Theorem 3.4.1, Rule 2 — action/observation exchange' is imprecise […] Substantive identification still holds"  
> 20260507T090428Z, claude-opus-4-7, claim-supported, **verified**: "Post-fix: B-CS1 §B line 94 cite-target retargeted from 'Theorem 3.4.1 Rule 2' to 'Theorem 3.3.2 back-door criterion' (commit 6b4f815). Cite now matches the d-separation graph G_overline(a_t) used in the proof."

The strongest mechanical form is in `ai-risk-model/bin/check-quote`, whose status vocabulary I would hold up as a specimen on its own:

> Statuses: ok, unconfirmed (found once in the canonical text, but the PDF check it needed found no match, so the page rests on the canonical text alone), not-found, near-miss (no match, but a passage at least 80% alike: a changed word, or paraphrase presented as quotation; the record gives it), ambiguous, page-mismatch, not-in-pdf, no-text […]. Separately, `exact` says whether the quote matches the text character for character

Its project states the discipline (`ai-risk-model/CLAUDE.md`):

> **Fidelity.** Every claim is anchored to a verbatim passage with its location, so any reader can check exactly what is being claimed. Our reading of a source is always attributed as ours, and kept beside the source's words, never in place of them.

logos decides how deeply to check by how the citation is being used (`arch/logos/04-…/scratch/verification-anchors-2026-05-31.md`, subject matter elided):

> The **heart's rivals** (the contested philosophical ground […]) are VERIFIED. The paper's hardest engagements […] stand on read sources.  
> The **shoulders** ([…]) are the debt. These are *cited as precedent the limb stands on*, not contested — so the exposure is lower

#### A2. Did someone actually open it?

*Asked by coordinators of the agents below them, and by Joseph. Answered in provenance tags, separate logs of what was not checked, and verification tiers.*

This is the most distinctive question in the estate. neurips states that it is a separate axis (`neurips/adjudicated-common/truthification-methodology.md:16–19`):

> **Separate axes, always:**
> - **Rung** — [PROVED] / [TESTED] / [HYPOTHESIS] / [SKETCH]
> - **Provenance** — who opened what ([first-hand] / [recon] / [unverified])
> - **Residue** — refuted formulations kept as do-not-use, never silent delete

The best specimen I found (`neurips/spikes/occupancy-weighted-tv-regret/PARENT-VERIFICATION.md`):

> *What the parent (main-session agent) checked first-hand, 2026-07-29, as distinct from what the spike agent or its recon sub-agent read. Written because `report.md` makes strong claims about a defect in a submitted paper, and the difference between "an agent said so" and "verified" has to survive into the record.*

and from its list headed "NOT verified by the parent — treat as the agent's read":

> Domingues et al. Theorem 9 / Eq. (8) — **§3c, verified by nobody**, composition assembled by the recon agent and explicitly disowned by the spike. Do not cite without opening arXiv:2010.03531.  
> Foster/Krishnamurthy et al. 2407.15007 Theorem 2.1 and its TV remark — **opened by a scout, read by neither** `[unverified-by-either]`

A reconciliation where two records disagreed about who had read something (`neurips/adjudicated-common/asf-backport-queue.md` §6):

> **Reconciled form (2026-08-02):** opened **only by the July recon peer**; **unverified by the verification chain**.  
> […] do not upgrade to chain-verified by silence.

ops has it as a required convention (`ops/FUNDING.md`, funder names elided):

> Funding facts decay fast and are acted on directly, so each load-bearing claim below is tagged **[verified — primary]** (read at the funder's own page today), **[verified — secondary]** ([…] aggregator), or **[unverified]** (could not confirm — flagged, never guessed). […] **Before relying on any dollar figure or email, click the cited URL and eyeball the live page.**

And in `ops/papers/format.md`:

> If you're working from agent-reported content rather than direct file reads, mark it explicitly in the body (e.g., "Substrate verified by file existence; content read by exploration agent only").

The reasoning, from `neurips/AGENTS.md` §3.5:

> Agent reports say what they *intended* to do, not always what they *did* do.

> When asked for an audit or review, the agent's summary *is* the comprehension — there's no other ground truth to spot-check against.

Note how far this goes past "verified or not". Reading depth has grades: `bib confirmed + full texts interned` is distinct from `claim-supported at primary source with verbatim quotes` (`arch/logos/04-…/FEEDBACK.md`), and a later entry there says: "*Not in [the instance's] artifact — status unconfirmed, do not assume verified*".

#### A3. How was this number got?

*Asked by whoever must rely on it next. Answered in measurement conditions, counts, frozen sets, status vocabularies.*

`arch/firmatum/relata/BETTER-DATA-AND-CALIBRATION-TODO.md` §1 and §4:

> The §16.31/§16.33 values were measured from the corpus and then **hand-typed into a Ruby constant, with the counts recorded in prose comments.** That prose is the entire provenance chain. A future agent cannot re-derive them, cannot verify them, and cannot tell whether the corpus has drifted since. That is not a calibration system; it is a calibration *anecdote*.

> All Laplace-smoothed; counts shown because a number without its `n` is an opinion.

A number's standing can depend on when it was seen relative to when the instrument froze (`arch/firmatum/utils/md-press/STATUS.md`, 0.3.0):

> Held-out set D (400 sites selected with frozen v3; v4 froze before any D label existed; the only clean held-out set). […] Every batch was labeled twice, independently, by Opus agents, not people. […] v7, the version integrated here, gets 85.0% and 4.5% on D. It was built after D was seen, so that is not held out.

The difference between a measurement and a reading, in a defect row (`limen/DEBTS.md`, PR-1):

> The likely cost is each changed row's render, done once for the splice and again for the structure patch (math-dense prose, KaTeX), but that is a reading, not a measurement.

vivarium has a status vocabulary for every constant the world runs on, and a test holding the ledger to the code (`arch/vivarium/ASSUMPTIONS.md`):

> **Status vocabulary:** `earth-ref` (taken from measured Earth — principled *by reference*, jettisonable for non-Earth worlds) · `literature` (a published model/value used as intended) · `tuned` (chosen to look/behave right; documented reasoning, no process) · `arbitrary` (a placeholder someone had to pick) · `operational` (affects builds/views, never world-law — listed only when confusable).

> **The rule.** No numeric constant enters a nomos without an entry here (or a doc-comment pointing here). An unprincipled value is not the sin — *an unaccounted one is*

A closing note worth keeping, from `relata/TODO-ingest.md` §16.31:

> The most dangerous thing in this session was not the bug that shipped — it was the bug that felt **principled**. […] **When you find yourself choosing a number, stop and ask what would measure it.** The data is usually already in the repository, and it does not care how confident you are.

#### A4. Has someone felt it, in the thing actually used?

*Asked by the builder of the one person who can answer. Answered in a verdict stream, an "owed" list, and tags in the text. No agent can answer it.*

limen's contract (`limen/VERDICTS.md:3`):

> he points out things that seem off, or confirms things that work, as he finds them, one message at a time — an observation is NOT necessarily "go fix this now"; intermediate time may be used to investigate, but the intent is simply to pass them along. Log every one here with its resolution state.

The state column is the specimen. It records what has been seen and by whom, and it splits a single row into parts (`limen/VERDICTS.md`):

> raise: confirmed · page follow: B2 · swap: noted  
> math: positive · clipping: fixed 2026-09-26 […]. His eyes pending.  
> landed; dark pending his eyes  
> fixed; his hands pending  
> awaiting his eyes  
> confirmed 2026-11-05 ("Looks great! Perfect.")

The check is indexed to an instrument, and the instruments are not interchangeable (VERDICTS #10):

> Checked in headless Chrome at 1500 px on a copy of his table and a wide aligned one; the Tauri window (WebKit) is his to see.

and from `limen/design/harness.md`:

> Every live suite and the shooters drive Chrome, but the app Joseph uses is Tauri on macOS, which is WebKit (WKWebView). Until today nothing looked at the page in WebKit.

Attribution is kept even inside the human channel (VERDICTS #16): "(builder's note, not Joseph's words)".

The same question in a philosophy paper takes a different form: the human has to attest that an agent's sentence is true of him. `arch/logos/04-…/scratch/contributions-log-2026-05-31.md`:

> Each NEW gem marked verified / my-synthesis / beautiful-attest-or-retire.

There are 26 `[?JW]` tags across that paper's `src/` and `scratch/`, beside `[GAP]`, `[CE]`, `[exp]`, `[struct]` and `[ed]`.

In relata the same human word is only evidence (`TODO-ingest.md` §7.4):

> **attestation** — operator asserts identity (`--is …`). A casual claim is moderate **+** `woe` ("pretty good") […]. But it is *evidence, not override*: an attestation contradicted by a strong extracted identifier nets to escalate-and-ask (Stage G), never silently encodes a human error as ground truth.

So in limen the human's report is final (it is about how the thing feels to him), in logos it decides whether a sentence may stay, and in relata it is a weighted input. One field called "human confirmed" would not hold all three.

### B. The standing of the record itself

#### B1. Could this check have failed?

*Asked by audits, usually after the fact. Answered in mutation runs, gates that test themselves, and post-mortems.*

`limen/design/harness.md`:

> **Correction, same evening.** The de novo audit […] found the green above was partly on credit: `parity/run.sh` filtered `cargo build` through a grep, and the system linker was in fact broken […], so the suites had been running against the cached binary from 2026-08-29. Two D1 checks passed unconditionally.

`limen/VERDICTS.md` #4 and #33:

> `animate` has never actually animated; it read as `instant` because it was.

> the animated area's height was set (320 px) but drawn at 4 px — no animation frames ran, both transitions sat at time 0 — and the Chrome test had checked the model, not the drawing.

limen's answer (`limen/CLAUDE.md:34`, and 25 of 63 impl notes mention mutation):

> **A design invariant becomes an assertion when its row lands.** The specimen is D2's parity suite, which greps the Rust source to assert no viewport-sync path exists. The counter-specimen is ledger F7: the viewport design said "buffer-local mappings," the code made them global, two impl notes repeated the design, and it sat three weeks until a cold reader compared the sentence to the Lua.

`limen/impl/gt1-gate-speed.md`, on the gate that decides what "green" means:

> **`harness/test-gate.js`, in `pure`,** holds the runner to those promises over fake suites, and fails if a test file in the tree is not in the gate, which is what a hand-kept list otherwise loses over time.

A claim about a run is itself policed (`limen/CLAUDE.md:25`):

> A commit body says which suites it ran, and claims the full gate only if it was run and its verdict read.

In a research setting the point lands as an instrument property (`neurips/adjudicated-common/truthification-methodology.md`):

> When a comparison is byte-identical under random fallback, the instrument priced the difference at zero — report that as **instrument property**, not empirical finding.

And vivarium says plainly which of its checks bite (`arch/vivarium/ASSUMPTIONS.md`):

> That guard is one of the few things in the repo that actually convicts

The same concern, applied to discipline instead of to code (from a private project's `ORIENT.md`):

> So: **a `.scratch/` directory with files in it is not evidence the discipline held.** If you are checking your own work (or someone else's), look for predictions in front of the *last* reads, not the first.

A failed check that speaks with authority is worse than none (`relata/TODO-ingest.md` §16.29):

> when a system cannot distinguish "I looked and it isn't there" from "I never looked," it will eventually report the second as the first. It will do so in confident, well-formed prose, in exactly the artifact a human trusts most. Guard the failure vocabulary as carefully as the success path: **a plausible false reason is worse than no reason, because it is believed.**

#### B2. What does silence mean here?

*This question recurs in nearly every project, each time reinvented. I think it matters more than the count of its occurrences suggests.*

- `relata/TODO-ingest.md` §7.3: "**Absence is never refutation** (no DOI extracted ≠ DOI refutes); only a positively-extracted *conflicting* strong identifier is."
- `relata/docs/sys/entry.md`, on one field: "`pdf_acquisition_status:` is OPTIONAL (absence = "the fetcher has not touched this entry", semantically distinct from "unattempted" which means "we have looked at it and recorded that it has nothing to try yet")."
- `arch/firmatum/utils/project-heat/TAXONOMY-PLAN.md`: "`undeclared` is the non-frozen default (Joseph 2026-09-01) — the field is present and honest about not having been decided, distinct from a decided value."
- `limen/DEBTS.md`, M2: "the fuzz oracle cannot see this one either […] so it is reported as a blind spot, not agreement".
- `limen/spikes/audit-de-novo-2026-10-08.md`: "Read this report's finding list, not its silence, as its content".
- `arch/logos/philosophy-papers-feedback.md`: "every "I know of no precedent" below is a from-below claim about a literature I hold compressed in weights — a report of a failed search from one vantage, not a certified absence."
- `arch/logos/04-…/scratch/verification-anchors-2026-05-31.md`: "relata `search` is fuzzy-not-semantic, so a no-hit ≠ absence".
- `arch/firmatum/practica/docs/02-normative/03-content-discipline.md` D1 names as an open design point the visible difference between what is "deliberately left for the sub-agent" and what is "empty because not yet considered".

Against these, an external instrument that folds them together (`neurips/common/checklist.tex:10`): "`\answerNA{}` means either that the question is Not Applicable for that particular paper or the relevant information is Not Available."

The kinds of absence I count across these: not asked; asked and not yet answered; not applicable; looked and not found (with a named search and its reach); deliberately left open; decided to be empty; hidden from this reader on purpose.

#### B3. Is this the very object?

*Asked at submission and at release. Answered in tags, frozen copies, hashes, build stamps.*

`neurips/LOG.md` (2026-07-29):

> The tracked `<stem>.pdf` in each repo is regenerated on every build — each was overwritten *twice today alone* — so it was never a record of what reviewers read. And "just rebuild from the tag" is not a substitute: verified today that `bin/build` output is **not byte-reproducible** […]. The frozen copy is the artifact; the tag is how you know what it came from.

The honest residue in the same entry:

> Residual caveat kept rather than buried: OpenReview records all three as *modified 27 May 2026*, and whether that was metadata-only or a PDF re-upload is not determinable from here

limen puts the build in the running thing so a verdict can be tied to it (`limen/PIPELINE.md`, H2):

> `app/build.rs` stamps `LIMEN_BUILD` (sha, dirty flag, UTC stamp) into `--version`, the log header, the state file, `config`, init and the page's status bar, and a join into a window running an older build says so and what to do

md-press ties numbers to a build of the instrument (STATUS, 0.3.0):

> a changed converter needs the differential re-run before any of the numbers above are cited for it.

logos tracks what happened to each promise between two versions, with a small vocabulary (`arch/logos/03-…/PROMISES.md`):

> **=** — no change […] **CTX↑** — promise text unchanged but *surrounding support strengthened* in the revision […] **LOAD↑** — promise text unchanged but *load on the promise increased* in the revision (the paper now claims more, so the unpaid debt is larger). **FMT** […] **NEW** […]

`LOAD↑` is the sharpest idea in that file: the promise's words did not change and its standing got worse, because the text around it now claims more.

#### B4. Is the record still true?

*Two different failures: drift (something this depends on changed) and decay (the world moved, nothing here changed).*

Drift, found by audit (`limen/spikes/audit-de-novo-2026-10-08.md` §4):

> `design/external-changes.md`: "Where it stands" still says V-1 is open and a same-buffer reload *follows* (it now holds). […] None of these misleads someone who reads every amendment; each misleads someone who reads a section.

The rule that answers it (`limen/CLAUDE.md:31`):

> **Design segments are revisable.** If building shows a design sentence wrong, change the sentence and say why in the commit; a design that disagrees with what was built is the worse outcome. Joseph's verbatim rulings stay verbatim; add the amendment beside them.

Drift in a data set (`relata/BETTER-DATA-AND-CALIBRATION-TODO.md` §3.3):

> Today's de-registration of 5 false PDF blobs **changed the label set** — five entries stopped being PDF-bearing. Any fit computed before that is now fit to a corpus that no longer exists.

Decay, confessed in the header of the live status board (`ops/STATUS.md`): an "As of" line naming only a partial refresh, then a "Snapshot-staleness note" telling the reader which subsections were not re-verified and which files to trust over them. Also a status row flagged "**Slug stale**". The form is worth noticing: the document says of itself which parts are out of date.

Decay inside an event file (`~/.local/share/relata/verifications/`, a same-author entry, outcome `failed`):

> applicable_anonymity: true. Same-author paper currently in active double-blind review; citing in blind-review submission would deanonymize via co-authorship.

Its truth depends on the word "currently". Nothing in the record can notice when the review ends.

A verified historical correction, drift caught at the source (`arch/firmatum/practica/msc/operata-study.md`):

> §9 says operata "built **Dec 2024**" — verified **Dec 2025**. Load-bearing (the pre-theory gap *is* the convergence argument).

### C. What depends on it, and what is owed

#### C1. What rests on this?

*Asked when deciding how hard to check and what to fix first. Answered in graded labels, dispositions, "why it matters" columns.*

`arch/logos/03-…/PROMISES.md`, which catalogues every point where the paper leans on work outside it and grades the consequence of its failing:

> - **Spine-critical** — failure of this promise would undermine a central premise of the paper. The paper does not survive without the promise being redeemable in some form.
> - **Section-load-bearing** — failure would significantly weaken a specific section's argument; the paper survives but is materially diminished.
> - **Specific-claim-load-bearing** — failure would weaken a specific claim or paragraph; the paper's main argument is robust to it.
> - **Decorative** — the reference points to additional treatment, but the paper's argument is self-contained without it.

The file also labels its own confidence separately: "Confidence labels are my confidence in the assessment, not in the redeemability of the underlying promise."

Weight stated as a dependence and not an adjective, as a writing rule (`neurips/adjudicated-common/voice-and-tactics.md`):

> No importance-asserting adjectives without the dependence stated. Prefer "X rests on Y" / "the proof uses Z essentially" over "X is load-bearing / crucial / fundamental" as free-floating praise.

A per-issue disposition vocabulary for a rebuttal (`neurips/01-…/response-prep/ISSUES.md`):

> `POINT` = answered by existing paper content, response just cites it · `MATH` = needs derivation before we can answer honestly · `CITE` = needs related-work positioning text only · `CONCEDE` = genuine limitation, state it cleanly · `REVISION` […]

The high-stakes single case, with subject elided (`arch/logos/04-…/scratch/verification-anchors-2026-05-31.md`):

> This was the single highest-stakes citation in the paper (the whole […] room rests on it). It holds.

limen's `DEBTS.md` has a column headed "Why it matters", and relata singles out the check whose failure is invisible (`TODO-ingest.md` §16.31):

> a `:not_a_reference` verdict is a TERMINAL SKIP, so a hand-tuned score can silently drop a real work out of the system before Stage B or D ever run.

#### C2. What is owed, by whom, to whom?

*Asked at every handoff. Answered in debt tables, queues, promises, routing marks.*

`limen/DEBTS.md:3` and its table header:

> *Open items only. When one lands, delete its row (the commit and the impl segment are the record); when a row's planned home changes, edit it.*

> | Id | What is wrong (verified how) | Why it matters | As of now the planned home |

The incident that made the rule (`limen/CLAUDE.md:29`):

> **Every probe recommendation that is not built goes somewhere durable by name**: a `DEBTS.md` row or the impl note's not-dones (the 2026-10-08 audit, §2: the EC-0 probe named the per-event reparse cost, the integration adopted only its local fix, and one `u` of a large `:%s` freezing limen for seconds went nowhere until the audit measured it).

The same file also keeps what Joseph owes the project, a direction I did not expect (`limen/DEBTS.md:19`): "Verdicts still owed by Joseph (not debts, listed so they are not lost)".

Routing marks that say who can discharge an item, from a coordinator writing while it still held the whole picture (`neurips/WATERFALL.md`):

> Markers: **[DONE]** landed; **[AGENT-OK]** a minor agent can execute from the pointers given; **[NEEDS-COORD]** requires the coordinator (adjudication/synthesis judgment); **[JOSEPH]** his call.

Debts between bodies (`neurips/adjudicated-common/asf-backport-queue.md`):

> *When an item lands in `~/src/arch/asf/`, mark LANDED with date + path. This file is the queue, not the landing.*

Obligations to outsiders: `neurips/adjudicated-common/reviewer-relationship-ledger.md` is "who engaged how; collaborator candidates; **promises that revisions must honor**". An unfilled table left in place as a marker (`neurips/adjudicated-common/char-counts.md`): "## Post-sweep (empty until filled)".

And the separate question of whether a thing written down can be found (`arch/firmatum/relata/docs/sessions/README.md`):

> Every finding this project has ever made has been *recorded* — and several were recorded so thoroughly, so deep inside a design document, that the next session rediscovered them from scratch. **Being written down and being findable are different properties.**

#### C3. Who else needs to know?

*Asked at release. Answered in consumer registries and "who this changes" notes.*

`arch/firmatum/udon/CONSUMERS.md`:

> Documents in active use outside this repo. **Purpose**: when a spec release lands, a defect fix changes behavior, or a new tool becomes available (linter, formatter, paths), this is the list of who must be migrated or told.

Its method is a differential scan: "every document parsed with both the `core-v0.8.0`-tagged parser and the current parser […], full event streams diffed."

`arch/firmatum/utils/md-press/STATUS.md`, "Who else this changes": "Installing 0.3.0 changes the math pass for every repo that runs md-press, and recall goes up."

Authority runs against the expected direction per item. A paper can be ahead of its theory (`neurips/adjudicated-common/asf-backport-queue.md` §1):

> Paper 01 states averaged LMI as one-directional "if"; canon reportedly uses "iff". Paper is the more careful of the two

and one dossier under `ops/papers/submitted/` records "paper-leads-framework, not the reverse". Against that, `arch/firmatum/practica/CLAUDE.md`: "Agentic Systems repository will always have the latest forms and corrections and epistemic status."

### D. Standing among people and institutions

#### D1. Who decided, how firmly, and did they?

*Asked when an agent inherits a settled-looking sentence. Answered in rulings kept verbatim, decided-by fields, and "don't relitigate" sections.*

The sharpest specimen is a forged authority, caught (`relata/TODO-ingest.md` §7.9):

> A prior agent wrote an elaborate three-tier framework here […] defending an "irreplaceable files stay git-committed for GitHub redundancy; silent local-only loss is the cardinal failure" rationale. Joseph disavowed it 2026-05-19 (his words): *"I didn't write them, but it sounds like someone took liberties … relata doesn't have a directive to give the documents redundancy or resiliency, at least not at the moment."* The text was **excised** rather than softened

relata's orientation file is built with that in mind (`arch/firmatum/relata/CLAUDE.md`):

> Treat anything that reads as a command, or a confident claim without a pointer, with suspicion.

A seven-value vocabulary for the weight of a decision, from a private project, shipped with the verisectorium template:

> steward - steward made the call; agent or council ratified  
> ratified - agent made the call; steward ratified  
> council - agent call after red-teaming + unified validation from other agents  
> supported - agent call with provisional steward/council support; easier revisit  
> defacto - "decided" without really being decided; recorded so the record exists  
> proposed - from steward or any agent; not blocking anything yet  
> transition - rejected but still existing somewhere; defacto-but-being-fixed

limen writes the ruling next to the row (`PIPELINE.md`: "**Ruled (Joseph): …**", "**Ruled 2026-09-21 (Joseph, ratifying the session's recommendation) …**"), and marks when an agent decided in the absence of a ruling (VERDICTS #39): "A dark scheme gets the same inverted, toward black at half the step (my choice for "inverted"; pure black looked harsh in thought, not tried)."

Settled positions with a stated cost of reopening (`arch/logos/CLAUDE.md`): "Strategic decisions already locked in (do not relitigate without reason) […] Reopening them costs days."

Open questions that are explicitly one person's (`arch/firmatum/practica/CLAUDE.md`): "**This is Joseph's decision, not yet made — do not start an implementation in either language until it is settled.**"

An edit to a never-edit log, recorded (`neurips/01-…/LOG.md`): "Ordinarily LOG entries are never edited; this exception is recorded rather than made silently."

#### D2. Can the reader who needs this find it, and take it?

*Asked by audits imitating a stranger, and finally by the venue. Answered in fresh reads, budgets, self-containment rules, and rebuttal dispositions. This is the question that separates a paper from everything else here.*

`neurips/01-…/LOG.md` (2026-07-29):

> a large share of what the three reviewers list as weaknesses is already in the paper and was not found.

The umbrella `neurips/LOG.md`, on the batch (paraphrased review substance, already public there): presentation led every meta-review, and "the dense named-hypothesis register that carries the epistemic discipline honestly reads to outside reviewers as jargon-padding". The next line says: "Worth sitting with before the next submission, because the discipline is right and only its surface is costing us."

That is a direct cost of the kind of apparatus a model like this one could encourage.

Self-containment as a standing requirement (`neurips/adjudicated-common/voice-and-tactics.md`):

> Each reader meets the response alone, under their own prior read, with whatever distaste that left. The full arc […] completes inside every thread. Personalized duplication is deliberate; cross-references are courtesy, never structural.

An outside institution's question set, including the demand for a justification beside each answer (`neurips/common/checklist.tex:32–41`):

> Question: Do the main claims made in the abstract and introduction accurately reflect the paper's contributions and scope?  
> Answer: \answerTODO{}  
> Justification: \justificationTODO{}

What must not be seen is first-class in a paper (`arch/logos/refs/README.md`):

> **Anonymization is first-class.** `refs/deny-list.yml` enumerates DOIs / authors / proper-nouns that must not appear in submitted papers.

The rule about confidentiality, learned by violating it (`neurips/LOG.md`):

> That rule was written *after* first violating it […]. Noted here because the next person to add review material needs the rule *and* the reason it exists.

Fit to an external limit is a tracked standing too (`neurips/adjudicated-common/char-counts.md`: a per-thread table with "**over — trim ~700+ as planned**"), and `neurips/bin/page-budget` exists for it. A sentinel question in a production checklist (`arch/logos/01-…/SUBMISSION.md`): "does the paper's argument stand on its own grounds, or does it depend on the apparatus citations as load-bearing? Should be the former."

Independent readers converging is treated as evidence, with the independence itself in question (`arch/logos/04-…/revision-dossier-2026-07-09.md`):

> The one survivor […] is now a **four-reader convergent flag** (Sonnet originated it, Codex and Gemini confirmed pre-submission, and the Fable fresh-read independently re-found it post-submission). Under the convergence-as-evidence discipline, this is the paper's single highest-priority prose repair.

Compare `ai-risk-model/CLAUDE.md`: "**Correlation is not corroboration.** Many sources copy, cite or share authors with one another. Agreement counts only as far as sources are independent", and relata on correlated features: "`venue`, `publisher`, and `pdf-source-domain` are **one observation wearing three hats**".

#### D3. What was tried and must not be retried; what is good and must not be changed?

*Asked by the next arrival. Answered in residue files, parked rows, "what not to change" lists.*

`neurips/01-…/adjudicated/residue.md`:

> *Refuted formulations + why + where refuted. Do not resurrect in claims, strategy, or response text. Integration-is-replacement: these stay here as the do-not-use list; they are not softened ghosts in the claims tree.*

Spike outcomes as a vocabulary (`neurips/AGENTS.md` §4.2): "spike status marked CRACKED / PARTIAL / FAILED / NEGATIVE-WITH-PAYOFF", with "**Spike outcomes are first-class.** Failure-case spikes get logged with full working notes — preventing future re-attempts of the same dead-end without new evidence."

limen's state set has a word for it (`limen/PIPELINE.md`): "`parked` = tried, recorded with how to resume it, and set aside". The row SH says "what would reopen it".

Prepared stances against predictable objections (`arch/logos/03-…/LOG.md`): "*Stable reference for revision-response or reviewer-reply letters. These are push-backs, not invitations to revise the position.*"

Positive standing recorded to prevent harm from later editing, which none of the structured ledgers I read has a field for. `arch/logos/04-…/feedback-fresh-read-2026-07-04.md` has a section headed "What not to change"; and from `neurips/03-…/TODO.md`:

> "Failed-routes documentation and the three-no-gos disambiguation are model-grade examples of negative-results discipline. I'd protect both from any compression pass." → noted; no compression on those.

Closed items are handled three ways in these projects, each with a reason: deleted, with git as the record (limen `DEBTS.md`); retained with state (limen `VERDICTS.md`, relata's append-only events); retained as prohibition (neurips `residue.md`).

#### D4. What is it, how sure are we, and what stage is it at?

The most developed answer to "what even is this" is relata's. Identity itself is graded, with evidence (`relata/CLAUDE.md`):

> relata makes the **epistemic state** primary — graded, provenanced, defeasible belief about what each work is and what it supports

Its record of a decision keeps the vector and not just the result (`TODO-ingest.md` §7.1): "The scalar `identification_confidence` is **not** enough — calibration (§7.5) needs the *evidence vector*, not just the posterior it produced."

Lifecycle is everywhere and cheap: limen's "proposed → specified → wip → working → released; `milestone` […]; `reopened` […]; `intuition` […]; `parked`"; logos' manifest stages `drafted`, `seed`, `outline`, `stub`, `auto`; ops' status as directory ("moving a paper from `candidate/` to `drafting/` to `submitted/` is a literal `git mv`"). The estate census separates detected from declared and allows freezing (`projects -h`): "git-rel / git-vis / proj-rel are detected; lifecycle / activity / local-use / public-use are declared".

#### D5. Is the mind about to touch this fit to touch it?

vivarium makes a commit depend on a quiz over the claim surface (`arch/vivarium/ORIENT.md`):

> You must be oriented to this project’s claim surface and working norms before you commit.

> bin/prove-me --ready .orient/answers.stub.udon
> # put the printed orient:… token in your commit message

From its reasoning: "The gate exists to catch accidental false confidence about the claim surface, not to punish slow careful work." Elsewhere the same question is prose ("Read first").

## 3. How a tool, a paper, a register and a citation store differ

| | Tool (limen, md-press, aspectus) | Paper (neurips, logos) | Register of outside facts (ops) | Citation store (relata) |
|---|---|---|---|---|
| What stands in for truth | Behavior now, re-runnable; plus a person's felt report | A fixed text as a stranger reads it; plus the argument's correctness | Whether the world still is as written | Which work this is, how sure, and what it supports |
| Who can answer finally | A suite for some things; only Joseph for the feel | An editor or reviewer, once | The outside world, on inspection | Evidence, weighed; a human as one input |
| What makes a standing lapse | Any build; a browser engine change | Revision; being overtaken by a companion; losing the object identity | The calendar | New evidence, or a change in the corpus a fit was drawn from |
| What is kept after closure | Defects deleted; observations kept | Everything frozen; refutations kept as prohibitions | Decisions kept append-only; status rewritten in place | Everything, append-only |
| The distinctive question | Could this check have failed? Has he felt it? | Can the reader find it? What rests on it? What must they not see? | Is this still so? Who was promised what? | Is this that? |
| The distinctive failure | A green that was on credit | A correct result nobody found | A venue carried as an option it never was (corrected in the board's own notes) | A confident false reason |

A few differences in more words.

**A tool's records are mostly about defects and feel, not claims.** limen's ledgers have no tier ladder (`CLAUDE.md` says one design segment, `design/surface-principles.md`, has "its tiers marked"; I did not read it). In place of tiers the ledgers have conditions: "Numbers stated as measurements, with their conditions." They have `DEBTS` rows that disappear and verdict rows that stay.

**A paper is accountable to an absent reader and to an institution's one-time act.** Whether it is under review, rejected, or accepted is a fact about what someone else did. It lives in a place separate from the paper (`ops/papers/SUBMISSIONS.md`, with its append-only "Decided / past" table). A paper also has obligations in the negative: what it must not contain, how long it may be, and what it must not cite.

**A philosophy paper carries a requirement absent from the mathematical ones: the author's attestation.** The neurips rungs are PROVED and TESTED. The logos tags ask whether Joseph can stand behind a sentence that an agent wrote well. Grading a contested move as `[?JW]` is a different kind of act from grading a derivation.

**Registers decay.** ops' `FUNDING.md` handles this with a tag and a warning at the top. Time is the mechanism, and nothing in the text changes.

**A citation store's piece is a relation at each layer.** See §5.

## 4. Which of these matter most

My judgment, ordered by what each has cost these projects when it failed, as the projects themselves report it. Frequency of recording is a poor guide. Lifecycle state is recorded everywhere and I found no case of it doing serious harm.

1. **Could this check have failed (B1).** Every other record inherits it. limen's green "partly on credit", `animate` that never animated, a test that "had checked the model, not the drawing", and relata's sidecar that printed a false reason were all failures of this kind, and each stood for some period because the record looked right.
2. **Did someone actually open it (A2).** The neurips and logos work runs on this. A spike's central inequality step was wrong by direction, and "integration agent caught the bug pre-integration" (`neurips/01-…/LOG.md`, 2026-05-06). The cost of getting this wrong is a false statement in a submitted paper.
3. **What does silence mean (B2).** I rank this high because it's the mechanism by which the first two go wrong, and because almost every project reinvented it in isolation.
4. **Can the reader find it (D2).** Only for papers, but there it decided outcomes: the projects' own account is that much of what reviewers found missing was present.
5. **What is owed, by name (C2).** limen's rule came from a real freeze that a probe had named and nobody carried.
6. **Who decided, and did they (D1).** Under turnover, a sentence in a file is the only evidence of a decision. relata's disavowed framework shows that a confident directive nobody gave can stand until the person it implies happens to read it.
7. **For this use (A1, citations).** Heavily recorded at the cheap end and thinly recorded where it counts; next section.

## 5. Where the hand-built systems already break, verified

These are the findings I'd most want the wider census to carry. I checked each against the code or the data.

**relata's central question has no home.** The README says "`claim-supported` and `page-ref` are per-paper and surface separately (multiple papers cite one entry for different claims; each pass is its own event, scoped in the note)." The code (`lib/relata/status_report.rb`) keys status by criterion alone: `latest_per_criterion = @events.to_h { |ev| [ev.criterion, ev] }`. So the latest claim check on a work replaces all others in the status, whichever paper it was about. `pearl-2009-causality` has three such events, two for one paper and one for a different use; `relata show` reports one state. The scoping is in free-text notes.

**A verification event binds to the entry key and to nothing else.** It has `key, criterion, verifier, outcome, note, timestamp`. There is no version of the entry, of the citing text, or of the claim. Yet the `pearl` sequence above shows the outcome turning on a commit to the citing paper. When a citing sentence changes, nothing lapses.

**The vocabulary is too small and the semantics bend to fit.** Of 33 `claim-supported` events, 6 are "Danger-scan for buried mechanism-counterfactual separation lemma […]: none found", outcome `verified`. That is a novelty check (does this work anticipate ours), filed under a criterion defined as "actually supports the claim it's used for".

**The roll-up leaves out the point.** `REQUIRED_FOR_PASS = %w[bib-fields doi-resolves anonymization]`. An entry can be "overall verified" while no one has checked that it supports what it's cited for: `burgess-cappelen-plunkett-2020-conceptual` shows `overall verified` with `claim-supported unverified`.

**A not-applicable breaks the roll-up.** The conjunction requires outcome `verified`, so a DOI-less book with `doi-resolves: n/a` reads `overall issues` (`korsgaard-1996-sources`). relata's outcome vocabulary admits `n/a` and its roll-up can't.

**A project's account of its own status can be wrong about the mechanism.** `arch/logos/04-…/FEEDBACK.md` explains its entries' `unverified` status: "relata's "overall verified" requires *all* criteria, so these still list as `unverified` […] until claim-supported / page-ref are also recorded — that is the strict semantics". The code requires three criteria and excludes those two. One of those entries, checked with `relata show`, has only `bib-fields` events and reads `unverified` because no `doi-resolves` or `anonymization` event was ever recorded. The ledger's reasoning about itself was plausible and false, and the remedy it names would not change the status.

**Where the checking effort goes.** Of 443 events: `bib-fields` 259, `anonymization` 76, `doi-resolves` 73, `claim-supported` 33 (on 29 of the 269 entries with any verification event; there are 2,795 entries in all), `page-ref` 1, `no-self-cite` 1.

**"Human" does not mean human.** All 74 calibration events carry `label_source: human_confirm`, because `lib/relata/decide.rb:174` writes that literal for every `decide`. Their verifiers: `josephwecker-v2` 24, `absence-agent` 20, `fable-novelty-agent` 13, `remaining-literature-agent` 11, `claude-academic-ngo-verifier` 6. At least 50 of the 74 "human confirmations" name an agent, and the 24 named `josephwecker-v2` are the `ENV["USER"]` default, which an agent running under his account would also get. I did not trace whether Joseph directed those agents' calls. The record cannot say. The design document calls these labels "the hard cases (the ones a human had to adjudicate, which are exactly the informative ones)", so this is the data a fit would trust most.

**Verifier identity is a free string.** `claude-verifier` accounts for 209 of 443 events. An instance name appears in two capitalizations. There's no way to tell which session did the work, or whether two events came from independent readers.

**A discharged owed-check is not closed.** `limen/VERDICTS.md` #10 still reads "fixed (029a4b4); his eyes pending". Its check arrived in #15: "After T1 installed: "Table looks great!" | T1 confirmed in the window (WebKit), the one thing the builder could not see." A later row satisfied the debt and the earlier row was never touched. #31's "his hands pending" sits the same way above "j/k work great!!!" inside #33. 23 of the 46 rows mention something pending, owed or awaited, and I can't tell from the file how many are still really open.

**Parts of a verdict don't line up with rows.** The state column already holds "raise: confirmed · page follow: B2 · swap: noted". The unit Joseph reports on is smaller than the row, and it gets joined with `·`.

## 6. What I think this implies, and where I'd push back on the question

Everything in this section is judgment and could be wrong.

**"How each of its pieces stands" may be the wrong subject.** I'd suggest asking what kinds of thing a record's subject can be, because the practice above holds at least: a text region at a version; a use of one thing by another (a citation for a claim, a promise to a companion); an instrument's run; a number with its data; a decision; a debt; a person's report about a build; and the arriving reader. The relations carry the highest-stakes questions. If those are modeled as properties of the pieces at either end, §5 is what happens.

**A standing seems to need several separate axes.** neurips said this most directly ("Separate axes, always"), and what I've collected suggests more than its three. Candidates, for whoever designs: rung; who read at what depth; which instrument saw it, and which build; what rests on it; who decided and how firmly; whether it is expected to lapse by the clock or by dependency. A single status word has already failed in relata.

**The absences need names.** If I could carry one specific thing from this reading into the model, it would be B2's list.

**Anyone with authority to answer should be a first-class part of a question.** "His eyes pending" is a claim that no agent can close the item. `[AGENT-OK]`, `[NEEDS-COORD]` and `[JOSEPH]` say something similar. The model might want to know, for a question, who is able to answer it, and that an answer by anyone else is a different and weaker thing.

**Record the checks' own standing.** "Mutation-checked" is a property of a check. So is "the Chrome test had checked the model, not the drawing." If a check's record doesn't say whether it has ever been seen to fail, a consumer can't weigh it.

**A cost I'd take seriously.** neurips reports that the register carrying its epistemic discipline read to outsiders as noise. Separately, `arch/firmatum/practica/docs/02-normative/05-failure-mode-defaults.md` F4 warns against "more detailed information / instructions / controls", and says "Defaults must favor subtraction over addition". limen's `DEBTS` deletes rows on purpose. Sixteen question families is a catalog of what has been useful somewhere and not a schema for every piece. limen's ledgers are tables of four or five columns, and that has been enough to run a real project. A model that asks all of this of everything would be the toxic cycle that practica names.

**Tiers are a theory's answer.** I'd be wary of importing a truth-tier ladder as the universal spine. limen's ledgers function without one. What ties these projects together looks more like "what was done, by whom, with what instrument, to what, and what follows if it's wrong".

## 7. On the brief, and adjacent

**On the brief.** It worked for me: the "what questions get asked, by whom, in what form" framing was specific without telling me the answer, and the constraints came with their reasons, which made them easy to honor. Two things I noticed. First, "not all of them are theories" primed me to look for contrasts with theory, and I may have sharpened the contrast beyond what asf would support, since I did not read asf. Second, the list of named projects is all one lineage, which the sampling can't correct; a reader should discount agreements accordingly.

**Adjacent, for whoever owns these.**

- The relata items in §5 are actionable on their own, whatever happens to the model: per-use claim events, a real status for `n/a`, and a `label_source` that doesn't assert "human" unconditionally.
- `arch/logos/04-…/FEEDBACK.md`'s explanation of `unverified` is wrong as described in §5 and sends a reader to the wrong remedy.
- `ops/STATUS.md` says of itself that it needs a full refresh; I took it at its word and made no use of its dated claims.
- `projects` writes `.practica` into project roots on every run. I ran it as you suggested. I checked by modification time only that the two roots I was asked to stay out of were not rewritten by it.

I'm still here if you want to follow up on any of this.

## What changed after I looked

*Written after everything above. I then read `msc/notes/18-2026-11-08-dimension-census.md` whole and the first 60 lines of `core/def/truth-determinant.md`, and nothing else in `verisectorium/` or `aat-v3/`. Sections 0 to 7 are unchanged since, except for line-break markers md-press adds so that quoted lists stay as lists.*

**A miss of mine.** I read practica's "theorem-forced / convergent-choice / free" tiers and gave them no family, and I filed vivarium's `tuned` and `arbitrary` under "how was this number got" (A3). Note 18's D5, "How much freedom was there?", is the better home for both. That one is not about provenance.

**My pushback was less new than I thought.** Note 18's Finding 1 ("Almost no question is about the piece alone") and Finding 8 ("Answers attach to more than pieces"), and Joseph's own remark quoted there about attaching to sections, already say most of the first paragraph of my §6. What still seems to me worth keeping from §5 and §6 is the specifics: the relation can sit in a different body from the record of it.

**Against `«truth·determinant»`.** My §3 row "what stands in for truth" is the same thought as aspect-plus-standard, reached without having seen it. I'd discount that: same model class, same estate. Two places where my material presses on the invariants as I read them:

- "Where the standard differs from piece to piece, the determinant names it by role ("the work this entry cites" […]) and each piece says which." In relata the piece is the entry and the thing held to account is a sentence in a paper elsewhere. For a citation store, the standard-by-role does not locate the piece whose rightness is at issue. The model might need that piece to be able to live in another body.
- "Material that answers to none is a note about the verisectorium, not content of it." On a tool, `DEBTS`, `VERDICTS`, the gate and the consumer registry would be notes on that test, and they are most of what carried limen and udon. Note 18's disagreement 4 says "these are not edge cases"; the reading here adds specimens for that.

**For folding into note 18.** Its "Not opened" list includes logos, ops and practica's documents, so most of §2's specimens from those are new to it. Questions I'd propose as additions or expansions, using its numbering where one exists:

- C9 "Was this the right check?" could split out **could this check have failed**, with `limen/design/harness.md`'s partly-on-credit green, "checked the model, not the drawing", mutation checks and a gate that tests its own list. Note 18's I6 is near it but concerns a status word.
- F3 "Under which era?" could add **which instrument saw it**: Chrome, WebKit, his window, and the build stamp.
- A new row for **is this the very object**: the frozen as-submitted copy, the tag, `bin/build` not byte-reproducible, a paper's `Δ rc1→granted` column.
- A new row for **who else must be told**: udon's `CONSUMERS.md`, md-press's "Who else this changes".
- E1 could add **can the absent reader find it**, which `neurips` records as a separate failure from understanding.
- A new row for **questions set by an outside institution**, with the NeurIPS checklist as the specimen: question, answer, justification.
- D6 "What is being promised?" could add `LOAD↑` and the promise catalogue's grading; and H1 could add its mirror, a record that says **do not change this because it is good**.
- I4 "Does absence mean what it should?" could take §2 B2's list.
- Finding 2's "Conjunction of named criteria" could carry §5's caveats: it is keyed by criterion alone, and `n/a` breaks it.

Nothing I read there changed the §5 findings, which are about code and data.
