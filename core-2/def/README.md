# core-2/def — the term definitions

The form is `core/def/README.md`'s, unchanged: one file per term, `<term>.md` with `-` where the term has `·`; a leading ```` ```kdl ```` block (KDL 2.0) with one `term "name" pos=noun pl="…"` node, children `subtypes`, `synonyms`, `avoid "word" "why"`, and `rel verb term="target" card="{m,n}" note="…"` (`informal=#true` when the target is a plain word, `provisional=#true` when the relation itself is a lean); then `status provisional`, or `status decided by="…" on="…"`.

Body, in order: `# «term»` with the one-line definition under it; optional `## Intro`; `## Definition` with `### Invariants`; free sections as needed; `## Discussion`; `## Examples`; `## Working Notes` (required: what is left open, with a lean; what the term was adjudicated against). Working notes are the term's inbox and are not part of the model.

References: `«term»` for a term with a file; `‹subtype›` for a declared subtype. Plain words defined by the outline's inline rows (ontology, log, state, content, identity, version, assertion, warrant, name, slot, inner dependency, row, actor, criterion, affirmation, acceptance, chunk, inbox, rendering) are written plainly, without guillemets, and mean what the outline says.

`bin/defs check core-2` is the gate.
