#!/usr/bin/env python3
"""E as an evaluator of one state, helped. Asked "is row N stationary?" outright,
E does not answer in 40 seconds. So this asks the small questions in the order
a rule engine would compute them (selected versions, then which evidence
applies, then canon, then each condition), each one both ways (is it so? is it
not so?), and hands E every answer so far as an axiom for the next question.
The ordering is mine; that it is needed is the finding.

usage: ladder.py ROW [seconds-per-question]"""
import subprocess, sys, time, re
row = int(sys.argv[1]); secs = sys.argv[2] if len(sys.argv) > 2 else "5"
pieces = "o t uu c d e k u".split()
vers = {"o":["o1"],"t":["t1"],"uu":["uu1"],"c":["c1","c1p","c2"],"d":["d1","d1p","d2","d3"],
        "e":["e1"],"k":["k1","k2"],"u":["u1","u2"]}
evid = re.findall(r"E = (ev\d+) &", open(f"row-{row}.ax").read().split("evid_exactly")[1].split("\n")[0])
Q = []
Q += [f"sel({p}, {v})" for p in pieces for v in vers[p]]
Q += [f"applies({e})" for e in dict.fromkeys(evid)]
Q += [f"canon({p})" for p in pieces]
Q += ["checked(c, valid)", "checked(u, valid)", "checked(t, whole)", "checked(uu, whole)",
      "ok2(u, c)", "looked(e, c)", "looked(k, e)"]
Q += [f"owed({c}, {p})" for c in ["cond2","cond4","cond5","cond6"] for p in pieces]
Q += [f"own({p})" for p in pieces] + [f"bad({p})" for p in ["c", "u"]]
Q += [f"owed(cond5r, {p})" for p in pieces]
Q += ["stationary"]

def ask(formula, lemmas, tag):
    f = f"ladder-row{row}.p"
    with open(f, "w") as fh:
        fh.write("include('m0.ax').\ninclude('story.ax').\n" + f"include('row-{row}.ax').\n")
        for i, l in enumerate(lemmas): fh.write(f"tff(known_{i}, axiom, {l}).\n")
        fh.write(f"tff(q, conjecture, {formula}).\n")
    t = time.time()
    out = subprocess.run(["opam","exec","--switch=rocq-try","--","eprover","--auto",f"--cpu-limit={secs}","-s",f],
                         capture_output=True, text=True).stdout
    m = re.search(r"SZS status (\w+)", out)
    return (m.group(1) if m else "NoStatus"), time.time() - t

known, owed, undecided, total = [], [], [], 0.0
for q in Q:
    # the two questions alternate in short slices, so neither waits out the other
    done = False; spent = 0.0
    for slice_ in ["1", "2"]:
        secs = slice_
        s, dt = ask(q, known, "pos"); total += dt; spent += dt
        if s == "Theorem":
            known.append(q); print(f"  yes  {q}  ({spent:.1f}s)", flush=True)
            if q.startswith("owed"): owed.append(q)
            done = True; break
        s2, dt2 = ask(f"~ {q}", known, "neg"); total += dt2; spent += dt2
        if s2 == "Theorem":
            known.append(f"~ {q}"); print(f"  no   {q}  ({spent:.1f}s)", flush=True)
            done = True; break
    if not done:
        undecided.append(q); print(f"  ??   {q}  ({s}/{s2}, {spent:.1f}s)", flush=True)
# second pass, longer, for what was left undecided
secs = "15"
for q in list(undecided):
    s, dt = ask(q, known, "pos"); total += dt
    if s == "Theorem":
        known.append(q); undecided.remove(q); print(f"  yes  {q}  (second pass, {dt:.1f}s)", flush=True)
        if q.startswith("owed"): owed.append(q)
        continue
    s2, dt2 = ask(f"~ {q}", known, "neg"); total += dt2
    if s2 == "Theorem":
        known.append(f"~ {q}"); undecided.remove(q); print(f"  no   {q}  (second pass, {dt + dt2:.1f}s)", flush=True)
print(f"ROW {row}: owed = {owed}; undecided = {undecided}; {len(Q)} questions, {total:.0f}s", flush=True)
