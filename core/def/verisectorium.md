```kdl
term "verisectorium" pos=noun pl="verisectoria" {
  avoid "repository" "where files happen to live; a verisectorium may span several or none"
  avoid "knowledge base" "suggests settled facts; a verisectorium is mostly work in progress, honestly marked"
  rel declares     term="truth⸱determinant" card="{1,N}"
  rel described-by term="ontology" card="{1,1}"
  rel persisted-in term="data⸱store" card="{1,1}"
}
status provisional
```

## Definition

A «VERISECTORIUM» ("place for cutting truth") indicates one of:

- (1) A place for dissecting and adjudicating new or existing content, refining it toward truth as given by its declared «truth⸱determinants», and reassembling the parts into meaningful coherent results. It is therefore a body of work that is *truth-centric*, exhibits *continual improvement*, and needs to be *resilient to constant turnover* (see Discussion items 3,4, & 5);
- (2)  This repository and project's name, which describes «verisectoria» generally, gives their meta-«ontology», and provides tooling (`v2`) for initializing and operating instantiations of them (see Discussion item 1 & 2);
- (3) A concrete instance of (1), with its «ontology», the current snapshot of its «data⸱store», and often (as when it is a repository) its history.

### Invariants
*(These are loose approximations. The more detailed components of the «verisectorium» definitions specify these invariants authoritatively.)*

- No piece in it claims more than what has been done to it warrants, and none is left as if nothing had been done when something has.
- Every piece of its content answers to at least one of its «truth⸱determinants»; a piece that answers to none is a note about the verisectorium, not content of it.


## Discussion
1. Sense (2) is kept in the definition because the rest of the estate already refers to this repository as the place where verisectoria are defined and the tool that helps.
2. This repository, in sense (2), has its `core/` as a verisectorium in sense (1), held by hand, whose truth determinants are the coherence of the model, consistency, its efficacy as a model and tooling to facilitate verisectoria instances as defined, and its ability to quickly instill a working mental model for those implementing new instances. *(It should be noted however that this repository/project does *not* use `v2` because it is still manually getting to a bootstrapping threshold. It may also be inconsistent with what it *defines* as canonical vs. what it uses in practice within this initial bootstrapping phase.)*
3. **Truth-centrism**
  Aspects of truth (internal coherence, authenticity, factual correctness, completeness, fidelity, and so forth), under stated hypotheses, are being adjudicated, discovered or organized, or are what the work must stay faithful to. Which aspects, and against what, are the verisectorium's declared truth determinants.
4. **Continual improvement**
  The work is rarely considered finished; it is a living body of work, evolved through interaction. Over time it is expected to get *better*, in the sense that it answers better to its truth determinants. That sense of better is what orders the work. Continual improvement often shows the other marks of a complex system: growth, interacting components, boundaries, operating principles, rules, feedback loops. None of those is definitional;
5. **Turnover-resilience**
  The work must facilitate being worked on by many minds who do not know it beforehand and who have limited time and attention, capturing their iterative and accumulated contributions without becoming noisy and fractured.

## Examples
- AAT. Claims answering to logic under named hypotheses; better is stronger claims more firmly established.
- A formal specification. Rules answering to their own consistency and to the intent behind them; better is no conflicts, every rule decided and exercised.
- A novel's world. Facts answering to the world's own canon and to the author's intent; better is self-consistency and fidelity.
- (This repository's core, as described in the Discussion).

## Working Notes
- Open. Whether "stated flatly" (see «theory⸱claim») is a property of truth-centric work generally or only of the theory regime. Lean: the regime's.
- When later segments (projections, etc.) are finished, consider forward-referencing them better from here.
