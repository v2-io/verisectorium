# De novo audit of `msc/notes/18-2026-11-08-dimension-census.md`

*2026-11-08. A Claude Code agent (Fable 5.1), briefed with one sentence: audit the note, write this file. I had not read the note, the `census-*.md` reports, or any `core/` file before this session. I read the note whole (620 lines), then went to the sources it names. I did not read the nine reports whole; I read their headings, their coverage and afterword sections, and every passage the note cites by section number. Nothing here has been checked by a second mind.*

*How to read this: the finding list is the content; silence about a claim means only that I did not reach it or it held. Section 4 says what I checked and did not.*

---

## 1. The short version

The note holds up well on what can be recomputed and on most of what can be looked up. Every count I re-ran from primaries reproduced (500 outcomes as 373/84/43; 247 `status:` values over eight words; 205 `stage: draft`; 220 Epistemic Status sections; 115 vivarium segments all `draft`; 488 checks in the sprint's vsect flow). Of roughly fifty quotations I traced to their source files, all but two are verbatim or are honest fragments of a longer sentence, and the attributions to Joseph's messages resolve to real messages at the stated times with three exceptions, each off by one message.

The defects that matter for a cold reader:

1. **Two paraphrases are wearing quotation marks**, and the note's own preface says a script confirmed that every quotation exists in its source. That claim is not true as written; either the script did not cover these or its matching was loose. (§2.1)
2. **The abbreviation key refers to "the joseph-messages file above," and no such file is named anywhere in the note.** The reader cannot resolve the eleven `JM` citations without finding `~/src/aat-v3/preparations/research/joseph-messages-2026-10-28--11-05.md` on their own. (§2.2)
3. **The second pass corrects the census tables in prose but leaves the tables uncorrected**, and the warning tells the reader to "trust the reports" where they disagree. For a note whose stated use is "deciding what the model should say," rows A14–A16, E3 and F3 are now known-stale and still read as current. (§3.1)
4. **Finding 3 says `«truth·determinant»` "says nothing about their order."** Its Working Notes do: a conflict between two determinants is resolved by "a «bound», consulted at the moment," which is exactly the second of the note's three kinds of ordering (precedence in a conflict). (§2.4)

Everything else below is smaller.

---

## 2. Fidelity findings

### 2.1 Quotations that are not in their sources as quoted

| Note | Quoted as | Source actually says | Where |
|---|---|---|---|
| I2, line 306 | "a gate, not a dimension" | "A gate, never a rung" | `pi/theory/influx/segments-model-rc1/10-FOUNDING-QUESTIONS.md:7`; the same phrase in `segment-research/securing-contract-2026-08-14.md:20`. "not a dimension" occurs nowhere in RC1 or the archive that I could find. |
| Finding 1, line 451 | PLAN had "A record has no importance in general, only importance-for" | "**Importance is an aspect, and always *for* a target:** a purpose, a decision, a consumer." | `prep/PLAN.md:171` (and its frozen copy `msc/notes/02-…:171`). No file in `prep/` or `msc/notes/` carries the quoted wording except note 18 itself. |

Both paraphrases sharpen the source toward the note's thesis (the second one toward Finding 1's "second argument"). The thesis survives either way; the quotation marks do not. Line 5's sentence, *"a script compared each quotation against the source files after this was written (it confirms the words exist in them…)"*, should be softened to say what the script actually matched, or these two should lose their quotation marks.

### 2.2 Citations a cold reader cannot resolve

- Line 10: **"JM 11-04 18:46 is the message at that local time in the joseph-messages file above."** Nothing above or below names the file. Line 34 calls it "Joseph's messages file: 62 of 174 messages." The file is `~/src/aat-v3/preparations/research/joseph-messages-2026-10-28--11-05.md`. It is headed as never meant for a public repo, which may be why the path was dropped; if so, the note should say that and still give enough to find it.
- The "Second pass" table (line 50) reads `census-es-reader-a.md (Opus)`; reader A's own header names no model. Reader B's names Fable 5.1. Not wrong that I can show, but unsourced.

### 2.3 Attributions to Joseph's messages that are off by one message

I resolved all eleven `JM` timestamps to `####` headings in the messages file. Three quotations sit under a different heading than the note gives:

| Row | Note says | Quoted phrase is actually under | Note |
|---|---|---|---|
| D7 (line 235) | `JM 11-03 15:06` for "easy to apply but difficult to reverse" | `2026-11-05 18:50` (file line 996). The 15:06 message (lines 417–422) contains nothing on reversibility. | The phrase is also in `msc/notes/08/08:24`, which the row cites and which is correct. "impact radius" is at `11-03 18:43` (line 546) and in udon's CTQ. |
| D8 (line 236) | `JM 11-03 16:09` for sustaining levels and "no confidence" | "no confidence" is under `11-03 16:39` (line 503). The 16:09 message does discuss what "object" does to closing, so the row's citation is apt for the levels, not for that phrase. | minor |
| Line 85 | "aat-v3 session `92e38652`, 2026-11-06 19:57Z" | The passage ("how sharp … what conditions … how it is supported") is in that session's transcript; the nearest timestamps I found are 19:55–19:56Z. | within a minute or two; not a defect |

The remaining eight (`11-04 18:46`, `17:59`, `18:14`, `18:57`, `15:32`; `11-03 18:43`; `11-05 18:09`; `10-30 23:18`; `11-02 18:54`) resolve exactly, and the long 18:46 block (lines 343–352) is verbatim including its bullets.

### 2.4 Where the note mis-describes a `core/` text

- **Finding 3 (line 20 and 490):** "The current «truth·determinant» text says each is asked about separately, which is true, and says nothing about their order." The def's Working Notes, fourth bullet: *"where they conflict, which yields is a «bound», consulted at the moment."* That is an ordering of the second kind the note names (precedence in conflict), and it is the def's lean, not a stray remark. The note's *"what it puts to the model"* for Finding 3 asks whether an ontology declares such an order; the def has already half-answered. Finding 3 should engage with that lean rather than report an absence.
- **Finding 6 (line 546):** "the outline's «claimed·level» reads 'one only, the rest in the log'… although its own Part II neighbours have begun to take it apart." True of the outline row and the def's invariant. But `core/def/claimed-level.md`'s own Working Notes already say: *"Open. Whether 'claimed level' is one field or several. ASF's labels say what is asserted is several separate things: conditions, sharpness, forced or chosen, kind of support, whose. See «claim»."* The split is acknowledged inside the term, not only by its neighbours. The note under-credits the def and so slightly overstates the tension.
- **Finding 5 table (line 521):** the "Current outline" column lists `«decision»` as a term. In `core/model.outline.md` it is a subtype, `‹decision›` of `«act»`. Minor, but the outline's legend makes the distinction load-bearing.

### 2.5 Where the note mis-carries a report's correction

- **Line 122:** "Only axes A and B are typed; C and D are free strings, and **A14–A16** describe a LEXICON draft." The vivarium reader (`census-vivarium.md` §9) says: *"Rows **A15 and A16** describe the LEXICON draft, not what is carried,"* and that axis B (the note's A14) **is** typed. The note extends the correction one row too far. Rows A14–A16 themselves (lines 172–174) still carry Mode `E` and the LEXICON wording, uncorrected; see §3.1.

### 2.6 Claims I could not source

- **Line 539:** "ASF's frontmatter `exact` on `deriv-stochastic-non-exit`, true of two claims of three (08/04)." I found no such statement in `msc/notes/08/04`. That note says the segment's Claim Record has three entries (line 17) and nothing about which are true. The missed-error report says Prop A.1S(i) is false; the "two of three" is presumably the author's inference joining the two. The inference may be right; the citation is not where it is said.
- **Line 56:** "`census-joseph-words.md`: 144 passages." The report has 188 dated entries, 7 of them marked "left out" (date and location only). I could not get 144 from its structure. Not shown wrong; not reproduced.
- **Lines 34 and 56:** "174 messages" in the Joseph-messages file. By `#### 2026-` headings the file has **173**; there are no other heading forms. The joseph-words report also says 174, so the number was inherited, not counted here. One off; worth a recount by whoever cares.
- **Line 540:** "Vivarium before its 2026-07-13 split." I found the `verified`-as-stage sentence (`vivarium/FORMAT.md:78`) but nothing dating a split to 07-13; the only 07-13 in FORMAT is an example of a date *not* to write (line 219). Unverified, not refuted.
- **Line 541:** live_docs' current README values. I could not locate a live_docs checkout under `~/src` at depth 5. The RC1/95 half of that bullet is confirmed (`95-ADDENDUM…:17`).
- **Line 305:** "SF burst 5a." The verbatim file has `## Burst 5 — Fidelity` and a sub-heading `### Burst 5a — correction (interrupt)`. Fine, but the I1 quotation "Fidelity is the substrate" is RC1/03's wording, not the SF file's; the row cites both, so no error, only a nudge to check which carries the words.

### 2.7 What held

So the record is not only a list of defects: these were checked at the primary and are as the note has them.

- `core/`: «bound» "There are no degrees of a bound"; «truth·determinant» "chooses among them and adds none of its own" and "each is asked about separately"; the outline's «scale» "a ladder, an unordered set, or a number" and «dimension» "about a piece"; «claimed·level» "one only, the rest in the log"; «latent·level» and «ground» exist as the note says.
- RC1: "Fidelity underlies everything" (01-SPINE:62); "Fidelity is the substrate, not a peer" (03:30); the Q5 two-columns sentence (10:12) verbatim; "assignable from kind" (03:70, 10:13); the usage-license cell "declared, not secured by degrees… projected from Evidence outcomes + Backing declaration" (03:61); "Freshness against the population it tracks" (01:36); "nothing after capture" (01:25); "on disagreement, I lose" (03:64).
- ASF: `FORMAT.md:189` "Orthogonal to epistemic status"; `:191` "currently ignored in practice"; `:535–539` "Max attainable: [status]"; `.vsect/kinds.yaml` lines and rungs exactly as rows A1, A7, A8, A9, A11 give them; "RESOLVED in canon — do not re-open" is the missed-error report quoting Working Notes (`missed-error…:36`); "pre-answered my strongest planned attack" is in `asf/audits/AUDIT-WORKING-731548/25-deriv-sector-condition.md:36`; the eight quotations in Finding 4's table are all in `missed-error-case-2026-11-06.md`, `INTENT.md` A.2 and E.3, or `SF` burst 1, as given.
- The inline-labels report: 15 items; "790 labels… about two"; 472 / 138 / 95 / 47-of-which-22 / 17 / 12 / 11 / 8 / 8 all as the B-family rows use them; the coverage sentence about `disc-`, `emp-`… and volumes 2–4.
- Vivarium: "B OVER A (Joseph, 2026-07-03)", "VIBE-MODELING = HIGH D RIDING ON LOW B/C", "Lawful first, Earth-shaped second" (all `LEXICON.udon:290–293`); "THIS IS THE ONE FIELD WHERE AN ERROR IS NOT MERELY WRONG" (`DECISIONS…:74`); "An unprincipled value is not the sin — *an unaccounted one is*" (`ASSUMPTIONS.md:16`); "An inlined definition is not a copy. It is a fork." (`FORMAT.md:213`); "decalibrates the instrument"; the "it is in the ledger, therefore it can wait" shape (`norm-declared-violation-is-not-license.md:19`); "convict" in 62 of 115 segments (I count 63 files under `core/` including `OUTLINE.md`).
- Elsewhere: udon `conv-verification-and-status.md:34,36` carries both Joseph quotations on kind and max; `CTQ-FACTORS.md:16` the veto/weights/impact-radius sentence; `address-theory/DECISIONS.ud:9–15` a seven-value `decided-by` legend; `generic-collab-council.md:74–76` the six sustaining levels and "declared in the charter, by importance"; `limen/VERDICTS.md` uses exactly `confirmed`/`applied`/`positive`/`pending`; `ai-risk-model/CLAUDE.md:21–25,40` the three truths and the conflict-of-interest line; comproprium `PROVENANCE.md:8` "Agent self-reports are the weakest class present"; `TAXONOMY-FILL-v1.md:54` rates Ceiling `veritas-critical`; `foundation-axis…:11` the March ladder ending "Cargo cult / Unprincipled"; `deployments.md` "Updated 2026-08-05" with tiers A–F; the `~/.claude/history.jsonl` 08-14 orthogonality quotation exists once, at a timestamp that is 2026-08-14 evening local.
- Reports: `census-asf-surfaces.md` 500 checks / 200 findings clipped at 420 / 23 of 24 audit dirs skipped / 263 / 65 of 153 and the `author.role` caveat; `census-tools-and-papers.md` §5 `REQUIRED_FOR_PASS = bib-fields doi-resolves anonymization`, keyed by criterion alone, `n/a` breaks the roll-up; `census-udon-address.md` `verification-level` on 0 records, `awaiting-second` on 236 of 236, VERBATIM read to line 991; `census-source-stores.md` 472 licence keys, 57 of 57 `:stage draft`; `census-vivarium.md` 24 segments whole, 95 ES sections, "no other value of `stage` has ever been written" in git history, and three things "read and failed to carry"; `census-tools-and-papers.md` one miss; `census-august-surveys.md` §0 discloses the dozen leaked lines; reader A 804 labels and nine ceiling sorts; reader B 802 labels, "155 of 220", "at least four things" for Max attainable. Every L-row's section pointer (L1–L26) lands on a heading of the right name in the named report.

---

## 3. Structural observations

These are not fidelity errors. They are what a cold reader trips on.

### 3.1 The tables are stale by the note's own account, and the note asks the reader to hold both

The warning (line 8) says *"Where the two disagree, trust the reports."* The "Corrections to the first pass" (lines 120–125) then names specific rows as wrong: A14–A16's mode, E3 "thin," F3 "expires visibly," Finding 2's conjunction, Finding 4's basis. None of those rows or findings were edited. A reader who comes for the census (the tables, lines 149–334) and not the narrative gets the first-pass values with no marker on the row. The cheapest fix is a mark in the affected cells pointing to the correction; the honest one is to apply the corrections and let the history layer hold what the first pass said. The note's own Finding 9 ("A note saying it is settled… sat above a false result") is the pattern it is at risk of.

### 3.2 Two censuses, not one

Lines 91–118 (L1–L26) are a second question list in a different numbering, not folded into A–K. "In brief" counts "a little over a hundred" (the A–K rows total 109) and "eleven families"; neither number includes the 26. Several L-rows are clearly members of existing families (L2, L3 → D or K; L5 → F; L16 → A/I; L23, L24 → D) and the tools reader's afterword already proposed homes for several. Leaving them as a separate list means the "What the earlier lists leave out" table (Finding 5) was computed against 109 rows and not 135.

### 3.3 The canary was scored by the author

Lines 61–83 compare two blind reads against the 15-item list "by me, from reading both reports." The author also wrote the first pass that failed the list. The comparison is disclosed and looks careful (I spot-checked items 1, 4, 8, 13, 15 against the reports and agree with the cells), but it is the one place in the note where the author grades their own canary, and a second reader would cost little.

### 3.4 What the preface promises versus what it did

Line 5 makes three promises: quotations copied from the named source (two failures, §2.1); a script confirming words exist (overstated, §2.1); attributions "checked by eye on a sample" (three off by one message, §2.3). These are the right promises to make, and the failure rate is low; the wording should match the rate.

### 3.5 Things done well that a reader should not have to rediscover

- The coverage table (lines 29–38) and "The largest limit on this census" (line 25) are unusually honest about priming and about what was never opened; they let me plan this audit in minutes.
- "Joseph's own words, by family" is kept verbatim and separate, as he asked; every quotation in it that I traced is exact.
- Finding 4's table is the strongest single thing in the note: eight distinct questions under one word, each with a specimen that exists where cited.
- "What I could not tell" (lines 611–619) names the right open questions, including whether the eleven families are the right cut.

---

## 4. What I checked, and did not

**Recomputed from primaries:** outcomes in `asf/reviews/` (500 = 373+84+43); `status:` and `stage:` across the four ASF volumes; `## Epistemic Status` count; vivarium `stage:` and "convict" counts; Joseph-messages heading count; the reader reports' line counts.

**Traced to the named file and line:** roughly fifty quotations (every one in Findings 1–9 and the disagreements section, all eleven `JM` citations, the `core/` quotations, the RC1 cells for rows A10, A17, D1–D4, H1–H5, I1, I2, the ASF FORMAT and kinds.yaml rows, the vivarium, udon, address-theory, council, limen, ai-risk-model, comproprium and archive specimens named in §2.7).

**Checked against the report, not the primary:** every number the note takes from a `census-*.md` report (263, 65 of 153, 472, 57, 236, 0, 804, 802, 155, 24, 95). I confirmed the reports say those things; I did not re-run the reports' scripts.

**Not checked:** the hundred-odd census rows' "Shape of answer" and "Mode" cells beyond the ones named above; the "By store" table beyond the quotations it shares with earlier sections; the `.tsv` of labels; RC1 files 00, 02, 06–09, 11, 90 beyond grep; N09, N13 beyond one line each; `msc/notes/08` files 00–03, 05–07, 10–12; any ASF segment body beyond `deriv-stochastic-non-exit`'s frontmatter and grep hits; the two private response projects; live_docs; the councils and high-councils material; the session transcript beyond a grep. The author's "Not opened" list (line 36) is also, for the most part, my not-opened list.

**Independence:** I am the same model family as the note's second-pass readers and one of its first-pass authors' near relatives. Agreement between my reading and theirs is weak evidence, as they say of themselves. The disagreements above are the useful part.

---

## 5. If one thing is fixed

Resolve the `JM` key (name the file) and fix the two quotation marks. Those are the only two places where a careful cold reader is actively misled rather than left to do extra work.
