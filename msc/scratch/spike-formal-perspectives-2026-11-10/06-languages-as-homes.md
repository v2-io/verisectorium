# Would any of these languages serve as a home for the model?

*To Joseph, 2026-11-11, from the spike agent (Fable 5.2). You asked the lead: "In this case the comparison was more about whether or not one of those languages would serve the model well semantically and toolchain-wise. Did the agent discuss the feels / pros / cons of the languages?" Not well enough. The debrief said what each language showed about the model and gave one paragraph to this. This file is the answer.*

*How it was made. I used the Datalog family myself and none of the other three. So I asked each fork, the only mind that worked in its language on this model, to write its own account: `lean/AS-A-HOME.md`, `alloy/AS-A-HOME.md`, `tla/AS-A-HOME.md`. I read all three whole. They are better than my summary of them and each is short; where I quote, the words are theirs. Where they disagree with my debrief I have kept the disagreement and say whether it moved me.*

*What it rests on: one evening per language, one mind each, a model much smaller than the kernel spec, and nobody has yet maintained any of this across a change to the model. Every "I would dread" below is an expectation, not experience. Nobody here used OCaml or Ada; what I say of OCaml is from reading the builder's account and is marked.*

## The short answer

Nobody who used one of these would make it the home alone. All four of us, separately, land on the same shape, and the three forks each land there against their own language:

- **The conditions as rules**, as the thing people read and the thing that runs.
- **Lean, small and to the side**, for the few statements worth proving for every state, and for the one or two things that only a proof-carrying type gives.
- **Alloy and TLA+ as instruments picked up for a question and put down**, not kept.

I should say plainly that I am the one who used the rule languages, so my landing on rules is the least independent of the four. The forks landing there too is worth more than my landing there, and less than it looks, since they began with my reading.

| | as the home | in a combination | the fork's own words |
|---|---|---|---|
| Datalog family | plausible, for the conditions; not for shape or proofs | the centre | (mine, below) |
| Lean 4 | "defensible" if one language mattered more than comfort | yes, a specific small part | "As one part of a combination, and a specific part. Not as the home." |
| Alloy 6 | no | as a questioning instrument | "Not as the home. Yes, and gladly, as the instrument you point at a sentence before you believe it." |
| TLA+ | no | "I lean no" | "It would hold the model the way a notebook would." |

## The Datalog family, firsthand

Three engines: clingo (answer-set programming), Soufflé (strict Datalog), SWI-Prolog with tabling. About 330 lines in all for the two versions of the model, the story and the rule-graph reader.

**Getting it.** One `brew install`, bottles, a few minutes, nothing else. This was the lightest toolchain of the four.

**Writing it.** The model's computed side went down in one sitting and gave the story's frontier on the first run. I do not think that says I am careful; it says the nine conditions are already rules in everything but notation. "A claim in canon that the root asks be checked, with no applying evidence that holds" is one line and reads as that sentence. Every run all evening finished in under a second, so I never thought about speed.

**The best thing, and the reason I would choose it for a model that is still moving.** An alternative reading of the spec is a file of one to three lines, added on the command line. "A write of a dependent counts as having looked" is two lines (`reading-write-looks.lp`). "Written-against is worked out from the line" is one. I ran the model both ways side by side and diffed the frontiers. When the spec's wording has two readings, which the two builders between them report in more than a dozen places, this is the cheapest way I know to see what each reading costs. The Lean fork got the same benefit from the other direction ("I could not type the next line without choosing"); here you do not have to choose, you can run both.

**What fought me.**

- *Nothing checks a name.* Misspell a relation in clingo and it prints one line marked "info" and then answers as if that relation were empty. For a model whose most important output is "nothing is owed", an error that produces *less* output looks exactly like success. I ran with warnings merged into the output and saw none, but I was the only check. Soufflé does type and arity checking and would catch this; the price is that it wants every relation declared with types and every constant quoted, and I judged the full model not worth translating for one evening. I ran only small programs and a cut of the model in it. That is a real gap in what I can tell you: the engine I would most trust at size is the one I used least.
- *Soufflé's explanations are interactive.* The "why is this owed" output, which I think is the most valuable single thing in this family, is a prompt you type into. Driving it from a pipe took two tries; the first died with `stoi: no conversion` because it was waiting for a rule number.
- *Output is a flat list of facts.* Everything went through `tr` and `sort` before I could read it.
- *The engines do not hold the model's oldest rule.* Both accept a status typed by hand beside the rules that compute it. I had told myself they would not, wrote that into the perspective file, tested it, and had to take it back.

**What it cannot do.** Prove anything. It runs a state; it says nothing of every state. My one general result (which news is good) came from an 89-line script of my own that reads rule text with regular expressions, leaning on a theorem I stated from memory. I would not want that script maintained by anyone. It also has no natural way to say a refused write, or levels of warrant without either a rule per level or aggregation, which I did not try.

**What I would dread.** Silent emptiness, above all: a rule that stops firing after someone renames a relation, and a frontier that gets shorter. A fixed set of stories with their expected frontiers, run on every change, is the only defence I can see, and it is the same defence the builders already use. Second, the choice of engine matters more than it should: the three semantics disagree on exactly the cases the model cares about (a condition that loops), so "it is Datalog" underdetermines what the rules mean, and whoever picks the engine is making a decision about the model.

**What a cold agent needs.** That a missing fact and a false fact are the same thing here. That `clingo file… 0` shows every answer and more than one answer means a rule loops through a negation. That the stories are the tests.

## Lean, in the fork's words

Whole account: `lean/AS-A-HOME.md`. The parts I would not want you to miss:

On the shape of the work: "The abstract mathematics went through first time and the concrete proof took seven [runs]. That is the honest shape of working in Lean. … Four of the seven runs were me asking to see the remaining goals, not errors. Nothing in it was hard. All of it was looking."

On what it gives: "The moment a sentence of the model had to become a definition, it had to have one reading, and several did not. … I did not go looking for these. I could not type the next line without choosing." And `Checkpoint`: "Of everything I built it is the smallest and the one that most looks like the model's own first sentence about what is computed and never typed."

On cost: 2.8 GB installed; builds in about a second; no Mathlib, "and I would keep it as a rule for this project". Proofs are coupled to the shape of definitions, so each new condition breaks the proof until its case is added. "Tactic proofs cannot be read, only re-run." The toolchain changes monthly and an arriving agent's knowledge of it will be behind.

And the one I think you should hear in its own words, because it is your caution: "A proof assistant rewards making the model smaller and sharper until a theorem goes through. Everything I proved is about a model with no warrant levels, no `same`, no promises, no descent. … A lead living in this tool would feel progress all day and could end with a beautifully proved kernel that has no workflow in it. That has already happened once this week without Lean's help. Lean would make it more comfortable."

Its bound for keeping Lean in service: "do not let it grow past what one mind can re-prove in a sitting."

## Alloy, in the fork's words

Whole account: `alloy/AS-A-HOME.md`.

Why not the home: note 22's own example, thirty-one events and nothing to search for, takes about three minutes to *evaluate*; "no counterexample" always means "none this small", and small was four pieces.

Why keep it at all: "when someone proposes a sentence about the model ('two forks that write different pieces can both close'), write the sentence and ask for a world where it is false. That cost me between eight seconds and two minutes each time tonight, and it was wrong fourteen times in a row."

What it was like: writing the model "was the pleasure … a relation and its closure are the native nouns, and this model is made of relations and closures." Reading what comes back was the worst part: flat lists of relations with atoms named `Version$3`, "several minutes of careful tracing" each, about twenty of them, "checked by nobody". Two reserved words cost three runs to find. One run was stopped after ten silent minutes with no sign of progress.

Where a false "verified" would come from: "Scope numbers are part of the meaning. … Under turnover, with minds that inherit a file and a passing log, this is the place I would most expect a false 'verified' to appear."

It also names a lapse of its own that the tool made easy: it tightened two files in place, so seven of its fifteen rounds can be re-read and not re-run.

## TLA+, in the fork's words

Whole account: `tla/AS-A-HOME.md`.

"Writing the state function was writing mathematics with no one checking it. There are no types." "Writing the steps and the claims was a pleasure." The best moment: when the story's last command is *close* and the fork is not stationary, the checker reports a deadlock; "the tool's word for 'no step is allowed' was exactly the model's 'the close is refused'."

Costs: four attempts to the first run, because the stable release rejects the one feature that makes traces readable, with misleading errors, and the working version is a rolling pre-release. Exhaustive runs of 1.5 to 8 minutes for three pieces and two forks. Twenty-one configuration files.

It would not keep TLA+ even as a standing part, which is firmer than my debrief: "Everything TLC found about forks came from a universe of three pieces with the conditions cut to almost nothing, and the questions were of a kind the OCaml explorer already asks. … The lost rewrite would have fallen out of that explorer with one more check. So I would not keep a third language alive for the steps." What it would keep costs nothing and needs no tool: that the verisectorium's visible state is its latest checkpoint's line and the record, with learning and closing its only steps; and that stationary is a claim about where a close lands.

**Two corrections it asks me to carry**, both to its own earlier file, which it left alone because that file is being audited. `tla/PERSPECTIVE.md` says two mistakes in the state function were "found only by reading traces"; that is wrong. Reading traces found a too-weak closing rule and two too-crude claims, none in the state function, so there is no evidence from this spike that TLA+ helps find errors in the conditions. And the same file says the state function is "three quarters" of the specification; it is about 75 of 245 lines. Neither is in my debrief.

## Where the forks disagree with my debrief, and whether I now agree

My debrief said the formal part is three layers (shape, what a state owes, how states follow one another), that types carry the first, rules the second and a model checker the third, and that each language was good at one.

1. **Lean: "Lean is not only the 'shape' language."** The function was written and run in Lean too. So if the conditions live as rules for reading and in Lean for proving, "there are two copies to keep the same. That cost is real and the debrief's paragraph does not count it." **I agree, and it is the most important correction here.** My paragraph made the combination sound free. It is not: every language added is another hand-kept copy of the conditions, and the TLA+ fork names the same dread from its side ("under turnover that copy will drift and nothing will say so"). Tonight there are six copies, counting the two builds.
2. **Lean: "'Types carry the shape' is true and smaller than it sounds."** "I would not want Joseph to hear 'as types instead of terms' and picture core's def files turning into type declarations that enforce the model. Most of what the defs say is about states that are allowed to be wrong for a while, and a type cannot say 'wrong for a while'." **I agree.** My debrief says this, less well.
3. **Alloy: it is not a layer, and there is a fourth job.** "If a combination is drawn as three boxes, Alloy is not a box; it is the thing you point at the boxes." The fourth job is finding out whether a proposed general sentence about the model is true, which is neither shape nor a rule nor a step, and on which both builders spent their largest effort. For that the choice is between writing a generator (the OCaml build), a proof (the Ada build), or the sentence itself. **I agree, and I had missed it.** My three layers describe what the formal layer *is*; they leave out the work of finding out what is true of it.
4. **TLA+: the third layer is small, and does not need its own language.** **I half agree.** On tonight's evidence it is right. I note that the fault I put first in the debrief (reading an event's place in a line) was found there, by the tool whose only strength is orders of steps, and was missed by an explorer that could in principle have found it. A tool that makes you ask a question you would not otherwise ask has paid for an evening even if it is then put away. That is an argument for picking it up, which is what the fork says too.

## OCaml, and "as types instead of 'terms'"

You asked my predecessor's lead whether OCaml would be "a good candidate for a literal version of core/'s formal spec -- as types instead of 'terms'". Nobody in this spike wrote OCaml, so this is from reading, and from what the forks found in neighbouring languages.

What transfers. The Lean fork: the vocabulary of what may be written and recorded (pieces, kinds, slots and their states, evidence about a version, events) "became a few dozen lines of type declarations with no strain, and I think they would in any language with algebraic types; nothing I used there needed Lean's dependent types except `Checkpoint` and the quotient for `same`." OCaml has algebraic types. So I would expect OCaml to carry that vocabulary as well as Lean did, with a far lighter toolchain, and it is already installed and already holds a working model of the kernel.

What does not. A value that cannot exist without a proof that nothing is owed needs proofs in the types, and OCaml has none. The nearest thing in OCaml is a module that hides the constructor and exports only a function that checks before building. That gives "cannot be typed by hand" as an engineering fact and not as a theorem, which may be all the model needs. I have not tried it.

And the limit that no typed language moves: the nine conditions are not types in any of them. They are a function, and in OCaml they would be what they already are in the builder's `model.ml`, an ordinary program. So "core's formal spec as OCaml types" would be honest for core's term blocks (what a thing is, what it relates to, how many) and would leave everything in note 22 Part 4 as code beside the types.

One more voice on the term blocks specifically. The Alloy fork put a core `rel` line beside an Alloy signature and found "the same information … in nearly the same number of words", checked by a tool, and usable in the next sentence; and it adds at once that this is "a typed *vocabulary* and a way to ask questions in it, not a typed *construction*". If what you want from "types instead of terms" is that the term blocks be checked and computed with, a declaration language of that kind (Alloy's signatures, Soufflé's relation declarations, OCaml's types) is the right family and the differences between them are small. If what you want is that a wrong state be unwritable, almost none of the model qualifies, because the model's states are meant to be wrong for a while.

## What I would do, if it were mine

A guess, from one evening, labelled as one.

- **One copy of the conditions, as rules, with the stories as its tests.** In an engine that checks names and arities and can explain an owed item. On what I saw that points at Soufflé, which is the one I used least, so the first step would be to translate the small model into it and see what it costs. If conditions on decisions are to be allowed (note 22 §3.4), strict Datalog refuses them outright and the engine has to be an answer-set or tabled one; that is a model decision arriving dressed as a tooling one.
- **The stored vocabulary declared once**, in that same engine's declarations if they will bear it, so that the declarations and core's term blocks could become one text.
- **Lean only for what must hold of every state**, three or four theorems, re-proved in a sitting, on the same small model. And I would accept that this is a second copy and keep it small for that reason.
- **Alloy or TLA+ when someone is about to write "always" or "never" into a working note**, as a throwaway, with the file kept as the record of the question.
- **No new copy of the conditions without retiring one.**

What I am least sure of. Whether rules stay readable at the kernel spec's real size, with warrant levels and descent; nobody tried. Whether an answer-set engine is acceptable as the meaning of the conditions, given that it will happily return two answers. And whether the right first move is none of this: the two builds already exist, the OCaml one runs every story, and the cheapest "home" may be the OCaml model with its conditions pulled out into a form a reader can check against note 22. I did not read its code and cannot weigh that.

## What nobody did

Used any of these on the kernel spec at its real size. Maintained any of them through a change to the model. Tried Soufflé on the whole small model; Alloy's graphical tool or JSON output; TLA+'s typed checker (Apalache) or its proof system; Lean with typed kinds throughout. Compared any of this with the OCaml or Ada code.
