# Verisectorium Model

This is the canonical projection of `core/`, initially describing the model via grouped and ordered lexical definitions, although mechanisms, descriptions, discussions, and introduction segments are likely to follow and intermingle. Each term has its own def; cross-cutting ideas (time and change, growth, honesty) run through several groups and are not sections of their own.

> [!LEGEND]
> - `mark`: Every row carries one of:
>   - **accepted**: The group is in `core/def/` and has been decided (steward and lead, unanimous).
>   - **promised**: The store says this group will exist; its def may be a stub.
>   - **provisional**: A suggestion that such a group, or such a gap, is probably wanted. Not a commitment. It may stay at any level of detail without making this outline false. A row moves from provisional to promised by a decision. The outline is true as stated at every commit: a provisional row claims only that the suggestion exists.
>   - **gap**: Something is known to be missing here; what will replace it, and in how many groups, is not known.
> - `def`: Whether and how the segment exists, independent of how settled it is: `–` (none yet), `inline` (the description is the whole definition), `stub` (a file exists, possibly only working notes), `present` (a full def). A present def can still be provisional.
> - `term`: The term, as a link to its def. One term per def and per row; what used to be a group is now a set of terms that cross-reference each other. For an `inline` row the link is omitted.
> - `subtypes`: The term's declared subtypes, as `‹subtype›`. Multi-word terms are joined with `⸱` (U+2E31). Terms are nouns. Verbs, adjectives and states are defined within the noun they belong to or minted as compounds of it (`promised⸱row`, not `promised`); a weak or ambiguous noun is namespaced by the term it belongs to. Filenames use `-` where a term has `⸱`.
> - `description`: Describes the group overall or, for `inline` rows, the full definition. (Verbose for provisional segments that don't yet have an associated file etc.;  exactly the primary one-line definition for accepted terms).
> - `see`: (Provisional Only). Names the msc note(s) (`msc/notes/NN`) likely to inform early drafting and the segment's working notes. *Deleted for non-provisional segments.*
>
> **Defined terms in prose**, here and everywhere in `core/`, are written `«term»`, or `«wording|def/group#term»` where the wording is a plural, a different casing, or would be ambiguous. Inside a def's group paragraph a term's first mention is `«TERM»` in capitals. A bare `«term»` is valid only while exactly one def defines it. A **subtype** (a state or kind of a noun, declared in the noun's def) is written `‹subtype›` next to its noun, or alone when it is unique across the lexicon; `«subtype⸱noun»` is its full name and is always valid. A subtype has no file of its own; if it ever needs one it is a term. The checker verifies: the target exists; a bare term is unique; plural and casing match the def's `pl`; a subtype is declared by its noun; a bare `‹subtype›` is unique or adjacent to its noun.

**TODO**:
- [ ] Retire `see` column after prior discussions and items are fully integrated.

## Part I
| mark | def | term | subtypes | description | see |
|---|---|---|---|---|---|
| accepted | present | [[def/verisectorium\|Verisectorium]] |  | A "place for cutting truth." It is a truth-centric, continually improving system for building a body of work under turnover, the project that defines such systems and their tools, or, when used in this ontology, a concrete instance with its constituent parts. |  |
| provisional | present | [[def/truth-determinant\|Truth⸱Determinant]] |  | One aspect of truth a verisectorium declares that its content answers to, and against what. |  |
| provisional | stub | [[def/ontology\|Ontology]] |  | The declared kinds, dimensions, reference kinds and moves of one «data⸱store»; versioned; every piece follows one version of its kind; holds no content; written by hand for now. (Named *definition* in the 11-05 drafts; renamed because that word now collides with the def files and with term definitions) | 01 §1, 02 Part B, 09 §4.6, 11 |
| provisional | stub | [[def/data-store\|Data Store]] |  | A «verisectorium»'s contents as held, under an engine or by hand; the «log» is append-only; a «state» is the data store as of a point in it: what every piece says, how pieces are assembled, which «ontology» is in force, what has been recorded as done | 01 §2, 09 §3.1, 11 |
| provisional | stub | [[def/log\|LOG]] |  | Everything recorded about a store, in order, only ever added to. |  |
| provisional | stub | [[def/state\|STATE]] |  | The store as of one point in its log. |  |
| provisional | stub | [[def/veritoid\|VERITOID]] |  | One piece of «content» of a declared «veritoid⸱kind», with the answers to the questions that kind allows; never meaningful alone; never changed alone; contains no veritoid; has no name of its own | 05, 08/06–08, 09 §2.1, 11 |
| provisional | stub | [[def/content\|CONTENT]] |  | The text or data a veritoid holds, at a version. |  |
| provisional | stub | [[def/veritoid-kind\|VERITOID KIND]] |  | A declared type of veritoid, saying what form its content takes, what it answers to, and which questions may be asked of it. |  |
| provisional | stub | [[def/property\|PROPERTY]] | ‹written› ‹computed› | Anything the data store holds about a piece; the line the model stands on: a ‹written› property (content, ground, bounds, claimed level, references, assembly, order) is set by an author; a ‹computed› one (every value, attribute, whether a reference holds, every roll-up) is produced by the store and never typed | 09 §2.7, 11 |
| provisional | – | [[def/dimension\|DIMENSION]] |  | One independently answerable question about a piece, with the «scale» of values it can take (a «ladder» of ordered «rungs\|def/dimension#rung», an unordered set, or a number); sustained by evidence, by decision, or by attestation, or a mix; no dimension's answer ever stands in for another's | 08/09, 09 §2.2, 11 |
| provisional | – | [[def/scale\|SCALE]] |  | The values a dimension can take: a ladder, an unordered set, or a number |  |
| provisional | – | [[def/ladder\|LADDER]] |  | A scale whose values are ordered |  |
| provisional | – | [[def/rung\|RUNG]] |  | One step of a ladder |  |
| provisional | – | [[def/value\|VALUE]] | ‹aliased› ‹derived› ‹owned› | What is warranted on one dimension as of a state, computed from the acts that still bind and never typed: a «position» (what has been done) or a «judgment» (a reading only judgment can give, held with its spread). Three things kept apart for every question: what is claimed («claimed⸱level»), what has been done (the acts), what is warranted (the value); honesty is that the first never exceeds the third. Belief rightly rises with each act by an amount that depends on how independent the act is | transcript 11-06 12:15–12:30; 12 and addendum; replaces 11 def-value |
| provisional | – | [[def/position\|POSITION]] |  | A value that says what has actually been done to a piece; a fact about the record |  |
| provisional | – | [[def/judgment\|JUDGMENT]] |  | A value only judgment can give, held with its spread over the scale |  |
| provisional | – | [[def/credence\|CREDENCE]] |  | A number for "is it true", a special case a store declares where the evidence reduces to priors and likelihoods (as relata does); not the core | 12 addendum |

## Part II
| mark | def | term | subtypes | description | see |
|---|---|---|---|---|---|
| provisional | stub | [[def/ground\|GROUND]] |  | What an author states could ever support a piece; it opens the questions that can be asked of it; an unopened question is a fact, not a gap | 08/09, 09 §2.2, 11 |
| provisional | stub | [[def/bound\|BOUND]] |  | A declared limit on a piece, consulted and never earned: what it may assert on its own authority, what a reader may do with it, whether it is safe to show an unprimed auditor | 08/09, 09 §3.4, 11 |
| provisional | stub | [[def/claimed-level\|CLAIMED LEVEL]] |  | What a piece's content asserts about its own support; written, compared with what is computed; one only, the rest in the log; to soften it is to lower it or narrow what is said | 01 §7, 09 §2.2, 11, 12 |
| provisional | stub | [[def/theory-claim\|THEORY CLAIM]] |  | A piece of content that aims to be true or false: stated flatly, settled by derivation, broken by counterexample, its doubt a named list beside it; the first of two regimes, joining «empirical⸱fact» and «proposed⸱model» at the hypothesis | 12 addendum |
| provisional | stub | [[def/empirical-fact\|EMPIRICAL FACT]] |  | A piece of content about the world, supported by runs or measurements, adequate by degree and never simply true. |  |
| provisional | stub | [[def/proposed-model\|PROPOSED MODEL]] |  | A piece of content offered as a representation of something, adequate for a purpose by degree, falsifiable, and built on by decision. |  |
| provisional | – | [[def/claim\|CLAIM]] |  | The veritoid kind at the centre of a theory store: in a «context», under «hypotheses», a «conclusion» holds by a «derivation» from named premises. *May be AAT-specific.* | 12 |
| provisional | – | [[def/context\|CONTEXT]] |  | The standing definitions, assumptions and choices a claim is stated within |  |
| provisional | – | [[def/hypotheses\|HYPOTHESES]] |  | The conditions beyond the context under which a claim's conclusion holds |  |
| provisional | – | [[def/conclusion\|CONCLUSION]] |  | What a claim asserts, given its context and hypotheses |  |
| provisional | – | [[def/derivation\|DERIVATION]] |  | The steps from named premises by which a conclusion is reached; each step a use |  |
| provisional | – | [[def/strength\|STRENGTH]] |  | How much a claim says: «strength» is entailment, not a level; "conditional" and "exact" describe what is said («sharpness»), not how sure; «forced» vs chosen is whether a uniqueness result stands behind a choice | 12 |
| provisional | – | [[def/sharpness\|SHARPNESS]] |  | The form of a claim's conclusion: an identity, a sharp threshold, a bound, a leading-order scaling, a direction only |  |
| provisional | – | [[def/forced\|FORCED]] |  | Whether a uniqueness result stands behind a choice, so that it is the only form the earlier material allows |  |
| provisional | – | [[def/sketch\|SKETCH]] |  | First-class kinds with honest low ceilings and their own stances, not forced into the «claim» shape | 14 (Joseph), 15 |
| provisional | – | [[def/hypothesis\|HYPOTHESIS]] |  | A low-fidelity kind: a claim offered for test, not yet derived |  |
| provisional | – | [[def/loose-model\|LOOSE MODEL]] |  | A low-fidelity kind: a model proposed without its adequacy yet argued |  |
| provisional | – | [[def/anecdote\|ANECDOTE]] |  | A low-fidelity kind: a single reported case |  |
| provisional | – | [[def/toy-simulation\|TOY SIMULATION]] |  | A low-fidelity kind: a run that illustrates rather than tests |  |
| provisional | – | [[def/idea\|IDEA]] |  | A low-fidelity kind: a direction, not yet a claim |  |
| provisional | – | [[def/segment\|SEGMENT]] |  | A named, ordered assembly of «veritoids\|def/veritoid#veritoid» in declared «slots\|def/segment#slot», written as one whole and reviewed as one whole; the «segment⸱kind» declares the slots, each with its veritoid kind, whether required, and how many it holds | 05, 09 §2.3, 11 |
| provisional | – | [[def/segment-kind\|SEGMENT KIND]] |  | Declares a segment's slots, each with its veritoid kind, whether required, and how many it holds; and how the segment's own values are got |  |
| provisional | – | [[def/slot\|SLOT]] |  | A declared place in a segment kind holding one, at most one, or any number of veritoids of one kind, in order |  |
| provisional | – | [[def/inner-dependency\|INNER DEPENDENCY]] |  | A declared dependence of one slot on another within one segment kind; declared once for the kind, not written per veritoid; why the whole segment is looked at together when one veritoid moves | 05, 11 |
| provisional | – | [[def/roll-up\|ROLL UP]] |  | How a segment gets its own values, its «roll⸱up»: an ‹aliased› «value» is one veritoid's, a ‹derived› value is computed from several, an ‹owned› value is asked of the whole, chiefly «coherence»: does it hold together read as one thing (the three are subtypes of «value») | 05, 09 §2.3, 11 |
| provisional | – | [[def/coherence\|COHERENCE]] |  | A segment's chief owned value: does it hold together when read as one thing; moved by a review of the whole |  |
| provisional | – | [[def/name\|NAME]] |  | A label the store keeps bound to a segment's «identity», with history; old names resolve; uniqueness is upkeep, not an assumption; a veritoid has no name | 09 §2.4, 11 |
| provisional | – | [[def/identity\|IDENTITY]] |  | What makes a segment the same segment across changes and renames; a name is bound to it |  |
| provisional | – | [[def/reference\|REFERENCE]] |  | A written pointer from a «veritoid» to others; someone declared it and it can be wrong; the store computes only whether it holds. The chief «reference⸱kind» is «predicated⸱on», which carries support and is a «use»: this step invokes that result here, and its hypotheses are met by these; the graph of uses among claims has no cycles; the «latent⸱level» is the limit a premise puts on everything predicated on it, written down or not | 09 §2.5, 11, 12 §6 |
| provisional | – | [[def/reference-kind\|REFERENCE KIND]] |  | A declared kind of reference, saying what passes along it; earns its place only when something treats it differently |  |
| provisional | – | [[def/predicated-on\|PREDICATED ON]] |  | The reference kind along which support travels: this claim needs those claims; acyclic among claims |  |
| gap | – | mutual definition | | AAT's first chapter looks like five terms defined together, not a chain; the model has «predicated⸱on» between claims and needs a second relation for terms that co-define (address theory's term group), or must say why not | orientation 11-06 |
| provisional | – | [[def/use\|USE]] |  | A predicated-on reference read as an invocation: this step invokes that result here, and that result's hypotheses are met by these |  |
| provisional | – | [[def/latent-level\|LATENT LEVEL]] |  | The limit a premise puts on everything predicated on it, written down or not |  |
| provisional | – | [[def/premise-change\|PREMISE CHANGE]] | ‹refuted› ‹dropped⸱in⸱level› ‹narrowed› | Three ways the target of a «predicated⸱on» reference can change, with different consequences downstream; a ‹narrowed› premise asks each dependent whether it used what is gone | 09 §2.5, 11 |
| provisional | – | [[def/act\|ACT]] |  | One recorded thing an attested «actor» did against a «state», which «binds\|def/act#bind» to exactly what it read, under a «criterion» fixed before the result; «standing» is yes-or-no before any question of quality; recording too little is as dishonest as claiming too much | 09 §3.1–3.5, 11 |
| gap | – | independence of acts | | What makes two acts independent lines when nearly every actor is the same model family; the stopped-bound case says this is not a detail | 16 q10, 09 §3.2 |
| provisional | – | [[def/actor\|ACTOR]] |  | The attested identity that performed an act, read from the harness and never typed |  |
| gap | – | steward attestation | | How "it was Joseph" is attested when his main session and an agent acting in it look the same to the harness | 09 §3.5 |
| provisional | – | [[def/bind\|BIND]] |  | What an act does to exactly what it read: it holds while that is unchanged and lapses when it changes |  |
| provisional | – | [[def/standing\|STANDING]] |  | Whether a given actor's act of a given sort counts at all; yes-or-no before any question of quality |  |
| provisional | – | [[def/criterion\|CRITERION]] |  | What an act was performed against, fixed before the result was seen |  |
| provisional | – | [[def/move\|MOVE]] |  | A declared way a «value» changes through an «act», naming what must be true first and who has standing; each has a «queue»; a queue is worked by a «mechanism»: a rule, an agent, or a council, decided later and not modelled here | 09 Part 6, 11 |
| provisional | – | [[def/queue\|QUEUE]] |  | The things waiting for one move; computed, visible, never filling unseen |  |
| provisional | – | [[def/mechanism\|MECHANISM]] |  | What works a queue: a rule, an agent, or a council; not modelled here |  |
| provisional | stub | [[def/steady-state\|STEADY STATE]] |  | Two kinds of time kept apart: the store moves between «steady⸱states\|def/steady#steady⸱state», at each of which it is "good or true, with stated conditions", at one logical instant; the hours in which a move is assembled are a different clock, during which there is a «working⸱state» that is never the verisectorium | 05, 08/10, 09 §3.1, 14 |
| gap | – | known defect on a steady state | | Whether a finding that breaks something may show on the steady line before its consequences are worked through, as a mark that inhibits reliance | 05, 09 §4.4 |
| provisional | stub | [[def/working-state\|WORKING STATE]] |  | The last steady state plus everything one atomic changeset in progress has staged so far. |  |
| provisional | stub | [[def/steady-time\|STEADY TIME]] |  | The sequence of steady states, in which each move happens at one logical instant. |  |
| provisional | stub | [[def/work-time\|WORK TIME]] |  | The hours and days in which minds assemble a move, with an order, clock times and actors. |  |
| provisional | – | [[def/segment-changeset\|SEGMENT CHANGESET]] |  | The unit of writing: a whole new written state of one segment, every inner dependent either changed or carried with the author's «affirmation» that it is still right; a state with a part that is neither is a draft | 05, 08/10, 11 |
| provisional | – | [[def/affirmation\|AFFIRMATION]] |  | The author's recorded statement, inside a segment changeset, that a veritoid left unchanged is still right against what did change; never an independent check |  |
| provisional | stub | [[def/atomic-changeset\|ATOMIC CHANGESET]] |  | Everything that takes the store from one steady state to the next; opens with a «perturbation»; the «frontier» is what is still owed while it is assembled; what is left on it by recorded decision is the «accepted⸱remainder» | 05, 09 §4.3, 11 |
| gap | – | parallel changesets | | Several atomic changesets in progress at once; whether the union of two independently steady stores is steady; punted by Joseph | 05 |
| provisional | stub | [[def/perturbation\|PERTURBATION]] |  | Whatever first disturbs a steady store and so opens an atomic changeset. |  |
| provisional | stub | [[def/frontier\|FRONTIER]] |  | Everything still owed in a working state; what is known not yet to be consistent, computed afresh after each write or act. |  |
| provisional | stub | [[def/accepted-remainder\|ACCEPTED REMAINDER]] |  | What is left on the frontier at the close of an atomic changeset by explicit, recorded decision, with its reason. |  |
| provisional | – | [[def/recut\|RECUT]] | ‹split› ‹merge› ‹promote› ‹fold⸱back› ‹retire› | To change how content is divided among veritoids and segments without changing what it says, never silently breaking or redirecting a «reference» | 09 §2.4, 11 |
| gap | – | veritoid identity under recut | | Whether a veritoid has an identity that survives being moved, or is only its place in a segment; decides what every split, promote and inbox drain does to inbound references | 09 Part 9, 11 |
| provisional | – | [[def/gap-segment\|GAP SEGMENT]] |  | Segment kinds the core itself needs: a «gap⸱segment» says what is missing and, where something must rest on it, enough to be rested on, and ends by vanishing or being replaced; a «planned⸱segment» is a legitimate state with declared-owed slots | 14, 15 |
| provisional | – | [[def/planned-segment\|PLANNED SEGMENT]] |  | A segment kind: a legitimate state with declared-owed slots; a name, a place in the outline and an inbox before any content |  |
| provisional | – | [[def/projection\|PROJECTION]] |  | A segment kind whose slots point at other segments in a chosen order for a purpose; at least one «canonical⸱projection» always exists; what a review of it reads of each member is declared; an «orphan» is reached by no canonical projection and no support reference; an «order⸱exception» is a recorded reason the order disagrees with dependency order | 05, 09 §2.6, 11 |
| provisional | – | [[def/canonical-projection\|CANONICAL PROJECTION]] |  | The projection that says "this is the work, in this order"; at least one always exists, however experimental |  |
| provisional | – | [[def/row\|ROW]] | ‹provisional› ‹promised› ‹present› | A «row» of a projection is a suggestion (‹provisional›), a promise the store stands behind (‹promised›), or ‹present›; provisional to promised is a decision; the outline stays true at every steady state | 14 |
| provisional | – | [[def/orphan\|ORPHAN]] |  | A segment reached by no canonical projection and by no support reference in or out |  |
| provisional | – | [[def/order-exception\|ORDER EXCEPTION]] |  | A recorded reason a projection's order disagrees with dependency order |  |
| provisional | – | [[def/inbox\|INBOX]] |  | Every segment's own intake, outside its written state, where «chunks\|def/intake#chunk» that bear on it wait; adding to it or emptying it never makes the segment look changed | 09 Part 5, 11, 14 |
| provisional | – | [[def/source\|SOURCE]] |  | A «source» is anything brought in from outside the store's settled content, cut completely into «chunks\|def/intake#chunk», each with at most one current «crossing», the act recording where it went (into a veritoid, a new veritoid, already present, an independent arrival, superseded, a «delivery» to another store, or an «inbox»); a source is retired when every chunk has a final crossing | 09 Part 5, 11, 14 |
| provisional | – | [[def/chunk\|CHUNK]] |  | One piece cut from a source |  |
| provisional | – | [[def/crossing\|CROSSING]] |  | The act recording where a chunk went |  |
| provisional | – | [[def/delivery\|DELIVERY]] |  | Material sent on from one store to another |  |
| provisional | – | [[def/rendering\|RENDERING]] |  | Text produced from the store for a reader, as of a state; never the thing; a status word in it is a snapshot with a time; nobody edits a rendering to change the store | 09 §2.8, 11 |

## Part III. Patterns

> [!NOTE]
> Not terms. Recurring patterns an «ontology» would select and name, each to be defined once with its behaviour in terms of the model; whether they earn a place of their own is open.

| mark | pattern | description | see |
|---|---|---|---|
| provisional | stance | What a piece of content does and so what it answers to: asserts, stipulates, selects, is taken, reports, proposes, prescribes, explains, wonders | 13 |
| provisional | relation with consequences | Not "A points at B" but what must stay in agreement, what a change at B does to A, and which act checks it; the recurring six: rests-on, faithful-to, consistent-with, realizes, explains, replaces | 13 |
| provisional | way of settling | The acts that can answer a question: derive, counterexample, measure, simulate, check at source, run the tests, machine-check, walk a reader through, scan for contradictions, red-team | 13, transcript 11-06 12:49 |
| provisional | roll-up | The declared ways a whole reads its values from its parts: aliased, strongest-line, every-member-sustains, min, headline | 11 def-segment, 08/09 (RC1 projections) |
| provisional | where depth goes | Breadth first (the outline with empty segments), then depth where the store's definition says: roots first for new theory, the end first for most other works | 14 (Joseph) |

## Part IV. Instances

Store definitions are not part of this model and live with their stores: AAT's in `~/src/aat-v3/`; udon's spec, an essay-centric store and vivarium are the next candidates Joseph has named. What is core and what is AAT-custom is not knowable before two or three of them exist; until then anything in core that may be AAT's is marked, and nothing is generalized early. An outline of instance examples may come later, as something other than definition groups.

## Part V. Questions and Prompts

Discussion prompts that haven't been discussed that may be fruitful.

- What would show this design is wrong? No piece of real material has been through it; a prediction belongs on paper before the first drain.
- What is the least that would have changed the sprint's outcome? Three candidates: knowing what has been read, an inbox outside the text, findings going back to the same author. Which parts of the model carry each?
- What does a cold agent see and do in its first five minutes?
- What does each act of recording cost, and is it cheaper than not recording?
- What will agents do to make the frontier empty?
- What reaches the steward, and in what form?
- What can be shown to a skeptical outsider?
- What happens outside AAT when a root changes?
- How does anything leave, and is the surface shrinking?
