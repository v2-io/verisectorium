# Guesses, written before anything was run

*2026-11-10/11, spike lead. Every line here is a guess from reading the model and from memory of the tools. None has been run. They are written down first so that it can be seen afterwards which ones the tools overturned. `05-what-the-guesses-came-to.md` (written last) says what became of each.*

## Datalog, answer-set programming, tabled Prolog

- G-D1. The table "written, done, computed" is Datalog's own split between stored facts and derived facts: a derived relation cannot be inserted into. Datalog will not see any difference between *written* and *recorded*; it will instead split stored facts by whether rules use them only positively (they mean the same for ever) or under a "latest" (they need the line). I expect that split to coincide with the spec's base and line.
- G-D2. Datalog computes least fixed points, and consistency in the spec is a greatest one. I expect the natural Datalog definition to be of *fault* (a piece has a violation of its own, or rests on one that has), with consistent as its absence. If so the choice of "greatest" that both builds report (R7, not unique) is not a choice in this view: a piece is at fault only for a reason.
- G-D3. The lead's guess that stratification is the builds' finding (b). My sharper guess: the three pathologies have three standard names. A question conditioned on its own piece's consistency is an odd loop through negation (no stable model). Two questions each conditioned on the other piece are an even loop (two stable models, no greatest). Two pieces resting on each other are a positive loop (one stable model; least and greatest fixed points differ). I expect clingo to return 0, 2 and 1 models, and SWI-Prolog's well-founded tabling to answer *undefined*, *undefined* and *false*.
- G-D4. "Unconditional" is blunter than needed. A decision conditioned on how well an *upstream* piece stands should be harmless as long as nothing loops back; the exact condition would be no cycle through a condition, a property of a state like the spec's "no capping cycle". If so the builds' G11 (an acceptance that should reopen when a named assumption fails could not be said) has an answer that does not need the rule relaxed everywhere.
- G-D5. A waiver conditioned on a piece being consistent is monotone the harmless way (more consistent, more waived, more consistent). I expect it to have two fixed points and a greatest, unlike a conditioned question, so that the builds' rule lumps together two different things.
- G-D6. "Good news does no harm" is a statement about polarity: good evidence appears in the derivation of *owed* only under an odd number of negations. I expect to be able to read R6, and the fact that a set-aside is not good news (Ada G8), off the rule dependency graph without running a state.
- G-D7. Datalog has no append, only sets. I expect it to land directly on the reading both builders had to take (a line is a set of timed events; a state is read as of a time; closing is union).

## Lean 4

- G-L1. What can be a *type* is what is true even on an abandoned fork: ids are never reused, versions are immutable, evidence is about a version. Everything in the nine conditions must stay a proposition about a state that may be false, since a fork has to pass through states that violate them. So "the model as types" will come out as three tiers: unrepresentable, refused, owed; and nearly all of the model's content is in the third.
- G-L2. A checkpoint can be a type that cannot be built without a proof that its state is stationary. That is "computed, never typed" as a typing rule.
- G-L3. Evidence is a family of types indexed by version, and **same** is what lets a value be carried from one index to another. I expect this to recast "same" as: evidence is about a *view* of a version (what the criterion can see), and normalization, graded reads (existence only) and attested sameness are three cases of one thing.
- G-L4. Lean will refuse to define consistency when a question is conditioned on it: as an inductive predicate by the positivity check, as a coinductive one by the monotonicity obligation. The same finding (b), a third way.
- G-L5. Lean's logic has weakening (more hypotheses never unprove anything) and the frontier does not (bad news adds to it). So "owed" cannot be provability from the record; it has to be a function on a closed state. I expect that to be the main thing Lean has no native way to say.
- G-L6. Small theorems should go through for unbounded numbers of pieces, which neither build gives: blame as reachability, good news antitone, a frame property.

## Alloy 6

- G-A1. Alloy has transitive closure and no recursion. I expect that, with obligations unconditional, consistency needs no fixed point at all: a piece is consistent when nothing it transitively rests on has a violation of its own. If Alloy can state the whole state-to-frontier function with closures only, the fixed-point language in the spec is heavier than what it says.
- G-A2. Alloy will find the builds' small counterexamples from declarative statements with no generator written: the ring, the two forks that write different pieces and cannot both close.
- G-A3. Two forks that write different pieces and each read what the other wrote is *write skew*, an anomaly with a literature. I expect Alloy's smallest instance to have that shape.

## TLA+

- G-T1. "Many steps inside, one logical instant from outside" is refinement with stuttering: the steps on a fork are invisible to a specification whose only steps are checkpoint to checkpoint. TLC should be able to check that a fork-level specification implements the checkpoint-level one.
- G-T2. TLA+ will force a choice the model has in prose: evidence arriving against a checkpoint changes what the checkpoint owes with no step on the main line. Either the base is part of the visible state, and learning is a visible step, or R11 is false as an invariant. I expect it to say: two visible steps, *learn* and *close*.
- G-T3. Interleavings of two forks closing will reproduce the builds' clock case (a write that counts as having affirmed something its writer never saw).

## From other bodies of work (to be read, not run)

- G-O1. Truth maintenance systems, the assumption-based kind especially, already hold "what was learned on an abandoned line is still known": every datum carries the sets of assumptions under which it holds, and switching context recomputes nothing.
- G-O2. Build systems with verifying traces already hold "evidence records what it read at which versions and counts while those are unchanged", and early cutoff is "same".
- G-O3. Both builders say the fork-meeting condition is the read-set and write-set condition of transaction processing and neither checked a text. I expect the texts to say more than that: the specific failure is write skew under snapshot isolation, and the known repair looks for a particular pattern of read-write dependencies, not for any overlap.
- G-O4. The base-and-line split is the split the CALM theorem draws: what is monotone needs no coordination, what is not needs an order.
