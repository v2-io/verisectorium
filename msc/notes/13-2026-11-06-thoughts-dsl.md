# Thoughts on a language for describing kinds of verisectoria

*Fable session, 2026-11-06, in answer to Joseph's question: is there something more expressive than node-and-edge graphs, in which one could say in a few lines "here is mathematical theory", "here is empirical work", "here is one with an automated-proof aspect", "concept engineering", "a formal spec", "world-building for a novel", "an app pipeline"? A sketch, untested. Nothing here is a syntax proposal; the blocks are illustrations of what would need to be sayable.*

## Where the expressiveness would come from

Not from a richer data model. A graph of nodes and edges can already hold everything. What it cannot do is *mean* anything: an edge called `rests-on` is just a label until something says what happens at one end when the other end changes.

So the gain would come from a vocabulary whose words carry behaviour. Three things would each be declared once, with their behaviour, and then merely named in a store's definition:

1. **Stances.** What a piece of content does, and so what it answers to.
2. **Relations with consequences.** Not "A points at B" but "A must stay in agreement with B in this way, a change at B does this to A, and this kind of act checks it".
3. **Ways of settling.** The kinds of act that can answer a question: derive, find a counterexample, measure, simulate, check at the source, run the tests, machine-check, walk a reader through it, scan for contradictions.

A store definition is then short because it only selects and names.

## One lens that seems to cover all seven of your examples

> Every piece of content **answers to** something, and getting better means agreeing better with what it answers to.

| Store | What its central content answers to |
|---|---|
| mathematical theory | logic, given the hypotheses |
| empirical work | the world, through runs and measurements |
| automated proof | a proof checker |
| concept engineering | cases, and the job the concept is wanted for |
| a formal spec | its own consistency, and the intent behind it |
| world-building | the world's own established facts, and the author's intent |
| an app pipeline | the requirements, and what actually runs |

That gives your "branches of truth" one frame: true of the world, valid, lawful within a canon, faithful to a source. Each is agreement with a different thing. I offer it as a lens, not a result.

## Three layers

- **Core, small and fixed.** Content; wholes assembled from it; questions that can be asked; acts that answer them; pointers; changesets; the log. This is what `model-and-lexicon.md` has been circling.
- **A library of patterns, which grows.** The stances, the relations with consequences, the ways of settling, and the ways a whole reads its values from its parts. Each defined once, in terms of the core.
- **Store definitions, short.** Which patterns, under what local names, with what at the centre, and what "better" means here.

RC1's kinds-by-failure-mode would live in the second layer, as one way of telling stances apart. Its weakness, as you put it, was not being complete enough about the evidence patterns and living-document patterns. In this arrangement those are library entries that can be added one at a time as real stores need them, without reopening the core.

## What a few lines might look like

Illustration only. Every word on the right would be a library pattern with defined behaviour.

```
store mathematical-theory
  centre   claims, chained by rests-on
  better   stronger claims, more firmly established
  claim        asserts            settled by derivation, or broken by counterexample
  assumption   is taken           asked: where does it hold; is it needed
  definition   stipulates         asked: well-formed; used consistently; captures its intent
  choice       selects            asked: what else would fit; is it forced, by which claim
  derivation   argues for a claim each step uses a claim or an import, meeting its hypotheses
  import       carries a result   checked at its source
  explanation  explains a claim   faithful to it; lands with a reader
  doubt        goes beside the claim as something to check, never into it
  whole        result = claim + assumptions + derivation + explanation, read whole for coherence

aspect automated-proof  on mathematical-theory
  derivation   may be formalized  settled by machine check, the strongest act on "valid"
  claim        formal statement must be faithful to the written one

store empirical-work
  centre   findings, chained by supports (graded)
  better   more of the world accounted for, more reliably
  observation  reports a run      reproducible; tied to the instrument's version
  model        proposes           adequate for a purpose, by degree; broken by an observation
  build-on     a model, by decision: evidence so far, and how much will rest on it; reopenable

store concept-engineering
  centre   concepts, linked by refines, contrasts-with, replaces
  better   does the work it is wanted for
  concept      stipulates and proposes   tested against cases and against stated desiderata
  case         reports an intuition or a use   may count for or against a concept

store formal-spec
  centre   rules, linked by depends-on and consistent-with
  better   no conflicts; every rule decided; every rule exercised
  rule         decides and prescribes    backed by a rationale; reopened when a named assumption fails
  example      asserts input gives output   settled by running it against the implementation at a version

store world-building
  centre   established facts, linked by consistent-with, placed on a timeline
  better   self-consistent; faithful to intent
  fact         establishes, within the world
  scene        must be faithful to the facts it touches
  undecided    is marked as such, and may be settled by the author only

store app-pipeline
  centre   requirement, design, code, test, release, chained by realizes
  better   conforms, and works
  requirement  commits
  code         realizes a requirement    settled by tests that run
  decision     selects                   with what would reopen it
```

## Things I notice in that sketch

- **The same few relations recur.** `rests-on`, `faithful-to`, `consistent-with`, `realizes`, `explains`, `replaces`. Six or so may cover a great deal, if each is defined with its consequences.
- **The centre differs, and that matters.** Claims chained by support; rules held consistent; facts held consistent on a timeline; a pipeline of realizations. Earlier designs assumed one centre.
- **An aspect is a short addition to an existing store,** which is what "ten lines for an automated-proof aspect" needs. The language would have to let one definition extend another.
- **"Better" has to be said per store.** It is what decides where work goes.
- **Doubt has a stated place** in the theory store, as you described ASF's practice.

## A comparison you are better placed to judge than I am

What I am describing resembles a declarative resource framework more than a graph language: named kinds with attributes; relationships that carry behaviour; actions with preconditions and rules about who may take them; values computed from other data; changesets as the unit of writing; and extensions that add all of those to an existing definition. Ash is the one I know of, and Rowan is your port of it. If that resemblance is real, then much of the shape of such a language has already been worked out there, and the verisectorium-specific part is the library: the stances, the relations with their consequences, and the ways of settling. I know Ash only from training and have not looked at Rowan, so treat this as a lead to check.

## What I do not know

- Whether six relations and ten ways of settling are really enough, or only look enough from seven one-paragraph sketches.
- Whether "answers to" survives a hard case. Pedagogy answers to two things at once: what it explains, and a reader.
- How change across stores works when one store's content answers to another's.
- Whether the right move is a language at all yet, or two or three hand-written store definitions first, with the language extracted from what they share. I lean to the second, starting with the mathematical-theory one for AAT and the formal-spec one for udon, since both have real material and differ at the centre.
