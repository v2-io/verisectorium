# Thoughts toward a more principled model, for mathematics-heavy theory

*Fable session, 2026-11-06, in answer to Joseph's question after the label and Epistemic Status readings. My thinking, untested. It draws on: 790 inline labels read (435 with free text, all read); 62 of 220 Epistemic Status sections read; FORMAT's definitions of type, status, stage and its triage; the stopped-bound case; and general knowledge of how proof assistants organize mathematics, which is from training and not checked here. It does not yet touch `model-and-lexicon.md` or the def files.*

## The observation everything rests on

When ASF's authors tried hardest to be honest, they almost never wrote how sure they were. They wrote **what exactly is being claimed** (under which conditions, how sharply, forced or chosen, resting on what, whose, and what is not being claimed) and **what had been done to check it**. The one-word status then tried to summarize all of that and could not.

So the thing that needs structure is not a ladder of confidence. It is the claim.

## Mathematics already has a canonical shape for a claim

> In a **context** (definitions, standing assumptions, choices already made), under **hypotheses**, a **conclusion** holds, by a **derivation** from named premises.

Every free-text label I read is an attempt to fill in one of those five places. I think the principled move is to make that shape the structure of the content itself.

## What follows if that is taken seriously

1. **Strength is entailment, not a level.** One statement is stronger than another if it implies it: weaker hypotheses, or a stronger conclusion. That is a real order that mathematics supplies. "Soften" means replace a statement by one it entails. "Strengthen" means the reverse. "Narrowed" stops being a special case: it is a move down that order, and the question it puts to each dependent is precise. *Does your use still discharge the hypotheses?*
2. **"Conditional" is content.** It says the statement has hypotheses beyond the standing context. It is not a lower grade. A conditional result with a complete derivation is fully established as the if-then it is.
3. **Whether the hypotheses hold somewhere is a different claim, about a different thing.** It belongs to the application or the reading, not to the statement. ASF says this in prose over and over: "properties of the application", "model quality, not proof quality".
4. **"Exact", "robust-qualitative", "heuristic" describe the conclusion's form**: an identity, a sharp threshold, a bound, a scaling to leading order, a direction only. That is content too. Where a segment says "exact in the linear-Gaussian case, robust-qualitative in general", it holds two statements, one a special case of the other.
5. **"Forced" versus "chosen" is whether a uniqueness result stands behind a choice.** A formulation is a choice. If something proves it is the only form the earlier material allows, that proof is a statement of its own, and the choice now rests on it.
6. **A dependency is a use.** To use result B inside the derivation of A, A has to meet B's hypotheses. So a pointer from A to B is not just "A needs B". It is "A invokes B here, and B's hypotheses are met by these". The stopped-bound error was exactly a mismatch of this kind: the step invoked delivered one quantity and the statement claimed another.
7. **What is left as genuinely about support is small and uniform.** For a derivation: is it complete, and what has been done to it. For an import: has it been checked at its source, and are its hypotheses met where it is used. For a reading: has the correspondence been verified. For a simulation or measurement: what was run. Each is a record of acts, with the question each act asked.

## What the store could then compute, and I think this is the heart

For any statement: **everything it rests on, all the way down, with what has been done to each.**

Something like: *this result rests on two postulates; three formulation choices, one of them forced; one imported theorem not yet checked at its source; one unproven hypothesis; and fourteen derivations, of which three have never been independently read and none has been attacked.*

That is what an Epistemic Status section is trying to say by hand. It is also, as far as I know, what a proof assistant will tell you about a theorem when asked which axioms it depends on. I think a mathematics-heavy verisectorium is the informal version of that structure, with recorded human and agent checks where the proof assistant has a kernel, and with the amount of checking recorded and not assumed. Formal verification is then not a different system. It is the strongest kind of act available on the same structure.

A one-word status such as "exact" becomes a display computed from this, and one that can always be opened up.

## Kinds of content this suggests, for a mathematical theory

Each kind differs in what can sensibly be asked of it.

| Kind | What it does | What can be asked |
|---|---|---|
| definition | stipulates | Is it well-formed given what came before? Is it used consistently? Does it capture what it is advertised to capture? (That last is a claim.) |
| assumption (postulate, scope condition, named hypothesis) | is taken, not derived here | Where does it hold? Is it needed, with the case that shows it? |
| choice (formulation, convention) | selects among alternatives | What were the alternatives? Is it forced? What survives a different choice? |
| statement | context, hypotheses, conclusion | Is there a derivation? What other support? |
| derivation | steps from premises | Is each step valid? Does each use meet the hypotheses of what it invokes? Is it complete? |
| import | an outside result as used here | Is it stated faithfully? Checked at the source? |
| reading | maps the theory's objects onto something else | Does the correspondence hold? |
| observation | reports a run or a measurement | What was run, under what, and is it reproducible? |
| explanation | teaches | Is it faithful to what it explains? Does a reader get it? |
| non-claim | says what is not being asserted | (stated, and consulted) |

## What I am unsure of

- **Cost.** Writing hypotheses and uses as structure for every statement is real work. In its favour: 138 labels already name what a piece rests on and 95 already name its conditions, in free text. The information is being written anyway.
- **How much of AAT is this shape.** The appendices are. The modelling, the scope arguments, the discussion segments and most of volumes 2 to 4 are partly something else. This is a model for the mathematical core, with the other kinds of content beside it.
- **Whether "context" should be its own thing.** ASF has a scope lattice (adaptive, agency, learning-agent, Class 1, composite), and results hold from their scope inward. A proof assistant would make that a first-class structure. I have not thought it through.
- **Whether this is the same idea as RC1's "the ground opens the lines"**, seen from the content side. I think so: the kind of content decides what can be asked of it.
- Everything here about proof assistants is from general knowledge. Someone should check it against a real one before leaning on the analogy.

## A cheap test

Take `deriv-sector-condition` at the pre-sprint tag and write its Prop A.1S in this shape: context, hypotheses, conclusion, derivation steps, and what each step invokes. Then see whether the false step shows up as a use whose hypotheses or output do not match. If it does not, this structure would not have helped with the one error we have studied closely, and that would be worth knowing.

---

## Addendum, same day: Joseph on why the claim is central

His words, after reading the above:

> one of the reasons I kept feeling that the earlier attempts at verisectorium (especially for ASF) were failing was because they kept making "claim" something less central than it seemed to be to me. Not all verisectoria have claims--- but the branching chain of claims is exactly what has been the principle driver of discovery for theory.

> ASF has worked very hard to *state the currently known truth* -- if there was ever any lower credence in the mind of any agent, it was put in working notes as something to check […] So what was left was a binary claim that also made it falsifiable. That's the wisdom of making credence and/or standing and/or importance distinct from truth-claims.

> The things that ASF doesn't have much of (but probably needs more) are empirical and statistical facts + "proposed models" (even if mathematical in notation) --- those kinds of matters that aren't necessarily expected to ever settle on a binary "true" but can often be falsified and that have "effective credence" that justifies building on it further (as a work prioritization and workflow decision, not a truth determination). That's kind of what the verisectorium engine ended up circling around, which is actually a bit of an edge-case in terms of ASF...

What I take from it (mine):

- **Two regimes, and the earlier designs built for the less common one.** A theory claim aims to be true or false, is stated flatly, and is settled by derivation and refutation. An empirical fact or a proposed model is not expected to become "true"; it is more or less adequate, can be falsified, and is built on by decision. Graded weight of evidence is native to the second. RC1 and PLAN put most of their machinery there.
- **In the first regime, doubt is a list and not a number.** ASF's discipline was: the body says what is currently held true; any doubt becomes a named thing to check, placed beside the claim. So how uncertain a claim is, is the set of specific things not yet checked or still questioned about it. Each is work, and each can be closed.
- **The two regimes join at the hypothesis.** A theorem that rests on a proposed model is still a flat if-then: *if the model holds, then this*. The model's adequacy carries the graded part. Nothing graded leaks into the theorem.
- **"Effective credence that justifies building on it" is a decision**, about where effort goes, made on the evidence so far and on how much rests on it, and reopenable.
- **Claim-centred is a property of a theory store's definition, not of the engine.** A store of specification rules has decisions at its centre.
- **A caution from the stopped-bound case.** The flat-claim discipline only works while doubt has a live place to go and reopening is cheap. That segment said "exact" in the body and "RESOLVED — do not re-open" in the notes.
