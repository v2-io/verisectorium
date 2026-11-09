```kdl
term "claimed·level" pos=noun pl="claimed·levels" {
  avoid "status" "ASF's frontmatter word was a claimed level written as if it were a value"
  rel of term="veritoid" card="{1,1}" provisional=#true
  rel compared-with term="value" card="{1,N}"
}
status provisional
```

# «claimed·level»
What a veritoid's content asserts about its own support; written, and compared with what is computed.

## Intro

A «claimed·level» is what a «veritoid»'s content asserts about its own support: "theorem", "exact under these premises", "conditional", "hypothesis". It is ‹written›, like the content, and it is not a «value». The store's work is to compare it with what has been earned; a claimed level above what the computed values allow is an inconsistency and goes on the «frontier». To *soften* a claimed level is to lower it, or to narrow what the content says; it is honest and it is the easy thing, and its quick calm is often false because of «latent·level»s downstream. Softening never leaves a ghost: the body states what is now held, and the former claim is in the «log».

## Definition

### Invariants
- There is only ever one. What it used to be is a matter for the «log».
- A claimed level above what the computed values, or the «latent·level» from its premises, allow is an inconsistency on the frontier.

## Discussion

- For a «theory·claim», the claimed level is part of what is said, not a confidence: "conditional" says the statement has hypotheses beyond the standing context, and a conditional result with a complete derivation is fully established as the if-then it is. Strength of claim and how sure pull against each other; a ladder ordered by strength is wrongly read as a ladder of confidence.
- What is claimed, what has been done, and what is thereby warranted are three things kept apart for every question about every piece. The claimed level is the first; the acts are the second; the «value» is the third. Honesty is that the first never exceeds the third.

## Examples

- Theorem. Exact under these premises. Conditional on (S1)–(S5). Hypothesis. Robust-qualitative.

## Working Notes

- Open. Where a claimed level lives: a field beside the content, a word inside the content ("Theorem"), a bound, or something the veritoid's kind declares. Lean: a field, so that the comparison with values is mechanical.
- Open. Whether "claimed level" is one field or several. ASF's labels say what is asserted is several separate things: conditions, sharpness, forced or chosen, kind of support, whose. See «claim».
- From the kernel spikes. The comparison a claimed level is held to is the *ceiling* (the piece's own position capped by what it rests on, the «latent·level»), and the spikes found the statement of that cap in `KERNEL-SPEC.md` too weak: "ceiling ≤ position and ≤ every target's ceiling" is satisfied by rating everything at the bottom rung; the real contract is the defining equation, ceiling = min(position, min over targets), which both Ada kernels proved, with uniqueness on an acyclic graph (Ada/Opus). When the ceiling is written into «value» or «latent·level», it should be the equation, not the bound.
- Adjudicated against msc/notes 01 §7, 09 §2.2, 11 def-written, 12.
