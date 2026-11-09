```kdl
term "segment·changeset" pos=noun pl="segment·changesets" {
  synonyms "instance-isolated changeset"
  rel "on" term="segment" card="{1,1}"
  rel by term="actor" card="{1,1}" provisional=#true
  rel belongs-to term="atomic·changeset" card="{1,1}" provisional=#true
  rel carries term="affirmation" card="{0,N}"
}
status provisional
```

# «segment·changeset»
The unit of writing: a whole new written state for one segment, replacing the old one at one logical instant, every inner dependent either changed or carried with the author's affirmation.

## Definition

### Invariants
- A segment state with a part that is neither changed nor affirmed is a draft, not a changeset.
- What is written is reconciled by the author, inside the changeset, at one instant. Values are not the author's to set; they fall when what they rested on changes and are earned back by later acts.
- A changeset that would make the reference graph cyclic, or that names an id another segment holds, is refused.
- The changed-or-affirmed rule follows each «inner·dependency». A «reference» reaching out of the segment or into it is not part of that rule; what a change does to one goes on the «frontier».

## Working Notes

- Stub, from the kernel spikes. The term was promised and had no file; the spikes made the refusals and the identity rule precise.
- **An id belongs for life to the segment that introduced it** (Ada/Fable, needed for P3; Rust/Fable and Rust/Opus refuse an id held by another segment; Ada/Opus refuses a foreign id). This is the model's open gap "veritoid identity under recut" met in practice: the kernel does not know what moving a veritoid between segments means, so it refuses to let it happen by accident; a move is a remove in one segment and an add in another, two changesets, and acts reading `x@v` revive across the move under content hashes (Rust/Opus). «recut» has to say what identity survives; until it does, this rule is the safe one. Lean: adopt the rule; a dropped id is a tombstone, never a stranger's.
- **Refusal kinds the spikes needed**: cycle; foreign id (another segment's); duplicate id in one changeset; version reuse for different content (Rust/Opus); carried piece re-pointed without affirmation (Ada/Opus). Rust/Fable: acts are never refused, only changesets.
- **Recorded or reported** (`COMPARISON.md` §5). Rust/Opus and Ada/Opus record a refused changeset in the log with the verdict computed at fold (the attempt happened; a stored verdict could be edited; the model's act def says recording too little is dishonest). Rust/Fable and Ada/Fable report it and leave the log untouched (the log records what happened *to the store*, and a refused write did not; a work-time intake log could hold attempts). Open for Joseph; lean: recorded, because "who tried to write a cycle" is exactly the kind of thing a later mind will want and cannot recover otherwise, and the fold can skip it.
- The worked example in `KERNEL-SPEC.md`, as four independent kernels found, mis-stated what this unit does: its expected frontier was hand-assembled by asking "who points at c" instead of running the definitions, and listed `stale-reference(d, c)` for a piece rewritten against the new `c` in the same changeset. The corrected example is in each branch's tests; that file is a spike artifact and is not corrected here.
