# Verisectorium Model

This is the canonical projection of `core/`, initially describing the model via grouped and ordered lexical definitions, although mechanisms, descriptions, discussions, and introduction segments are likely to follow and intermingle. Groups are organized around their main term; cross-cutting ideas (time and change, growth, honesty) run through several groups and are not sections of their own.

> [!LEGEND]
> - `mark`: Every row carries one of:
>   - **present**: The group is in `core/def/` and has been decided (steward and lead, unanimous).
>   - **promised**: The store says this group will exist; its def may be a stub.
>   - **provisional**: A suggestion that such a group, or such a gap, is probably wanted. Not a commitment. It may stay at any level of detail without making this outline false. A row moves from provisional to promised by a decision. The outline is true as stated at every commit: a provisional row claims only that the suggestion exists.
>   - **gap**: Something is known to be missing here; what will replace it, and in how many groups, is not known.
> - `def`: Whether and how the segment exists, independent of how settled it is: `–` (none yet), `inline` (the description is the whole definition), `stub` (a file exists, possibly only working notes), `present` (a full def). A present def can still be provisional.
> - `group`: The name of the term-group as a link to the segment. Terms are grouped when they are only defined properly in conjunction with the others. For an `inline` row the link is omitted.
> - `terms-defined`: The actual lexical terms defined in the segment. Multi-word terms are joined with `⸱` (U+2E31). A term that would otherwise be a weak or ambiguous word is namespaced by the term it belongs to (`value⸱move`, `store⸱state`). Filenames may use `-` where a term has `⸱`.
> - `description`: Describes the group overall or, for `inline` rows, the full definition. (Verbose for provisional segments that don't yet have an associated file etc.).
> - `see`: (Provisional Only). Names the msc note(s) (`msc/notes/NN`) likely to inform early drafting and the segment's working notes. *Deleted for non-provisional segments.* *Deprecate column when empty*.
>
> **Defined terms in prose**, here and everywhere in `core/`, are written `«term»`, or `«wording|def/group#term»` where the wording is a plural, a different casing, or would be ambiguous. Inside a def's group paragraph a term's first mention is `«TERM»` in capitals. A bare `«term»` is valid only while exactly one def defines it. The checker verifies: the target exists; a bare term is unique; plural and casing match the def's `pl`; a namespaced term's qualifier is itself a defined term.

**TODO**:
- [ ] Possibly mark/highlight terms with very specific verisectorium definitions vs. typical definitions that are important for the full model but that aren't novel per se.
- [ ] Every namespacing below is provisional; decide each when its group is adjudicated.

## I. Verisectorium

| mark | def | group | terms-defined | description | see |
|---|---|---|---|---|---|
| provisional | stub | [[def/verisectorium\|VERISECTORIUM]] | verisectorium<br>answers⸱to<br>better | A body of work that is never finished, worked on by many minds who each arrive cold, in which every piece says honestly what it rests on and what has been done to it. Every piece of its content «answers⸱to» something (logic under hypotheses; the world through runs; a checker; cases; its own consistency; a canon; a source), and getting «better» means agreeing better with what it answers to; what better consists of is declared per verisectorium | 09 §1, 13, 14 |
| provisional | stub | [[def/regime\|REGIME]] | theory⸱claim<br>empirical⸱fact<br>proposed⸱model | Two regimes of content: a «theory⸱claim» aims to be true or false, is stated flatly, settled by derivation and refutation, its doubt a list beside it; an «empirical⸱fact» or «proposed⸱model» is adequate by degree, falsifiable, built on by decision; they join at the hypothesis | 12 addendum |
| provisional | stub | [[def/definition\|DEFINITION]] | definition | The declared kinds, dimensions, reference kinds and moves of one «store»; versioned; every piece follows one version of its kind; holds no content; written by hand for now | 01 §1, 02 Part B, 09 §4.6, 11 |
| provisional | – | [[def/layers\|LAYERS]] | core<br>pattern⸱library<br>aspect | A small fixed «core» (this outline); a growing «pattern⸱library» of patterns with behaviour (part IX) from which a «definition» selects and names; an «aspect» extends a definition | 13 |

## II. Store

| mark | def | group | terms-defined | description | see |
|---|---|---|---|---|---|
| provisional | stub | [[def/store\|STORE]] | store<br>log<br>state | A «verisectorium»'s contents as held, under an engine or by hand; the «log» is append-only; a «state» is the store as of a point in it: what every piece says, how pieces are assembled, which «definition» is in force, what has been recorded as done | 01 §2, 09 §3.1, 11 |
| provisional | stub | [[def/steady\|STEADY]] | steady⸱state<br>working⸱state<br>steady⸱time<br>work⸱time | Two kinds of time kept apart: the store moves between «steady⸱states\|def/steady#steady⸱state», at each of which it is "good or true, with stated conditions", at one logical instant; the hours in which a move is assembled are a different clock, during which there is a «working⸱state» that is never the verisectorium | 05, 08/10, 09 §3.1, 14 |
| provisional | stub | [[def/atomic-changeset\|ATOMIC CHANGESET]] | atomic⸱changeset<br>perturbation<br>frontier<br>accepted⸱remainder | Everything that takes the store from one steady state to the next; opens with a «perturbation»; the «frontier» is what is still owed while it is assembled; what is left on it by recorded decision is the «accepted⸱remainder» | 05, 09 §4.3, 11 |
| gap | – | known defect on a steady state | | Whether a finding that breaks something may show on the steady line before its consequences are worked through, as a mark that inhibits reliance | 05, 09 §4.4 |
| gap | – | parallel changesets | | Several atomic changesets in progress at once; whether the union of two independently steady stores is steady; punted by Joseph | 05 |

## III. Veritoid

| mark | def | group | terms-defined | description | see |
|---|---|---|---|---|---|
| provisional | stub | [[def/veritoid\|VERITOID]] | veritoid<br>content<br>veritoid⸱kind | One piece of «content» of a declared «veritoid⸱kind», with the answers to the questions that kind allows; never meaningful alone; never changed alone; contains no veritoid; has no name of its own | 05, 08/06–08, 09 §2.1, 11 |
| provisional | stub | [[def/written\|WRITTEN]] | written<br>computed | The line the model stands on: content, ground, bounds, claimed level, references, assembly and order are set by an author; every value, attribute, whether a reference holds, and every roll-up are produced by the store and never typed | 09 §2.7, 11 |
| provisional | stub | [[def/ground\|GROUND]] | ground | What an author states could ever support a piece; it opens the questions that can be asked of it; an unopened question is a fact, not a gap | 08/09, 09 §2.2, 11 |
| provisional | stub | [[def/bound\|BOUND]] | bound | A declared limit on a piece, consulted and never earned: what it may assert on its own authority, what a reader may do with it, whether it is safe to show an unprimed auditor | 08/09, 09 §3.4, 11 |
| provisional | stub | [[def/claimed-level\|CLAIMED LEVEL]] | claimed⸱level<br>soften | What a piece's content asserts about its own support; written, compared with what is computed; one only, the rest in the log; to «soften» is to lower it or narrow what is said | 01 §7, 09 §2.2, 11, 12 |
| provisional | – | [[def/claim\|CLAIM]] | claim<br>context<br>hypotheses<br>conclusion<br>derivation | The veritoid kind at the centre of a theory store: in a «context», under «hypotheses», a «conclusion» holds by a «derivation» from named premises. *May be AAT-specific.* | 12 |
| provisional | – | [[def/strength\|STRENGTH]] | strength<br>sharpness<br>forced | How much a claim says: «strength» is entailment, not a level; "conditional" and "exact" describe what is said («sharpness»), not how sure; «forced» vs chosen is whether a uniqueness result stands behind a choice | 12 |
| provisional | – | [[def/low-fidelity-kinds\|LOW-FIDELITY KINDS]] | sketch<br>hypothesis<br>loose⸱model<br>anecdote<br>toy⸱simulation<br>idea | First-class kinds with honest low ceilings and their own stances, not forced into the «claim» shape | 14 (Joseph), 15 |

## IV. Segment

| mark | def | group | terms-defined | description | see |
|---|---|---|---|---|---|
| provisional | – | [[def/segment\|SEGMENT]] | segment<br>segment⸱kind<br>slot | A named, ordered assembly of «veritoids\|def/veritoid#veritoid» in declared «slots\|def/segment#slot», written as one whole and reviewed as one whole; the «segment⸱kind» declares the slots, each with its veritoid kind, whether required, and how many it holds | 05, 09 §2.3, 11 |
| provisional | – | [[def/inner-dependency\|INNER DEPENDENCY]] | inner⸱dependency | A declared dependence of one slot on another within one segment kind; declared once for the kind, not written per veritoid; why the whole segment is looked at together when one veritoid moves | 05, 11 |
| provisional | – | [[def/roll-up\|ROLL-UP]] | aliased<br>derived<br>own<br>coherence | How a segment gets its own values: «aliased» to one veritoid's, «derived» from several, or «own» to the whole, chiefly «coherence»: does it hold together read as one thing | 05, 09 §2.3, 11 |
| provisional | – | [[def/name\|NAME]] | name<br>identity | A label the store keeps bound to a segment's «identity», with history; old names resolve; uniqueness is upkeep, not an assumption; a veritoid has no name | 09 §2.4, 11 |
| provisional | – | [[def/inbox\|INBOX]] | inbox | Every segment's own intake, outside its written state, where «chunks\|def/intake#chunk» that bear on it wait; adding to it or emptying it never makes the segment look changed | 09 Part 5, 11, 14 |
| provisional | – | [[def/segment-changeset\|SEGMENT CHANGESET]] | segment⸱changeset<br>affirmation | The unit of writing: a whole new written state of one segment, every inner dependent either changed or carried with the author's «affirmation» that it is still right; a state with a part that is neither is a draft | 05, 08/10, 11 |
| provisional | – | [[def/recut\|RECUT]] | recut<br>split<br>merge<br>promote<br>fold⸱back<br>retire | To change how content is divided among veritoids and segments without changing what it says, never silently breaking or redirecting a «reference» | 09 §2.4, 11 |
| gap | – | veritoid identity under recut | | Whether a veritoid has an identity that survives being moved, or is only its place in a segment; decides what every split, promote and inbox drain does to inbound references | 09 Part 9, 11 |
| provisional | – | [[def/segment-kinds\|SEGMENT KINDS]] | gap⸱segment<br>planned⸱segment | Segment kinds the core itself needs: a «gap⸱segment» says what is missing and, where something must rest on it, enough to be rested on, and ends by vanishing or being replaced; a «planned⸱segment» is a legitimate state with declared-owed slots | 14, 15 |
| provisional | – | [[def/projection\|PROJECTION]] | projection<br>canonical⸱projection<br>orphan<br>order⸱exception | A segment kind whose slots point at other segments in a chosen order for a purpose; at least one «canonical⸱projection» always exists; what a review of it reads of each member is declared; an «orphan» is reached by no canonical projection and no support reference; an «order⸱exception» is a recorded reason the order disagrees with dependency order | 05, 09 §2.6, 11 |
| provisional | – | [[def/row\|ROW]] | row<br>provisional⸱row<br>promised⸱row<br>present⸱row | A «row» of a projection is a suggestion («provisional⸱row»), a promise the store stands behind («promised⸱row»), or «present⸱row»; provisional to promised is a decision; the outline stays true at every steady state | 14 |
| provisional | – | [[def/rendering\|RENDERING]] | rendering | Text produced from the store for a reader, as of a state; never the thing; a status word in it is a snapshot with a time; nobody edits a rendering to change the store | 09 §2.8, 11 |

## V. Reference

| mark | def | group | terms-defined | description | see |
|---|---|---|---|---|---|
| provisional | – | [[def/reference\|REFERENCE]] | reference<br>reference⸱kind<br>predicated⸱on<br>use<br>latent⸱level | A written pointer from a «veritoid» to others; someone declared it and it can be wrong; the store computes only whether it holds. The chief «reference⸱kind» is «predicated⸱on», which carries support and is a «use»: this step invokes that result here, and its hypotheses are met by these; the graph of uses among claims has no cycles; the «latent⸱level» is the limit a premise puts on everything predicated on it, written down or not | 09 §2.5, 11, 12 §6 |
| provisional | – | [[def/premise-change\|PREMISE CHANGE]] | refuted<br>dropped⸱in⸱level<br>narrowed | Three ways the target of a «predicated⸱on» reference can change, with different consequences downstream; a «narrowed» premise asks each dependent whether it used what is gone | 09 §2.5, 11 |
| gap | – | mutual definition | | AAT's first chapter looks like five terms defined together, not a chain; the model has «predicated⸱on» between claims and needs a second relation for terms that co-define (address theory's term group), or must say why not | orientation 11-06 |

## VI. Dimension and Value

| mark | def | group | terms-defined | description | see |
|---|---|---|---|---|---|
| provisional | – | [[def/dimension\|DIMENSION]] | dimension<br>scale<br>ladder<br>rung | One independently answerable question about a piece, with the «scale» of values it can take (a «ladder» of ordered «rungs\|def/dimension#rung», an unordered set, or a number); sustained by evidence, by decision, or by attestation, or a mix; no dimension's answer ever stands in for another's | 08/09, 09 §2.2, 11 |
| provisional | – | [[def/value\|VALUE]] | value<br>position<br>judgment | What is warranted on one dimension as of a state, computed from the acts that still bind and never typed: a «position» (what has been done) or a «judgment» (a reading only judgment can give, held with its spread). Three things kept apart for every question: what is claimed («claimed⸱level»), what has been done (the acts), what is warranted (the value); honesty is that the first never exceeds the third. Belief rightly rises with each act by an amount that depends on how independent the act is | transcript 11-06 12:15–12:30; 12 and addendum; replaces 11 def-value |
| provisional | – | [[def/credence\|CREDENCE]] | credence | A number for "is it true", a special case a store declares where the evidence reduces to priors and likelihoods (as relata does); not the core | 12 addendum |
| provisional | – | [[def/move\|MOVE]] | move<br>queue<br>mechanism | A declared way a «value» changes through an «act», naming what must be true first and who has standing; each has a «queue»; a queue is worked by a «mechanism»: a rule, an agent, or a council, decided later and not modelled here | 09 Part 6, 11 |

## VII. Act

| mark | def | group | terms-defined | description | see |
|---|---|---|---|---|---|
| provisional | – | [[def/act\|ACT]] | act<br>actor<br>bind<br>standing<br>criterion | One recorded thing an attested «actor» did against a «state», which «binds\|def/act#bind» to exactly what it read, under a «criterion» fixed before the result; «standing» is yes-or-no before any question of quality; recording too little is as dishonest as claiming too much | 09 §3.1–3.5, 11 |
| gap | – | independence of acts | | What makes two acts independent lines when nearly every actor is the same model family; the stopped-bound case says this is not a detail | 16 q10, 09 §3.2 |
| gap | – | steward attestation | | How "it was Joseph" is attested when his main session and an agent acting in it look the same to the harness | 09 §3.5 |

## VIII. Intake

| mark | def | group | terms-defined | description | see |
|---|---|---|---|---|---|
| provisional | – | [[def/intake\|INTAKE]] | source<br>chunk<br>crossing<br>delivery | A «source» is anything brought in from outside the store's settled content, cut completely into «chunks\|def/intake#chunk», each with at most one current «crossing», the act recording where it went (into a veritoid, a new veritoid, already present, an independent arrival, superseded, a «delivery» to another store, or an «inbox»); a source is retired when every chunk has a final crossing | 09 Part 5, 11, 14 |

## IX. Typical Patterns

> [!NOTE]
> Not definition groups and not part of the lexicon. Candidates for the «pattern⸱library», each to be defined once with its behaviour, in terms of the core. Whether the library earns a segment kind of its own is open.

| mark | pattern | description | see |
|---|---|---|---|
| provisional | stance | What a piece of content does and so what it answers to: asserts, stipulates, selects, is taken, reports, proposes, prescribes, explains, wonders | 13 |
| provisional | relation with consequences | Not "A points at B" but what must stay in agreement, what a change at B does to A, and which act checks it; the recurring six: rests-on, faithful-to, consistent-with, realizes, explains, replaces | 13 |
| provisional | way of settling | The acts that can answer a question: derive, counterexample, measure, simulate, check at source, run the tests, machine-check, walk a reader through, scan for contradictions, red-team | 13, transcript 11-06 12:49 |
| provisional | roll-up | The declared ways a whole reads its values from its parts: aliased, strongest-line, every-member-sustains, min, headline | 11 def-segment, 08/09 (RC1 projections) |
| provisional | where depth goes | Breadth first (the outline with empty segments), then depth where the store's definition says: roots first for new theory, the end first for most other works | 14 (Joseph) |
| gap | whether six relations and ten ways are enough | Only looked enough from seven one-paragraph sketches | 13 |

## X. Instances

Store definitions are not part of this model and live with their stores: AAT's in `~/src/aat-v3/`; udon's spec, an essay-centric store and vivarium are the next candidates Joseph has named. What is core and what is AAT-custom is not knowable before two or three of them exist; until then anything in core that may be AAT's is marked, and nothing is generalized early. An outline of instance examples may come later, as something other than definition groups.

## XI. Questions and Prompts

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
