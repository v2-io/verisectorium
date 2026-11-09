```kdl
term "truth·determinant" pos=noun pl="truth·determinants" {
  synonyms "determinant" "aspect"
  avoid term="fitness function" def="A way of scoring agreement with the determinant"
  rel declared-by term="verisectorium"
  rel advanced-by term="veritoid·kind" card="{0,N}"
  rel advanced-by term="segment·kind"  card="{0,N}"
}
status provisional
```

# «Truth·Determinant»
An aspect of truth with the standard it is held against that motivates some portion of a verisectorium's content.

## Definition
«Truth·determinants» have two parts:
1. The *aspect* says in what way the content is to be right, e.g.:
  - validity
  - factual correctness
  - internal coherence
  - fidelity
  - completeness
  - authenticity
  - effectiveness
  - comprehension.
2. The *standard* says what it must agree with, e.g.:
  -  logic under stated hypotheses
  - reality (our universe and universal law)
  - an established canon
  - a named source (for fidelity, for example)
  - the intent behind the work
  - a reader

The standard is what the content must agree with, not the means of finding out whether it does. A derivation, a measurement and a proof checker are ways of finding out. Where the standard differs from piece to piece, the determinant names it by role ("the work this entry cites", "the result this explains") and each piece says which.

A «verisectorium» declares its «determinants|truth-determinant» in its «ontology», and each «veritoid·kind» and «segment·kind» says which of them its content answers to. A piece answers to a determinant when it is in the service of it: it asserts something the determinant settles, or it asks, doubts, explains or records in aid of settling it.

"Better", said of a verisectorium or of anything in it, means answering better to its determinants, or having been shown more firmly to.

### Invariants
- It has a name in its «ontology», and it names both an aspect and a standard.
- Determinants are declared in one place, for the whole verisectorium. A «veritoid·kind» chooses among them and adds none of its own.
- Every «veritoid·kind» answers to at least one. Material that answers to none is a note about the verisectorium, not content of it.
- A piece may answer to more than one, and each is asked about separately. Agreement with one never stands in for agreement with another.
- To add, drop or change a determinant is to change the «ontology», and so what "better" means. It is a «perturbation».

## Discussion
1. **Why "truth determinants" rather than "truth".** What have been called branches of truth (true of the world; valid; lawful within a canon; faithful to a source; self-consistent) are each agreement with a different thing. Declaring the aspect and its standard covers all of them without pretending a novel's world is true in the way a theorem is. "Truth" also ties to the *veri* in the name, and it is meant broadly, as in «verisectorium»: for an explanation or a tool, being understood or working as intended is what being right comes to.
3. **"Better" gives a direction, not a queue.** Two versions can each be better on a different determinant, with neither better overall; which to prefer is a decision. And among real improvements, where effort goes next is a decision too, which may weigh importance for some target.
4. **A determinant is not a «dimension».** A dimension is a question asked of a piece; a determinant is what some of those questions are about. Several dimensions can bear on one determinant: whether a claim's derivation has been checked and whether it has been formalized both bear on validity against logic. Some bear on none: how important a piece is for some target says nothing about whether it is right.
5. **Nor is it a «criterion» or a «ground».** A criterion is what one act was performed against, fixed before its result. A ground is what an author states could ever support one piece. A determinant holds for the whole verisectorium.
6. **Some determinants are met or not; others by degree.** Validity against logic is met or not. Adequacy to the world comes by degree. That difference is what separates a «theory·claim» from an «empirical·fact» or a «proposed·model».
7. **It does not say how right anything is.** It says what being right would consist of. How far a piece has got is a «value».

## Examples
*Illustrative. No store has declared its determinants yet.*

| Verisectorium | Aspect | Standard |
|---|---|---|
| AAT | validity | logic, under each claim's stated hypotheses |
| AAT | completeness | the questions the theory undertakes to settle |
| AAT | reproducibility | reruns of what it simulates |
| An empirical study | factual correctness | the world |
| A formal specification | consistency | its own rules |
| A formal specification | fidelity | the intent behind them |
| A novel's world | consistency | the world's established canon |
| A novel's world | fidelity | the author's intent |
| A library of citations | factual correctness | the work each entry cites (by role) |
| A journal of raw reflections | authenticity | what the writer thought at the time |
| This repository's `core/` | coherence | the model, read whole |
| This repository's `core/` | consistency | its own terms |
| This repository's `core/` | effectiveness | the instances and tooling built from it |
| This repository's `core/` | comprehension | someone implementing a new instance cold |

Completeness is what lets AAT's "stronger claims" count as better: on validity alone, a store softened to tautologies would be perfect.

## Working Notes

- Decide. The second invariant: one declaration for the verisectorium, and a kind chooses among them and adds none. Lean: as written. A store whose kinds need a new determinant has found its declaration incomplete, which is worth an ontology change.
- Decide. «verisectorium» Discussion 4 says this sense of better "is what orders the work". Discussion 3 here reads that as direction: better says what counts as an improvement, and where effort goes among improvements is a separate decision. If "orders" meant a queue, Discussion 3 is wrong.
- Decide. Whether every «dimension» either names the determinant it bears on or is declared as organizing the work, and whether a ‹finding› names the determinant it says is broken. Lean: yes to both. Until then nothing computes from a determinant, and accepting this term accepts that.
- Open. Two determinants that disagree: fidelity to what an explanation explains and comprehension by its reader, where the clearest telling may not be the most faithful. Lean: they stay separate questions and are never combined into one score; where they conflict, which yields is a «bound», consulted at the moment.
- Open. How a piece fills a standard named by role. Lean: through a «reference».
- Open. Whether at least one determinant must be held against something no write to the store can change. Lean: yes; every example above has one. It would not settle whether a store is pointed the right way: AAT passes through logic alone (msc/notes 16, question 3).
- Open. What a change of determinant does. Acts already recorded served some determinant, and whether they still bear on anything is not a question of whether old data loads (`msc/scratch/rowan-ash-research.md` §5 raises this for dimensions). «atomic·changeset» has no place yet for a write to the «ontology». And the standard can move while the text does not: a canon grows, a cited work is corrected, intent shifts. That would be an ‹outside·change›, and intent can only be read by asking someone, which meets the open gap on steward attestation.
- Open. Whether aspect names form a shared vocabulary or each ontology coins its own. Lean: each its own, until two or three stores exist.
- Adjudicated against msc/notes 13 (the "answers to" lens), «verisectorium» Discussion items 2 to 4, Joseph's rename to truth determinants (2026-11-07), his reading of "answers to" as "in the service of" (2026-11-08), and the cold read at `msc/scratch/truth-determinant-denovo-1.md`.
