# Verisectorium Model (core-2)

The canonical projection of `core-2/`: everything the model consists of, in dependence order, with what is settled and what is not marked on every row. Intro, discussion and implication segments (`src/`) are interspersed where they belong in the reading; each names in its frontmatter the defs it narrates, so a change to a def says which prose must be re-read. Read the rows in order.

> [!LEGEND]
> - `mark`: **accepted** (decided by steward and lead, unanimous), **promised** (the verisectorium says this will exist), **provisional** (a suggestion; true as stated at every commit, since it claims only that the suggestion exists), **gap** (something is known missing; what replaces it is not known).
> - `def`: `present` (a full def file), `stub`, `inline` (the description is the whole definition; no file), `–` (none yet).
> - `term`: a link to `def/<term>.md`; for an inline row the plain word; for a `src/` segment a link to `src/<slug>.md`, with its form (`intro`, `disc`, `impl`) in the `def` column. Terms are nouns in the singular; a multi-word term joins its words with `·`. In prose a term is written `«term»`; a subtype `‹subtype›`; inline words are written plainly.
> - `subtypes`: declared in the term's def; they have no file of their own.
>
> `bin/defs check core-2` verifies that every «term» and ‹subtype› resolves, that files and rows agree, and that relations point at terms.

## Part I

> [!NOTE]
> The spine, in a considered order. Ten terms with files, the plain words they lean on as inline rows beside them, and the gaps beside the term they concern. Nothing else is in the model until it earns a row.

| mark | def | term | subtypes | description |
|---|---|---|---|---|
| provisional | intro | [[src/intro-spine\|The whole thing, first]] |  | What a verisectorium is for, from influx to results others build on; then the five sentences of machinery that keep that production trustworthy, and the identity rule under them. Read before anything else. |
| provisional | present | [[def/verisectorium\|Verisectorium]] |  | A place for cutting truth: material brought in is dissected until each piece can contribute on its own, adjudicated and refined toward agreement with the truth it is held to, and reassembled into coherent results that others build on and read; worked under turnover; true as stated, with its conditions, at each steady state. Concretely an ontology, a corpus, acta and a history. States the distinction between its machinery (this outline) and the practical model a mind at work meets. |
| provisional | inline | corpus |  | Everything written in a verisectorium: its veritoids' content, assertions and references, its segments' assembly, its projections' members. Written only by changesets. Not "the store", which blurred written with done. |
| provisional | inline | canon |  | The stable part of the corpus: what the canonical projection reaches, at a steady state. Orphans, sources and planned rows are corpus and not canon. |
| provisional | inline | ontology |  | What a verisectorium declares: its kinds, its dimensions (and which of them are determinants), its reference kinds, and its own constraints. Holds no content. Versioned; every piece follows one version of its kind. Written by hand for now. |
| provisional | inline | acta |  | The record of everything done to a verisectorium, in order, only ever added to: every act and every changeset lands here as an actum. Everything computed is read from it. Not "the log", which names too many things. |
| provisional | inline | actum |  | One entry in the acta: an act, or a changeset, as recorded. Never edited; corrected by a later actum. |
| provisional | inline | state |  | The verisectorium as of a point in the acta: what every piece says, how every segment is assembled, which ontology version is in force, and what has been done. |
| provisional | inline | content |  | The text or data a veritoid holds. |
| provisional | inline | identity |  | The id minted for every veritoid and segment at creation and never reuses; what a reference points at and what a version is a version of. A split or merge retires ids and mints new ones with recorded descent; a move keeps them. |
| provisional | inline | version |  | The hash of a veritoid's written state (content, assertions, references with the versions they saw), or of a segment's assembly and its veritoids' versions. What an act binds to. One version names one content for the life of the verisectorium. |
| provisional | disc | [[src/disc-written-done-computed\|Written, done, computed]] |  | The table the whole discipline is the line in: what an author sets, what an actor records, what is computed. |
| provisional | disc | [[src/disc-record-surfaces\|Four places a record can go]] |  | The acta (done, append-only), the history of renderings (outside the verisectorium), working notes (the inbox, drained), and history (written prose kept with a segment about how it came to be, faithful to the acta, the one place to point outward); the body states present truth and stands alone. |
| provisional | present | [[def/veritoid\|Veritoid]] |  | One piece of content of a declared kind, with its assertions about itself and the warrants the acts give it. Never meaningful alone; never changed alone; contains no veritoid; has an id and no name. |
| provisional | inline | assertion |  | What a veritoid's content says about itself on one dimension ("exact", "conditional on (S1)–(S5)", "ratified"). Written. One per dimension at a time; the rest are in the acta. The honesty constraint compares it with the warrant. |
| provisional | inline | warrant |  | What the acts that still bind warrant for a piece on one dimension, read as that dimension declares. Computed, never typed. "Never asked" is a warrant. |
| provisional | present | [[def/segment\|Segment]] | ‹projection› ‹source› | Veritoids written and judged together under a name: the unit of writing, of identity by name, and of whole review. A ‹projection› holds references to other segments in a chosen order; a ‹source› holds chunks cut from material brought in. |
| provisional | inline | name |  | A label kept bound to a segment's id, with history. A rename is recorded and old names keep resolving. Two segments under one name is a failure that is surfaced, never assumed away. |
| provisional | inline | slot |  | A declared place in a segment kind, holding one, at most one, or any number of veritoids of one kind, in order. |
| provisional | inline | inner dependency |  | A declared dependence of one slot on another within a segment kind. Why a changeset must change or affirm every dependent of what it changed. Not a reference; it has no version seen. |
| provisional | inline | row |  | One member of a projection, with two states kept apart because they move independently: commitment (provisional, a suggestion; or promised, the verisectorium stands behind it, by a decision) and existence (absent, or present). This outline's own `mark` and `def` columns are the two. |
| provisional | present | [[def/kind\|Kind]] | ‹veritoid·kind› ‹segment·kind› | What a veritoid or segment holds and which dimensions apply to it. A ‹veritoid·kind› declares content shape, opened dimensions, allowed assertions and reference kinds; a ‹segment·kind› declares slots, inner dependencies, and how the segment's own dimensions read from its veritoids. |
| provisional | disc | [[src/disc-pieces-and-identity\|The pieces, and why identity is minted]] |  | Veritoid, segment and kind read together; names and versions; recutting; why two levels. |
| provisional | present | [[def/dimension\|Dimension]] | ‹determinant› | One question asked of a piece, declared with what it asks, of which kinds, against what, what act produces its answer and whose acts count, how the warrant is read from binding acts, and what passes along references. A dimension is a constraint: assertion ≤ warrant. A ‹determinant› is one the ontology names as part of what being right consists of; better is read over them. |
| provisional | disc | [[src/disc-dimensions-as-constraints\|Dimensions are constraints]] |  | The five-slot declaration, assertion against warrant, determinants as a role, and the six constraints every verisectorium has without declaring them. |
| gap | – | the recording cost |  | Whether declaring a dimension's five things, and recording per-veritoid assertions and per-act read sets, costs less than writing prose. The estate's dead fields say this decides whether anything is recorded at all. |
| gap | – | write-time addressing |  | How an author or an agent names a veritoid when writing a reference or an act's read set, when the surfaces they write on carry segment names and tags, and today's tools record reads at segment grain. A design decision, not only a cost. |
| gap | – | ontology change record |  | Where a change to the ontology is recorded, since it is neither written content nor an act on content, and every piece's kind version depends on it. |
| gap | – | refusals |  | Whether some constraints are better answered by the engine refusing a state than by a recorded act (a read-only handle, a compile-included ledger), and whether an ontology should be able to declare that per dimension. |
| provisional | present | [[def/reference\|Reference]] |  | A written pointer from a veritoid to veritoids or segments, of a declared kind, carrying the target version last reconciled against and optionally the warrant it needs. Only whether it holds is computed. Kinds so far: predicated-on, narrates, restates, seeded-by, supersedes, bears-on. |
| provisional | present | [[def/actor\|Actor]] | ‹mind› ‹instrument› | The attested identity that performs acts and writes changesets, minted anew at every discontinuity (compaction included: a new actor with a source), with a record of its own (model and prompt attested; orientations as warrants earned by checks; consortia as references; experience computed) that a dimension's producer reads as the gate of standing. |
| provisional | present | [[def/act\|Act]] | ‹check› ‹finding› ‹attestation› ‹crossing› ‹rule·firing› ‹outside·change› | One recorded thing an attested actor did against a state: it reads things at versions, concerns a subset, answers one dimension, and binds while what it read is unchanged. Finding-out acts can be overturned by later acts; making-so acts only by their party. |
| provisional | inline | criterion |  | What a check was performed against, fixed before its outcome was seen. A check whose criterion came after adds no weight. |
| gap | – | independence of acts |  | What makes two acts independent when nearly every actor is an instance of one model family. The stopped-bound case says this is not a detail. |
| gap | – | steward attestation |  | How "it was Joseph" is attested, when his main session and an agent acting in it look the same to the harness; and the mirror case, a subagent inheriting the lead's orientation pass. "Only the steward may rule" has no mechanism until this is closed. |
| provisional | present | [[def/changeset\|Changeset]] | ‹segment·changeset› ‹atomic·changeset› | A change at one logical instant. A ‹segment·changeset› is a whole new written state of one segment, every inner dependent changed or affirmed, else refused as a draft. An ‹atomic·changeset› is everything, writes and acts, that takes the verisectorium from one steady state to the next. |
| provisional | inline | affirmation |  | An attestation carried inside a segment changeset: the author says a veritoid left unchanged is still right against what did change. Never counts as an independent check. |
| provisional | present | [[def/frontier\|Frontier]] |  | Everything owed in a working state: every violated constraint, computed fresh after each write or act, each item naming its cause and who can clear it. Never kept as a list. |
| provisional | present | [[def/steady-state\|Steady·State]] |  | A state whose frontier is empty, or every item on it is covered by an acceptance with a reason. The acceptances, and the determinant dimensions never asked, are its stated conditions. Steady time is the sequence of steady states; between them is work time and a working state that is never the theory. |
| provisional | inline | acceptance |  | An attestation that an item still owed is knowingly left owed, with its reason, by an actor with standing. What makes a steady state's conditions. |
| provisional | disc | [[src/disc-actor\|The minds that turn over]] |  | A compaction is a new actor with a source; orientation gets its purpose from frontier versus steady state (roots for the cold, the tip for the resuming); the actor's record and standing as a gate over it; reading checked not attested; the pass as an act; the gate's shape; the gaming surface; heat placed as a rendering. |
| provisional | disc | [[src/disc-better\|What "better" is]] |  | Feasibility and direction; the partial order over determinants; why softening is honest and not enough; the two regimes. |
| gap | – | parallel changesets |  | Several atomic changesets in flight at once, and whether the union of two independently steady verisectoria is steady. Punted by Joseph. |
| provisional | inline | chunk |  | A veritoid of a ‹source› segment: one piece cut from material brought in, carrying a bears-on reference to what it concerns. The cut must cover the whole source. |
| provisional | inline | inbox |  | A segment's intake, computed: the chunks bearing on it with no final crossing. Adding to or draining it never changes the segment. |
| provisional | inline | rendering |  | Text produced from the corpus and acta for a reader, as of a state: a file, a page, a dashboard, the view put before an agent about to write. Never the thing itself; a status word in it is a snapshot with a state on it. |
| provisional | inline | praxis |  | What is expected of a mind working in a verisectorium that no tool there enforces: how to orient, which surface to write in, when to seek a cold read. The dual of the engine's affordances; written as segments of its own, projected by a praxes outline. Not "SOP". |
| provisional | impl | [[src/impl-intake\|Intake needs no machinery of its own]] |  | Source, chunk, crossing and inbox as segments, veritoids and acts; what ASF's Working Notes were. |
| provisional | impl | [[src/impl-scope-adaptive-system\|A real root: scope-adaptive-system]] |  | ASF's broadest scope segment cut under a sketch ontology and read through the 162 acts vsect 0.1 recorded on it. |
| provisional | impl | [[src/impl-stopped-bound\|The stopped bound]] |  | Prop A.1S(i), false for six months under fourteen passes, read through the model: caught by grain and by concerns-within-reads. |
| provisional | disc | [[src/disc-what-would-show-this-wrong\|What would show this wrong]] |  | The falsifiers, the five things one AAT root is expected to strain, and the four decisions the first cold read showed the model had not made. |

## Part II. Deliberately not carried from `core/`

Not rows; a record of what was left out so a reader does not think it was forgotten, with the reasons.

Carried as plain words or subtypes, not terms: ontology, corpus, canon, acta, actum, praxis, state, version, identity, name, actor, criterion, content, slot, inner dependency, inbox, chunk, crossing, rendering, projection, row, source, affirmation, acceptance. They are defined once in the outline's inline rows and used without guillemets. Also dissolved without a word of their own: *standing* (a dimension's *produced by* says whose acts count), *bind* (what every act does), *coherence* (a segment's own dimension), *orphan* and *order·exception* (facts about a projection, computed or recorded), *delivery* (a crossing outcome), *planned·segment* and *gap·segment* (a promised row whose segment has declared-owed slots).

Dissolved into the model: *truth·determinant* (a role of dimensions); *claimed·level* (an assertion on a dimension); *value*, *position*, *judgment*, *credence*, *ceiling*, *latent·level*, *roll·up* (warrants and their declared reading); *scale*, *ladder*, *rung* (the shape of a reading); *property* (the written/done/computed table); *ground* and *bound* (a kind's declaration of which dimensions it opens, and non-claims as content); *perturbation*, *working·state*, *steady·state*, *steady·time*, *work·time*, *accepted·remainder* (§7); *premise·change* (what passes along a reference, per dimension); *recut* and its five verbs (§3); *move*, *queue*, *mechanism* (a dimension's producer, and the frontier addressed to someone).

One verisectorium's choices, not the core: *claim*, *context*, *hypotheses*, *conclusion*, *derivation*, *strength*, *sharpness*, *forced*, and the low-fidelity kinds. They belong in AAT's ontology, where the examples sketch them.

Not carried, on your word: everything the kernel spikes fed into `core/`'s stubs, except what §3 and §6 re-derive from the notes themselves (minted identity; reads versus concerns). Where a spike and the notes agreed, the notes are the source.

Still open, and listed as gaps in the outline: several atomic changesets in flight and whether the union of two steady verisectoria is steady; independence of same-model checkers; steward attestation; the recording cost; and whether some constraints are better answered by a refusal than by a record.

## Part III. Questions a cold reader should ask of this

- Run one more real root, from a different volume, before adding any term.
- Which of the inline rows wants to be a term? The rule: it becomes one when its Working Notes would hold a decision nobody else's file can hold.
