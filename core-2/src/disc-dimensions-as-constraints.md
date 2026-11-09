---
slug: disc-dimensions-as-constraints
form: disc
status: provisional
narrates: [dimension, frontier, reference, kind, checkpoint]
---

# Dimensions are constraints

*Moved from the first-iteration overview (`MODEL.md`, Fable 5.1, 2026-11-08) into a segment of its own on Joseph's suggestion, so that it narrates the defs it rests on and lapses when they change. Provisional. Where a thing is Joseph's it says so; [M] marks the least tested.*

A «dimension» is one question that can be asked of a piece. The ontology declares each one with five things, plus an optional sixth, and the census of what the estate's verisectoria actually adjudicate is why there are five and not two:

| The declaration says | For example |
|---|---|
| **asks**: the question | does the statement as written follow from its premises? |
| **of**: which kinds it applies to | claims |
| **against**: what the piece is held to, where that varies per piece, how a piece names it | logic, under the hypotheses the claim states; or "the source this quotes", named by a reference |
| **produced by**: what act answers it, and whose acts have standing | a ‹check› by a mind re-deriving, not the author |
| **read as**: how the warrant is read from the acts that still bind | the highest rung reached by a confirming check, unless a later check is broken; narrowed counts as a split signal |
| **passes along**: what it does to pieces that reference this one, per reference kind | caps: nothing predicated on this can be warranted above it |

A dimension with no producer is a wish, and the ontology checker refuses it. "Nearly every question has a second argument, and the second argument is what moves" (census): the *against* slot is that argument, and an act answering the dimension must read what fills it, so freshness, eras and fidelity targets are all one mechanism: something read has moved.

For each piece and each dimension its kind opens there are two things, kept apart:

- Its **assertion**: what the content says about itself on that question, written by the author. ASF's "exact", "conditional on (S1)–(S5)", "axiomatic", "ratified", "faithful to §4" are assertions. A dimension says whether pieces may assert on it and in what form. There is only ever one; the former ones are in the acta.
- Its **warrant**: what the acts that still bind warrant, read as the dimension declares. A piece's *own* warrant is read from the acts that concern it; its *effective* warrant is the own warrant lowered by whatever caps along its references (nothing is warranted above what it rests on). The constraint below compares the assertion with the effective warrant; own above effective is information a working agent wants to see (a well-checked claim on an unchecked premise), not a violation. A warrant can be *never asked*, which is a value and not a gap, and a dimension not opened for a piece's kind is a fact and not a gap.

The **constraint** is: assertion ≤ warrant, on the dimension's own ordering. Where it fails the piece is **overclaimed** and that is owed. This is the whole honesty rule. It dissolves "claimed level" as a term (an assertion on one dimension), "one current epistemic label" (one assertion per dimension), and "softening" (replacing an assertion by a weaker one, or narrowing the content so a weaker assertion is true of it). ASF's one-word `status:` was several assertions on several dimensions of several veritoids, typed once on the file; the model has nowhere to put that word except as a rendering of per-veritoid assertions, which is where it should have been.

**Determinants.** The ontology marks some dimensions ‹determinant›: those that say what being *right* consists of for this work, and over which "better" is read (`disc-better`). Validity against logic, agreement with the world, fidelity to a source, consistency with a canon are determinants; importance for a target, freshness, who decided, and who moves next are dimensions that organize the work and are not. This is what "truth determinant" turns out to be: a role of some dimensions, declared, with no machinery of its own. Your "aspect × standard" carve was asking of a determinant what *asks* and *against* already say of every dimension. [Your lean of 11-08, "synonym for or subset of dimensions"; subset, since importance is adjudicated and is not an aspect of truth.]

**Intrinsic constraints.** Every verisectorium has these whether or not its ontology says so; they are what the tools and the model supply, and they are your "underlying current":

1. No piece asserts more than its acts warrant (above).
2. Every reference holds: its target exists, is at the version the reference last saw, and is warranted at least at what the reference needs.
3. Nothing is warranted above what it is predicated on (passes-along: caps), and the predicated-on graph has no cycles.
4. In every segment, every inner dependent of a changed veritoid was changed or affirmed in the same write (this one is a refusal at the «changeset», not a frontier item).
5. What a check or finding says is broken has been dealt with, or its remaining-broken is accepted with a reason.
6. Every dimension has a producer.

The ontology adds its own constraints, stated over dimensions, the same way.
