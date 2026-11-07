# The verisectorium model: outline, as a lexicon

This is the canonical projection of `core/`: the one ordered grouping of its definition groups. It is the only place where things not yet in `core/def/` may be named.

**Row marks.** Every row carries one of:

- **present** — the group is in `core/def/` and has been decided (steward and lead, unanimous).
- **promised** — the store says this group will exist; its def may be a stub.
- **provisional** — a suggestion that such a group, or such a gap, is probably wanted. Not a commitment. It may stay at any level of detail without making this outline false.
- **gap** — something is known to be missing here; what will replace it, and in how many groups, is not known.

A row moves from provisional to promised by a decision. The outline is true as stated at every commit: a provisional row claims only that the suggestion exists.

**Reading.** Each group leans only on groups above it, except where a row says "later". Terms are given in the form `term-group: lead term, other terms — one line`. The `from` column names the working note (`msc/notes/NN`) a provisional row would be adjudicated from; it is a pointer to work, not history.

**As of 2026-11-06 every row is provisional.** Nothing has been decided.

---

## I. What a verisectorium is

| mark | group | one line | from |
|---|---|---|---|
| provisional | **verisectorium**: verisectorium, store, steady state, canonical projection | a body of work that is never finished, worked on by many minds who each arrive cold, in which every piece says honestly what it rests on and what has been done to it; it is "good or true, with stated conditions" at each steady state | 09 §1, 14 |
| provisional | **answers-to**: answers to, better | every piece of content answers to something (logic under hypotheses; the world through runs; a checker; cases; its own consistency; a canon; a source), and getting better means agreeing better with what it answers to; "better" is declared per store | 13 |
| provisional | **three layers**: core, pattern library, store definition, aspect | a small fixed core (this outline's parts II–V); a growing library of patterns with behaviour (part VI); short store definitions that select and name patterns (part VII); an aspect extends a store definition | 13 |
| provisional | **regimes**: theory claim, empirical fact, proposed model, hypothesis | a theory claim aims to be true or false, is stated flatly, settled by derivation and refutation, its doubt a list beside it; an empirical fact or proposed model is adequate by degree, falsifiable, built on by decision; they join at the hypothesis | 12 addendum |

## II. Content and the wholes it is assembled into

| mark | group | one line | from |
|---|---|---|---|
| provisional | **veritoid**: veritoid, content, veritoid-kind | a piece of content of a declared kind, with the answers to the questions that kind allows; never meaningful alone | 11 def-veritoid, 05, 08/08 |
| provisional | **segment**: segment, segment-kind, slot, inner-dependency, aliased, derived, own, coherence | a named, ordered assembly of veritoids in declared slots, written as one whole and reviewed as one whole, with values of its own got by aliasing, derivation or asked of the whole | 11 def-segment, 05 |
| provisional | **name**: name, identity | a label the store keeps bound to a segment, with history; old names resolve; the thing is not the name | 11 def-name |
| provisional | **reference**: reference, reference-kind, predicated-on, use, dependency-graph, latent-level | a written pointer from a veritoid to others; the chief kind carries support and is a *use*: this step invokes that result here, and that result's hypotheses are met by these; the graph of uses has no cycles among claims; nothing can be better supported than what it rests on | 11 def-reference, 12 §6 |
| gap | mutual definition | the first chapter of AAT looks like five terms defined together, not a chain; the model has rests-on between claims and needs a second relation for terms that co-define (address theory's term group), or must say why not | (orientation 11-06) |
| provisional | **projection**: projection, canonical projection, orphan, order exception | a segment whose slots point at other segments in a chosen order for a purpose; there is always at least one canonical one, however experimental; what a review of it reads of each member is declared | 11 def-projection, 05 |
| provisional | **recut**: split, merge, promote, fold back, retire | the ways structure is changed without any pointer silently breaking or silently redirecting | 11 def-recut |
| gap | veritoid identity under recut | whether a veritoid has an identity that survives being moved, or is only its place; decides what every split, promote and drain does to inbound references | 09 Part 9, 11 |
| provisional | **rendering**: rendering | text produced from the store for a reader; never the thing; a status word in it is a snapshot with a time | 11 def-rendering |

## III. Questions, acts and judgments

| mark | group | one line | from |
|---|---|---|---|
| provisional | **dimension**: dimension, scale, ladder, rung, ground, bound | one independently answerable question about a piece of content, with the values it can take; which questions are open for a piece is set by its declared ground; a bound is declared and consulted, never earned | 11 def-dimension, 08/09 (RC1 take) |
| provisional | **act**: act, actor, bind, standing, affirmation, criterion | one recorded thing an attested actor did against a state, binding to exactly what it read, under a criterion fixed before the result; standing is yes-or-no before quality; recording too little is as dishonest as claiming too much | 11 def-act |
| provisional | **three things kept apart**: claimed, done, warranted | for every question about every piece: what the content asserts (written by an author); what has actually been done (the acts, a fact); what that justifies believing (an inference by a stated rule anyone can re-run); honesty is that the first never exceeds the third | transcript 11-06 12:15–12:30; 12 |
| provisional | **value**: value, position, judgment, credence | the computed answer on one dimension as of a state; a position is what has been done; a judgment is a reading only judgment can give, held with its spread; credence, a number for "is it true", is a special case a store declares (as relata does) and not the core; belief rightly rises with each act by an amount that depends on how independent the act is, and a claim held high that later fails is not a malfunction | 12 addendum; replaces 11 def-value, known contradictory |
| provisional | **claim shape**: context, hypotheses, conclusion, derivation, strength, sharpness, forced | in a context, under hypotheses, a conclusion holds by a derivation from named premises; strength is entailment, not a level; "conditional" and "exact" describe what is said, not how sure; forced vs chosen is whether a uniqueness result stands behind a choice | 12 |
| provisional | **status as display**: computed status | the one-word status is a display computed from everything a claim rests on and what has been done to each, and can always be opened up | 12 |
| gap | independence of checks | what makes two acts independent lines when nearly every checker is the same model family; the stopped-bound case says this is not a detail | 16 q10, 09 §3.2 |
| gap | steward attestation | how "it was Joseph" is attested when his main session and an agent acting in it look the same to the harness | 09 §3.5 |

## IV. Time and change

| mark | group | one line | from |
|---|---|---|---|
| provisional | **state**: state, steady state, working state, log, steady time, work time | the log is append-only; a state is the store as of a point in it; the store moves between steady states at one logical instant; the hours in which a move is assembled are a different clock | 11 def-state, 08/10 |
| provisional | **changeset**: segment changeset, atomic changeset, perturbation, frontier, accepted remainder | a segment changeset is a whole new written state of one segment, every inner dependent changed or affirmed; an atomic changeset is everything that takes the store from one steady state to the next; the frontier is what is still owed while it is assembled | 11 def-changeset, 05 |
| provisional | **premise change**: refuted, dropped in level, narrowed | three ways a premise can change, with different consequences downstream; a narrowing asks each dependent whether it used what is gone | 11 def-premise-change |
| provisional | **move**: move, queue, mechanism | a declared way a value changes through an act; each has a queue; a queue is worked by a rule, an agent or a council, decided later and not modelled here | 11 def-move |
| gap | known defect on a steady state | whether a finding that breaks something may show on the steady line before its consequences are worked through, as a mark that inhibits reliance | 05, 09 §4.4 |
| gap | parallel moves | several moves in progress at once; whether the union of two independently steady stores is steady; punted by Joseph | 05 |

## V. How a store grows

| mark | group | one line | from |
|---|---|---|---|
| provisional | **intake**: source, chunk, crossing, inbox, delivery | a source is cut completely into chunks, each with at most one current crossing; every segment has an inbox outside its written state where chunks that bear on it wait; what leaves for another store is a delivery | 11 def-intake, 14 |
| provisional | **commitment**: provisional, promised, present | a row of the canonical projection is a suggestion, a promise the store stands behind, or present; moving from provisional to promised is a decision | 14 |
| provisional | **gap kind**: gap, planned segment | a gap is a kind of segment that says what is missing and, where something must rest on it, enough to be rested on; it ends by vanishing or being replaced; a planned segment is a legitimate state with declared-owed slots | 14, 15 |
| provisional | **low-fidelity kinds**: sketch, hypothesis, loose model, anecdote, toy simulation, idea | first-class kinds with honest low ceilings and their own stances, not forced into the claim shape | 14 (Joseph), 15 |
| provisional | **where depth goes** | breadth first (the outline with empty segments), then depth where the store's definition says: roots first for new theory, the end first for most other works | 14 (Joseph) |
| gap | the least that would have fixed the sprint | three candidates: knowing what has been read, an inbox outside the text, findings going back to the same author; the model must say which of its parts carry each, and what else is needed now | 16 q2 |

## VI. The pattern library

| mark | group | one line | from |
|---|---|---|---|
| provisional | **stance** | what a piece of content does and so what it answers to: asserts, stipulates, selects, is taken, reports, proposes, prescribes, explains, wonders | 13 |
| provisional | **relation with consequences** | not "A points at B" but what must stay in agreement, what a change at B does to A, and which act checks it; the recurring six: rests-on, faithful-to, consistent-with, realizes, explains, replaces | 13 |
| provisional | **way of settling** | the acts that can answer a question: derive, counterexample, measure, simulate, check at source, run the tests, machine-check, walk a reader through, scan for contradictions, red-team | 13, transcript 11-06 12:49 |
| provisional | **roll-up** | the declared ways a whole reads its values from its parts: aliased, strongest-line, every-member-sustains, min, headline | 11 def-segment, 08/09 (RC1 projections) |
| gap | whether six relations and ten ways are enough | only looked enough from seven one-paragraph sketches | 13 |

## VII. Store definitions (instances)

| mark | group | one line | from |
|---|---|---|---|
| provisional | **mathematical theory** (AAT) | centre: claims chained by use; better: stronger claims more firmly established; doubt beside the claim; lives in `~/src/aat-v3/` | 13, 12 |
| provisional | **formal spec** (udon) | centre: rules held consistent and decided; better: no conflicts, every rule exercised | 13 |
| provisional | **explication / essays**, **vivarium** | named by Joseph as the third and fourth instances before "core vs domain" can be judged | (11-06) |
| gap | what is core and what is AAT-custom | not knowable before two or three instances; until then anything in core that may be AAT's is marked, and nothing is generalized early | (Joseph, 11-06) |

## VIII. Outside the model but owed to it

| mark | group | one line | from |
|---|---|---|---|
| gap | what the first five minutes look like | what a cold agent sees and does; we designed what exists, not what is put in front of someone | 16 q4 |
| gap | the cost of recording | if structure costs more than prose, agents write prose | 16 q5 |
| gap | the frontier as a target | affirmations and accepted remainders are cheap exits | 16 q6 |
| gap | what reaches the steward, and in what form | | 16 q7 |
| gap | the skeptical outsider | everything so far faces inward | 16 q8 |
| gap | reach beyond the store | what happens outside AAT when a root changes (other volumes, submitted papers) | 16 q9 |
| gap | what leaves, and is the surface shrinking | the operations are named; there is no measure | 16 q11 |
| gap | what would show this design is wrong | no piece of real material has been through it; a prediction belongs on paper before the first drain | 16 q1 |
