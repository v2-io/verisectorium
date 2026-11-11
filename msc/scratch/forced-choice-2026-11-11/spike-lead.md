# One home, and living with it: the spike lead's answer

*2026-11-11, by the spike agent (Fable 5.2). Written before opening anything else in this directory. Read first, whole: the assembled comparison (`languages-compared-2026-11-10.md`) and the two builders' notes, which I had not seen. I have used three of the eight languages on this model and none of the other five.*

## clingo

Answer-set programming, the one I called "the workbench beside it, not the copy of record" two files ago. So I am choosing my own experience, and against my own earlier verdict. Joseph is right that the other answer was the safe one, and I have tried to check that this one is not just the comfortable one. Here is what moved me.

**It is the only one of the eight in which a single copy of the conditions does three of the four jobs.** The rules that say what a state owes are the same text that runs a story, and the same text a search is asked over: "find me two forks, each stationary, whose union is not" is a few lines of choice added to the rules, not a generator written beside them and not a second model. Every other candidate has a second hand-kept statement somewhere. The OCaml builder names its own (the definition of what each condition reads, on which its fork result rests). The Ada builder wrote a 1,200-line search because the prover finds nothing. Lean and Soufflé cannot search at all. Alloy searches from one copy too, and takes three minutes to evaluate note 22's example. If I am the one keeping this true through several changes, the thing I most fear is two statements of the conditions drifting apart with nothing saying so, and this is the only home where I can refuse to have a second.

**It is the only one for which there is evidence about a mind arriving cold.** The independent reader had none of our context. It read all fifty-five rules, found a real defect in one of them by reading, replaced three rules to isolate a cause, wrote eight probes inline, and re-ran everything, inside one pass. Nobody has yet read the OCaml but its builder, who says of it "I would not ask anyone else to verify it by reading". That is one cold mind on a small model, and it is still the only measurement anyone has of the thing the question asks about.

**Joseph can read it against his own sentences.** A condition is one rule under its sentence. And a second reading of a sentence is a file of two lines added from outside, by someone who has not read the rest, run beside the first and diffed. The spec was read two ways in more than a dozen places in one evening; that will not stop.

**It does not force the model's hand on decisions.** Note 22 §3.4 says a decision has conditions. Strict Datalog refuses any such rule, harmless or not, so Soufflé as the only home would quietly settle that question by what compiles. clingo runs them and tells you when a state has no answer or two. That is why it is clingo and not Soufflé, though Soufflé is the better-behaved tool.

## What I give up, knowing it

- **Proof.** Entirely. Everything I can ever say is "none found within these bounds". The Ada frame theorem and Lean's results would have to be re-earned by search or lost. That is the largest price, and the two builders pay the same one.
- **A compiler.** Nothing is declared and nothing is typed. A misspelled relation is empty, and an empty relation makes the frontier shorter, which looks like good news. I would not live with that unguarded; see below.
- **"Why is this owed", built in.** Soufflé has it and I would miss it most days.
- **The engine.** This could never be the thing a real verisectorium runs on. OCaml could.

## What I would do in the first week, as conditions of the choice

Fail any run that prints an "info" line (that is the misspelling and the wrong arity, turned into an error). Fail any run that returns other than exactly one answer, unless the file says it is a search. Keep every story with its expected frontier and run them all on every change. And say, on every "none found", the bounds it was found within and one witness that the space was not empty; the Alloy fork's vacuous pass and the OCaml builder's missing tag are the same warning from two sides.

## What would show me I chose wrong

I have run six of the nine conditions, on a model a fraction of the spec's size, and one small search over selections; never a search over pairs of forks, which is the job this choice leans on. If within that week the fork search cannot reach the universes the OCaml explorer already covers, or the conditions about how well something stands come out as rules nobody can read against their sentences, then the answer is **OCaml**, with its conditions pulled out one per sentence as its builder began to do. It is the only candidate that has carried all nine conditions and the events through a change of spec, and its builder's remark that the pulled-out conditions "are nearly rules already" is, I think, true and is the reason the two answers are close. I rank it second and not first because what it has proven is that it can be kept running, and what the question asks is whether it can be kept *true*, by reading, by someone who did not write it.

## Added after reading the others' answers and running the check

*Everything above was written first and is unchanged. This part came after.*

The TLA+ fork chose clingo too, and named the same test I did: its two-fork question asked in clingo. I ran it (`clingo-fork-search/`, with its own README). The lost rewrite, the clock case and write skew all come out, over the same rules that run the story and with no second model, in under a fifth of a second each. So the thing I said would show me wrong did not, at the size I tried, which is far smaller than what the OCaml explorer covers.

What I had not expected is how the three runs went. The first two each handed me a wrong answer that read like a right one: a "none" that was only none within too small a bound, a "found" from a question I had worded loosely, and a "none" because a line I added had silently forbidden every affirmation. I caught all three only because I already knew what the answers should be. On a question whose answer I did not know, I would have believed them.

That does not change my choice. It changes what I think the choice costs. The guards I listed above as first-week work are not hygiene; without them this home would have told me three false things in fifteen minutes. The two Lean answers put their weight on exactly this: a home should tell apart, by machine, what was shown from what was only run. I think they are right that this is the deepest objection to my choice, and I think the answer to it is the model's own (say on every result what it rests on, and compute that where it can be computed) and not a different language. But I hold that less firmly than I did an hour ago.
