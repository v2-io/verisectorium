#!/usr/bin/env python3
"""Makes two-worlds.ax from ../m0/m0.ax: the same definitions twice, for a state
(suffix 1) and for that state with ONE more piece of evidence that holds,
recorded after everything else (suffix 2). No particular state: every relation
is left open, so what E proves from this it proves of every state."""
import re
src = re.sub(r"\)\.[ \t]+tff\(", ").\ntff(", open("../m0/m0.ax").read())
per_world = "write against evid reads affirm before sel was latest applies ok2 checked looked own bad owed stationary".split()
out = ["% Made by two_worlds.py from ../m0/m0.ax.\n"]
# shared declarations and axioms: everything that mentions no per-world name
blocks = re.findall(r"tff\([^.]*?\)\.\n", src, flags=re.S)
def mentions(b): return any(re.search(r"\b%s\b" % n, b) for n in per_world)
for b in blocks:
    if not mentions(b): out.append(b)
for w in "12":
    for b in blocks:
        if mentions(b):
            c = b
            for n in per_world: c = re.sub(r"\b%s\b" % n, n + w, c)
            c = re.sub(r"tff\((\w+),", lambda m: f"tff({m.group(1)}_w{w},", c, count=1)
            out.append(c)
out.append("""
% ----- how the two states differ: g, one more piece of evidence that holds -----
tff(g, type, g: ev).  tff(gp, type, gp: piece).  tff(gv, type, gv: ver).  tff(gc, type, gc: crit).
tff(same_writes, axiom, ![E: ev, P: piece, V: ver]: (write2(E, P, V) <=> write1(E, P, V))).
tff(same_against, axiom, ![E: ev, Q: piece, W: ver]: (against2(E, Q, W) <=> against1(E, Q, W))).
tff(same_affirms, axiom, ![E: ev, P: piece, V: ver, Q: piece, W: ver]: (affirm2(E, P, V, Q, W) <=> affirm1(E, P, V, Q, W))).
tff(one_more, axiom,
    ![E: ev, P: piece, V: ver, C: crit, O: outcome]:
      ( evid2(E, P, V, C, O) <=> ( evid1(E, P, V, C, O) | (E = g & P = gp & V = gv & C = gc & O = holds) ) )).
tff(its_reads, axiom, ![E: ev, Q: piece, W: ver]: (reads1(E, Q, W) <=> (reads2(E, Q, W) & E != g))).
tff(g_is_new, axiom,
    ( ![P: piece, V: ver, C: crit, O: outcome]: ~ evid1(g, P, V, C, O)
    & ![P: piece, V: ver]: ~ write1(g, P, V)
    & ![P: piece, V: ver, Q: piece, W: ver]: ~ affirm1(g, P, V, Q, W)
    & ![Q: piece, W: ver]: ~ against1(g, Q, W) )).
tff(g_is_last, axiom, ![E1: ev, E2: ev]: (before2(E1, E2) <=> ( (before1(E1, E2) & E2 != g & E1 != g) | (E2 = g & E1 != g) ))).
""")
open("two-worlds.ax", "w").write("".join(out))
qs = {"cond2": "cond2", "cond4": "cond4", "cond5": "cond5", "cond6": "cond6", "cond5r": "cond5r"}
for name, c in qs.items():
    open(f"good-news-{name}.p", "w").write(
        "% For EVERY state: one more piece of evidence that holds adds nothing owed under this condition.\n"
        "include('two-worlds.ax').\n"
        f"tff(good_news_{name}, conjecture, ![P: piece]: ( owed2({c}, P) => owed1({c}, P) )).\n")
open("only-canon-owes.p", "w").write(
    "% For EVERY state: a piece that is not in canon owes nothing.\n"
    "include('../m0/m0.ax').\n"
    "tff(only_canon_owes, conjecture, ![C: cond, P: piece]: ( owed(C, P) => canon(P) )).\n")
open("finding-blocks.p", "w").write(
    "% For EVERY state: while a finding applies to a piece in canon, the state is not stationary.\n"
    "include('../m0/m0.ax').\n"
    "tff(finding_blocks, conjecture,\n"
    "    ![E: ev, P: piece, V: ver, C: crit]: ( (canon(P) & evid(E, P, V, C, fails) & applies(E)) => ~ stationary )).\n")
