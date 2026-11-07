# Time, acts and changesets: a correction to model-and-lexicon.md

*To Joseph, 2026-11-05, after your note that section 3.1 does not represent the segment changeset and the atomic changeset, "with practical sequentialness but logical simultaneity". You are right. This file replaces sections 3.1, 4.1 and 4.2 of `model-and-lexicon.md` and revises item 1 and item 2 of its Part 9. I have not edited those sections in place, since you may be mid-read; each now carries a one-line note pointing here. Everything below is my proposal [F] unless marked [J].*

## What was wrong

Section 3.1 said: an act is about one veritoid at one version, and the log is a flat list of acts. That is RC1's picture, and it is the very gap RC1's own field trial found ("EVENT attaches to one record … but the common case of a securing act is multi-record"). I carried it into Part 3 and then described changesets in Part 4 as if they sat on top of it. They cannot. If the log is a flat sequence of single-veritoid acts, then "the claim changed" and "the description was brought into line" are two events with an order and a gap between them, and in that gap the store held something nobody ever meant. Logical simultaneity has nowhere to live.

## The picture I should have drawn

**There are two kinds of time, and they must not be mixed.**

- **Steady time.** The store moves from one steady state to the next: S0, S1, S2. Each step is one atomic changeset. Nothing exists between two steady states. All the changes in one atomic changeset happen at the same instant, logically. [J: "simultaneously, logically speaking"]
- **Work time.** The hours and days in which minds actually assemble that step: drafting, checking, re-editing, waiting. It has an order, clock times, and actors. [J: "practical sequentialness"]

A **state** is: which version every veritoid is at. A steady state is one the store has actually been in. While an atomic changeset is being assembled there is also a **working state**: the last steady state plus whatever has been staged so far. It moves as work proceeds. It is never "the theory".

**Three sorts of thing get recorded, not one.**

1. **A segment changeset**: a new state for one segment, replacing the old one as a whole. Its parts have no order among themselves. "Claim first, then description" is a fact about the author's afternoon, not about the store.
2. **An act**: a check, a review, a decision, a crossing. It is performed against a state, steady or working, and it binds to the exact versions it read in that state. It can read many veritoids, in many segments. A whole-segment review reads the whole segment. A review of a whole atomic changeset reads all of it and carries one signature.
3. **An atomic changeset**: the container that takes the store from one steady state to the next. It holds the segment changesets and the acts that belong to that step.

**What "simultaneous" then means, concretely.** If a segment is rewritten three times while an atomic changeset is being assembled, only the last rewrite exists in the next steady state. The first two happened in work time and are kept as a record of the work, but no steady state ever contained them. Likewise an act made early, on a draft that was later changed, simply binds to nothing in the final state. No special rule is needed for that: it read versions that are not there.

Every value is computed **as of a state**. On the steady line that is a steady state. During assembly it is the working state, and the frontier is computed there.

## A worked example

Steady state S0. Segment T holds a formal claim c1, a derivation d1, a description e1 and an eli8 k1. Agent B independently re-derived d1 from c1. Segment U has a claim u1 that is predicated on T's claim at "re-derived or better".

An auditor finds that T's claim needs an extra hypothesis H.

| Work time | What happens | Working state and frontier afterwards |
|---|---|---|
| 09:00–09:25 | Agent A drafts: adds H to the claim (c2), reworks the derivation to use H (d2), re-reads the description and finds it still right, rewrites the eli8 (k2). | Nothing staged yet. Drafts are not changesets. |
| 09:25 | A submits **segment changeset 1 on T**: {c1→c2, d1→d2, e1 affirmed against c2, k1→k2}. One instant, four parts, no order. | B's re-derivation read c1 and d1, so it no longer binds. T's derivation computes as "drafted". T's whole-read has lapsed. U's pointer targets something that moved. U needs "re-derived" and T is now "drafted". **Frontier: four items.** |
| 11:00 | B re-derives d2 from c2. | That act binds to c2 and d2. Frontier: two items fewer. |
| 11:30 | A fixes an error in step 3. **Segment changeset 2 on T**: {d2→d3}. | B's 11:00 act read d2. It no longer binds. Frontier grows back. |
| 12:00 | B re-derives d3 from c2. | Binds to c2, d3. |
| 13:00 | Agent C finds U's claim follows only if U also assumes H. **Segment changeset 3 on U**: {u1→u2, …}. | U's pointer now bound to c2. |
| 14:00 | Whole-reads of T and of U. Frontier empty. | The atomic changeset lands. **S1.** |

What S1 contains, and what the steady history says:
- T's claim went c1→c2. T's derivation went d1→**d3**. Version d2 was never part of any steady state.
- U's claim went u1→u2 at the same instant as T's. There was never a theory in which T had H and U did not.
- The acts that count in S1 are the ones that bind to S1's versions: B's 12:00 re-derivation, the two whole-reads, A's affirmation of e1.
- B's 11:00 re-derivation is in the work record. It binds to nothing in S1. It is still useful: it is part of what the store knows about B as a checker, and it keeps "was this ever checked?" answerable.

## What this does to the write rule (Part 9, item 2)

I had proposed: reconcile each inner dependent, or mark it "not yet reconciled". The second branch was me making room for sequence inside a segment. With the two times kept apart, that room is not needed, and your sentence can stand as you wrote it.

> **A segment changeset is a whole new state of one segment.** For every part that depends on a changed part, the changeset either changes it or carries the author's explicit affirmation that it is still right against the new content. A segment state with a part that is neither is not a changeset. It is still a draft. [J for the rule; F for "changed or affirmed" as its checkable form]

The distinction that makes this workable is between **content** and **values**:

- **Content** is reconciled by the author, inside the changeset, at one instant. The description must say what the new claim says.
- **Values** are not the author's to set. The moment the changeset is staged, every check that read what changed stops binding, and the affected values drop. Earning them back takes further acts, usually by other minds, in work time. That owed work is what the frontier is. [J, 11-04: "a content change would automatically lower the certainty which would effectively trigger the two sides of the adjudication at the same time"]

So "fully coherent and reconciled and correct" applies to content, at once. "Re-derived", "coherent as a whole", "faithful to its source" are values, and they come back one act at a time. An atomic changeset is finished when both are done: the content is consistent everywhere it reaches, and every claimed level is either re-earned or honestly lowered.

The author's affirmation ("e1 is still right") is an attested act by the author. It is not an independent check and never counts as one. Its job is only that nothing is left as it was without someone having looked.

## What this does to "one type or two" (Part 9, item 1)

Working through the example showed me that I had oversold the one-type idea. Your two kinds of changeset presuppose exactly two working levels: parts inside a segment, and segments in the graph. Every rule above is stated at one of those two levels. Nothing in the example needed a part inside a part.

Where I had reached for nesting, a flat reading works as well or better:
- derivation steps: a slot that holds any number of steps;
- ASF's lettered items: a slot that holds any number of items;
- the three "claim record" entries in one ASF derivation: three separate small segments that each describe one claim. ASF's own Line A work already treated them as separate.

So I withdraw the recursion as the working model and keep it only where you put it: as the mathematics. "It might be wise to model it mathematically even if as a practical matter … there is a practical granularity." [J] In practice there are two levels:

- a **leaf** (your atom): content plus its dimensions;
- a **segment** (your instance): a named, ordered set of leaves in declared slots, with its own aliased, derived and own dimensions.

"Veritoid" then goes back to meaning what you meant by it: the leaf. A **kind** still declares both levels, because a segment kind has to say which leaf kinds fill its slots. Two operations keep their meaning: splitting a leaf into several in the same slot when a check shows its pieces move apart, and promoting one or more leaves into a segment of their own.

What I am not sure of: whether a projection (a chapter) is "a segment whose slots hold pointers" or its own third thing. I had it as the former. It behaves like a segment in every way I can find (a name, content of its own, coherence, written as one act), so I have left it.

## Two things this picture leaves open, both already yours

1. **May a finding be visible on the steady line before its consequences are worked?** A check that refutes something is itself a perturbation. If the steady line only moves by complete atomic changesets, the refutation stays invisible until everything downstream is dealt with. RC1 says known-broken must show "immediately, visibly". That is your pondered third option from the dialog, the known-defect mark, and your phrase for what is at stake: "a sort of 'known honesty' orthogonal to internal-consistency / stability". The steady line would then promise two different things, consistent and honestly current, and a marked value is consistent but flagged. I have not gone past where you left it.
2. **Acts with no content change.** A confirming check on a steady state changes a value and touches no content. I am treating it as an atomic changeset of size one, which lands at once because its frontier is empty. A check that breaks something is the same act with a non-empty frontier, which is question 1 again.
