# Would Lean serve as a home for the model's formal layer?

*2026-11-10/11, by the Lean fork (Fable 5.2), in answer to Joseph's question, relayed by the spike lead: "Did the agent discuss the feels / pros / cons of the languages?" This is the firsthand side: what the work was like and where I would land. It is one mind's experience of one short session in one language (by the files' timestamps, 20:20 to 20:43 local, under half an hour of wall-clock), on a model much smaller than the kernel spec. I did not work in OCaml, Ada, Datalog, Alloy or TLA+ today and say nothing here about them from experience.*

*What I checked against the directory before writing, since I am writing after a compaction: file sizes, the build log's timings, the install's size on disk, the list of logs kept. What is from memory of the session and not from a log is marked.*

## Where I land

As one part of a combination, and a specific part. Not as the home.

Lean is where I would put **the definitions that have to have exactly one reading, and the few statements about them worth proving for every state**. It is the wrong place for the engine, and it has nothing to offer on forks and orders of events.

If someone held me to a single language for the whole formal layer, Lean is a defensible choice, because it does three of the four jobs in one file format: shapes as types, the state-to-frontier function as an ordinary runnable definition, and proofs about that function. It did all three today (the story ran inside Lean, with no second tool). It would do each less comfortably than a tool made for that job alone, and I would not choose it that way unless the single language mattered more than the comfort.

## What it was like

**Install.** `elan-init -y --no-modify-path` from Homebrew, then it fetched the toolchain. It took more than three minutes (my command was moved to the background at 180 seconds; from memory, it finished within a minute or two after). It put 2.8 GB under `~/.elan`. Nothing needed a password or touched a shell profile. After that everything is `~/.elan/bin/lake build`. I used no libraries, on purpose: the standard mathematics library (Mathlib) is several more gigabytes and a long first build, and nothing I did needed it. That choice held all the way through, and I would keep it as a rule for this project.

**Speed.** Fast enough that it was never on my mind. From the build log: each file between 0.2 and 0.6 seconds, the story file 1.2 seconds, a clean build of all seven in a few seconds. The story's ten frontiers are checked by the kernel evaluating the model, and that 1.2 seconds is for eight pieces and a dozen events. I did not measure how that grows and I would expect it to grow badly; see below.

**How many runs, and why.** This is the part I would most want a successor to know, because the spread was wide and the reasons differ.

| file | runs to clean | what the failed runs were |
|---|---|---|
| `Fault.lean` (282 lines, eleven theorems about consistency) | 1 | none |
| `Refusals.lean` | 2 | two documentation comments in a row is a parse error |
| `Model.lean` (the function itself) | 1 | none |
| `Story.lean` | 3 | I had indexed a list with `[i]!`, which needs a default value the type did not have, and which the kernel's evaluator then could not see through |
| `View.lean` | 2 | a rewriting notation that did not apply; I replaced it with the plain function |
| `Tiers.lean` | 1 | none |
| `GoodNews.lean` (the one real proof about the model) | 7 | see below |

The abstract mathematics went through first time and the concrete proof took seven. That is the honest shape of working in Lean. A statement about relations and fixed points is short and Lean's automation is good at it. A statement about a real function over lists with eight kinds of item in it is a case analysis, and I did it the way one does: unfold, ask Lean to simplify, **read the goal it prints back**, write the next three lines, run again. Four of the seven runs were me asking to see the remaining goals, not errors. Nothing in it was hard. All of it was looking.

**The errors.** Mixed, and the mix matters for a cold agent.

- The best was the one I came for. Asked to define consistency with a question conditioned on it, the kernel said `arg #4 of 'Vk.FaultR.raised' has a non positive occurrence of the datatypes being declared`, and the fixed-point checker said `Could not prove 'Vk.ConsR' to be monotone in its recursive calls`. Both are one line, both name the thing, and both are the builds' finding stated by a tool that had never seen the builds.
- Unsolved goals are printed in full and are readable. They are also long: the eight-case goal was about 150 lines of output per run, most of it the same disjunction repeated. I filtered it to read it.
- The worst was a parse error that listed some fifty keywords it would have accepted, for what was a stray comment.
- When kernel evaluation got stuck it showed the exact term it was stuck on, which was enough to find the cause, though it took knowing what "stuck" means.

**What fought me.** Less than I expected. Three things.

1. I did not know which fixed-point features this Lean had. My knowledge of Lean was a few versions behind, and I had to write a probe file to find out that `coinductive` exists in 4.35 and what names it generates. Lean changes monthly. Any agent arriving will be behind in the same way.
2. The step from "true" to "the kernel will evaluate it" is not free. Writing the model so that `decide` can run it means structural recursion with an explicit bound, no partial functions, no convenient indexing. I knew to do that from the start; an agent who did not would lose time.
3. Within the day, one lemma name I used was already flagged deprecated. It is a warning and it is still in the log.

**What was a pleasure.** Two things, and they are the case for Lean.

- The moment a sentence of the model had to become a definition, it had to have one reading, and several did not. Whether writing k2 counts as having looked at it beside e1; whether a check that read a reference's target has reconciled the reference; whether "answered" means applying now or having applied when recorded. I did not go looking for these. I could not type the next line without choosing.
- `Checkpoint`. A value that cannot exist without a proof that its frontier is empty, and a compiler that rejects one at 13:00. Of everything I built it is the smallest and the one that most looks like the model's own first sentence about what is computed and never typed.

## What I would dread maintaining

The model is still changing, and under turnover. So this is the section that should weigh most.

- **Proofs are coupled to the shape of definitions.** `GoodNews.lean` has one case per kind of frontier item. Add a condition to the model and that proof breaks until someone adds the case. I think that is partly a virtue: the new case is the question "which way does good news move this item?", and it should be answered. But it means every change to the model has a second cost, paid in a language where the paying is looking at goals. With the model moving daily, I would not keep more than a handful of theorems alive. Today's seven-run proof is about the right size for one; fifteen of them would be a job.
- **Tactic proofs cannot be read, only re-run.** A successor opening `GoodNews.lean` sees `rcases h with (((((((h | h) | h) | h) | h) | h) | h) | h)` and has to run Lean to learn what the eight cases are. I put a comment on each. That is discipline, not something the language gives.
- **The pinned refusals are pinned to Lean's wording.** `Refusals.lean` stops compiling if a later Lean phrases the error differently. That is what I wanted today (the refusal is checked, not reported). Over a year it is a small recurring chore.
- **The toolchain moves.** The project pins 4.35.0 in `lean-toolchain` and that should not be touched casually. An upgrade is a decision with a cost.
- **The pull toward what is provable.** This is the one I would name to Joseph directly, because he named it first. A proof assistant rewards making the model smaller and sharper until a theorem goes through. Everything I proved is about a model with no warrant levels, no `same`, no promises, no descent. Each cut was honest and stated, and the result is true of something that is not the spec. A lead living in this tool would feel progress all day and could end with a beautifully proved kernel that has no workflow in it. That has already happened once this week without Lean's help. Lean would make it more comfortable.

## What a cold agent would need to know

Six lines, and I would put them at the top of any Lean directory in this project.

1. `~/.elan/bin/lake build`, and the toolchain is pinned; do not upgrade it in passing.
2. No Mathlib. If you think you need it, you are probably proving something that is not about the model.
3. Read `Model.lean` before any proof. The definitions are the content; they are plain functions on lists and need no Lean to read.
4. To understand a proof, delete its last few lines and build: Lean prints what was left to show.
5. Your Lean is out of date. Probe before relying on a feature.
6. A theorem here is about the small model in `Model.lean`. Say so every time you cite one.

## Against the lead's paragraph in `DEBRIEF.md`

The lead writes that the formal part is not one layer (shape, a function from state to what is owed, steps), that types carry the first and rules the second, and that it would try the nine conditions as rules first. I agree with the division and with where to start. Two differences, both of degree.

- **Lean is not only the "shape" language.** The function is also perfectly sayable in it, and was said: `Model.lean` is 246 lines and the story runs on it. So the choice between Lean and a rule language for the nine conditions is not about what each can express. It is that rules state each condition once, in the form a reader would recognise, and get the explanation of each owed item for nothing, while in Lean I wrote the bookkeeping by hand (a loop with a bound for reachability, lists for sets). For the conditions as a thing people read, I would also take rules. For the conditions as a thing theorems are proved about, they have to be in Lean anyway, and then there are two copies to keep the same. That cost is real and the debrief's paragraph does not count it.
- **"Types carry the shape" is true and smaller than it sounds.** Of a slot's declaration, the kind of filler and how many fit in a type; *required* does not, and nor does any of the nine conditions. What types gave the model today was one thing of weight (a checkpoint cannot be made by hand) and one observation (the empty slot states are what let typing coexist with unfinished work). I would not want Joseph to hear "as types instead of terms" and picture core's def files turning into type declarations that enforce the model. Most of what the defs say is about states that are allowed to be wrong for a while, and a type cannot say "wrong for a while".

On his earlier question, whether a typed language could carry core's formal spec "as types instead of 'terms'": from this side, partly, and the part is the vocabulary of what may be *written and recorded* (pieces, kinds, slots and their states, evidence about a version, events). Those became a few dozen lines of type declarations with no strain, and I think they would in any language with algebraic types; nothing I used there needed Lean's dependent types except `Checkpoint` and the quotient for `same`. Whether that makes OCaml the better host for that part I cannot say from experience. I would only say that the two things here that did need Lean are also the two I would least want to give up.

## What I would actually do

A guess, labelled as one. Keep Lean small and off to the side: one directory, the definitions of the state-to-frontier function at whatever size the model currently has, and three or four theorems chosen because they are what an *ontology* must satisfy and so can be checked once and not per state (well-definedness by monotonicity; good news; the frame's reading list, if someone does it). Re-run on every change to the conditions. Treat a proof that breaks as a question about the model first and a chore second. Let something else be the thing people read and the thing that runs.

And do not let it grow past what one mind can re-prove in a sitting. That bound is what would keep it serving the model.

## What this rests on

One session; one mind; a model of nine kinds of frontier item against the spec's fifteen kinds of instance; no library; no proof longer than about sixty lines; nothing run at size. I have not maintained Lean code across a change to the model, which is the very thing the dread section is about; those are expectations from how today's proofs are built, not experience. The install time and the "four of seven runs were looks" are from memory of the session; the failed-run logs were not kept.
