```kdl
term "kind" pos=noun pl="-s" {
  subtypes "veritoid·kind" "segment·kind"
  avoid "template" "the dialog's local word for a segment kind; kept free for the seed a new verisectorium is initialized from"
  avoid "type" "suggests a filename prefix or a stage; a kind is a declaration of content shape and questions"
  rel opens term="dimension" card="{1,N}"
  rel allows term="reference" card="{0,N}" note="by reference kind, for a veritoid kind" informal=#true
}
status provisional
```

# «kind»
What a veritoid or segment holds and which dimensions apply to it, as declared in the ontology.

## Definition
A ‹veritoid·kind› declares: the shape its content takes; the «dimensions|def/dimension» it opens (which questions may be asked of a veritoid of this kind, and so which may carry an assertion); which assertions the content may carry, in what form; and which kinds of «reference» it may hold. A ‹segment·kind› declares: its slots, in order, each with the veritoid kind it holds, whether it is required, and how many; its inner dependencies between slots; and how each of the segment's own dimensions is read from its veritoids: *aliased* to one veritoid's warrant, *derived* from several, or *own*, asked of the whole. A projection kind also declares what a review of it reads of each member.

### Invariants
- A kind fixes what questions can be asked; it is not a position on any ladder. A veritoid moving up a dimension never changes its kind.
- A dimension not opened for a kind is a fact about pieces of that kind, not a gap in their record.
- Every veritoid kind opens at least one dimension. A question opens *answered* (produced by its closer's attestation); a regression guard opens *still false* (a check); a non-claim opens *fidelity* (does the text indeed not claim it). Content whose kind opens none is a note about the verisectorium, not content of it.
- A kind has versions, and every piece follows one version of its kind. Adding a required slot to a segment kind makes every existing segment of that kind owe something; the ontology change is a perturbation like any other.

## Discussion
- Why kind does both jobs under one word. The 11-05 dialog separated "atom kind" from "template" because the earlier "kind" had said nothing about what content pieces a thing has. Both are declarations of what a thing holds and what may be asked of it, at the two levels; one word with two subtypes keeps the lexicon from doubling.
- Why kinds are not individuated by how they fail. That was RC1's cut, and it drove the record ever finer without saying what the pieces were for. A kind here is individuated by what it holds and what is asked of it; failure is one of the dimensions.
- What goes in a verisectorium's ontology and not here. The claim shape for a theory (context, hypotheses, conclusion, derivation), the low-fidelity kinds (sketch, hypothesis, idea, anecdote), the statement subkinds (definition, scope, postulate, no-go) are kinds AAT declares. The core only says what a kind declaration consists of.

## Examples
- AAT's `derived-result` segment kind: slots formal-claim (one, claim), derivation (any number, proof-step), description (one, explanation), eli8 (at most one, explanation), questions (any number), guards (any number); inner dependencies eli8 → description → formal-claim; truth aliased to the formal claim's validity; freshness derived as the minimum; coherence own.
- AAT's `claim` veritoid kind: content is a statement with its hypotheses and conclusion; opens validity, simulation, imported; may assert on validity ("exact", "conditional on …", "hypothesis"); may hold predicated-on and restates references.
- A `chunk` veritoid kind: content is a span; opens where-did-it-go; holds one bears-on reference.
- An `account` veritoid kind: prose about how a segment came to be as it is; opens fidelity to the acta; may hold references outward to sources and notes; sits in a history slot where the segment kind declares one.

## Historical Context
### Etymology
Plain English, kept over *type* (which the estate's files used for a filename prefix and a stage) and *template* (the 11-05 dialog's word, now freed for the seed a new verisectorium is initialized from). A kind says what a thing holds and what may be asked of it; *genus* was considered and declined as pretentious for so ordinary a role.

### Adjudication
- Adjudicated against msc/notes 05 (21:52Z–22:19Z), 06 §2, 09 §2.3, 12, 13, 19 §2.

## Working Notes
- Open. Whether the ontology itself may one day be content of its own corpus (the compiler bootstrap). Deferred by Joseph: not at first.
- Open. Where an ontology change is recorded (cold read §2.7). It is neither written content nor an act on content, and ‹outside·change› is for things neither corpus nor acta hold. Either the ontology becomes content of a special segment (deferred by Joseph) or the acta have a third record kind beside writes and acts. A gap row carries it.
- Open. Whether a kind declares the references its pieces are expected to hold (a claim: at least one predicated-on; a decision: what it rests on), as it declares slots, so that a missing one is owed at the kind's grain. Lean: yes; it is the same declaration as a required slot, for references. See «reference».
- Open. What a kind change does to recorded acts whose reads are still intact. An act binds to versions, not to kinds, so a kind change lapses nothing by itself; whether it should is a decision for the first real migration.
