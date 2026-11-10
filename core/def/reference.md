```kdl
term "reference" pos=noun pl="-s" {
  synonyms "pointer"
  avoid "edge" "suggests an object apart from the veritoid that wrote it"
  avoid "depends" "ASF's frontmatter word pointed whole segments at whole segments"
  rel from term="segment" card="{1,1}" note="a veritoid, or an assembly's pointing slot"
  rel to term="segment" card="{0,N}" note="how many it expects is written with it"
}
status provisional
```

# «reference»
A written pointer from a segment to segments, of a declared kind, with the target version it was last reconciled against carried beside it and optionally the warrant it needs its target to have; someone wrote it, it can be wrong, and only whether it holds is computed.

## Definition
A reference is written content: what it points at is part of its segment's version, so re-pointing one is a write. The version it last saw is carried beside it; reconciling it against the same target at a new version is the author's affirmation ("I looked; I still rely on it"), which mints no version and lapses nothing. Its **kind** says what passes along it, and a kind exists only because some «dimension» treats it differently from the rest. Kinds so far: **predicated-on** (this claim needs those; support travels along it and validity caps along it), **narrates** (this talks about that; staleness only), **restates** (the two must agree), **seeded-by** (two acts are not independent), **supersedes** (which is current), **bears-on** (what a chunk concerns), and the pointing of an assembly's slot at the segment that fills it. The ontology may add kinds and their behaviour.

A reference **holds** when its target exists (its id is not retired), the target's version is the one the reference last saw, and the target's warrant on the dimension the reference names is at least what the reference needs, where it says. A reference that does not hold is owed on the «frontier»: *stale*, *dangling* or *unmet*, each a different repair.

### Invariants
- It points at the specific segment relied on, at the grain relied on: the claim used and not the document that holds it, unless the whole is what is meant.
- It says how many targets it expects; that gives a miss its meaning. Zero against exactly-one is a defect; zero against any-number is just the answer.
- A reference to a piece that does not yet exist is allowed and owed, so a projection can point at promised work and a derivation at a result not yet written.
- A reference to a retired id is never silently redirected; it is owed until re-pointed to a descendant or dropped.
- A reference kind that some dimension caps along has no cycles, since the cap has one solution only on an acyclic graph; a cycle found there is something cut too coarsely. Kinds nothing caps along (terms that define one another; two choices that each presuppose the other) may form cycles, and their members are reviewed and accepted together.

## Discussion
- Why a reference is content and not a value. Joseph described the dependency as an array dimension on the claim atom. Here the targets are written by the author and only *does it hold* is computed, because a derivation that now uses a different premise is a different derivation, and a check of the old one should not bind to the new.
- Why the version seen is carried beside the reference. It is what makes staleness computable, and what lets an author reconcile a reference against a moved target without changing a word of content.
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
- Open (practical model). The frontier is exactly as complete as the written references, and references are systematically incomplete in the direction that matters: the piece that contradicts a change but shares none of its vocabulary, which no author wrote a reference to and no search finds. Propagation along references is the well-understood half; detection of the unwritten reference is where real verisectoria fail. The practical answer is a judgment walk over the changed segment's projection neighbours on every substantive change, writing the references it finds so the frontier reaches them next time, and treating a root changed with nothing lapsed as suspicious. Machinery needs nothing new; the review's default read set does.
- Open. Whether the expected references of a piece should be declared on its kind (every claim expects at least one predicated-on; every decision expects what it rests on) rather than only per reference instance, so that a missing why is owed without an author having to write a dangling reference. Lean: both; the kind-level form is what makes a promised row's missing support computable. See «kind».
- Which way dependence runs, and in what order things are accepted. Joseph, 2026-11-09: accepting a piece pulls in "any upstream graph of the initial one you hope to have accepted", but which end is upstream is less fixed than it looks. "Technically it's the smallest pieces that are the independent roots that need to be defined in order to build the composite pieces. But ontologically it is much, much easier to comprehend and deliberate when it's initially top-down (whole->parts) and then later a mix of top-down and bottom-up. That's where the dependency graph (along with apparently live_docs needing cyclical interdependencies) might be more situational or nuanced than I've thought." Earlier the same day he put the two readings side by side: small sub-definitions as roots that accumulate into the main things by strict definitional dependence, or "the higher-level with forward-dependencies to its constituent parts, where the high-level ones will get adjudicated sooner on average, but the lower-level ones may bubble up changes". A restatement of mine that would let both hold, untested: the two are different reference kinds. A whole that *names* its parts and states only what is true of the whole does not rest on them (nothing caps along that reference; a change in a part puts a question to the whole and does not unsettle it), so it can be accepted first and alone; a piece that *uses* another's content does rest on it, and is pulled in. Top-down acceptance is then possible exactly as far as the higher piece refrains from restating its parts, which is the one-home rule for invariants seen from this side. It joins the two notes above: co-definition, and whether acyclicity belongs only to a kind something caps along.
- A reference-kind list is better derived than listed: name each kind by what it does (what passes along it, which direction, whether it caps, whether it is acyclic, whether its target may be outside the verisectorium) and collapse kinds with identical behaviour. Narrates and restates may collapse under that test; bears-on may not.
