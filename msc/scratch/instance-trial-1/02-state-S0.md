# kvl at S0: corpus and acta

Ids are shown as short names; in the model each is a minted id. `@1` means version 1 of a veritoid.

## Corpus (written)

**O**, freestanding, kind *spec*, canonical. Slots: (1) points at S1; (2) points at S2; (3) points at G.

**G**, freestanding, kind *grounds*:
- p1@1 (premise): "Most kvl files will be written by hand, by people who already write INI files."
- p2@1 (premise): "Values that must keep leading or trailing blanks are rare enough to leave unsupported."

**S1 "Lines"**, freestanding, kind *section*:
- rules: r1@1 "A file is a sequence of lines separated by LF; a CR before the LF is removed." · r2@1 "A line whose first non-blank character is `#` is a comment and is ignored." · r3@1 "Every other non-blank line is an entry: a key, the separator `=`, and a value; the first `=` on the line is the separator." (predicated-on r1)
- rationale: x1@1 "`=` is used because the people writing kvl already write INI, where `=` is the separator." (narrates r3)
- examples: e1@1, with input `name = kvl # the name` and `# a comment`, expecting `{"name": "kvl"}`, predicated-on r2, r3, r4.

**S2 "Keys and values"**, freestanding, kind *section*:
- rules: r4@1 "Blanks (space, tab) around a key and around a value are removed." (predicated-on r3) · r5@1 "Keys are case-sensitive." · r6@1 "If a key appears more than once, the last entry wins." (predicated-on r5)
- examples: e2@1, with input `a=1`, `A=2`, `a=3`, expecting `{"a":"3","A":"2"}`, predicated-on r5, r6.
- questions: q1@1 "May a key be empty (`= x`)?", with the steward as closer.

e1 is already wrong at S0: under r2 and r3 the value is `kvl # the name`. Nobody has noticed yet. That sets up move 2, and it matches the stopped-bound lesson: a steady state promises that nothing outruns the record, not that the record is right.

## Acta up to S0 (done)

| actum | sort | by (seat) | concerns | reads | outcome / basis |
|---|---|---|---|---|---|
| a1 | testimony | Ines (steward) | p1 | p1@1 | "I asked six INI users who said they would hand-write kvl." |
| a2 | testimony | Tomas (implementer) | p1 | p1@1 | "Our pilot users' files were all hand-written." |
| a3 | decision (assent), answers *backed* | Ines (steward) | r3 | r3@1, p1@1 at *supported*, G | choose `=` over `:` and over both; importance **major**; reopen if p1 fails; consulted Tomas |
| a4 | decision (assent), answers *backed* | Tomas (implementer) | r3 | same basis as a3 | assent |
| a5 | decision, answers *backed* | Ines | r2 | r2@1, p1@1 at *supported* | `#` over `;` and both (INI uses both; one is simpler); **minor** |
| a6 | decision, answers *backed* | Ines | r1, r4, r5, r6 (one act each, a6a–a6d) | each rule; p2@1 for r4 | **minor** |
| a7 | testimony | Ines | p2 | p2@1 | "No one in the pilot needed it." |
| a8 | check, answers *consistent*, means pairwise reading | reviewer M (bare brief) | r1–r6 | r1–r6 @1, S1, S2, O | criterion fixed first: "no input with two parses"; **confirmed**. One act concerning six rules: it lapses as a unit. |
| a9 | check, answers *conforms*, means hand derivation | M | e2 | e2@1, r5, r6 | confirmed |
| a10 | run, answers *conforms*, means reference parser | instrument kvlp@0.3 | e1 | e1@1, r2, r3, r4 | **confirmed**: kvlp outputs `{"name":"kvl"}` |
| a11 | run, answers *conforms* | kvlp@0.3 | e2 | e2@1 … | confirmed |
| a12 | testimony that M read x1 against r3; answers *faithful* | M | x1 | x1@1, r3@1 | confirmed |
| a13 | check, answers *coherent*, whole read | reviewer N | S1; then S2 (a13b) | S1 and everything it holds; S2 likewise | confirmed |
| a14 | decision, answers *accepted* | Ines | O | O, S1, S2, G, each at *accepted* | assent |

**Two places where S0 is not what it looks like:**

- e1 has *conforms* by one means only (the a10 run). Under its read-as (both means) it is **not confirmed**, so e1 is **not accepted** by rule. S1 requires examples? No: the examples slot is 0..N, not required, so S1 is accepted while holding an unaccepted e1. «segment» allows this: "An accepted assembly may hold a provisional piece in a slot that is not required." So e1 is provisional and owes nothing, and S0 is steady. Nobody will notice e1 is wrong, because nothing asks.
- *Never asked*, for the steady state's conditions: conforms by hand derivation on e1 would be listed, except that e1 is not in canon, and the conditions list only "every piece in canon whose warrant is never asked". So **S0's stated conditions are empty**, while the one wrong statement in the spec is visible only as "e1 provisional". q1 is an open question in canon, and it does not appear in the conditions either, because *answered* is not a determinant (finding 9).

## Computed at S0

- Warrants: r1–r6 backed (r3: steward + implementer); consistent confirmed (a8). p1 *supported* (a1, a2; two lines, assuming the two testimonies are independent: Ines asked her six, Tomas his pilot). p2 *thin*. e2 conforms (both means). e1 conforms by one means.
- Accepted (computed by rule): r1–r6, p1, p2, x1, q1, e2, S1, S2, G; O by assent a14. e1 is not accepted.
- Frontier: empty. **S0 is a steady state of the whole, with no stated conditions.**
