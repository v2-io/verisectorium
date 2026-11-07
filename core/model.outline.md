# Verisectorium Model

This is the canonical projection of `core/`, initially describing the model via grouped and ordered lexical definitions, although mechanisms, descriptions, discussions, and introduction segments are likely to follow and intermingle. Groups are organized around their main term; cross-cutting ideas (time and change, growth, honesty) run through several groups and are not sections of their own.

> [!LEGEND]
> - `mark`: Every row carries one of:
>   - **present**: The group is in `core/def/` and has been decided (steward and lead, unanimous).
>   - **promised**: The store says this group will exist; its def may be a stub.
>   - **provisional**: A suggestion that such a group, or such a gap, is probably wanted. Not a commitment. It may stay at any level of detail without making this outline false. A row moves from provisional to promised by a decision. The outline is true as stated at every commit: a provisional row claims only that the suggestion exists.
>   - **gap**: Something is known to be missing here; what will replace it, and in how many groups, is not known.
> - `group`: The name of the term-group as a link to the segment. Terms are grouped when they are only defined properly in conjunction with the others. `(inline)` in place of the link marks a row whose definition is simple enough to be fully contained on "one line"; the mark still says how settled it is, so an inline row may be provisional.
> - `terms-defined`: The actual lexical terms defined in the segment. Multi-word terms are joined with `⸱` (U+2E31). A term that would otherwise be a weak or ambiguous word is namespaced by the term it belongs to (`value⸱move`, `store⸱state`). Filenames may use `-` where a term has `⸱`.
> - `description`: Describes the group overall or, for `(inline)` rows, the full definition. (Verbose for provisional segments that don't yet have an associated file etc.).
> - `see`: (Provisional Only). Names the msc note(s) (`msc/notes/NN`) likely to inform early drafting and the segment's working notes. *Deleted for non-provisional segments.* *Deprecate column when empty*.
>
> **Defined terms in prose**, here and everywhere in `core/`, are written `«term»`, or `«wording|def/group#term»` where the wording is a plural, a different casing, or would be ambiguous. Inside a def's group paragraph a term's first mention is `«TERM»` in capitals. A bare `«term»` is valid only while exactly one def defines it. The checker verifies: the target exists; a bare term is unique; plural and casing match the def's `pl`; a namespaced term's qualifier is itself a defined term.

**TODO**:
- [ ] Possibly mark/highlight terms with very specific verisectorium definitions vs. typical definitions that are important for the full model but that aren't novel per se.
- [ ] Every namespacing below is provisional; decide each when its group is adjudicated.

## I. Verisectorium

| mark | group | terms-defined | description | see |
|---|---|---|---|---|
| provisional | [[def/verisectorium\|VERISECTORIUM]] | verisectorium<br>answers⸱to<br>better<br>theory⸱claim<br>empirical⸱fact<br>proposed⸱model | A body of work that is never finished, worked on by many minds who each arrive cold, in which every piece says honestly what it rests on and what has been done to it. Every piece of its content «answers⸱to» something (logic under hypotheses; the world through runs; a checker; cases; its own consistency; a canon; a source), and getting «better» means agreeing better with what it answers to; what counts as better is declared per store.<br>Two regimes of content: a «theory⸱claim» aims to be true or false, is stated flatly, settled by derivation and refutation, its doubt a list beside it; an «empirical⸱fact» or «proposed⸱model» is adequate by degree, falsifiable, built on by decision; they join at the hypothesis | 09 §1, 12 addendum, 13, 14 |
| provisional | [[def/store\|STORE]] | store<br>store⸱state<br>steady⸱state<br>working⸱state<br>store⸱log<br>steady⸱time<br>work⸱time<br>atomic⸱changeset<br>perturbation<br>frontier<br>accepted⸱remainder | A verisectorium's contents as held, under an engine or by hand. The «store⸱log» is append-only; a «store⸱state» is the store as of a point in it. The store moves between «steady⸱states\|def/store#steady⸱state», at each of which it is "good or true, with stated conditions", at one logical instant («steady⸱time»); the hours in which a move is assembled («work⸱time») are a different clock, during which there is a «working⸱state». An «atomic⸱changeset» is everything that takes the store from one steady state to the next; it begins with a «perturbation»; the «frontier» is what is still owed while it is assembled, and what is left on it by explicit decision is the «accepted⸱remainder» | 09 §3.1, 11 def-state, 11 def-changeset, 05, 14 |
| gap | known defect on a steady state | | Whether a finding that breaks something may show on the steady line before its consequences are worked through, as a mark that inhibits reliance | 05, 09 §4.4 |
| gap | parallel moves | | Several atomic changesets in progress at once; whether the union of two independently steady stores is steady; punted by Joseph | 05 |
| provisional | [[def/layers\|LAYERS]] | core<br>pattern⸱library<br>store⸱definition<br>aspect | A small fixed «core» (this outline); a growing «pattern⸱library» of patterns with behaviour (part VIII); short «store⸱definitions\|def/layers#store⸱definition» that select and name patterns, one per store; an «aspect» extends a store definition | 13 |

## II. Veritoid

| mark | group | terms-defined | description | see |
|---|---|---|---|---|
| provisional | [[def/veritoid\|VERITOID]] | veritoid<br>content<br>veritoid⸱kind<br>ground<br>bound | A piece of «content» of a declared «veritoid⸱kind», with the answers to the questions that kind allows; never meaningful alone. Which questions are open for a piece is set by its declared «ground» (provable? measurable? an instance of a known model? only witnessed?). A «bound» is a declared limit on it, consulted and never earned | 11 def-veritoid, 11 def-dimension, 05, 08/08 |
| provisional | [[def/claim\|CLAIM]] | claim<br>claim⸱context<br>claim⸱hypotheses<br>claim⸱conclusion<br>derivation<br>claim⸱strength<br>claim⸱sharpness<br>forced | The veritoid kind at the centre of a theory store: in a «claim⸱context», under «claim⸱hypotheses», a «claim⸱conclusion» holds by a «derivation» from named premises. «claim⸱strength» is entailment, not a level; "conditional" and "exact" describe what is said («claim⸱sharpness»), not how sure; «forced» vs chosen is whether a uniqueness result stands behind a choice. *May be AAT-specific.* | 12 |
| provisional | [[def/low-fidelity-kinds\|LOW-FIDELITY KINDS]] | sketch<br>hypothesis<br>loose⸱model<br>anecdote<br>toy⸱simulation<br>idea | First-class kinds with honest low ceilings and their own stances, not forced into the «claim» shape | 14 (Joseph), 15 |

## III. Segment

| mark | group | terms-defined | description | see |
|---|---|---|---|---|
| provisional | [[def/segment\|SEGMENT]] | segment<br>segment⸱kind<br>slot<br>inner⸱dependency<br>aliased<br>derived<br>own<br>coherence<br>segment⸱name<br>segment⸱identity<br>segment⸱inbox | A named, ordered assembly of «veritoids\|def/veritoid#veritoid» in declared «slots\|def/segment#slot», written as one whole and reviewed as one whole. A «segment⸱kind» declares the slots, their «inner⸱dependencies\|def/segment#inner⸱dependency», and how the segment's own values are got: «aliased» to one veritoid's, «derived» from several, or «own» to the whole, chiefly «coherence». A «segment⸱name» is a label the store keeps bound to the segment's «segment⸱identity», with history; old names resolve. Every segment has a «segment⸱inbox», outside its written state, where «chunks\|def/intake#chunk» that bear on it wait | 11 def-segment, 11 def-name, 11 def-intake, 05, 14 |
| provisional | [[def/segment-changeset\|SEGMENT CHANGESET]] | segment⸱changeset<br>affirmation | The unit of writing: a whole new written state of one segment, every inner dependent either changed or carried with the author's «affirmation» that it is still right. A segment state with a part that is neither is a draft, not a changeset | 11 def-changeset, 05, 08/10 |
| provisional | [[def/recut\|RECUT]] | split<br>merge<br>promote<br>fold⸱back<br>retire | The ways a segment's structure is changed without any «reference» silently breaking or silently redirecting | 11 def-recut |
| gap | veritoid identity under recut | | Whether a veritoid has an identity that survives being moved, or is only its place in a segment; decides what every split, promote and inbox drain does to inbound references | 09 Part 9, 11 |
| provisional | [[def/segment-kinds\|SEGMENT KINDS]] | gap⸱segment<br>planned⸱segment | Segment kinds the core itself needs: a «gap⸱segment» says what is missing and, where something must rest on it, enough to be rested on, and ends by vanishing or being replaced; a «planned⸱segment» is a legitimate state with declared-owed slots. Other kinds belong to store definitions | 14, 15 |
| provisional | [[def/projection\|PROJECTION]] | projection<br>canonical⸱projection<br>projection⸱row<br>provisional⸱row<br>promised⸱row<br>present⸱row<br>orphan<br>order⸱exception | A segment kind whose slots point at other segments in a chosen order for a purpose. There is always at least one «canonical⸱projection», however experimental. Each «projection⸱row» is a «provisional⸱row» (a suggestion), a «promised⸱row» (the store stands behind it), or a «present⸱row»; provisional to promised is a decision. What a review of a projection reads of each member is declared. An «orphan» is a segment in no canonical projection and with no support reference in or out; an «order⸱exception» is a recorded reason the projection's order disagrees with dependency order | 11 def-projection, 05, 14 |
| provisional | [[def/rendering\|RENDERING]] | rendering | Text produced from the store for a reader; never the thing; a status word in it is a snapshot with a time | 11 def-rendering |

## IV. Reference

| mark | group | terms-defined | description | see |
|---|---|---|---|---|
| provisional | [[def/reference\|REFERENCE]] | reference<br>reference⸱kind<br>predicated⸱on<br>reference⸱use<br>latent⸱level | A written pointer from a «veritoid» to others; someone declared it and it can be wrong; the store computes only whether it holds. The chief «reference⸱kind» is «predicated⸱on», which carries support and is a «reference⸱use»: this step invokes that result here, and that result's hypotheses are met by these. The graph of such references among claims has no cycles. The «latent⸱level» is the limit a premise puts on everything predicated on it, written down or not | 11 def-reference, 12 §6 |
| provisional | [[def/premise-change\|PREMISE CHANGE]] | refuted<br>dropped⸱in⸱level<br>narrowed | Three ways the target of a «predicated⸱on» reference can change, with different consequences downstream; a «narrowed» premise asks each dependent whether it used what is gone | 11 def-premise-change |
| gap | mutual definition | | AAT's first chapter looks like five terms defined together, not a chain; the model has «predicated⸱on» between claims and needs a second relation for terms that co-define (address theory's term group), or must say why not | orientation 11-06 |

## V. Dimension and Value

| mark | group | terms-defined | description | see |
|---|---|---|---|---|
| provisional | [[def/dimension\|DIMENSION]] | dimension<br>scale<br>ladder<br>rung | One independently answerable question about a piece of content, with the «scale» of values it can take, which may be a «ladder» of ordered «rungs\|def/dimension#rung», an unordered set, or a number | 11 def-dimension, 08/09 (RC1 take) |
| provisional | [[def/value\|VALUE]] | value<br>value⸱claimed<br>value⸱done<br>value⸱warranted<br>position<br>judgment<br>credence | For every question about every piece, three things kept apart: «value⸱claimed», what the content asserts, written by an author; «value⸱done», what has actually been done, the acts, a fact; «value⸱warranted», what that justifies believing, an inference by a stated rule anyone can re-run. Honesty is that the first never exceeds the third. A «value» is the warranted answer on one dimension as of a state: a «position» (what has been done) or a «judgment» (a reading only judgment can give, held with its spread). «credence», a number for "is it true", is a special case a store declares (as relata does), not the core. Belief rightly rises with each act by an amount that depends on how independent the act is; a claim held high that later fails is not a malfunction. The one-word status of old ASF is a display computed from all of this, and can always be opened up | transcript 11-06 12:15–12:30; 12 and addendum; replaces 11 def-value, known contradictory |
| provisional | [[def/value-move\|VALUE MOVE]] | value⸱move<br>move⸱queue<br>move⸱mechanism | A declared way a «value» changes through an «act»; each move has a «move⸱queue» of things waiting for it; a queue is worked by a «move⸱mechanism»: a rule, an agent, or a council, decided later and not modelled here | 11 def-move |

## VI. Act

| mark | group | terms-defined | description | see |
|---|---|---|---|---|
| provisional | [[def/act\|ACT]] | act<br>actor<br>bind<br>standing<br>criterion | One recorded thing an attested «actor» did against a «store⸱state», which «binds\|def/act#bind» to exactly what it read, under a «criterion» fixed before the result; «standing» is yes-or-no before any question of quality. Recording too little is as dishonest as claiming too much | 11 def-act |
| gap | independence of acts | | What makes two acts independent lines when nearly every actor is the same model family; the stopped-bound case says this is not a detail | 16 q10, 09 §3.2 |
| gap | steward attestation | | How "it was Joseph" is attested when his main session and an agent acting in it look the same to the harness | 09 §3.5 |

## VII. Intake

| mark | group | terms-defined | description | see |
|---|---|---|---|---|
| provisional | [[def/intake\|INTAKE]] | source<br>chunk<br>crossing<br>delivery | A «source» is anything brought in from outside the store's settled content, cut completely into «chunks\|def/intake#chunk», each with at most one current «crossing», the act recording where it went (into a veritoid, a new veritoid, already present, an independent arrival, superseded, a «delivery» to another store, or a «segment⸱inbox»). A source is retired when every chunk has a final crossing | 11 def-intake, 14 |

## VIII. Typical Patterns

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

## IX. Instances

Store definitions are not part of this model and live with their stores: AAT's in `~/src/aat-v3/`; udon's spec, an essay-centric store and vivarium are the next candidates Joseph has named. What is core and what is AAT-custom is not knowable before two or three of them exist; until then anything in core that may be AAT's is marked, and nothing is generalized early. An outline of instance examples may come later, as something other than definition groups.

## X. Questions and Prompts

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
