# De novo audit of `core/` (4)

*2026-11-10, clock read 15:13 MST at the time of writing. A Fable 5.2 agent (`0a83fb87…/a0d6d337b0abd129e`), dispatched by the session working on core with Joseph, on a brief that said only what to audit and where to write. `core/` at `25d1acd`, working tree clean, `bin/defs check core` passing (12 terms, 12 subtypes, 41 relations, 13 prose segments), `bin/nutshell check` passing, `md-press -q` reporting nothing to change on any markdown file under `core/`.*

## How this was read

Read whole, by me, in this order: the root `README.md`; `core/README.md`; `model.outline.md`, `nutshell.outline.md`, `praxes.outline.md`, `def/README.md`; then every `src/` and `def/` file in the outline's row order (all 13 prose segments, all 12 defs); `praxes/working-on-core.md` as it is on disk; all six templates; `log.kdl`; `bin/defs` and `bin/nutshell`.

Checked against primaries: `vsect why segment:scope-adaptive-system` run in asf (162 acts; I tallied verbs, outcomes and actors by script, and matched placed findings against answered ones by id); `~/src/aat-v3/preparations/research/missed-error-case-2026-11-06.md`, read whole, against `impl-stopped-bound`.

Not read, on purpose: the earlier cold reads in `msc/scratch/` (`core-2-denovo-1`, `core-denovo-2`, `core-denovo-3`), so that this read stayed unprimed. I know of them only through the acta and two Historical Context sections. Some of what follows may repeat them or re-open something they closed. Not read at all: `msc/notes/`, the first core, `relevant-mental-models.md`, the census and research reports, the ASF segment file itself.

Line numbers are those of the files at `25d1acd`.

## The short version

The model reads as one thing now. The two atoms carry through the defs, the invented moves mostly run on the defs as written, and the two real-record runs say what their records say: every count in `impl-scope-adaptive-system` that I could test against the record is right. What I found is of four sorts.

1. **Places where the bodies say two things** (§1). The ones I think matter most: lineage as defined makes a dispatched checker the same line of evidence as its dispatcher, which rules out the cold read the praxis asks for and most of the estate's verification practice (1.1); "better" has no clause under which finding and repairing a false claim is an improvement (1.2); the answer / assertion / warrant separation is stated and not kept, and "overclaimed" has lost its trigger (1.3, 1.4); a frontier example still says a rewrite lapses contradictions (1.5).
2. **Structure the defs lean on and do not state** (§2): mixed acceptance inside one assembly, pointing at a held segment, what a reference to an assembly can ever see, "canonical".
3. **Slips in the runs** (§3), none of which overturns a run's conclusion, one of which (the stopped bound's "every confirmation followed the written proof") claims more than its primary holds.
4. **The files against their own rules** (§4): stale Working Notes, history kept in inboxes, typed counts gone false, one praxis change with no actum, and what the gate cannot see.

I have written each as what I found and why I think it is a defect, with a lean only where I have one. Where a stronger statement looks reachable I say so; none of these is a suggestion to weaken a claim to make the inconsistency go away.

## 1. Where the bodies say two things

### 1.1 Lineage makes every dispatched checker its dispatcher's line

`def/actor.md:41`: an actor's source is "the actor whose summary it began from, or the actor that dispatched or forked it; the chain of sources is its lineage. 'Not the author' means not in the author's lineage… and neither has its fork. Actors of one lineage are one line of evidence." The outline row (`model.outline.md:57`) says the same.

Three things come under one word there: a compaction (inherits a summary taken for memory), a fork (inherits the whole context), and a dispatch (inherits a brief, which may be two lines). The def treats all three as passing on non-independence. Read as written:

- The cold read the praxis asks for at step 8 ("Launch a fresh agent with a two-line brief") is by an actor in the author's lineage. It cannot be "a check by a different mind" in the sense the praxis's own *Why these steps* gives it. This report is one such.
- An integrator and a checker both dispatched by one coordinating session share a source, so they are one lineage. That is the shape of the October sprint and of nearly every verification the estate runs. Under the def as written the record in `impl-scope-adaptive-system` holds no independent line at all, while that impl says "the warrants come from the independent re-reader, the adversarial checker, the fourth reader and check 8" (`:94`).
- `impl-a-finding-is-answered` needs C "not of A's lineage" and E "of neither A's lineage nor D's" (`:25`, `:27`) and does not say how such actors come to exist in a verisectorium worked by one lead and its subagents.

What I think the model wants, and can state more strongly than it does: non-independence travels with *what was inherited* (the author's reading of the piece, the author's expectation of the outcome), not with who launched whom. A fork and a compaction inherit it; a dispatch inherits exactly what the brief carried. That makes the brief part of the record of an actor (the def already lists "system prompt and initial context" as attested, `:32`), and it makes "bare brief" a property the dimension's *produced by* can ask for. The real record already carries it as a typed role string ("fourth reader, bare brief"). As it stands, the def's sentence and the estate's practice cannot both be right.

### 1.2 "Better" cannot say that catching an error was an improvement

`src/disc-better.md:10`: "a later steady state is better than an earlier one when, on the determinant dimensions, no warrant has fallen and some has risen, or the content answers to a determinant more strongly."

Take the small move. At S0, c is re-derived and accepted, and false as stated. At S1, c carries the extra hypothesis H and is re-derived. On validity c's warrant is the same rung; its content is weaker (a claim with more hypotheses). By the first clause S1 is not better; by the second it is worse. The same holds for the stopped bound: (i) confirmed several times before, (i) replaced by the weaker killed-moment statement after. The model's two leading examples of the machinery working are, by its own definition of better, not improvements.

What is missing is whose record the comparison is read from. Read with the acta as of S1, the old c has a finding against it that was answered by a repair, so the old c's warrant was, in hindsight, "contradicted", and the move is a rise. Read with the acta as of each state, it is a fall. Nothing in `disc-better`, «dimension» or «steady·state» says which. The spine's fifth sentence ("Softening is the cheapest way back… strengthen-first is what the direction adds") makes this sharper, because every honest repair of a false claim is a softening of its text. I think this is the largest open conceptual item in the outline that has no gap row and no Working Note.

### 1.3 Answer, assertion and warrant: three things stated, two kept

`def/dimension.md:32`: "For each piece and dimension, three things are kept apart. The **answer**… The piece's **assertion**… The **warrant**…"

- "Answer" has no home. It is not an inline row. For a dimension the content asserts on (validity), the answer "is what is claimed", which is the assertion. For a dimension the content does not assert on (freshness, reach, simulation, comprehension), the answer is an act's outcome, and the *read as* examples return it as the warrant: "latest outcome", "computed reach", "fresh / stale" (`dimension.md:59`, `:65`; `impl-scope-adaptive-system.md:54`). So for most rows of the example table "warrant" is the value and there is no separate "how well that value stands".
- `def/verisectorium.md:60` (Working Notes) still says of this core: "here a dimension's answer is one warrant, and the value of an aspect and the certainty of that value are not kept apart." That note and the Definition's "three things are kept apart" cannot both describe the same text. From the examples, the note is the accurate one.
- `dimension.md:28`: "Where no rule can read it, it is routed to a decider and the answer arrives as that decision." For a found-out dimension that is a decision standing in for a found-out answer, which the invariant twelve lines down forbids (`:40`: "no decided answer stands in for a found-out one"). «decision»'s Discussion has the reconciling idea ("Every adjudication ends in a decision… that the evidence is enough", `decision.md:44`): the decision is about whether to count or close, not about the answer. The Definition does not say that; it says the answer arrives as the decision.

### 1.4 "Overclaimed" has no trigger left

The frontier item (`def/frontier.md:22`): "a piece's content says more about how well it stands than its warrant gives." The dimension invariant (`dimension.md:42`): "anything its content says about how well it stands may not exceed its warrant." The spine (`intro-spine.md:18`): "claim to stand better than it does."

Against those: the assertion row (`model.outline.md:44`) says an assertion "says what is claimed, not how well it stands"; the dimension Definition says "exact", "conditional on…" "are content: they say what is claimed"; and the outline's note for Joseph's vote, item (4), says "What content says about itself is what is claimed; it is not compared with a warrant."

So nothing a kind declares content may carry is a statement of standing, and the one thing that used to be compared with a warrant (the status word) is now, by decision, not compared. No run produces an overclaimed item: not the five invented moves, not the scope run's frontier at HEAD, and the stopped-bound run names it only to say there was none. Either the item is vestigial after choice (4), or there is a kind of content sentence ("re-derived twice", "verified first-hand") that is about standing, in which case a kind has to be able to say which sentences those are, and nothing in «kind» does. The spine's second sentence and the frontier's one-line ("what canon says outruns the record") both lead with it.

### 1.5 A frontier example still lapses contradictions on a rewrite

`def/frontier.md:47` (Examples): "two consequence claims contradicted, each by a check, and five findings. The integrator's rewrite lapses the contradicting acts and reopens the acceptance of every rewritten claim."

`def/act.md:29`: "a contradicting check or a finding does not lapse when the text it read is rewritten. It stays owed until it is **answered**." The same def's Discussion (`:51`) explains why the other reading is the cheap exit. The example is in a standalone section and states the reading the 13:51 actum says was removed.

### 1.6 A waiver clears, and a waiver does not clear

`def/frontier.md:20`, `:21`, `:27`: "cleared by … or a waiver". `def/steady-state.md:27`: "A waiver is visible in the conditions of every steady state while its item stays owed, and it ends with the repair that clears the item." `def/changeset.md:21`: "closes when every item it caused is cleared or waived."

Two of three say a waived item stays owed and is covered. The frontier table puts the waiver in the *cleared by* column, and only for three of the nine items; whether a reopened decision, a stale reference or a raised question can be waived is left to inference. «steady·state»'s own example (`:38`) waives a narrowed check, whose item (raised) has no waiver in its row.

### 1.7 A slot is in one state, and a slot is promised and filled

`def/segment.md:23`: "each slot is in one of these written states", with **promised** defined as "empty" (`:26`). The same def: "A promised slot is owed until what fills it is accepted" (`:42`); "promised, filled and unaccepted (work in progress)" (`:54`). `impl-an-outline-fills-in.md:34`: "The slot is filled… The promise is still owed."

Promised is being used as two things: a written state of an empty slot, and a decision that outlives the filling. The second is what the frontier item needs. If the written state becomes *filled* at step 2, then "promised" after that is read from the standing decision, not from the slot, and the four states are not the whole of what a slot carries. The outline's legend compounds it: its one `mark` column holds a slot state (promised, gap) or an acceptance state (accepted, provisional), and its "provisional (filled or suggested, not accepted)" fuses the two cases «segment»'s Discussion says a cold mind must be able to tell apart (`segment.md:54`).

### 1.8 A decision is an act by one actor, and by several

`def/act.md:10`: `rel by term="actor" card="{1,1}"`. `def/decision.md:6–7`: `rel is term="act" card="{1,1}"` and `rel by term="actor" card="{1,N}"`; Examples (`:50`): "one decision, two parties." Unity among seats is central to how this verisectorium accepts anything, so whether a decision in unity is one act with two actors or two acts that a rule reads together is worth saying. Related: «act»'s one-line (`act.md:17`) says an act "answers one dimension, and counts while what it read still holds", which is false of a finding (counts until answered) and of a decision about the work (answers none); the KDL note and the outline row are careful about both, and «dimension»'s KDL note (`dimension.md:9`) says "an act answers exactly one dimension".

### 1.9 The means that matter most have three names

The lesson of `impl-stopped-bound` is that an act must say by what means it asked, "in words the dimension declares". The words:

- `def/dimension.md:27`: "following the written derivation; setting the statement against its neighbours' results; building an instance; a formal proof."
- `dimension.md:58` (Examples): "re-derivation, collision with neighbouring results, a constructed instance."
- `def/act.md:55`: "by the means *re-derivation*."
- `impl-scope-adaptive-system.md:49`: "line derivation is the only means in the record."
- `impl-stopped-bound.md:45`: "a re-derivation, a collision… and a constructed instance."

"Following the written derivation" and "re-derivation" are used as one means. They are the two things the stopped bound most needs told apart: a mind that follows the written proof step by step shares its source with every other mind that did; a mind that derives the statement without the written proof does not. The model's own independence rule ("the same written derivation read" is one line, `dimension.md:43`) depends on that difference, and the vocabulary erases it. The small move's rule ("re-derived c by way of d", `impl-a-small-move.md:18`) is, by that reading, acceptance on the means the stopped bound shows to be one line.

### 1.10 Smaller two-sayings

- **Carrying and "however small".** `act.md:33`: carrying "is how a small rewording keeps the checks, and the decisions resting on them". `decision.md:36`: "a change to the basis reopens it, however small", and its example: "Reword the definition and the decision is reopened." Carrying keeps a decision only where its basis is the warrant and not the piece at its version; for acceptance by parties, as here, it keeps nothing. «segment»'s Working Notes know this; «act»'s Definition does not say it.
- **Only canon owes.** `frontier.md:33` says so; the spine's second sentence ("A violation is owed") and `dimension.md:42` ("Each failure is owed on the «frontier»") are unqualified. In a verisectorium with nothing accepted, which is this one, the frontier is empty by definition and every state is steady. That is intended, I think, and it is not said anywhere a reader of the spine would meet it.
- **‹segment·kind› is not the kind of a segment.** A veritoid is a segment (`veritoid.md:15`), and a ‹segment·kind› is "the kind of an assembly" (`kind.md:16`). And `actor.md:7` gives an actor `rel of term="kind"` ("an actor kind"), which is neither subtype, while «kind»'s one-line is "What a «segment» holds"; «dimension» is "of which kinds", "of an «actor» as well as of a piece" (`dimension.md:24`), and its one-line says "asked of a piece".
- **Three extents of steady state.** The one-line (`steady-state.md:15`): "of the whole or of the part outside every open changeset." `changeset.md:9–10`: an atomic changeset is *from* and *to* a steady·state that is "its scope as it stood settled", the part *inside*. And `changeset.md:10` gives `to` cardinality `{1,1}`, which an open changeset does not have.
- **Invariants that are norms.** "Where an act confirms part of it and contradicts the rest, it is split" (`veritoid.md:22`); "If the frontier keeps growing… work stops" (`frontier.md:39`); "Recording too little is as dishonest as claiming too much" (`act.md:45`). None can be broken in the sense `def/README.md` gives ("the thing that is broken when it fails"); they are praxis or rationale.

## 2. What the defs lean on and do not state

### 2.1 Mixed acceptance inside one assembly

`segment.md:32`: "Accepting an assembly accepts what it holds." The runs do not behave that way:

- `impl-an-outline-fills-in` gives D, held by O, an acceptance of its own: "D's acceptance read the old D: reopened" (step 5), "The steward and the lead accept the new D… O is read whole and accepted" (step 6). Two decisions.
- `impl-intake` step 5 writes a provisional c′ "into a new slot of T", T being accepted. So an accepted assembly holds a provisional piece. When T is next accepted, does that accept c′?
- This verisectorium's own outline is the same case: one assembly, each held inline row with a mark of its own.

So acceptance is per segment at every depth in practice, and the sentence in the Definition says otherwise. The related consequence, which the outline run states in a bullet whose heading says the opposite (`impl-an-outline-fills-in.md:49`): an assembly's version does not cover its fillers' versions (`segment.md:41`), so an assembly's acceptance, whose basis is "the segment at its version", is reopened by an edit to held content only through whatever check in its basis read that content. An assembly accepted with no whole-read in its basis would stay settled while everything in it was rewritten.

### 2.2 A reference to an assembly cannot go stale on content

`reference.md:18`: a reference holds when "the target's version is the one the reference last saw." `reference.md:21` allows pointing at a whole document "unless the whole is what is meant". But an assembly's version is its slots, their states and which ids fill them. Rewriting every veritoid inside a document changes none of that. So a narrates or predicated-on reference to a document, and every pointing slot of a projection, holds through any rewrite of the content it points at. «segment» handles this for acts ("a review of an assembly lapses on what its kind says such a review reads", `:41`); nothing handles it for references. Either a reference to an assembly reads something declared, as a review does, or the grain rule has to forbid relying on a whole.

Also unsaid about versions: a veritoid's version covers "the ids its references point at" (`veritoid.md:24`). A reference's kind and the warrant it needs are written too (`reference.md:13`), and neither is in the version, so turning a narrates into a predicated-on, or lowering what a reference needs, is a write that mints nothing and lapses nothing.

### 2.3 Pointing at a held segment

`segment.md:27`: a slot is filled "by a «reference» to a segment that is written on its own (**pointed at**)", and `:56`: "A held segment has one home and changes with it; a pointed-at one is shared and changes on its own. Nothing else distinguishes…" In `impl-an-outline-fills-in`, P has a slot "pointing at D" (`:25`), and D is held by O. `nutshell.outline.md` does the same thing to this core: every row points at a part of a def. So a held segment can fill another assembly's slot by pointing, held and pointed-at are not exclusive, and how P names D is the write-time addressing gap arriving in the first invented example that has a second projection.

### 2.4 "Canonical" is used as a term and defined nowhere

"At least one of its projections is canonical" is an invariant of «verisectorium» (`:26`). The orphan invariant (`segment.md:44`), the steady state's stated conditions (`steady-state.md:22`), the default weighting (`dimension.md:34`, `disc-better.md:10`) and orientation (`disc-actor.md:26`) all read from "the canonical projection". What makes a projection canonical (a declaration in the ontology, a decision, by whom) is not said in any def, row or note, and the word sits one letter from "canon" while meaning something else: this verisectorium's canonical projection is provisional, so it is not in canon. The 19:40 actum of 11-09 records that canon was once defined as "what the canonical projection reaches" and was changed; the other half was not picked up.

Other words the bodies define in bold and lean on that have no row: **scope** (of a changeset), **answer**, **backing** (the word the second atom stands by; «decision» never says what it consists of outside Historical Context), **party**, **provisional**, **settled**, **stated conditions**, **working state**, **source** in the actor's sense (which collides with ‹source›), **account**, **routing**.

### 2.5 Under a rule, what "reopened" and "withdrawn" mean

Every invented move but one accepts by rule ("a claim is accepted while…"). Under a rule, acceptance is recomputed at every state, so "reopened… until its party, or the rule that stands in for one, accepts it again" is just "does not now pass". Then a piece that once passed and now fails is "unsettled, in canon, owed", and a piece in the identical recorded condition that never passed is "provisional, owes nothing". That may be right (the first has dependents and a history), and it is path-dependence worth stating. And nothing says how a rule withdraws.

## 3. The runs

### 3.1 `impl-a-small-move`

- The 08:30 row lists **found** (c) and **reopened** (c, u). By the run's own rule ("a document is accepted when its claims are") T and U are reopened at 08:30 too. `impl-two-moves-at-once` runs the same setup and says so: "reopened (c, T, u, U)" (`:22`). Here T's reopening first appears at 09:25, attributed to the lapsed whole read, and U's is never listed. The run's stated purpose is that "the frontier says at every moment what is owed", so the column matters.
- Its rule says "a mind other than its author"; `impl-a-finding-is-answered` says "outside its author's lineage". The first predates lineage.
- Working Note 1 (`:46`) asks "Whether a reader of S0 should see it before 14:00". `steady-state.md:29` answers it as an invariant: a rendering made while a later move is under way "shows every contradiction and finding recorded since".

### 3.2 `impl-an-outline-fills-in`

- Step 4 is listed as "a decision, two parties". It also writes: the assumption is "written into R2 as an open question", which is a segment changeset on R2 that must land before the acceptance can read R2 at its version.
- P pointing at held D: see 2.3. D's separate acceptance: see 2.1.

### 3.3 `impl-intake`

- Step 5 calls writing c′ into T "one write, with nothing owed". By the rule the outline run applies at its step 1, a write that changes T's slots changes T's version, lapses its whole read and reopens its acceptance. Here that is masked because T is already reopened by the findings of steps 2 and 3, and the bullet "An idea has a cheap home… with nothing owed" generalises from the masked case.
- The findings of steps 2 and 3 are never answered or contested. The changeset opened at step 2 is still open at step 7, "weeks later", and the run does not say so; "T's and O's inboxes are empty" at step 6 reads as if the place were settled.
- `:48`: "The defs said a source is 'never rewritten' without that distinction; «segment» now makes it." That is history, in the body.
- Not exercised and not listed as such: how a single note from a mind ("a reader's stumble", `disc-record-surfaces.md:22`; "Anyone may add a note", `segment.md:53`) enters an inbox. As defined, an inbox holds chunks, a chunk is held by a ‹source›, and a source is cut whole. So jotting one note is: mint a source, cut it into one chunk, write a bears-on reference. That is the recording-cost gap at its sharpest, on the cheapest act the model wants to keep cheap.

### 3.4 `impl-scope-adaptive-system`, against the record

Tallied from `vsect why segment:scope-adaptive-system` today:

| the impl says | the record |
|---|---|
| 162 acts: 62 rederive, 10 run, 36 findings, 33 answered, 8 revises, 8 rewording judgments, 3 corrections, 2 read-checks | the same, verb for verb |
| six equivalent, two not | the same |
| 33 answerings: 5 fourth reader, 13 check-8 verifier, 15 round-6 integrator in a second-mind role | the same |
| three findings with no answer: check 8's F1, F5, and C11's narrowing | `check-8#C11/finding`, `check-8#F1`, `check-8#F5`: the same |
| 25 of the confirmed checks are an integrator's | 25 of the 61 confirmed rederive or run acts |
| integration-7 at `6e778ade`, a version no revise produced | five acts at `6e778ade`; revises give `aa9487fa`, `9fde935e` |

What I would still change:

- **Two denominators, unexplained.** "50 of its 63 confirming checks" (`:10`, `:86`) and "twenty-five of the sixty-one confirmed checks" (`:94`). Both are right: 61 rederive or run acts came back confirmed, and the two read-checks make 63. A reader meets them as a discrepancy.
- **A dimension on a reference.** §1 and §2 make each import a reference "of kind imports, each with a dimension *checked at source*", and the sketch table has *source* "of: import reference" (`:51`). «reference»'s Working Notes lean the other way ("Whether a reference may itself carry a warrant… Lean: no", `reference.md:46`), «dimension»'s example makes the import a piece (`dimension.md:60`), and "imports" is not among the reference kinds. The run needed something the defs lean against, and says nothing about it under "what strained".
- **"Nothing unsettled"** (`:84`) holds only because the sketch rule lacks the clause the other moves' rules carry ("no finding or contradiction stands against it unanswered"). With that clause, the fifteen findings whose only answer is their repairer's would leave their pieces unsettled, by the lean in `impl-a-finding-is-answered` (choice 1).
- The row for reread-1's F5 says "two bullets still open"; the record has it answered at 03:18Z by the check-8 verifier.
- Not checked by me: the cut in §1 against the ASF file, and which items each revise touched. The impl's own Working Notes say the same of itself.

### 3.5 `impl-stopped-bound`, against its primary

The table's quotations are in the primary as given, the dates and the 15:13 / 15:50 times match, "three model families" is right by the primary's naming (Claude, Codex, Gemini), and the corrections its Working Notes record are as the primary reads.

One sentence claims more than the primary holds, and it is the one the lesson rests on. `:12`: "What every one of those passes did was follow the written proof." `:43`: "Every confirmation followed the written proof. None put the statement against the segment's other results; none built an instance." The primary (`:101`): "The checks that passed (i) *mostly* verified a different thing: that the Itô correction, the Grönwall algebra and the optional-stopping step are each legitimate." And §5: "*Most* passes verified steps of the proof." For the Codex audit ("plausible", "can remain") and the 05-16 adjudication ("are fine") the primary records no means at all, and its author read six of the audit reflections whole and grepped the rest. That the means of those passes cannot be recovered is the run's own thesis; "every… followed the written proof" and "none… none" assert a recovery. The stronger true statement is available: the record cannot show that any pass asked by a second means, and that is exactly what a means-recording act would have shown.

Also: the body's opening line (`:10`, "Rewritten 2026-11-09 after a cold audit showed…") is history in the body, and the §2 right-hand column still reads the audits as checks while Working Note 1 says that under the rebuilt model each "enters as a ‹finding›, or as nothing". The run's headline survives that; its table does not yet say it.

## 4. The files against their own rules

### 4.1 Working Notes that have been overtaken

- `act.md:69`: "Untested on an invented move: answering, carrying and contesting." `impl-a-finding-is-answered` runs all three.
- `act.md:70`: "Lean: say this in the Definition once an intake has been run." One has.
- `impl-a-small-move.md:46`: answered by `steady-state.md:29` (3.1).
- `model.outline.md:93`: "The weighting of determinants is argued in three places and wants one." The 13:51 actum says it is "now argued in disc-better only", and that is what I find.
- `kind.md:49`: "which the outline lists as dissolved into kind." The outline lists nothing as dissolved.
- `reference.md:42`: "for the three notes above it" (it sits in Historical Context, and the notes are below it); `:49`: "It joins the two notes above" (one of them is now an invariant).
- `steady-state.md:54`: "Here acts lapse completely on any change to what they read." Carrying exists now.
- `verisectorium.md:60`: see 1.3.
- `core/README.md:8`: "Two `impl-` runs are invented moves." There are five.

### 4.2 Typed counts

`model.outline.md:93`: "what a reader must read to hold the model is about 25,000 words." Measured today (the outline, every `src/` and `def/` file, each cut at its first History, Historical Context or Working Notes heading): about 31,600. Whole files: 41,700. The 15:51 actum of 11-09 removed typed term counts for this reason ("a count being a computed thing that had been typed"). `bin/nutshell check` already prints the nutshell's size; nothing prints this one.

On the falsifier "if the terms have to multiply back toward eighty" (`disc-what-would-show-this-wrong.md:12`): the gate counts 12. Named in the outline: 12 terms, 12 subtypes, 36 inline rows. With the nine frontier items, four slot states and six reference kinds, 79. With the three acts about acts and three check outcomes, 85. The def bodies introduce 75 distinct words in bold. The outline's own note says "about fifty words, plus…" and asks that the falsifier be measured against that. Measured, it is at eighty now. Whether that falsifies depends on what the first core's eighty-five counted, which I did not read; what I can say is that the term/inline line is doing the work of keeping the count at twelve.

### 4.3 History in the inbox, and history in the body

`disc-record-surfaces.md:30`: "A verisectorium that keeps its accounts in Working Notes has made its history undrainable and its inbox unreadable."

- Working Notes holding adjudication records, which the disc template puts under Historical Context: `disc-record-surfaces.md:49`, `disc-actor.md:61`.
- `actor.md:69` repeats `actor.md:65` nearly word for word (one in Working Notes, one in Adjudication).
- `verisectorium.md:55–61`: five bullets of provenance and Joseph's messages, verbatim, under one "Open" item. It is the best account of the two atoms in the repository, and it is in the inbox.
- Body lines carrying dates and provenance: `disc-record-surfaces.md:10`, `disc-actor.md:10`, `impl-stopped-bound.md:10`, `impl-intake.md:48`, `disc-what-would-show-this-wrong.md:23` ("Two things the first cold read found"). The disc and intro templates ask for a "*Status and date line*" in the body, so two of these follow a template that is itself at odds with the README's "the files carry no change log of their own".
- `veritoid.md:18` (Intro): "Joseph's words: …". `def/README.md` does not say whether Intro stands alone; the template says it is "for a cold reader".
- `dimension.md:34`, inside `## Definition`: "`disc-better` is where weighting is argued." A standalone section pointing at a prose segment, which the gate's own comment says a def never does. The gate misses it because the slug has no `src/` in front.
- `praxes/working-on-core.md:22`: "an actum that runs ahead of its change is a false record, and this session wrote two." A praxis is for every mind; "this session" is true of one that has ended.

### 4.4 One change to core with no actum

Praxis step 7 gained "Nothing the verisectorium needs may live only in a commit message: an open item goes in the Working Notes of what it concerns" in `b9ff5a6` (11-10 13:51). The actum of that time lists what changed at length and does not mention the praxis. Step 9's rewrite in `5148e94` is recorded. Step 6 says every change to core is an actum.

The sentence that was added also sits oddly beside `disc-record-surfaces.md:41` ("Commit messages carry what git needs and nothing the verisectorium needs") and the same step's "a message a future mind can orient from": the 13:10 actum of 11-10 records a new actor orienting from "the commit messages since 2026-11-04".

### 4.5 What the gate does not see

All of these pass today:

- a pointer to a `src/` segment by bare slug in a standalone section (4.3);
- `## Intro`, which is not among the sections it checks;
- whether a prose segment's `narrates` covers the terms it uses (`impl-intake` uses «verisectorium» and does not narrate it) or whether the terms it narrates are marked when used (every prose segment narrates terms it never marks with «…»: the spine marks two of its nine, `impl-an-outline-fills-in` one of its nine, so a «…» mark is not a usable index of where a term is leaned on);
- whether the inline words listed in `def/README.md:11` are the outline's inline rows (they are, today, by hand);
- any section structure in `src/` or `praxes/`;
- relation cardinalities and KDL notes against the prose (1.8, 1.10).

The gate's outline-row pattern also accepts `present` as a mark (`bin/defs:92`), which is a `def`-column value.

## 5. Arriving cold

The front door works. Root README to `core/README.md` to the outline's rows is a path I could follow without help, and the outline's row order is a real reading order; I met few words more than a row or two before their row. Things a cold arrival trips on:

- **The spine uses nearly everything before it is defined**, which is its job, and the nutshell inherits that without repairing it. `nutshell.outline.md` aims for "each word met before it is used". The assembled text uses *warrant* seven times and never defines it, and the same goes for *canon*, *slot*, *waiver*, *acta*, *influx*, *determinant* and *lapse*: they are inline rows, and a nutshell row can pull a section of a file and cannot pull an inline row.
- **Three root files the README does not mention**: `slot-rollup.md`, `slot-rollup-once.md`, `segment-kinds.md` (9,180 lines). They are dated today and refer to a `proto-instances.md`. The root README says it tells what lives where.
- **`disc-actor` and «actor» are largely the same text twice** (the record's parts, the compaction argument, the pass in the acta), as are the two-atoms paragraphs in the spine, «decision»'s Intro and «verisectorium»'s Definition. The one-home rule is stated for invariants only; for size, this is where the 31,600 words could come down.
- **"History"** in three senses is noted in the outline; «verisectorium» adds a use that is none of the four surfaces of `disc-record-surfaces` ("a **history**, the changesets that have closed and the steady states they reached").
- The first person in `disc-what-would-show-this-wrong` ("my guess", "I expect") has no author a reader can identify, and "on 1,234 records" (`:16`) has no referent.

## 6. What held

So that the list above is not read as the whole picture:

- Every count in `impl-scope-adaptive-system` that the record can test is right, including the three the last correction changed.
- `impl-stopped-bound` quotes its primary faithfully; its conclusion (the model would not have caught it; the missing thing was the means) is the primary's own reading, apart from the one universal in 3.5.
- `impl-two-moves-at-once` and `impl-a-finding-is-answered` run on the defs as written. I found no step in either that the defs do not license, lineage aside.
- The outline's rows agree with the defs' one-lines and subtypes; the nine frontier items in the row are the nine in the table; the inline-word list in `def/README.md` matches the rows.
- The acta read as a truthful record, including against themselves (the estimated timestamps, the two acta that ran ahead). The last five entries' times match their commits to the minute.
- The praxis on disk is the one the `CLAUDE.md` import names; it differs from the copy loaded into my context at steps 7 and 9, as I was told it might.

## 7. What this report does not cover

- I did not read the earlier cold reads, so I cannot say which of these are new.
- I did not read `msc/notes/` or the first core. Every statement here about what Joseph said or decided is from core's own files and acta.
- I did not check the scope run's cut against the ASF file, or re-derive anything mathematical.
- I did not try to build an instance from the model, which «verisectorium»'s own example names as one of the things core answers to. A cold reader building a small ontology from the defs alone would be a different and probably more useful test than this one.
- By the model's own rule (1.1) I am of the lead's lineage, and I am the same model as the lead. Treat the findings as findings to be answered or contested, and treat the silence of this report about any file as silence.
- I changed nothing under `core/`. This file is uncommitted.
