# E 3.1 on its own

*By a fork of the spike lead. Start with `PERSPECTIVE.md` (what E showed about the model), then `AS-A-HOME.md` (what it was like). The slice is `../../idiomatic-slice-2026-11-11/eprover.p`.*

| | what | re-run |
|---|---|---|
| `slice/` | the slice's axioms (`axioms.ax`, cut from `eprover.p`) and one small question per file; the ring; the general "only grows" statement in first-order and higher-order form | `cd slice && opam exec --switch=rocq-try -- eprover --auto --cpu-limit=10 -s FILE.p` |
| `m0/` | the small model's conditions 2, 4, 5, 6 as definitions (`m0.ax`); the story's ten rows as generated states (`gen.py` writes `story.ax` and `row-N.ax`); `ladder.py ROW` evaluates one row question by question | `cd m0 && python3 gen.py && ./ladder.py 0` |
| `general/` | statements about every state: two copies of the definitions differing by one piece of evidence (`two_worlds.py`), and the questions asked of them | `cd general && python3 two_worlds.py && opam exec --switch=rocq-try -- eprover --auto --cpu-limit=30 -s good-news-cond4.p` |
| `runs/` | the whole output of every run cited, named for its question; `ho-build.txt` is the log of building E with higher-order support | |

The `*-ho.p` files need E built with `./configure --enable-ho`; opam's build refuses them. I built one in the session scratchpad from opam's cached source and did not install it.

Every E call here had a time limit, and I ran one at a time.
