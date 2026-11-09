```kdl
term "verisectorium" pos=noun pl="verisectoria" {
  avoid "repository" "where files happen to live; a verisectorium may span several or none"
  avoid "knowledge base" "suggests settled facts; a verisectorium is mostly work in progress, honestly marked"
  rel declares term="dimension" card="{1,N}" note="of which at least one is a determinant"
  rel declares term="kind" card="{1,N}"
  rel holds term="segment" card="{0,N}" note="its sources among them"
  rel rests-at term="steady·state" card="{0,N}" note="its history on the steady line"
}
status provisional
```

# «verisectorium»
A place for cutting truth: a body of work where material brought in is dissected until each piece can contribute on its own, adjudicated and refined toward agreement with the truth it is held to, and reassembled into coherent results for others to comprehend and build on; worked on under high turnover, and true as stated, with its conditions, at each of its steady states.

## Definition
Every verisectorium in the estate began the same way and keeps beginning that way: with **influx**. A pile of quotes pulled from memorata-search on a subject; spikes and generative drafts; empirical results; audits; an earlier theory's files; the notes a project was worked out in. That material is **cut** until the pieces are independently contributory, each able to be right or wrong, decided or open, on its own. The pieces are **adjudicated**: checked, re-derived, measured, decided, read, by minds and instruments whose acts are recorded. They are **refined** toward agreement with what the work is held to: strengthened where a claim outran its support, narrowed where it had to be, decided where a choice was open. And they are **reassembled** into coherent results: a canon, an outline, a specification, a compiled product, a paper, pedagogy, implications, tooling, which readers and downstream builders use and build on, so that under turnover the work compounds instead of being redone. New results are built on adjudicated ones; in a theory the branching chain of claims is the engine of discovery, in a specification the accumulating decisions are.

A verisectorium is, concretely, three things together: an **ontology** (the kinds of thing it may hold, the «dimensions|def/dimension» asked of them, and which of those are ‹determinant›s), a **corpus** of everything written in it, its **acta** of everything done to it, and a **history**, the line of its «steady·states|def/steady-state». The word also names this repository and project, which describes verisectoria generally and builds the tooling (`v2`) for them; that sense is kept because the estate uses it, and it is not the referent of the relations above.

### Machinery and practical model
Two things are defined here and must not be confused. The **machinery** is the meta-ontology the rest of this outline gives: eleven terms, under which content divides without end in principle (a derivation into steps, a step into clauses) and stops in practice at a few scales, the «veritoid», the «segment» and the projections that gather segments. It is general, and is expected to reduce to something small and logical. The **practical model** is what a mind at work actually meets: an outline with marked rows, document-like segments rendered as markdown, an inbox beside each segment, a frontier to read, a steady state to reach, and the affordances each of those wants. The practical model is built on the machinery and is not the same thing as it; a tool may give an outline affordances a bare projection does not name, without the machinery changing. Where this outline speaks of both, it says which. What the practical model cannot embed deterministically, how a mind orients, which surface it writes in, when it asks for a cold read, is written for the mind as a **praxis**, the dual of the engine's affordances: the engine enforces what it can, and the praxes say what is expected beyond that. Every concrete verisectorium has both.

### Invariants
- At each of its steady states, no piece asserts more about itself than what has been done to it warrants, every reference holds, and whatever is still owed is owed by recorded acceptance with its reason.
- At least one of its projections is canonical, however experimental, and it is true as stated at every steady state, because a provisional row claims only that the suggestion exists.
- Every piece of its content is of a declared kind, and every kind opens at least one dimension. Content that answers to no dimension is a note about the verisectorium, not content of it.
- Nothing in its corpus is changed by hand, and nothing in its acta is typed. Every change goes through a «changeset», and where the engine cannot express a change, that is how the engine's gap is found.

## Discussion
- **Truth-centric.** What a verisectorium is for is agreement with the dimensions it declares as determinants: validity against logic, agreement with the world, fidelity to a source, consistency within a canon, and so on. Which, and against what, is each verisectorium's declaration. The *veri* in the name is broad on purpose: for an explanation or a tool, being understood or working as intended is what being right comes to.
- **Continually improving.** It is rarely finished. Over time it is expected to get better: answering better to its ‹determinant› «dimensions|def/dimension», or shown more firmly to. A later steady state is better when no determinant warrant has fallen and some has risen, or the content answers to a determinant more strongly in a sense the ontology declares. That sense is a partial order and a direction, not a score and not a queue; where effort goes next is a decision. Refining is the daily work: strengthen, re-derive, narrow, decide. The honesty machinery exists so that the result of that work stays trustworthy while it is done.
- **Turnover-resilient.** Many minds who do not know it beforehand must be able to work on it, with limited time and attention, and leave it better and not noisier. This is why standing is computed from acts and never typed, why the frontier is computed and never kept, and why the inbox is outside what a segment says.
- **Self-consistency is intrinsic.** Steady-state stability as a self-consistency check is the one motivation every verisectorium shares; the constraints the «frontier» lists as its items (assertion within warrant; references holding; nothing warranted above what it rests on; inner dependents changed or affirmed; broken things dealt with; every dimension produced) are what the model and tools supply to all of them without declaration.

## Examples
- AAT: began as earlier theory files and sprint audits brought in as influx; claims answering to logic under their stated hypotheses; results built on results; delivered as volumes, a front door, papers and pedagogy. Better is stronger claims more firmly established.
- A formal specification (udon): began as usage, demands and discussion; rules answering to their own consistency and to the intent behind them; decisions accumulating with grounds and a path to revisit; delivered as the spec tooling is built from.
- A compiled product (comproprium, ai-risk-model, relata): began as sources; pieces answering to the works they came from, each named by a reference; delivered as a system prompt, a response store, a bibliography that other work consumes.
- A novel's world: facts answering to the world's own canon and to the author's intent; better is self-consistency and fidelity.
- This repository's `core-2/`: began as the working notes and transcripts of its own design, cut and read; a model answering to coherence read whole, consistency among its terms, and whether a cold reader can build an instance from it; delivered as what `v2` and each verisectorium's ontology are built from.

## Historical Context
### Etymology
*Verisectorium*: a place (*-orium*, as in auditorium, sanatorium) for cutting (*secare*, whence section, dissect) truth (*veritas*). Coined by Joseph before any of this model existed, for the estate's living bodies of work, and the literal image, a dissection table for truth, turned out to be the operational definition: influx is cut until its pieces can stand alone. Nothing ancient names the thing; *corpus* names only what it holds.

### Adjudication
- The model this def heads was worked out in `msc/notes/` 01–19 (2026-11-04 to 11-08) and the sessions behind them; `msc/notes/00-INDEX.md` says what each note is and what supersedes what. The term itself was first decided in `core/def/verisectorium.md` on 2026-11-07 and restated here on 11-08 after Joseph combined its senses (1) and (3) and found the aspect × standard carve of "truth determinant" unprincipled (see «dimension»'s Historical Context). The operational purpose leading the def is his correction of 2026-11-08: the first core-2 draft had led with the machinery.
- Adjudicated against: `core/def/verisectorium.md`; Joseph's 11-08 turns on combining (1) and (3), on determinants as a subset of dimensions, on self-consistency as the underlying current, on what the estate's verisectoria are used for, and on influx as where every one of them starts; msc/notes 01 §1, 13, 14, 19.

## Working Notes
- Restated from `core/def/verisectorium.md` (decided 2026-11-07) with senses (1) and (3) combined, as Joseph said on 11-08 he needed to do; truth determinants folded into dimensions; and, after his correction of 11-08 (the operational purpose had been lost in favour of the machinery), the definition led by influx, cutting, adjudication, refinement and reassembly into results others build on, with the machinery-versus-practical-model distinction stated inside the term. What I take to be wrong in the decided def: the separate sense (3); the second invariant's "answers to at least one of its truth determinants" where the determinant was carved as aspect × standard; "fitness function" on the avoid list with no reasoning behind it. Lean: this text, provisional, for his adjudication.
- Open. Whether "stated flatly" (theory claims) is a property of truth-centric work generally or only of the theory regime. Lean: the regime's; see «dimension»'s discussion of the two regimes.
- Open. Where the line between machinery and practical model is drawn for each affordance (an outline's marks, a segment's rendering as one file, the inbox). Lean: the machinery names the thing and its constraints; the practical model names what a tool shows and lets a mind do with it; the outline's `mark` and `def` columns are practical model over the machinery's row states.
