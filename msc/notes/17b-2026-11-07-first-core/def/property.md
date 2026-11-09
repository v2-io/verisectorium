```kdl
term "property" pos=noun pl="properties" {
  subtypes "written" "computed"
  avoid "field" "a field is how a property may be stored; the property is what is known about the piece"
  avoid "attribute" "a plain measurement with no judgment in it, such as word count or age; defined with the dimension group"
  rel of term="veritoid" card="{1,1}" provisional=#true
  rel of term="segment" card="{1,1}" provisional=#true
}
status provisional
```

# «property»
Anything the data store holds about a veritoid or segment, each either written by an author or computed by the store.

## Intro

A «property» is anything the data store holds about a «veritoid» or a «segment» beside the bare fact of its existence: its content, its «ground», its «bounds|def/bound#bound», its «claimed·level», its references, its values, a segment's assembly, a projection's members and order. Every property is one of two kinds, and the line between them is what the rest of the model stands on. A ‹written› property is set by an author and changed only by a «segment·changeset». A ‹computed› property is produced by the data store from what has been recorded, as of a «state», and is never set by anyone.

## Definition

### Invariants
- ‹written›: set by an author, reconciled by the author inside the changeset at one instant, never set by the store. Content, ground, bounds, claimed level, references, a segment's assembly, a projection's members and order.
- ‹computed›: produced by the store from what has been recorded, as of a state; the same recorded things read in any order give the same answer; never typed. Every «value», every attribute, whether each reference holds, every «roll·up».
- A typed status word is a ‹written› property wearing a ‹computed› one's clothes.

## Discussion

- The whole discipline of "status is computed from recorded acts, never typed" is this line. Everything the sprint found wrong with hand-set status words follows from their being on the wrong side of it.
- Values are not the author's to set: the moment a changeset is staged, every act that read what changed stops binding and the affected values fall; earning them back takes further acts, usually by other minds, in work time.
- Acts are neither. They are recorded, not written by an author about a piece, and they are the store's input rather than its output. What is written and what is computed both answer to the record of acts.

## Examples

- An author rewrites a claim and affirms its description. Both are ‹written›. The claim's "independently re-derived" is ‹computed›; it falls at once and comes back only when a second mind re-derives the new text.

## Working Notes

- Open. Whether "property" is the right noun, or whether the two kinds want a noun each. Lean: one noun with two subtypes, since the point is the line between them.
- Adjudicated against msc/notes 09 §2.7 and §4.1, 11 def-written, and the 11-06 transcript (acts as a third kind, 12:18–12:20).
