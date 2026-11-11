#!/usr/bin/env python3
"""A sanity check of the polarity table, by running states: add one piece of evidence that
holds to the story, in every shape a small vocabulary allows, at two different times, and
confirm that no row of the table owes anything it did not owe before. This is a test of the
story's rows only, and only of single additions."""
import subprocess, itertools, sys
BASE = ["m0.lp", "story.lp", "reading-write-looks.lp"]
VERS = [("c","c1"),("c","c1p"),("c","c2"),("d","d1"),("d","d1p"),("d","d2"),("d","d3"),("e","e1"),
        ("k","k1"),("k","k2"),("u","u1"),("u","u2"),("t","t1"),("uu","uu1"),("o","o1")]
def owed(extra):
    out = subprocess.run(["clingo", *BASE, "-", "--outf=0", "-V0"], input=extra, capture_output=True, text=True).stdout
    return {a for a in out.split() if a.startswith("owed(")}
base = owed("")
n = bad = removed = 0
for t in (72, 113):
    for (p, v) in VERS:
        for crit in ("valid", "casex", "whole"):
            for rd in [None] + VERS:
                if rd == (p, v): continue
                fact = f"evidence(new,{t},{p},{v},{crit},holds)." + (f" reads(new,{rd[0]},{rd[1]})." if rd else "")
                got = owed(fact); n += 1
                if got - base:
                    bad += 1; print("ADDED:", fact, sorted(got - base))
                if base - got: removed += 1
print(f"{n} single additions of evidence that holds; {bad} added something owed; {removed} removed something owed; baseline owes {len(base)} items over all rows")
