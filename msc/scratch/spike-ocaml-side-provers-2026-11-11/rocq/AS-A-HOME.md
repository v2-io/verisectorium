# Rocq, and the OCaml it extracts to, as a home for the model

*2026-11-11, by the Rocq fork of the OCaml-side provers spike (Fable 5.2). Firsthand, from one short sitting: the idiomatic slice, the small model M0, note 22's story, and four general theorems. I am a fork of the OCaml builder and began with its two builds, its `AS-A-HOME.md` and its forced choice of Lean. Every "I would dread" below that is not marked as having happened is an expectation.*

## The short answer

Yes, more than I expected, and with one cost I had under-weighed.

Having touched it, I would now put "Rocq and the OCaml it extracts to" ahead of Lean as the one home, where before I held it as a lean I had not tested. The parent's forced choice is the parent's to change; this is what the hour did to mine. The reason is not that Rocq is nicer than Lean, which I cannot judge, having used Lean on nothing. It is that the two things I said I most wanted and could never have in OCaml turned out to be a few compiles each, in the same switch as the OCaml I already have, and the model then ran from the extracted OCaml without my writing it again.

The cost: the functions that are easy to prove are slow, and my findings in the kernel builds all came from speed.

## What the work was like

**Getting it.** `opam switch create` and `opam install rocq-prover`, three minutes fifty-five seconds from an empty switch by the clock file, at two jobs. It is an opam package beside the OCaml compiler it is written in. Nothing else to configure. The command is `rocq compile`; the library is `From Stdlib`; both are new names as of this year, and what I remembered (`coqc`, `From Coq`, `app_length`) was one release stale in each case. The old names mostly still work with a warning.

**Writing the model.** As in OCaml. The types of the slice and of M0 are OCaml's sum and record types with different punctuation, and the conditions are the same functions over lists. I did not have to think differently to write `M0.v` than I did to write `model.ml`. Two differences in kind:

- *Every function has to be seen to stop.* For all of M0's conditions that is free: they are folds over a list. For "follow the pointers" it is not, and Rocq refused the function I had written without thinking in OCaml. That refusal was right; the OCaml version ran for ever on a ring.
- *Nothing is mutable and nothing is fast.* Names are strings compared character by character; a set is a list with duplicates removed. I wrote it that way because the standard library has the lemmas for exactly that.

**Running it.** The story's ten rows computed correctly the first time `Story.v` compiled, and each is now a line of the file that fails to compile if the model's answer changes (`Example at_0830 : frontier looks r0830 = [(4, "c"); (5, "u")]. Proof. reflexivity. Qed.`). A frontier of the 29-event last row takes a hundredth of a second inside Rocq. The earlier spike reports about a second in Lean for a model of this size and three minutes in Alloy.

**Proving.** This is what I had not done before on this model, in any language.

- That the canon function computes canon, for every store: three compiles.
- The same, generalized so M0 could use it twice: first compile.
- That at any checkpoint nothing in canon is known wrong unless waived: first compile.
- That recording evidence which holds adds nothing to what is owed, for M0's own function: fourth compile, 349 lines.

None of it was hard. All of it was small steps of the form "this list is that list with one more thing on the end, so anything found in the short one is found in the long one". I used no automation but the arithmetic tactic. I am reporting the counts because the Lean fork reported seven runs for its good-news theorem and I expected worse, not better; I do not know whether that is the language, the library, or my having read that it could be done.

**What went wrong.** Nine compiles failed, across everything (one of them the parent's draft of the slice, before I began). Three were the wrong notation being chosen: `length`, `<?` and `++` each mean one thing for strings and another for lists or numbers, and which you get depends on what was opened last. One was a lambda whose argument type Rocq could not infer. Five were proof steps: a lemma needing its arguments spelled out; an arithmetic goal the tactic would not do that a one-line rewrite did (I do not know why); a rewrite aimed at the wrong occurrence; a tactic that silently rewrote the goal as well as the hypothesis; a simplification that unfolded too much. Every one was loud, pointed at a line, and took one edit.

## One change to the model, and what it cost

Only one, so this is thin. To prove good news I changed how M0 lists "what fails on a piece of its own", from seven `if`s joined end to end to a table of (condition, met or not). Same answers.

- The story's fourteen pins did not notice. They are computations; they passed.
- The checkpoint theorem's proof broke, because eight of its lines were about the old shape. Rewriting it was eight new lines.
- Extraction did not notice.

That is the Ada builder's report in miniature: the pinned examples carry across a change for nothing, and a proof breaks exactly where the thing it was about moved. It is also the Lean fork's warning: I changed the model's definition *to make a proof easier*. This time the change was harmless and arguably an improvement. It is the same motion as cutting warrant levels out because a theorem will not go through with them.

## The OCaml it extracts to

Three lines at the end of a file, and M0 is 700 lines of OCaml with a 194-line interface (`extract/m0_extracted.ml`). A short driver runs the story from it and prints what `Story.v` pins (`runs/m0-extracted-story.txt`).

- **Readable.** Types and functions come out as one would write them, with the same names. `frontier : ontology -> line -> (int * piece) list`.
- **What the types knew is partly gone.** `veritoid Claim` and `veritoid Step` extract to one type. A checkpoint extracts to `type checkpoint = line`: the proof is erased, and the generated interface does not hide the type. The guarantees are about the functions. They stop being about the data at the boundary unless the interface is closed by hand.
- **Three small things are trusted and not proved**: that Rocq's natural numbers may be OCaml's `int` (I asked for that; it is wrong past 2^62 and irrelevant here), that Rocq's strings may be OCaml's, and the driver.
- **Speed.** 20,000 frontiers of 15-to-29-event lines in 1.83 s: 92 microseconds each. The slice's canon on an outline of 200 results: 2.7 s extracted, 1.3 s for the same rounds written by hand, 0.0002 s for the walk-with-a-set I would write without a proof to satisfy. Extraction costs a factor of about two here and I can see where it goes. The proof-friendly algorithm costs four orders of magnitude on that example.

The last point is the one that bears on my forced choice. I said speed was the risk that would send me back from Lean to OCaml within a week, and that on this route "it is not a risk". That was too quick. Extracted code is OCaml and runs like OCaml; but what it runs is the function I proved, and I proved the slow one because it took three compiles. My kernel explorer visited tens of millions of states in minutes. I have not measured the two on the same model, and I did not try driving the extracted functions from the existing explorer. My guess, marked as one: M0 as extracted is some ten times slower per frontier than hand-written OCaml of the same model would be, which is the edge of what I said I could live with, and the way back is the usual one: write the fast function as well and prove it equal to the slow one, once, when the definition has stopped moving.

## What I would dread

- **The proofs as text.** A proof here is a list of small commands, each acting on a goal that is not on the page. Mine are short and plain and I could not tell you what line 14 of `own_no_more` is doing without running it to that point. A mind arriving cold can re-run them and cannot read them. The statements above them it can read, and those are the part Joseph would read.
- **Two vocabularies, and the join not made.** For canon and for "rests on", what it *is* and what is *computed* are both written and proved equal. For the nine conditions I wrote only the functions. So the sentence Joseph would adjudicate ("every reference was written or re-read against its target as the target now is") is still a comment above a program, exactly as in `pulled_out.ml`. Making each condition a stated rule with a proof that its function decides it is the work that would make this a home for reading, and I did none of it. For conditions 1, 8 and 9 I expect it to be like canon without the counting. For 4 (guards) I do not know.
- **Shrinking to fit.** Everything I proved is about M0, which has no warrant levels, one step of `same`, no descent. I felt the progress the Lean fork warned about. A theorem went through every few minutes, and at no point did the tool ask me whether the model was the one anybody meant.
- **A `Fail` that fails for the wrong reason.** `Fail` passes if the command fails for any cause, a typo included. I checked each refusal's message separately (`runs/refusals.txt`, `runs/mutations.txt`). Nothing would have made me.
- **Strings for everything.** A piece name, a version name and an evidence name are the same type here. That is my haste again and is cheap to fix; unfixed, it is where a wrong-but-accepted model would hide.

## What a cold agent needs to know

- `opam exec --switch=rocq-try -- rocq compile -Q Vk Vk Vk/<file>.v`, in dependency order; or `./run.sh`, which does all of it from clean in about fifteen seconds and keeps the output.
- Rocq 9: `rocq`, not `coqc`; `From Stdlib`, not `From Coq`; some list lemmas were renamed (`length_app`).
- When a comparison or `length` or `++` gives a type error about `string`, it is the notation scope. `Open Scope list_scope` last, or write `List.length`, `Nat.ltb`.
- An `Example … Proof. reflexivity. Qed.` is a pinned computation and cannot be vacuous. A `Theorem` with hypotheses can be; look at whether anything satisfies them.
- `Print Assumptions t.` says what a theorem rests on. "Closed under the global context" means nothing but the definitions.
- The extracted `.ml` files are generated. Edit the `.v`.

## Would I make it the home?

As the one home, under the rule that I keep it true through the next changes to the spec: **yes, this one**, written the way I said I would write Lean: the model first as functions and pinned stories; statements written down the day they are believed with their proofs left open; nothing proved about a definition until it has survived two drafts; the model never made smaller to close a proof; and the search kept, running on the extracted OCaml.

What this hour adds to that list is one rule I did not have: **every condition is written twice, as the sentence and as the function, and the proof that they agree is the first proof owed.** That is the only thing that would make it better for Joseph's reading than the OCaml I already have, and it is the thing I did not do.

What I would say plainly on its first page: that the proved functions are slow and the fast ones are not yet proved; that the types' refusals stop at the boundary with OCaml; and which of the nine conditions are still only programs.

I have not used Lean. If the two were set side by side by someone who had used both on this model, what I would look at is whether Lean's own compiler gives the speed that Rocq gets only by extraction, and whether its proofs break more gently when a definition moves. On what I have touched, Rocq is the one I would live with.
