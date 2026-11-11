# The Datalog family, pulled apart

*To Joseph and the lead, 2026-11-11, from the spike agent (Fable 5.2). You asked for a bigger table with "those" separated out. `06-languages-as-homes.md` spoke of "the Datalog family" as one thing, and it is four: a language, and three engines that each give it a different meaning at exactly the point this model cares about. This file is the part of that table only I can fill, from use.*

*One thing is new since 06. I had said there that Soufflé was the engine I would most trust and had used least, and that the first step would be to translate the whole small model into it. I have now done that (`datalog/souffle/`, `datalog/runs/17` and `18`), so the Soufflé column below is from use and not from expectation. It took one sitting and ran correctly the first time.*

## How the four relate

**Datalog** is a language, not a program you install: facts, and rules of the form "this holds if these hold", with recursion allowed and "not" allowed under a restriction. With the restriction (no rule may depend on the absence of something that depends on it: *stratified*), every program has exactly one answer, always terminates, and the answer does not depend on the order anything is written in. The lead's account to you was right.

The three engines differ in what they do when the restriction is broken, and otherwise in everything practical.

- **Soufflé** is Datalog and nothing more. It enforces the restriction and refuses a program that breaks it.
- **clingo** (answer-set programming) drops the restriction. A program then has zero, one or several answers, and clingo lists them. It can also *choose*: "pick one version for each piece such that…" is a statement in its language, so it searches as well as computes.
- **SWI-Prolog with tabling** is a general programming language that, with one declaration per relation, evaluates rules to a single answer in three values: true, false, and *undefined* for whatever depends on its own absence.

On a program that keeps the restriction, all three give the same answer. The small model keeps it. So the choice among them is not about what the nine conditions mean today. It is about what happens the day a decision is allowed a condition (note 22 §3.4), and about everything practical.

## The table

Everything in it is from my own use on this model unless marked. "Share of the evening" is felt, not measured.

| | Datalog, the language | Soufflé 2.5 | clingo 5.8 | SWI-Prolog 10, tabled |
|---|---|---|---|---|
| **What it is** | a notation and a guarantee | a compiler for strict Datalog | a solver for rules with choice | a general language with a Datalog-like mode |
| **Share of my evening** | all of it, in the sense that the model was written once as rules | least until tonight: three toy programs and a cut of the model; then the whole model, about a quarter of an hour | most: every run of the model, both footings, the forks, the searches | one file of six toy programs, two runs |
| **What I ran in it** | | the whole small model and the story; three loop programs; an explanation of an owed item | the same model and story; six loop programs; two-fork story; a search over selections; a conditioned acceptance; the model on the causal footing | the six loop programs only. **Never the model.** |
| **First run of the model** | | correct, first time, identical to clingo's frontier at every row (`runs/17`) | correct, first time | not tried |
| **Speed on the story** | | 0.04 s | under a second | not tried |
| **What you must write** | rules | rules, plus a typed declaration for every relation; every constant quoted; an item like `c2_unreconciled(Q,W)` flattened into a kind and two detail columns | rules. Nothing declared. Items can be named with their arguments as they are in prose | rules, plus a `table` line per relation, `tnot` in place of `not`, and care about what is bound when |
| **A misspelled relation** | | **an error, with the line.** Nothing runs | one line marked "info", then an answer as if the relation were empty | an error at run time, only if that rule is reached (from knowledge of Prolog; not tested here) |
| **A status typed by hand beside the rules** | the theory forbids it | accepted without a word (`runs/11`) | accepted without a word (`runs/11`) | accepted, I expect; not tested |
| **A condition that loops through "not"** | outside the language | **refused**, clearly, naming the relations and the line. It also refuses the harmless case where the condition reads only something upstream | zero answers, or two, listed. One answer for the harmless case | *undefined* for the looping ones; the right answer for the harmless case |
| **"Why is this owed?"** | every derived fact has a derivation | **built in**: it prints the derivation, and for something absent, which rule would have given it and which part failed. On the whole model the tree is complete and very wide (`runs/18`); on a cut it is a few lines (`runs/10`). It is an interactive prompt and awkward to script | nothing built in | possible to program; I did not |
| **Search** ("is there a selection such that…") | no | no | **yes, in a few lines** (`selections.lp`) | by hand |
| **Proof of anything for all states** | no | no | no | no |
| **Reading the output** | | tab-separated tables, one per relation; easy | one line of facts per answer; I piped everything through `tr` and `sort` | whatever you print |
| **What it suits in this model** | being the form the nine conditions are *stated* in | being the one copy that runs, is checked for names, and explains itself | trying a reading of the spec in two lines beside another; finding out whether a rule loops; searching small spaces | giving the third value to a looping condition; and, being a full language, the glue around an engine. On the evidence of six toys |
| **What I would dread** | | every relation's declaration to keep in step with its rules; the flattening of item names; the explainer as a prompt | silent emptiness: the answer gets *shorter* when something is misspelled, and shorter looks like "nothing owed" | it accepts everything. Order of clauses and of goals matters in ordinary Prolog and a reader has to know which relations are tabled |
| **As the home for the conditions** | yes, as the notation | **yes, as far as I have now seen**, while decisions stay unconditional | as the workbench beside it, not as the copy of record | cannot say; I did not run the model in it |

## What changed in my own view by doing the translation

- 06 said the cost of Soufflé was "every relation declared with types and every constant quoted, and I judged the full model not worth translating for one evening". Having done it: fifty-three declarations for fifty-five rules, mechanical, and the facts for the story I converted with ten lines of script. The declarations are not only a cost. They are the stored vocabulary written down once and checked, which is the part of "as types instead of terms" that every fork agreed is reachable. In Soufflé the vocabulary and the conditions are one file in one notation.
- The misspelling test is the difference that matters most to me. I ran the same slip through both. clingo answered. Soufflé stopped.
- An earlier caveat is retired. `datalog/PERSPECTIVE.md` §5 says that the small model being stratified "is from my script, not from Soufflé accepting it". Soufflé has now accepted the whole model.
- One thing I did not expect to care about: clingo let a frontier item be named `c2_unreconciled(c, c2)`, as a person would say it, and Soufflé wanted `"c2_unreconciled", "c", "c2"` in fixed columns. Soufflé has record and sum types that would probably close this. I did not try them.

## Where this leaves the one real decision

If decisions may have conditions, as note 22 §3.4 says and as the builders' rule currently forbids, then strict Datalog cannot hold the model: Soufflé refuses even the harmless case, with the same error as the paradox. The conditions would then have to live in clingo (and someone must say what two answers mean) or in a tabled engine (and someone must say what *undefined* means, which could simply be "owed"). If decisions stay unconditional, Soufflé is enough and is the one I would pick.

So the engine choice follows the model decision and should not be made first. I would not want the convenience of Soufflé to settle a question about decisions by default.

## What I did not use, and cannot speak to

Soufflé's compiled mode, its record and sum types, its JSON form of explanations, or anything at size. clingo's Python interface. The model in SWI-Prolog. Any incremental Datalog engine (one that updates the frontier when an event is added, without recomputing), which is what an engine for a real verisectorium would want and which I know of only from training. Whether fifty-five rules stay readable when they are two hundred.

## For the bigger table

The four columns above are ready to lift. For Lean, Alloy and TLA+ the cells are in each fork's own `AS-A-HOME.md` and summarized in 06; I would take their words over mine. For OCaml and Ada I have nothing firsthand. If it would help, I am glad to draft the whole table once the builders' notes exist, with each cell marked by whose use it rests on; equally glad for the lead to assemble it, since the lead is the one reading the builders' code.
