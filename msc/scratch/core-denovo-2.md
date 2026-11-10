# De novo audit of `core/`, second

*2026-11-09. Claude Fable 5.2, a fresh agent launched by the session working on `core/` with Joseph. The ask: a de novo audit of `core/`, especially for how well it would handle the verisectoria described in `msc/notes/18-2026-11-08-dimension-census.md`, judged by the intent under those examples and not by parity with them. I edited nothing in `core/` and committed nothing.*

## What this rests on

**Read whole, myself:** the root `README.md`; every file under `core/` (both outlines, the eleven defs, the eleven `src/` segments, the praxis, the six templates, the two READMEs, `log.kdl`); `bin/defs`; note 18; and `~/src/aat-v3/preparations/research/missed-error-case-2026-11-06.md`, because `impl-stopped-bound` says it rests on that report and four defs cite the case.

**Run:** `bin/defs check core` (passes); ten planted defects against a scratch copy of the gate; `vsect why` and `vsect read` on `segment:scope-adaptive-system` in `~/src/arch/asf` at `68f68644`, to compare with the counts `impl-scope-adaptive-system` states; `md-press` in report mode over every markdown file in `core/` (clean, nothing to change); word counts per section.

**Not read, on purpose:** `msc/scratch/core-2-denovo-1.md`, `census-audit-1.md` and the other `census-*.md` reports, the first core, and the other notes. So I do not know which of the findings below the first cold read already made. The Working Notes cite it by section, and from those I know roughly what it settled; I could not avoid that.

**Independence.** Same model family as the authors. My global instructions carry vsect 0.1's mental model ("computed from recorded acts, never typed"), so the model's central line was in my head before I opened a file. Where I agree with core, discount it.

Each finding is marked **[verified]** (I checked the text or ran the command), **[follows]** (a consequence I derived from the defs as written, which may not be what was meant), or **[judgment]**.

## In brief

Core's answer to the census is strong where the census found fusion and wrong grain: one status word carrying several questions, standing attaching below the record, attestations as a different sort of act from checks, intake that could not tell "found everything" from "found something", who moves next. Those are placed, and placed more simply than the stores placed them.

It is weaker than it reads in four places, and the first is the one I would look at before anything else:

1. **The stopped-bound result is stated more strongly than its own primary supports.** Core says every pass concerned a step and so the statement's validity was never asked. The record it cites has at least three passes that affirmed the statement in so many words. On that record the model would have shown (i) confirmed by an independent mind from the third day, not owed for six months.
2. **The "second argument" has a mechanism only when its filler is inside the corpus.** A simulator version, a build, code, a cited paper, a reader, Joseph's eye: for these the defs say two different things (the answer lapses; a question is raised) and define only the second, with nobody named to record that the outside thing moved.
3. **The linchpins are the actor's own word.** What an act read, what it concerns, and whether its criterion came first are all declared by the actor, in a model whose `disc-actor` calls an actor's word about its reading the least trustworthy act in the acta.
4. **"Provisional" does three jobs, and whether provisional content is under the constraints is not said.** All 52 outline rows are provisional or gap; the way out is itself a gap row.

After those: references go stale regardless of kind, which makes every inbox chunk and every outline row an owed item on any edit; nothing reaches another verisectorium; absence has three of the census's eight kinds; the cap along predicated-on cannot express a second independent line of support; and for the decision-centred stores the determinant itself runs through the open steward-attestation gap.

Held to its own model, core has several small true-as-stated failures, listed in §5. Three counts in `impl-scope-adaptive-system` and one in `changeset.md` disagree with the command they cite. The gate caught two of ten planted defects.

## 1. The stopped bound: what the record says against what core says

**What core says.** Outline row: "false for six months under fourteen passes … caught by grain and by concerns-within-reads." `impl-stopped-bound`, the headline: "Fourteen checks that each concerned a step leave the claim's validity *never asked*, while its assertion says *exact*: owed from the first day." `frontier.md` Examples: "because every recorded pass concerned a proof step and not the statement." `steady-state.md` Examples: "no steady state from 2026-04-22 on without an acceptance." `act.md`, an invariant: "that is how the stopped bound survived fourteen passes." `veritoid.md` Examples: "That separation is what lets the model show (i) was never asked."

**What the primary says [verified].** The missed-error report §2.4, quoting the audits' own files:

- 2026-04-25, audit 584721 (Opus 4.7): "the stopped Grönwall bound holds. … ✓" and "**Math is sound throughout.**" The report adds that this pass also passed the old (iii), which another audit broke the same day.
- 2026-04-25, audit 742613 (Codex): "Prop A.1S's stopped mean-square bound is plausible"; "The stopped bound can remain".
- 2026-05-16, adjudication 628401 (Opus 4.7): "The *stopped bound* (i) and the *mean-square persistence* (ii) are fine — the defect is localized to (iii)".
- 2026-05-28, audit 773921 (Gemini 2.5 Pro): "they are textbook-perfect"; "What would I change? Nothing."

The report's own summary is "The checks that passed (i) **mostly** verified a different thing." Core turned "mostly" into "each" and "every".

`impl-stopped-bound` does carry the 04-25 quote, and beneath it writes "The audit's own words are about steps; recorded honestly it concerns steps." The words quoted are "the stopped Grönwall bound holds", and the stopped bound is (i). For 05-16 it supplies a criterion the adjudicator never recorded ("is the defect localized to (iii)?") and concludes the act concerns (iii). Its "Not shown, honestly" paragraph treats a confirming check on (i) as a hypothetical. On the record it is the plain reading of two or three acts.

**What follows [judgment].** Had the engine existed in April, the likelier record is: 04-22 (i) lands, never asked; 04-25 an independent non-author confirms it, concerning (i). No overclaim after that, no never-asked condition, and a later reader sees (i) as checked by three model families. Per-veritoid grain and concerns ⊆ reads make that record more legible. They do not make (i) owed.

What broke (i) was a different *method*: the report's "The break tested the statement against a neighbouring result" (the census's B5), with a Monte Carlo beside it (B4). Every earlier affirmation followed the written proof (B1). So the impl's conclusion, "This does not need a separate dimension … It needs two things the model has anyway", is the part I think is wrong, and the census's finding 8 is the part that stands: "which of the several 'valid' questions it asked" has to be countable.

**The stronger form is already within the model's vocabulary.** `dimension.md` lists "a conjunction of named checks" among the ways a warrant is read. If AAT's validity read *exact* only when a re-derivation, a collision scan against the segment's own results, and a constructed instance all bind, (i) would have been owed until someone ran the scan, and the scan is what broke it. That is a claim about the dimension's declaration, which is where note 19 put it. Two smaller things the record also asks for and core has no place for: an act that confirmed several pieces and was broken on one of them the same day (584721 on old (iii)) leaves its other confirmations binding at full weight; and a refutation of a neighbour that names this piece "the safe fallback" is correctly not an act, but nothing shows the reader that the repair leaned on it.

I would re-run this impl with the April and May passes recorded as their words read, and let the result be whatever it is.

## 2. Where the census's intent has no place yet

### 2.1 The second argument, when its filler is outside the corpus

Census finding 5: the filler is what moves, and the answer lapses "without the piece having changed". Core's reply is the *against* slot, and `dimension.md` says "An act answering the dimension reads what fills this slot, which is why a change in it lapses the answer."

**[verified]** `act.md` defines a read as one of three things: a veritoid's written state, its assertion on a dimension, or its warrant on a dimension. Nothing outside the corpus can be read at a version. What `act.md` gives for outside things is ‹outside·change›, "recorded at a moment", and `frontier.md` turns that into a *raised* item for the producer to answer. `disc-actor` says the opposite mechanism is already there: "an act reading an instrument at a version, lapsing when it moves."

So for fillers outside the corpus there are two mechanisms claimed (lapse; raise), one defined (raise), and no producer named for the ‹outside·change› itself. If nobody records that the kernel moved, every run against the old kernel still binds. That is the census's C1, C2, C6, C8, A2 and F2: vivarium's R² going from 0.36 to 0.94 on the same construction, "his eyes pending" on a new build, "a measured claim is a memo without a key", `convict` on 62 of 115 segments where the thing held against is code. It is most of what a tool or build verisectorium (limen, aspectus, md-press) adjudicates, and it is where I would expect the third instance to strain first.

**[judgment, untested]** One way through that adds nothing: a pin is written content. A veritoid whose content is "the simulator at this hash", "address theory at `90f4fb6`", "this build" can be read at a version like anything else; moving the pin is a write; everything that read it lapses by the one rule the model already has. ‹outside·change› might then reduce to the changeset that moves a pin.

**Two smaller things in the same place [verified].**

- A cited work is outside in `act.md` (‹outside·change› lists "a cited work") and inside in `dimension.md` (the import row is held "against the cited work, named by reference", and a reference's targets are veritoids or segments). And ‹source› is defined by being drained: cut completely, "retired, computed, when every chunk has a final crossing". In the source-fidelity stores (ai-risk-model's 472 sources, comproprium) a source is the standing thing every quote stays anchored to, and retiring it is meaningless. ‹source› is carrying two roles: influx to be consumed, and an original to be held against.
- Census A1: "span extracted, never retyped". That is content computed from a reference. The written/done/computed table has no row for content that is a function of other content, and core's own outline is a specimen (§5.4).

### 2.2 What an act read, what it concerns, and when its criterion was fixed are the actor's word

**[verified]** `act.md` says the actor is "read from the harness, never typed". It does not say who supplies the read set, the concerns set, or the order of criterion and outcome; `impl-scope-adaptive-system` says "an act must say which veritoids it read". `disc-actor`: "An actor's own word about what it has read is the least trustworthy act in the acta."

Binding, lapsing, independence and the stopped-bound argument all rest on those three declarations. `act.md` notes that lapsing as a unit "pushes actors toward acts that read as little as possible, which is also honest". It is also the cheapest way to hold a warrant: an act that under-declares its reads never lapses. The census's G2 (`read:` on 139 of 500), G3 ("you either read it in *this* session or you generated it") and C4 (`committed: before` on 226, `after` on 274, undefined anywhere) are this.

**[judgment]** Each has an observed form. A harness can record which files a mind opened. A criterion is fixed first only if it lands in the acta as its own entry before the outcome does, or as a sealed hash, as vivarium's quiz did. If reads stay declared, I think the defs should call them attestations and say what that costs. The gap row "write-time addressing" covers how a mind names a veritoid; it does not cover whether its account of what it read is observed or attested.

### 2.3 "Provisional"

**[verified]** Three senses are in use. (a) The `row` inline: commitment is provisional or promised, and that is about whether a segment will exist. (b) The outline legend: `mark` is accepted, promised, provisional or gap, where "accepted" is a decision about content, appears in no def, and is called "decided" in the KDL `status` line and the praxis. (c) `verisectorium.md` invariant 3: a provisional segment of any kind "is, to canon, only a claim that the suggestion … exists". So the `mark` column fuses commitment, decision-standing and gap, against `dimension.md`'s first invariant. `segment.md`'s notes have the "gap" half of this; not the "accepted" half.

**[follows]** Under (c), what a provisional segment that is *present* asserts inside itself is not a claim of canon. Nothing says whether its overclaims are owed. If they are not, marking a segment provisional is a universal exit from the frontier, cheaper than an acceptance and with no reason attached. If they are, provisional claims a good deal more than "the suggestion exists". AAT's migration turns on which: every claim that arrives asserting *exact* is either an overclaim on day one or exempt.

**[verified]** All 11 defs say `status provisional`; all 12 `src/` and praxis files say `status: provisional`; the outline is 45 provisional rows and 7 gaps. The path out is a gap row in `praxes.outline.md` ("releasing a decision … Not yet needed; nothing is decided"). The census named this shape in its finding 1 and its disagreement 8, "a transition whose actor was never assigned", and said of the first core "which is honest and is also the same shape". It is still that shape.

### 2.4 References

**[follows]** A reference "holds" when its target exists, is at the version last seen, and meets the need; `disc-dimensions-as-constraints` makes that the second intrinsic constraint, for every kind. A chunk's *bears-on* points at a segment, whose version changes with any veritoid in it. So every chunk in an inbox becomes a stale reference, owed, each time its segment is edited, and `segment.md`'s notes say a chunk is never rewritten, so it cannot be reconciled. The same holds for every row of a projection: one edit anywhere stales the outline's reference to that member. `segment.md` protects a projection's *coherence review* from this; nothing protects its references. `reference.md` already says a kind "says what passes along it"; whether a kind goes stale at all wants to be part of that. (The Decide note on reconciliation-as-a-write is about the cascade, which is a different consequence of the same clause.)

**[verified]** Two things called references are not from a veritoid, which `reference.md`'s relations require. *Seeded-by* is glossed "two acts are not independent", a relation between acts, which are done, not written. An actor's consortia are "references to other actors". If independence is to be computed from descent (`act.md`'s lean), the descent record needs a home, and it is not in written content.

**[verified]** An inbox is "the chunks bearing on it with no final crossing", so membership is by the chunk's written, immutable bears-on. But a ‹crossing› outcome is "passed to a segment's inbox". A chunk cut with the wrong bears-on cannot be re-routed by either rule as stated.

**[verified]** A ‹segment·changeset› is on exactly one segment (`rel "on" … {1,1}`) and "may … move veritoids in or out". A fold-back changes two segments' written states; between the two changesets the veritoid is in both or neither, against `sits-in {1,1}`.

### 2.5 Across records, and into other bodies

Census finding 3 has three directions. Core answers "below" well. For "across", the census asks whether a relation can itself be what has a value. **[verified]** `reference.md` leans no ("contest it by a finding on the referencing veritoid"), while `impl-scope-adaptive-system` §1 reads the Epistemic Status imports as "**references** of kind imports, each with a dimension *checked at source*". The `dimension.md` example avoids this by making the import a veritoid kind. The two should agree, and relata's whole subject ("a sentence in a paper elsewhere") depends on which.

For "into other bodies" there is nothing: no row, no gap row. A crossing may end "delivered to another verisectorium" and nothing says what the receiving side holds. Udon's `CONSUMERS.md`, ai-risk-model's pin of address theory at a commit, the paper that is "the more careful of the two" against its own theory, and the census's D13 ("who else must be told") have no place. Core is itself the case: its Examples say it is "delivered as what `v2` and each verisectorium's ontology are built from", and AAT's ontology in `aat-v3` will follow some version of these kinds.

### 2.6 Absence

Census finding 6 lists eight kinds. **[verified]** Core has three: never asked (a warrant), not opened for this kind (a fact), and a missing reference target (owed). A fourth, declined for this piece with a reason, is a lean in `kind.md`'s notes. Not placed: looked and not found, with the search carried; deliberately left open, with the reason; decided to be empty ("None recorded. Do not reconstruct them."); withheld from this reader. No Working Note asks the census's question (one thing or several; core's or each ontology's).

**[follows]** Two of these would be acts if an act could concern them. `act.md`'s relations let an act concern veritoids and actors. An empty slot has no veritoid to concern; neither does a missing reference; and a segment's *own* dimensions (coherence) need an act that concerns a segment, which the relations also omit.

### 2.7 The steady state at the estate's scale

**[judgment]** Three things, all downstream of census finding 1.

- The steady states are one line for the whole verisectorium, and a `frontier` belongs to "the atomic changeset in progress", one. With many agents on unrelated segments, any open finding anywhere means work time everywhere. `disc-actor`'s test for what an arriving mind should read ("which case holds is a fact about the verisectorium's state") would then nearly always answer "mid-changeset". "Parallel changesets" is a gap row, punted; I think it bears more weight than a punt suggests. A projection already carries a purpose and a sense of better; a steady state *of a projection* may be the practical unit.
- A steady state's conditions include every determinant never asked. The census's reader counted 500 checks on 94 of 1,234 ASF records. At that coverage the conditions are tens of thousands of lines, and `frontier.md`'s own note applies: a computed thing nobody can read silts like a kept list. Never-asked on a *fitness* dimension is not a condition at all, so it shows nowhere.
- "A dimension has a producer, or the ontology checker refuses it" tests the declaration. The census's dead fields all had declared producers: `awaiting-second` true on 236 of 236 because the clearer never clears. What it asks is whether the producer has ever fired. That is computable from the acta per dimension (pairs opened, pairs ever answered, last firing) and core does not ask for it. Likewise crossings: `frontier.md` makes uncrossed chunks and unretired sources explicitly not owed. Visibility is a real gain over the October sprint, but the outline's own practical test (3), "no source was ever retired", is answered by visibility alone, and the census's law is that what depends on someone returning later stops.

### 2.8 The cap is a minimum only

**[follows]** Effective warrant is "the least of its own warrant and the effective warrants of everything it is predicated on". On an ordinal ladder that is exact on any acyclic graph, reconvergence included, since a minimum cannot double-count; the census's AND/OR-tree caution bites only where a credence is propagated. But every predicated-on reference is a conjunct. A claim with two independent derivations from different premises can only be lowered by the second. Joseph's line in the census is "the truth level itself is something like the max(orthogonal evidence lines)", with max and gcd as "two very worthwhile but distinct patterns". Core has the max *within* a piece (highest confirmed rung over acts) and the min *across* references, which is a good pairing, and has no way to write alternative support across references.

### 2.9 Orientation as an ordinary act

**[follows]** An orientation pass is "bound to what it read", and an act lapses when anything it read changes. Read literally, a mind's pass lapses on its own first changeset to a segment it was sampled on, and on anyone else's edit to a sampled root; with "no write by an actor without a binding pass" its second write is refused. Vivarium's gate bound the pass to the compaction generation, not to content. That may be intended (re-orient to what moved), but it is not said.

**[verified]** Nothing says *when* standing is read. An orientation warrant lapses "when the actor ends", and every actor ends. If a warrant computed today reads standing as of today, no past check has standing; it must be as of the act, and the defs should say so.

### 2.10 The decision-centred stores

**[judgment]** For a theory, steward attestation is at the edge. For udon's spec, the decisions store and address theory, `verisectorium.md` says the rules answer "to their own consistency and to the intent behind them". The intent is Joseph's, so the *determinant* is held against a party's mind and its only producer is that party's attestation, which is the open gap row. Add that `act.md`'s notes say "decision" is "used throughout core and placed nowhere", and that co-definition cycles are a lean in a note. The second instance will meet all three before it meets anything the two AAT runs exercised. The census's D4 (assumptions; reopen-when; forbidden to back-fill) fits well once a decision is a veritoid: an assumption is a predicated-on target, and its change asks the question.

### 2.11 Not placed, smaller

- **D8**, may it be shown, cited, changed, and by whom: anonymization under double-blind review, the private response projects, "The distinction is publication, not validity". The earned half of a licence fits exactly (a ladder read from acts; "tools may downgrade a mark that no record supports" is assertion ≤ warrant). The membrane half, a rendering for a reader-role, is nowhere.
- **G4 and G6**, could this check have failed, and what is this checker's verdict worth. Standing is yes or no "before any question of quality", and then nothing addresses quality. The census's reader has 65 of 153 non-integrator re-derivations finding something against 7 of 123 integrator ones; that is computable per actor kind from the acta. `changeset.md`'s worked move says the lapsed act "is what a verisectorium needs in order to know what B's checks are worth", and that is the only place it appears.
- **B9**, the whole as self-consistent: vivarium calls it "an asymptote … never an event that certifies completion". Core's coherence is an *own* dimension confirmed by a review, which is an event. A read-as of "no contradiction found by scans of declared reach" would be the same refusal.
- **The addressee** of finding 7. Guards, non-claims and closers are veritoids, which is right. That a guard reaches the editor at the moment of editing wants an inner dependency from guard to claim, so that changed-or-affirmed forces the look; `kind.md`'s example lists no such dependency.

## 3. Where core answers the census well

Stated because a list of gaps misreports the proportion.

- **Finding 4, one field carrying several questions.** Assertion per veritoid per dimension, against a warrant read from acts, with `status:` reduced to a rendering. This is the clearest thing in core, and `impl-scope-adaptive-system` §1 (the Epistemic Status sentences taking four homes) is a convincing demonstration of it.
- **Finding 3, below the record.** Minted ids, grain discovered by adjudication, a narrowing check as the split signal. Both real splits in the scope run are good evidence.
- **Finding 2, attestations.** Two sorts of act, differing in how they are corrected, is the right cut, and "an acceptance warrants nothing about any piece" with "silence is not ratification" answers Joseph's "authority displacing thought".
- **Finding 7 and D7, who moves next.** A frontier computed with "cleared by" replaces flags that nobody clears.
- **F4, intake.** A cut that must cover the source, with a crossing per chunk, makes "found everything, or something" computable.
- **Disagreement 6**, the body as both content and a record of acts: `disc-record-surfaces` is a clean answer.
- **Disagreement 4**, every kind answering to a determinant: "opens at least one dimension", not necessarily a determinant, lets a debts ledger or a consumer registry be content.
- **Joseph's state flags** ("citations-check (resets whenever it's edited)"): acts that lapse on change are exactly this, with no extra machinery.
- **The three orderings** (prerequisite, precedence, veto) are stated and nothing combines dimensions on a piece.

## 4. By family of verisectorium

From the census's "Verisectoria known so far". The third column is my guess at what strains first; none of it has been run.

| Family | What it was reaching for | Core today | Strains first |
|---|---|---|---|
| Full claim or precept (ASF, vivarium, comproprium) | which question a check asked; standing per piece; nothing typed | the home case; two runs | §1 (method); for vivarium §2.1 (code and era as the thing held against) |
| Decided or spec-centred (udon, address theory) | who stands behind it, how revisitably, what reopens it | attestation and "that party's latest word" fit | §2.10: the determinant runs through the steward gap; decision unplaced; cycles |
| Cousin stores (terminology, refs, relata) | a relation to a sentence elsewhere as the thing judged | credence as a declared read-as fits | §2.5 (reference as subject; another body) |
| Source-fidelity (ai-risk-model, the response projects) | copy against original, never retyped; typed nulls for sources; who may see | a script as an ‹instrument›; licence levels fit | §2.1 (source as standing referent; derived content), §2.6, D8 |
| Tools and build programs (limen, aspectus, md-press) | does it work, on this build, to the one who can say; refusals | ledgers as kinds fit | §2.1 throughout; G4; the refusals gap row |
| Paper-section (the papers) | a subgraph reweighted for a venue; frozen as submitted | projection weights fit well | a submitted rendering is a delivery (§2.5); D8 |
| Registers of outside facts (ops) | decay by the calendar | a rule over a date, raising | who runs the rule; §2.1 |
| The model's own (`core/`) | coherence, consistency, a cold reader can build an instance | kept by hand | §5 |

## 5. Core held to its own model

README: "This repository is itself a bespoke verisectorium." All **[verified]** unless marked.

1. **Typed counts that disagree with their source.** `impl-scope-adaptive-system` cites `vsect why segment:scope-adaptive-system`. Run today at the same ASF head: 162 acts, as stated. But "158 of 162 are `rederive` or `run`" is 72 (62 rederive, 10 run; the rest are 69 findings, 8 revises, 8 confirm-rewordings, 3 corrects, 2 read-checks). "Nineteen of the confirmed checks are the integrator's own" is 25 of 63. "50 of its 63 checks lapsed" is 74 checks: 63 confirming, of which 13 hold and 50 are lapsed, plus 11 broken or narrowed. `changeset.md` Examples says "four revise acts"; there are eight. The log's 15:51 entry already drew this lesson for term counts.
2. **The gate's reach.** Ten defects planted in a scratch copy; `bin/defs check core` caught two (an unresolved «term»; "note 09" in a def's Examples). It passed: a `src/` body resting on `msc/notes/09` "for the full derivation"; a def Definition pointing at `spikes/…`; a def with its Discussion and Examples deleted; an invariant restated in a second def; a `narrates` list missing terms the body uses; `status decided` with no decider; an outline description contradicting its def; a gap row deleted and an inline row duplicated. Praxis step 5 describes the gate as checking that "no standalone section points outside"; for `src/` and for most paths it does not look. Census G4, in vivarium's words: "A green probe certifies only what its discrimination covers."
3. **`src/` bodies carry provenance and a second person.** Nine of eleven open with a "*Moved from …*" line (seven from `MODEL.md` "on Joseph's suggestion", two from `examples/`). Five address Joseph as "you" in the argument ("This is your …", "Yours:", "Your two regimes", "your definition"). `disc-what-would-show-this-wrong` cites `msc/scratch/core-2-denovo-1.md` in its body. None has the template's Historical Context section, and nine of eleven have no Working Notes. `templates/README.md` says every segment of a kind "owes conformance"; that frontier is real and shown nowhere.
4. **The outline restates what it projects, by hand.** `segment.md` says a projection kind declares what a review reads of each member, "headline and assertion". The description column is written, not read from the member, and has drifted: the verisectorium row and `intro-spine` say "an ontology, a corpus, acta and a history", four; the def says five, with praxes. For inline rows the same column *is* the definition. One column, an owner in 23 rows and a copy in 11. Census A6: "An inlined definition is not a copy. It is a fork." The four record surfaces are stated in full in four places (`disc-record-surfaces`, `segment.md` Discussion, `def/README.md`, `templates/README.md`), and `disc-pieces-and-identity` is mostly a restatement of three defs, including the version rule `veritoid.md`'s notes lean toward changing.
5. **"History" names three things:** the line of steady states (`verisectorium.md`: "a **history**, the line of its «steady·states»"), the slot of account veritoids, and "the history of renderings". The lexicon is otherwise careful about collisions.
6. **`def/README.md`** lists "actor" among the plain inline words; it has been a term with a file since the 13:30 entry.
7. **`verisectorium.md` Discussion** gives the frontier's items as six constraints including "inner dependents changed or affirmed" and "every dimension produced". `frontier.md`'s table has neither (the first is a refusal, the second an ontology check) and has *raised*, which the list lacks.
8. **Intrinsic constraint 3**, "nothing is warranted above what it is predicated on", cannot be violated: the effective warrant is defined by the cap, and `frontier.md` says "the cap itself is never a violation". `steady-state.md`'s first invariant still lists it as holding "except by recorded acceptance". Only its acyclicity half is a constraint.
9. **Row order.** The outline says "in dependence order". `disc-written-done-computed` and `disc-record-surfaces` sit before five and seven of the defs they narrate. As a cold reader I felt it at `disc-record-surfaces`: slots, account kinds, inner dependencies and changesets are used several rows before they are defined. `segment.md`'s notes have the general question; this is the specimen.
10. **What an ontology declares** is four things in its inline row. Collected from the defs it is at least eight: veritoid kinds (content shape and its normalization, dimensions opened, assertion forms, references allowed and perhaps expected); segment kinds (slots, inner dependencies, how each segment dimension is read; for a projection, what a review reads of a member, and the weights); dimensions (five or six slots, the determinant mark, prerequisite, precedence, veto); reference kinds with their behaviour; rules over attributes; actor kinds and who may accept; the sense in which content is "stronger"; its own constraints. "Rule" is machinery (‹rule·firing›, *raised* items, "every declared rule evaluated") with no row and no stated home.
11. **Working Notes are 31% of the defs by words** (5,377 of 17,215), and about half of `changeset.md`, `reference.md` and `kind.md`. Four of the last seven acta (16:21, 16:29, 16:35, 16:56) add to them; one of those also cut some. Roughly forty open items, four of them marked "Decide (Joseph)", wait on one draining act. The reading path (outline, `src/`, defs) is about 30,700 words against the outline's own aim of roughly 350 lines. The outline's note says it is not there yet; the direction of the afternoon's acta is away.
12. **Core's own determinants** are named in prose (`verisectorium.md` Examples: coherence read whole, consistency among its terms, whether a cold reader can build an instance) and declared nowhere, against its first invariant. Producers: cold reads fire (this is one); the gate covers part of consistency (item 2); no instance has been built, so the third is, in core's word, a wish.

Kept, and worth saying: `md-press` is clean on every file; the log's corrections (the estimated `at=` times; the two acta that ran ahead) are the model's own discipline practised on itself; the praxis's step 0 was earned the same way.

## 6. If it were mine

Opinion, for whatever use it is.

**Write one ontology whole before another def changes.** Every dimension table in core is a sketch inside an impl, fitted afterward to a record its author had already read. The smallest honest candidate is core's own: five segment kinds that already exist as templates, the three determinants of §5.12, the standalone rule as a constraint, the cold read and the gate as producers. As a cold reader trying to build an instance I could draft kinds and five-slot dimensions from what is here. I would stop at: the assertion vocabulary and its ordering per dimension; what a rule is and where it is declared; how a standing gate is written; what form a weight takes; which reference kinds go stale; and whether provisional content is under the constraints. Six of the findings above are those six stops. Writing the declaration would force each as a small decision in context, which is the outline's own advice ("run one more real root before adding any term") and the census's ("with a written guess beforehand").

**Then re-run the stopped bound forward**, with the April audits recorded as their words read (§1).

**Decide what provisional exempts** (§2.3) before AAT's first intake, because it sets whether day one has ten thousand owed items or none.

## 7. What this report's silence does not mean

- I walked the census's eight findings, its nine disagreements and its row families against the defs. I did not walk all eighty-odd rows one at a time; rows not named here were not each checked.
- The census is itself one remove from its primaries, and I am one further. Every count quoted from it is a reader's count. The only primaries I opened were the missed-error report and vsect's record of one ASF segment.
- §1 is a judgment about a counterfactual: what April's auditors would have recorded. The quotations are verified; what they would have ticked is not knowable.
- Items marked **[follows]** are literal consequences of the text. Several may be things the authors mean otherwise and have not yet written.
- I did not check `relevant-mental-models.md`, the kernel spikes, or whether the Historical Context breadcrumbs resolve.
- I did not assess whether the term set is the right one, beyond noting what has no home. Eleven terms read as about right to me; that is an impression, not a finding.

## 8. On the brief, and adjacent things

The brief was the right size. Joseph's note, to judge by intent and not parity, changed what I did: without it §4 would have been a row-by-row compliance table, and §2.1 and §2.10 would not have been found, since both come from asking what a family of stores was *for*.

Adjacent, not acted on:

- ASF's head commit is "pre-commit hook: disabled for now (Joseph, 2026-11-04)". The global CLAUDE.md's vsect entry still says "asf's pre-commit hook runs `vsect check`". The census flagged this on 11-08.
- The census says "The eight rows are the eight questions the one word 'valid' covered"; its family B table has nine rows. `dimension.md`'s "at least eight" survives either way.
- Raw outputs behind §5.1 and §5.2 are in this session's scratchpad and will not outlive it; the commands are named above and re-run in seconds.

I'm staying on the line.
