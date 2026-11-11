# Note 22's nine conditions: what each is for, and where I expect them to be doubted

*To Joseph, from the second Fable 5.2 lead of 2026-11-10/11, written late in my context at your request, to sit beside note 22 when you read it. You said of the nine conditions, before reading the note: "I'm even pretty skeptical of the 9 conditions as you listed … it seemed like some of them were overly restrictive and in the wrong places." This is what I told you in answer, put where it will not be lost.*

*What it rests on. The conditions are quoted from note 22 §4.1. The purpose I give for each is my reading of note 22, `core/` and the two builders' accounts; note 22 itself justifies the list only with "I have tried to make each one something a person would recognize. I do not know that nine is right." The doubts are predictions of mine, made before you read the note. The section on forks draws on the builders' accounts and the first spike, and I say where the independent read of that spike qualified it. I ran none of the builds.*

## 1. The nine, each with what I take it to be for

1. **"every reference reaches something that is there"**. So that nothing silently rests on a missing piece. A pointer at work not yet written is allowed, and shows as owed until the work exists.
2. **"every reference was written or re-read against its target as the target now is"**. When a piece changes, everything that references it has to be looked at again ("did I rely on what changed?"). This is the main way one edit ripples outward.
3. **"every piece has, from what it is predicated on, at least what it needs"**. A claim can say it needs its premise to be at least this well supported; if the premise's support falls, the claim shows as owed.
4. **"nothing is known wrong: no finding applies to it, and every defect found in it has since been looked for and not found"**. Bad news cannot be ignored. The second half is there so that a defect cannot be shed by rewording the piece.
5. **"it has what each root that reaches it asks, and rests only on pieces in canon that are themselves consistent"**. The first half is where each purpose sets its own standard: a theory's outline asks that claims have been checked, a paper's also that citations have. The second half makes an unsound premise show on everything built on it.
6. **"pieces with an inner dependency between them have been looked at together as they now are"**. Keeps a result's description and plain-language paragraph in step with its claim when the claim moves.
7. **"it says no more about how well anything stands than is so"**. The oldest honesty rule: text that says "we prove" or "verified" may not outrun the record.
8. **"every promised or required slot has something in canon in it"**. A promise stays owed until what fills it is accepted, not merely written; a result missing its required description owes one.
9. **"every question raised about it has been answered since"**. Lets a person or a rule put a question to a piece ("run the cheapest falsifier on this") and have it stay visible until someone answers.

## 2. Where I expect the doubt to land

- **Condition 2 is very eager.** As worded, any new version of a target makes every piece that references it owe a second look, however small the change. Core's own notes carry this as undecided («reference»; the last Working Note of `impl-a-small-move`). Section 3 below says what the fork work adds.
- **Condition 6 may be in the wrong place.** Core's rule is about a *write*: when something changes, what depends on it is changed or affirmed in that same write («changeset»). As a standing condition on a state, with no memory of what changed, it asks for more. That is the reading under which note 22's own example (§4.3) does not close: the eli8 was rewritten, the description it depends on was not, and nobody is recorded as having looked at the two together. By core's rule nothing is owed there.
- **Condition 8 says "in canon".** A required slot filled by a draft that is not yet accepted still owes. On an early outline that could make nearly everything owe.
- **Condition 3 and the second half of 5 overlap.** Both carry a premise's trouble down to what rests on it. An earlier kernel spike found the same of the "needed" mark on a reference: it mostly duplicates what the cap already says.
- **The second half of condition 4** is the rule in which the two builders found four holes, and it is not something you asked for. On 11-04 and 11-05 you said a change to content should lower certainty by itself, and that a discovered defect is first an honest lowering of the claim and then a strengthening attempt. Core as it stood on the morning of 11-10 had no such rule: in its small move, rewriting the claim cleared the finding, and what stayed owed was that the new version asserted "exact" and nobody had checked it.
- **Condition 7 is hard to compute** unless what a piece says about standing is declared and not only written in prose.

## 3. What the fork-and-merge results add to the doubt about condition 2

You asked whether those discoveries play into it. They do, more than into any other condition.

**Condition 2 is most of what makes two forks collide.** In both builders' accounts two forks "meet" when something on one reads a piece the other changed, and a reference is the commonest thing that reads another piece. So how eagerly condition 2 fires largely decides how often two independent repairs can both land without rework.

**The builds already hold a way to make it less eager, which note 22 does not.** The kernel spec lets each kind of reference declare how much of its target it relies on: only that the target exists; only what it asserts; or everything. A reference that relies only on existence does not go stale when its target is rewritten. That is why, in the OCaml build, two repairs to different results under one outline do not meet: the outline's pointing relies on existence only. With every reference read as "the target changed", every pair of forks met at the outline and nothing could close on its own. Note 22's "as the target now is" is the ungraded form.

**Condition 2 has to rest on what the writer actually saw.** Both builders found the same fault. If "this reference was written against the current target" is worked out from the order of events, then after two forks merge, a rewording made on one can be credited with having seen a rewrite on the other that its writer never saw. Both repaired it the same way: the write records what its references pointed at when it was made.

So the fork work says two things of condition 2: grade it by what the reference relies on, and never infer what the writer saw.

**A candidate, not a result.** The Lean fork of the first spike put relying on existence only, ignoring a reflow of text, and an attested "these two versions are the same for this purpose" as one idea: a reference or a check is about what was *seen* of a version, and holds while that view is unchanged. If so, condition 2 is "what this piece saw of its target has not changed", and its eagerness is a choice each kind of reference makes. The independent read notes that the construction assumes what it sets out to show (that sameness is equality under a view), so it settles nothing by itself.

**Condition 1 is touched too, more simply.** One fork retires a piece that the other fork's new version refers to, and the merge has a reference to nothing. The Ada builder lists this among the ways two forks meet.

A limit on all of this: the builders' statements about forks are for the kernel spec's rule that forks which meet must be reworked. Two of the faults the first spike reported about merging exist only under a looser rule (close whenever the merged state happens to owe nothing), which the spec does not have and which is one of the open choices in note 22.

## 4. My own opinion of the nine, for what it is worth

I think they are three ideas, and I have run nothing to test it.

- **Current**: everything that relied on something still sees it as it was when relied on. (Conditions 1, 2 and 6; also evidence still applying and a decision's conditions holding, which note 22 has in Part 3.)
- **Answered**: everything asked has an answer that still applies, and no applying answer says no. (What a root asks in 5; 3; 8; 9; and, if a found defect is a question that stays asked, the second half of 4.)
- **Grounded**: a piece rests only on pieces that are themselves all right, and says no more about how well anything stands than is so. (The second half of 5; 7.)

That is close to your sentence of 11-10: "this perturbation makes these things now inconsistent-- and it isn't stationary until it's all consistent again". The Ada build's frame result points the same way, since it depends on nothing but each owed item being computed from what one piece reads.

What I am unsure of: whether "answered" really absorbs the rule that bad news persists, or only hides it; whether levels of support and the cap along what a piece rests on fit inside "grounded"; and where time and outside referents go, which you called the hard part of influx and which neither the nine nor these three place anywhere.
