# De novo audit of `core/`, third

*2026-11-10, by a Fable 5.2 agent launched with a two-line brief by the session working on core with Joseph. The audited state is commit `5148e94` (the rebuild on the two atoms). Nothing in `core/` was changed by this audit.*

## What I read, and what I did not

Read whole, myself: the root `README.md`; everything under `core/` (README, the three outlines, all twelve defs, all eleven `src/` segments, the praxis, the six template files, `def/README.md`, `log.kdl`); `bin/defs` and `bin/nutshell`; and the stopped bound's primary, `~/src/aat-v3/preparations/research/missed-error-case-2026-11-06.md`.

Run: `bin/defs check core` (passes: 12 terms, 12 subtypes, 41 relations, 11 prose segments), `bin/nutshell check` (18 parts, 2,843 words), `md-press -q` over every markdown file in core (clean), a KDL parse of `log.kdl` (47 entries, parses), `vsect why` and `vsect read` on `segment:scope-adaptive-system` in asf at `68f68644`, and a search of Joseph's typed message history for 34 quotations core attributes to him.

Not read, or not whole:

- The earlier cold reads (`msc/scratch/core-2-denovo-1.md`, `core-denovo-2.md`). Left unopened on purpose. Two things about them reached me anyway through core's own text: that the first corrected a count in `impl-scope-adaptive-system`, and that the second caused the rewrite of `impl-stopped-bound`.
- `msc/notes/`, the first core, `relevant-mental-models.md`. Not read. I cannot say whether anything in them is carried or lost.
- The ASF segment `scope-adaptive-system.md`. I saw it only as `vsect read` printed it, with long lines cut by my own pipe. I did not check the cut in `impl-scope-adaptive-system` §1 against the file.
- The commit message of `5148e94`, which I did read, carries a "Known and left" line about the 20:49 row of `impl-scope-adaptive-system`. That item is the lead's, not mine.
- I read the `src/` segments before the defs, not interleaved in row order as the README asks. The forward-reference finding in §4 is from the outline's text, not from having been confused in order.

The silence of this report on any file or claim is not a finding that it is sound.

## 1. Where the model, as written, says two things

These are ordered by how much rests on them.

### 1.1 A piece whose acceptance is reopened is, by the definitions, no longer canon, and then owes nothing

The canon row (`model.outline.md:24`) and `segment.md:32` both say a segment is accepted when an admitting decision exists "and that decision's basis holds", and that "an unaccepted segment is provisional". `segment.md:43` and `frontier.md:32` say nothing inside a provisional segment is owed: "only canon owes". The frontier's first item is defined on "an accepted piece" (`frontier.md:20`).

Put together: the moment a contradicting act lands, the acceptance's basis fails, the piece is unaccepted, so it is provisional, so its contradiction is not owed. `impl-a-small-move` at 08:30 has c "contradicted" and "no longer accepted" in the same cell. Read strictly, every disturbance removes from canon exactly the pieces it disturbs, and the frontier holds only the reopened decisions themselves.

The model plainly means a third state. `frontier.md:30` names it ("unsettled"), and `decision.md:30` says "reopening is not reversal; what was decided stays written". But the two definitions of canon and of provisional are two-state. What is unsaid: whether an unsettled piece is in canon; whether "only canon owes" means admitted-and-standing or admitted-at-all; and what a piece is, at a steady state, when its reopened acceptance is covered by a waiver.

### 1.2 Does a contradiction survive an edit? The two runs answer differently

`act.md:29`: any act of finding out lapses the moment something it read changes. `frontier.md:20`: contradicted is cleared by "a repair that lapses the contradicting act". `impl-a-small-move` at 09:25 follows this: the finding "read the old c and no longer binds".

`impl-scope-adaptive-system` at 20:49 says the opposite about the same event: the rewrite clears the two contradicted items, but "the findings remain owed until answered".

By the defs, any write to a veritoid clears every contradiction and finding on it, whether or not the write addresses them. The piece then reads never-asked, and a rule that accepts on one confirmation re-accepts it when someone follows the proof again. For the stopped bound that is the whole failure again: the collision check that broke (i) would lapse at the first rewording. This exit is cheaper than a waiver or an affirmation and is not on the list of cheap exits in `frontier.md:59` or `disc-what-would-show-this-wrong` item 6.

The real record does it the second way. See §2.1: 33 of the 162 recorded acts are a second mind marking a finding "answered".

### 1.3 The actor is minted at every discontinuity; author, party and "not the author" all need something that persists

`actor.md:42`: identity is minted anew at every session start, subagent launch and compaction. Against that:

- "Only its party changes it" (`act.md:31`, `decision.md:35`). An agent party stops existing at its next compaction.
- A stale reference is cleared by "the author affirming it" (`frontier.md:23`); a reopened decision is "addressed to its party".
- Validity is produced by "a mind not the author" (`dimension.md:58`). A session that writes a claim, compacts, and re-derives it is, by the defs, a different actor and so not the author.
- "The steward and the lead, in unity." This repository's own acta show the lead as three successive actors in two days.

The model has the pieces (an assignment that is a decision; a compacted actor "with a source"; a seeded-by reference kind) but no statement that authorship, party and independence are read through lineage or role and not through actor identity. This is the def's own purpose, turnover, meeting its own identity rule. I found no Working Note that carries it; the steward-attestation gap is a different problem (two principals under one harness identity, where this is one principal under many).

### 1.4 "Same means" is counted as "same line", and one of the def's own examples contradicts that

`dimension.md:43` and the evidence row (`model.outline.md:52`): two confirmations "by the same means, or with a shared source" are one line. `dimension.md:62` then reads comprehension as a "count of independent readers", all by one means.

The stopped bound supports the narrower statement only. `impl-stopped-bound.md:46` has it right: "several minds following one written proof are one line". What they shared was an artifact, the written derivation every one of them read. The model can already see that without a new rule: each of those checks has the derivation veritoid in its reads. Generalized to "same means", two minds who each re-derive blind, sharing nothing, are one line, and with the default that lines share a source until shown otherwise and the independence gap open, no dimension can currently reach more lines than it has means.

Is the shared read, and not the shared means, what the case shows? That is my reading of the primary's §2.4 ("mostly verified a *different* thing ... each is [legitimate]"), offered as a reading.

### 1.5 The frontier's item list does not cover what the acts def says is owed

- `act.md:37`: a finding "owes an item on the frontier". No item in `frontier.md`'s table is a finding. The runs file findings under *contradicted*, which is defined as an asserted answer that evidence says is wrong; "this paragraph hides a derivation" is not that.
- A check's outcome may be *narrowed*. No item says what a narrowed check owes on the piece itself (*raised* is for its dependents). `steady-state.md:35` counts "one narrowed check" as owed.
- A reference "to a piece that does not yet exist is allowed and owed" (`reference.md:23`). Stale, dangling and unmet are each defined on a target that has an id.
- A contradiction that is itself mistaken has no way out. *Read as* says "contradicted wins", and the item is cleared only by rewriting the piece or by a waiver. An act's `concerns` is segments or actors, so nothing can be recorded against the contradicting act. `impl-scope-adaptive-system` twice needs exactly that ("a ‹testimony› about the finding").

### 1.6 A decision "answers exactly one dimension", and several of the decisions the model names answer none it can declare

`decision.md:8` and `act.md:6` give `answers` a cardinality of one. A dimension is opened for kinds, or for an actor (`dimension.md:24`). Waiving an owed item, promising a slot, choosing where effort goes, and changing the ontology concern an owed item, a slot, the work and the ontology. None of those is a kind of piece. Either there are dimensions of those things, which the dimension def does not allow, or the relation is left from before decisions were general.

Related: `decision.md:25` puts "the assumptions it names" in a decision's basis, and "whether each decision still stands" is in the computed row of the table. Step 7 of `impl-an-outline-fills-in` reopens R2 when "a check elsewhere shows X is not finite". For that to be computed, the assumption has to be a piece with an id that the check concerns. Nothing says an assumption is a piece. As written, someone must notice.

### 1.7 Smaller ones

- **Two affirmations.** The inline row (`model.outline.md:55`) defines affirmation as carried inside a segment changeset, for an unchanged inner dependent. `reference.md:16` uses it for reconciling a reference against a moved target, which "mints no version" and happens in no changeset of the referencing segment. Related: the version a reference last saw is "carried beside" it. If that is written, an act changes the corpus, against `act.md:34`. If it is read from the acta, the table's written row should not list it.
- **The actor borrows the piece's machinery.** It is "of a kind" (`actor.md:7`), holds references to other actors (`:11`), has dimensions opened and warrants. `kind.md` knows only veritoid kinds and segment kinds, and `reference.md:6` runs from a segment to segments.
- **The frontier at a steady state.** `frontier.md:5` and `:13` tie the frontier to a working state and to exactly one atomic changeset in progress. `steady-state.md:15` defines a steady state by its frontier, which holds the waived items.
- **The author's own check.** `act.md:38`: it "has standing as a check and adds no independent line". `actor.md:44`: acts without standing "warrant nothing". `dimension.md:58`: the producer is "a mind not the author". Is the author's check zero lines, or one line that is not independent of itself?
- **What is accepted.** In `impl-an-outline-fills-in` the steward and lead accept R2 (step 4), then c1 and c2 are what is reopened (step 5), then R1 and R2 are accepted again (step 6).
- **"Overclaimed" has no worked case.** By the defs, content says what is claimed and never how well it stands, so the item applies only to content that is already malformed. Before the rebuild, `impl-scope-adaptive-system` used overclaim for "asserts *exact*, never checked"; the rebuild's diff replaces each with "unsettled" by way of a sketch acceptance rule. So an unchecked *exact* in canon is owed under no universal constraint. It shows only in the never-asked conditions, and only for a determinant. That may be the intended design. Sentence 2 of the spine, and "supplied to all of them without declaration" in `verisectorium.md`, read as promising more.
- **Never asked by this means.** The last bullet of `impl-stopped-bound` §4 says the gap is visible only if never-asked-by-this-means is. The steady state's stated conditions (`steady-state.md:20`) list never-asked per dimension, not per means.

## 2. The two real-record runs, against their records

### 2.1 `impl-scope-adaptive-system`

Counts that hold against `vsect why` today: 162 acts; 62 rederive and 10 run; 61 of those confirmed (7 narrowed, 4 broken); 25 of the 61 by integrators; 8 revises; 3 corrections; 2 read-checks; 13 checks binding at HEAD and 50 of 63 confirmations lapsed.

What does not hold:

- **"69 findings"** (§2). The record has 36 `place-finding` and 33 `review-finding`. Every one of the 33 has outcome `answered`, by a second mind or verifier. They are judgments that a finding has been answered, not findings.
- **"8 confirmed rewordings."** Eight `confirm-rewording` acts: six `equivalent`, two `not-equivalent`.
- **"Five round-7 integrator confirmations, all recorded at `9fde935e`"** (§3). They were recorded at `v:6e778ade`. They bind at HEAD because the check-8 verifier recorded a `confirm-rewording`, outcome equivalent, at 03:27Z: "neither touches what integration-7 C1-C5 checked".
- **"Nothing needed a term the model lacks"** (§4). That sentence is about the file. Of the record, 44 of 162 acts (33 answered-findings, 8 rewording judgments, 3 corrections) are acts about other acts, and the table in §3 reads none of the first two kinds through the model. The model has no act that answers a finding (§1.2) and none that re-binds checks across an edit judged equivalent. The second is the open question in `segment.md:89` and `steady-state.md:49`, and the record shows how it was answered in practice: by a second mind, not by the author's affirmation, and sometimes with "not equivalent".

**The runs were not re-run on the rebuilt model.** The word-level diff of `5148e94` on these two files is vocabulary (broken to contradicted, attestation to testimony, crossing to routing decision, accepted to waived) plus a sketch acceptance rule threaded through the table. `core/README.md:8` calls these runs "the test of the model". The outline's Working Note on what is untested since the rebuild lists an intake and a delivery, and not these.

`core/README.md:8` also says both are read "from the acts recorded in asf's `.vsect/`". `impl-stopped-bound.md:20` says of its own material: "None of these was a recorded act when it happened."

### 2.2 `impl-stopped-bound`

Read against the primary, the rewrite is faithful on its main claim. At least three minds other than the author affirmed (i) itself (audit 584721, audit 742613 more weakly, adjudication 628401); the break came by collision and simulation; three minds confirmed it; one dependent was left unchecked.

Three counts are not in the primary:

- The 04-28 to 05-10 row says "three audits". The primary's three in that window are 829314 ("highly mature and exact"), 451729 ("correct"), and 193847, of which it says "Nothing on the stopped bound."
- "A fourth model family" (05-28 row) and "four model families agreed" (§4). The 05-28 audit is Gemini 2.5 Pro, and Gemini had already spoken on 04-28. The minds the primary names as passing (i) or its localization step are Claude Opus 4.7, Codex, Gemini, Claude Sonnet 4.6, Gemini 2.5 Pro and Claude Fable 5. I count three families, unless Opus, Sonnet and Fable are counted apart.
- "Would not have told four later auditors to stop." The primary gives no number.

"Every quotation above is from its §2.4 and §2.5": "unchecked" and "not re-derived" are from §2.7.

### 2.3 Joseph's words

Of 34 sampled quotations, 29 are in his typed history byte for byte, and two more differ only by a corrected spelling or dropped emphasis marks. The other three:

- `frontier.md:41` quotes him: "clear delineation of the frontier vs stable steady states". He wrote (2026-11-08 18:53): "clear deliniation of the frontier vs stable checkpoints". The rename of the term went through a quotation.
- `frontier.md:43`, "as Joseph described it: 'a known defect probably lowers this; not yet worked through; do not rely in the meantime'". That is an earlier note's paraphrase inside quotation marks. He wrote (2026-11-05 15:53): "There is now a known defect that likely downgrades this dimension's assertion-- but the work is not yet done to integrate the soften or adjudicate a strengthen-- do not rely in the meantime".
- `steady-state.md:30`, "known honesty orthogonal to internal consistency", is compressed from: a sort of "known honesty" orthogonal to internal-consistency/stability factor on main.

That same message continues with a condition that core does not carry anywhere, in body, history or notes: "I would support that if it was pretty rare and is almost always the thing being worked on right away-- so they don't accumulate-- maybe even dissallow more than one or two flags like that without reconciling one.... but that doesn't make sense to disallow a known correction... still pondering..." `steady-state.md`'s history says the mark he weighed "became the waiver here". See §3.1.

## 3. Judgments about the design

These are mine, and are arguable in a way §1 and §2 are not.

### 3.1 One global steady state, with parallel changesets punted, makes the waiver the ordinary way to close

An atomic changeset is everything between two steady states of the whole verisectorium, and a working state "belongs to one atomic changeset". In a store with several minds at work, some finding somewhere is nearly always open. So either steady states are rare, or they are reached by waiving whatever is unrelated to the move at hand. The model's answer to waivers as a cheap exit is that they are visible. Joseph's condition on the mark the waiver came from was that it be rare and not accumulate.

The gap row calls parallel changesets punted. I think it is on the critical path of the first real store, not behind it.

Related, and already in two Working Notes (`impl-a-small-move`, `frontier.md:60`): between 08:30 and 14:00 a reader of "the verisectorium" is shown S0, in which c is accepted, while a recorded act says c is false. "True as stated whenever stationary" holds by construction, because the working state "is never the verisectorium". The stopped bound's 15:13 spike author is this reader. I would rank this above an open note. It decides what a steady state promises a downstream builder during a long move.

### 3.2 Intake's central case, evidence that arrives as prose, has no path into the acta

The first real store begins as audits brought in as influx. An audit bullet that says "claim X is false" is, cut, a chunk: content, routed by a decision. The routing outcomes in `impl-intake` do not include "recorded as a finding or a check". If they did, the actor would be an auditor from months ago whom no harness attests, and `decision.md:35` and `actor.md:42` forbid a typed identity. The stopped bound's table is this case, row after row. Its right-hand column reads audit prose as checks without saying who would have recorded them, or as whom.

This repository meets the same thing in its own acta. Every decision of Joseph's is recorded by the lead typing his name into `why`.

### 3.3 The ontology is in none of the three columns

`disc-what-would-show-this-wrong` names as a falsifier "a thing that is neither written, done nor computed". The ontology "holds no content" and is "written by hand for now". It "holds the rules", and a rule is "a decision like any other, with a party and a basis", which makes it an act in the acta. Every *read as* is such a rule. The two-atom reduction, followed through, makes each ontology declaration a decision whose wording is content. That is the ontology as content of its own corpus, which `kind.md`'s notes record as deferred by Joseph. The gap row covers where a change is recorded. The prior question is where the ontology is.

### 3.4 The vocabulary is larger than the outline counts

Declared: 12 terms, 12 subtypes, 25 inline words. Used throughout with no row of their own: *assembly* (46 uses), *standing* (65), *owed* (66), *basis* (48), *means* (47), *rule* (45), *party* (44), *answer* (45), and also *freestanding*, *unsettled*, *influx*, *working state*, *importance*. Then eight frontier items, four slot states, seven reference kinds, three check outcomes. The praxis says a plain word the model leans on is an inline row.

*History* has three senses: the line of steady states (`verisectorium.md:19`), prose kept with a segment, and the version-control history of renderings. *Seeded-by* is listed as a reference kind, glossed "two acts are not independent", and used nowhere. References run between segments, not acts.

The falsifier is "the terms have to multiply back toward eighty". I am not saying it has been met. The count it would be measured against is not the one the gate prints.

### 3.5 Size

What a reader must read to hold the model (outline, `src/` bodies, def bodies, without Historical Context and Working Notes) is about 25,700 words. The target in the outline's Working Notes is stated in lines ("about three hundred and fifty"). The files are one line per paragraph, so the nutshell's "123 lines" is under the target by an accident of wrapping. Words would compare. The nutshell, at 2,843 words, is the only text near the stated size.

The same passage on weighting determinants (theory against paper, segment kind × determinant) stands in `verisectorium.md` Discussion, in `dimension.md` Definition, and in `disc-better`. "The two regimes" stands in `dimension.md` and `disc-better`. `decision.md`'s Intro restates the spine's second paragraph. The rebuild removed two disc segments as restatements of defs. `disc-better` is now mostly in that condition.

### 3.6 What the rebuild chose

The last actum says three notes "had each been parked as leans or decisions for him" and that "Working notes that these changes decide are removed." The bodies now carry at least these choices: what a version covers; that reconciling a reference is an affirmation and not a write; that assertions are content and are not compared with warrants; that only canon owes; that acyclicity belongs to capped reference kinds; that means are declared by the dimension.

Everything is still `status provisional`, and the praxis's step 9, as now on disk, licenses writing the best current model into the body. But from the files alone Joseph cannot tell a body sentence that has stood for two days from one chosen an hour ago on a question that had been his. The list exists only in one actum and one commit message. `veritoid.md:42` says what its version covers "was decided here".

## 4. Surfaces, gate, praxis

- **The gate checks standing-alone only in `def/`.** The praxis's step 5 says "no standalone section points outside". `src/` bodies are not checked. `impl-scope-adaptive-system` carries, in its body, a provenance paragraph with `~/src/` paths, the first person, and two mentions of a cold read correcting it (one with a path into `msc/scratch/`). The praxis's step 8 says not to do the last. It has no Historical Context and no Working Notes, so the item the lead knows is open on it lives only in a commit message. `disc-record-surfaces` says a commit message carries "nothing the verisectorium needs"; the praxis's step 7 says "a message a future mind can orient from"; the 2026-11-10 actor's `by` line says it oriented from commit messages.
- **Provenance inside a Definition.** `changeset.md:19` and `:21` end with `Joseph's "instance-isolated changeset"` and `Joseph's "atomic changeset", "simultaneously, logically speaking"`. The gate's pattern looks for paths and note numbers, not attributions. `changeset.md:29` is filed as an invariant and is a note about architecture.
- **`src/` segments do not follow their templates.** `templates/README.md` says every segment of a kind "owes conformance". `disc-better`, `disc-written-done-computed`, `disc-what-would-show-this-wrong`, `intro-spine` and `impl-intake` have none of their template's sections, Working Notes included. `templates/README.md` also says the gate enforces the templates "where it can"; for `src/` it enforces frontmatter only. The outlines are a kind in use with no template.
- **`narrates` is loose in both directions**, and the gate checks only that each name is a term. `impl-scope-adaptive-system` and `impl-stopped-bound` both lean on segment and atomic changesets and do not narrate changeset. `intro-spine`'s third sentence is about the frontier, which it does not narrate; it narrates changeset and never uses the word. `disc-what-would-show-this-wrong` narrates veritoid, kind, reference and frontier and uses none of the four words. Since `narrates` is how a def change says which prose to re-read, the misses are the ones that matter.
- **Left from before the rebuild.** `act.md:57`: "its subtypes (check, finding, attestation)", where attestation is now on that def's avoid list. `segment.md:52`: a promise may stand "by acceptance with a reason like any other owed item", the sense that is now waiver. "Crossings" or "uncrossed" in `segment.md:50` (twice) and `disc-what-would-show-this-wrong.md:10`. `verisectorium.md:59` is a Working Note that says of itself "this paragraph is history". `core/README.md:11` and the header of `log.kdl` say the files "carry no history of their own"; since `disc-record-surfaces` they carry History and Historical Context by design.
- **The outline says two things about its order**: "in dependence order" (line 3) and "in a considered order" (line 16). The first is not true as stated. The canon row leans on decision, standing and segment; the two disc segments that follow the state row narrate six and seven terms defined after them. The term graph is cyclic, which `reference.md:25` allows. `segment.md:92` already asks that a deliberate departure from dependence order be a decision with a reason.
- **The outline's gap rows are questions.** A gap, by `segment.md:28`, is a slot whose kind is not yet known. "Whether declaring a dimension costs less than writing prose" and "what shows two lines independent" are open questions with no closer, which the model cuts as veritoids of a question kind.
- **`disc-what-would-show-this-wrong.md:10`** says "see «changeset»" for where a checker's findings go. That is only in changeset's Working Notes, which nothing is to cite as if it had standing.
- **Two slips in the invented moves.** In `impl-a-small-move`, S0 never says U was read whole or accepted, and from 13:30 a whole read of U is owed. In `impl-an-outline-fills-in`, step 5 lapses O's whole read and reopens O's acceptance, both of which have been lapsed and reopened since step 1 with no read between (step 4: "Owed: a whole read of O"); the fourth bullet after the table repeats it.
- **The praxis reached me stale.** `CLAUDE.md` imports the praxis so that it is "in context rather than pointed at". The copy in my context at launch had the old step 9 ("leans are written as leans ... decisions as 'Decide (Joseph).'"). The file on disk, committed eight seconds before my first command ran, has the new one. An agent launched from a long session may get the praxis as it was when that session began.
- **The acta.** The last two entries' `at` agree with their commits to the minute. Nothing in `log.kdl` contradicts what I found on disk.

## 5. What held

So that the lists above are read in proportion.

The two-atom spine reads as a real reduction, not a relabelling: found out against decided, evidence lapsing against a basis failing, and "no decided answer stands in for a found-out one" do work in every def I read. `decision.md` is the strongest file in core and stands alone for a cold reader. Separating wanted-here (a slot's written state) from accepted (a decision about the piece) is exercised step by step in `impl-an-outline-fills-in` and survives it. The rewrite of `impl-stopped-bound` says plainly that the model would not have caught the error, which is what its primary supports. Thirty-one of 34 sampled quotations of Joseph are verbatim or differ only by a corrected spelling. The acta carry several corrections of their own earlier entries, in the open.

The strain I found is mostly where the rebuild's new sentences meet older ones that were swept and not rethought (canon and provisional; the frontier's items; the actor's identity rule; the real-record runs), and in the surfaces of `src/`, which the gate does not read.
