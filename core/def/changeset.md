```kdl
term "changeset" pos=noun pl="-s" {
  subtypes "segment·changeset" "atomic·changeset"
  avoid "episode" "an earlier word for the atomic changeset"
  avoid "commit" "one way of holding one"
  avoid "atom" "atomic means all-or-nothing and has nothing to do with any small unit of content"
  rel "on" term="segment" card="{1,1}" note="for a segment changeset"
  rel holds term="act" card="{0,N}" note="for an atomic changeset, with its segment changesets"
  rel from term="steady·state" card="{1,1}" note="for an atomic changeset"
  rel to term="steady·state" card="{1,1}" note="for an atomic changeset"
}
status provisional
```

# «changeset»
A change at one logical instant: a whole new written state of one segment, or everything that takes the verisectorium from one steady state to the next.

## Definition
A ‹segment·changeset› is a whole new written state of one «segment», replacing the old one at one instant, with no order among the changes inside it. For every veritoid that depends, by an inner dependency of the segment's kind, on a veritoid that changed, it either changes that veritoid too or carries the author's affirmation of it; otherwise the write is refused as a draft. It may change content, assertions and references; recut (split, merge); move veritoids in or out (promote, fold back); and mint new segments. Joseph's "instance-isolated changeset".

An ‹atomic·changeset› is everything, segment changesets and acts together, that takes the verisectorium from one «steady·state» to the next. It opens with whatever first disturbs the steady state (a finding, a softened assertion, a new result, a rule firing, an outside change) and closes when the «frontier» is empty or every item on it is accepted. It is usually more than one mind can assemble in one pass, so it is staged; after every stage the frontier says what is owed. Only the last write to each segment reaches the next steady state. Joseph's "atomic changeset", "simultaneously, logically speaking".

### Invariants
- A «veritoid» never changes alone; only a segment changeset writes.
- A segment changeset is refused, not owed, when an inner dependent is neither changed nor affirmed, when it would make predicated-on cyclic, or when it names an id it does not hold and is not moving.
- What is written is reconciled by the author at one instant. Warrants are not the author's to set: the moment a changeset is staged, every act that read what changed lapses, and earning the warrant back takes further acts, usually by other minds, in work time.
- An affirmation never counts as an independent check. Its job is only that nothing was left as it was without someone having looked.
- An act alone, such as a confirming check on a steady state, is an atomic changeset of size one.
- Whether a refused write is recorded in the acta or only reported is an architectural choice; the model requires only that the acta hold what happened to the verisectorium.

## Discussion
- Why two sizes. Keeping the veritoids of a segment coherent is the author's job and is checkable at the write; keeping the graph coherent across segments is many minds' job over hours, and only the frontier can say how far it has got. The segment changeset is where the author's whole-instance reconciliation lives; the atomic changeset is where logical simultaneity across the verisectorium lives.
- Why the changed-or-affirmed rule is a refusal. A segment state with a part neither changed nor affirmed is not a weaker changeset; it is a draft, and a draft is not something the corpus holds. Joseph: inner dependencies "would have to be fully coherent and reconciled and correct … or it isn't a valid instance-change".
- The soften-then-strengthen choice is methodology, not engine. Softening an assertion is the cheapest way back to a steady state and often a false calm, because of what caps along predicated-on. Whether to complete the softening first and take up the strengthening after, or to stack them and complete once, is a decision about where effort goes. The model allows both and prefers neither.

## Examples
- `33cfb14c` (2026-10-30 16:29): one segment changeset on `deriv-sector-condition` ((i) becomes the killed moment, (iii) splits, A.1S-τ arrives), part of an atomic changeset that also rewrote `result-contraction-template`, re-read four consumers, and moved a headline in the introduction; the broken check at 15:50 was its opening and the independent confirmation at 22:58Z part of its close.
- The 2026-10-30 integrations of `scope-adaptive-system`: four revise acts (`5e613630`, `26a703b0`, …, `9fde935e`), each a segment changeset, inside one atomic changeset that closed with check 8.

## Historical Context
### Etymology
English, from version control, where it means a set of changes applied as one. Kept because that is the exact sense: a whole new written state at one logical instant. Joseph's own phrases, *instance-isolated changeset* and *atomic changeset*, are its two sizes; *episode* (the plan's word for the second) and *commit* (one way of holding one) were declined.

### Adjudication
- Adjudicated against msc/notes 05 (22:19Z–23:11Z), 08/10, 09 §3.1 and §4, 19 §5.

## Working Notes
- Open (Joseph's, punted). Several atomic changesets in flight at once, and whether the union of two independently steady verisectoria is steady. The model says nothing; a working state belongs to one atomic changeset.
- From the first core's term "perturbation", not yet said here: connecting an unconnected segment into the verisectorium, by a predicated-on reference or by a place in a canonical projection, opens an atomic changeset of its own and is usually the largest in its neighbourhood (Joseph, 2026-11-05); a segment minted alone and left unconnected disturbs nothing. And the asymmetry that follows from reach: a change near the roots reaches nearly everything and one at the tips nearly nothing, hence his "natural incentive to get the early stuff as solid as possible roughly in proportion to their age and downstream graph-size". Lean: one Discussion bullet each, when this def is next adjudicated.
- A small worked move, wanted somewhere in core because nothing here shows the two kinds of time on an example a reader can hold in their head (the two `impl-` runs are real and heavy). Its words are older than this def's: read "position" as warrant and "owed" as frontier items. Lean: an `impl-` segment of its own, restated in this model's words, placed right after «steady·state» in the outline.

  Steady state S0. Segment T is a derived result: a formal claim c1, a derivation d1, a description e1 and an eli8 k1. Agent B has independently re-derived c1 by way of d1; that act read c1 and d1. T has been read as a whole and found coherent. Segment U has a claim u1 predicated on T's claim at "re-derived or better". Nothing else points at T or U.

  | Work time | What happens | What is owed afterwards |
  |---|---|---|
  | 08:30 | An auditor finds that T's claim is false as stated and needs an extra hypothesis H. The finding is recorded as an act. | No longer steady. This act is the perturbation. Owed: T's claim is known broken. |
  | 09:00–09:25 | Agent A drafts: adds H to the claim (c2), reworks the derivation (d2), re-reads the description and finds it still right, rewrites the eli8 (k2). | Nothing staged yet. Drafts are not changesets. |
  | 09:25 | A submits segment changeset 1 on T: {c1→c2, d1→d2, e1 affirmed against c2, k1→k2}. One instant, four veritoids, no order. | B's re-derivation read c1 and d1, so it no longer binds; c2 is "drafted". T's whole-read no longer binds. U's reference targets something that changed, by narrowing, so U must be asked whether it used what is gone. U needs "re-derived" and T's claim is "drafted". Four things owed. |
  | 11:00 | B re-derives c2 by way of d2. | Binds to c2 and d2. Two owed: T's whole-read, and the question to U. |
  | 11:30 | A finds and fixes an error in step 3. Segment changeset 2 on T: {d2→d3}. | B's 11:00 act read d2. It no longer binds. T's claim is "drafted" again. |
  | 12:00 | B re-derives c2 by way of d3. | Binds to c2 and d3. |
  | 13:00 | Agent C answers the question to U: U's claim follows only if U also assumes H. Segment changeset 3 on U: {u1→u2, reference re-declared against c2}. | U's reference holds. u2 is "drafted". |
  | 13:30 | B re-derives u2. | Binds to u2 and c2. |
  | 14:00 | Whole-reads of T and of U, by someone other than their authors. Nothing owed. | The move is complete. S1. |

  What S1 holds: T's claim went c1→c2 and its derivation d1→d3; d2 was never part of any steady state. U's claim went u1→u2 at the same instant as T's; there was never a theory in which T had H and U did not. The acts that count in S1 are those that bind to what S1 contains. B's 11:00 re-derivation binds to nothing in S1 and is not neutral: B passed a derivation with an error in step 3, which is what a verisectorium needs in order to know what B's checks are worth.
- Not in the model, and the one diagnosed cause of the October sprint's check-and-fix loop: who writes the repair. Joseph: "wrong integrator agent after a verification pass with a new mind"; "Why does a new integrator land the independent checker's findings instead of the original integrator? That seems extremely wasteful and prone to error." A fresh mind landing a checker's findings writes new text that then needs checking; almost half of the claims "fixed" in that sprint had been written earlier in the same sprint. The remedy it points to: a checker's findings go back to the author of the segment changeset, inside the same atomic changeset, and independence belongs on the checking side only (in the worked move above, A stays T's author throughout and B only checks). The model allows this and says nothing about it. Lean: a praxis, not an invariant; and the frontier's "who can clear it" for a broken item should name the segment's last author first.
- Open. Whether a recut (split or merge) must be its own segment changeset or may ride inside one that also changes content. Lean: may ride inside; the descent record is what matters.
