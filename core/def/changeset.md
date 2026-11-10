```kdl
term "changeset" pos=noun pl="-s" {
  subtypes "segment·changeset" "atomic·changeset"
  avoid "episode" "an earlier word for the atomic changeset"
  avoid "commit" "one way of holding one"
  avoid "atom" "atomic means all-or-nothing and has nothing to do with any small unit of content"
  rel "on" term="segment" card="{1,1}" note="for a segment changeset"
  rel holds term="act" card="{0,N}" note="for an atomic changeset, with its segment changesets"
  rel from term="steady·state" card="{1,1}" note="for an atomic changeset: its scope as it stood settled"
  rel to term="steady·state" card="{1,1}" note="for an atomic changeset: its scope settled again"
}
status provisional
```

# «changeset»
A change at one logical instant: a whole new written state of one segment, or everything that takes the part of the verisectorium one disturbance reaches from settled to settled again.

## Definition
A ‹segment·changeset› is a whole new written state of one freestanding «segment» and everything it holds, replacing the old one at one instant, with no order among the changes inside it. For every held segment that depends, by an inner dependency of the kind, on one that changed, it either changes that one too or carries the author's **affirmation** of it, a «decision» to keep it as it is beside the change; otherwise the write is refused as a draft. It may change content and references; change slots and their states; recut (split, merge); move held segments in or out (promote, fold back); and mint new segments.

An ‹atomic·changeset› is everything, segment changesets and acts together, that follows from one disturbance, until the segments it reaches are settled again. It opens with whatever first disturbs the steady state (a finding, a narrowed claim, a new result, a rule applying, word that something outside has moved) and closes when every item it caused is cleared or waived. Its **scope** is every segment it has written or that has a «frontier» item it caused; nobody declares it. Several atomic changesets may be open at once while their scopes share nothing. When they meet (one comes to rest on, or to write, a segment in the other's scope) they are one changeset from then on. It is usually more than one mind can assemble in one pass, so it is staged; after every stage the frontier says what is owed. Only the last write to each segment reaches the next steady state.

### Invariants
- Nothing held changes alone; only a segment changeset writes.
- A segment changeset is refused, not owed, when an inner dependent is neither changed nor affirmed, when it would make a cycle along a reference kind some dimension caps along, or when it names an id it does not hold and is not moving.
- What is written is reconciled by the author at one instant. Warrants are not the author's to set: the moment a changeset is staged, every check that read what changed lapses and every decision that rested on it is reopened, and earning them back takes further acts, usually by other minds, in work time.
- An affirmation is the author's decision and never evidence. Its job is only that nothing was left as it was without someone having looked.
- An act alone, such as a confirming check on a steady state, is an atomic changeset of size one.

## Discussion
- Who writes the repair. A checker's findings go back to the author of the changeset they are about, inside the same atomic changeset; independence belongs on the checking side only. A fresh mind landing another's findings writes new text that then needs checking, and in one real sprint almost half of the claims "fixed" had been written earlier in the same sprint.
- Why two sizes. Keeping the veritoids of a segment coherent is the author's job and is checkable at the write; keeping the graph coherent across segments is many minds' job over hours, and only the frontier can say how far it has got. The segment changeset is where the author's whole-instance reconciliation lives; the atomic changeset is where logical simultaneity across the verisectorium lives.
- Why the changed-or-affirmed rule is a refusal. A segment state with a part neither changed nor affirmed is not a weaker changeset; it is a draft, and a draft is not something the corpus holds. Joseph: inner dependencies "would have to be fully coherent and reconciled and correct … or it isn't a valid instance-change".
- The soften-then-strengthen choice is methodology, not engine. Softening an assertion is the cheapest way back to a steady state and often a false calm, because of what caps along predicated-on. Whether to complete the softening first and take up the strengthening after, or to stack them and complete once, is a decision about where effort goes. The model allows both and prefers neither.

## Examples
- A theory's proposition found false by a check in the afternoon: one segment changeset rewrites its document (the proposition restated, a neighbour split, a replacement result added), inside an atomic changeset that also rewrites the template result built on it, re-reads four consumers and moves a headline in the introduction. The contradicting check opened it; an independent confirmation that night was part of its close.
- One day's integration of a scope segment: eight rewrites, each a segment changeset, inside one atomic changeset that closed with the eighth round of checks.

## Historical Context
### Etymology
English, from version control, where it means a set of changes applied as one. Kept because that is the exact sense: a whole new written state at one logical instant. Joseph's own phrases, *instance-isolated changeset* and *atomic changeset* ("simultaneously, logically speaking"), are its two sizes; *episode* (the plan's word for the second) and *commit* (one way of holding one) were declined.

### Adjudication
- Adjudicated against msc/notes 05 (22:19Z–23:11Z), 08/10, 09 §3.1 and §4, 19 §5.

## Working Notes
- Open. Whether a refused write is recorded in the acta or only reported. An architectural choice; the model requires only that the acta hold what happened to the verisectorium.
- Open. Two open changesets that contradict each other in substance while no reference connects them never meet; both close. Detection is «reference»'s unwritten-reference problem.
- Open (Joseph's, punted). Whether the union of two verisectoria, each steady, is steady.
- From the first core's term "perturbation", not yet said here: connecting an unconnected segment into the verisectorium, by a predicated-on reference or by a place in a canonical projection, opens an atomic changeset of its own and is usually the largest in its neighbourhood (Joseph, 2026-11-05); a segment minted alone and left unconnected disturbs nothing. And the asymmetry that follows from reach: a change near the roots reaches nearly everything and one at the tips nearly nothing, hence his "natural incentive to get the early stuff as solid as possible roughly in proportion to their age and downstream graph-size". Lean: one Discussion bullet each, when this def is next adjudicated.
- Not in the model, and the one diagnosed cause of the October sprint's check-and-fix loop: who writes the repair. Joseph: "wrong integrator agent after a verification pass with a new mind"; "Why does a new integrator land the independent checker's findings instead of the original integrator? That seems extremely wasteful and prone to error." A fresh mind landing a checker's findings writes new text that then needs checking; almost half of the claims "fixed" in that sprint had been written earlier in the same sprint. The remedy it points to: a checker's findings go back to the author of the segment changeset, inside the same atomic changeset, and independence belongs on the checking side only (in the small move after «steady·state» in the outline, A stays T's author throughout and B only checks). The model allows this and says nothing about it. Lean: a praxis, not an invariant; and the frontier's "who can clear it" for a broken item should name the segment's last author first.
- Open. Whether a recut (split or merge) must be its own segment changeset or may ride inside one that also changes content. Lean: may ride inside; the descent record is what matters.
