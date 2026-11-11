# Kernel spec, draft 3

*2026-11-10. By the lead (Fable 5.2). Not part of core. Drafts 1 and 2 are in git (`bdf5e71`, `f642167`); both audits of draft 1 are beside this file and are still worth having open, since most of what they found is why this draft has the shape it has. What changed this time is Joseph's, from three remarks made while draft 2 was being written. Choices of mine that core has not adjudicated are marked **[lead]**.*

## 0. What changed, and whose it is

Joseph, 2026-11-10, on the layer of named acts (accept, answer, carry, repair): "it feels like it's not principled--- like it's a layer of heuristical practices on top of what should just be 'this perturbation makes these things now inconsistent-- and it isn't stationary until it's all consistent again'". On the record: "the idea that everything is append-only is flawed as well. Whenever stationary-- absolutely … an atomic changeset is append-only. But when it is nonstationary … there needs to be the ability to try it several different ways … back up, undo all of that work that was going to be a deadend, and stabilize the right way." On acts: "the emphasis on 'acts' has de-emphasized the idea of 'logically simultaneous changes' that are sequentially applied". And: standing "should be its own separate concern completely so we can make it initially 'any' for all acts in order to get the actor-identity-agnostic machinery working".

Drafts 1 and 2 folded an ordered log of writes and acts, so every intermediate step of a repair was a state of the model, the only way back was forward, and each way of restoring consistency had become a named act with its own rule. This draft has no log and no fold:

- **Versions are immutable. Facts are about versions, and only accumulate.** A fact about a version stays true of that version whatever is done next.
- **A state is a selection**: which pieces, each at which version. It is not a position in a history. It may be moved anywhere, any number of times.
- **Consistency is a set of constraints on a selection, given the facts.** The frontier is the constraints violated. Stationary is none violated.
- **An atomic changeset is a pair of stationary selections**, with the facts gathered between. It is one logical instant however it was assembled. The sequence of them is the only thing that is append-only.
- **Work is free.** Between two stationary selections any candidate may be tried, abandoned or gone back from. What a dead end leaves behind is facts about versions nothing selects.
- **Who did something is not in the kernel.** Every fact counts. Standing and independence are a filter over the facts, to be added as a later layer and left open here.

The acts that drafts 1 and 2 named are not primitives. Each is one of two facts in a particular situation, as §3 shows.

## 1. Scope

In: versions; facts; selections; the constraints; stationarity; atomic changesets and how they compose.

Out, deliberately: actors, standing, independence, seats, means, importance; "better"; renderings; changes to the ontology; normalization; intake's cut.

## 2. Parameters (an ontology, as a bounded table)

- **Kinds.** A veritoid kind: the dimensions it opens. An assembly kind: named slots (what fills each, one or many, required or not), inner dependencies between slots, and what a view of the whole relies on in each filler (existence, assertions, everything).
- **Dimensions.** An ordered set of warrants with a bottom (*never asked*) and meets; `read_as`, from the evidence that applies to a (warrant, conflict flag); which reference kinds it caps along.
- **Reference kinds.** Whether a piece rests on its target through it; what of the target it relies on (existence, assertions, everything); whether a dimension caps along it.
- **The standard for canon** (§5, C5): what must be true of a piece for the verisectorium to assert it. Three shapes are to be run side by side: a decision about the piece; a rule over its warrants; nothing beyond being placed.

## 3. Objects

**Id.** Minted once, never reused. A **descent** relation on ids records recuts: a split, a merge, a replacement. (`def/segment.md`: "minted at creation and never reused")

**Version.** An immutable written state of one id. For a veritoid: opaque content; the assertion it carries on each dimension its kind opens; any claims its content makes about how well some piece stands; any decisions it reports; its references (kind, target id, optional needed warrant). For an assembly: its slots, each empty, holding an id, or pointing at an id. Versions are never changed; a rewrite is a new version of the same id. (`def/veritoid.md`: "of its references as written")

**Fact.** One of four. The set of facts only grows.

| fact | says |
|---|---|
| **evidence**(p@v, d, criterion, outcome) | on dimension d, asked by this criterion, piece p at version v was found to hold, to fail, or to hold in part |
| **same**(x@v, x@w, for f) | for the purposes of fact f, versions v and w of x do not differ |
| **decision**(kind, subject, conditions) | a choice about a subject (a piece at a version, a slot, a reference at two versions, a constraint instance), good while its stated conditions are true of the selection. Kinds used here: accept, affirm, promise, waive, raise |
| **withdrawn**(decision) | that decision is no longer offered |

What the earlier drafts called by other names:

| earlier name | here |
|---|---|
| a check, a run | evidence, outcome holds |
| a finding, a narrowing, a contradiction | evidence, outcome fails or holds in part |
| lapsing | no **same** fact reaches the selected version |
| carrying | a **same** fact |
| answering | evidence on the same criterion at the selected version, outcome holds |
| contesting | evidence on the same criterion at the same version with the other outcome: a conflict (C6) |
| reopened | a decision whose conditions are not true of the selection |
| sustaining | a new decision with conditions that are |
| settled, unsettled | whether C5 holds for a piece |

**Selection.** A finite set of ids, each at one of its versions, with a subset marked **asserted**: the canon. Any selection may be considered. Which pieces are asserted is part of the selection, chosen like everything else in it; what justifies asserting a piece is constraint C5. **[lead]** (`def/segment.md`: "still in canon, and owed")

## 4. Derived, for a selection σ and a set of facts F

- An evidence fact e about p@v **applies** in σ when σ selects p at v, or at a version reachable from v by **same** facts for e. If p is not selected and has descendants that are, e's *criterion* passes to them (below), not its outcome.
- A decision **holds** in σ when it is not withdrawn and each of its conditions is true of σ. A condition is one of: this piece is selected at this version, or at one **same** for this decision; this piece's warrant on d is at least w; this piece is asserted and consistent; this slot is filled as stated.
- `warrant(p, d)`: `read_as(d)` over the evidence applying to p on d. `effective(p, d)`: the meet of that with the effective warrants of the targets p references along kinds d caps along; a target not selected is bottom.
- **Guards.** If any evidence fact with outcome *fails* or *holds in part* exists about p at any version, or about any id p descends from, its criterion is a **guard** on p. **[lead]** This is the one place a choice is built in: a defect once found is presumed present in later versions until looked for and not found. It is what draft 2's asymmetry between good and bad news came to; here it is a constraint (C6) and can be switched off to see what it buys.
- p **rests on** q when p references q by a kind that rests, or a decision that C5 relies on for p has a condition about q.
- p is **consistent** in σ when no instance of C1–C9 about p is violated and everything p rests on is consistent, or is relied on for existence only. Greatest fixed point: pieces resting on one another in a cycle are consistent together unless one has a violation of its own.

## 5. The constraints

Each is a condition on σ given F, and each instance is about one asserted piece and what that piece reads. Pieces not asserted have no instances.

- **C1. Shape.** Every selected id held by an assembly is held by exactly one; every assembly's slots conform to its kind.
- **C2. Looked at together.** For each inner dependency of an asserted assembly's kind, from slot a to slot b: an **affirm** decision, or evidence, exists for the filler of a at its selected version against the filler of b at its selected version (or versions **same** for it). This is "changed or affirmed" without an order of events: whoever last touched either side looked at the pair. (`def/changeset.md`: "refused, not owed")
- **C3. References resolve.** Every reference of an asserted piece has a selected target, or one selected descendant of it. No cycle along a kind some dimension caps along.
- **C4. References reconciled.** For every reference of an asserted piece p to q, by a kind that relies on more than q's existence: an **affirm** decision exists for (p at its selected version, q as far as the kind relies on it at its selected version), up to **same**. A version of p written against q counts as its own affirmation of what it was written against **[lead]**.
- **C5. The standard for canon.** For each asserted piece, per the ontology: an **accept** decision about it holds; or the rule over its warrants is true; or nothing (placement). And everything it rests on is asserted and consistent, or relied on for existence only.
- **C6. Not known wrong.** For each asserted piece and each dimension: no evidence with outcome *fails* or *holds in part* applies; every guard on the piece has evidence on that criterion with outcome *holds* applying; and no two applying evidence facts on one criterion disagree.
- **C7. Says no more than is so.** Every claim an asserted piece's content makes about how well a piece stands is at or below that piece's effective warrant; every decision it reports holds.
- **C8. Needs met, promises kept.** Every reference's needed warrant is at or below its target's effective warrant. Every slot with a **promise** decision that holds, and every required slot, is filled by an asserted, consistent piece.
- **C9. Questions answered.** For each **raise** decision that holds, about p on d: evidence on d applies to p.

The **frontier** of σ is the set of violated instances. A **waive** decision about an instance, holding in σ, marks it covered and removes nothing. σ is **stationary on** a set of pieces when no uncovered violated instance is about any of them or about anything they rest on. (`def/steady-state.md`: "nothing there rests on anything that is")

## 6. Change

An **atomic changeset** is (σ, F) → (σ′, F′) with F ⊆ F′, where σ and σ′ are each stationary on the pieces whose selection or consistency differs between them. It has no inside. However many candidates were tried on the way, and in whatever order facts were gathered, the changeset is the pair. (`def/changeset.md`: "follows from one disturbance")

The **steady record** is the collection of closed atomic changesets, ordered where one's σ is another's σ′ on some piece. Only this is append-only.

A **perturbation** is anything that makes the present selection non-stationary: a new fact (evidence that fails; a withdrawal), or a wish to select differently (new material; a rewrite). Work is the search for a σ′ and for the facts under which it is stationary.

## 7. Properties

For every ontology, or under a stated condition; or a smallest counterexample.

- **Q1. No history.** The frontier is a function of (σ, F) alone. Two ways of arriving at the same selection with the same facts cannot differ.
- **Q2. Dead ends are inert.** A fact about a version from which no **same** chain reaches a selected version, and which is not a guard on a selected piece, changes nothing in the frontier of σ. So abandoning an attempt costs nothing and hides nothing.
- **Q3. Going back.** If σ was stationary under F, then under any F′ ⊇ F it is stationary again exactly when no fact in F′ ∖ F violates a constraint at σ. Whatever was tried, the way back is open, except that what was learned about the old state stays learned.
- **Q4. Good facts do no harm.** Adding evidence with outcome *holds*, a **same** fact, or an accept, affirm or promise decision never adds a violated instance, with one exception to pin down: a promise adds a C8 instance. State the exact condition on `read_as`.
- **Q5. A known defect cannot be selected away.** With guards on: if evidence that fails exists about p@v, no σ′ that asserts p, or any descendant of p, at any version is stationary unless evidence that holds on that criterion applies there. Rewording, splitting and replacing do not shed it. Dropping p from what is asserted does, openly, and then C3 and C5 fall on whatever rested on p.
- **Q6. Well defined.** `effective` is unique on every selection satisfying C3. Consistency's greatest fixed point exists and is unique.
- **Q7. Locality.** Each constraint instance reads a bounded neighbourhood: the piece, what it references as far as the kinds rely, what it rests on. So for two sets of pieces closed under that reading and not meeting, the frontier on their union is the union of their frontiers.
- **Q8. Changesets compose.** If two atomic changesets from the same stationary σ change pieces in closed sets that do not meet, applying both gives a stationary selection, in either order, and it is the same one. Characterize when the closed sets of two changes meet, and in particular what a canonical outline pointing at everything must rely on (existence, assertions, everything) for two repairs in different documents not to meet through it.
- **Q9. The three standards for canon.** Run C5 as a decision, as a rule, and as placement. For each: what a new assertion costs to make stationary; what a rewrite of an asserted piece requires; whether any admits a stationary selection the others would call inconsistent. Under *placement* nothing gates assertion but C6–C8, which is the reading under which Joseph's asf question has its sharpest form.
- **Q10. Switches.** Guards off: exhibit the smallest stationary selection that asserts a reworded piece with a known, unexamined defect. C4's "written against counts as affirmed" off: count the affirmations a one-word edit then requires.

## 8. What the five invented moves in `core/src/` should look like here

Each should be expressible as one atomic changeset (or two), with the work in between being selections and facts. Say for each whether it is, and what, if anything, it shows that this draft cannot say. The second half of `impl-two-moves-at-once` (two repairs that come to depend on each other) is Q8's meeting case.

## 9. What to bring back

Per property: proved, tested to what bound, or a smallest counterexample. Every place this draft had to change to be built, as a finding. Whether anything the earlier drafts could express, and that matters, has been lost by removing the log; both audits' lists are the place to check against. Nothing learned here is a fact about the model until it has been adjudicated in core.
