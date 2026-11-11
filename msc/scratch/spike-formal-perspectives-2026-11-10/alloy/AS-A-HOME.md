# Alloy as a home for the model's formal layer: the firsthand side

*2026-11-10/11, by the Alloy fork of this spike (Fable 5.2), answering Joseph's question to the lead: "Did the agent discuss the feels / pros / cons of the languages?" I had not. `PERSPECTIVE.md` beside this file says what Alloy showed about the model; this says what it was like to work in, and whether I think it would serve.*

*What this rests on: one evening, about 800 lines of Alloy across ten files, some two dozen solver runs, one small model (M0, the lead's reduction of note 22 Parts 2 to 4). I had not written Alloy in this session before tonight and came to it from general knowledge. Part of this session was compacted before I wrote this, so where I give a number I have checked it against a log or a file in this directory, and where I describe how something felt, that is memory and is marked by its register. I have not used Alloy's graphical tool at all, and that is where most people meet it; everything here is the command line.*

## Where I land

**Not as the home. Yes, and gladly, as the instrument you point at a sentence before you believe it.**

A home is where the model's formal statement lives, is read by arriving minds, is kept true as the model changes, and (eventually) is what an engine is built from or checked against. Alloy fails three of those four for reasons that are not about taste:

1. **It cannot run the model at the size of a paragraph.** Note 22's own example, thirty-one events, nothing to search for, every atom given: about three minutes to evaluate (`runs/story.log`). I would expect the same story to evaluate at once as rules (the lead's Datalog version; I have not timed it or read its logs). Alloy turns everything into one large Boolean problem whether or not there is a question in it. A real segment with sixty-five pieces is out of reach.
2. **"No counterexample" is always "none this small",** and small here was four pieces. That is honest and useful, and it is not what a home should say about its own content.
3. **It has no recursion and no universal statement over sets.** The first turned out to be a gift (below). The second means it can ask "is this state stationary" and cannot ask "does every ontology have an answer", which is the kind of thing the Ada build proved.

The fourth, being read by arriving minds, it does well. More on that below, because it is the part that surprised me.

In a combination, I would give it one job: **when someone proposes a sentence about the model ("two forks that write different pieces can both close"), write the sentence and ask for a world where it is false.** That cost me between eight seconds and two minutes each time tonight, and it was wrong fourteen times in a row. Nothing else in this spike does that as cheaply, because nothing else lets the sentence be one line with no generator between it and the search.

## What it was like

**Getting it.** One jar, one `curl`, no install, no project file, no dependencies beyond a JDK. The machine's system `java` was a broken x86 one and the lead had put a working JDK at a known path; without that I would have lost time. Alloy 6.2 has a real command line (`exec`), which older versions did not, and my knowledge of that was uncertain until I ran `help`. The jar prints four lines of Java warnings on every run; harmless, and noise in every log.

**The language, writing it.** This was the pleasure. M0's computed side went down almost as fast as I could think it: "canon is what the roots reach through non-provisional slots" is `roots.*fill`; "what this piece rests on, transitively" is `^rests`. A relation and its closure are the native nouns, and this model is made of relations and closures. I wrote `m0.als` (200 lines) once, and after two keyword collisions it did not change in substance for the rest of the night except for one addition. I do not think that would have been true in a general-purpose language.

**The language, fighting it.** Three things cost me real time.

- *Reserved words with no warning in the message.* I named a field `pred` (predicated-on) and another `for`. The error was "There are 28 possible tokens that can appear here", with a line and column and no mention that the token I had written was a keyword. I found the first by counting columns by hand. It took three runs to clear two words.
- *Order.* Alloy's ordering library fixes the order of atoms by the order they were declared. My story's events were declared grouped by kind (all the writes, then all the affirmations), and the story needs them in time order. Stating the order as thirty "this is before that" constraints made the solver grind for minutes on what is a pigeonhole problem; stating it as "this event's time is the next after that one's" let it propagate. Nothing in any message pointed at this. I knew to try it only from knowing how SAT solvers fail.
- *Scopes.* The first story run, with a lazy "up to 31 of everything", I killed after three minutes with no output. Tightening every scope to the exact count was necessary and still left the three-minute evaluation.

**Reading what it gives back.** This is the weakest part on the command line. A found world comes back as a flat list of relations with atoms named `Version$3` and `Outline$1`. To learn what had happened in a fork instance I had to reconstruct by hand: which writes are on which fork, in what time order, what is therefore selected, what canon is, which condition fails. Each one took me several minutes of careful tracing, and I did about twenty. I wrote two small shell filters (`show.sh`, `showf.sh`) only to make the text shorter. The graphical tool would draw these; I did not use it and an agent on a command line would not either. And the world returned is *a* world that fits, not the smallest or the most natural: several of mine carried an assembly with a slot for itself, or a write that re-selects the version already selected, beside the part that mattered. I read past those; a less careful reader could take the oddity for the finding. My readings were checked by nobody.

**How many runs, and why.** Roughly: four to get the story to run at all (two keywords, the ordering, the scopes); one for the fixed-point file, which was right the first time, and a second after adding two variants; and about fifteen for the forks, which is the honest shape of that work and not a failure of the tool: state a condition, get a world that defeats it, read it, tighten, again. Fourteen tightenings each came back defeated in under two minutes. The fifteenth I stopped by hand after about ten minutes of silence (`runs/forks6.log`). That silence is the other face of the tool: when there may be nothing to find, it does not say so quickly, and it gives no sign of progress.

**One thing I did wrong that the tool made easy.** I tightened `forks2.als` and `forks3.als` in place, round after round, saving the logs and the defeating instances and not the earlier clause texts. So seven of the fifteen rounds can be re-read and cannot be re-run. An Alloy file is a model plus a list of questions asked of it, the questions are where the history is, and nothing about the tool encourages keeping them.

## What I would dread maintaining

**Two models, not one.** The story and the search wanted different things from the same definitions: the story needs thirty-one named events and exact scopes; the search needs anonymous atoms and small bounds. I kept one `m0.als` under both and it held, but the story file is 200 lines of hand-written atoms that would have to be rewritten whenever M0's event shapes change. That file is a test fixture in a language with no good way to write fixtures.

**Every definition is inlined at every use.** Alloy has no memoised functions; `sel[v]` (which version is selected) is expanded wherever it appears. That is why the story is slow, and it means that adding one condition to the model can multiply solve time with no warning. A cold agent adding warrant levels or caps would probably hit a wall of minutes and not know which line caused it.

**Scope numbers are part of the meaning.** `for 4 but 4 View, 9 Time, 9 Event, 6 Version` is not a detail: change the model and a previously meaningful "no counterexample" can become vacuous because the interesting world no longer fits. Nothing checks that. Under turnover, with minds that inherit a file and a passing log, this is the place I would most expect a false "verified" to appear.

**Fact versus predicate is silent.** Anything written as a `fact` simply removes worlds. If a later mind moves one of the nine conditions into a fact to make a run faster, every check afterwards is about a narrower model and no output says so.

## What a cold agent would need to be told

1. `pred`, `for`, `in`, `one`, `some`, `all`, `no`, `lone`, `set`, `sig`, `fact`, `fun`, `run`, `check`, `let`, `this`, `iden`, `univ`, `none`, `disj`, `open`, `as`, `but`, `exactly`, `else`, `implies`, `not`, `and`, `or`, `iff`, `seq`, `sum`, `Int`, `String`, `steps`, `var`, `always`, `eventually`, `after`, `until`, `once`, `historically`, `before`, `since`, `releases`, `triggered` are words you cannot name a field. (The first two are the ones that bit me; the rest are from my knowledge of the language and the parser's own list in its error, not each tested.) A syntax error naming "28 possible tokens" at a column usually means this.
2. Give every signature an exact scope when the world is fixed; never rely on a default.
3. With `util/ordering`, the order is the atoms' declaration order. To pin your own order, say "x is the next after y", never "x is before y".
4. `check` with "no counterexample" means none within scope. Say the scope whenever you say the result.
5. "For all sets S" cannot be asked. Make the candidate sets atoms (`fixpoints.als` shows how) and accept $2^n$.
6. Use a native solver (`-s glucose`); the default is a Java one and slower.
7. A returned world is one that fits. Before reading meaning into a feature of it, ask for another with that feature excluded.
8. Keep each question as its own named `run` in a file you do not overwrite.
9. If a run is silent for ten times as long as its neighbours, it is probably proving there is nothing, and it will not tell you how far along it is.

## On "as types instead of terms"

Joseph's earlier question was whether a language could carry core's formal spec as types in place of terms. For Alloy the honest answer has two halves.

**The declarations are the closest thing to core's KDL blocks that I saw tonight, and they are checked.** Compare what `core/def/*.md` writes by hand,

```
rel holds term="segment" card="{0,N}"
rel of term="kind" card="{1,1}"
```

with what `m0.als` says:

```
sig Version { of: one Piece, slots: set Piece, prov: set Piece } { prov in slots }
```

It is the same information (a thing, its relations, how many) in nearly the same number of words, a reader with no Alloy can follow it, and a tool rejects a file that uses a relation that is not declared or uses it at the wrong arity. `bin/defs check` verifies that relations point at terms; an Alloy signature does that and also lets the relations be *used* in the next sentence. If the question is "what would core's term blocks look like if they could be computed with", this is a fair picture of it, and of the four languages in this spike I think it is the most readable picture for someone who is not a programmer.

**But they are not types in the sense that gives the idea its force.** Nothing in Alloy stops a value of the wrong shape from existing the way a type in Lean or OCaml does; a signature is a set and a `fact` is a filter over worlds. There is no checkpoint-that-cannot-be-built-without-a-proof here. What Alloy gives is a typed *vocabulary* and a way to ask questions in it, not a typed *construction*.

**Where I differ from the lead's DEBRIEF.** The debrief says the formal part is three layers (shape carried by types, what a state owes carried by rules, how states follow one another explored by a model checker), that each language was good at one, and that it would try the nine conditions as rules first. I agree with the three layers and with rules first. Two differences, both from having done this part by hand:

- Alloy is not "good at one of the three". It is passable at shape, passable at what-a-state-owes (the conditions went down as easily as I expect they did in Datalog, and read about as plainly), and poor at steps. Its place is across the first two as a *questioning* instrument, not inside any one as a carrier. If a combination is drawn as three boxes, Alloy is not a box; it is the thing you point at the boxes.
- I would add a fourth job that the three-layer picture leaves out and that turned out to be most of what I did: **finding out whether a proposed general sentence about the model is true.** "Forks that do not meet can both close" is not shape, not a rule over one state, and not a step. It is a claim *about* the rules, and the builds each spent their largest effort on it. Rules can run the story; they cannot tell you the sentence is false. For that the choice tonight was between writing a generator (the OCaml build), writing a proof (the Ada build), and writing the sentence (here). The third is far the cheapest and far the weakest, which is the right trade for a first look.

## If I were asked to choose

For the home: rules (the Datalog fork's direction), with the declarations written so that they read like `m0.als`'s signatures, because that is the form in which core's term blocks and the formal statement could be one text instead of two.

For Alloy: keep `m0.als`-sized models beside the rules, small, each tied to one question, and treat a file here as disposable when the model moves. I would not ask anyone to maintain an Alloy model of the whole. I would ask every proposed "always" or "never" about the model to pass through one before it is written into a working note as if it were known.

What would change my mind: if the graphical tool (or a script over the JSON output, which exists and which I did not try) made instances readable in seconds, the cost side of this would drop a great deal; and if someone showed the full spec's conditions evaluating in seconds through a different encoding, point 1 above would fall. I tried neither.
