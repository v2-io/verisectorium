# def/ — the v2 model as definition groups

*Fable session, 2026-11-06, at Joseph's request. Status of every group: **proposed**. Source for the content: `../model-and-lexicon.md`. Where the two disagree, say so; neither wins by default yet.*

## What this is

The model of `model-and-lexicon.md`, restated as small groups of terms that are defined in relation to each other, with their relations and cardinalities written down as data.

The **form** is taken from the definition entries in `~/src/address-theory/def/*.ud`, which Joseph pointed to as exemplars of form. Only the form is taken. None of address theory's own terms or claims are imported here, and where this lexicon uses a word that address theory also defines (*reference*, *name*), the definition here is this model's own and stands or falls by itself.

It is YAML for now because udon's spelling is still moving. The mapping to the `.ud` form is one-to-one, so migrating later is mechanical.

## The form

One file per **term group**. A group is a handful of terms that are only well defined together.

| Key | What it holds | In the `.ud` exemplars |
|---|---|---|
| `term-group` | the terms this file defines, lead term first | `\|term-group[a][b][c]` |
| `status` | `proposed` for everything here | `:status` |
| `intro` | one or two paragraphs that introduce every term of the group in relation to the others. A term's first appearance is in **BOLD CAPITALS**. Any later mention, and any mention of a term from another group, is written `@{term}` | the leading prose |
| `terms.<term>.def` | a one-line definition | the text after `\|term[x]` |
| `terms.<term>.pos`, `.pl` | part of speech; plural | `:pos`, `:pl` |
| `terms.<term>.synonyms` | acceptable other words | `:synonyms` |
| `terms.<term>.avoid` | words not to use for this, each with the reason. This is where past misuses are named | `:avoid [..] ; reason` |
| `terms.<term>.rels` | relations to other terms: a relation name, the target term or terms, a cardinality `{min,max}`, an optional note | `\|rels :name @{target} {m,n}` |
| `terms.<term>.invariants` | what must always hold, including how the thing fails | `\|invariants` |
| `discussion` | why it is cut this way | `\|discussion` |
| `examples` | concrete cases | `\|examples` |
| `working-notes` | what is deliberately left open, with a lean where there is one; and where the content came from | `\|working-notes` |

A cardinality on a relation reads from the term that carries it: `veritoid` with `sits-in: slot {1,1}` means each veritoid sits in exactly one slot.

## Reading order

`_outline.yaml` lists the groups in the order they should be read. Each group's `intro` leans only on groups before it, except where it says "defined later".

## Checking and drawing

`../bin/defs check` verifies that every file parses, that every `@{term}` and every relation target is a defined term, that no term is defined twice, and that every group is in the outline.

`../bin/defs dot > lexicon.dot` draws every term that has relations, with the relations as labelled edges carrying their cardinalities. That picture is generated from these files, so it cannot drift from them.

`../bin/defs overview` prints the intros in reading order as one continuous text.

`../bin/defs terms` lists every term with its group and one-line definition.

One YAML trap, which the checker now catches: a bare `on`, `off`, `yes` or `no` is read as true or false. Relation names such as "on" are quoted for that reason.

