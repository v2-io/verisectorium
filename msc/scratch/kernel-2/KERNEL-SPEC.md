# Kernel spec, draft 4

*2026-11-10. By the lead (Fable 5.2). Not part of core. Earlier drafts are in git (`bdf5e71`, `f642167`, `9305775`). Draft 3 was built twice (`ada/ACCOUNT.md`, `ocaml/ACCOUNT.md`); both accounts were read whole, and `msc/notes/23` is the synthesis this draft follows. Choices of mine that nothing has adjudicated are marked **[lead]**.*

## 0. What changed from draft 3

Draft 3 had no order: a state was a free selection, and facts were a set. Both builds found what that costs. Nothing can be answered once (a defect must be met again at every version for ever), and a wrong finding cannot be undone. Joseph, the same evening: "there should be causal ordering, fwiw, definitely a clock and an addative base--- event sourcing style ---  but one that allows multi-step serial parts to be part of a logically simultaneous change and that distinct from the steady-state checkpoints *AND* the ability to rewind / unstage / fork at a checkpoint".

So:

- **The base is events, each with a time, only ever added to.**
- **A line is a sequence of events; work is a fork from a checkpoint; a fork can be rewound or abandoned.**
- **Evidence belongs to the base, not to a line**, because it is about immutable versions and stays true wherever those versions are. Writes and decisions belong to the line they were made on.
- **A state is read from a line.** Everything draft 3 computed from (selection, facts) is still computed from exactly that; the line is where the selection, the order of a piece's versions, and the decisions in force come from.
- **Canon is by placement.** Joseph: "canon is whatever the verisectorium says it is-- usually the main outline's non-provisional slots", with possibly several outlines marked as roots. What a root additionally asks of the pieces it reaches is that root's to declare.
- **Four rules from the builds are now part of the spec** (§2): obligations are unconditional; evidence records what it read; a slot may require a filler but not a consistent one; a decision about a piece at a version holds only at that version.
- **Carried over unchanged**: versions, the four kinds of fact, the constraints as a function of the state. The Ada proofs of draft 3's Q4, Q5 and Q6 are about that function and should need little.

## 1. Scope

In: events, lines, forks, checkpoints; versions; evidence, same, decisions; canon by roots; the constraints; stationarity; closing a fork.

Out: who made an event and whether that matters (every event counts); importance; "better"; renderings; changes to the ontology; normalization; intake's cut.

## 2. Parameters (an ontology, as a bounded table)

- **Kinds.** Veritoid kinds: the dimensions each opens. Assembly kinds: named slots (what fills each, required or not), inner dependencies between slots.
- **Dimensions.** An ordered set of warrants with a bottom (*never asked*); `read_as`, monotone in evidence that holds; which reference kinds it caps along.
- **Reference kinds.** Whether a piece rests on its target through it; what of the target it relies on (existence, assertions, everything); whether a dimension caps along it. A slot's pointing is a reference kind relying on existence only **[lead]**.
- **What a root asks.** For each canon root (an assembly kind): for each kind of piece it reaches and each dimension, the least warrant it requires, possibly none. A decided dimension ("accepted by these people") is asked for the same way.

Fixed by the spec, from the builds:

- A **raise**, **promise**, **waive** or **set aside** decision has no conditions. It holds until withdrawn.
- **Evidence has reads**: other pieces at versions, each with how far it was relied on. A check of a whole that read two parts is one fact with two reads.
- A required or promised slot needs a filler in canon. It does not need the filler to be consistent.
- An **accept** or **affirm** decision about p@v has "p is at v, or at a version **same** for this decision" among its conditions.

## 3. Objects

**Id**, **descent**, **version**: as draft 3 §3. A slot is empty, or holds an id, or points at an id, and carries a **provisional** flag. (`def/segment.md`: "minted at creation and never reused"; `def/veritoid.md`: "of its references as written")

**Event.** Every event has a time; times are totally ordered. Three sorts.

| event | belongs to | says |
|---|---|---|
| **write** | a line | a new version of one id becomes the selected one; or an id is minted; or retired, with what it descends to. A write of an assembly sets its slots |
| **evidence**(p@v, d, criterion, outcome, reads) | the base | piece p at version v, on dimension d by this criterion, holds, fails, or holds in part, having read these |
| **same**(x@v, x@w, for f) | the base | for the purposes of evidence or decision f, versions v and w of x do not differ |
| **decision**(kind, subject, conditions) | a line | accept, affirm, promise, waive, raise, set aside (an evidence or same event), mark root, unmark root, withdraw (a decision) |

**Line.** A finite sequence of write and decision events in time order. The **main line** is one line. A **checkpoint** is a marked position on the main line. A **fork** is a line that shares the main line's events up to some checkpoint and then has its own.

**The state of a line** is: the selected version of each id (its latest write on the line, unless retired); for each id, the order in which its versions were selected on the line; the decisions on the line not withdrawn; the canon roots marked on the line; and all evidence and same events in the base up to the line's latest time. (`def/steady-state.md`: "nothing there rests on anything that is")

**Canon.** A piece is **asserted** in a state when it is reachable from a marked root through filled slots not flagged provisional.

## 4. Derived, for a state

As draft 3 §4, with these changes.

- Evidence e about p@v **applies** when p is selected at v, or at a version reachable by **same** events for e; and each of e's reads is as it was, as far as relied on, or reachable by **same**; and no **set aside** decision about e is on the line.
- **Guards, with order.** A finding (evidence that fails or holds in part) against p at a version v the line once selected leaves a guard on p's later versions on the line. The guard is **met**, for good, by evidence on the same criterion that holds at any version of p the line selected at or after v, provided that evidence applied when recorded. After that, later versions carry no guard from that finding. Selecting v itself again brings the finding back, since it is about v. Guards pass to descendants of a retired id as in draft 3.
- A reference to a retired id does not resolve through descent. It is dangling until re-pointed. (`def/reference.md`: "never silently redirected")
- **Consistent**: greatest fixed point, as draft 3, over the pieces asserted in the state.

## 5. The constraints

Each is about one asserted piece in one state. Changes from draft 3 are marked.

- **C1. Shape.** As draft 3, stated of the assembly: no id is held by two selected assemblies.
- **C2. Looked at together.** As draft 3; met by an affirm decision or by evidence about one filler that read the other.
- **C3. References resolve.** To a selected id. *(No redirect.)* No capping cycle.
- **C4. References reconciled.** As draft 3. Switch: a write of p counts as affirming p's references as they then stood.
- **C5. What its roots ask.** *(Replaces the three standards.)* For every root that reaches p and every dimension that root asks of p's kind: p's effective warrant is at least what is asked. And everything p rests on is asserted and consistent, or relied on for existence only.
- **C6. Not known wrong.** No finding applies at the selected version; no guard is unmet. *(Guards as §4. A conflict needs no clause of its own.)*
- **C7. Says no more than is so.** As draft 3.
- **C8. Needs met, slots filled.** Needed warrants as draft 3. A promised or required slot is filled by a piece in canon. *(Not "consistent".)*
- **C9. Questions answered.** For each raise on the line about p on d: evidence on d that applies to p and is later than the raise.

The **frontier**, **waive**, and **stationary on** a set of pieces: as draft 3 §5. A waived instance does not make its piece inconsistent for the purposes of what rests on it **[lead; draft 3 had it spread]**. Stationary **for a root** is stationary on everything that root reaches.

## 6. Change

- **Fork.** Start a line at a checkpoint.
- **Work.** Append writes and decisions to the fork. Evidence and same events go to the base.
- **Rewind.** Drop the fork's events after some point. The dropped events stay in the base; they are on no line.
- **Close.** A fork whose state is stationary, for every root, may be closed: its events since the checkpoint are appended to the main line and a new checkpoint is marked. From the main line's side this is one step from one checkpoint to the next. (`def/changeset.md`: "follows from one disturbance")
- **Close after the main line has moved.** If other forks have closed since this one began, it may close when its events and theirs do not meet (§7, R9); otherwise it must be reworked on the new checkpoint.

An **atomic changeset** is what lies between two consecutive checkpoints.

## 7. Properties

For every ontology of §2, or under a stated condition, or with a smallest counterexample.

- **R1. A state is a function of its line and the base.** Two lines with the same events have the same state and frontier.
- **R2. Abandoned work is inert, except for what was learned.** Events dropped by a rewind, and events of a fork never closed, change nothing in any other line's state, apart from evidence and same events, which are in the base.
- **R3. Going back.** After a rewind to a point, the state differs from the state when that point was first reached only by evidence and same events recorded since. Characterize when a state that was stationary is not stationary after returning to it.
- **R4. Answered once.** A finding against p at v, met by evidence that holds on its criterion at a later version on the line, puts no guard on any version after that, with no further events. Re-selecting v brings it back. *(Draft 3 needed one fact per finding per edit.)*
- **R5. A wrong finding has a way out that leaves the piece alone.** A set aside decision about the finding clears it without a write. Characterize what a set aside can and cannot remove.
- **R6. Good news does no harm.** Draft 3's Q4 with its three conditions now built in. Re-prove; say whether any condition can be dropped now.
- **R7. Consistency is well defined.** Draft 3's Q6. With obligations unconditional, the greatest fixed point exists; re-prove, and say whether it is now unique.
- **R8. A defect survives recorded recuts.** Draft 3's Q5 with ordered guards. The unrecorded-replacement hole is known; state it.
- **R9. Forks compose.** Two forks from one checkpoint: characterize exactly when both can close, in either order, to the same state. Draft 3's finding was that they fail to compose only where they select different versions of one id, or one's evidence read what the other rewrote. Is that still the whole of it?
- **R10. Canon by roots.** A piece reached by two roots is held to what both ask. Unmarking a root removes its items and nothing else. A piece flagged provisional in every slot that reaches it has no items, and bad news against it is still visible (as a stated condition: compute these).
- **R11. Checkpoints.** Every checkpoint's state is stationary for every root marked there. Closing preserves this.
- **R12. Locality.** Draft 3's Q7 on the wider reading both builds found. With no redirect through descent and C1 stated of the assembly, is the reading narrower again?

## 8. The five invented moves

Each as a fork from a checkpoint that closes. `impl-a-finding-is-answered` step 4 (a wrong finding, the piece untouched) and the whole reads in `impl-a-small-move` and `impl-an-outline-fills-in` could not be said in draft 3 and should be sayable now. Say for each whether it is.

## 9. What to bring back

Per property: proved, tested to what bound, or a smallest counterexample. What of the draft-3 build carried over unchanged, and what had to be rebuilt. Every place this draft had to be read one way to be built. Nothing learned here is a fact about the model until it has been adjudicated in core.
