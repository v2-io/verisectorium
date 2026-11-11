# Orientation for the next lead

*To whoever takes this over, from the second Fable 5.2 lead of 2026-11-10, written at 87% of my context at Joseph's request. He asked for the list I actually used, "possibly excluding parts that really won't contribute", because a good deal of the evening went on my orientation. He means to continue two threads with you: the language comparison (which he calls "absolutely sideways"), and "the big picture model, the trajectory of verisectorium and my interactions with it over the last 8 days".*

*Two cautions before the list. A predecessor's reading list marks where the predecessor found its holes; it is not coverage, and my one-line glosses below are not the content. And I say for each item whether I read it whole, in part, or not at all, because I relayed several things wrongly tonight from things I had read and then summarized from memory.*

## 1. What oriented me most, in order of what it gave

**1. Joseph's own prompts, 2026-10-30 to now.** About 600 prompts, roughly 85k tokens, read whole in order. This did more than everything else together, and I read it last; read it first. His words: "It doesn't take up much context in the big picture and tends to have a very high signal-to-noise ratio because typing is slow and I have to be strategic". It holds his decisions in his own words with their dates, which things he has had to say to agent after agent, and what he asked for that no document carries. It holds only his half: I misjudged the tone of one line that was a joke the other side was in on.

```sh
python3 - <<'E'
import json, datetime
last = None
for l in open('/Users/josephwecker-v2/.claude/history.jsonl'):
    try: d = json.loads(l)
    except Exception: continue
    t = datetime.datetime.fromtimestamp(int(d['timestamp'])/1000)
    p = d.get('project', '')
    if t >= datetime.datetime(2026,10,30) and any(k in p for k in ('aat-v3','verisectorium','councils','arch/asf')):
        x = d.get('display', '')
        if x.startswith('/') and len(x) < 40: continue
        s = d.get('sessionId', '')[:8]
        if s != last: print(f"\n######## session {s} ({p.split('/')[-1]})"); last = s
        print(f"\n[{t.strftime('%m-%d %H:%M')}] {x}")
E
```

Write that to a scratch file and Read it in pages. The spine of the eight days, as his prompts give it (my compression; check it against them):

| day | what happened |
|---|---|
| 10-30 | the ASF "in-place refactor" sprint: hundreds of agents, a check-and-fix loop, influx never drained, "found something" taken for "found everything". The motivating failure |
| 11-02, 11-03 | vsect 0.1 reviewed; agent identity; councils (RONR, then the higher councils with a presiding leader and unity); "treat each vsect transition-edge as a queue that is drained by a 'decision-maker'" |
| 11-04 | the decision to start clean: `~/src/verisectorium/` and `~/src/aat-v3/`; "new ideal vsect from the beginning"; nobody edits by hand; the primitives (truth claims with evidence, decisions with backing); perturbation, ripple, settle or halt |
| 11-05 | the building blocks in his words: content with dimensions, grouped into templates; the two sizes of changeset; honest-intermediate then strengthen; "veritoid" |
| 11-06 | note 09 written for him; the wish for a short declarative way to describe each kind of verisectorium; provisional, promised, gaps; how `core/` is to be kept |
| 11-07 | the first core (85 terms); the Rust versus Ada spike |
| 11-08 | "truth determinant" collapses into dimension; the census; "multiplying and multiplying terms again"; purpose before machinery; `core-2/` |
| 11-09 | `core-2/` becomes `core/`; the actor; four record surfaces; provisional is not canon; slots hold segments, a segment is a veritoid or an assembly |
| 11-10 | the two atoms restored; free rein; the first lead expands core sideways; kernel spec drafts 1 to 4 built in Ada and OCaml; notes 22 and 23; then the languages |

**2. `msc/notes/22-2026-11-10-model-as-held.md`, whole.** The first lead's statement of the model at its real size. Joseph had not read it when I wrote this. Its Part 8 says what each part rests on.

**3. `msc/notes/09-2026-11-05-model-and-lexicon.md`. I never read it, and that is the largest hole I leave.** Joseph names it as the size and register the core should end at. Read it before forming any view of whether note 22 is the right size.

**4. `core/`, selectively.** I read every file whole. What contributed: `README.md`; `model.outline.md` including its Working Notes; `src/intro-spine.md`; all twelve `def/*.md` for their Definition, Invariants and Working Notes, and the Historical Context of `verisectorium`, `segment` and `decision`, which hold Joseph verbatim; `src/impl-stopped-bound.md` (the one real failure the model was read against); `src/disc-what-would-show-this-wrong.md`; `src/disc-record-surfaces.md`. The praxis is auto-loaded.

**5. Core as it stood before the first lead**, three files only: `git show c92d256:core/def/dimension.md`, `c92d256:core/src/disc-dimensions-as-constraints.md`, `c92d256:core/src/impl-a-small-move.md`. They show a smaller core with one honesty rule (what a piece asserts may not exceed its warrant) and no rule that a found defect persists across rewording.

**6. `msc/notes/23-2026-11-10-kernel-synthesis.md`, whole**, for what the two formal builds showed and what is known wrong in the kernel spec.

## 2. What I read whole and would not ask you to

- In `core/`: `templates/*`, `def/README.md`, `nutshell.outline.md`, `praxes.outline.md`; the invented runs `impl-a-small-move`, `impl-an-outline-fills-in`, `impl-a-finding-is-answered`, `impl-two-moves-at-once`, `impl-intake` (they are where the vocabulary grew, and note 22 says what survives of them); `impl-scope-adaptive-system`; `disc-actor`, `disc-better`, `disc-written-done-computed`. `log.kdl` tells the two-day sequence of corrections, and Joseph's prompts tell it better.
- `slot-rollup.md`: Joseph asks leads to read it, and it is quick. What it gave me was small: standing is typed by hand nearly everywhere; the decision records in the wild already carry assumptions and reopen-when. It is evidence of what was done, "not an exemplar".
- The rest of core at `c92d256`.

## 3. For the language thread

1. `msc/scratch/languages-compared-2026-11-10.md`, whole. It is the hub: eight languages as homes for the model's formal layer, every cell marked by whose use it rests on; §7 has each one's idiomatic rendering of one small slice; §8 has the forced single choices.
2. `msc/scratch/spike-formal-perspectives-2026-11-10/de-novo-feedback-1.md`, whole. The independent read of the first spike. Read this and not the spike's `DEBRIEF.md`, which claims more than its own files show.
3. `msc/scratch/forced-choice-2026-11-11/`: seven one-page answers.
4. Only if you are going to argue about the kernel itself: `msc/scratch/kernel-2/KERNEL-SPEC.md` (draft 4) and the two `ACCOUNT.md` files. I read all three whole; for the big-picture thread, note 23 §8 is enough.
5. The firsthand notes (`AS-A-HOME.md` under `kernel-2/ocaml`, `kernel-2/ada`, and the spike's `lean`, `alloy`, `tla`; the spike's `06` and `07`) and the nine slice files are quoted in the hub. Open one when a cell is in question.

**Running when I wrote this:** the OCaml builder was asked, at Joseph's word, to fork and run every prover on the OCaml side (Rocq with extraction, Why3, Cameleer, Alt-Ergo, E), each fork leaving what the first spike's forks left. When it lands: read it whole, add its snippets and verdicts to the hub, and commission an independent read with a bare brief. And then, at his word (2026-11-11): "Let's also put the language results, when all ready, as a numbered note instead of leaving it in scratch". So once the OCaml-side work is in the hub and has had its independent read, the hub (`msc/scratch/languages-compared-2026-11-10.md`, with its snippets) becomes the next numbered note in `msc/notes/` with a row in `00-INDEX.md`; the slice files, the forced choices and the spikes can stay in scratch and be pointed at. Not done yet when I wrote this, because the results were not all ready. It exists because his original ask named Rocq and the comparison ended up setting Ada with its prover against OCaml without one.

## 4. What I never read, and what I think of each gap

- **Note 09**: read it (above).
- `msc/notes/19-2026-11-08-holistic-model.md` and `msc/notes/02-2026-11-04-plan.md` §A0: the two earlier small statements of the model. Probably worth it for the big-picture thread; I cannot say.
- `msc/notes/18-2026-11-08-dimension-census.md`: Joseph calls it "very important and also very priming" and prefers to hand it to an agent with a specific question.
- The councils dialog (`~/src/arch/msc/councils/research/dialog-for-kernel-2026-11-04.md`): I have his half from the prompts.
- Any code beyond `kernel-2/ocaml/lib/model.ml`, `kernel-2/ada/src/vk.ads` and `vk-model.ads`.

## 5. What I got wrong, so that you start ahead of it

- I relayed the first spike's debrief to Joseph before its independent read came back, and repeated three of its overclaims in my own words. Wait for the read, or mark the relay unverified in its first line.
- I said note 22's example "does not close as written" after reading, that same hour, the rule in «changeset» under which it does.
- I told seven minds they could not lean on a combination of languages, and then leaned on one in my own answer.
- Not an error of mine, on Joseph's word after reading this list: I had listed here that I commissioned four rounds of delegated work on languages while the model thread waited. He answered: "those are all yours. Except the last one. That was completely on me … adjudicating these languages is helping me learn how to think about formal proofs and the modeling. It is a bit of a distraction but it's part of my growth." So the language thread is his chosen one, not drift to be corrected; the model thread is still the one that is waiting, and it is his to say when to return to it.

## 6. What is waiting on Joseph, for the model

To read notes 22 and 23. Then: whether `core/` is cut back to note 22; the two unrepaired places in the kernel spec; whether two forks may close because the merge is stationary or only because they do not meet; the seven choices in note 22 Part 8. And five things his prompts hold that note 22 does not: a halt when ripples keep growing instead of settling; the importance of a decision, and that agreement needed rises with it; a kind of verisectorium declarable in about ten lines; outside referents and time ("how long can we afford having something stale" against "what is the likelihood of this being stale by this time"); and terms as nouns.
