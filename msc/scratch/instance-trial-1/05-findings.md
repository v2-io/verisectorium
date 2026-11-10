# Findings: where the model left me guessing, contradicted itself, or lacked a word

**The verdict first.** The model is usable for this. From `core/` alone I could declare an ontology, place every piece, and run two moves. Once I had fixed the ontology choices below, every frontier cell came out the same on recomputation. The machinery is mechanical in the good sense. What follows is where it wasn't. I've ordered them by consequence, not by the order I hit them. The numbers match the markers in the other files.

## Structural

**12. Every changeset's scope reaches the canonical projection, so scopes always meet there.** «segment» says accepting an assembly "rests on what fills its required slots being accepted", and an accepted segment resting on an unsettled one is unsettled and owed. The spec's slots are required, so any disturbance anywhere unsettles a section, then the spec, and the spec is in the scope. Two moves in unrelated sections therefore meet at O and become one changeset. "Steadiness is said of a place" collapses back to the whole, which is the outcome it was written to avoid. `impl-two-moves-at-once` didn't hit this because no projection holds T/U/V/W. The way out is already in «reference»'s Working Note: a whole that *names* its parts does not rest on them. But that is a lean in an inbox, and the «segment» body says the opposite. For my O, acceptance meant "these sections, in this order, cohere". It did not need to mean "and every section is settled right now".

**1 / 6 / 15. In a decision-centred verisectorium the decisions are the substance, and they live in the acta, where no reference can reach them.**
- A rationale explains a *decision*. But references point segment → segment, and a decision is an act. So x1 could only narrate the rule. When the ground under the decision changed (move 1, step 5), the rule stayed the same, nothing went stale, and the now-false rationale was caught only because A2 happened to read it.
- Premises are reached only through decision bases. The orphan rule counts only canonical projections and predicated-on references, so the grounds segment was an orphan until I gave the spec a slot for it.
- "Rests on" is used in «segment», «frontier» and «changeset» but never defined in terms of edges. Does it cover predicated-on only? Narrates? Slot pointing? A decision's basis? I took predicated-on plus required slots. That choice is what produced finding 12.

The underlying design question, for Joseph: is the record a specification's readers most want (alternatives weighed, grounds, what would reopen it; an ADR) a *rendering of acts*, or *content*? If it is a rendering, a rationale veritoid duplicates a basis and has nothing to be faithful to. If it is content, the decision should read it, so that rewriting the reasons reopens the decision. Then it also has to reach the premises, so that a ground falling makes the reasons stale. The model currently has it neither way.

**3 / 17. Is applying a rule an actum, and what does a rule-accepted piece owe when the rule stops holding?** «decision» says applying a rule is computed. «frontier» says a reopened acceptance waits until "the rule that stands in for one accepts it again", and «decision» says a decision by rule "is withdrawn only as the ontology says, never merely by failing". Taken together, a piece the rule accepted *once* stays in canon owing forever until a party withdraws it, while a piece the rule never accepted owes nothing. In move 2, e2 (once accepted) needed a waiver for a parser bug in another project, and e1 (never accepted, equally affected) needed nothing. That may be right, but it should be said. The waiver also goes against «steady·state»'s "never for work that is merely elsewhere", and the model had no other exit.

**16. "Only canon owes" plus a strict acceptance rule hid the one real error.** e1 was wrong at S0, and S0's stated conditions were *empty*. The contradiction, when it came, opened no changeset. The stricter I made acceptance, the cleaner the steady state looked. I'd suggest that a contradiction against a provisional piece *held in a canonical assembly* be at least a stated condition, even if it is not owed.

## Mechanisms I had to invent

**4. What an unanswered finding does to a warrant.** Decision bases read "grounds at the warrant they then had" and reopen when one "falls or is contradicted". Nothing says whether a ‹finding› (no criterion) makes a ground fall. I invented *disputed*. The consequence was that one sentence from an unattested issue, routed by the editor, reopened a major two-seat decision and the canonical projection. That is `impl-a-finding-is-answered`'s choice 1, now with decisions downstream, and the cost is larger there than it looked.

**5. What an act reads of an assembly.** *Consistent* is held against "every other rule in canon", a set. For an added rule to lapse the check, the act must read the set's membership. But reading the assembly lapses the check on *any* slot change: adding a question re-costs every consistency check. The act def's read grains (whole written state, assertion, warrant) need a fourth: *the membership of one slot*. «segment» gestures at "what the kind says it reads of what the assembly holds" for reviews of the assembly. An act on a veritoid whose *against* is a set has no such thing.

**8. Instruments as means, and how an instrument loses standing.** See move 2. A means held against something other than the dimension's own *against* is a different dimension, and the model has no test that says so. And standing is "read from the record as the ontology declares", but nothing says how an instrument version's standing is lost once it is found wrong. Without my invented rule, every future run of kvlp@0.3 must be contested one by one.

**7. No act for a case put to a decision's party.** «decision» invites one ("any actor may put a reasoned case … to its party"). Contesting is for acts of finding out, and the routing outcomes don't include "put to the party". I wrote a question instead. It worked, but it is a workaround.

**10. A required slot with many fillers.** Must all of them be accepted, or at least one? It decided whether G was settled.

**11. Importance has no scale and no declaring home.** Decisions record "the importance it was decided at", and standing "may rise with importance", but importance is never declared: not by the ontology, not by the decision, not by anyone. I invented minor/major. Who decides a decision's importance is itself a decision, which is circular for the first one.

**14. Testimony binds to the wording of what it concerns.** Ines's "I asked six INI users" is a fact about the world, but it read p1@1, so rewording p1 lapsed it and it had to be carried. Its truth doesn't depend on p1's wording; only its bearing on p1 does. Separating "this happened" (testimony, binding to nothing written) from "this supports p1@2" (a cheap check that binds) would make premises rewordable without carrying.

**13 (small).** A decision's ground is often a truth claim about the corpus itself ("both separators make `a:b=c` ambiguous"), not about the world. The model handles it if it is written as a piece, but nothing prompts that. Left in the basis, it goes unchecked.

**9 (small).** Open questions in canon, and non-determinant dimensions never asked, appear in no steady state's conditions. q1 stayed open through every state unseen.

## What worked without strain

- (This was finding 2 before I resolved it.) The two atoms. Every adjudication in a decision-centred spec was one or the other, and *backed* (a decision) beside *consistent* (a truth claim) on the same rule was natural. Acceptance as a **rule over** backing and consistency, rather than a second steward decision, removed what would otherwise be a duplicate per rule. The model allows this but doesn't say it; the dimension examples table lists both "is this part of canon" and "who stands behind this choice" without saying how they relate in a specification.
- Decisions reopened by a failed ground, sustained on a new basis, and with no rule text changed (move 1, step 7). This is the heart of a specification, and the model got it exactly right.
- Intake, routing and retirement. Findings outlasting edits. Carrying. Answering by someone other than the repairer. Contesting (I produced the first specimen of a contest that overturns, in move 2, step 6).
- Written / done / computed. I never had to type a status.

## Vocabulary

I used about sixty of the model's words. I never needed: attribute, version (beyond `@n`), name, overclaimed, dangling, unmet, promised, suggested, gap (as a slot state), restates, supersedes, the better order or weighting, or rendering beyond a mention. The words I needed and didn't have: *importance* (as a declared thing), *slot-membership read*, *case/petition*, *rests on* (as a defined relation), *instrument standing lost*, and *waiting on outside*. So the model is not short of words. It is short of a few relations.

## On the request

Building was a better test than another read, and I think a sharper one. Four of the findings above (12, 3/17, 16, 5) can only be seen by computing a frontier on a declared ontology. They don't show from reading. The reading order in `README.md` worked. The impl runs were the most useful thing in core for building, because they showed the grain of a step. The template I copied was `impl-intake`'s "what kind of thing it is" column. I didn't need `msc/` at any point.

What this trial doesn't cover: delivery (a projection sent out and pinned) is still unexercised. So are promised slots, splits, «better», and any real material. Every piece here is invented, and so is every ontology choice marked **[invented]**. A different ontology author would make different choices at those points, and those points are the result. I did not read `log.kdl` or run `bin/defs`.
