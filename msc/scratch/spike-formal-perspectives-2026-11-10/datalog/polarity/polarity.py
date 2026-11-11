#!/usr/bin/env python3
"""Read a rule file (the plain subset of clingo syntax used in this directory) and report,
from the rule dependency graph alone, with no state run:
  1. whether any cycle passes through a negation (the stratification test);
  2. for each stored relation (one that heads no rule), by which polarities it can reach
     a target relation: '+' through an even number of negations on some path, '-' through
     an odd number. '+' only: more of it never removes a target fact. '-' only: more of it
     never adds one. Both: no promise either way.
This is a sound, coarse test. It reads predicate names, not arguments."""
import re, sys
from collections import defaultdict

def strip(src):
    return "\n".join(l.split("%")[0] for l in src.splitlines())

def split_top(s, sep):
    out, depth, cur = [], 0, ""
    for ch in s:
        if ch == "(": depth += 1
        if ch == ")": depth -= 1
        if ch == sep and depth == 0:
            out.append(cur); cur = ""
        else: cur += ch
    out.append(cur)
    return [x.strip() for x in out if x.strip()]

def pred(atom):
    m = re.match(r"^([a-z_][A-Za-z0-9_]*)\s*(\(|$)", atom)
    return m.group(1) if m else None

def rules(src):
    src = strip(src)
    for stmt in re.split(r"\.\s*(?=\n|$|[a-z#])", src):
        stmt = stmt.strip().rstrip(".")
        if not stmt or stmt.startswith("#"): continue
        if ":-" in stmt:
            head, body = stmt.split(":-", 1)
        else:
            head, body = stmt, ""
        h = pred(head.strip())
        if h is None: continue
        lits = []
        for lit in split_top(body, ","):
            neg = lit.startswith("not ")
            a = lit[4:].strip() if neg else lit
            if re.search(r"<=|>=|<|>|!=|=", re.sub(r"\(.*\)", "", a)): continue  # comparison
            p = pred(a)
            if p: lits.append((p, neg))
        yield h, lits

def main():
    files = [a for a in sys.argv[1:] if not a.startswith("--")]
    targets = [a.split("=")[1] for a in sys.argv[1:] if a.startswith("--target=")] or ["owed"]
    heads, edges = set(), defaultdict(set)   # edges[body_pred] = {(head_pred, neg)}
    preds = set()
    for f in files:
        for h, lits in rules(open(f).read()):
            preds.add(h)
            if lits: heads.add(h)
            for p, neg in lits:
                preds.add(p); edges[p].add((h, neg))
    stored = sorted(p for p in preds if p not in heads)
    # 1. cycles through negation: is there an edge p -(neg)-> h with h reaching p?
    def reach(a):
        seen, todo = set(), [a]
        while todo:
            x = todo.pop()
            for (y, _) in edges[x]:
                if y not in seen: seen.add(y); todo.append(y)
        return seen
    bad = sorted({(p, h) for p in preds for (h, neg) in edges[p] if neg and p in reach(h) | ({h} if h == p else set())})
    print("rules read from:", ", ".join(files))
    print("derived relations:", len(heads), " stored relations:", len(stored))
    print("cycles through negation:", "none (the program is stratified)" if not bad else bad)
    # 2. polarities
    for t in targets:
        print(f"\npolarity of each stored relation toward `{t}`:")
        for s in stored:
            seen, todo = {(s, 0)}, [(s, 0)]
            while todo:
                x, par = todo.pop()
                for (y, neg) in edges[x]:
                    st = (y, par ^ (1 if neg else 0))
                    if st not in seen: seen.add(st); todo.append(st)
            pol = "".join(sym for sym, par in (("+", 0), ("-", 1)) if (t, par) in seen)
            word = {"+": "can only add", "-": "can only remove", "+-": "either", "": "does not reach it"}[pol]
            print(f"  {s:<16} {pol or '.':<3} {word}")

main()
