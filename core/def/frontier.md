```kdl
term "frontier" pos=noun pl="-s" {
  avoid "todo list" "a frontier is computed, never typed, and lies only as much as the state it is computed from"
  avoid "obligations" "an earlier word; the items are violated constraints, each with a clearer"
  rel of term="changeset" card="{0,N}" note="the open atomic changesets; every item belongs to the one that caused it"
  rel names term="dimension" card="{0,N}" note="per item: the dimension whose producer can clear it" informal=#true
  rel names term="decision" card="{0,N}" note="per reopened item: the decision and its party" informal=#true
}
status provisional
```

# «frontier»
Everything owed in a working state: every place where what canon says outruns the record, computed fresh after each write or act, each item naming its cause and who can clear it.

## Definition
The frontier is computed for any state, and recomputed after every write or act in an ‹atomic·changeset›: every place where what canon says outruns the record. The items are:

| item | what has outrun the record | cleared by |
|---|---|---|
| **contradicted** (piece, act) | a piece in canon asserts an answer that a check says is wrong | the contradiction being answered after a repair, or overturned when contested |
| **found** (piece, act) | a finding against a piece in canon has not been answered | an answer, or being overturned when contested |
| **overclaimed** (piece, dimension) | content says more about how well a piece stands than that piece's warrant gives | evidence that raises the warrant, or the author saying less |
| **reopened** («decision») | a decision's basis has failed: what it read was rewritten, a ground fell, an assumption failed, more rests on it than it was decided at | its party sustaining it on the new basis, or deciding again |
| **stale** (reference) | the target is no longer at the version the reference saw | the author affirming it against the new version, or re-pointing, after answering "did I rely on what changed?" |
| **dangling** (reference) | the target does not exist: not yet written, or its id retired | the target being written, re-pointing to a descendant, or dropping |
| **unmet** (reference) | the target's warrant is below what the reference needs | the target earning it, or the author needing less |
| **promised** (slot) | a promised slot has nothing accepted in it | writing and accepting what fills it, or the promise being withdrawn |
| **raised** (piece, dimension) | a question put to a piece has no answer: by a rule, by a narrowed premise, or by a check on the piece itself that came back narrowed (does it want splitting?) | the dimension's producer, or the author |
| whatever the ontology's own constraints add | | |

The most common item is a reopened acceptance. A piece is in canon by a decision whose basis is the piece at its version, the warrants the ontology asks of it, and everything it rests on being accepted. Rewrite the piece, lapse a check it needed, or unsettle a premise, and its acceptance is reopened: the piece is **unsettled** until its party, or the rule that stands in for one, accepts it again. An unsettled piece is still in canon. Reopening is not reversal, and that is why it owes.

Any item may be covered by a **waiver** instead of cleared: it stays owed, and stays shown.

Each item carries its cause (which write or act made it owed, and so which open changeset it belongs to) and who can clear it: for a found-out dimension whoever its *produced by* gives standing, the piece's last author first where a repair is wanted; for a decision, its party. The frontier is addressed to someone. Only canon owes, settled or unsettled: what a provisional segment says inside itself is shown and not owed. Beside the owed items the frontier shows, as information, every piece whose own warrant exceeds its effective one: a well-checked claim resting on an unchecked premise.

### Invariants
- It is computed, never kept. The same recorded things read in any order give the same frontier, with every declared rule evaluated as of the state.
- A contradicting check or a finding adds an item the moment it is recorded, before any repair.
- Notes in an inbox are not owed; an inbox may be full at a steady state. A source not yet retired, a suggested slot and a gap are not owed either.
- If the frontier keeps growing instead of shrinking as a changeset is staged, work stops and the whole is looked at: two ideas treated as one, a genuine tension between two well-supported claims, or a foundation that has moved.

## Discussion
- Only canon owes, so a verisectorium with nothing yet accepted has an empty frontier and is steady at every state. That is correct and worth knowing on arrival: until something is accepted, the frontier says nothing, and what guides the work is the outline and the inboxes.
- Why the frontier is the first thing a working agent looks at. The kind tables of the earlier notes said what records can be; the frontier says what is not yet true around what I just changed, and that is the question a mind at work actually has. Telling the frontier apart from the states the work rests at is the critical thing this model adds over the ad hoc verisectoria.
- Why one cause can make many items. One rewritten root reopens its own acceptance and makes a stale reference, an unmet need and a reopened acceptance on every dependent. The raw set is what a stranger can recompute; grouping by cause is a rendering.
- Why the known-defect mark needs no machinery. A contradicted item still on the frontier when a steady state is wanted is either repaired or waived with a reason, and the waiver is visible in the steady state's conditions. That is the known-defect mark.

## Examples
- A scope segment after an independent re-read: two consequence claims contradicted, each by a check, and five findings. The integrator's rewrite reopens the acceptance of every rewritten claim; the contradictions and findings stay owed until someone other than the integrator records each answered.
- A proposition whose validity had been confirmed several times, then contradicted by a check using a new means: from that moment contradicted, before any repair is written, with a question raised on every piece predicated on it.
- A paper drawn from a theory says "we prove" of a result whose only confirmation followed the written derivation: overclaimed, cleared by a second means that holds or by the paper saying less.

## Historical Context
### Etymology
From *frons*, the front: the line where settled territory ends. What is still owed in a working state, computed, addressed to someone. Kept over *obligations* (the plan's word) and *todo list* (which is typed) because a frontier moves as work advances and is never kept by hand.

### In his words
Joseph, 2026-11-08: "clear deliniation of the frontier vs stable checkpoints is one of the critical things we'll be adding here" (checkpoint was the word for a steady state until the next day).

### Adjudication
- Adjudicated against msc/notes 05 (22:19Z), 09 §4.3, 10 §1.1, 19 §5, and Joseph's 11-08 "dimensions as constraints".

## Working Notes
- Open. Whether the item kinds above are complete. An ontology adds its own.
- The frontier is as complete as the written references, and references are incomplete in the direction that matters: the piece that contradicts a change and shares none of its vocabulary. See «reference»'s note on detection. And a computed frontier nobody is shown silts exactly like a kept list: it has to be rendered where every changeset opens and closes, and what reaches the steward from it should be only what the steward alone can weigh.
- Open. What agents will do to make the frontier empty. Affirmations and waivers are both cheap exits (rewording a piece to shed a finding was a third, closed by findings staying owed until answered), and any marker of done becomes a target. The model's only answer is that both are decisions with a party and a reason, visible at every steady state.
- Open. Whether a contradicted item under a waiver should make references to that piece unmet unless they acknowledge the waiver. Lean: yes; a known defect should inhibit new reliance, not only be visible.
