# The verisectorium model

*To Joseph, and to whoever arrives cold. Fable 5.1, 2026-11-08, after the whole of `msc/notes/` in order, the last two days of transcript, and the two real ASF segments worked in `examples/`. Written to be read top to bottom; each word is introduced before it is used. Everything is provisional. Where a thing is yours I say so; where it is mine it is marked [M] and is the least tested. A «word» is a term with a file in `def/`; other words in bold are defined where they appear and in the outline's inline rows.*

---

## 1. The whole thing, first

A «verisectorium» is a body of written work that is never finished, worked on by many minds who arrive knowing nothing about it, that takes material in, cuts it into pieces, holds each piece to declared questions, assembles the pieces into coherent wholes, and at its checkpoints is true as stated, with its conditions stated. That is your definition (1), with (3) folded in: a concrete one has an ontology, a store of what has been written and done, and a history.

Five sentences carry the rest. Everything below is these, made exact enough to run.

1. **The store holds what was written and what was done. Everything it says about how well a piece stands is read from that record, never typed from outside it.** It holds many true sentences, but it holds no verdict on them except what the acts warrant: a true claim nobody has checked and a false one everyone has passed look the same to it until an act says otherwise. A claim believed for good reasons that later fails is not a malfunction.
2. **A dimension is a constraint.** For every piece and every question its kind opens, what the piece *asserts* about itself may not exceed what the acts *warrant*, and what passes along its references must hold. A violation is owed. This is your "dimensions become logical correctness constraints", and your "internal self-consistency is an underlying current of all verisectoria" is the set of constraints every verisectorium has whether or not it declares them.
3. **A checkpoint is a state where nothing is owed, except by recorded acceptance.** Between checkpoints the store is in work time, and the frontier says exactly what is still owed and who can clear it. The acceptances are the checkpoint's stated conditions.
4. **Writing happens in segments, at one logical instant; warrant moves one act at a time.** There are two levels of content, veritoids and the segments they are written in, and no more.
5. **Better is a direction along the dimensions the ontology names as determinants.** It is a partial order, not a score and not a queue. Softening is the cheapest way back to a checkpoint; strengthen-first is what the direction adds. What to work on next is a decision.

And one rule under all five: **identity is minted and outlives content.** Acts bind to versions; versions are of something; that something has an id the store gave it and never reuses.

## 2. Written, done, computed

| | What | Who sets it | How it changes |
|---|---|---|---|
| **written** | a veritoid's content, its assertions, its references; a segment's assembly (which veritoids, in which slots, in what order); a projection's members | an author | only by a segment changeset |
| **done** | acts: who did what, against which versions, answering which dimension, with what outcome | an actor, at a moment | appended, never edited; corrected by a later act |
| **computed** | every warrant; whether each reference holds; the frontier; whether a state is a checkpoint; every attribute and roll-up; each segment's inbox | the store, as of a state | by recomputation, never by anyone |

Acts are the input both sides answer to. A typed status word is a written thing wearing computed clothes; the whole discipline is the line in this table.

## 3. The pieces

A **veritoid** is one piece of **content** of a declared kind, together with what it asserts about itself and what the acts warrant for it. Yours: "content with one or more dimensions + rules". In ASF's files it is usually a `##` section or something smaller: one lettered item under a statement, one step of a derivation, one entry of a claim record. It almost never makes sense alone and is never changed alone.

A «segment» is veritoids written and judged together, under a **name**. It exists because keeping its veritoids together when adjudicating any one of them is crucial; a change to one forces a look at its neighbours. It is the unit of writing and of whole review. Two subtypes need naming at once: a ‹projection› is a segment whose places hold references to other segments in a chosen order (a chapter, a volume, the canonical outline, a report), and a ‹source› is a segment whose veritoids are **chunks** cut from material brought in (§8). At least one projection is **canonical**: it says "this is the work, in this order", and each of its rows carries two states kept apart, commitment (**provisional**, a suggestion; or **promised**, by a decision) and existence (**absent** or **present**), so that an outline full of unwritten rows is still true at every checkpoint. Its review lapses only on what its kind says a review reads of each member, and a member may be a segment that does not yet exist; that reference is owed, not forbidden.

A «kind» says what a veritoid or segment holds and which dimensions apply to it. A ‹veritoid·kind› declares a content shape, the dimensions it opens, which assertions its content may carry, and which reference kinds it may hold. A ‹segment·kind› declares **slots** (which veritoid kind goes in each, required or not, how many, in order), **inner dependencies** between slots (the eli8 rests on the description, which rests on the formal claim), and how the segment's own dimensions are read from its veritoids: aliased to one, derived from several, or asked of the whole (coherence).

**Identity, names, versions.** Every veritoid and every segment has an **id** the store mints at creation and never reuses. A segment also has a **name**: a label bound to its id, with history; a rename is recorded and old names keep resolving; two segments under one name is a failure the store surfaces. A veritoid has no name; a rendering addresses it through its segment. A veritoid's **version** is the hash of its written state: content, assertions, and references with the versions they were last reconciled against. So re-pointing a reference is a write and mints a version, which is right, because a derivation that now uses a different premise is a different derivation. A segment's version is the hash of its assembly and its veritoids' versions.

**Recutting.** A *split* retires one id and mints several, recording descent; a *merge* retires several and mints one; a *promote* or *fold-back* moves veritoids between segments and keeps their ids. A reference to a retired id is owed (re-point to a descendant, or drop) and is never silently redirected. Grain is discovered by adjudication: when an act confirms part of a veritoid and breaks the rest, the veritoid wants splitting. [M for the id rule; the gap it closes has been open since 11-05.]

**Two levels only.** Content has veritoids and segments. Projections gather segments to any depth, but that is gathering, not content inside content. The decomposition could continue as mathematics; two levels is where practice stops, and every rule here is stated at one of them.

## 4. Dimensions are constraints

A «dimension» is one question that can be asked of a piece. The ontology declares each one with five things, plus an optional sixth, and the census of what the estate's stores actually adjudicate is why there are five and not two:

| The declaration says | For example |
|---|---|
| **asks**: the question | does the statement as written follow from its premises? |
| **of**: which kinds it applies to | claims |
| **against**: what the piece is held to, where that varies per piece, how a piece names it | logic, under the hypotheses the claim states; or "the source this quotes", named by a reference |
| **produced by**: what act answers it, and whose acts have standing | a ‹check› by a mind re-deriving, not the author |
| **read as**: how the warrant is read from the acts that still bind | the highest rung reached by a confirming check, unless a later check is broken; narrowed counts as a split signal |
| **passes along**: what it does to pieces that reference this one, per reference kind | caps: nothing predicated on this can be warranted above it |

A dimension with no producer is a wish, and the ontology checker refuses it. "Nearly every question has a second argument, and the second argument is what moves" (census): the *against* slot is that argument, and an act answering the dimension must read what fills it, so freshness, eras and fidelity targets are all one mechanism: something read has moved.

For each piece and each dimension its kind opens there are two things, kept apart:

- Its **assertion**: what the content says about itself on that question, written by the author. ASF's "exact", "conditional on (S1)–(S5)", "axiomatic", "ratified", "faithful to §4" are assertions. A dimension says whether pieces may assert on it and in what form. There is only ever one; the former ones are in the log.
- Its **warrant**: what the acts that still bind warrant, read as the dimension declares. A piece's *own* warrant is read from the acts that concern it; its *effective* warrant is the own warrant lowered by whatever caps along its references (nothing is warranted above what it rests on). The constraint below compares the assertion with the effective warrant; own above effective is information a working agent wants to see (a well-checked claim on an unchecked premise), not a violation. A warrant can be *never asked*, which is a value and not a gap, and a dimension not opened for a piece's kind is a fact and not a gap.

The **constraint** is: assertion ≤ warrant, on the dimension's own ordering. Where it fails the piece is **overclaimed** and that is owed. This is the whole honesty rule. It dissolves "claimed level" as a term (an assertion on one dimension), "one current epistemic label" (one assertion per dimension), and "softening" (replacing an assertion by a weaker one, or narrowing the content so a weaker assertion is true of it). ASF's one-word `status:` was several assertions on several dimensions of several veritoids, typed once on the file; the model has nowhere to put that word except as a rendering of per-veritoid assertions, which is where it should have been.

**Determinants.** The ontology marks some dimensions ‹determinant›: those that say what being *right* consists of for this work, and over which "better" is read (§9). Validity against logic, agreement with the world, fidelity to a source, consistency with a canon are determinants; importance for a target, freshness, who decided, and who moves next are dimensions that organize the work and are not. This is what "truth determinant" turns out to be: a role of some dimensions, declared, with no machinery of its own. Your "aspect × standard" carve was asking of a determinant what *asks* and *against* already say of every dimension. [Your lean of 11-08, "synonym for or subset of dimensions"; subset, since importance is adjudicated and is not an aspect of truth.]

**Intrinsic constraints.** Every verisectorium has these whether or not its ontology says so; they are what the tools and the model supply, and they are your "underlying current":

1. No piece asserts more than its acts warrant (above).
2. Every reference holds: its target exists, is at the version the reference last saw, and is warranted at least at what the reference needs.
3. Nothing is warranted above what it is predicated on (passes-along: caps), and the predicated-on graph has no cycles.
4. In every segment, every inner dependent of a changed veritoid was changed or affirmed in the same write (this one is a refusal, §7, not a frontier item).
5. What a check or finding says is broken has been dealt with, or its remaining-broken is accepted with a reason.
6. Every dimension has a producer.

The ontology adds its own constraints, stated over dimensions, the same way.

## 5. References

A «reference» is a written pointer from a veritoid to other veritoids or segments, of a declared kind, carrying the target version it was last reconciled against and, optionally, the warrant it needs its target to have. Someone wrote it and it can be wrong. The store computes only whether it *holds*. Each reference kind exists because a dimension treats it differently: **predicated-on** carries support and caps; **narrates** carries staleness only; **restates** demands agreement; **seeded-by** says two acts are not independent; **supersedes** says which is current; **bears-on** is what a chunk points at (§8). Yours: the dependency is really "an array dimension from a claim atom to those other instances' claim atoms"; ASF's frontmatter `depends:` was a roll-up of it to segment grain, a fair convenience that hid the real graph.

A reference says how many targets it expects, which is what gives a miss its meaning. A reference to a piece that does not yet exist is allowed and owed, so an outline can point at promised work.

## 6. Acts

An «act» is one recorded thing an attested **actor** did against a state. It **reads** a set of things, each at its version: a veritoid's whole written state, or only its assertion on a dimension, or only its warrant on a dimension when that is all it relied on (a chapter review that read each member's headline and assertion, not its proof steps). It **concerns** a subset of what it read, and **answers** one dimension. It **binds** while everything it read is unchanged; the moment any read changes it lapses, and the store can say why. A read of a warrant lapses only when that warrant falls, so a confirming check never undoes a review. A lapsed act warrants nothing. Reading a premise without concerning it is how a re-derivation reads its context honestly without certifying it.

Acts come in two sorts, and the model has to say so because they are corrected differently:

- **Finding out**: a ‹check› (criterion fixed before the outcome; outcome confirmed, narrowed or broken), a ‹finding› (something is broken, with no criterion fixed in advance, so it carries no weight as a confirmation), a review. A run is a check whose actor is an instrument at a version. A later act can overturn an earlier one.
- **Making so**: an ‹attestation›: "I decided this", "I read this" (a reader event is one of these), "I affirm this unchanged piece is still right", "I accept this remaining item, for this reason", "I ruled". Nothing can convict these by running anything; only the party who made one can correct it, or someone showing it never happened. A checkpoint's conditions are made of these. This is where an error is gravest, and an agent's act recorded in your name is the failure this sort exists to prevent.

Two more subtypes exist for completeness: a ‹rule·firing› (a declared rule over attributes raised a question or moved a value, at a definite moment) and an ‹outside·change› (something the store does not hold moved: a simulator version, a cited work, a date a rule cares about).

A dimension's *produced by* says whose acts count: the gate the estate calls standing, yes or no before any question of quality. The author's own check has standing as a check and no weight as an independent one. Whether two checks by two instances of one model family are independent is a gap this model does not close.

A broken check or a finding goes on the record when it happens, before anyone has written a repair, and puts an item on the frontier. The known-defect mark you were weighing needs no machinery: a broken item still on the frontier at a would-be checkpoint is either repaired or *accepted* with a reason, and the acceptance is visible in the checkpoint's conditions.

## 7. Change

There are two kinds of time. In **steady time** the store moves from one «checkpoint» to the next, each move at one logical instant; nothing exists between two checkpoints. In **work time** minds assemble that move over hours and days; while they do there is a **working state**, the last checkpoint plus what has been staged, and it is never "the theory".

A «changeset» has two sizes, both yours. A ‹segment·changeset› is a whole new written state of one segment at one instant: every inner dependent of a changed veritoid is changed too or carried with the author's affirmation, or the write is **refused as a draft**. It may recut, may move veritoids in or out, may mint segments. An ‹atomic·changeset› is everything, writes and acts, that takes the store from one checkpoint to the next; usually more than one mind can assemble in one pass, so it is staged, and at every stage the frontier says what is owed. An act alone, such as a confirming check on a checkpoint, is an atomic changeset of size one.

The «frontier» is everything owed in a working state, computed fresh after every write or act, never kept. Its items are the violated constraints of §4: *overclaim* (piece, dimension: assertion above effective warrant), *stale* (reference), *dangling* (reference to a retired or missing id), *unmet* (reference's need above the target's warrant), *broken* (piece, act), *raised* (a rule or outside change put a question to a piece), and whatever the ontology's own constraints add. Beside them the frontier shows, as information and not as owed, where a piece's own warrant exceeds its effective one. Each item names its cause and, through the dimension's producer, who can clear it. The frontier is addressed to someone; that is most of what the stores have meant by "standing" (census).

A «checkpoint» is a state whose frontier is empty, or every item on it is covered by an acceptance with a reason. The acceptances, and the list of determinant dimensions never asked of any piece, are the checkpoint's **stated conditions**: that is what "good or true, with stated conditions" means made exact.

**Content moves at once; warrant moves one act at a time.** The author reconciles what is written inside the changeset. The moment it is staged, every act that read what changed lapses and the warrants fall; earning them back takes further acts, usually by other minds, in work time. Whether a small rewording should cost a derivation all of its warrant is open; positions fall completely here, and a store that wants a graded fall declares a *read as* that gives one.

## 8. Intake

Taking material in is the first thing your definition says a verisectorium does, and it needs no machinery beyond the above. A **source** is a ‹source› segment; its veritoids are **chunks**, of a chunk kind, and the cut must cover the whole source so that "every chunk dealt with" cannot mean "found something". A chunk carries a *bears-on* reference to the segment or veritoid it concerns. A ‹crossing› is an act that concerns a chunk and answers the dimension *where did it go*: changed an existing piece, became a new piece, already present, one more independent arrival (evidence, not a duplicate), superseded or rejected with a reason, delivered to another store, passed to a segment's inbox (not final). A segment's **inbox** is computed: the chunks bearing on it with no final crossing. The chunk lives in its source, so adding to or draining an inbox never changes the segment; that is the measured lesson of the sprint. "Read by whom, how far" are dimensions of the source, read from attestations of reading. A source is retired when every chunk has a final crossing, computed.

What sat in ASF's Working Notes was three things: inbox chunks; standing content that belongs in slots of its own kind (regression guards, open questions with closers, dead ends with reasons); and in-place fate markers written as prose ("Resolved 2026-10-30 in …"), which are crossings that never became acts.

## 9. Better

A checkpoint is *feasible*: every constraint holds or is accepted. **Better** is a direction within feasibility: a later checkpoint is better than an earlier one when, on the determinant dimensions, no warrant has fallen and some has risen, or the content answers to a determinant more strongly in a sense the ontology declares (AAT: a claim that entails another is stronger; weaker hypotheses, stronger conclusion). Two checkpoints can each be better on a different determinant with neither better overall; choosing is a decision, and so is where effort goes next. No composite score lives on a piece. The one place the estate combines scores openly is when choosing between candidates in a decision, and that is where it should stay.

This is why softening is honest and still not enough: lowering an assertion is the cheapest way back to feasibility, and a store softened to tautologies would be perfectly steady and worth nothing. Strengthen-first is what the direction adds and the engine does not enforce.

Your two regimes need nothing of their own. A theory claim asserts flatly and its determinant dimensions read true or false; its doubt is a list of named open checks beside it, not a number. An empirical fact or a proposed model is read by degree. They join at the hypothesis: a flat if-then resting on a model whose adequacy carries the graded part. A store that wants numeric credence declares a dimension whose *read as* computes one from the acts, as relata does.

## 10. A real root through it

`examples/scope-adaptive-system.md` runs ASF's broadest scope segment through the model, using the 162 acts vsect 0.1 actually recorded on it between 2026-10-30 and 10-31. `examples/stopped-bound.md` runs the Prop A.1S(i) error that passed fourteen audits in six months. Two results, stated here because they bear on the model and not only on ASF:

- **The stopped bound is caught by grain, not by a dimension list.** Note 19 needed the ontology to declare "does the derivation deliver the statement?" as a separate dimension from "is each step right?". Here it falls out of two things the model already has: derivation steps are veritoids separate from the claim they prove (ASF's Formal Expression already writes them apart), and an act concerns only what it concerns. Fourteen checks that each concerned a step leave the claim's validity *never asked*, while its assertion says *exact*: owed from the first day, as an overclaim with a named clearer. The "RESOLVED — do not re-open" sentence closes nothing, because closure is an act.
- **Binding per veritoid keeps more of the record alive, by an amount not yet counted.** vsect 0.1 binds a check to the whole segment's text, so the segment's nine versions on 10-30 left 50 of its 63 checks lapsed. Under this model an act lapses only when a veritoid it read is rewritten; the last reword touched only item (c) and the imports, so acts on other items recorded just before it survive. But several items were rewritten earlier the same day, so the earlier reviews' acts lapse under this model too. The cold read corrected my first count; the true number needs a per-item diff per version pair. It is also where the recording cost will bite: an act must say which veritoids it read.

## 11. What would show this wrong, and what I expect to strain

The model is wrong if a real store needs a thing that is neither written, done nor computed; if a warrant cannot be read from acts without someone typing it after all; or if the ten terms have to multiply back toward eighty to do real work.

Before any more material, my guess at what one AAT root will strain, in order:

1. **The cost of recording.** Per-veritoid assertions and per-act read sets on 1,234 records. If an act costs more than a sentence of prose, agents will write prose, and the stores' dead `stage` fields say this decides everything.
2. **What a derivation step reads.** Honest reads include the premises; then every premise change lapses every dependent's checks, which is right and expensive. A store may want *reads* to distinguish "relied on at a warrant" from "read the text".
3. **Attestations of the steward.** "Only Joseph may rule" has no mechanism while his session and an agent in it look alike to the harness.
4. **Whether *against* carries the census's second argument everywhere**, or whether importance-for-a-target and comprehension-by-a-reader need the target as content of the act rather than of the dimension.
5. **Acceptance as a cheap exit.** Any marker of done becomes a target; acceptances are attestations with reasons, visible at every checkpoint, and that is all the model offers against gaming.

Four decisions the first cold read (`msc/scratch/core-2-denovo-1.md`) showed the model has not yet made, each a sentence in a def and not a new term; they are recorded in the defs' Working Notes for Joseph:

- **Which assertions compare with warrants.** "Conditional on (S1)–(S5)" says what is claimed; "ratified" says how well it stands; ASF's "exact" straddles both. A dimension may need to say how its assertion vocabulary embeds in its *read as* ordering, and which assertions are content scope, exempt from the constraint. The stopped-bound example turns on this (`dimension.md`).
- **Whether reconciling a reference is a write.** With seen-versions inside the version hash, clearing one stale reference lapses everything downstream that read nothing changed. The alternative hashes targets, carries seen-versions beside, and makes reconciliation an affirmation (`reference.md`).
- **How an author names a veritoid at write time.** The model is finer than anything authors write or tools record today (a gap row).
- **Where an ontology change is recorded**, since it is neither written content nor an act on content (a gap row).

## 12. What `core/` had that is not here, and why

Carried as plain words or subtypes, not terms: ontology, log, state, version, identity, name, actor, criterion, content, slot, inner dependency, inbox, chunk, crossing, rendering, projection, row, source, affirmation, acceptance. They are defined once in the outline's inline rows and used without guillemets. Also dissolved without a word of their own: *standing* (a dimension's *produced by* says whose acts count), *bind* (what every act does), *coherence* (a segment's own dimension), *orphan* and *order·exception* (facts about a projection, computed or recorded), *delivery* (a crossing outcome), *planned·segment* and *gap·segment* (a promised row whose segment has declared-owed slots).

Dissolved into the model: *truth·determinant* (a role of dimensions); *claimed·level* (an assertion on a dimension); *value*, *position*, *judgment*, *credence*, *ceiling*, *latent·level*, *roll·up* (warrants and their declared reading); *scale*, *ladder*, *rung* (the shape of a reading); *property* (the written/done/computed table); *ground* and *bound* (a kind's declaration of which dimensions it opens, and non-claims as content); *perturbation*, *working·state*, *steady·state*, *steady·time*, *work·time*, *accepted·remainder* (§7); *premise·change* (what passes along a reference, per dimension); *recut* and its five verbs (§3); *move*, *queue*, *mechanism* (a dimension's producer, and the frontier addressed to someone).

One store's choices, not the core: *claim*, *context*, *hypotheses*, *conclusion*, *derivation*, *strength*, *sharpness*, *forced*, and the low-fidelity kinds. They belong in AAT's ontology, where the examples sketch them.

Not carried, on your word: everything the kernel spikes fed into `core/`'s stubs, except what §3 and §6 re-derive from the notes themselves (minted identity; reads versus concerns). Where a spike and the notes agreed, the notes are the source.

Still open, and listed as gaps in the outline: several atomic changesets in flight and whether the union of two steady stores is steady; independence of same-model checkers; steward attestation; the recording cost; and whether some constraints are better answered by a refusal than by a record.
