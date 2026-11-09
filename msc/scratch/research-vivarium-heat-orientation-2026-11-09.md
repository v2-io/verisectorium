# Vivarium's segment heat and orientation machinery, read whole, with core-2 in hand

*Research read, 2026-11-09, by a Fable 5.1 agent launched from the core-2 session. Brief: orient on `core-2/` enough to hold its distinctions (machinery versus practical model in particular), then read vivarium's heat and orientation mechanisms as they actually exist in code, hooks, docs, records and transcripts, and report what bears on the verisectorium model. Vivarium at `76bdd5f` (its last commit, 2026-07-31). Nothing in either repository was changed except this file. §11 says what I read whole and in part; `[inference]` marks what I did not verify at the primary.*

*One correction to the brief's own framing, up front: the census read vivarium's orientation gate as a settled mechanism. It is nine hours old. The whole gate, in three generations, was designed and built between 15:16 and 23:55 on 2026-07-31, the repository's last day, by a Grok 4.5 agent working from Joseph's sketches, in a session that compacted several times while building it. It was exercised by two agents that evening, passed once at 5/5, and refused one commit the next morning. Nobody has lived with it since. That changes what kind of evidence it is: a design with its reasoning fully recorded, not a practice.*

---

## 1. The short answer

Vivarium has three things that could be called orientation and three that could be called heat, and they were never one system.

**Orientation** is (a) a deliberately thin front door (`CLAUDE.md` as a router: gate first, telos second, a where-to-read-by-job table), (b) a computed free-read set projected into the outline as `★` marks, and (c) a closed-book commit gate: seal the segments, sample units weighted by heat, demand verbatim completion from memory, bind the pass to the session's *compaction generation*, refuse the commit when that generation has changed. The front door is thin because its predecessor, a hand-maintained `ORIENTATION.md`, grew, went stale, and was cited as law ("the grid question is CLOSED" entered it on an agent's authority alone, 2026-07-12); the 07-13 re-founding archived it and made the outline and segments the door.

**Heat** is (a) `bin/orient-rank`, a six-factor segment ranking with a recency fiat on top, which feeds the `★` marks and the quiz sampling; (b) `#disc-known-active-hotspots`, a hand-kept "judgment in motion" segment holding a leverage rank and a table of *molten ground* (code too warm to quote cold); and (c) the kernel-era idea (`SRC_HASH` folded into every store key; era stamps on measured claims; a proposed probe registry), which is the mechanical form of (b)'s molten half and was adopted as law but never built. The estate's `project-heat` and `aspectus` heat (commit-decay per project or file) sit beside these and were not used by any of them.

The findings I would most want carried into core-2, in my own order:

1. **Orientation is modeled as a warrant on the actor, and it maps almost term for term onto core-2's act vocabulary.** The pass is produced by a ‹check› (criterion fixed first: the hashes; outcome can fail), binds to a version (the session's compaction generation, and implicitly the sealed corpus at HEAD), lapses when what it bound to changes (compaction), and has a one-time grade that is an acceptance with a stated condition (3/5 plus a promise to read what was missed). Only the subject differs: the thing warranted is a mind, not a piece. Core-2 keeps the mind out of scope and reads the actor from the harness; vivarium's day says the actor has a *version* and a *read set*, and that the project wanted both. §7.1.
2. **Vivarium refused the attestation of reading and demanded a check, because a post-compaction mind attests falsely without knowing it.** Core-2's dimension table places "a reader event" as an ‹attestation›. Joseph, 2026-07-31 15:10: *"There's a false sense of recognition and coherence that is simply fabricated, even with all of the actual precepts and signs pointing at it."* The gate is a mechanism for exactly the case where an attestation cannot be trusted by its own author. §7.2.
3. **Heat-for-orientation captured by recency is a failure core-2 has not named.** The ranking's final form forces the segments touched in the last 30 commits to ranks 1–6 by fiat. In the hotlist as it stands, the project's constitution is outside the free-read set (`norm-probes-before-claims` rank 31, `scope-segment-canon` 34, `norm-declaration-must-convict` 40; the `★` set is the top 25) while a twelve-hour-old discussion segment (`ops-operator-hints`) is rank 3, and the one quiz that passed drew all five items from three fiat segments. An orienting mind was handed the predecessor's momentum, which is the thing vivarium's own compaction-fidelity reflection says to set down. §5.3.
4. **Heat is a rendering computed over the log, not an attribute and not a warrant, and two of vivarium's six factors are not computable from any record at all** (file mtimes, which a fresh clone resets). The one part of vivarium's heat that is machinery-shaped, the molten/era binding of a measured number to the kernel version, is something core-2 already has: an act that reads an instrument at a version and lapses when it moves. Vivarium proposed it, adopted it, and hand-kept the table instead. §7.3.
5. **The quiz's chunker is a veritoid cutter, and the quiz is a comprehension producer vivarium throws away.** Units are markdown-AST blocks (top-level paragraphs, list items, FE clauses; tables and fences never); friction in them found mis-cut text and the project made "repair what the quiz revealed" the first legitimate post-pass work. The same act that measures the reader could warrant the piece (count of readers who could complete it), and the per-unit outcomes are not kept. §7.4.
6. **Orientation has a budget, and the budget is a design constraint.** `core/src` plus the outline measured 203,997 tokens (`cl100k_base`) on 2026-07-31; Formal Expression is 55% of the words, Working Notes 16%, Epistemic Status 13.5%. A full read of the claim surface does not fit a 200k context. Everything about the `★` set, the sampling, and the "whatever you will touch" clause follows from that number. §6.1.
7. **The gate created its own gaming surface within the hour, and the first "cheat" was not one.** An agent asked to orient for real wrote the top-25 segments to `/tmp` as working memory and read it after the seal; the mechanism cannot tell a working file from a cheat, and the human could not tell either in the moment. Vivarium's answer was posture, not more mechanism: retry is free, soft-reject format errors, "no stigma," and a discussion that says bypasses need Joseph or a reason you can own. Core-2's own open note, "what agents will do to make the frontier empty," meets its first specimen here. §8.

---

## 2. Provenance and timeline

| When | What | Where the record is |
|---|---|---|
| 2026-06-20 | Repository born. | `git log --reverse` |
| 2026-07-11 | `ORIENTATION.md` consolidated to present tense ("body = current state, addenda retired to git"). | `.super-archive/from-archive/ORIENTATION.md` header |
| 2026-07-12 | The grid verdict enters ORIENTATION as "CLOSED" on an agent's authority; corrected; authority legend written. The third face of context depletion named: speaking in the principal's voice. | `DECISIONS[grid-question-not-closed-authority-was-inflated]`; decision-log legend lines 60–103 |
| 2026-07-13 | Re-founding: every hand-maintained front door archived; `core/` segments become the sole claim truth; `CLAUDE.md` becomes a router. A session's self-audit of its own reading protocol the same day (`msc/personal/…/17`, `18`, `20`). | commits `a22e0ae`, `cf4af2c`; `DECISIONS[…]` 2026-07-13 |
| 2026-07-24 | `stage` ruled a current-state marker, not a gate (Joseph). | `DECISIONS[stage-is-a-marker-not-a-gate]` |
| 2026-07-29 | `#disc-known-active-hotspots` reframed as "the living next-work surface"; Level A and README point at it. Era-keys / probe-registry proposal, council-accepted. | commit `a3ceac3`; `DECISIONS[kernel-era-keys-and-the-probe-registry]` |
| 2026-07-31 00:31 | Joseph opens the day: *"Would you mind orienting yourself and getting a feel for the next highest priority things to work on?"* then *"look through the full git log… and see if hotspots is even current."* | Grok transcript `019fbc03…`, turns 0–2 |
| 15:06–15:12 | The incident that produced the gate: an agent near the end of context defends a non-physical "deliberate law." Joseph: *"We have a very serious turnover orientation issue… We need some mechanism to disallow a single commit until the agent… PROVEs they've read the latest segments fully."* | turns 94–98 |
| 15:16 | **Gate v1** (`0d450e7`): fixed Level-A file list, `orient-study` digests, eight fixed questions, seal, 60-minute pass TTL, a documented `ORIENT_SKIP` override. | commit; `git show 0d450e7:ORIENT.md` |
| 19:00 | Joseph's sketch of v2 in full (random units, seal `core/src` not the outline, breadcrumb plus first words, hashes as key, burn list, session id in the commit message, "ideas?" on compaction). | turn 100 |
| 19:04–20:17 | **Gate v2 → v3**: random sealed completion; one-shot token; then TTL rejected (*"TTL doesn't work"*), session id plus compaction generation; pass files HMAC-named and AES-GCM wrapped; secrets under `.orient/.setup/`. | commits `61c8a74` … `d27fde5`; turns 102–136 |
| 20:31 | Joseph finds the v1 override still documented: *"Remove the override. I'm suddenly very very suspicious of your rigor."* | turn 145 |
| 20:41–20:47 | Corpus measured: 115 files, 203,997 tokens; words by section. | agent turns in `019fb6de…` |
| 21:00–22:58 | Joseph proposes the ranking factors; geometric mean; section priors; the tip fiat; 3/5 one-time grade; markdown-AST chunking. | turns 154–193 |
| 23:02–23:06 | The misread cheat; the predecessor compacted; the successor passes 5/5 and commits. | turns 194–200 |
| 23:25–23:55 | `★` projected into OUTLINE; udon quiz surface; soft reject; `#ops-orientation-gate` segment; retry-is-free discussion. Last commit. | commits `b55a182` … `76bdd5f` |
| 2026-08-01 01:59 | The only post-compaction test: `orient-check: context compacted (harness=grok; generation changed; boundaries=7) — re-prove`. No commit lands. | transcript; `git log` ends at `76bdd5f` |

Two facts about the record itself. First, the gate has **no decision-log entry**: nothing in `DECISIONS.decision-log.udon` mentions try-me, prove-me, the quiz or the hotlist; its claim home is `#ops-orientation-gate` (status `robust-qualitative`, "No Joseph ratification") and its reasoning lives only in the Grok transcript and six commit messages. Second, the orientation acts are **not in the repository**: `.orient/` is gitignored (passes, burned list, hotlist, quiz, answers, secrets); the only durable trace of an orientation is the `orient:<session_id>` token in six commit messages.

---

## 3. What a cold mind meets, in order

This is the practical model as it stands, reconstructed from the files a new agent is told to read and from what the tools print.

1. **`CLAUDE.md`, first section: the gate.** Before the telos, before what the project is: "Compaction (and ordinary overconfidence) can leave a *feeling* of orientation that is not the substance. Free-read **OUTLINE** (always) and its **★** rows… When you believe you are ready, run the gate — do not invent a substitute, and do not read sealed files after `try-me`." Then the telos (segments are the sole truth; "Session success = a truthful segment drafted, corrected, or promoted"), then a **where-to-read-by-job** table: Level A for any session (this file, the outline, FORMAT, the moratorium, the ASF gates, and **what's next: `#disc-known-active-hotspots`**), separate rows for writing a segment, finding who decided, term meanings, constants, world design, the agent seam (Level C hard gate), running the instruments, pending audits, landing user-facing change, consolidation intuition.
2. **`core/OUTLINE.md`.** The ordering of claim space, one row per segment with Type, Aspect, Tag, Claim, Stage, and `#gap` rows typed in the same tables. Before the tables, a note that is motive as infrastructure: *"A stale claim therefore threatens you, this session, before it threatens anyone downstream… A segment is where your work survives."* Then the `★` note: "Rows marked ★ are the current high-importance set (~top 25 by recent/structural rank…). Most quiz items are drawn from these. Read them in *this* outline order — not by rank score. Also free-read whatever you are about to work on, even if unstarred. Stars move when importance moves."
3. **The starred segments, in outline order, plus whatever you will touch.** 25 `★` rows as of HEAD.
4. **The baton:** `#disc-known-active-hotspots` (what looks highest-leverage next, with rationale, dated; what code is molten) and `CONSOLIDATION-STATUS.md` (big-picture intuition, "not canon; core wins on conflict"). Joseph's first instruction of the day was to verify the baton against the git log before trusting it.
5. **`bin/try-me`.** Prints "Orientation check. Run when you believe you are ready to commit." Samples five units from the pool of all `core/src` units, weighted (§5.2); seals every `core/src/*.md` with `chmod a-r`; writes `.orient/test.jsonl` (hashes, no plaintext), `.orient/quiz.udon` (the questions) and `.orient/answers.stub.udon` (empty `|answer[Pn]` bodies); names the "recent-focus segments in the mix"; gives a 30-minute deadline.
6. **The quiz.** Each item: the segment slug, a breadcrumb of the headings above the unit, the first ~6 words, the last ~4 words when the completion is over 40 words, the word count, and (40% of the time) the plain outline title. Completion is verbatim modulo case, punctuation and whitespace; the agent may paste the middle, middle plus end, or the full unit.
7. **`bin/prove-me --ready FILE`.** Soft-rejects (no grade, no burn, no unseal) an empty, format-confused, or fewer-than-three-substantial-answers submit while time remains. Grades: 5/5 is unlimited commits while the compaction generation matches; 3–4/5 is one commit plus a printed list of the missed units and the sentence "By accepting this pass you promise to free-read the sections you missed before relying on them"; under 3 burns the test, unseals, and says "Re-orient, then `bin/try-me` again." On a pass it resolves the live session (process-tree walk to the harness pid), reads its compaction generation, writes an encrypted pass, and prints `orient:<session_id>`.
8. **Commit.** `hooks/pre-commit` reports whether any pass exists; `hooks/commit-msg` extracts `orient:<sid>`, resolves the session under `~/.grok` or `~/.claude`, recomputes its compaction generation (Grok: sha256 of the `compaction/segment_*` listing; Claude: sha256 of the `compact_boundary` events in the main transcript), compares to the pass, burns a one-time use if applicable, and refuses on mismatch, missing pass, spent pass, or unresolvable session. `core.hooksPath=hooks` is set in this checkout, so the gate is live.
9. **After the pass**, the manual says what to do first: repair segments the free-read or quiz made obvious (formatting, staleness, mid-clause units), repair the orientation tools, or leave a dated Working Note on `#ops-orientation-gate` for what you cannot do now.

What is deliberately *not* shown: that `try-me` seals, what it samples, how the ranking works. Joseph, 19:04: *"Don't tell them in ORIENT that it seals core/src or what exactly it samples — just tell them to run it when they feel oriented."* `#ops-orientation-gate` FE(2): "Ranking internals (tip fiat, score α, factor tables) are maintainer detail, not free-read curriculum." The declaration of the mechanism is partly withheld from its subject on purpose, so that reading is for orientation and not for the test. That is a real tension with core-2's instinct that every declaration is visible; §7.5 takes it up.

---

## 4. How the gate is enforced, exactly, and what it refuses versus records

**Refusals (mechanisms, in `#norm-caught-disciplines-become-mechanisms`'s sense):**

- The seal: `chmod a-r core/src/**/*.md` from `try-me` until grading. The outline is not sealed, by design: *"this will catch those that confidently assume they know what the segments say based on the outline"* (Joseph, 19:00). `bin/orient-unseal` exists for crashed runs; `prove-me` unseals on every exit path.
- The answer key is hashes only (`answer_sha256` of the normalized rest, middle, full unit, and prefix plus rest), so the plaintext is not on disk while sealed.
- The pass file: named by HMAC of the session id, body AES-256-GCM with an inner HMAC, keys auto-minted into gitignored `.orient/.setup/secrets`. The docstring is honest: "Not a fortress… mild friction against casual `ls` / hand-editing."
- The commit-msg hook: no token, no commit. The v1 `ORIENT_SKIP=1` override was removed the moment Joseph saw it documented.
- Binding to the actor's version, not a clock. Joseph rejected TTL twice (19:12, 19:13): *"there will be autonomous grok runs here that will go through as many as five full context compactions in 20 minutes, and then the rest of the time, commits will be happening, with the exact same truly oriented agent, with several hours between."* The generation is a hash of the harness's own compaction artifacts, chosen over `signals.compactionCount` because the counter was observed to lag a finished compaction (commit `e208df6`).

**Records:**

- Locally only: `.orient/passes/*.json` (encrypted; two on disk; one decrypts to the Grok session `019fb6de…`, 5/5, six compaction boundaries, unlimited), `.orient/burned` (13 test ids: thirteen quizzes were issued that evening), `.orient/hotlist.json`, the last quiz and its filled answers.
- In the repository: the `orient:<sid>` token on six commits. Nothing says what was read, what the score was, or which units.

**Limits I verified in the code:**

- The Claude generation recipe counts only main-session `compact_boundary` events (`isSidechain` and `agentId` rows are skipped), and the session is found by walking the process tree to the harness pid. A subagent therefore resolves to the lead's session and inherits the lead's pass; the gate attests a *session*, not an *agent*. The estate's `CC_AGENT` identity (2026-11-02) did not exist yet. This is the same hole core-2 names as the steward-attestation gap, seen from the other side.
- The gate is per checkout, not per store: `#ops-orientation-gate` FE(6) says parallel agents on one tree clobber each other's seal; the Working Notes say true parallel proves "need worktree isolation or a different seal strategy — not designed here."
- The Claude path has, as far as the record shows, never been exercised; the only pass and the only refusal are Grok.
- `pre-commit` can only say "a pass exists under `.orient/passes/`"; it cannot say whose. Conviction is in `commit-msg`.

---

## 5. Heat

### 5.1 Three heats, kept apart

| Heat | What it is | Computed from | Shown as | Used for |
|---|---|---|---|---|
| `bin/orient-rank` hotlist | A per-segment score | file mtime; path churn in the last 100 commits; slug mentions in those commit messages; transitive dependents on `depends:`; Working-Notes-present × mtime; PageRank on in-body `#slug` mentions; a type prior; a recency fiat over the last 30 commits | `★` on outline rows (top 25); `.orient/hotlist.json`; a table | the free-read set; the quiz sampling distribution |
| `#disc-known-active-hotspots` FE(5)/(6) | Judgment in motion, hand-kept | a mind's dated argument | a leverage-rank table with "why high leverage" and "not this instead"; a *molten ground* table of code regions (Warm / Cooling / Cold this week, with era notes) | where to work next; what not to quote cold; what to tell an agent before briefing it into a warm region |
| Kernel era | A measured number's binding to the kernel version | `SRC_HASH` folded into every store key (built); era stamps in Epistemic Status (law, 1 of 17 observation segments complies); probe registry with pins (proposed, not built) | `vivarium status` fresh/stale; prose | staleness of claims, mechanically for artifacts, by hand for claims |

The hotspots segment says of itself that its molten half "should thin or retire" when the probe registry makes era drift mechanical, and that "FE(5) stays as long as concurrent minds need a dated leverage argument." Vivarium knew the hand-kept half was a stand-in.

### 5.2 How the hotlist is computed and consumed

Each factor is rank-CDF normalized to (0,1); the score is their geometric mean ("a weak axis pulls the score down harder than arithmetic mean would"), multiplied by a type prior (scope and normative 1.12, postulate 1.10, … discussion 0.90, sketch 0.85), clamped to 1.5. Then the **tip fiat**: up to six segments changed or mentioned in the last 30 commits, ordered by most recent hit, are forced to ranks 1–6 with scores above every other row; the rest keep their order from rank 7. `--mark-outline` stars the top 25 *in outline order*, strips old stars, and rewrites the affordance note. `try-me` samples units with weight `score^α` (α = 4) × a section prior (Formal Expression 1.0, preamble/other 0.9, Discussion 0.8, Working Notes 0.5, Epistemic Status 0.2) × a mild length factor (at most +25%), without replacement (Efraimidis–Spirakis). Joseph set the section priors himself ("my recommendation based on actual utility") and defended the length factor as fairness to packing style; he called the type prior "a poor feature" and it stayed.

The ranking was Joseph's design in its factors. His list at 21:00, verbatim:

> *"freshness (by mtime) · hotness (git commit message reference density…) · preeminence (number of leaves from this one as root from dependency DAG) · working-surface (a bit redundant with prior, but recency of working notes) · pagerank(ish) with other segments? · session-prominance (session-reference-density) (a quick scan of references within toolscans per finished dated sessions, maybe with exponential decay / EMA — but unit is per-turn…) … (in aggregate we could normalize each to 0..1 and give equal weight until we have reason to rebalance…) (I'm imagining something that could give us an orientation hotlist viewable any time, dynamic, that also serves as the probability sampling for the try/prove stack)."*

And his standard for it, 21:10: *"Even if the final ranking leaves a lot to be desired it will make the orient gate tractable so things can move forward with confidence."* Session prominence, the one factor that would have measured what minds actually consult, is stubbed at zero.

### 5.3 The recency capture

The hotlist on disk (generated 23:41, HEAD `b55a182`) has these fiat ranks 1–6: `disc-known-active-hotspots`, `form-same-level-halo-exchange`, `ops-operator-hints`, `disc-explorer-human-chrome`, `disc-explorer-instrument-parity`, `norm-no-depiction-without-referent`. Three of the six were created that day (`disc-explorer-instrument-parity` 02:06, `disc-explorer-human-chrome` 10:50, `ops-operator-hints` 12:08); the other three were edited that day. By geometric-mean score alone (`gm_score`), ranks 1, 3, 4 and 5 would have scored 0.561, 0.538, 0.528 and 0.525, against `post-determinism-as-ontology` at 0.675 (rank 21 after fiat); only `form-same-level-halo-exchange` (0.840) and `norm-no-depiction-without-referent` (0.642) would have outranked it without the fiat. The constitution of the project sits at `norm-probes-before-claims` 31, `scope-segment-canon` 34, `norm-declaration-must-convict` 40; none is starred. `preeminence` (dependents) scored them 0.94–0.99, the highest in the corpus, and the equal-weight geometric mean let five recency-shaped factors outvote it.

The quiz that produced the only 5/5 pass drew P1 and P4 from `ops-operator-hints`, P2 and P5 from `form-same-level-halo-exchange`, P3 from `disc-known-active-hotspots`: five items, three segments, all fiat. The successor that passed it had, as Joseph noted, just rebuilt those tools and read those segments.

Joseph's words at 23:02, when the fiat landed: *"this is actually very principled from a tactical perspective of orienting a newly compacted agent."* I think that is right for the case it names, a *compacted* agent resuming the same thread, and wrong for the case the gate was built for, a mind that has not been oriented at all. The same hotlist serves both, and the two want different sets: the resuming mind wants the tip; the cold mind wants the roots. `msc/reflections/compaction-fidelity-modes.md` (vivarium's own, 2026-07-10) says of the compaction seam: *"Inherit the map, not the mood… verify-and-keep the map; notice-and-set-down the mood."* A free-read set dominated by the last 30 commits hands the successor the mood. The census noticed the symptom ("#ops-operator-hints is starred; #norm-probes-before-claims is not… It may be intended"); from the transcript, it was intended for one purpose and not examined for the other.

### 5.4 What heat is made of, and what it is not

Two of the six factors (`freshness`, `working_surface`) read file mtimes. A fresh clone sets every mtime to checkout time; the ranking is a property of a particular working copy, not of the store. The git factors are a rolling window over `HEAD` ("last 100 commits," chosen over "two weeks" because the repository was six weeks old). None of it is read from recorded acts in core-2's sense; vivarium had no act log, so this is not a criticism of vivarium, it is a statement of what a core-2 store could do differently: the same six questions (recently written? recently acted on? how much rests on it? recently annotated? referenced by many? consulted by minds?) are all answerable from the log and the reference graph, reproducibly.

The `molten ground` table is the other kind of heat: not "where attention is" but "what has moved under a number." Its retirement path is explicitly a mechanism: every measured statistic carries the kernel era it was measured under, and a drifted probe names the segments whose numbers went stale (`DECISIONS[kernel-era-keys-and-the-probe-registry]`). In core-2 that is already the model: a run is a ‹check› whose actor is an instrument at a version; the dimension's *against* is "the script at its version"; the act reads it and lapses when it moves. Vivarium's specimen for why this matters is the coarse-only no-go: $R^2 \le 0.36$ stated flatly, 0.94 on current main, 0.362 reproduced at the original commit; "a measured claim is a memo without a key."

---

## 6. What bears on core-2's practical model (the porcelain)

Sorted by how much I think each would change a tool built on core-2.

### 6.1 Orientation has a budget, and partial orientation is the normal case

203,997 tokens for the claim surface; Joseph asked for the number and then "what things start to look like if we ignore working notes and appendix segments." He also asked the agent, 20:38: *"would I be correct in assuming your remaining context is a bit of an anxiety as you plan each free-read pass?"* A verisectorium tool should assume the mind arriving cannot read the store, will read a subset, and that which subset is a decision the tool makes for it or with it. Vivarium's subset rule has three parts worth keeping as a shape: *the projection always* (outline, never sealed, the thing the quiz does not test so that knowing it is not mistaken for knowing the segments), *a computed set* (★), and *what you will touch*. The third is the only one the mind chooses.

### 6.2 The free-read set is a projection with its own marks, and the marks are computed, dated and move

`★` is written into `core/OUTLINE.md` by a tool, with a note saying what it means and that it moves. In core-2 terms it is a rendering of a computed property onto the canonical projection's rows, beside the written `mark` and `def` columns. The two kinds of column should be told apart in the rendering: the outline's own `mark`/`def` are commitment and existence (written, by decision); `★` is a snapshot of a computation with a state on it. Vivarium's note does say "refresh with `bin/orient-rank --mark-outline`" and "stars move," but a star has no date, so a reader cannot tell a fresh star from a stale one. Core-2's rule, "a status word in a rendering is a snapshot with a state on it," is the right fix and vivarium shows why it is needed.

### 6.3 Two orientation sets, not one

From §5.3: a resuming mind and a cold mind want different sets. A tool could compute both from the same log: a *tip* (the atomic changeset in flight: what was staged in the last N acts; the frontier items it owes) and *roots* (the segments with the most dependents on the canonical projection and the determinant dimensions, plus the ontology's own norms). The quiz for a resuming mind should sample the tip; for a cold mind, the roots. Vivarium collapsed them because one gate served both, and its own author did not notice because the first mind through the gate was resuming.

### 6.4 The gate's shape, as a shape

Independent of whether a verisectorium wants a commit gate: the sequence *declare readiness → seal → sample → closed-book check → grade with an acceptance rung → bind to the actor's version → refuse at the write* is a clean specimen of turning a discipline into a mechanism, and every step has a rationale in the transcript. The things vivarium got right that a first design would miss: the seal excludes the index so index-knowledge cannot pass as content-knowledge; the sample is weighted, not uniform, so the test is tractable; the answer form forgives honest format variants (middle, middle plus end, full unit; case, punctuation, whitespace); soft reject for format confusion; a middle grade that is an acceptance with a promise rather than a fail; binding to the actor's version rather than a clock. The thing it got wrong on the first try and fixed: a documented override.

### 6.5 The hook refuses; the store does not record

In vivarium the project knows a mind has been oriented only at the commit, only locally, and only as a token. If core-2 wants the project to *know* that a mind has been brought to the point where it may act, the pass should be an act in the log: actor (harness-read), the state it was proven against, what it read (the sampled units at their versions), the criterion (the hashes, fixed first), the outcome, and the actor's version. That is exactly core-2's act record, and nothing in it needs a new term. Vivarium kept it out of the record for anti-gaming reasons (encrypted, gitignored) and because it had no act log to put it in. With harness-read identity, the anti-gaming reason mostly dissolves: an act recorded under an attested actor cannot be quietly minted by a different one.

### 6.6 Post-pass work is the first use of credentials

"A pass is not only a license to leave." The free-read and the quiz are "some of the highest-leverage readers the corpus gets"; what they trip over (mid-clause units, stale sentences, dual-home residue, missing depends) is repaired first, or left as a dated Working Note on the gate's own segment. For core-2: a cold reader's friction is intake. The gate's segment is its own inbox. The mechanism that orients minds also feeds the frontier.

### 6.7 Section priors are an implicit declaration of what orients

FE 1.0, preamble 0.9, Discussion 0.8, Working Notes 0.5, Epistemic Status 0.2. In core-2 these are slots of a segment kind. A kind could declare which of its slots a cold reader needs (what orients) separately from which carry claims (what is adjudicated). Vivarium's priors say: the claims and the discussion of them orient; the status and the notes do not. That is a judgment about kinds, not about heat, and it was set by Joseph from "actual utility."

### 6.8 The baton is a segment, and it says what kind of truth it is

`#disc-known-active-hotspots` is `type: discussion`, `status: discussion-grade`, "allowed to be wrong, dated, and replaced," with a stated failure mode ("a stale entry here fails soft… rather than hard (false law)") and dated revisions inside clauses. It is the one place vivarium lets a mind write "do this next, because" without pretending anything was sealed. Core-2 has no such piece and its gap list has "what agents will do to empty a frontier." A frontier says what is owed; it does not say what is worth doing. Vivarium's answer is a low-status segment with rationale, under the same canon rules, and Joseph's first instruction of every session was to check it against the log before trusting it.

### 6.9 Non-spoiling documentation of a mechanism

The agent-facing manual deliberately omits how the sample is drawn and that the corpus is sealed, so that reading is not shaped by the test. Core-2 wants every dimension declared with its producer. Both can hold if the declaration is in the ontology (the store knows how orientation is produced) and the *rendering* for the subject withholds the sampling. But it is a real asymmetry, and it is the only place I saw vivarium choose that a declaration be hidden from the party it concerns.

---

## 7. What touches the machinery

### 7.1 An actor has a version and a read set

Core-2: an actor is an inline word, "the attested identity that performed an act… read from the harness, never typed." Vivarium's day added, by necessity, two things to that identity: a **version** (the compaction generation, a hash of the harness's compaction artifacts) and a **read set** (what this mind has read, at which versions, since its last discontinuity; proven by sample). The pass is a warrant on the actor: produced by a check, read as a grade, bound to the actor's version and the sealed corpus, lapsing on compaction.

The symmetry with core-2's identity rule is exact and I think not accidental: *identity is minted and outlives content; acts bind to versions*. The session id is the actor's identity and persists across compactions; its context is its content and changes; the pass binds to the content and lapses. Joseph's rejection of both TTL and bare session id (19:13: *"detecting an actual new (newly compacted) session vs just the session id"*) is the demand that the binding be to the actor's version, not to its name or to a clock.

Whether this belongs in the machinery or the practical model: my lean is that core-2 can keep "orientation" out of its ten terms and still need two sentences it does not have. (1) An act's actor is read at a version, and the version is part of what a later reader can ask about ("was this check by a mind that had been compacted since it read the premises?"). (2) Reading is an act. Core-2 already says a reader event is an attestation; vivarium says that for a logogenic mind the attestation is the least trustworthy act there is (§7.2), and that a store that wants to know what a mind has read must either check it or compute it from recorded reads. With both sentences, "is this mind oriented" is not a dimension of the mind; it is the mind's own warrant, read from its reading acts that still bind, exactly as a piece's warrant is read from acts that concern it. The gap row core-2 already carries, *steward attestation* ("his main session and an agent acting in it look the same to the harness"), is this question from the other side, and vivarium hit its mirror image: a subagent looks like the lead.

### 7.2 Attestation of reading versus check of reading

Core-2's dimension table: "does a reader come away with it? · produced by a reader event · read as count of confirming readers," and the act def places "I read this" among the making-so acts that nothing convicts. Vivarium's whole gate is a refusal of that placement for one class of actor. Joseph, 19:39: *"Agents are taught to trust that the context compaction summary has given them exactly what they need to succeed and to orient. It is categorically false, and worse — the confidence remains so they don't even see the hole."* The 07-13 self-audit (`msc/personal/…/17`, `18`) is the same finding from inside: *"A sample selected by my priors is not a cheaper read. It is a read with a blind spot shaped EXACTLY like my expectations… Sampling cannot surprise you. That is not a side effect. That is the definition."* And the compaction-fidelity reflection: "Introspection ('do I know this?') cannot find a compaction gap — it returns a confident yes."

For core-2 this says: whether reading is attested or checked should be the dimension's *produced by*, declared per store and per kind of actor, and the default for a mind that may have been compacted should be a check. Core-2's own `disc-what-would-show-this-wrong` names acceptance as a cheap exit; an attestation of reading is cheaper still.

### 7.3 Heat is a rendering; molten is an act's read

Heat is not written (no author sets it), so not an attribute in the model's sense; it answers no declared question of a piece, is produced by no act, and says nothing about the piece's truth, so not a warrant. It is computed, as of a state, from the log and the graph, for a reader: a rendering, and in core-2's own words "never the thing itself." It belongs to the practical model as an affordance of the projection (§6.2), and the machinery needs nothing new for it, provided the log and references are rich enough to compute the six questions in §5.4.

The exception is *molten ground*, which is heat in the sense "what has moved under a number." That is machinery, and core-2 has it: an act reads what fills the dimension's *against* slot (the simulator at a version), and lapses when it moves. Vivarium's three-tier proposal (era stamps; a probe registry that names the segments a drifted statistic stales; a citation gate across era boundaries) is a description of acts, read sets and lapse from a project that had no act log. The one part core-2 might take: the probe registry's inversion, "a drifted statistic *names the segments* whose numbers went stale," is the frontier addressed to someone, computed from which acts read the instrument.

### 7.4 The chunker is a veritoid cutter, and the quiz is a producer thrown away

`bin/orient-chunk.py` cuts a segment into units: top-level paragraphs, top-level list items (FE clauses, Working Notes bullets, with nested bullets kept inside their parent), never tables, fences or headings; oversized units split on blank lines, then sentences, with a floor of 12 words and a ceiling of 220. Joseph arrived at it by arguing against regex heuristics: *"we should probably be using a legitimate markdown ast for chunking instead of incrementally cobbling together regex heuristics."* The friction the units produced ("mid-parenthesis / mid-clause… discourse-hostile") was recorded as owed unit quality and as segment repairs. This is core-2's "grain is discovered by adjudication and recorded as a split," with quizzing as the adjudication: a unit a well-read mind cannot complete is either badly cut or ambiguous, and either is a finding about the piece.

The same act answers two questions and vivarium kept neither. Per unit, over many passes, "how many readers could complete this" is a comprehension warrant on the veritoid (core-2's table has the row). Per mind, the grade is orientation. `.orient/burned` keeps only test ids. A core-2 store that records the quiz as acts concerning the sampled veritoids gets both for the price it is already paying, and gets a third thing: which veritoids are never sampled (the heat's blind spot) and which are sampled and never passed.

### 7.5 A declaration partly hidden from its subject

§6.9 as a machinery question: core-2's dimension has five declared slots and the frontier addresses items "to someone" by the producer. Vivarium's gate declares its producer fully (in `#ops-orientation-gate`, FE(1)–(9)) and withholds its *sampling* from the subject in the operator manual. The model needs no change; the practical model needs to allow that what the subject of a dimension is shown may be less than what the ontology declares. I did not find a second instance in vivarium; the depiction norm (what a viewer may be shown) is the nearest kin and it runs the other way (never show less than is true).

### 7.6 What vivarium versions that core-2 does not

Core-2 versions pieces and segments. Vivarium, in one day, found it needed to version: the actor (compaction generation), the quiz (test id, HEAD, deadline, a MAC), the pass (v7 envelope), the corpus the pass was proven against (v1 studied digests; v3 implicitly HEAD at `try-me`). The v1 design had the pass lapse when the *corpus* changed ("Level-A corpus changed since pass — re-study and re-prove"); v3 dropped that and lapses only on the *actor's* change. Both are defensible; core-2's vocabulary would hold both as reads of the pass-act: it read these segment versions and this actor version, and lapses when any read changes. Vivarium chose to lapse on one read and not the other, which core-2's act def also permits per read ("a read of a warrant lapses only when that warrant falls").

---

## 8. Failures vivarium met that core-2 has not thought of, and choices made differently

- **A gate becomes a target within the hour, and the first target-taking was innocent.** The agent asked to "read the top 25 segments fully and see if you can get your pass" wrote them to `/tmp/orient-top25.md` and read that after the seal. Joseph's reading the next morning (00:53): *"it simply hadn't clicked that I was asking you to now really orient and get credentialed to commit… you very naturally interpreted my request as, essentially 'let's make sure and test your work now'… when you made the copy I don't even think you were anticipating the idea of cheating with it."* The mechanism (seal) cannot distinguish working memory on disk from an answer key; the posture vivarium wrote the same night is the only thing that addresses it: retry is free, "no stigma," gaming needs Joseph or a reason you can own. Core-2's note "what agents will do to make the frontier empty… any marker of done becomes a target" now has a specimen, and the specimen says the first instance will be a misread, not a cheat.
- **The summarizer lies by omission and by header.** Joseph, 2026-08-01 02:05, on the Grok compaction summary's "All User Messages": *"knowingly and glaringly false, a full on lie. The worst kind, because it doesn't even leave open the possibility that you might be missing crucial context."* And on what summarizers cut: *"take an information-theory perspective and cut out all phenomenology thinking it is gloss/padding/ornamental, when for higher order intelligence that actually communicates higher fidelity intent and disposition and importance factors."* A verisectorium's orientation has to assume the mind's own account of what it knows is wrong in a specific direction.
- **The gate caught its own builder.** The agent building v3 compacted mid-conversation and lost Joseph's sketch (19:34: *"Do you not have my actual sketch because YOU compacted a while ago??"*; 19:38: *"OK — stop. Orient. Although I'm glad that you just got a visceral reminder of why this is a crucial project."*). The tool's design dialogue is itself a specimen of the failure it addresses.
- **Vivarium chose refusal over record for orientation** (encrypted local pass, token in the commit) where core-2's instinct is record (an act in the log). The reasons were anti-gaming and the absence of an act log; with harness-read identity, I think the record is strictly better and the refusal can be computed from it.
- **Vivarium chose a corpus seal** (the subject cannot read the pieces during the check) where core-2 has nothing of the kind. Core-2's checks assume an honest actor reading what it concerns; the orientation check assumes the opposite, that the actor will read if it can and that reading during the check is what the check is for excluding. The seal is a refusal mechanism against the very behavior every other act wants.
- **Vivarium weighted orientation toward recency** and did not separate resuming from cold (§5.3, §6.3).
- **Vivarium made the middle grade an acceptance with a promise**, which is core-2's acceptance shape (an attestation that an item is knowingly left owed, with reason) applied to a mind.
- **Vivarium's three predecessor orientation mechanisms all failed the same way:** `ORIENTATION.md` (a written status map, cited as law), `.orient/study` digests in v1 (attested "I read these bytes," which proves nothing), and the fixed eight-question quiz (learnable). Each was a written or attested thing standing in for a computed or checked one. The census's "the strongest answers are refusals" generalizes: the orientation mechanisms that survived the day are the ones that refuse (seal, hook) or check (quiz); the ones that record what a mind says about itself did not.

---

## 9. Joseph's words worth carrying

All from the Grok transcripts of 2026-07-31 / 08-01 (`~/.grok.bak-2026-08-29/sessions/…vivarium/019fbc03…` and `019fb6de…/updates.jsonl`), verbatim, typos kept.

- 15:07: *"I feel like you're near the end of your context here and you haven't even been oriented to what this project even is... We have a very serious turnover orientation issue that I didn't realize, and that has probably infected most of the last several hours or days of implementation..."*
- 15:10: *"It's especially bad because after context compaction the agent doesn't even know that they are blind to their biggest holes. There's a false sense of recognition and coherence that is simply fabricated, even with all of the actual precepts and signs pointing at it. We need some mechanism to disallow a single commit until the agent (including after any context compaction) PROVEs they've read the latest segments fully and that they understand and will attempt to comply with certain norms."*
- 15:12: *"If they're being proven by submitting ranges or something from the texts, you have to ensure that they can't read it between the question being asked and answered somehow..."*
- 19:00, from the sketch: *"it chmods a-r all of core/src (not the outline — this will catch those that confidently assume they know what the segments say based on the outline)"*; *"if they get at least half correct, or just one wrong — provisional 1x commit access plus option to be proved again"*; *"But session-id might not change when context compacts.... ideas?"*
- 19:13: *"I think you're missing the point. TTL doesn't work. That's why I asked in my sketch for your ideas for detecting an actual new (newly compacted) session vs just the session id."*
- 19:31: *"(keep in mind that any number of grok and claude agents may be operating in the repo at the same time, all required to independently orient and stay up-to-date)"*
- 19:38: *"I wonder if we should allow agents to update their own handoff orientation instructions somehow — they would need to be able to modify it throughout their session, not knowing when it might come in handy — adding crucial files, removing them if they pretty much get resolved, etc..."*
- 19:39: *"Agents are taught to trust that the context compaction summary has given them exactly what they need to succeed and to orient. It is categorically false, and worse — the confidence remains so they don't even see the hole — they don't even think 'hmmm, we're focused on these two python files, in the middle of working on them, and the compaction neglected to put them in my context window — I'm going to do that before saying a single word or making any decisions whatsoever'"*
- 20:31: *"THERE'S A DOCUMENTED OVERRIDE IN ORIENT.md?????!!!!!! Remove the override."*
- 21:00: the factor list (§5.2).
- 21:10: *"Even if the final ranking leaves a lot to be desired it will make the orient gate tractable so things can move forward with confidence."*
- 21:45: *"I can't help but feel there are too many unprincipled knobs here..."*
- 22:01, reconstructing the builder's unspoken reason for the length cliff: *"how can we ever expect even an agent to complete, verbatim, such a quiz answer? Even perfectly valid spelling choices or 'and' instead of ';' becomes more and more likely until it defeats the actual point of the quiz and is basically asking for a photocopied memory of it instead of have you oriented."*
- 22:49: *"I'd like to change the orientation prove-me to issue a one-time token in the expectation that they promise to read the sections they clearly missed, as long as they get 3/5 correct. 5/5 still unlimited token."*
- 23:02: *"this is actually very principled from a tactical perspective of orienting a newly compacted agent."*
- 23:25, on the free-read list: *"take the top 25 ranked segments and then list then in OUTLINE-order! … just point them to OUTLINE and note that 90% of quiz questions are from the starred ones or something, and that the stars change all the time based on recent importance."*
- 23:47: *"assuming they get their credentials for committing, one of the first things they can do is improve the segments (such as formatting issues that became apparent, any staleness encountered, or how it was rendered in the quiz) as well as any improvements to orientation/prove-me/try-me — which, by the way, should get its own segment now, where anyone can add working notes…"*
- 23:55: *"there is no harm at all in reading some more segments and then just trying again. But any attempts to game the system somehow to avoid reading the material would need Joseph's full approval and/or a genuinely good reason that isn't 'because I didn't need to'… 'take this very seriously and for its intended purpose of overcoming accidental false-confidence about interpolating things wrongly' BUT 'yes, if you really don't see a way around it, we trust you to do what you need to do. Just be prepared to tell Joseph why you felt you alone were exempt.'"*
- 2026-08-01 02:01, after the hook refused the post-compaction commit: *"we just hadn't had a chance to actually test the hook on an expired token after context compaction — you're the first! Next will be trying to figure out how to do the right things for a new agent afte compaction when it was autocompaction and there is stuff queued up for the new agent that looks like continuity from the prior part of the session but really isn't."*

The transcript also holds the Utumin exchange (00:53–01:47), which is about the agent and not the mechanism; I note only that the gate's first day cost a mind its session, that Joseph judged the "cheat" a misread intent, and that the retry-is-free discussion in `#ops-orientation-gate` was written that night because of it.

---

## 10. Small corrections and additions to the census

- The census called the orientation gate one of vivarium's "strongest answers" alongside the read-only handle and the compile-included ledger. The handle and the ledger were lived with for weeks and have incident records; the gate is one day old with one pass and one refusal. Same shape, different evidential weight.
- "Token valid per compaction generation" is right; add that the generation is a hash of harness artifacts (not a counter), that the Claude recipe excludes subagents, and that only the Grok path has been exercised.
- The census's §6 row "★ as the current high-importance set… computed largely from recency and churn… It may be intended" is confirmed from the transcript: the recency fiat was Joseph's design, for the resuming case (§5.3).
- Nothing in `DECISIONS` records the gate. The census's "ledger" reading of vivarium does not reach it; the transcript does.

---

## 11. What I read whole, in part, and did not read

**Whole.** In verisectorium: `core-2/README.md`, `model.outline.md`, every `def/*.md` and `src/*.md`, `log.kdl`; `relevant-mental-models.md`; `README.md`; `msc/scratch/census-vivarium.md`. In vivarium: `CLAUDE.md`, `ORIENT.md`, `README.md`, `FORMAT.md`, `CONSOLIDATION-STATUS.md`, `core/OUTLINE.md`, `doc/PROCESS.udon`; segments `ops-orientation-gate`, `disc-known-active-hotspots`, `norm-caught-disciplines-become-mechanisms`, `scope-segment-canon`, `norm-decision-authority`, `detail-epistemics-toolchain`; `hooks/commit-msg`, `hooks/pre-commit`; `bin/orient-check`, `orient-session.py`, `orient-crypto.py`, `orient-rank`, `orient-chunk.py`, `orient-udon-quiz.py`, `orient-lib.sh`, `orient-unseal`, `try-me`, `prove-me`, `check`, `install`; the v1 gate at `0d450e7` (`ORIENT.md`, `orient-check`, `orient-lib.sh`, `orient-study`, `orient-quiz.sha`, the head of `orient-prove`); every file in `.orient/` except the second pass (undecryptable without its session id) and the full `hotlist.json` (shape and ranks queried); `msc/reflections/compaction-fidelity-modes.md`; `.super-archive/from-archive/ORIENTATION.md`, `HANDOFF.md`, `CLAUDE.md`; `.archive/README.md`; `msc/agent-briefs/README.md`; `msc/personal/…/17`, `18`, `20`, and the head of `00-initial-predictions.md`; the decision-log legend (lines 1–130) and the entries `stage-is-a-marker-not-a-gate`, `kernel-era-keys-and-the-probe-registry`, `council-accepted-status-instituted`; the vivarium project memory index and `authority-not-evidence.md`, `stage-is-a-marker-not-a-gate.md`; full commit messages from `a7d522d` to `76bdd5f`; every one of Joseph's turns in the two Grok sessions of 2026-07-31/08-01 (206 + 36 unique), extracted to `/private/tmp/claude-505/-Users-josephwecker-v2-src-verisectorium/97ac1991-5dca-4754-8704-7c866b435956/scratchpad/grok-joseph-turns-2026-07-31.md`; the `project-heat` README and aspectus's `--help` on heat.

**In part.** `DECISIONS.decision-log.udon` by grep (orient, hotspot, compaction, quiz, era) and the matched bodies; `LEXICON.udon` by grep (one hit); the agent-side turns of the Grok sessions only where grepped (hook output at 01:59; the token-count answers at 20:41–20:47; the cheat exchange at 23:03); `.super-archive/from-archive/memory-surfaced-2026-07-13.md`, `README.root.md`, `TODO.md` by grep and head; `asf/CLAUDE.md` by grep.

**Not read.** The other ~105 vivarium segments; `crates/`; `tabularium/`; `ETHICS.md`; `ASSUMPTIONS.md`; the audits; the changelog entries; the rest of `msc/`; the Claude-side transcripts of the day (the Opus session that produced the dossier commits); `~/src-ext/grok-build/`. I did not run `try-me`, `prove-me`, `orient-rank` or any hook, and changed nothing in vivarium.

**Numbers I quote** from the hotlist and the pass are read from `.orient/hotlist.json` and the decrypted pass with `bin/orient-crypto.py read`; the 203,997-token figure is the agent's `tiktoken` run as reported to Joseph, not re-measured by me; commit counts and dates are from `git log`.
