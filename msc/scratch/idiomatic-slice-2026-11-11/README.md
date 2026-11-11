# One small slice, written the way each language would want it

*2026-11-11, set up by the lead (Fable 5.2) at Joseph's request. Scratch.*

## The ask, in Joseph's words

After seeing excerpts cut from the existing builds side by side: "Rather than the code segments as they already existed, I'd love to see a representation (including content for veritoids) that is idiomatic in that language with that small subset". The subset he had named earlier: "veritoids + segments + slots + 'canon' designations or something smallish but meaningful".

So this is not a port of the kernel spec or of the spike's small model. It is the question: if this little piece of the model were yours to write in your language, and nothing else had to fit around it, what would it look like? Where the language has a natural way to say something (or a natural refusal), that is the thing he wants to see.

## The slice

From `msc/notes/22` Part 2 and §3.5, and nothing else:

- A **segment** is a **veritoid** or an **assembly**.
- A **veritoid** is one piece of **content** of a declared **kind** (a claim, a derivation step, an explanation). Here the content is a sentence of text.
- An **assembly** has **slots**, declared by its kind: what kind of thing fills each, how many (one, at most one, any number), in order.
- A slot is **suggested** (with a note), **promised**, a **gap**, or filled: it **holds** a segment that lives in it, or **points at** one that lives elsewhere. A filled slot may be marked **provisional**.
- Some assemblies are marked as **roots**. **Canon** is what the roots reach through slots that are filled and not provisional.

Left out on purpose: versions, events, evidence, decisions, the nine conditions. One state, no history.

## One instance, so the eight can be compared

Assembly kind `derived-result`: formal-claim (one, a claim); derivation (any number, steps); description (one, an explanation); eli8 (at most one, an explanation). Assembly kind `outline`: any number of slots, each taking a segment of any kind.

| piece | kind | content, or slots |
|---|---|---|
| c | claim | "Every bounded monotone sequence of reals converges." |
| d | step | "Take the least upper bound of the terms and show the terms come within any ε of it." |
| k | explanation | "If you keep stepping forward and there is a wall you cannot pass, you end up settling somewhere at or before the wall." |
| T | derived-result | formal-claim holds c; derivation holds d; description is promised; eli8 holds k |
| u | claim | "Every Cauchy sequence of reals converges." |
| U | derived-result | formal-claim holds u; nothing else yet |
| O | outline, marked as a root | 1: points at T. 2: points at U, provisional. 3: suggested, "a result about series is probably wanted here". 4: a gap |

Expected: canon is O, T, c, d, k. U and u are not in canon (the slot that reaches U is provisional). It would be good to be able to ask "which slots are promised and empty" as well, and get T's description; but only if that falls out naturally.

## What lands here

One file per language in this directory, named for the language, that actually compiles or runs, holding the slice and this instance and showing the canon it computes. And a few lines, in the file or beside it, on which of the language's idioms you reached for and why, and anything the language made awkward or refused. If the idiomatic way to write it departs from the slice as worded above (a different cut of slot states, kinds in types, content as something richer than a string), that departure is exactly what is wanted; please just say so.

Joseph has asked that agents keep to two or three processes at a time on this machine.
