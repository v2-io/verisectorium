# Debrief: the kernel in Ada/SPARK (Opus)

Joseph, this is the whole spike in plain terms. The detail and the file references are in `account.md` beside this file.

## What was asked

Build the smallest piece of the v2 engine in Ada 2022 with SPARK: an append-only log of changes and acts, the state of the store as of any point in that log, and what is still owed in that state. Prove what can be proved, and report honestly what the language did. Three other spikes are doing the same from the same spec (Rust twice, Ada once more, by a different model).

## What happened

It all got built and nearly all of it is proved. The kernel runs, the worked example runs, a small command-line tool loads a log file and prints the state and what's owed, and gnatprove proves 418 checks at the project's configured level with nothing assumed or waived. Of the eight properties the spec asks for, seven are proved for every possible input. The eighth, that a log written to a file and read back gives the same state, is tested on the worked example and 400 random logs but not proved, because the file reading and writing isn't in the proved part of the code. From the base commit to the last commit was about 47 minutes by the git log, ten of them spent waiting for the big random test run.

The proved core is about 1,400 lines; everything, tests and tool included, is about 3,000.

## What I'd want you to take from it

**On the language question.** Writing the spec's definitions as contracts was nearly a transcription: "position is the greatest rung among checks that still bind and read it" is the postcondition of `Position`, word for word. The first time I ran the prover on the core (positions, ceilings, what's owed, and a proof that the ceiling has exactly one possible value), everything proved without a second try. That made me suspicious, so I then broke the code in six deliberate ways the proofs should depend on, in the core and in the log layer, and each break was caught. The fights with the toolchain were small and each took one round. The one real conceptual snag was that Ada's built-in `=` on records isn't the prover's notion of "the same value", so "the store's state is the log folded up" couldn't be proved until I wrote equality out layer by layer. The fix was in an example shipped with the tool. On fluency, what I can report from one side is this: the language never stood between me and the kernel. The time went into deciding what the spec means, not into making Ada accept it.

**On the scaling question.** It's all done with fixed-size arrays: 32 pieces, 64 acts, 128 records. I re-proved everything with 1,000 pieces, 10,000 acts and 100,000 records, and it still proved, so the proofs don't depend on the small numbers. They do depend on fixed-size storage. A real engine would need growable structures, and I didn't try SPARK's versions of those. That is the largest unknown this spike leaves.

**On the model.** Working through the spec closely turned up places where it doesn't hold together. These are probably worth more to you than the language comparison:

- **The worked example's list of what's owed after the auditor's change doesn't follow from the spec's own definitions.** When c drops to sketch, e's support drops with it, so e now overclaims, and d and e both fall short of what they need from c. The spec lists that shortfall for u but not for d or e. The spec also lists e's reference to c as stale, but nothing later touches e. If that reference stays stale, the example's end state is never clean. The only way the example ends clean is if A's affirmation of e is what brings e's reference up to date. I built that reading, and a test shows the other reading never settles.
- **As specified, an affirmation changes nothing the engine computes.** I gave it one job: it is the only way to update a piece's references without changing its content. Without it, such a change is refused. That's my addition, and the model should decide it.
- **Reverting a piece's content brings old checks back to life** if versions are content hashes. If they're counters, it can't happen. The spec allows either, and they behave differently.
- **A check that read two pieces stops counting entirely when either one changes.** In the example, fixing d took away c's support too, though c hadn't changed. That's faithful to the spec, but it will push people toward checks that read as little as possible.
- **The ceiling doesn't need the no-cycles rule to exist.** It needs the rule to have one unique answer and to rule out circular support. "Each piece is no better than what it rests on" (P6) is too weak as stated, since rating everything at the bottom rung satisfies it. What is proved is the full defining equation plus uniqueness.
- **A single finding produced nine owed items** with one root cause. A frontier that recorded what caused what would be easier to work.

**Choices I made.** A refused change is written into the log with the reason it was refused, and it changes nothing. I chose this because the model's own definition says recording too little is as dishonest as claiming too much. When the log is read back, the engine re-checks every record. The tool also flags any record whose recorded outcome no longer matches what the engine computes, which I tried on a hand-edited file.

## What isn't done

- Proving the file round-trip. My felt estimate is several hours to a day.
- Growable data structures, mentioned above.
- The frontier as a set of owed items isn't connected to which item caused which.
- I didn't try Ada's one property-testing library; the random testing is hand-written.
