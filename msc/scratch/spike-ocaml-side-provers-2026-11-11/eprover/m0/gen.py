#!/usr/bin/env python3
"""Writes story.ax (what never changes) and row-N.ax (the state at each row of
note 22 section 4.3, as M0 tells it) for E. Every stored relation is given as
EXACTLY these tuples, and every pair of names as different."""
import itertools

pieces = "o t uu c d e k u".split()
vers = "o1 t1 uu1 c1 c1p c2 d1 d1p d2 d3 e1 k1 k2 u1 u2".split()

# (row introduced, name, kind, payload). Order in this list is time.
EV = [
 (0,"w_c1","write",("c","c1",[])), (0,"w_d1","write",("d","d1",[])),
 (0,"w_e1","write",("e","e1",[])), (0,"w_k1","write",("k","k1",[])),
 (0,"w_u1","write",("u","u1",[("c","c1")])),
 (0,"w_t","write",("t","t1",[])), (0,"w_uu","write",("uu","uu1",[])), (0,"w_o","write",("o","o1",[])),
 (0,"ev1","evid",("c","c1","valid","holds",[("d","d1")])),
 (0,"ev2","evid",("u","u1","valid","holds",[("c","c1")])),
 (0,"ev3","evid",("t","t1","whole","holds",[("c","c1"),("d","d1"),("e","e1"),("k","k1")])),
 (0,"ev4","evid",("uu","uu1","whole","holds",[("u","u1")])),
 (0,"a1","affirm",("e","e1","c","c1")), (0,"a2","affirm",("k","k1","e","e1")),
 (1,"ev5","evid",("c","c1","casex","fails",[])),
 (2,"w_c1p","write",("c","c1p",[])), (2,"w_d1p","write",("d","d1p",[])),
 (2,"ev6","evid",("c","c1p","valid","holds",[("d","d1p")])),
 (4,"w_c2","write",("c","c2",[])), (4,"w_d2","write",("d","d2",[])), (4,"w_k2","write",("k","k2",[])),
 (4,"a3","affirm",("e","e1","c","c2")),
 (5,"ev7","evid",("c","c2","valid","holds",[("d","d2")])),
 (5,"ev8","evid",("c","c2","casex","holds",[])),
 (6,"w_d3","write",("d","d3",[])),
 (7,"ev9","evid",("c","c2","valid","holds",[("d","d3")])),
 (8,"w_u2","write",("u","u2",[("c","c2")])),
 (8,"ev10","evid",("u","u2","valid","holds",[("c","c2")])),
 (9,"ev11","evid",("t","t1","whole","holds",[("c","c2"),("d","d3"),("e","e1"),("k","k2")])),
 (9,"ev12","evid",("uu","uu1","whole","holds",[("u","u2")])),
]
REWOUND_AT = {"w_c1p": 3, "w_d1p": 3}   # dropped from the line from row 3 on

def exactly(rel, vars_, tuples):
    names = [v.split(":")[0] for v in vars_]
    body = " | ".join("(" + " & ".join(f"{n} = {x}" for n, x in zip(names, t)) + ")" for t in tuples) or "$false"
    return f"tff({rel}_exactly, axiom, ![{', '.join(vars_)}]: ( {rel}({', '.join(names)}) <=> ( {body} ) )).\n"

def differ(tag, names):
    pairs = " & ".join(f"{a} != {b}" for a, b in itertools.combinations(names, 2))
    return f"tff({tag}_differ, axiom, {pairs}).\n"

with open("story.ax", "w") as f:
    f.write("% Made by gen.py. What does not change through the story.\n")
    for p in pieces: f.write(f"tff({p}, type, {p}: piece).\n")
    for v in vers: f.write(f"tff({v}, type, {v}: ver).\n")
    for _, n, _, _ in EV: f.write(f"tff({n}, type, {n}: ev).\n")
    f.write(differ("pieces", pieces)); f.write(differ("vers", vers)); f.write(differ("evs", [n for _, n, _, _ in EV]))
    f.write(f"tff(pieces_all, axiom, ![P: piece]: ({' | '.join('P = ' + p for p in pieces)})).\n")
    f.write(exactly("slot", ["A: piece", "P: piece"], [("o","t"),("o","uu"),("t","c"),("t","d"),("t","e"),("t","k"),("uu","u")]))
    f.write(exactly("root", ["A: piece"], [("o",)]))
    f.write(exactly("is_claim", ["P: piece"], [("c",),("u",)]))
    f.write(exactly("is_result", ["P: piece"], [("t",),("uu",)]))
    f.write(exactly("pred", ["P: piece", "Q: piece"], [("u","c")]))
    f.write(exactly("dep", ["A: piece", "X: piece", "Y: piece"], [("t","e","c"),("t","k","e")]))

for row in range(10):
    present = [(n, kind, pl) for (r, n, kind, pl) in EV
               if r <= row and not (n in REWOUND_AT and row >= REWOUND_AT[n])]
    W = [(n, pl[0], pl[1]) for n, k, pl in present if k == "write"]
    AG = [(n, q, w) for n, k, pl in present if k == "write" for q, w in pl[2]]
    E = [(n, *pl[:4]) for n, k, pl in present if k == "evid"]
    R = [(n, q, w) for n, k, pl in present if k == "evid" for q, w in pl[4]]
    A = [(n, *pl) for n, k, pl in present if k == "affirm"]
    names = [n for n, _, _ in present]
    B = [(a, b) for a, b in itertools.combinations(names, 2)]
    with open(f"row-{row}.ax", "w") as f:
        f.write(f"% Made by gen.py. The state at row {row}.\n")
        f.write(exactly("write", ["E: ev", "P: piece", "V: ver"], W))
        f.write(exactly("against", ["E: ev", "Q: piece", "W: ver"], AG))
        f.write(exactly("evid", ["E: ev", "P: piece", "V: ver", "C: crit", "O: outcome"], E))
        f.write(exactly("reads", ["E: ev", "Q: piece", "W: ver"], R))
        f.write(exactly("affirm", ["E: ev", "P: piece", "V: ver", "Q: piece", "W: ver"], A))
        f.write(exactly("before", ["E1: ev", "E2: ev"], B))
