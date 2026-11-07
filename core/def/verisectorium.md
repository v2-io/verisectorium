```kdl
group "verisectorium" "truth⸱determinants"
status provisional
term "verisectorium" pos=noun pl="verisectoria" {
  avoid "repository" "where files happen to live; a verisectorium may span several or none"
  avoid "knowledge base" "suggests settled facts; a verisectorium is mostly work in progress, honestly marked"
  rel declares "truth⸱determinants" card="{1,N}"
  rel described-by "ontology" card="{1,1}"
  rel held-in "data⸱store" card="{1,1}"
}
term "truth⸱determinants" pos=noun pl="truth⸱determinants" {
  synonyms "truth aspects"
  avoid "fitness function" "a determinant is what the work must answer to; a fitness function is one way of scoring agreement with it"
}
```

## Intro

A «VERISECTORIUM» ("place for cutting truth") indicates one of:

- (1) A place for dissecting and adjudicating new or existing content, refining it toward truth as given by its declared «TRUTH⸱DETERMINANTS», and reassembling the parts into meaningful coherent results. It is therefore a body of work that is *truth-centric*, exhibits *continual improvement*, and needs to be *resilient to constant turnover*, as described below;
- (2) The title of this repository and project, which describes verisectoria generally, gives their meta-ontology, and provides tooling (`v2`) for initializing and operating instantiations of them;
- (3) A concrete instance of (1), with its «ontology», the current snapshot of its «data⸱store», and often (as when it is a repository) its history.

**Truth-centrism.** Aspects of truth (internal coherence, authenticity, factual correctness, completeness, fidelity, and so forth), under stated hypotheses, are being adjudicated, discovered or organized, or are what the work must stay faithful to. Which aspects, and against what, are the verisectorium's declared truth determinants.

**Continual improvement.** The work is rarely considered finished; it is a living body of work, evolved through interaction. Over time it is expected to get *better*, in the sense that it answers better to its truth determinants. That sense of better is what orders the work.

**Turnover-resilience.** The work must facilitate being worked on by many minds who do not know it beforehand and who have limited time and attention, capturing their iterative and accumulated contributions without becoming noisy and fractured.

## Terms

### «verisectorium»

A truth-centric, continually improving body of work, resilient to constant turnover; or a concrete instance of one with its ontology, data store and history.

- It is never finished. A «steady⸱state» is a resting point, not an end.
- No piece in it claims more than what has been done to it warrants, and none is left as if nothing had been done when something has.
- Every piece of its content answers to at least one of its truth determinants; a piece that answers to none is a note about the verisectorium, not content of it.

### «truth⸱determinants»

The aspects of truth a verisectorium declares that its content answers to, and against what: logic under stated hypotheses; the world, through runs and measurements; a proof checker; cases; its own consistency; an established canon; a source it must stay faithful to.

- They are declared, once, for the verisectorium; every «veritoid⸱kind» says which of them its content answers to.
- "Better" means answering better to them. Work ordered by anything else is somebody's mood wearing a number.
- A piece may answer to more than one. An explanation answers to what it explains and to a reader.

## Discussion

- Why "truth determinants" rather than "truth". What people here have called branches of truth (true of the world; valid; lawful within a canon; faithful to a source; self-consistent) are each agreement with a different thing. Declaring the things answered to covers all of them without pretending a novel's world is true in the way a theorem is, and it ties to the *veri* in the name.
- Continual improvement often shows the other marks of a complex system: growth, interacting components, boundaries, operating principles, rules, feedback loops. None of those is definitional; a verisectorium is identified by the three properties in the intro.
- "Better", "answers to" and the like are plain English here, defined in terms of the truth determinants, not lexical entries of their own. Verbs and adjectives do not make sense without their referent noun, so the lexicon mints nouns and defines their verbs and states within them.

## Examples

- AAT. Claims answering to logic under named hypotheses; better is stronger claims more firmly established.
- A formal specification. Rules answering to their own consistency and to the intent behind them; better is no conflicts, every rule decided and exercised.
- A novel's world. Facts answering to the world's own canon and to the author's intent; better is self-consistency and fidelity.
- This repository, in sense (2): its `core/` is a verisectorium in sense (1) held by hand, whose truth determinants are the coherence of the model and its fidelity to the dialogs it was worked out in.

## Working Notes

- Open. Whether truth determinants are declared once per verisectorium or can be refined per kind. Lean: declared once; a kind says which of them it answers to, and may not add new ones.
- Open. The hard case: pedagogy answers to two determinants at once (what it explains, and a reader), and the two can disagree. Lean: allow more than one, as the invariant says, and let the kind say how they combine.
- Open. Whether "stated flatly" (see «theory⸱claim») is a property of truth-centric work generally or only of the theory regime. Lean: the regime's.
- Adjudicated against msc/notes 09 §1, 11 def-verisectorium, 13, 14, and Joseph's rewrite of this intro (2026-11-06).
