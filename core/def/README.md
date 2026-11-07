# core/def — the definition groups

One file per term group, `<lead-term>.md` (with `-` where the term has `⸱`), or named as `core/model.outline.md` links it. A group holds only terms that cannot be defined without each other; anything that merely belongs to a term gets its own file, even of one term. Terms are nouns; verbs, adjectives and states are defined within the noun they belong to, or declared as subtypes of it (`‹promised›` «row», full name `«promised⸱row»`), never as free-standing terms.

**The leading ```` ```kdl ```` block** (KDL 2.0; what `bin/defs` reads): `group "lead" "other"…`, `status provisional` (until decided by steward and lead), and one `term "name" pos=noun pl="-s"` node per term, with children `subtypes "a" "b"` (states or kinds of the noun; they have no file of their own), `synonyms "x"`, `avoid "word" "why"`, and `rel verb "target"… card="{m,n}" note="…"` (`informal=#true` when the target is not a term).

**Body**, fixed headings: `## Intro` (one or two paragraphs defining every term of the group in relation to the others; a term's first mention is `«TERM»`); `## Terms` (one `### «term»` each: first line is the one-line definition, bullets are invariants, including how the thing fails); `## Discussion` (why it is cut this way); `## Examples`; `## Working Notes` (what is deliberately left open, with a lean; what the group was adjudicated against). Working notes are the segment's inbox, not part of core.

**References** everywhere in core: `«term»`, or `«wording|def/group#term»` for a plural, a different casing, or an ambiguous bare word. A bare `«term»` is valid only while exactly one def defines it or the outline promises it. A subtype is `‹sub›` beside its «noun» on the same line, or alone when unique across the lexicon; `«sub⸱noun»` is its full name and always valid. Inside tables the pipe is escaped: `«…\|def/…»`.

`bin/defs check` verifies all of the above and that the outline's `def` column matches the files. `bin/defs dot`, `overview`, `terms` draw and read the groups in outline order. History of changes to core is in `core/log.yaml` and the commits, never in these files.
