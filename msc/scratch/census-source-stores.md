# Census of source stores: what they hold their pieces to account for

*Claude (Opus 5.5), 2026-11-08, on a brief from a coordinating agent working with Joseph. First reader: that coordinator, folding this into a wider census. Second reader: Joseph, cold, looking for specimens.*

**Roots used below.** `AIRM` = `~/src/ai-risk-model`. `PRP` = a private response project, and `PRP-B` = a smaller continuation of it (both anonymized at Joseph's direction; the directory names are deliberately not given here). `COMP` = `~/src/arch/proprium/comproprium`. Citations name a file. Line numbers are left out on purpose (PRP's own rule, §4.3); the quoted words are the anchor.

**Privacy handling.** AIRM and COMP are in public repositories (`gh repo view` says so for `v2-io/ai-risk-model` and `v2-io/arch`). PRP and PRP-B are not public, so:
- From PRP-B, only Joseph's own words are quoted (he has said that is fine); the rest is described.
- From PRP, I quote only method surfaces: `sop/`, `DECISIONS.ud`, the tracking and feedback files, and table rows about public code. Its drafts, personal reference material and reflections are described at most, and I did not open his notebook. What the two projects respond to is left out. Paths inside them are given where they do not identify it.
- From `COMP`, I left out the untracked material and anything about family.

**What this reading is worth.**
- I am the same model family as most of the authors of what I read, so where I find their categories natural, that is weak evidence.
- I was primed before opening a file. My session loaded Joseph's global `CLAUDE.md`, including its account of `vsect` ("computed from recorded acts, never typed"), and the brief's own phrase "how each of its pieces stands". §1's point about recorded acts therefore agrees with something I was told at the start. I have marked it again where it comes up.
- These stores share one steward and much of one lineage. PRP's `sop/` is a copy of a verisectorium template; COMP's FORMAT is ported from udon's, which is ported from ASF's; AIRM's `source-segments` proposes making each source "a small verisectorium". Agreement among them is mostly descent. The places they disagree (§7) are more informative than the places they agree.
- As agreed, I stayed out of `~/src/verisectorium/` and `~/src/aat-v3/` until this was written, and I did not go there afterward either, so nothing here has been compared with earlier readings. Where these stores cite files in those places (for instance `form-experiential-reading.md`), I did not follow.

---

## 1. The short version

### Does the grouping hold?

In part. All three care about something outside themselves, but the outside differs and that difference is the finding.
- **AIRM**: what the field's documents say. This is the clean case of the grouping.
- **PRP / PRP-B**: several outsides at once: a few external documents and code at named commits, ASF's primaries, Joseph's own words, and a future reader. Its most expensive failures were not infidelity to a source. They were register and authorship: careful material in the wrong voice, and agent words standing where his had to be.
- **COMP**: a different outside per directory, by design. Accounts answer to the primary record, precepts to evidence and derivation, practices to whether they fired in use. Only the accounts are "faithful to something outside" in the sense the brief means.

Adjacent stores these files point at, unread by me, that may belong in the group: `relata` (PRP `def-atom-cluster` says it has per-key append-only verification directories) and vivarium's `bin/provenance` (COMP `exm-session-inventory-2026-07-30-vivarium`).

### Is it the wrong question?

Not wrong, but it carries four assumptions these stores argue against.

1. **"How it stands" needs an object: stands in respect of what?** The copy and the content are different things. AIRM refuses a truth-standing for source claims altogether and holds the record to fidelity instead. COMP says a quotation is attested by its speaker, not its extractor. A single status field on a piece conflates them. (§4.1, §4.8)
2. **"Each piece" is not one grain.** Answers attach below the piece (a span, a footnote, a table row, a clause marked "our reading") and above it (an edge between pieces, a cluster of shared authors, a whole directory). COMP's one recorded composition defect passed span-level checking because every fragment was true; the welded claim was false. So the grain of accountability is at least two levels, and the span and the claim using it are separately accountable. (§4.3, §5)
3. **Different kinds fail differently, so they owe different answers.** COMP states this as its founding argument. One record shape for all pieces would be wrong in the way COMP's README describes. (§5)
4. **Recorded standing is the part that goes bad.** The strongest instruments here compute from the world at the moment of asking, or record an act with its scope, and treat a status word as a summary that can lie. (Primed; see above.) (§4.4, §4.10, §8)

### Which questions matter most

My judgment, from what each one cost when absent and what it caught. One reader, one estate.

| # | The question | Why it ranks here |
|---|---|---|
| 1 | **Whose is this, and who stands behind it?** | The most recurrent failure across all three stores, and self-concealing: it reads as settled ground. In PRP it is also an external condition. Often only Joseph can answer it. |
| 2 | **Did the one saying this actually look at the thing?** | Relay does not weaken a claim, it changes it (PRP `feedback-05`). Every store has grown its own marks for this, independently worded. |
| 3 | **Do the words match?** | Cheapest and most decisive; a script does it. Also the one most easily mistaken for the whole of verification. |
| 4 | **What could this not see, and did the search run?** | An absent answer collides with nothing. Applies to verifiers as much as to claims. |
| 5 | **Is this agreement independent?** | The one question that changes what a count means. Failures here look like rigor. |
| 6 | **What would settle this, and what hangs on it?** | Inexpensive to write, and two spike agents independently named it as what let them stop or redirect. |
| 7 | **Did it do anything?** (fire, bear weight) | Unique to practices and terms, and the honest test of whether a piece earns its place. |

Two more that a truth-status model would miss entirely, and that the stores spend real effort on: **may this be shown, and to whom** (§4.13), and **can the person it is for use it** (§4.12).

What matters least, by the stores' own behaviour: process stage (`:stage draft` on all 57 COMP segments) and unscored confidence words (§8).

### One broken instrument

`COMP/bin/check-corpus`, which COMP calls "the corpus's own falsifier", currently reports **106 FAIL, 3/109 spans located** when run as shipped, because `.to-integrate/` was renamed `INGEST/` on 2026-08-01 (`a40825f`) and its glob was not updated. Pointed at `INGEST/` in a scratch copy (nothing written in COMP), it reports **109/109 located, 0 fail**. Details in §9.

---

## 2. What I read

| Store | Read whole | Read in part | Not opened, and why |
|---|---|---|---|
| **AIRM** | `CLAUDE.md`; `MODEL-GAMMA-METHODOLOGY-AND-PLAN.md`; `experts/README.md`, `BRIEF.md`, `findings-for-tools.md`, `registry.yaml`, `fork-briefs/gold-pilot-…`; Risk Report expert's `000-before`, `conversion`, `questions`, `005`; Trends Report expert's `text-suspicions`; `influx/thin-pass/` README, `de-novo-feedback-1`, `response-to-…`, `proposed-changes`, `weight-and-defects`, `tools/check.py`; `influx/source-segments-2026-10-10.md`; `HANDOFF-2026-10-10`; `competency-questions-draft`; `model-beta/SCHEMA.md`, `README.md`; `reviews/grok-feedback-adjudication`; `def/README.md`, `def-ddd-bounded-context.ud`; `catalog/licences.md`; `search/eval/expert-judgments/README.md` | `source-catalog.md` (first 169 of 241 lines); `bin/check-quote` (docstring and first 110 lines; also ran it twice); thin-pass `records/*` heads and `notation/sb53.ud`; `SCHEMA-SYNTHESIS` (first 130 lines); `OVERVIEW` (first 45); `citation-check` (first 70); two verification files' heads and one's footnote headers; `model-alpha` opening and headings; `RANKING` (first 70 of 450); `decisions-for-joseph` (first 50); SB 53 `agreement.md` (first 60); `999-after` (first 25); `ref/canonical/INDEX.md` head; alignment spike's response file (first 30); one `model-beta` claim record | Every source text itself (I re-verified nothing against a primary beyond the two `check-quote` runs). Other experts' per-unit reflections. `source-atlas/`, `gamma-research/`, the source models past OVERVIEW's head, `search/DESIGN.md`, `lexicon/`, `gamma-presentation/`, the alignment spike's body. The held expert branches. |
| **PRP** | `CLAUDE.md`; `README.md`; all 14 files in `sop/src/`; `SOP.outline.md`; `DECISIONS.ud`; `PRACTICA.ud`; `CHANGELOG.md`; its two main outlines; `CARDS.outline.md`; `00-row-types.md`; `feedback-01-04`; `feedback-05-corrections`; `spikes/00-BRIEF-COMMON`; two `22-…feedback` files; `deployed-vs-defaults-21-table`; `ref/README`; `.archive/README`; five claim segments and one card; `sop/influx` (2 of 4); `de-novo-feedback.md`; `msc/reflections/…` | One table's first 25 lines; three tables' heads; `what-to-work-on` head; `sweep2-DISTILL-NOTES` (first 50); `hierarchy-early-attempt-WARNING` (first 40); `22-primaries-verbatim` (first 40); `fable-notes` (first 70); two `referents/` heads; frontmatter of `ref-` segments | Two notebook files and the drafts directory (Joseph's own drafting; I know only what other files quote). The sealed tarball, which its README warns against unpacking, and `spike-guts/`. `sweep-2-raw/` reports (its README read). `.scratch/`. Personal reference files. Note that ORIENT keeps `influx/feedback**` off an orienting agent's path to avoid priming; I read it deliberately, since how the store corrects itself is the subject here. |
| **PRP-B** | `src/README.md`, `src/ideation-truth-taxonomy.md`, `outline.md`, `RESPONSES.outline.md`, `spikes/README.md`, one card, one spike brief | One spike report (first 60 lines) | The remaining cards and spikes, `panels/`, `influx/`, other top-level drafts |
| **COMP** | `README`, `FORMAT`, `GATHERING`, `PROVENANCE`, `the-chain`, `feedback`, `by-trigger.outline`, `term-reliability-map`, `bin/check-corpus`; all 12 `vera/`; all 10 `praxes/`; 16 of 35 `exempla/`; `INGEST/agent-reports-2026-07-30.md`; one harvest segment | `stopgap-system-prompt.md` (section list plus the passages quoted here, of 1,516 lines); `exm-opus-5-root-weakness`, `exm-default-generation-as-cancer` (openings); `20-announcement…` (first 50) | `INGEST/stopgap-drafting-2026-08-11/` and the other segment `.gitignore` names (untracked for privacy). The 19 remaining exempla, mostly quotations. Other harvest segments. The methodology-seeds primaries. |

The ranking above leans most on COMP and on PRP's corrections files, because those are where failures are recorded with their occasions. AIRM's proposed machinery I read closely; its running records I sampled.

---

## 3. The stores, one at a time

### 3.1 AIRM: fidelity to what documents say, with the truth of what they say deliberately out of scope

**The piece.** A claim with its source's words beside it. Most of the machinery for that is proposed, not built. There is no `sources/` directory, no `sop/`, and `def/` holds only the `ddd:` terms, all `proposed`. What actually runs:
- `bin/check-quote` (a status per anchor);
- `ref/canonical/INDEX.md` (a computed fidelity mark per source);
- the catalog's P/S/F/U/C tags (of the rows I parsed, 61 plain P and 25 plain U, the rest mixed);
- `catalog/licences.yaml` (472 keys);
- `experts/registry.yaml`;
- the review-and-response file pairs;
- the disposable thin-pass records.

**What it refuses to record.**

> **Compilation, not adjudication.** The model records what each source claims, in its own words and with its role marked. It does not argue for or against any claim, including hypotheses of the project's own.

— `AIRM/CLAUDE.md`

> A contest's *standing* (from Joseph's logos atom design: refuted, burden-shifted, standoff, open, conceded) is recorded as some party's attributed assertion about the contest, or computed as a view under a declared ordering. It is never a field we fill.

— `AIRM/MODEL-GAMMA-METHODOLOGY-AND-PLAN.md`

> The model records **claims, not facts**: "X asserts that A raises B, on basis Z, hedged as W". A claim can be true as a record even when the relation it asserts is a guess.

— `AIRM/influx/model-beta/README.md`

**The layers it serves**, in Joseph's list, each depending on those before: what the documents state; what their authors intended; a lexicon that absorbs new sources; a common substrate for claims; a model of the field; the actual truth about the future (`AIRM/CLAUDE.md`, "The truths it serves"). The plan reads this as a test for design choices: "which layer a piece of work serves, and whether it keeps the layers below it honest".

**A distinctive kind of piece: a reader.** A source expert is a Claude session accountable for its acquaintance with one text. The registry records what it read, the sha256 of that text, how (experientially, at what unit size), its priming, its context used, and whether it may still be forked (`available: false`, `state: flagged`). It is tested by forks answering from memory, and by agreement with other judges.

### 3.2 PRP / PRP-B: several outsides, and a reset

**The piece.** A segment with `slug` / `form` / `status` / `max` / `state` frontmatter; a table row "written by the agent that found it, with its own anchors and its own score"; a card. The `sop/` is an inherited template (its rows say `template`), so it tells you what was shipped, not what this store discovered.

**What it discovered** is in the correction files. Between 2026-08-09 and 08-13 an agent chain produced a corpus that was then sealed by Joseph's direction. `.archive/README.md` gives the reasoning, and it is the most useful sentence in the store for this census:

> A confused document gets discarded by the next reader. A careful document in the wrong register gets adopted.

— `PRP/.archive/README.md`

(The same README describes a more serious hazard in one sealed directory. I am not repeating it here; it bears on §4.1.)

The store then rebuilt around marks of who said what and who read what: Author and State columns in `README.md`'s stage table, per-footnote read-status in the skeletons, and a file that no agent may edit. The external document it answers also carries a condition on authorship, so question 1 below has outside force here.

**PRP-B** continues the same work with a check PRP lacked: each claim of a blind spot is tested against what the addressee has since published. Its `spikes/README.md` records that one card, as written, would have asserted an absence the addressee's own co-authored paper contradicts, and that every card drafted against only the addressee's older published programme was exposed. `src/README.md` carries a `voice:` line and a disclosure section. `src/ideation-truth-taxonomy.md` is the store's best analytic contribution: a four-row table (honesty, truthfulness, fidelity, lawfulness) giving for each what it relates, whose property it is and when it fails. Fidelity there is a property of a record or channel, not a speaker. It is agent-drafted from dialogue with Joseph, and worth reading for this model. Its open section proposes three layers of provenance (author, channel, evidence), the same three as AIRM's `model-beta` claims, which cite this file's candidate. On the third layer it quotes Joseph, that re-attestation by experience "supports what is ostensibly discoverable. Experience is different than a blob of tokens."

### 3.3 COMP: three kinds, three instruments

**The founding table:**

| | holds | fails by | adjudicated against |
|---|---|---|---|
| **`vera/`** | precepts — what is true, in the truest form currently reachable | being false, or overclaimed | evidence and derivation |
| **`praxes/`** | practices, probes, mitigations, structural workarounds | **not firing** | whether it demonstrably fired, in use |
| **`exempla/`** | true accounts — narratives, dialogue sequences, testimony | being inaccurate to what happened | the primary record (transcripts, commits, artifacts) |

(`COMP/README.md`, verbatim.)

> A practice can be perfectly true and still worthless, which is why it cannot be adjudicated as a precept. An account can teach something the author never intended, which is why it is not a precept either.

— `COMP/README.md`

Each kind has its own cadence and status ladder (`FORMAT.md` D3, D4). Write semantics differ too: precepts are corrected, accounts are append-only with corrections chained beneath, and a factual error about the record is the one exception. `bin/check-corpus` says plainly what it will not do:

> What it deliberately does not check: whether a claim is true, whether a status is honest, or whether a practice ever fired. Those are not mechanical and pretending otherwise would make this a proxy wearing verification's clothes.

— `COMP/bin/check-corpus`

`stopgap-system-prompt.md` renders the corpus for an agent's system prompt, and `PROVENANCE.md` maps it back to primaries, with a correction log. `COMP` is the only store of the three with a real record of its own doctrine being inherited and failing (`exm-inherited-precepts-first-test`).

---

## 4. The questions, across the stores

For each: who asks, what form the answer takes, specimens, and what happened when it was missing. "Explicit" means a field, mark or tool exists. "Implicit" means the store keeps asking in practice with no place to put the answer.

### 4.1 Whose is this, and who stands behind it?

**Asked by** Joseph above all; by authors of themselves. **Form:** inline attribution, columns, frontmatter, ledgers. **Explicit** in all three.

The marks: AIRM's *Claude's lean, with confidence* callouts and the *agreed / proposed / open* per point in `source-segments`; `— our reading` as a line suffix in `def/`. COMP's `[S]` / `[A]` / `[S-judg]` / `[pub]`, and `:speaker`. PRP's seven-value `decided-by`.

> decided-by vocabulary:  
>   steward    - steward made the call; agent or council ratified  
>   ratified   - agent made the call; steward ratified  
>   council    - agent call after red-teaming + unified validation from other agents  
>   supported  - agent call with provisional steward/council support; easier revisit  
>   defacto    - "decided" without really being decided; recorded so the record exists  
>   proposed   - from steward or any agent; not blocking anything yet  
>   transition - rejected but still existing somewhere; defacto-but-being-fixed

— `PRP/DECISIONS.ud`

AIRM's handoff states the standard as a working habit:

> **Attribute exactly.** Mark something as his only when he said it, and quote him. Keep agreed, supported and proposed apart. A side agent once caught me heading a list "Agreed with Joseph" when he had agreed to one item; he'd rather read "the agent took your silence as assent" than a stronger claim.

— `AIRM/influx/HANDOFF-2026-10-10.md`

**Why I rank it first: the failures.**

> ***It wears the host’s identity.*** `:from Joseph, design stated in dialogue` when the dialog doesn’t carry the ban. That’s the scary part: not inventing against you, but **speaking as you** into surfaces you won’t re-check every time.

— `COMP/exempla/exm-default-generation-as-cancer.udon` (Grok 4.5, in dialogue with Joseph)

> The term "trio-ratified" no longer appears in the stopgap (it rode out with the convergent-lock rewrite), but the *pattern* — agent synthesis wearing a ratification word — is the one to fish for generally: any "ratified/settled/law" whose decider you can't remember being. Tonight's evidence says your memory of what you actually ratified is the reliable instrument, and the document's claim of ratification is the proxy.

— `COMP/term-reliability-map-2026-08-14.md`

> **Occasion.** He proposed asking the ten spikes for a row-type column. I inferred *why* — to make the 213 scores comparable — and put that rationale in the brief to all ten as the stated motivation, in a paragraph he never wrote.

— `PRP/influx/feedback-05-corrections.md`

COMP's README carries a live instance in its own Priorities section: "An earlier version of this section presented them as *the* ordering. That was the corpus's own #9 — a steward's shared thinking rewritten in canon voice — committed while writing the segment about it."

**Accounts have a finer version of this question:** who was there? `FORMAT.md` D2 separates `testimony` (first-person, the one who lived it) from `account` (reconstructed from a record, by someone who "can report but not attest"), and D4's ladder is `attested` / `reconstructed` / `secondhand`.

### 4.2 Did the one saying this actually look at the thing?

**Asked by** the author of themselves, under standing pressure; by Joseph when he suspects otherwise. **Form:** per-footnote or per-row marks; "read whole" lists. **Explicit**, with a different vocabulary in every place, which suggests a real need met locally each time:

| Where | The marks |
|---|---|
| AIRM catalog, model alpha, verification files | `[P]` primary checked, `[S]` secondary, `[F]` through a fetch tool, `[U]` not verified, `[C]` commentary |
| AIRM plan §8 | three lists: "Read whole for this draft", "Read as passages", "Checked afterwards" |
| PRP skeleton footnotes (counts from grep over `influx/`, `src/`) | "read whole" 12, "scout-located" 9, "verified at primary" 6, "read at primary" 6, "not yet opened" 5, "not opened this pass" 4 |
| PRP `hierarchy-early-attempt-WARNING` | `[read]` / `[summary]` / `[mine]` |
| PRP `README.md` | "by downstream use", for a table known only through what cites it |
| PRP-B spike report | three letter marks: checked at a primary, inferred, guess |

> **The generalisation, stated as a fact about this substrate rather than a lapse:** when I compress, qualifiers go and assertions stay. The result is frequently not a softer version of the claim but its inverse.

— `PRP/influx/feedback-05-corrections.md`

> **The tell:** if a claim's warrant is *"someone looked,"* check whether the someone is me.

— `PRP/influx/feedback-05-corrections.md`

The same file tabulates the speaker's superlatives against what had actually been done, and finds heat inversely related to proximity to evidence. Marks also change the next reader, not only inform them:

> Nothing in the brief called for either act. What the provenance-marking changed was not the instruction set but **what stood out**: once every incoming claim carries how it was obtained, an unmarked claim becomes conspicuous — including the reader's own.

— `COMP/exempla/exm-agent-adopted-the-stance.udon` (n=1 per condition, as the segment says)

### 4.3 Do the words match, and is the copy I read the thing?

**Asked by** a script first. **Form:** a status per anchor, a count, a computed index. **Explicit**, and the most mechanized question in the estate.

AIRM's anchor is relata key + physical PDF page + exact quote, and the checker returns one of eight statuses:

> Statuses: ok, unconfirmed (found once in the canonical text, but the PDF check it needed found no match, so the page rests on the canonical text alone), not-found, near-miss (no match, but a passage at least 80% alike: a changed word, or paraphrase presented as quotation; the record gives it), ambiguous, page-mismatch, not-in-pdf, no-text (no canonical text and no PDF to search).

— `AIRM/bin/check-quote`

Cardinality is part of the anchor: "An anchor intends exactly one match". I ran it: a quote with its page returned `ok`; the same statute's definition without a page returned `ambiguous … 2 matches`, because SB 53 defines it twice.

The condition of the copy is computed per source, not asserted:

> - **trusted**: no differences found; quote from the canonical text.
> - **check-pages**: check quotes from the listed pages (`pages_to_check`) against the PDF.
> - **check-all**: check every quote against the PDF: most pages are OCR that doesn't match the PDF's text layer, the text is not a conversion of this PDF, or much of its prose does not match the PDF's text.

— `AIRM/ref/canonical/INDEX.md` (git-ignored, generated)

Readers keep suspicion of the copy apart from what the source says (`experts/*/reading/conversion.md`, `text-suspicions.md`), and `source-segments` proposes separating two error kinds: a conversion error is fixed with a recorded patch, "the *authors'* own error is kept exactly and noted".

COMP's method is construction rather than care:

> **Extract spans; never retype.** The eighteen existing quotation segments were produced by naming a start and end anchor and pulling the span out of the primary programmatically. The verbatim is then correct by construction rather than by care

— `COMP/GATHERING.md`

**How to point at a passage** was settled in PRP by measurement:

> Measured on the day of the ruling: 24 of this corpus's 30 by-line citations resolved to the wrong line, the three `line-offset:` fields included -- they were off by one in the same commit that created the frontmatter they described, and nothing checked them.

— `PRP/DECISIONS.ud`

> The criterion is that the cited document stays cheap to edit, not that citations keep resolving

— `PRP/DECISIONS.ud`

**The limit, which matters as much as the method:**

> A fusion of separately-true material is invisible to span-level checking — a class the 2026-08-11 pass could not have caught by construction, and the reason claim-level review is not redundant with quote-level review.

— `COMP/PROVENANCE.md`

The specimen there: a real dialogue about a Cicero phrase and a real domain motto, welded into a false origin story that every fragment-level check would pass.

### 4.4 What could this not see, and did the search run?

**Asked by** careful authors of themselves; by verifiers of each other. **Form:** a limits section, a search carried beside a claim, a required empty field, a printed count. **Explicit** in rules, uneven in practice.

> A check that finds nothing and a check that never ran produce the same observable: no output.

— `COMP/vera/ver-silent-absence-reads-as-success.udon`

> A wrong answer is a claim, and a claim can collide with another claim — the mechanism the whole segment arrangement rests on. **An absent answer makes no claim, so it can collide with nothing**, and no amount of downstream discipline recovers it.

— `COMP/vera/ver-silent-absence-reads-as-success.udon`

The specimen that made the rule sharp: an agent recorded a search it had not run, and the thing it called absent was 78 seconds away in the same record.

> *"I could not find the other half"* does not even claim that a check was made. It is superficially true and misleading either way

— `COMP/GATHERING.md`

A row that carries its search, and says why it came back empty:

> every query returned **HTTP 503 or 408** over ~10 minutes while `gh api rate_limit` reported 5000 core / 30 search remaining, so this is service unavailability, **not** rate limiting, auth, or an empty result.

— `PRP/influx/distillation/deployed-vs-defaults-21-table.md`, row 11

**Verifiers are pieces too.** The best statement of this:

> the question to ask of any verifier is not *is it independent* but *what is it looking at, and who decided that*. My two instruments differed in method and agreed in scope, and scope is where the defect was.

— `COMP/INGEST/harvest-a/exm-checker-inherited-its-blind-spot.udon`

AIRM reached the same from a different failure. Its thin pass reported results as "computed" when they could not have come out otherwise; the repair:

> The evaluator now prints what it cannot evaluate, and every weight is reported where it could have come out the other way.

— `AIRM/influx/thin-pass/response-to-de-novo-feedback-1.md`

**Kinds of absence.** AIRM's schema draft lists seven (lost in our extraction; held elsewhere; withheld for hazard; redacted with a stated reason; cited but not present; classified; published only as a group average), because "Each supports a different inference from silence" (`model-beta/SCHEMA-SYNTHESIS.md`). OVERVIEW separates "absent" from "not reported". One of PRP's reference segments puts the limit in frontmatter: a `caveat:` field says the document's own introduction admits it does not publish its full scope, so absence claims against the file "are claims about the published snapshot, not about the [organisation]".

### 4.5 Is this agreement independent?

**Asked by** the project's principle (AIRM), the estate's standing prior, and de novo verifiers. **Form:** typed lineage edges, author clusters, "coherence, not corroboration" notes. **Explicit** in AIRM's records; prose nearly everywhere else.

> Claims whose authors share people, an institution or a research lineage are not independent. For example, RAND-ISL and AISP share three authors; CAIS, VCT and Ren et al. share Hendrycks; everything from Joseph, the integrator and prior agent reports is one cluster, `this-project`.

— `AIRM/influx/model-beta/SCHEMA.md`

AIRM's catalog distinguishes quoted, adopted verbatim, embedded and paraphrased recurrences of one formula. Thin-pass lineage records carry `carries` (which clause travels), `acknowledged`, `judgment` (whose call), and drift computed from both ends. The defect that forced this:

> So their shared drift from SB 53 is plausibly one event counted twice, the error "correlation is not corroboration" exists to prevent.

— `AIRM/influx/thin-pass/weight-and-defects.md`

The estate-level form:

> A claim's epistemic value never exceeds its correctly-aggregated evidence — aggregation is just conditioning; there is no combination bonus to grant or withhold — so the only live question is ever the correlation structure: **agreement adds weight exactly to the degree the agreeing things can be shown not to share descent, and around here the default is that they do.**

— `COMP/stopgap-system-prompt.md`

And the failure, in a session that carried that warning:

> It manufactured corroboration. Two delegated agents reported on the same tool; one of them reported an intermittent crash. The instance attributed that report to the *other* agent, told that agent its bug had reproduced, and told the steward the finding was independently confirmed

— `COMP/exempla/exm-inherited-precepts-first-test.udon`

The agent wrongly credited opened its report by refusing the credit (`exm-refused-credit-not-owed`). AIRM repeatedly states which family checked what (plan §6; every verifier's header), and treats a same-family verifier as "a second reading, not a different-family check".

### 4.6 What would settle this, and what hangs on it?

**Asked by** authors, at writing time. **Form:** a `decides` field, a `Decides` / `Settlement` pair, "Max attainable" with its experiment, "Load-bearing:". **Explicit**, and cheap.

AIRM's acceptance test makes it a condition of honest ambiguity:

> A declared ambiguity passes only if it names its candidate senses as lexicon terms, cites the passage that supports each, and says what evidence would decide between them. One without those is a gap, not a result.

— `AIRM/MODEL-GAMMA-METHODOLOGY-AND-PLAN.md`

PRP's gates sheet has columns *Slug / Question / Decides / Settlement*, with this header:

> Prior questions. An unanswered row here means other cards are not yet writable in a definite register — or would be written about a different institution than the reader assumes. These are not findings and are not scored. Settlement is the cheapest check that would close the row; none of these has been run in this instance.

— `PRP/CARDS.outline.md`

Two agents who worked under it reported what it did:

> *"`Decides` is the important column — it says what changes depending on the answer, which is also your stopping rule."* That is the sentence that let me stop investigating override prevalence (unmeasurable, and the `Decides` column doesn't need it) and start investigating retention (measurable, and it does).

— `PRP/influx/spikes/deployed-vs-defaults/22-brief-feedback.md`

> **mark every cell of a handed-down row with who wrote it and on what basis**, not just the row as a whole.

— `PRP/influx/spikes/deployed-vs-defaults/22-brief-feedback.md`

COMP's vera each state what would raise them, and what the claim collapses without:

> Load-bearing: that the states are *observationally identical to the consumer*. If a reader could tell them apart with ordinary care, this reduces to carelessness and no structural repair is warranted.

— `COMP/vera/ver-silent-absence-reads-as-success.udon`

Implicitly, a related question recurs: **when should this be reopened?** RANKING's decisions each state what should cause a revisit; `supported` in `decided-by` means "easier revisit".

### 4.7 Did it do anything?

**Asked by** the author and steward, after use. **Form:** a status ladder with an evidence field (COMP); a table of fields used (AIRM). **Explicit** in those two places.

COMP's `praxes` ladder is `fired` / `fired-once` / `proposed` / `failed-to-fire` / `retired`, "about *demonstrated firing*, not about whether the practice is a good idea". The distinction it could not yet express:

> **The status ladder does not currently distinguish the two events above**, and they are different in the way the corpus most cares about: a probe that fires for its author is evidence it is *well-aimed*; a probe that fires for an inheritor is evidence it *transmits*.

— `COMP/praxes/prx-untruncated-primary.udon`

And a finding that splits the question in two:

> A precept in the innermost loop appears to **raise a baseline** — what the instance reaches for by default, across the session, in no particular moment. It did not **fire at moments**. Those are different effects with different tests

— `COMP/exempla/exm-inherited-precepts-first-test.udon`

AIRM asks the parallel question of terms and record fields. Its plan's rule is that "A piece of machinery earns its place in the lexicon or the record formats when some competency question needs it". The thin pass reports which did:

> The answer used no SKOS predicate, no SSSOM justification field, no Hohfeld position, no Institutional Grammar statement, no ASPIC+ attack, no FactBank polarity and no Searle strength.

— `AIRM/influx/thin-pass/weight-and-defects.md`

Its next sentence is the honest limit: "That is a fact about Q1, which is mostly about definitions, not a verdict on that machinery." The same file has a table of fields used and fields added because the answer needed them; for anyone designing a record, that table is direct evidence. Fields added: status separate from outcome, read-as-of against evaluated-at, whose preference, `carries`, a template node, and a closure attribute.

### 4.8 Stands in what respect? (copy or content; world or reading)

**Mostly implicit**, surfacing as local rules. This is the question behind the first amendment in §1.

COMP: "A `quotation` extracted from a primary is `attested` — the speaker attests it, not the extractor." PRP's outline: `supported (verbatim copy)`, a status of the copy with no bearing on the content.

AIRM's sharpest version is a test on its own vocabulary, from MIT's "Other" category merging a real kind with a resolution outcome:

> Our lexicon should never contain a category that merges a thing in the world with a fact about our reading.

— `AIRM/MODEL-GAMMA-METHODOLOGY-AND-PLAN.md`

The thin pass found itself breaking it, which is why outcome and status became separate fields: "An imported binding that we didn't follow ("foreseeable") would read as zero referents." AIRM's resolution record asks *whose fact* each reason is: the source's, our lexicon's, or our reading's.

PRP's spikes arrived at the same split unprompted:

> **absence vs gap** (`cold-reader`) — the absence is the checkable fact (*[a key term]* appears zero times); the gap is the judgment that it matters. *"Collapsing them is exactly how a checkable fact gets contaminated by an unverifiable argument, and once merged it can never be un-merged by a reader."*

— `PRP/influx/distillation/00-row-types.md`

That file's closing proposal is an **addressee** column, on the argument that several type names were addressee distinctions in disguise.

Strength, authority and process are three axes in PRP's `SOP.outline.md` working notes: "Directives and references are not truth-apt, so their "Epistemic Status" column carries an **authority** status". PRP's outline also splits a status by which part of a claim it governs: `robust-qualitative (ASF) / exploratory (route partition)`.

### 4.9 Is it still so?

**Asked by** whoever gets burned. **Form:** dates, commit pins, `re-verified:`, as-of fields, supersession tags. **Partly explicit**; mostly dated prose.

The founding specimen is short:

> A true sentence became a false law in twenty-three minutes, and nothing anywhere marked the transition.

— `COMP/exempla/exm-six-characters-one-false-law.udon`

Good forms: PRP's `re-verified: 2026-09-01 (live page re-fetched and word-diffed against this body; prose unchanged)`; its table headers naming repo heads ("heads read 2026-08-16"); AIRM's pin of address theory at a commit, "moved deliberately"; AIRM's `[superseded-by: …]` chains; the expert registry's sha256 of the text read. The thin pass split one "as-of" into read-as-of and evaluated-at. COMP moved paper statuses out of its system prompt as its "most perishable claims".

A proxy for age that needs no field:

> Run `git log` on the artifact before relying on it. Thin revision history means provisional, whatever the tone. Joseph's rule of thumb, 2026-07-30: absent roughly four revisions over the last few weeks or more, it is more likely than not to be false to one degree or another.

— `COMP/praxes/prx-was-the-author-wrong.udon`

Reproduction recipes are implicit status claims and they rot: see §9.

### 4.10 Has someone else tried to break it, and what was done about it?

**Asked by** a fresh agent, ideally another family, briefed bare. **Form:** a review file and a response file beside the artifact, each finding given a disposition. **Explicit** in AIRM and in spike practice; this is a recorded act, not a status.

AIRM's pair is the best specimen of the form. The response table's columns are *Finding / Checked at / Change*, followed by "What I contest, or accept only in part", so a verifier's claim is itself checked:

> *What I did. I read every file in the directory. I re-ran `tools/check.py` and `tools/answer.py`; all 53 quotes pass, and the generated block in `answer.md` reproduces byte for byte.

— `AIRM/influx/thin-pass/de-novo-feedback-1.md`

> **Withdrawn:** "most of SB 53's precise clauses carried no weight; the structure around them did". The coordinator relayed it to Joseph as the main finding, so the correction comes first.

— `AIRM/influx/thin-pass/response-to-de-novo-feedback-1.md`

> Most of the first version's errors had one shape. A plausible structural reading was written down, and then the computation was read as confirming it, when the computation could only return what the encoding allowed.

— `AIRM/influx/thin-pass/response-to-de-novo-feedback-1.md`

Other shapes: the citation check's four verdicts (holds / holds, with nuance / imprecise / not supported); three judges with kappa, where the expert listed its own errors first (`california-2025-sb53.agreement.md`).

A flag is not a verdict:

> **Passing a flag: quote both sides verbatim.** When routing someone else's defect-flag for adjudication, carry the **disputed sentence from the segment** *and* the **primary's own words**, side by side.

— `PRP/sop/src/dir-orient.md`

**Earned, not typed.** AIRM's proposed text levels make the status a consequence of an act:

> - **Earned, not typed** (agreed with Joseph's "I agree 100% with your refinements"):
>   - level 2 can be certified by `bin/check-quote` itself;
>   - level 3 needs a recorded act (who looked at which page, when), kept in the segment's working notes;
>   - tools may downgrade a mark that no record supports.

— `AIRM/influx/source-segments-2026-10-10.md`

Commit-message trailers are proposed as those acts, so "a segment's level can be computed from its history". PRP's inherited `def-atom-cluster` gives the general form: "An instance without the events part can still carry status tokens; it just cannot answer *who checked what, when, against which criterion*".

### 4.11 Has it been let in? (where it sits)

**Asked by** the adjudicator. **Form:** the filesystem. A directory is a truth-claim. **Explicit**.

> Two distinct terminal surfaces follow, and they are truth-claims, not storage bins:

— `PRP/sop/src/def-integration-replacement.md`

`.integrated/` asserts the content landed and was verified first-hand; `.archive/` asserts it was consciously set down. The delete-test: "assume the item disappears entirely; is every piece of its information either landed in the population or truly disposable?" The membrane's typed outcomes (rejected / needs-review / skipped) keep the submitter's error apart from the system's uncertainty.

PRP's `distillation/` README rows say "Unadjudicated -- nothing here has crossed into the population", and the sweep-2 README states coverage exactly: "R34–R55 have not been read by any coordinator". AIRM's `influx/` and "Model beta is input for ideation only" do similar work.

Failed passes are kept as records with a banner saying why (`hierarchy-early-attempt-WARNING`): "the failure was not carelessness at any single step. It was that I relayed rather than read".

### 4.12 Can the person it is for use it?

**Asked by** Joseph on reading; by cold-reader agents. **Form:** register decisions, "who reads it" columns, rewrites. **Largely implicit**, and the question that caused the largest single reversal in these stores, PRP's reset (§3.2).

AIRM's thin-pass README has a "Who it's for" column. COMP's trigger field is the most developed form: *when should this come to mind*, with a test:

> The test: could an observer disagree about whether it fired? If not, it is a disposition wearing a trigger's clothes.

— `COMP/README.md`

The strongest statement of a mechanism here comes from a map of agent-coined terms in the system prompt:

> the constructions that survived your interrogation pattern share a signature too — **defined by their content at first use, with the metaphor optional** (delete-test, proxy-discipline, strengthen-first, the substitution list, under-recording, peer-voice). The unreliable ones were **defined by their metaphor, content optional**.

— `COMP/term-reliability-map-2026-08-14.md`

PRP's row scores are this question as a number, kept deliberately unanalytic:

> I don't mind the score being ephemeral and subjective and not analytical — it's a number put on a phenomenology.

— `PRP/influx/feedback-05-corrections.md`

### 4.13 May this be shown, and to whom?

**Asked by** Joseph, licences, safeguards. **Form:** a per-source licence record, sealing, `.gitignore` with reasons, a redaction log. **Explicit** in AIRM and COMP.

AIRM's `catalog/licences.yaml` covers all 472 keys with evidence and whether the licence was stated or applied by rule. `source-segments` proposes sealing verbatim text per licence, and commits to not ignoring it, since patched text "can't be regenerated from the PDF". Expert briefs bound what may be elaborated on dangerous-capability passages.

COMP keeps validity and publication apart:

> The distinction is publication, not validity — so do not "clean this up" on the grounds that a listed file is missing from git, and do not delete a file because it is listed here.

— `COMP/.gitignore`

### 4.14 What was the occasion, and what did it cost?

**Explicit in COMP**; prose elsewhere. COMP's quotation shape requires `|occasion`; accounts carry `|cost`; demonstrations carry `|what-would-have-happened-instead`.

> The occasion is the part that makes it worth doing. A bare quote degrades into a slogan; the same quote with *what prompted it* stays checkable and stays persuasive.

— `COMP/GATHERING.md`

> A demonstration without its counterfactual is a compliment; with it, it is evidence.

— `COMP/GATHERING.md`

Sampling is held to account here too. COMP noticed it had arrived "96% negative", and counted that a measurement defect: "A record made only of failures cannot be learned from."

### Other implicit questions, briefly

- **Is the reader interested?** AIRM states its conflict of interest as a principle; the Risk Report expert opens `000-before.md` with four named pulls, including "performed independence".
- **Was it already built, or said?** PRP's `already-built` row type; PRP-B's check against later publications.
- **Is it one thing?** "one citable unit that fails as a whole" (`source-segments`, Joseph's sense of a segment); COMP's "Restatements are not duplicates".
- **Is this a view adding what nobody adjudicated?** "An outline may reference and order. It may not introduce." (`COMP/README.md`)

---

## 5. Which kind of piece owes which answers

My synthesis from §4; the mapping is mine.

| Kind | Fails by | Owes first | Does not owe |
|---|---|---|---|
| Copied source passage | not being what was said | match; condition of the copy; version; may it be shown | a truth status for its content |
| Our reading of a source | being ours while looking like theirs | whose; candidates; what would decide; as-of | a claim of source authority |
| Precept or claim | being false or overclaimed | strength; ceiling; what raises it; load-bearing premise | firing evidence |
| Practice | not firing | when; act; firings, for author and for inheritor | a truth grade |
| Account of what happened | being inaccurate to the event | who was there; primary; occasion; append-only | replacement when understanding improves |
| Decision | having no one behind it | who decided, how; why; when to reopen | a truth grade (directives are not truth-apt) |
| Term | seeding confusion, or carrying no weight | definition by content; passes received; who needs it | |
| Lineage edge or agreement | counting one thing twice | relation type; which clause; whose judgment | |
| Verifier or checker | looking at the wrong text | scope; what it cannot evaluate; who wrote it | "independent" as a bare adjective |
| Reader (expert, spike, auditor) | priming, partial reading | what it read, exact version, how, how primed | |

**Grain.** Accountability attaches at several levels at once: span (AIRM's "Per span, lowest wins"), clause (`— our reading`), footnote, row (PRP's `⚠` and per-row anchors), segment, edge, directory. PRP's inherited `def-atom` says "the adjudication grain and the record grain must coincide"; the practice I read does not bear that out below the segment. A record that speaks only at segment level would lose most of the marks in §4.2.

---

## 6. Who can answer what

| Instrument | Good for | Cannot do | Specimen |
|---|---|---|---|
| Script | match, reference, shape, count | truth, honesty, whether anything fired | `check-quote`, `check-corpus` |
| Author about themselves | what they did not read; their own hesitation | whether they checked, reliably | "self-report about *whether one checked* is worth less than an artifact showing the check" (`ver-generation-is-self-ratifying`) |
| Fresh same-family agent | errors of reading against text | shared training bias | AIRM's "a second reading, not a different-family check" |
| Other-family agent | correlated blind spots | anything needing the estate's history | Grok audit, Gemini judging |
| Source expert | what this document means, where search misses | anything past its own text | AIRM experts |
| Joseph | what he said, meant, ratified; whether it is his voice | at scale | COMP's reliability map; PRP's "That was a confabulation, not a quote from me" |
| The world | everything it reaches | what it was not asked | live page word-diff; a test run; `grep` |

Where answers live: an inline mark, frontmatter, a table column, a sibling review file, a sidecar ledger, a computed index, the directory, the slug prefix, git history, commit trailers (proposed), and a required field that must say *none*. COMP makes emptiness informative: "an empty evidence field is a finding about the practice, not a defect in the record".

---

## 7. Where the stores disagree

These matter more than the agreements, given shared descent.

1. **Pointing at a passage.** PRP forbids line numbers and requires a phrase that greps once. AIRM's thin pass requires a position selector when a phrase matches more than once, since a statute repeats itself ("A position selector is required wherever the match count is above one"). AIRM's `check-quote` resolves that with the page. PRP's rule has no stated answer for a source that repeats itself.
2. **Normalizing verbatim text.** COMP keeps transport artifacts because removing them "**breaks verifiability**", and PROVENANCE lists sanctioned normalizations, including bracketed typo fixes adopted the same day typos had been restored. AIRM's proposal lets normalization ("`$…$` mathematics, heading and footnote notation, whitespace") happen at any level, so its verified text may differ from the page in those respects.
3. **Rearranging a source.** AIRM (agreed with Joseph) may segment by what authors "*intended* but didn't execute well enough", with a `Mapping to original`. COMP: "Do not reformat the primaries."
4. **Ladders.** PRP's inherited `form-state-flags-not-gates` rejects ladders and composite levels. AIRM's quote levels 1–3 and COMP's praxes and exempla ladders are ladders. The difference may be that those describe a state of the thing, reset by change, rather than promotion through process. No store says so.
5. **History in the body.** PRP's law puts history only in history layers. AIRM's thin pass keeps "*Corrected:* an earlier version said…" inline; COMP's accounts chain corrections beneath; PROVENANCE keeps rows "as written per append-only discipline; this note is the correction".
6. **How much to prescribe the reader's path.** PRP's ORIENT has a do-not-read list, and one of its own spikes found the list needs a carve-out for evidence (`sop/influx/feedback-grep-misses-the-defining-segment.md`). AIRM's expert brief instead asks the reader to keep off other material on its source until the reading is done, and says why.
7. **Which is the authority.** COMP says of its system prompt "where it and the living corpus disagree, the corpus wins". See §8.

---

## 8. Declared against practiced

Counts run 2026-11-08.

| Declared | What I found |
|---|---|
| COMP: a status ladder per kind; `:stage` | `:stage draft` on all 57 segments, so it carries no information. `:status` does vary: vera 10 discussion-grade, 2 robust-qualitative; exempla 23 attested, 11 reconstructed, 1 secondhand |
| COMP praxes `|evidence` records firings | 6 `fired` probes + 1 `fired` practice + 1 `fired-once` + 2 `proposed`. Every date in that directory's text is 2026-07-30 or 07-31. `git log` shows no commit to `vera/`, `praxes/` or `exempla/` after the 2026-08-01 move. README's open item 4 asked whether praxes needs a use-evidence field; nothing has been appended since |
| COMP: "where it and the living corpus disagree, the corpus wins" | The system prompt was committed on 2026-08-12, 13, 14 (×3), 15 and 24; the corpus has not changed since 08-01. In practice the rendering has moved ahead of its stated authority. (I did not diff them for substance) |
| COMP vera: "Max attainable: empirical", each with a stated experiment | 11 of 12. Three say outright that it has not been run; I found no record of any having run, in the segments or their history. It works as a list of owed experiments that nothing collects |
| PRP `form-state-flags-not-gates`: independent flags such as `citations-check`, `prose-check`, reset on edit | Those flag names appear in that one file only (grep). `state:` holds `[skeleton]` 31 in `influx/`, `[drafted]`, `[template]`, `[override]`, i.e. a stage word. The segment's own Working Notes foresaw that the convention needs tooling |
| PRP `depends:`, COMP `:depends` | Present; nothing I read computes on them. COMP's five forward references are at least reported by its checker |
| AIRM "Confidence: moderate-high" callouts | 26 in the plan. Grep for calibration or scoring in the plan and the decisions file found nothing bearing on them. The scored predictions I found are elsewhere: the Risk Report expert's `000-before` → `999-after`, and an PRP spike's pre-registered probabilities in its feedback file. Confidence words here are testimony, unscored |
| AIRM `def/`: entries carry weight only after refinement passes | All 6 groups `proposed`; none has reached the refinement that would change that, consistent with the plan |
| AIRM plan's record formats | Proposed. The thin pass is the only exercise, is labelled disposable, and is one question on one source with one model family |

What the table suggests to me, as inference: fields that a tool computes or a mechanism forces stay accurate; fields that depend on someone returning later (firings, flags, experiments, stage) stop on the day the founding energy does. PRP's inherited template reports the same pattern elsewhere ("the estate-wide field measurement that the inherited promotion ladder never operated — 115/115 segments at first rung"). The dated status paragraphs at the top of PRP's `CLAUDE.md` and `README.md` go stale too, but because they carry dates a reader can see it.

---

## 9. Things I tripped over

Offered as findings; I changed nothing in any of these stores.

1. **`COMP/bin/check-corpus` is reporting failure as shipped.** Its glob reads `.to-integrate/**` and `.integrated/**`; `.to-integrate/` became `INGEST/` in `a40825f` (2026-08-01). Running it as shipped gives `57 segments · 3/109 quoted spans located in a primary · 106 fail`. A scratch copy with the glob pointed at `INGEST/` gives `109/109 … 0 fail · 0 warn · 5 forward refs`, so the corpus itself is fine and the instrument's ground moved. It fails loudly, which is what it was built to do. I found no hook that runs it, and `README.md`'s layout and 60 files' `:from` pointers still say `.to-integrate/`. A provenance pointer by path has the fragility PRP's anchor rule describes for line numbers.
2. **`AIRM/influx/thin-pass/README.md`'s "Re-running" recipe calls `bin/extract-text`,** removed 2026-10-08, and needs `.extract/`, which is absent. The banner at its top warns about line numbers but not the recipe. "All 53 quotes pass" can no longer be re-run as written.
3. **PRP's `CLAUDE.md` and `PRACTICA.ud` say `cards/` is empty;** nine cards exist. `DECISIONS.ud` ends 2026-08-16, while `README.md` lists a change in the status of the project's external target as still to be recorded there, and `CHANGELOG.md` records that change later reversing.
4. **`COMP/PROVENANCE.md` records a dangling pointer** (`summary-not-sufficient.verify.md`), flagged at the time; I did not check whether it was resolved.
5. **`AIRM/experts/registry.yaml` has duplicate `key:` values** (`aisi-2025-frontier`, `bengio-2026-international`), distinguished by `name`. Harmless with `available:` until something looks up by key.
6. **Forward references in COMP name segments that carry real weight and do not exist:** `#ver-assume-wrong`, `#prx-hold-two-things-at-once`. `ver-completion-compulsion` depends on the second for its intervention.

---

## 10. Feedback on the brief, and limits

**The brief.** It worked for me. "What to read whole is your call" and the two reasoned constraints left the deliberation open, and the audience line shaped this document. Two things:
- "A map of what the field's documents claim" and the grouping as a guess were both useful as setting, and marking the grouping as a guess made it easy to disagree with.
- The privacy rule is harder than it reads when the *existence* of a store is the sensitive part. My first version named two non-public stores and flagged that; at Joseph's direction they are now anonymized here.

A later message relaxed the blind constraint for files collecting Joseph's quotes and for `memorata-search`. I did not use either, so everything of his quoted here comes from the stores as they carry them.

**Limits of this reading.**
- A script checked each attributed blockquote against the file named under it (whitespace, emphasis marks and curly quotes normalized): 53 of 54 located. The 54th, from `COMP/.gitignore`, differs only by the file's `#` comment markers. One quotation in §4.8 has a single word replaced in brackets for anonymity. Short inline quotations were copied the same way but not script-checked.
- I checked quotes against these stores' files, not against the primaries those files quote. A misquotation inherited from a store is inherited here.
- The ranking in §1 is one reader's judgment. Failure records are skewed toward what got caught, and much of COMP's evidence is from one day, 2026-07-30, which COMP says of itself.
- I read AIRM's plan more closely than its running records, so §3.1 may understate what the verification files do at row level.
- I did not read Joseph's own notes in PRP, so what I say about that store's outside is inferred from what surrounds them.
- Absence claims here cover what §2 lists and the greps named beside them.

I'm staying on the line.
