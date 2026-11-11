# Kernel spec, draft 1

*2026-11-10. Drafted by the lead (Fable 5.2) from `core/` at `89b04af`, for formal work: proofs where the kernel is stable, counterexample search where it is not. Not part of core. Every rule cites the def it comes from, by file and a phrase that can be searched for (`check-cites.sh` beside this file confirms each phrase is still there). Where this spec and a def disagree, that is a finding to bring back, not a fact about the model. The 2026-11-07 kernel spec was a toy for comparing languages and is not this document's ancestor.*

## 1. What is being formalized, and what is not

In: the record, the fold, the two kinds of act and how long each counts, identity and versions, references and the cap, acceptance and owing, the frontier's items and their exits, scopes and steadiness.

Out, for now: actors' orientation, importance and agreement among seats, "better", renderings, how the ontology itself changes, what normalization of content is, intake's cut (a source is just an assembly here).

## 2. Policy parameters

The kernel is stated for any choice of these. They are what an ontology declares, and two of them are still open questions in core. A property below is marked **(all)** if it should hold for every policy and **(policy: …)** if it needs a named condition on one.

| parameter | what it decides | core |
|---|---|---|
| `accepts` | how a segment enters canon: a party's decision, a rule over warrants, or placement unmarked in the canonical projection | `def/verisectorium.md`: "declares how a segment enters canon" |
| `rests_on` | which reference kinds, held-against namings and decision bases make one segment rest on another | `def/segment.md`: "Holding and pointing are not resting" |
| `read_as(d)` | per dimension, how answer and warrant are read from the acts that still count | `def/dimension.md`: "how the current answer for a piece, and its warrant, are read" |
| `standing(a, d)` | whether an actor's acts count on a dimension | `def/act.md`: "yes or no before any question of quality" |
| `shares(a, b)` | whether two actors share an inheritance, so that their acts are one line | `def/actor.md`: "Non-independence travels with what was inherited" |
| `review_reads(k)` | what a read of an assembly of kind k relies on in what it holds | `def/segment.md`: "reads what the kind or the reference kind says it reads" |

## 3. Types

- **Id**: minted, never reused. (`def/segment.md`: "minted at creation and never reused")
- **Segment**: a *veritoid* (kind, content, references) or an *assembly* (kind, ordered slots). (`def/segment.md`: "or an assembly of slots")
- **Slot**: suggested | promised | filled by holding an id | filled by pointing at an id | gap. (`def/segment.md`: "by a segment the assembly **holds**")
- **Reference**: kind, target id, optional needed warrant. (`def/reference.md`: "optionally the warrant it needs")
- **Version**: of a veritoid, a hash of normalized content and of its references as written; of an assembly, of its slots, their states and which id fills each. (`def/veritoid.md`: "of its references as written"; `def/segment.md`: "does not cover the versions of what fills them")
- **Read**: an id at a version; or a piece's warrant on a dimension; or which ids fill one slot. (`def/act.md`: "only which segments fill one slot")

## 4. The record

An ordered, append-only log of two sorts of entry.

**Write** (a segment changeset): by an actor; a whole new written state of one freestanding segment and everything it holds; with the author's affirmations. (`def/changeset.md`: "whole new written state of one freestanding")

**Act**: by an actor; with its reads; with what it concerns (a subset of its reads, or an earlier act). (`def/act.md`: "a subset of what it read") One of:

| act | carries | how long it counts |
|---|---|---|
| check | dimension, means, criterion fixed first or not, outcome: confirmed, narrowed, contradicted | confirmed: while every read is unchanged. narrowed or contradicted: until answered or overturned |
| finding | dimension | until answered or overturned |
| testimony | a stated fact | does not lapse |
| decision | what it is about (accept, waive, affirm, route, promise, other); its basis is its reads | while every element of its basis holds |
| answering | an earlier narrowing, contradiction or finding; outcome answered or not | as a check |
| carrying | an earlier act, two versions; outcome equivalent or not | as a check |
| contesting | an earlier act; outcome overturned or upheld | as a check |
| amending | the actor's own earlier act, weakened | permanent |

(`def/act.md`: "It stays owed until it is **answered**"; "Four acts concern an earlier act"; `def/decision.md`: "stands** while its basis holds")

## 5. The fold

`state(n)` is computed from the first n entries and nothing else. From it:

- `binds(c, n)`: confirmation c has every read unchanged at n, or each change is covered by a carrying act judged equivalent that itself binds. A read of a warrant fails only when that warrant falls. (`def/act.md`: "lapses only when that warrant *falls*")
- `open(b, n)`: a narrowing, contradiction or finding b has no answering act with outcome *answered* by an actor that does not share an inheritance with the author of any write to the piece since b, and no contesting act that overturned it. If the piece was retired, b is open against its descendants. (`def/act.md`: "Asked by someone other than the author of the repair"; `def/veritoid.md`: "stands against its descendants")
- `stands(d, n)`: decision d has every basis element holding at n: pieces at the versions read (or carried, where the policy allows), warrants not fallen, no open bad news against a ground. Otherwise d is *reopened*. (`def/decision.md`: "reopened exactly when its recorded basis fails")
- `warrant(p, d, n)`: `read_as(d)` over the acts that bind or are open and concern p, counted along lines that do not share an inheritance or a read source. (`def/dimension.md`: "Evidence adds only along independent lines")
- `effective(p, d, n)`: where d caps along a reference kind, the least of `warrant(p, d, n)` and the effective warrants of the targets, a missing target lowest. (`def/dimension.md`: "the least of its own warrant and the effective warrants")
- `in_canon(p, n)`: an accepting decision for p exists and has not been withdrawn. `settled(p, n)`: it stands. (`def/segment.md`: "still in canon, and owed")
- `frontier(n)`: the set of items in §6, each with the entry that caused it.
- `scope(c, n)`: for an open atomic changeset c, every segment it has written or that has an item it caused. (`def/changeset.md`: "every segment it has written or that has a")
- `steady(R, n)`: no unwaived item's piece or cause lies in the set of segments R.

## 6. Frontier items, and the only ways out

Only pieces in canon owe. (`def/frontier.md`: "Only canon owes")

| item | holds when | leaves the frontier only by |
|---|---|---|
| contradicted / narrowed / found | open bad news against a piece in canon | an answering act (answered) by a non-sharing actor; a contest that overturns |
| overclaimed | content speaks of a standing above the warrant | a write saying less; acts that raise the warrant |
| unbacked | content reports a decision not on record | the decision; a write saying less |
| reopened | a decision canon rests on does not stand | its party sustaining, deciding again, or withdrawing; a carrying act where policy allows |
| stale | a reference's target is not as last seen | the author's affirmation; a write re-pointing |
| dangling | the target does not exist | a write of the target; a write re-pointing or dropping |
| unmet | the target's warrant is below what is needed | acts raising it; a write needing less |
| unfilled | a promised or required slot has nothing accepted | a write and an acceptance; withdrawal of the promise |
| raised | a question put to a piece has no answer | an act by the dimension's producer or the assigned seat |

A waiver covers an item and removes nothing. (`def/frontier.md`: "it stays owed, and stays shown")

## 7. Refusals

A write is refused, and the state unchanged, when an inner dependent is neither changed nor affirmed; when it would make a cycle along a reference kind some dimension caps along; when it names an id it does not hold and is not moving. (`def/changeset.md`: "refused, not owed")

## 8. Properties to prove, or to break

**K1. Replay (all).** `state(n)` and `frontier(n)` are functions of the first n entries. Recomputing gives the same result. (`def/frontier.md`: "computed, never kept")

**K2. Separation (all).** No act changes any segment's written state or version; no write changes any act. (`def/act.md`: "It never changes what is written")

**K3. Exact lapse (all).** A confirmation binds at n if and only if each read is unchanged or carried. Appending a confirming act lapses nothing. (`def/act.md`: "good news never undoes a review")

**K4. Good news adds nothing (policy: `read_as` monotone in confirmations).** Appending a confirmed check to a state adds no frontier item.

**K5. Bad news survives writes (all).** If b is open against p at n, then for every sequence of writes after n, with no answering or contesting act, b is open against p or its descendants. In particular rewording p, and retiring p and minting a replacement, do not clear it.

**K6. No unlisted exits (all).** For each item kind, an item present at n and absent at n+1 implies entry n+1 is one of the kinds in §6's last column for that item. This is the property each cold read found a new violation of; it should be stated per item and checked exhaustively at small sizes before it is proved.

**K7. Reopening is exact (all).** A decision is reopened at n if and only if some basis element fails at n. A write that touches nothing in the basis reopens nothing.

**K8. The cap has one solution (all).** On any state the refusals of §7 allow, `effective` is uniquely determined. (`def/reference.md`: "the cap has one solution only on an acyclic graph")

**K9. Identity (all).** No id is minted twice. One version names one written state for the whole log; restoring earlier content restores the earlier version and what bound to it. (`def/veritoid.md`: "restores the earlier version")

**K10. Only canon owes (all).** Every frontier item's piece is in canon, or the item is on a reference or slot written in a piece in canon.

**K11. Holding is not resting (policy: `rests_on` excludes slot filling).** A write to a held or pointed-at part changes the settledness of an assembly only if it changes something `review_reads` says the assembly's accepting read relied on.

**K12. Scopes are local (policy: as K11).** If two open changesets have disjoint scopes at n, then entries belonging to one neither add nor remove an item of the other, and when one has no unwaived items the verisectorium is steady on everything outside the other's scope. Find the smallest policy change that breaks this; one is known (an assembly resting on its required parts).

**K13. Meeting merges (all).** If an entry makes a piece in one scope rest on, or be written with, a piece in the other, neither changeset can close before the union has no unwaived items.

**K14. Retirement (all).** A source is retired at n if and only if every chunk has a routing decision that stands at n. (`def/segment.md`: "while every chunk has a routing decision that stands")

**K15. Path-dependence, stated (all).** Two pieces with identical acts and content differ in owing only by whether an accepting decision was ever made. Characterize exactly which histories this distinguishes. (`def/segment.md`: "one that was once accepted owes and one that never was does not")

## 9. Questions the formal work is asked to answer

1. Which of K1–K15 hold for every policy, and for the others, what is the weakest condition on the policy?
2. Run the three candidate `accepts` policies (party decision; rule over warrants; placement in the canonical projection) through K4, K6, K12 and K15. Where do they differ?
3. Is §6's exit list complete? Any counterexample is a cheap exit.
4. Is there a state §7 allows in which two changesets that share no reference contradict each other and both close? (Core says yes and calls it a gap; a smallest witness would be useful.)
5. Does carrying compose? If a is carried across e1 and then e2, each judged equivalent, what may be concluded about a at the end, and is a cap on carries needed for K3?

## 10. What to bring back

For each property: proved, tested to what bound, or a counterexample with its smallest trace. Every place this spec had to be changed to be formalized, as a finding against the def it cites. Nothing learned here is a fact about the model until it has been adjudicated in core.
