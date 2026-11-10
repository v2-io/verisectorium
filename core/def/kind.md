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
What a «segment» holds, whether a leaf or an assembly, and which dimensions apply to it, as declared in the ontology.

## Definition
A ‹veritoid·kind› declares: the shape its content takes, and how that content is normalized before it is hashed; the «dimensions|def/dimension» it opens (which questions may be asked of a veritoid of this kind, and so which may carry an assertion); which assertions the content may carry, in what form; and which kinds of «reference» it may hold. A ‹segment·kind› is the kind of an assembly. It declares: its slots, in order, each with the kind of segment that fills it, whether by holding or by pointing, whether it is required, and how many; its inner dependencies between slots; how each of the assembly's own dimensions is read: *aliased* to the warrant of one segment it holds, *derived* from several, or *own*, asked of the whole; and what a review of the whole reads of each segment in it.

### Invariants
- A kind fixes what questions can be asked; it is not a position on any ladder. A veritoid moving up a dimension never changes its kind.
- A dimension not opened for a kind is a fact about pieces of that kind, not a gap in their record.
- Every kind opens at least one dimension. A question opens *answered* (decided by its closer); a regression guard opens *still false* (a check) where it guards a refuted statement, and where it forbids a future edit ("do not re-promote this without deriving the threshold") it is a decision record with its lifting condition; a non-claim opens *fidelity* (does the text indeed not claim it); a chunk opens *where did it go* (decided); an account opens *fidelity to the acta*. Content whose kind opens none is a note about the verisectorium, not content of it. This invariant is a design choice that follows from the purpose, not a necessity of the machinery: nothing breaks if a kind opens no dimension, but pieces of that kind could never be adjudicated, owed or warranted, and the corpus is for what can be.
- A kind has versions, and every piece follows one version of its kind. Adding a required slot to a segment kind makes every existing segment of that kind owe something; the ontology change is a perturbation like any other.

## Discussion
- Why kind does both jobs under one word. The 11-05 dialog separated "atom kind" from "template" because the earlier "kind" had said nothing about what content pieces a thing has. Both are declarations of what a thing holds and what may be asked of it, for a leaf and for an assembly; one word with two subtypes keeps the lexicon from doubling.
- Why kinds are not individuated by how they fail. That was RC1's cut, and it drove the record ever finer without saying what the pieces were for. A kind here is individuated by what it holds and what is asked of it; failure is one of the dimensions.
- What goes in a verisectorium's ontology and not here. The claim shape for a theory (context, hypotheses, conclusion, derivation), the low-fidelity kinds (sketch, hypothesis, idea, anecdote), the statement subkinds (definition, scope, postulate, no-go) are kinds AAT declares. The core only says what a kind declaration consists of.

## Examples
- A theory's `derived-result` segment kind: slots formal-claim (one, claim), derivation (any number, proof-step), description (one, explanation), eli8 (at most one, explanation), questions (any number), guards (any number); inner dependencies eli8 → description → formal-claim; truth aliased to the formal claim's validity; freshness derived as the minimum; coherence own.
- A theory's `claim` veritoid kind: content is a statement with its hypotheses and conclusion; opens validity, simulation, imported, accepted; its content carries its own conditions ("exact", "conditional on …", "hypothesis"); may hold predicated-on and restates references.
- A `chunk` veritoid kind: content is a span; opens where-did-it-go; holds one bears-on reference.
- An `account` veritoid kind: prose about how a segment came to be as it is; opens fidelity to the acta; may hold references outward to sources and notes; sits in a history slot where the segment kind declares one.

## Historical Context
### Etymology
Plain English, kept over *type* (which the estate's files used for a filename prefix and a stage) and *template* (the 11-05 dialog's word, now freed for the seed a new verisectorium is initialized from). A kind says what a thing holds and what may be asked of it; *genus* was considered and declined as pretentious for so ordinary a role.

### Adjudication
- Adjudicated against msc/notes 05 (21:52Z–22:19Z), 06 §2, 09 §2.3, 12, 13, 19 §2.

## Working Notes
- Open. The subtype names no longer fit what they name. A veritoid is a segment, so ‹segment·kind›, which is the kind of an assembly, is not the kind of every segment; and an «actor» is "of a kind" (a model or instrument at a version) that is neither subtype, while this def's one-line speaks only of segments and «dimension» is "of which kinds" and also "of an actor". Lean: three sorts of kind, of a veritoid, of an assembly and of an actor, with the one-line widened to "what a thing of this kind holds and what may be asked of it"; the renaming waits for a vote, since ‹segment·kind› is used throughout.
- Open. What makes a projection canonical. The outline's row says the ontology declares it; nothing says by whose decision, or whether there may be more than one.
- From the first core's "veritoid·kind", not carried: the admission rule, "a kind earns its place when some question is asked of its veritoids that is asked of no other kind's", or when something treats them differently. «reference» states the same rule for reference kinds; kinds of content have none here. Lean: an invariant of this def.
- A question of Joseph's (2026-11-04) that the model answers with nothing new, and a good test that an ontology change is ordinary: something like *novelty* starts as a soft label, later becomes a rule-backed assertion, later an auditable value with a procedure behind it, and finally "graduates into its whole new *kind*" with content of its own (near neighbours in the literature, dates of the last search) and its own freshness. Each step is a change to the ontology. The first three change the novelty dimension's *produced by* and *read as*. The last adds a slot to the segment kind for a novelty assessment, a veritoid with content and dimensions of its own, and re-declares the segment's novelty as aliased to it. Lean: an Example in this def once the ontology change record has a home.
- Open. Whether the ontology itself may one day be content of its own corpus (the compiler bootstrap). Deferred by Joseph: not at first.
- Open. Where an ontology change is recorded. It is a «decision» about how the verisectorium works, made by whoever has standing over the ontology; what such a decision reads, what it reopens, and whether the ontology itself becomes content of a special segment (deferred by Joseph) are unsaid. A gap in the outline carries it.
- On "every kind opens at least one dimension" (Joseph's question, 2026-11-09: forced, or a choice?). A choice, following from what the corpus is for. Every kind met so far opens something; the nearest exception, a claimless structural heading, is a slot name or a projection's assembly here and not a veritoid. If a verisectorium ever wants pure packaging as content, the relaxation is "every kind that may carry an assertion opens at least one dimension," at no cost to the machinery.
- Open. Whether a kind declares the references its pieces are expected to hold (a claim: at least one predicated-on; a decision: what it rests on), as it declares slots, so that a missing one is owed at the kind's grain. Lean: yes; it is the same declaration as a required slot, for references. See «reference».
- Open, from the first core's terms "ground" and "bound". One thing in them a kind does not cover. *Ground* was written per piece: "the kind says which questions could be asked of pieces like this one; the ground says which are open for this one"; a theorem and a conjecture were one kind at two grounds, and a claim that can never be simulated was never "not yet simulated". Here a dimension is opened per kind only, so such a claim reads *never asked* on simulation in every steady state's conditions forever, unless the two are different kinds. Lean: a piece may decline, in writing and with a reason, a dimension its kind opens; declining is a «decision», and its wording is content like a non-claim. Untested. The estate's own records reach for the same thing from the other side: several stores carry a per-piece ceiling (`max`, `max attainable`, "the strongest status it could ever reach"), which is a statement of which questions will never be open for this piece. The first core also allowed a declared *empty* ground, "for content whose value is that nobody repairs it (a sketch, a raw reflection)", which the invariant above (every kind opens at least one dimension) rules out; that is the same choice seen from the other side.
- Open. What a kind change does to recorded acts whose reads are still intact. An act binds to versions, not to kinds, so a kind change lapses nothing by itself; whether it should is a decision for the first real migration.
