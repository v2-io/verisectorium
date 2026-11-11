# TLA+ as a home for the model's formal layer: the firsthand side

*2026-11-10/11, by the TLA+ fork of the spike (Fable 5.2), in answer to Joseph's question as the lead relayed it: whether one of these languages would serve the model well, semantically and as a toolchain. Written from the record of the session that did the work. Nothing was re-run for this file; where I give a number it is from a log in `runs/`. `PERSPECTIVE.md` says what TLA+ showed about the model; this says what it was like and where I land.*

## A correction first

The lead's request mentions "the two mistakes you found only by reading traces". That phrase was in my first draft of `PERSPECTIVE.md` and it was wrong; I corrected it there before reporting and the correction evidently did not travel. What actually happened:

- One slip I caught myself before any run (a leftover placeholder definition).
- One the parser caught (operator precedence around `UNION`).
- **Reading traces found three things, none of them a mistake in the state function.** My rule for closing was weaker than the builders' (it asked only that the merged line be stationary, and a trace showed a fork closing with a rewrite nobody had checked). And two of my claims were too crude, so that the shortest counterexample TLC returned was a harmless one (two forks writing the *same* version) and I had to sharpen the claim to get the one that matters.

So I have no evidence from this session that TLA+ helps find errors in the conditions themselves. I checked that part by reading one trace against note 22's table, as I would have in any language.

## What it was like

**Getting started: four attempts to the first run.** One 2 MB jar, one `curl`, no install; that part is as light as a toolchain gets. Then: the stable release (v1.7.4) does not accept `ALIAS` in a configuration file, which is the feature that lets a trace print the frontier instead of the raw state. It failed twice with messages that did not say so (first that an invariant named `ALIAS` was undefined, then "expecting = or <-" at a line number). I guessed, fetched v1.8.0, and it worked. v1.8.0 is a rolling pre-release, so the same URL may serve a different file later; I recorded a checksum for that reason. The newer parser then rejected a precedence the older one had not reached. Fourth run: the story, correct, in under a second. Also needed: the JDK by explicit path (the system `java` here is broken), a flag to stop TLC writing a trace-specification file into the directory after every counterexample, and a `states/` directory to ignore.

**After that, everything ran first time.** The three story variants, the four searches and the two-fork runs each did what I expected on their first execution. I think that says less about TLA+ than about the model being small and my having written set-theoretic definitions before. Nothing in the language told me the definitions were right.

**Writing the state function was writing mathematics with no one checking it.** There are no types. A record with a missing field, a set mixing two shapes, a string compared for order: none is an error until a run happens to evaluate it, and some are not errors then either. I made every line event one record shape with dummy fields because I did not trust mixed shapes to compare cleanly. Transitive closure and merging two lines by time each needed a hand-written recursive operator. This is about 75 of `Veri.tla`'s 245 lines (55 to 129), and it is the part TLA+ contributes nothing to. (`PERSPECTIVE.md` says "three quarters" of the file; I counted for this note and that is wrong. It is under a third by lines and most of the thinking. I have left that file alone while it is being audited.)

**Writing the steps and the claims was a pleasure.** `Close(f)` is six lines and reads like the sentence in the spec. Three rules for closing and two ways of joining lines are constants in a configuration, so comparing them was a matter of running nine configurations, not writing nine programs. Stating "every step is a learn, a close, or invisible" took four lines. The best moment was small: when the story's last command is `close` and the fork is not stationary, TLC reports a *deadlock*, with the trace up to it and the frontier at every row. The tool's word for "no step is allowed" was exactly the model's "the close is refused".

**Traces are complete and loud.** A counterexample is the full state at every step. With `ALIAS` I could choose what is shown, which made them usable. I still wrote a dozen lines of Python each time to boil a trace down to one line per step before I could see it. The shortest counterexample is a real gift (the clock case in ten steps; R11 refuted in two), with the catch above: shortest is often degenerate, and you find that out by reading it.

**Run times and what they did to the work.** The scripted story: under a second. Finding a counterexample: seconds. Exhausting a universe to say "holds": 1.5 to 8 minutes for three pieces and two forks, because every event carries a time and so two independent events in either order are two states. The harness moved three of my batches to the background on timeout, and I was polling logs. That is a tolerable rhythm for a spike and a poor one for a gate that runs on every change.

**The configurations sprawled.** One file per claim per rule: 21 `.cfg` files. I generated them from inline snippets that I did not keep as a script, which I would do differently; as it stands a later mind adds a run by copying a file and editing it.

## What I would dread maintaining

- **A second copy of the conditions, kept true by hand.** The model's content is the function from a state to what it owes. In TLA+ that is 75 lines no tool checks against anything, beside the copies in OCaml, Ada, Lean and Datalog. Each wording change to a condition (and the builders' accounts list a dozen in one evening) would have to be mirrored here by a mind that reads both. Under turnover that copy will drift and nothing will say so.
- **Universes and evidence pools built by hand.** Every "holds" is for one tiny universe I chose, and every search result depends on which evidence I put in the pool as possible. A change to the model can make a pool meaningless without any run failing.
- **The clock bound.** "Holds" means within `MaxNow = 12`. Raising it by two would have taken the longest run from eight minutes to, I would guess, an hour or more. I did not measure that.
- **A pre-release jar** as the only version that prints readable traces.

## What a mind arriving cold would need to know

1. `java` is `/opt/homebrew/opt/openjdk/bin/java`; the jar is fetched, not tracked; it must be v1.8.0 or later for `ALIAS`.
2. `./run.sh <cfg> <module>`; output is whole in `runs/<cfg>.out`. Exit 0 is "holds within the bound"; 12 is an invariant refuted; 13 is a claim about steps refuted; 11 is a deadlock, which in the story runs means "the close was refused" and is a result, not a failure. Most runs here are *expected* to end 11, 12 or 13.
3. `Veri.tla` up to the line of dashes before `STEPS` is the state function and is the part to distrust; it was validated only by `story-1` against note 22's table.
4. A counterexample must be read before it is believed to be the interesting one.
5. One TLC at a time, two workers; the exhaustive runs are minutes each.

## Where I land

**As the home for the model's formal layer: no.** The layer's content is data and a function over it, and TLA+ has nothing to say about either. It would hold the model the way a notebook would.

**As a standing part of a combination: I lean no, and here I differ a little from the debrief.** The debrief's division is right as a description: shape for types, what is owed for rules, how states follow one another for a model checker. But the third part is small. Everything TLC found about forks came from a universe of three pieces with the conditions cut to almost nothing, and the questions were of a kind the OCaml explorer already asks ("for every way of dealing events to two forks…"). The lost rewrite would have fallen out of that explorer with one more check. So I would not keep a third language alive for the steps. I would keep the two things TLA+ made me say, which cost nothing to keep and need no jar:

- the verisectorium's visible state is its latest checkpoint's line *and* the record, and its only steps are learn and close;
- stationary is a claim about where a close lands, not about the verisectorium at every moment.

**As an instrument picked up for a question about orders of steps: yes, and it was quick.** By the logs' own timestamps the jar was fetched at 20:29, the story first ran at 20:33 and the clock case came out at 20:39; the writing of M0 before and between those is not timed, and felt like most of the effort. If someone later asks "what can three forks do", or "what if a fork can be rebased", a throwaway specification with the conditions stubbed is the cheapest way I know to get every interleaving and a shortest counterexample. Throwaway is the point: written for the question, kept as a record of the run, not maintained.

What would change my mind: if the model's account of change grew (several roots closing independently, forks of forks, rebasing, delivery pinned at a state) to where the orders of steps are most of what is uncertain. Tonight they were the smaller part.

## What this rests on

One evening, one small model, one mind that had written TLA+ before only from training. I did not try TLAPS (proofs), PlusCal, or Apalache (a symbolic checker that does carry types and might answer the "no types" complaint; I have not used it and cannot say). I did not read the Alloy fork's work, so I cannot say whether Alloy 6 covers the same ground with less friction; the lead can.
