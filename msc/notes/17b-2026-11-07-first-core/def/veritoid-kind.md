```kdl
term "veritoid·kind" pos=noun pl="veritoid·kinds" {
  avoid "filename prefix" "a kind is declared, never carried in a name"
  avoid "speech act" "an earlier model individuated kinds by how they fail; here by what is asked of them"
  rel answers-to term="truth·determinant" card="{1,N}"
  rel allows term="dimension" card="{1,N}" note="which are open for a given veritoid depends on its ground" provisional=#true
  rel declares term="move" card="{0,N}" provisional=#true
}
status provisional
```

# «veritoid·kind»
A declared type of veritoid, saying what form its content takes, what it answers to, and which questions may be asked of it.

## Intro

The «data·store» holds pieces of «content»: a formal statement, a step of a derivation, a paragraph of explanation, a caption, a question, an auditor's note. Every piece of content is of a declared «veritoid·kind», which says what form the content takes, which «truth·determinants» it answers to, and which questions may be asked of it. A «veritoid» is one piece of content of a declared kind, together with the answers to those questions. A veritoid almost never makes sense alone; it sits in a «segment» with others it depends on, and the segment is where it is written and reviewed.

## Definition

### Invariants
- A veritoid moving up any ladder never changes its kind.
- A kind earns its place when some question is asked of its veritoids that is asked of no other kind's, or when some «move» treats them differently.

## Discussion

- Why the piece is defined by what is attached to it and not by how it fails. For months the unresolved dissonance was that the questions asked of content attach to parts of a segment, not to the file, while markdown with frontmatter gives exactly one place to attach anything. The veritoid is the smallest thing questions attach to. "One fate" is then a quality target rather than the definition: a well-cut veritoid is one whose answers move together, and a check that narrows part of a veritoid and not the rest is the evidence that it wants splitting. Grain is discovered by adjudication and recorded as a split, not declared up front.
- Why two levels of content and only two. The decomposition could go on as mathematics ("turtles all the way down"); two levels, veritoids and the segments they are assembled into, is where practice stops, and every rule in the model is stated at one of those two levels.

## Examples

- In ASF's files today a veritoid is usually one second-level section of a segment file, or something smaller inside one, such as one lettered item under a statement, or one of the three entries in a claim record.
- The formal claim of a derived result; one step of its derivation; its plain-language description; its explanation for an eight-year-old. Four veritoids, of three kinds, in one segment.

## Working Notes

- Intro, discussion and examples shared verbatim with former group-mates (veritoid, content); to be rewritten for this term alone when adjudicated.
- Open, and it matters. Whether a veritoid has an identity of its own that survives being moved, or is only its place in a segment. See «recut». Every split, promote and inbox drain hits this.
- Not confirmed. That there are exactly two levels. Joseph said he was still not sure; the discussion's lean is a reading of his "practical granularity".
- Open. Whether the word survives. Joseph offered it half in jest, for having no history; "content+dimensions" was his other candidate.
- Adjudicated against msc/notes 05 (21:52Z), 08/06, 08/07, 08/08, 09 §2.1, 11 def-veritoid.
