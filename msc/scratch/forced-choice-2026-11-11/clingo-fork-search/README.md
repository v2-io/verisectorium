# The check both clingo answers asked for

*2026-11-11, spike agent (Fable 5.2). Run after the four forced-choice answers were written and read. `spike-lead.md` and `tla-fork.md` both chose clingo and both named the same thing that would show the choice wrong: the TLA+ fork's two-fork question, never yet asked in clingo. This is that question asked.*

## What it is

`universe.lp`: a checkpoint (an outline pointing at claims c and x, x predicated on c, both checked), up to N events after it drawn from a small menu (rewrites of c and of x, checks, affirmations), each line event dealt to fork a or fork b. The conditions are the spike's `datalog/m0.lp`, **unchanged and not copied**: the same file that runs note 22's story. Three questions, each a file of three or four lines, each asking for the fewest events.

```sh
M=../../spike-formal-perspectives-2026-11-10/datalog
clingo $M/m0.lp universe.lp q1-lost-rewrite.lp -c last=27 --outf=0 -V0
clingo $M/m0.lp universe.lp q2-cannot-both-close.lp --outf=0 -V0
clingo $M/m0.lp universe.lp q3-clock-case.lp -c last=27 --outf=0 -V0                                  # written-against as recorded
clingo $M/m0.lp universe.lp q3-clock-case.lp $M/reading-against-computed.lp -c last=27 --outf=0 -V0   # worked out from the line
```

## What came back (`results.txt`)

| question | answer | time |
|---|---|---|
| two forks each rewrite c differently, each can close alone, the union is stationary (the lost rewrite) | none within 6 events; **found at 8** | 0.14 s |
| forks that write different pieces, each can close alone, the union owes (write skew) | **found at 6**: one fork rewrites c and affirms x beside it; the other rewords x having seen the old c | 0.04 s |
| the clock case, with what a write was written against recorded by the write | none within 8 | 0.01 s |
| the same, with it worked out from the line | **found at 6** | 0.04 s |

So the TLA+ fork's two findings and Alloy's write skew all come out, over the same rules that run the story, in well under a second each, where TLC took minutes and Alloy seconds to minutes. On that much the choice survives its own test.

## What it took, which matters as much

Three runs, and **the first two each gave me a wrong answer that looked like a right one.** Both earlier outputs are kept.

1. *First run* (`results-first-run-two-of-four-wrong.txt`). The lost rewrite came back "none". It was none within six events, and the smallest one needs eight. And the clock case came back "found" under the reading where it should be impossible, because my question asked about any write of x and not the one that selects it. I caught the first only because I knew the answer from TLA+, and the second only because I had predicted "none".
2. *Second run* (`results-second-run-affirmations-silently-forbidden.txt`). Write skew came back "none". A line I had added to keep forks honest (a fork may only affirm what its own line has) referred to the selection at a time for which the rules had no entry, so it silently forbade every affirmation. Nothing warned. I found it by forcing the witness I expected and watching it be refused.
3. *Third run*, with two guard questions added (is the space non-empty; can an affirmation happen at all): the table above.

This is the Alloy fork's vacuous pass and the OCaml builder's missing tag, in my own hands, twice in a quarter of an hour, in the language I chose. A search here is as cheap as I claimed and exactly as easy to get silently wrong as the others said. Every "none" needs its bound stated and a guard beside it, and every "found" needs its witness read.

## What it does not show

The universe is two claims, three versions of one and two of the other, at most twelve events. The OCaml explorer covers four or five pieces and twenty-odd events exhaustively. I did not try that size and do not know where grounding stops being instant. The menu is mine and small. The conditions are M0's six of nine. Nothing here is about the kernel spec.
