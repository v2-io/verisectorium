```kdl
term "reference" pos=noun pl="-s" {
  synonyms "pointer"
  avoid "edge" "suggests an object apart from the veritoid that wrote it"
  avoid "depends" "ASF's frontmatter word pointed whole segments at whole segments"
  rel from term="veritoid" card="{1,1}"
  rel to term="veritoid" card="{0,N}" note="or a segment; how many it expects is written with it"
  rel to term="segment" card="{0,N}" note="a projection's members; a chunk's bears-on"
}
status provisional
```

# «reference»
A written pointer from a veritoid to veritoids or segments, of a declared kind, carrying the target version it was last reconciled against and optionally the warrant it needs its target to have; someone wrote it, it can be wrong, and only whether it holds is computed.

## Definition
A reference is written content: it is part of its veritoid's version, so re-pointing or reconciling one is a write. Its **kind** says what passes along it, and a kind exists only because some «dimension» treats it differently from the rest. Kinds so far: **predicated-on** (this claim needs those; support travels along it and validity caps along it; acyclic), **narrates** (this talks about that; staleness only), **restates** (the two must agree), **seeded-by** (two acts are not independent), **supersedes** (which is current), **bears-on** (what a chunk concerns). The ontology may add kinds and their behaviour.

A reference **holds** when its target exists (its id is not retired), the target's version is the one the reference last saw, and the target's warrant on the dimension the reference names is at least what the reference needs, where it says. A reference that does not hold is owed on the «frontier»: *stale*, *dangling* or *unmet*, each a different repair.

### Invariants
- It points at the specific veritoid relied on, not at that veritoid's whole segment, except where its kind is about segments (a projection's members; bears-on when the chunk concerns a whole segment).
- It says how many targets it expects; that gives a miss its meaning. Zero against exactly-one is a defect; zero against any-number is just the answer.
- A reference to a piece that does not yet exist is allowed and owed, so a projection can point at promised work and a derivation at a result not yet written.
- A reference to a retired id is never silently redirected; it is owed until re-pointed to a descendant or dropped.
- The predicated-on graph has no cycles. A cycle found is something cut too coarsely.

## Discussion
- Why a reference is content and not a value. Joseph described the dependency as an array dimension on the claim atom. Here the targets are written by the author and only *does it hold* is computed, because a derivation that now uses a different premise is a different derivation, and a check of the old one should not bind to the new.
- Why the version seen is part of the reference. It is what makes staleness computable, and what lets an author reconcile a reference against a moved target without changing a word of content; that reconciliation is still a write and still mints a version, which is right.
- What a premise change does downstream is the referencing dimension's business, not the reference's. A refuted premise leaves what rested on it unsupported by that route, not false. A premise that dropped in warrant lowers the cap. A narrowed premise puts a question to every dependent: did you rely on what is gone? That question is a frontier item raised on each dependent, and the dependent's author answers it by changing or affirming.

## Examples
- `scope-adaptive-system` item (b) predicated-on `example-kalman`'s random-walk tracker, at the version it last saw; (c) predicated-on `def-action-transition`'s Markov commitment, which is one veritoid of that segment and not the segment.
- An introduction's narrates reference to another segment's eli8 and not to its formal claim.
- A chunk from the 2026-05-30 gold lift with bears-on `scope-adaptive-system`.

## Historical Context
### Etymology
From *referre*, to carry back: a pointer carries the reader back to what a piece rests on. Kept over *edge* (which suggests an object apart from the veritoid that wrote it) and *link*; the estate's address theory uses the same word with the same shape, a written proxy whose referents are resolved as of a moment.

### Adjudication
- Adjudicated against msc/notes 05 (21:52Z), 09 §2.5, 10 §1.5–1.7, 19 §2 and §5; the live_docs read `msc/scratch/research-live-docs-2026-11-09.md` §§2.3, 2.4, 2.6 for the three notes above it.

## Working Notes
- Open. Whether *needed* on a reference is the author's assertion about what the dependent relies on (and so a constraint the author owns) or something the capping dimension consults. Lean: the author's, stated, and the cap is computed separately; the two agree in the common case and differ exactly where the author relied on more than the premise's warrant, which is worth seeing.
- Open. Whether a reference may itself carry a warrant (is it true that A rests on B?). Lean: no; contest it by a finding on the referencing veritoid.
- **Decide (Joseph).** Whether reconciling a reference to the same target at a new version is a write. As written, seen-versions are inside the referencer's version hash, so clearing one stale reference mints a version, lapses every act that read the referencer, and stales every reference to it, transitively through the graph, with no content changed (cold read §2.4). The argument given ("a different derivation") covers re-pointing to a different id, not re-reconciling to the same one. Alternative, inside the model's own words: the version hashes content, assertions and reference *targets*; seen-versions are carried beside it; reconciliation to the same id is an affirmation ("I looked; I still rely on it"), which never counts as a check and lapses nothing downstream. Staleness stays computable. Lean: the alternative; the second-order collapse on a 1,234-record corpus is the larger cost. Not changed in the text pending his call.
- Decide (Joseph). Whether "predicated-on has no cycles" is a core invariant or belongs to the kind along which validity caps. A cap is not well defined on a cycle, so the support kind must be acyclic; a dependence kind along which nothing caps (two decisions that each presuppose the other, in a specification verisectorium) need not be, and one real verisectorium in the estate allows exactly that. Lean: acyclicity is a property of any reference kind a dimension caps along, declared with the kind, and not of dependence in general.
- Open (practical model). The frontier is exactly as complete as the written references, and references are systematically incomplete in the direction that matters: the piece that contradicts a change but shares none of its vocabulary, which no author wrote a reference to and no search finds. Propagation along references is the well-understood half; detection of the unwritten reference is where real verisectoria fail. The practical answer is a judgment walk over the changed segment's projection neighbours on every substantive change, writing the references it finds so the frontier reaches them next time, and treating a root changed with nothing lapsed as suspicious. Machinery needs nothing new; the review's default read set does.
- Open. Whether the expected references of a piece should be declared on its kind (every claim expects at least one predicated-on; every decision expects what it rests on) rather than only per reference instance, so that a missing why is owed without an author having to write a dangling reference. Lean: both; the kind-level form is what makes a promised row's missing support computable. See «kind».
- Open, and not carried from `core/` on purpose or otherwise: its gap row "mutual definition" (terms that co-define, where predicated-on between claims does not fit; AAT's first chapter read as five terms defined together). It is neither a gap row here nor among the outline's deliberately-not-carried. This def set is itself a specimen: «veritoid», «segment», «kind» and «dimension» each use the others, their `rel` lines form cycles, and nothing is wrong with that. Lean: the same answer as the acyclicity note above (only a kind something caps along need be acyclic), with co-definition as a reference kind along which nothing caps and whose members are reviewed, and accepted, together.
- A reference-kind list is better derived than listed: name each kind by what it does (what passes along it, which direction, whether it caps, whether it is acyclic, whether its target may be outside the verisectorium) and collapse kinds with identical behaviour. Narrates and restates may collapse under that test; bears-on may not.
