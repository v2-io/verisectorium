# Kernel spec, draft 2

*2026-11-10. By the lead (Fable 5.2), revised from draft 1 after two audits against `core/` at `89b04af`: `ada/SPEC-AUDIT.md` and `ocaml/SPEC-AUDIT.md`, both read whole. Not part of core. Where this spec and a def disagree, that is a finding to bring back. Where core has not chosen, this draft either makes the choice a **switch** to be run both ways, or makes it and marks it **[lead]**: a choice made for the formal work, not yet adjudicated in core, and not Joseph's.*

## 0. What changed from draft 1, and why

Both audits found the same fault at the root: draft 1 computed every frontier item as a function of the current state, and separately listed the entries by which each item may leave. Core says both things too. Wherever they differ, an item can stop being computed without the named party having acted. So:

- **Every item is a pure function of the state. The exit table is an output of this work, not an input.** §7 gives the exits core intends, as a hypothesis. The work derives the real table per policy and sets the two side by side; each difference is a cheap exit or a mistaken intention.
- The fold now uses every parameter it declares, has entries for everything the items depend on, and says which fixed point each recursive definition takes.
- The properties that restated definitions are replaced by the statements that were meant.
- The spec is layered, so a result about a lower layer does not wait on a guess in an upper one.

## 1. Scope

In: the record; ids, versions, recuts; reads; evidence and how long it counts; decisions and their bases; canon; references and the cap; frontier items; regions and steadiness.

Out: orientation of actors; importance and agreement among seats (a decision has one party here); "better"; renderings; changes to the ontology; what normalization of content is; the cut of a source.

## 2. Parameters

An ontology, here a value (a bounded table, not code), so that a result can be stated for every ontology satisfying a condition.

| parameter | what it gives |
|---|---|
| kinds | for a veritoid kind: which dimensions it opens. For an assembly kind: its named slots, each with the kind that fills it, one or many, required or not; inner dependencies between slots; `review_reads`: what a read of the whole relies on in each filler (nothing, its assertions, or its whole version) |
| dimensions | found out or decided; an ordered set of warrants with a bottom (*never asked*) and meets; `read_as`: from the acts that count to (answer, warrant), required monotone in confirmations for K4; which reference kinds it caps along; which dimension of a target it reads when the target's kind does not open this one; whether its decisions may be carried |
| reference kinds | for each: whether a piece rests on its target through it; whether it relies on the target's existence only, its assertions, or its whole version; whether anything caps along it |
| `standing(a, d)` | whether an actor's acts count on a dimension. Static here; losing standing is out of scope and said so |
| `shares(a, b)` | whether two actors share an inheritance. Required reflexive and symmetric. **Switch S5**: an equivalence, or not transitive with lines counted as the largest set of pairwise non-sharing acts |
| `same_party(a, b)` | whether two actors hold the same seat |
| `accepts` | **Switch S1**, three policies, each defined in §5 |
| the canonical projection | an assembly id |

(`def/dimension.md`: "how the current answer for a piece, and its warrant, are read"; `def/segment.md`: "reads what the kind or the reference kind says it reads"; `def/actor.md`: "Non-independence travels with what was inherited")

## 3. Types

- **Id**: minted once, never reused. **Version**: immutable; one version names one written state for the whole log. (`def/segment.md`: "minted at creation and never reused")
- **Veritoid**: kind; opaque content; and, beside the content and hashed with it, what the kernel must see of it: the assertion it carries on each dimension its kind opens; any **standing claims** (piece, dimension, level) its content makes; any **reported decisions**; its references. (`def/veritoid.md`: "of its references as written")
- **Reference**: kind, target id, optional needed warrant on a named dimension.
- **Assembly**: kind; slots. A **slot** has an identity (the kind's slot name and a position), and holds: a note (suggested), or a held id, or a pointing reference, or nothing. A gap is a slot with no kind. Its version covers the slots and which id fills each, not the fillers' versions. (`def/segment.md`: "does not cover the versions of what fills them")
- **Read**, one of: an id at a version; a piece's assertion on a dimension, at a version; a piece's warrant on a dimension, at the value read; which ids fill one slot; an assembly **as reviewed**: its version together with, for each filler, what `review_reads` says. (`def/act.md`: "only which segments fill one slot")

## 4. The record

Append-only, ordered. Three sorts of entry.

**Write.** By an actor. A new written state of one freestanding segment and everything it holds; or, for a move, of the two freestanding segments a held piece moves between **[lead]**. It carries: the new states; **retirements**, each naming the ids the retired id descends to (a held piece dropped with no successor descends to its holder **[lead]**); new ids minted; and affirmations of inner dependents. (`def/changeset.md`: "whole new written state of one freestanding")

**Evidence**, by an actor, with reads and what it concerns:

| act | carries |
|---|---|
| check | dimension, means, criterion-first flag, outcome: confirmed, narrowed, contradicted |
| finding | dimension; a **relayed** flag |
| testimony | nothing the kernel reads |
| answering | an earlier narrowing, contradiction or finding, and the version of the piece it read; outcome answered or not |
| carrying | an earlier act, a read of that act, and two versions of what was read; outcome equivalent or not |
| contesting | an earlier act; outcome overturned or upheld |
| amending | the actor's own earlier check: contradicted becomes narrowed. Nothing else **[lead]** |

**Decision**, by an actor, with its basis (its reads) and its subject:

| decision | subject |
|---|---|
| accept | a segment |
| withdraw | an earlier decision |
| sustain | an earlier decision of the actor's own party, with a new basis |
| affirm | a reference whose target moved, or an unchanged inner dependent (this one rides in a Write) |
| promise | a slot |
| waive | an item |
| raise | a piece and a dimension, assigned to a party |
| route | a chunk; out of scope beyond K13 |

(`def/act.md`: "Four acts concern an earlier act"; `def/decision.md`: "sustains it on the new basis, decides again, or withdraws it")

**Refused entries** (state unchanged). For a write: an inner dependent neither changed nor affirmed; a cycle along a reference kind some dimension caps along; an id it does not hold and is not moving; a held segment written alone; a segment with two holders; an id minted twice or reused. For an act **[lead; core has refusals for writes only]**: reads of a version that never existed; concerns outside its reads; an act about a later or missing act; answering a confirmation; amending another's act; withdrawing or sustaining another party's decision. An act that read a version no longer current is allowed. (`def/changeset.md`: "refused, not owed")

## 5. The fold

Everything below is a function of the first n entries. Recursive definitions say which fixed point.

**Layer 1: evidence, decisions, canon.**

- `counts(e, n)` for an evidence act e: its actor has standing on its dimension; and it is not overturned, where e is overturned if a contesting act with outcome *overturned* concerns it, was made by an actor sharing with neither e's actor nor the last author of what e concerns, and itself counts. Well-founded: an act concerns only earlier acts.
- `carried(r, v, w, n)`: there is a chain of carrying acts that count, each for this act and this read, with outcome *equivalent*, each by an actor not sharing with the author of the write between its two versions, from version v to version w. A carry is a judgment about two immutable versions and does not lapse. Restoring content needs no carry (v = w). (`def/act.md`: "Asked by someone other than the editor")
- `binds(c, n)` for a confirmation c: c counts, and for each read of c: the thing is at the version read, or carried from it to the current one; a warrant read has not fallen below the value read. **Least fixed point**: a loop of confirmations each reading the other's warrant does not bind.
- `open(b, n)` for bad news b (a narrowing, a contradiction, a finding not relayed) against piece p: b counts, and p's current version v is not *covered*. **Switch S3**, what covers:
  - *versioned* (default **[lead]**): some answering act that counts, outcome *answered*, read p at a version w that b did not read, by an actor sharing with no author of a write taking p from what b read to w; and v = w or carried from w to v.
  - *permanent*: such an answer exists at any w.
  - *lapsing*: such an answer exists at w = v only.
  If p is retired, b is open against each id p descends to, at that id's versions. (`def/veritoid.md`: "stands against its descendants")
- `warrant(p, d, n)`: `read_as(d)` over the confirmations that bind and the bad news that is open, concerning p on d, confirmations counted along lines per `shares` and S5, and those with criterion fixed after adding nothing.
- `effective(p, d, n)`: the meet of `warrant(p, d, n)` and the effective warrants of p's targets along kinds d caps along, each read on the dimension the ontology names; a missing target is bottom. `unmet` and `overclaimed` compare against `effective` **[lead]**.
- `stands(D, n)` for a decision D: it is not withdrawn, and **Switch S2**:
  - *computed* (default **[lead]**): every basis element holds at n (a piece is at the version read, or carried where the dimension allows; a warrant has not fallen; a slot's fillers are as read; an assembly is as reviewed). A sustain replaces the basis.
  - *latched*: as computed, but once any element has failed, D stands again only after a sustain by its party.
  - *by maker*: computed for decisions made by rule, latched for decisions made by a party.
- `admitted(p, n)`: p is in canon. A latch under every policy **[lead]**: once admitted, p leaves canon only by a withdraw decision. An id minted as a descendant of an admitted id is admitted **[lead]**. By policy (S1):
  - *party*: an accept decision on p exists.
  - *rule*: the ontology's rule (a condition over p's warrants and over what p rests on) held at some m ≤ n.
  - *placement*: at some m ≤ n, p filled, or was held within a filler of, a slot of the canonical projection not in the suggested state.
- `accepting basis of p`: under *party*, the basis of the latest accept or sustain on p. Under *rule*, the rule's condition evaluated now. Under *placement*, p at the version it had when placed or last affirmed by its placer **[lead; core does not say]**.
- `settled(p, n)`: admitted; its accepting basis holds (per S2); and every piece p rests on is settled, or is relied on for its existence only. p **rests on** q when p references q by a kind the ontology says rests, or p's accepting basis reads q. Holding and pointing are not resting unless the ontology's kind says so. **Greatest fixed point**: pieces that rest on one another in a cycle are settled together unless one of them has a grounded reason not to be. (`def/segment.md`: "Holding and pointing are not resting")

**Layer 2: the items.** Each is a predicate on the state, with an identity that does not include how it came to hold.

| item | identity | holds when |
|---|---|---|
| contradicted, narrowed, found | (piece, the act) | the act is open against the piece and the piece is admitted |
| overclaimed | (piece, the standing claim) | an admitted piece's content claims a level above the effective warrant of the piece it names |
| unbacked | (piece, the reported decision) | an admitted piece reports a decision that is not on record or does not stand |
| reopened | (piece, the failing basis element) | an admitted piece's accepting basis has this element failing, or this piece it rests on unsettled. One item per element |
| stale | (piece, reference) | an admitted piece's reference: the target, as far as the reference kind relies on it, is not as last seen. *Last seen* is the target's state at the latest write that changed the referencing veritoid's own version, or at the author's latest affirm of this reference **[lead]** |
| dangling | (piece, reference) | the target does not exist, or is retired with no single descendant |
| unmet | (piece, reference) | the target's effective warrant is below what is needed |
| unfilled | (assembly, slot) | a promise decision on the slot stands, or the kind requires the slot, and no admitted and settled piece fills it. Read from the decision, not from the slot's written state **[lead]** |
| raised | (piece, dimension, the raising entry) | a raise decision, a relayed finding, or a narrowing of something the piece rests on, with no later act on that dimension concerning the piece and no later write or affirm by the piece's author |

A **waiver** that stands marks its item covered. It removes nothing. An item under a waiver whose own basis has failed is uncovered again.

Only admitted pieces have items. **Stated conditions**, also computed: every waiver; every (admitted piece, determinant dimension) with warrant *never asked*; every piece that is not admitted, fills a slot of the canonical projection, and has open bad news against it. (`def/steady-state.md`: "every provisional piece the canonical projection reaches")

**Layer 3: dependence, regions, steadiness.** No causes and no changeset membership: both audits found neither could be defined from draft 1, and neither is needed.

- Item i **depends on** item j when i holds only because j does: a *reopened* item for (p, q unsettled) depends on every item on q; an *unmet* item depends on the open bad news lowering its target; a *raised* item from a narrowing depends on it.
- An **open region** is a connected component of the uncovered items under dependence, together with the pieces they are on. This is what core calls an open atomic changeset, read from the state. **[lead]** Two regions may have items on the same piece, and on the same hub assembly, without being one region.
- `steady(P, n)` for a set of pieces P: no uncovered item is on a piece of P, and no piece of P rests on a piece that has one. (`def/steady-state.md`: "nothing there rests on anything that is")
- The **footprint** of an entry: what it writes, concerns and reads, closed backward along rests-on, references and review reads.

## 6. Properties

Each is to be proved for every ontology, or for every ontology meeting a stated condition, or broken with a smallest trace. Report per setting of the switches where it matters.

**Layer 1**

- **P1. Incremental equals replay.** A state updated entry by entry equals the fold from scratch.
- **P2. The two atoms stay apart.** No decision changes any found-out warrant. No evidence act makes, withdraws or sustains a decision. (`def/decision.md`: "It warrants nothing about whether what it concerns is true")
- **P3. Good news lapses nothing.** Appending a confirmation, or a carry judged equivalent, or an answer, never makes a binding confirmation stop binding or a standing decision stop standing. Find the condition on `read_as` and on S5.
- **P4. Good news adds no item.** Appending a confirmed check adds no item. Known to be at risk under the rule policy (a confirmation that admits a piece exposes what the piece already owed); find the exact condition. (`def/steady-state.md`: "since nothing becomes owed")
- **P5. Bad news survives writes, at the frontier.** If a contradicted, narrowed or found item holds at n, then after any sequence of writes alone it holds on the piece or on each descendant. Under every S1 policy.
- **P6. Decisions end only by their party or their basis.** Under each setting of S2, characterize exactly which entries make a decision stop standing and which make it stand again.
- **P7. Identity.** No id is minted twice; a version never names two states; restoring content restores what bound to it, and under S3 what was open against it.
- **P8. The cap is unique** on every state the refusals allow, and `binds` and `settled` are well defined (the stated fixed points exist and are unique).

**Layer 2**

- **P9. The derived exit table.** For every item kind, enumerate every kind of entry at which an item present at n is absent at n+1, under each policy and switch. Set it beside §7. This is the main deliverable.
- **P10. No exit by the interested hand.** For bad news against p: no sequence of entries made only by actors sharing with p's authors removes its item. For a reopened acceptance under the party policy: no sequence made only by actors outside its party restores it, except by restoring its basis (S2 computed).
- **P11. Only canon owes, and nothing hides.** Every item is on an admitted piece. Every piece of bad news that counts and is open is either an item or a stated condition, at every state.
- **P12. Path-dependence, characterized.** For each S1 policy, describe exactly the pairs of histories that end in the same written state and the same counting acts and differ in what is owed.

**Layer 3**

- **P13. Disjoint entries commute.** Two adjacent entries whose footprints do not meet may be swapped without changing the state's items or stated conditions.
- **P14. Regions are local.** For a set of pieces closed under footprints, the items on it are a function of the entries whose footprints meet it. And: when an open region has no uncovered items left, the pieces it was on are steady, whatever other regions are open.
- **P15. Hubs.** With a canonical outline pointing at every document: find which settings of the pointing kind's reliance (existence, assertions, whole) and of the outline's `review_reads` keep two repairs in different documents in different regions. The audit predicts that anything beyond existence joins them through the outline; confirm or refute, and find the weakest reading under which an outline still notices a part whose assertion changed.

## 7. The exits core intends (a hypothesis for P9)

| item | should leave only by |
|---|---|
| contradicted, narrowed, found | an answer by an actor not sharing with the repair's author; a contest that overturns; amending contradicted to narrowed moves it between the first two; withdrawal of the piece's acceptance |
| overclaimed, unbacked | a write saying less; acts or a decision making it true; withdrawal |
| reopened | the basis restored (S2 computed) or a sustain; whatever settles the piece rested on; withdrawal |
| stale | the author's affirm; a write that changes the referencing veritoid; a write re-pointing or dropping; the target restored |
| dangling | the target written; re-pointing or dropping |
| unmet | the target's warrant rising; needing less; re-pointing or dropping |
| unfilled | an acceptance of a filler; withdrawal of the promise |
| raised | an act by the producer on that dimension; a write or affirm by the piece's author |

(`def/frontier.md`: "it stays owed, and stays shown")

## 8. Questions for the work

1. P9's table under each of the three `accepts` policies. Where do they differ, and does any admit a cheap exit the others do not? (Draft 1's placement policy let a write to the outline withdraw; here admission latches and withdrawal is always a decision. Is that enough?)
2. S2: what each of computed, latched and by-maker costs in P6, P7 and P10.
3. S3: confirm the three-entry quiet exit under *permanent* and the re-owing under *lapsing*; is *versioned* free of both?
4. P4 under the rule policy: the weakest added clause that restores it.
5. P15.
6. Anything this draft still cannot express that the five invented moves in `core/src/` do.

## 9. What to bring back

Per property and per switch setting: proved, tested to what bound, or a smallest counterexample. The derived exit table. Every place this spec had to change to be built, as a finding against the def or the **[lead]** choice it concerns. Nothing learned here is a fact about the model until it has been adjudicated in core.
