```kdl
term "changeset" pos=noun pl="-s" {
  subtypes "segment·changeset" "atomic·changeset"
  avoid "episode" "an earlier word for the atomic changeset"
  avoid "commit" "one way of holding one"
  avoid "atom" "atomic means all-or-nothing and has nothing to do with any small unit of content"
  rel "on" term="segment" card="{1,1}" note="for a segment changeset"
  rel holds term="act" card="{0,N}" note="for an atomic changeset, with its segment changesets"
  rel from term="checkpoint" card="{1,1}" note="for an atomic changeset"
  rel to term="checkpoint" card="{1,1}" note="for an atomic changeset"
}
status provisional
```

# «changeset»
A change at one logical instant: a whole new written state of one segment, or everything that takes the store from one checkpoint to the next.

## Definition
A ‹segment·changeset› is a whole new written state of one «segment», replacing the old one at one instant, with no order among the changes inside it. For every veritoid that depends, by an inner dependency of the segment's kind, on a veritoid that changed, it either changes that veritoid too or carries the author's affirmation of it; otherwise the write is refused as a draft. It may change content, assertions and references; recut (split, merge); move veritoids in or out (promote, fold back); and mint new segments. Joseph's "instance-isolated changeset".

An ‹atomic·changeset› is everything, segment changesets and acts together, that takes the store from one «checkpoint» to the next. It opens with whatever first disturbs the checkpoint (a finding, a softened assertion, a new result, a rule firing, an outside change) and closes when the «frontier» is empty or every item on it is accepted. It is usually more than one mind can assemble in one pass, so it is staged; after every stage the frontier says what is owed. Only the last write to each segment reaches the next checkpoint. Joseph's "atomic changeset", "simultaneously, logically speaking".

### Invariants
- An atom of content never changes alone; only a segment changeset writes.
- A segment changeset is refused, not owed, when an inner dependent is neither changed nor affirmed, when it would make predicated-on cyclic, or when it names an id it does not hold and is not moving.
- What is written is reconciled by the author at one instant. Warrants are not the author's to set: the moment a changeset is staged, every act that read what changed lapses, and earning the warrant back takes further acts, usually by other minds, in work time.
- An affirmation never counts as an independent check. Its job is only that nothing was left as it was without someone having looked.
- An act alone, such as a confirming check on a checkpoint, is an atomic changeset of size one.
- Whether a refused write is recorded in the log or only reported is an architectural choice; the model requires only that the log hold what happened to the store.

## Discussion
- Why two sizes. Keeping the veritoids of a segment coherent is the author's job and is checkable at the write; keeping the graph coherent across segments is many minds' job over hours, and only the frontier can say how far it has got. The segment changeset is where the author's whole-instance reconciliation lives; the atomic changeset is where logical simultaneity across the store lives.
- Why the changed-or-affirmed rule is a refusal. A segment state with a part neither changed nor affirmed is not a weaker changeset; it is a draft, and a draft is not something the store holds. Joseph: inner dependencies "would have to be fully coherent and reconciled and correct … or it isn't a valid instance-change".
- The soften-then-strengthen choice is methodology, not engine. Softening an assertion is the cheapest way back to a checkpoint and often a false calm, because of what caps along predicated-on. Whether to complete the softening first and take up the strengthening after, or to stack them and complete once, is a decision about where effort goes. The model allows both and prefers neither.

## Examples
- `33cfb14c` (2026-10-30 16:29): one segment changeset on `deriv-sector-condition` ((i) becomes the killed moment, (iii) splits, A.1S-τ arrives), part of an atomic changeset that also rewrote `result-contraction-template`, re-read four consumers, and moved a headline in the introduction; the broken check at 15:50 was its opening and the independent confirmation at 22:58Z part of its close.
- The 2026-10-30 integrations of `scope-adaptive-system`: four revise acts (`5e613630`, `26a703b0`, …, `9fde935e`), each a segment changeset, inside one atomic changeset that closed with check 8.

## Historical Context
- Adjudicated against msc/notes 05 (22:19Z–23:11Z), 08/10, 09 §3.1 and §4, 19 §5.

## Working Notes
- Open (Joseph's, punted). Several atomic changesets in flight at once, and whether the union of two independently steady stores is steady. The model says nothing; a working state belongs to one atomic changeset.
- Open. Whether a recut (split or merge) must be its own segment changeset or may ride inside one that also changes content. Lean: may ride inside; the descent record is what matters.
