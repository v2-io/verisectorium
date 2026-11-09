# Census: what ASF holds its pieces to account for, outside `status:`, `## Epistemic Status` and the inline labels

Read at `~/src/arch/asf` HEAD `68f68644`, 2026-11-08. Written before opening anything under `~/src/verisectorium/` or `~/src/aat-v3/`, as the brief asked. Quotations are verbatim from the file named; `reviews/x#C7` means check C7 in `reviews/x.md`, and `path:NN` is a line number at this HEAD. Each count says how it was made.

## 0. The short version

The question is a good one, with four adjustments I think the wider census will want.

**The record mostly does not ask how a piece stands.** Section 2 lists 47 distinct questions it asks, in eight families: whether it is true; what kind of claim it is and of whom; whether two texts agree; whether what is said *about its standing* is true; who stands behind a check and what they read; what became of it; whether it can be read, found and placed; and whether it was worth doing. Truth is one family of eight.

**The unit asked about is rarely the file.** Of the 500 check criteria, 263 name something smaller than a segment (a proposition, item, Claim Record, paragraph, sentence or line), by a regular expression that I describe in section 1. All 500 bind to `segment:<slug>`. Many of the rest are about the relation between two texts, not about one text. `kinds.yaml` says this outright: "declared at record grain -- one statement per file, id `segment:<slug>` -- not carved into statements".

**The commonest non-trivial verdict is neither true nor false.** Of 500 checks: 373 confirmed, 84 narrowed, 43 broken. "Narrowed" means it holds of less than was said. One checker's summary of a whole Part II pass:

> "The failures are all about the scope of an "exact" sentence, not about the frame." — `reviews/part-ii-check-1-identification.md` :202

**Statements about standing are themselves held to account, and they fail often.** Labels, directory locations, "resolved" notes, "not yet read" notes and tracker rows are all treated as claims that can be false. The SOPs say so flatly ("`.integrated/` is a **truth-claim**", `spikes.sop.md:137`; "*A segment must never lie about its own status, even transiently.*", `routing.sop.md:88`), and the reviews catch them doing it.

If I had to name the one thing ASF asks most and records least, it is: *what was actually read, and by whom?* It is asked everywhere (section 2, family E), answered in prose in many formats, and is a queryable field almost nowhere. INTENT I.9 says of its own drains: "nothing records which files were read."

## 1. What I read, how I counted

**Read whole (every line):** every check's criterion, target, act, line and outcome, all 500, extracted from `reviews/*.md` by script into one list and then read line by line; `.vsect/kinds.yaml`; `doc/sop/agents.sop.md`; `doc/sop/audit.sop.md`; `PRACTICA.md`; `msc/inside-out-2026-10/INTENT.md`; `msc/tag-vs-now-assessment-2026-10-31.md`.

**Read line by line, clipped:** all 200 findings in `reviews/*.md`, each cut at its first 420 characters, so long findings were read only in their opening; `audits/README.md` and `empirica/README.md` with their longest lines cut.

**Read in large part:** `doc/sop/format.sop.md` lines 1–585 of 645 (the rest is equation-tag mechanics); `doc/sop/audit.sop/routing.sop.md` 9–198 of 222; `doc/sop/spikes.sop.md` 12–180 of 214; `doc/sop/audit.sop/de-novo.sop.md` §4.4, §5, §7.4–7.8, §7.12 (about 170 of 702 lines); `msc/inside-out-2026-10/system-review/00-system.md` §2 and §3.2; `msc/reflections/31-*` first 40 of 68 lines; naming principles' criteria and decision categories.

**Sampled (headings, frontmatter census, or a few specimens):** the review bodies beyond those fields (7,923 lines in all; I read the first five checks of `a2-front-door-trace-1` in full format and the "What I did not check" and closing-note sections); segment bodies (grep census plus snippets from seven; the other two readers hold their status layers); items (859: frontmatter census, five read); questions (64: frontmatter census, four read); `.vsect/events` (2,259: tallied by script, one or two of each act read); `TODO.md` headings; `CHANGELOG.md` preamble and headings; OUTLINE rows and `OUTLINE-accepted.md`; `spikes/INDEX.md` head; `spikes/.integrated/VERIFICATION-2026-07-16.md` head; one verify-1 spike head; `audits/audit-731548-FINAL-2026-07-02.md` head; `audits/pending-findings-2026-04-23.md` head; polish ledger's first 14 rows; `audits/.integrated/MANIFEST.md` head; one adjudication head; headings of one `audit-findings-*`; one reflection file of one `AUDIT-WORKING-*`; `empirica/INDEX.md`, one MANIFEST, one RUNS head; `terminology/README.md` head, one entry, one decision; one prior-art analysis head; `msc/quiz-responses` one file head; `doc/DOMAINS.md` head; `msc/meta-process-review-2026-07-07/PROCESS-MAP-v0.udon` and `DECISIONS-CENSUS.md` heads; one drain head; items-recheck pilot head; `HANDOFF.md` head; `bin/check-commit` head, `.githooks/pre-commit`, `bin/lint-outline` messages, `bin/make-quiz` head; relata's verification store (tallied, one read); 6 commit bodies plus keyword counts over the last 800.

**Skipped:** the other 23 `AUDIT-WORKING-*` directories (each is first-encounter cognition, and the richest unread thing here for this question); the `audit-findings-*.md` bodies; `audits/.integrated/`; `.archive/`; `spikes/.integrated/` and `.archived/` beyond one ledger; the spike bodies; `FINDINGS.md` and `CURRENT-VOL1*`; `LOG.md`; the `CHANGELOG.md` body (500 KB); most of `msc/` (the `summary-attempt/` tree, `owner-review/` explorers, `influx-scout/`, the drains); `system-review/vsect-flow-2026-11-02/`; `ref/` beyond one file; `terminology/decisions/` beyond one; the transcript corpus (memorata not searched). I did not re-derive or verify any mathematics. Where I say a check found X, I am reporting the check.

**Counts.** All counts are mine, at this HEAD, by script or grep, not taken from any dashboard or summary:

- Checks and findings: Python regex split on `^## ` in `reviews/*.md`, a heading containing `(check)` or `(finding)`, with `- field: value` lines parsed under it. 500 checks, 200 findings, across 64 review files.
- Acts and outcomes on events: `act:` and `outcome:` in the 2,259 YAML files under `.vsect/events/`.
- "Names a sub-part" (263 of 500): criterion matches any of `:NN`, Prop, Item, `(g)`, `(h)`, R1–R4, Lemma, Record, Corollary, Epistemic Status, Discussion, Brief, Working Note, paragraph, sentence, summary, Step, Instance, Theorem, table, row. It over-counts (a sentence mentioning "Theorem" of someone else's) and under-counts. Treat it as "about half".
- Keyword counts below (for example "falsifier: 19") are substring matches over the 500 criteria. They are floors on a theme and not a classification. I read all 500 but did not hand-code them, so I give no precise share per question.
- Claim Record, Findings, stage counts: greps over the 247 files in `0*-*/src/` excluding `old-*`.

## 2. The questions, by family

Each entry: the question in plain words, who asks it, the form the answer takes, then specimens. "Explicit" means a document states the question; "implicit" means practice asks it without a document saying so.

### A. Is it true?

**A1. Does it follow from what is written?** Explicit (FORMAT Gate 2 "Derivation check", `format.sop.md:238`; the de-novo audit; every checker). Answer: a `rederive` act on `line: derivation` (276 of the 500), and in findings a construction. The standard written into one spike: "Re-derived from what is written, not from what seems meant." (`spikes/spike-strategic-persistence-hard-ceiling-convention-2026-05-31-verify-1.md`).

> "Does the right rung $A_O^{\text{RH}} \leq A_O^{\text{B}}$ hold with no hypothesis on $\Pi$, as the body's "exact and unconditional" and its one-line proof say?" — `reviews/b1-part-ii-integration-1#C1`, broken

> "Under the discounted recurrence the segment states, does the stationary per-observation gain of $\hat p = \alpha/n$ equal $(1-\lambda)/(2-\lambda)$ (Prop C.1), so that $\sup_\lambda \alpha_\Sigma^{\text{ss}} = 1/2$ (Prop C.2)?" — `reviews/f72-hard-ceiling-verify-1#C1`, broken; refuted by the only `refute` event in the store, with `ground: kind: broken-derivation`

**A2. Is the premise it actually uses the one it states? Is each hypothesis needed?** Explicit in part (Gate 2: "Are all premises either in `depends:` or stated as local assumptions"); the "needed" half is practice.

> "Both branches use $\pi_{\text{RH}} \in \Pi$ ... Is that membership a consequence of C2's definition, or an unstated third hypothesis the rung fails without?" — `reviews/part-ii-check-1-b1-records#C2`, broken

> "(h′)'s hypotheses are needed. A frozen hidden $x \in [0, 1]$ under a known law, observed once as $o_2 = 1\{x \in \mathbb Q\}$, is out at $t = 1$ under Lebesgue and in under half Lebesgue plus half a dense atomic measure on the rationals" — `reviews/scope-adaptive-system-integration-2#C4`

> "Is the disjoint-modelled-ancestor condition correct and needed?" — `reviews/part-ii-check-1-b1-records#C8`

**A3. Does a constructed instance break it?** Explicit as an "emphasis" (`de-novo.sop.md` §5.1); recorded as `instantiate` (4) and as small named worlds. A checker's reading of why this works:

> "In each case a constructed instance, a dozen lines long, settled the question; re-derivation from the written text had not." — `reviews/part-ii-check-1-identification.md` :202

**A4. Do the numbers come out?** Explicit (empirica contract). Form: a `run` act (88), with a `recheck:` recipe, a named script and commit. Keyword floor "reproduce": 15.

> "Does every number in the Discussion's git-history measurement reproduce from `elapsed_time.py` on the six histories at the HEADs its header names?" — `reviews/tst-lane-check-1#C2`

> "A canon claim tagged *[Empirical Claim (…)]* that cites `empirica:` must trace to a recorded run — date, exact parameters, explicit seed, environment note, output (or digest of it). ... A claim whose run was never recorded is restated or rerun, not trusted" — `empirica/README.md`

And the failure of a witness is itself recorded: "**The LQR closed-loop ridge script exited 0 and printed nothing in my environment.**" (`reviews/part-ii-round-2#F3`).

**A5. Does the measurement measure the thing?** Explicit only in the reviews. This is a separate question from A4 and the TST lane asks it most sharply: is the estimator the quantity, is the interval honest, is the optimum global, are the pairs independent, is the unit the claim's unit.

> "Does the Discussion's "first-pass git-history measurement" ($\alpha \approx 0.118$ at $d \le 25$, read as heuristic corroboration of the exponential form) measure time at all, or only the time estimator?" — `reviews/hyp-exponential-cognitive-load-a13-rerun#C1`, broken

> "Does "the 316-commit TST research corpus (one author)", with i.i.d. pair-bootstrap intervals, describe what the corpus is and how independent its pairs are" — `reviews/tst-lane-check-2#C7`

> "Are the one-idle mixture fits the toolkit reports the maximum of their likelihood in each history" — `reviews/tst-lane-check-3#C4`

> "Its unit, a file's deletion, is not the claim's, a system's remaining feature count, so it tests nothing `#der-change-expectation-baseline` states." — `INTENT.md:48`

**A6. Was the design set before the result?** Explicit where it occurs: "The design, the decision rules and the agent's prior expectation were committed before any lifetime was extracted, in `msc/inside-out-2026-10/e3-measurement/prereg.md` (`54a0bf5e`)." (`empirica/software-file-lifetimes/MANIFEST.md`). Each check also carries a `committed: before|after` field, 226 and 274. I could not find a definition of that field in anything I read, and it does not track whether the criterion is phrased as a question or a finding (question and after 144, question and before 87, statement and before 139, statement and after 130). See "After writing".

### B. What kind of claim is it, of whom, and what would show it wrong?

**B1. The Claim Record: register, population, true of, false of, falsifier, instantiated.** Explicit and the most schema-like thing in the corpus (`format.sop.md:318–348`). 79 records in 24 files, all in `01-aat-core` (I grepped `^\*\*Register:\*\*`). Register: 51 formal, 18 descriptive, 10 normative. Asked by the author; checked "by someone other than the author" (INTENT B.1). The reason it exists, from the SOP:

> "a reader hears "exact" as "true of agents" when it means only that the derivation is valid." — `format.sop.md:318`

Specimen (`01-aat-core/src/def-control-regret.md`, second record): "**True of:** no measured instance. #example-strategy shows the diagnosis is computable and consistent; it compares the diagnosis with Part I's symptom, not the routing with a baseline agent."

**B2. Can the claim's own test do its job?** Practice, repeated enough to count. The falsifier, the population and the hypothesis are themselves checked for whether they could ever fire or be met. Keyword floors: falsifier 19, population 11, non-vacuity phrasing 8.

> "Does the new record for the aspiration hypothesis (`aspiration-dominance`) bound a population on which the hypothesis can be true?" — `reviews/part-ii-check-1-b1-records#C5`, broken

> "Is (C2) as written satisfiable by an agent in agency scope?" — `reviews/b1-part-ii-check-1#C8`

> "Does the record agree with the body, and can its falsifier separate the norm from its precondition?" — `reviews/b1-part-ii-check-1#C9`

> "Are both records faithful, and does the descriptive timescale record name a falsifier that would refute the body's sentence?" — `reviews/b1-part-ii-check-1#C3`

**B3. Has any of it been run on something the theory did not build?** Explicit (`Instantiated:`; objective E). 77 of 79 records begin "no" or "not" (first word of the field). The SOP treats the plain "no" as useful: "saying so plainly is what gives the empirical program its targets. A simulation of the theory's own equations is not an instantiation." (`format.sop.md:346`).

**B4. Is it typed right, and how strong could it ever get?** Explicit: the three triage questions (`format.sop.md:520–524`), the derivation-audit table "What Is Derived vs. What Is Chosen" (18 of the 247 segments carry the phrase), "Max attainable" (107 segments; that phrase sits in the other readers' sections), and the three "rings", which the SOP says are "not part of segment frontmatter — it's an analytical stance the reviewer takes" (`:575`). Worked examples carry a "Mapping Quality Summary" table per concept (3 files).

> "What competing formulation would also fit the prior objects?" — `format.sop.md:522`

**B5. Is each distinct claim covered at all?** Coverage questions, explicit in checks.

> "Coverage: does every distinct claim the segment makes have a record?" — `reviews/b1-part-ii-check-1#C10`

### C. Do two texts agree?

This family is about relations and is where the late record spends much of its effort. The sprint's own retrospective: "after the first rounds the mathematics held, and what checks kept finding were sentences elsewhere (Briefs, OUTLINE cells, README partials, neighbour segments) that said more than the corrected body." (`msc/reflections/31-*`). Acts: 122 `read-check` and 10 `read`. Keyword floor "agree/consistent": 37.

**C1. Does this restatement say what its body says, at the same register?** Explicit (INTENT A.2: "Each headline sentence traces to a body sentence of the same register").

> "INTRODUCTION H3 carries the four registers of the Claim Record separately and at their tiers ... "Necessary" and "coherence", which the old anchor 4 carried and no body states, are gone." — `reviews/a2-front-door-trace-1#C3`

> "No sentence in #deriv-sector-condition, #result-persistence-condition, #impl-persistence-and-limits or INTRODUCTION headline 2 credits gain on a fixed channel with time it cannot buy, or under-credits gain at fixed noise." — `reviews/part-i-round-3-check-1#C16`

The same audit emphasis in the SOP: "Caveats that exist in Working Notes only, while the segment's punchline reads as universal in the OUTLINE table or downstream summaries, are integration debt" (`de-novo.sop.md` §5.5). The A.2 trace records "16 mismatches in 28 front sentences" (`INTENT.md:20`).

**C2. Do neighbours agree?** Explicit (`de-novo.sop.md` §5.2; INTENT C.3).

> "Is the (C1)–(C3) triple the same triple as in #der-loop-interventional-access?" — `reviews/b1-part-ii-check-1#C6`

> "Do the segment's statements of the negotiated stance agree with each other and with #deriv-self-actuation-grounding?" — `reviews/vol4-c1-check-3#C4`, broken

> "Does the causal-reach criterion give one verdict on every case it covers" — `reviews/vol4-c1-check-3#C1`, broken

**C3. Is the old form gone everywhere?** Explicit as "cascade closure" (`routing.sop.md:92`) and "drain". Answer: a grep with its result list, and a run of carriers named by file and line. Findings call the sites "carriers". Keyword floor: 11.

> "After the edits, a repository-wide grep for every retired form ... returns in the live layers only (a) sites inside the round-2 integrator's eight segments, (b) sites held by the Volume 4 lane, (c) correct uses of a different lettered family, or (d) generated outputs that quote (c)." — `reviews/part-ii-round-2-drains#C1`

> "After the landing, does any live segment, OUTLINE or toolkit document still cite $\alpha \approx 0.118$ or the estimated-time fit as evidence for the exponential form?" — `reviews/hyp-exponential-cognitive-load-a13-rerun#C3`

**C4. Does the cited source say that?** Explicit (FORMAT "Citation discipline", `format.sop.md:84–86`; relata). Form: `line: imported` (13), and a reading-state written into the prose.

> "Ikeda & Watanabe 1977, Theorem 1.1 with Remark 1.1, applies to $\xi = \lVert\delta\rVert^2$ with common diffusion coefficient ... for every $n \geq 1$, as canon transcribes." — `reviews/part-i-round-2-check-1#C6`

> "In Putnam's own 1978 workshop text, is $E$ in the software equation life-cycle effort, does the minimum time come from the gradient constraint "cannot be exceeded"..." — `reviews/tst-lane-check-2#C9`

Relata keeps an append-only verification store (cross-project, not ASF only): 443 events over 269 keys; criteria `bib-fields` 259, `anonymization` 76, `doi-resolves` 73, `claim-supported` 33, `page-ref` 1, `no-self-cite` 1; outcomes 387 verified, 35 n/a, 13 uncertain, 8 failed. So the store's mass is about whether the entry is well formed, and 34 events are about what a source says. FORMAT asks for those two kinds on load-bearing dependencies.

**C5. Does what we adopted preserve what the original carried?** Explicit in spike promotion: "*what did the spike establish that the segment does not say?*" (`format.sop.md:259`, the "Spike-segment reverse check"), and in the Appendix F fates:

> "Does every part of Appendix F (`~/src/_ref/temporal-feedback/Appendix-F-Multi-Agent.md`) now have a fate, carried in a named segment, asked as a vsect question, or set aside with a reason" — `reviews/tst-lane-check-2#C15`

> "The Appendix F deletion dropped content the account records as carried ("close enough to detail-operationalization"). #detail-operationalization has no source-reliability content." — `reviews/tst-lane-check-1#F1`

> "Is the AXIOMATA row true to PROPRIUM ontology v2 and consistent with canon that constrains it" — `reviews/vol4-c1-check-1#C3`

### D. Is what is said about its standing true?

The family I would least want the model to miss. Here the thing under check is a label, a note, a place or a tool's output.

**D1. Is a status note in the working layer still true?** Practice, with a name. 14 findings open with the phrase "Working-Note status signal:" (grep). Specimens:

> "Working-Note status signal: the audit-gold preamble (line 91) says the "F122–F126 cluster, esp. the Case-1-needs-goal-blind-projection-too point, is routed to the findings track; see report flags". It was not." — `reviews/items-recheck-t2#F2`

> "Working-Note status signal: the note at :326 says the per-event versus per-time normalization of $\alpha$ is "architectural; tracked in PROPOSALS" ... It was never there" — `reviews/items-recheck-q-2#F1`

> "Line 35 claims exactness by construction, which the housing result removes, and line 80 misstates the scope's stage" — `reviews/scope-adaptive-system-reread-1#F13`

**D2. Is the recorded reading-state true?** Explicit in the prose of canon and in checks.

> "Ikeda & Watanabe 1977 has now been read at the primary and the application checks (C6). The sentences at :279, in Epistemic Status and in Related Work that say neither the author nor the verifier has read it are no longer true; they should say what was read." — `reviews/part-i-round-2-check-1#F5`

> "Grebenkov 2015 eqs. (75)–(76) are the Lemma's integral and its small-noise form, and state no series; Graczyk & Jakubowski 2008 is correctly marked as not read." — `reviews/part-i-round-4-check-1#C3`

**D3. Is a location telling the truth?** Explicit (`spikes.sop.md:137`; `audits/.integrated/MANIFEST.md`): "Moving a file here asserts that." And the bulk move of 64 spikes that was not verified was later repaid spike by spike (`spikes/.integrated/VERIFICATION-2026-07-16.md`: 54 landed, 6 partially landed, 3 superseded, 1 nothing to land).

**D4. Is a verification claim verification?** Explicit, and one of the sharpest things in the corpus:

> "Tagging a step `[Verified]` because a document *says* it does not make it verified — it verifies the document, not the truth. The tell: a `[Verified]` whose object is "what file F asserts" rather than "the derivation holds."" — `spikes.sop.md:20`

> "Every entry in the hierarchy below — and the ledgers, CHANGELOG, INDEX, `NOTATION.md`, the segment's own assertion, the auditor's framing, and even multi-agent convergence — is a **mild proxy** that *drifts*." — `routing.sop.md:178`

**D5. Is the tier honest as stated?** The label question is the other readers', but checks ask it directly, and a tier can be checked against what it rests on:

> "...and the tier "remainder $O(n^{-3/2})$, bounded step by step" is honest." — `reviews/part-i-round-4-check-1#C1`

> "Line 46 tiers factor (i) *exact* because it "follows from #scope-agent-identity", which is `robust-qualitative` ... A factor that follows from a segment cannot be stated above that segment's tier" — `reviews/vol4-c1-check-3#F5`

**D6. Is the record itself faithful?** The check layer is audited for its own truth.

> "The ledger commit's "revise events for every segment edited in the two commits" is not what the store shows, and the record carries pre-rebase hashes." — `reviews/part-ii-check-1#F12`

> "This item and item:gated-tempo-nu-versus-tempo-collision were closed `--by-commit 47d76999`, the lane's pre-rebase landing, which no ref reaches" — `reviews/defender-noise-check-1#F7`

> "The integrator's typed record was committed but never taken: `vsect why review:vol4-c1-integration-3` reports no recorded act. Its eleven checks and three findings are invisible to the dashboard and to `vsect open`." — `reviews/vol4-c1-check-3#F1`

The event store has an act for this, `correct` (135 events), and specimens show it being used for exactly these seams: "The at: b15e947d is the pre-rebase commit, reachable from no branch."

**D7. Does a check still apply after an edit?** Explicit and mechanical (`agents.sop.md:41`; `vsect help model`): a check binds to the SHA-256 versions of the statement and its `depends:` closure, and lapses with the cause named. A second mind then says whether a rewording touched what the check read (`confirm-rewording`: 74 equivalent, 3 not-equivalent). A specimen of what that judgment looks like:

> "Items (a) and (d)-(g) are unchanged, but the housing result's statement changed. Sameness is now stated as agreement with the original as a pi_0 mixture, and a new claim is added ... C5 confirmed 'each as stated' at the old text; the singularity claim was checked only by its author" — a `confirm-rewording` event, `not-equivalent`, on `segment:scope-adaptive-system`

The cost has been measured from inside: "the one confirm pass that ran found about 3 in 120 bindings actually touched" (`tag-vs-now:97`).

### E. Who stands behind it, and what did they read?

**E1. Was the checker someone other than the author?** Explicit everywhere ("adjudicator ≠ grad-confirmer", `routing.sop.md:184`; "A checker is always a mind other than the author", `INTENT.md:33`). It is recorded as a free-text `role:` and a free-text name. There are 26 distinct role strings on events. The method of independence often lives in the name: `Claude Opus 5.5 (B.1 checker, bare brief)`, `Claude Opus 5.5 (A.1 fourth reader, bare brief)`.

The numbers bear on it. Across all 276 re-derivations, by the review's `author.role`: where role is `integrator`, 116 confirmed, 5 narrowed, 2 broken; where it is anything else, 88 confirmed, 43 narrowed, 22 broken. So 65 of 153 non-integrator re-derivations found something. The seven integrator non-confirmations all sit in `reviews/b1-part-ii-integration-1.md`, whose author is named "(B.1 Part II integration, second mind)": a second mind, with role `integrator`. The role field does not say whether the actor wrote the thing. ASF already has an open item on this (`items/separate-self-recorded-from-independent-evidence.md`, which reports 116 of 116 and 65 of 153).

**E2. What did the reader actually read?** Explicit in many places and many forms, and the question I would most like the model to have a place for:

- `read:` field on 139 of the checks: "the records in its basis it actually read".
- "What I did not check" sections: "Not opened: Debreu (1954), Bertsekas (2020) ... statements about them are from knowledge, marked `intuition-only` in the segment's Search Log as before. Not searched: ... Not re-derived: ... Not read: ..." (`reviews/part-ii-round-2-right-rung.md` :157).
- Audit §C coverage statement: "What did you read first-hand, what did you skim, what did you skip?" (`de-novo.sop.md` §7.5), and `coverage_summary` in FINAL frontmatter.
- A lead's "Read-ledger" of "what it has actually read, what it holds only on another agent's word" (`msc/inside-out-2026-10/HANDOFF.md`).
- Drain "Coverage" headers (`drain/msc-reflections.md`): "Read whole: ... Not done: I did not open the primaries the reflections describe".
- A verbs key in an assessment: "Where I say "I re-derived" or "I computed", I did it in this session from the text; where I say "I read", I read the diff or the file and judged it; where I say "not read", I did not look and make no claim." (`msc/tag-vs-now-assessment-2026-10-31.md:3`). That sentence is close to a vocabulary.

And the failure, in the objectives file:

> "The planted canary failed: vivarium's `LEXICON.udon` (its kingdom, law and participation ontology, 690 lines) and its `def-nomos`, `form-lawful-steering`, `def-in-vivia` were never read by any scout or drain. Item sources are prose, not a queryable field, so what was not drained cannot be listed" — `INTENT.md:75`

**E3. Was the reader primed?** Explicit: `priming_bleed` in audit frontmatter ("This is calibration data for the reader, not a confession", `de-novo.sop.md` §7.4), the auditor-hidden file list (`agents.sop.md:314`), and a bleed note at the top of a reflection: "**Bleed note.** Gold-block again arrived in the same read (whole-file Read). From the next segment onward I locate the `### Incidental audit gold` heading first and read only up to it." (`audits/AUDIT-WORKING-731548/03-def-action-transition.md`).

**E4. What was the verdict's own reach?** Records of limits on a check:

> "Spot-check of the three support facts" — `reviews/scope-adaptive-system-check-5#C6`

> "Anything the checker's confirmed verdict missed?" — `reviews/b1-part-ii-integration-1#C10` and `#C11` (a check of a check, asked as such)

> "What would most change a verdict here: a second derivation of F5(b), the F6(iii) identity and the F2 recalibration identity (all mine, all short)." — `reviews/part-ii-check-1-distortion.md` :295

**E5. Can someone do this check again?** 498 of 500 checks carry a `recheck:` recipe, separate from the criterion. Examples: "The sentence to test hardest: "a theorem on one side and a hypothesis on the other" against :74–:96 of the sector segment." (`reviews/a2-front-door-trace-1#C1`); "grep the segment for "forced by information dependency", "ORDERING is exact", ..." (`reviews/b1-part-ii-check-1#C16`).

**E6. Is a finding about a theory real?** Explicit and strict: the critic carries a burden. Per-finding shape (`de-novo.sop.md` §7.6): verbatim passage, counterevidence search, status (`still real / already caveated / ambiguous / rescinded`), confidence with reason, why it still stands. Rejected candidates are part of the deliverable (§B.1 "Rescinded candidates"), and an explicit zero is worth more than padding: "No findings I can defend after first-hand reading."

### F. What became of it?

**F1. Where did each finding go?** Explicit: "**The job is not to do what the audit said — the job is to take each finding, decide what is and is not valid ... and route it to the right home**" (`routing.sop.md:11`). Disposition vocabulary at `routing.sop.md:170`. Spikes: the five-state table (it has six rows: `integrated-filed`, `integrated-misfiled`, `orphaned`, `correctly-superseded`, `archived`, `live-or-open`; `spikes.sop.md:108–115`). Findings carry a resolver in prose: "Resolver: anyone with both transcripts and the emergence-conditions segment." (`reviews/vol4-c1-integration-3#F3`).

**F2. Which way did the repair go?** Explicit and central: a closure can be in the wrong direction. "the test is "closed *in the right direction*," not merely "closed."" (`audits/.integrated/MANIFEST.md`). Spike completion states: strengthened to the claim, past it, a no-go, or "strengthen failed", which "is never a quiet landing; it is an alarm" (`routing.sop.md:66–71`). A no-go collapses the auditor's proposed fix too: "**There is no downgrade option.**" (`:84`).

**F3. Is this a restoration of something deliberately corrected away?** Explicit: the "regression axis". "The question is never "is it in canon?" alone — it is "is canon's current state, here, the *post-correction* truth, and would this spike's content *regress* it?"" (`spikes.sop.md:100`). The instrument is `git log -S`.

**F4. What is owed, by whom, and who may close it?** The vsect ledger, mechanically: items (859; `owner:` a KR id, or prose such as `unowned: no KR`, `C.1 integrator (unassigned)`; 197 have `owner: ""`), questions (64; `closer:` 61 `anyone`, 1 `steward-fact`, 2 `awaiting:…`), and an "owner by KR" check. Recheck verdicts on imported tracker lines form their own scale: 176 holds, 60 not-an-item, 47 duplicate, 39 superseded, 31 landed, 21 stale (374 events). A question's closer can be a specific piece of unbuilt work: `closer: awaiting:a multi-agent codebase simulation`.

**F5. Does a finding stand answered?** `review-finding` with `outcome: answered` (131) from a mind other than the finding's author, the criterion stating what was read. And the "Answers" form of check: 19 criteria use it.

> "Answers `review:part-ii-check-1-distortion#C8/finding` and `#F4`: Bennett's lemma bound stated and tight; "exact" moved from the $\lambda \cdot \mathrm{sd}$ factorization to the bound; the support factor and the high-gain engineering statement." — `reviews/part-ii-round-2#C13`

**F6. May it stop here?** Explicit counterweight to all the above: "**The gates exist to prevent false confidence, never to forbid honest incompleteness.** Duty is discharged — fully — when, *at the current level of understanding*: 1. the artifact carries its **honest tier** ... 2. its **Working Notes state precisely what is unresolved and what would resolve it**; and 3. the open remainder is **released to the standing cycle**" (`spikes.sop.md:26–30`).

**F7. Does the check fire without someone remembering?** Explicit as of the system review, and I think the sharpest piece of meta-accounting here: a table of each mechanism, "Designed to fire when", "What actually fires it", "State today" (`system-review/00-system.md`, §2): "**does it fire without a person remembering?** If it does, keep it. If it does not, it is a wish".

### G. Can it be read, found and placed?

**G1. Can a cold reader settle it?** Explicit (KR A.1, H.3), and a check criterion in its own right. Keyword floor 7.

> "KR A.1's cold-reader clause: can a reader settle membership on the page for a Kalman filter, for tabular RL, and for standard RL with continuous dynamics?" — `reviews/scope-adaptive-system-check-8#C11`, narrowed

The de-novo protocol's prompts (`de-novo.sop.md` §4.4, 14 prompts) ask a reader per segment for predictions, cross-segment consistency, what they would change, and how valuable it feels. Comprehension has also been tested directly, by quiz (`bin/make-quiz`, `msc/quiz-responses/`, with scores).

**G2. Does the plain-language gloss transfer?** Explicit: the Feynman criterion, with a real test: "the test is whether a reader can predict the qualitative consequences of perturbing the analog and have those predictions hold against the formalism" (`format.sop.md:393`). And: "the analog must be **isomorphic, not merely evocative**" (`agents.sop.md:296`).

**G3. Is it in the right place, with the right edges?** Mechanical and structural: canon boundary ("A canon reference to an internal artifact is an integration failure, by definition", `spikes.sop.md:43`); segment-voice not diff-voice; what earns a Working Note (`format.sop.md:467`); dependency genuineness and ordering (Gate 1, `:221–224`), with accepted-by-design violations tabulated (`OUTLINE-accepted.md`, each with date and reason); declared gaps (`--GAP--` rows and `missing` stage; `bin/segment-stats`).

**G4. Is a signal findable at all?** I.10 measures it: "count the live places outside the segment body and its ledger items where something about the claim is written ... and how much of each a cold agent must read to learn what is known and what is open" (`INTENT.md:76`). A surface whose subject is the cost of the other surfaces.

**G5. What is it called, and does the name overclaim?** Explicit: nine criteria (`doc/sop/naming.sop/principles.sop.md:71–`), including scope honesty and standalone citability; five decision categories; append-only decision events `terminology/decisions/<slug>/<ts>-<decider>-<action>.md`; multi-agent voting rounds (629 currents, 506 unrouted, per PRACTICA).

**G6. Does it render and lint?** `md-press`, `bin/lint-outline`, `bin/check-links`, `bin/refresh-all --check`, `vsect check`, gathered in `bin/check-commit`. Gate 3 is the SOP form. See section 5: the hook is currently off.

**G7. Has anyone looked for prior art, and how hard?** Explicit: Findings schema (50 entries in 48 files): Novelty Claim posture (recognition 19+, differentiation 10, integration 5, novelty 4, synthesis 2, transfer 2), Related Work with `published` and `found` dates and a relationship label (formal antecedent 91, adjacent literature 54, conceptual precursor 27, empirical instantiation supporting 15, partial anticipation 3 ...), and a dated Search Log with depth: `not-conducted`, `cursory`, `targeted`, `nominally-comprehensive`, `comprehensive`, `intuition-only`. "The Search Log is the discipline that prevents `Claim novelty on...` from being hubris." (`format.sop.md:451`). Specimen: "2026-10-30 (*not-conducted*): the right-rung hypotheses ... were derived here and not searched for in the restricted-policy-class literature" (`deriv-convention-monotonicity`).

### H. Was it worth it, and is the process itself sound?

**H1. How much does it matter?** Explicit: "A fact-check that would change nothing written is not where effort goes." (`agents.sop.md:9`); audit prompt 12, "How valuable does this segment *feel* to me? This ends up being a strong latent signal"; the "worthy gate" on Wisdom, Strength and Beauty (`de-novo.sop.md` §7.12); Findings' Brief and Impact. Implicit: check concentration. 94 distinct targets receive the 500 checks; `scope-adaptive-system` 74, `deriv-sector-condition` 44, `hyp-exponential-cognitive-load` 34. Whole-record: "records with a check recorded 94 · holding now 6 · without any 1140" (`vsect`).

**H2. What grounds a rule, and what do you owe it?** Explicit: rules carry two axes, groundedness (provisional, coordination, hard-won, mission-grounded) and posture (revisit-freely, obey-first-then-ask), `routing.sop.md:27–46`. "**this filter is itself unpurified**" (§7). The SOPs put their own scars in as provenance.

**H3. Does this finding or brief or process get feedback?** Explicit: §G of the FINAL, "process/instruction-feedback" disposition, closing notes in reviews ("Feedback on the brief: it worked for me — reading cold first was the right suggestion"). Soft material has a first-class home (`audits/polish-and-sentiment-ledger.md`, with bands `polish`, `sentiment`, `considered-declined`, `research-seed`), where a declined idea keeps "*with the reason*".

**H4. Is the agent's first-encounter cognition itself a kept object?** Explicit and unusual: "**the gold**" (`audits/README.md`); it may not be thrown away "*just because it was "irrelevant" to theory fixes.*" Lifted to segment Working Notes with attribution by substrate and audit (124 occurrences of "audit gold" in segments).

## 3. The surfaces, as a table

"Fires" says what makes it happen, as far as I could see. This is the census form of section 2.

| Surface | Grain | Asks | Answer form | Who | Size | Fires |
|---|---|---|---|---|---|---|
| `reviews/*.md` check (`## Cn`) | named part of a segment, recorded at segment | A1–A5, B2, C1–C5, D5 | target, act, line, read, criterion, committed, outcome, recheck | any named mind | 500 | an agent running `vsect take` |
| `reviews/*.md` finding (`## Fn`) | a sentence or site | anything wrong or missing | prose, often with carrier list and proposed text | same | 200 | same; narrowed/broken also open a finding automatically |
| `.vsect/events` | statement version | D6, D7, F4, F5 | content-addressed YAML, 2,259 | verbs, not hand | 17 acts | every verb; version binding is mechanical |
| `items/`, `questions/` | claim or work | F4 | frontmatter + one-paragraph body | any | 859, 64 | `vsect note/ask` |
| `## Claim Record` | one claim | B1–B3 | six fixed fields | author, then checked | 79 in 24 files | KR B.1 only so far |
| `## Findings` | a contribution | G2, G7, H1 | five fixed fields, dated log | author | 50 in 48 files | `bin/extract-findings` |
| `## Working Notes` | segment | forward pointers, regression guards, dead ends; also gold | prose | anyone | 238 of 247 segments | nothing; no segment has reached Gate 4 |
| `stage:` + OUTLINE Stage cell | segment | Gate 1–4 | one word, 4 gates of checklists | reviewer | 205 draft, 23, 17, 2; 0 at format-clean or candidate | "known to go stale ... currently ignored in practice" (`format.sop.md:191`) |
| Spike status (INDEX, README) | spike | F1, F2, D3 | prose status + location | agent | 64 live entries reported | agent remembering |
| `audits/` FINAL + working dirs | audit | E2, E3, E6, H3, H4 | frontmatter + §A–§G; per-segment reflections | de-novo reader | 24 working dirs; 4 FINAL and 15 findings extracts at the top level | a launch |
| Audit dispositions (pending-findings, MANIFEST, polish ledger) | finding | F1, F2 | enum + reason + commit | adjudicator ≠ confirmer | ledger files | agent |
| `empirica/` MANIFEST + RUNS | experiment | A4, A6, B3 | manifest + run table with seed, digest | author | 4 experiments | contract |
| relata verifications | bibkey + criterion | C4 | append-only event: criterion, outcome, note | any | 443, cross-project | agent |
| `terminology/` | term | G5 | entry + append-only decisions | any | 177 entries, 152 decision dirs | `bin/term` |
| Generated fronts (README, FINDINGS, LEXICON) | built | C1 | regenerated | build | — | `bin/refresh-all` |
| `bin/check-commit` (md-press, lint-outline, check-links, refresh-all, vsect) | commit | G6 | pass/fail per file | tool | — | off since 2026-11-04 |
| Commit bodies and `Claude-Agent:` trailers | commit | E1, D3 | prose, trailers | agents | 2,081 commits | hook |
| `CHANGELOG.md` / `LOG.md` | cycle | what changed, why | dated prose | agents | 500 KB | agent |
| KR tree (`INTENT.md`) | objective | F4, F7, whole-work state | one line + status per KR | lead | one file | lead |
| `msc/` reviews (owner, system, I.10, tag-vs-now, meta-process) | the whole | F7, G4, H2, and everything | essays, measurements | one-off minds | large | a request |

## 4. Vocabularies in use

These are the closed or nearly closed value sets I found. They are not one scale and I would not try to merge them by eye. Counts where I took them.

| Where | Values |
|---|---|
| Check `outcome` | confirmed 373, narrowed 84, broken 43 |
| Check `act` | rederive 276, read-check 122, run 88, read 10, instantiate 4. `vsect help take` lists `rederive, instantiate, run, read-check, assert, decline`: `assert` and `decline` have zero uses, and `read` is used but not listed |
| Check `line` (used) | derivation 358, correspondence 44, measurement 40, discussion 24, simulation 19, imported 13, reading 2 |
| Check `line` (declared in `kinds.yaml`) | derivation, simulation, instance, imported, measured, testimony, each with named rungs |
| Act × line | Not one thing: `run` against `derivation` 29, `read-check` against `derivation` 49. What the checker did and what warrant it speaks to are two axes |
| `kinds.yaml` rungs | `drafted, premises-checked, independently-rederived` and so on. Grep over events, reviews, items, questions: no file contains any of the rung names I tried |
| `criterion:` on events | one word for four things: the check's test, a rechecker's reason, a second mind's account of why a rewording is equivalent, a verifier's account of why a finding is answered (1,069 events carry it) |
| Recheck outcome | holds 176, not-an-item 60, duplicate 47, superseded 39, landed 31, stale 21 |
| Close outcome | done 18, superseded 8, duplicate 3 |
| Rewording | equivalent 74, not-equivalent 3 |
| Claim register | formal 51, descriptive 18, normative 10 |
| Spike completion | (A) to the claim, (B) past it, (C) no-go, (D) strengthen failed |
| Spike disposition | six states, under a heading saying five |
| Audit finding status | still real, already caveated, ambiguous, rescinded |
| Audit routing suggestion | New, Known-unintegrated, Known-resolved, Tooling gap, Scope/status mismatch |
| Finding disposition | resolved, resolved-by-strengthening, resolved-by-strengthening-then-no-go, correctly-rejected, architectural, subsumed-by-later-work, duplicate, soft bands, process/instruction-feedback, actionable-open |
| Ghost forms | own no-go in an appendix, quick no-go, disappears to CHANGELOG, something else |
| Polish ledger | bands polish, sentiment, considered-declined, research-seed; status open, applied, → SP-NN, → TODO, superseded-by, noted |
| Search depth | not-conducted, cursory, targeted, nominally-comprehensive, comprehensive, intuition-only |
| Relationship to prior work | ten suggested labels, open |
| Relata outcome | verified, failed, uncertain, n/a |
| Rule standing | current ops, convention SOP, evolved ops, authoritative SOP |

## 5. Things that surprised me, and my judgment of them

**The check record has a better account of grain and relation than its keys do.** Reviewers name "`:229`", "Item (g′)", "Record 4", "the Brief", and "the same sentence in `#x`". The key is the file. That is declared provisional, and it will matter for the model: a check that "binds to the exact versions it read" lapses whole-file, which is the cost reported in `tag-vs-now:97`. The `read:` field is the first patch and is present on 139 of 500.

**"Narrowed" carries more than the dashboard gives it.** `vsect` lists two records under "Known broken ... a check narrowed it". Fable's assessment says that register "overstates a `narrowed` outcome" (`tag-vs-now:60`). I would go further. A narrowed claim has a live residue, which `broken` does not, and the reviews usually state the residue. Part of what makes this hard is that the residue is prose.

**Reading-state is written into canon prose.** I had not expected to find sentences in `deriv-sector-condition` saying who had or had not read a cited paper, or a check confirming a "not read" marking was correct. 13 occurrences of "not read" and 7 of "read at the primary" in segments (grep). The Search Log is the disciplined form of the same thing. This bears on E2.

**Two kinds of check are doing different work under one schema.** Rederive checks by an independent reader are search (65 of 153 found something). Integrator checks are closure records (criterion written as the result, often beginning "Answers"). They are distinguishable in the text, and only partly in the fields.

**Absences are first-class almost everywhere they are possible.** "Instantiated: no", "*not-conducted*", §C coverage, "What I did not check", §B.1 rescinded candidates, "explicit-zero", `--GAP--`. A model that represents only what was done would lose a large part of what this corpus records on purpose.

**Declared mechanism and record disagree in places, in the direction the SOPs warn about.** Specimens I tripped over:

- `doc/sop/agents.sop.md:41` says "the pre-commit hook runs `vsect check`". `.githooks/pre-commit` has `exit 0` since 2026-11-04 ("Disabled on 2026-11-04 at Joseph's request, "for now""), so nothing gates a commit at this HEAD. The global CLAUDE.md index says the same as the SOP.
- The escalation forms in `routing.sop.md:90–92` (`status: FALSE`, `unlikely in current form`, a visible `TODO: FIXME`) appear in no segment (grep over the four `src/` trees). The `known-defect` disposition in the vsect model has zero uses. These may be unused rather than failed; I did not establish which.
- `audits/.integrated/MANIFEST.md` still names `../STATUS.md` as "the live routing tracker"; `routing.sop.md:163` says that file was retired on 2026-10-30.
- `PRACTICA.md:31` still says "the Three Deaths", which the project has retired as a name.
- `format.sop.md:70` gives the bibliography database as `~/src/relata/`; that directory does not exist on this machine (`relata` is on PATH, data at `~/.local/share/relata`).

**On the brief's own frame.** "How each of its pieces stands" presupposes that standing attaches to pieces. The corpus suggests standing is at least: (a) dated and bound to versions, (b) often relational, between a body and a restatement, or a claim and a source, (c) sometimes held by the words about the thing, not the thing, and (d) several independent axes, with no one of them able to answer for the others. "Exact" answers none of B, C, D, E or F, which is the reason Claim Records exist. I would not call the question misconceived. I would widen it from *how does a piece stand* to *what can be asked of an item in the record, and what form may the answer take*.

**On what is missing from the account.** I found no surface asking whether a *reader's trust* has been earned over time for a given mind or substrate, beyond free-text attribution; and little on *whose judgment is reserved* since the 2026-10-30 standings lifted the Joseph gates (the older `DECISIONS-CENSUS` and "steward-fact" closer are the remnants). I did not read enough of the working dirs to say whether either is asked there.

## 6. Feedback on the brief, and adjacent notes

The guess about the `reviews/` criteria was right and was the highest-yield single read. The separation of status words and Epistemic Status to other readers was workable; the one seam is "Max attainable", the derivation-audit tables and the Claim Records, which sit in or next to those sections. I took the last two and left the first. The instruction to say what was read whole shaped how I worked, and I think it changed what I read.

Aspectus showed the shape correctly and I have nothing for its inbox. I wrote only this file.

I am available for questions.

## After writing

After finishing the text above I looked at one thing in the previously off-limits trees, to resolve the open item in A6. I did not open any earlier census or survey, so the comparison you want is still clean.

`committed` is defined in the archived vsect source: "Was the criterion fixed before the outcome was seen? before | after." (`~/src/verisectorium/.archive/prior-vsect/src/main.rs:81`), and in the design: "whether that criterion was fixed before the outcome was seen" (`~/src/aat-v3/.archive/msc/vsect/model.md:60`). So A6 is correct to treat it as a pre-registration field. Two things follow that my text did not say:

- The source's outcome list also has `inconclusive` and `failed-to-run` (`main.rs:84`). Neither appears in the 500 checks.
- 226 "before" and 274 "after", set against the fact that the field is never defined in anything an agent working in ASF is pointed to (I found no statement of it in `agents.sop.md`, `format.sop.md` or `vsect help take`), means I cannot tell how carefully it was filled. Note `b1-part-ii-integration-1`, where an integrator wrote `committed: before` on checks whose criterion names the defect it found. That reading would fit "the question was fixed first", and would also fit a default: the flag's default is `before`, whereas a review-record item with no `committed` field defaults to `after` (`verbs.rs:833`).
