---
term-group:
- ontology
status: provisional
terms:
  ontology:
    pos: noun
    pl: -s
    synonyms:
    - store definition
    avoid:
      system model: used for a flow sketch that declared no dimensions
      template: the seed a new store is initialized from; a template may supply a definition but is not one
      schema: right as a comparison, wrong as the word; a definition declares questions and moves, not only shapes
    rels:
    - rel: governs
      to: data⸱store
      card: '{1,1}'
    - rel: declares
      to: veritoid⸱kind
      card: '{1,N}'
    - rel: declares
      to: segment⸱kind
      card: '{1,N}'
    - rel: declares
      to: dimension
      card: '{1,N}'
    - rel: declares
      to: reference⸱kind
      card: '{0,N}'
    - rel: declares
      to: move
      card: '{0,N}'
---

## Intro

An «ONTOLOGY» governs a «data⸱store»: it declares the kinds of thing the store may hold, the questions that may be asked of each, the references that may run between them, and the ways an answer may change. It holds no content of its own. It has versions, and every piece in the store follows one version of its kind.

## Terms

### «ontology»

The declared kinds, dimensions, reference kinds and moves of one store; versioned; holding no content.

- It has versions. Each «veritoid» and «segment» follows one version of its kind.
- It is written by hand for now. Holding the definition itself as content of a store is deferred.
- A change to it is a change to what "steady" can mean for part of the store, and is recorded like any other change.

## Discussion

- A definition is where a store selects from the pattern library and gives its selections local names. A short definition is the aim; the length of the library is where the meaning lives.
- Changes to a definition range from cheap and reversible (a new rung), through easy to apply and hard to undo (a split dimension), to changes that alter what stability can even mean for a set of pieces (a new required slot on every segment). The machinery for this is to grow when needed, as for schema migration generally.

## Examples

- AAT's definition will say that its centre is claims chained by use, that better is stronger claims more firmly established, and which kinds, dimensions and moves it takes from the library under which names.
- The May 2026 lift that wrote the same six slots into 120 ASF segments in two days was a definition change done by hand.

## Working Notes

- Open. How a definition changes over time, and what each veritoid's "version of its kind" means when a kind is split or a slot added. Left open on purpose.
- Open. Whether the definition is itself content of the store (the compiler-style bootstrap) or stays outside it. Deferred by Joseph: not at first.
- Adjudicated against msc/notes 01 §1 (compiler stages), 02 Part B, 09 §4.6, 11 def-verisectorium, 13.
