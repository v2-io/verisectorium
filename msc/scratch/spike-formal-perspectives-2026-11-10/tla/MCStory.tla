------------------------------ MODULE MCStory ------------------------------
(* Note 22 section 4.3 in M0.                                               *)
(* Versions:  c: 1 = c1, 2 = c1', 3 = c2      d: 1 = d1, 2 = d1', 3 = d2, 4 = d3 *)
(*            e: 1      k: 1 = k1, 2 = k2      u: 1 = u1, 2 = u2             *)
EXTENDS Veri, TLC

CONSTANTS Script        \* a sequence of commands, or <<>> for free search
VARIABLE pc

SPieces == {"c", "d", "e", "k", "u", "T", "U", "O"}
SKind   == [p \in SPieces |->
             CASE p \in {"c", "u"} -> "claim"
               [] p \in {"d", "e", "k"} -> "plain"
               [] p \in {"T", "U"} -> "result"
               [] OTHER -> "outline"]
SFill   == [p \in SPieces |->
             CASE p = "T" -> {"c", "d", "e", "k"}
               [] p = "U" -> {"u"}
               [] p = "O" -> {"T", "U"}
               [] OTHER -> {}]
SInner  == [p \in SPieces |-> IF p = "T" THEN {<<"e", "c">>, <<"k", "e">>} ELSE {}]
SRoots  == {"O"}
SPred(p, n) == IF p = "u" THEN {"c"} ELSE {}
SVers   == [p \in SPieces |->
             CASE p = "c" -> {2, 3} [] p = "d" -> {2, 3, 4}
               [] p = "k" -> {2}    [] p = "u" -> {2}
               [] OTHER -> {}]
SAff    == {<<"e", "c">>, <<"k", "e">>, <<"u", "c">>}

Ev(id, n, subj, ver, crit, out, reads) ==
  [id |-> id, n |-> n, subj |-> subj, ver |-> ver, crit |-> crit, out |-> out, reads |-> reads]

E1  == Ev("E1", 1, "c", 1, "valid", "holds", {<<"d", 1>>})
E2  == Ev("E2", 2, "u", 1, "valid", "holds", {<<"c", 1>>})
E3  == Ev("E3", 3, "T", 1, "whole", "holds", {<<"c", 1>>, <<"d", 1>>, <<"e", 1>>, <<"k", 1>>})
E4  == Ev("E4", 4, "U", 1, "whole", "holds", {<<"u", 1>>})
E5  == Ev("E5", 5, "c", 1, "caseX", "fails", {})
E6  == Ev("E6", 6, "c", 2, "valid", "holds", {<<"d", 2>>})
E7  == Ev("E7", 7, "c", 3, "valid", "holds", {<<"d", 3>>})
E8  == Ev("E8", 8, "c", 3, "caseX", "holds", {})
E9  == Ev("E9", 9, "c", 3, "valid", "holds", {<<"d", 4>>})
E10 == Ev("E10", 10, "u", 2, "valid", "holds", {<<"c", 3>>})
E11 == Ev("E11", 11, "T", 1, "whole", "holds", {<<"c", 3>>, <<"d", 4>>, <<"e", 1>>, <<"k", 2>>})
E12 == Ev("E12", 12, "U", 1, "whole", "holds", {<<"u", 2>>})
\* not in note 22's table; used by the variants and by the free search
E13 == Ev("E13", 13, "d", 3, "step3", "fails", {})            \* A's discovery at 11:30, recorded
E14 == Ev("E14", 14, "d", 4, "step3", "holds", {})            \* d3 looked at for that error
E15 == Ev("E15", 15, "c", 2, "caseX", "holds", {})            \* c1' does avoid the auditor's case
E16 == Ev("E16", 16, "T", 1, "whole", "holds", {<<"c", 3>>, <<"d", 3>>, <<"e", 1>>, <<"k", 2>>}) \* T read whole with d2
E17 == Ev("E17", 17, "T", 1, "whole", "holds", {<<"c", 3>>, <<"d", 4>>, <<"e", 1>>, <<"k", 1>>}) \* T read whole with k1 kept

StoryPool == {E5, E6, E7, E8, E9, E10, E11, E12}
WidePool  == StoryPool \cup {E15, E16, E17}
SEvPool   == IF Script = <<>> THEN WidePool ELSE StoryPool \cup {E13, E14, E15, E16, E17}
EvById(id) == CHOOSE e \in SEvPool : e.id = id

\* checkpoint S0
SLine0 == <<
  W("c", 1, 1, {}, 0, "S0"), W("d", 1, 2, {}, 0, "S0"), W("e", 1, 3, {}, 0, "S0"),
  W("k", 1, 4, {}, 0, "S0"), W("u", 1, 5, {<<"c", 1>>}, 0, "S0"),
  W("T", 1, 6, {}, 0, "S0"), W("U", 1, 7, {}, 0, "S0"), W("O", 1, 8, {}, 0, "S0"),
  A("e", 1, "c", 1, 9, "S0"), A("k", 1, "e", 1, 10, "S0") >>
SBase0 == {[e |-> E1, t |-> 11], [e |-> E2, t |-> 12], [e |-> E3, t |-> 13], [e |-> E4, t |-> 14]}
SNow0  == 15

-----------------------------------------------------------------------------
(* scripted run *)
Do(c) ==
  CASE c[1] = "learn"  -> Learn(EvById(c[2]))
    [] c[1] = "open"   -> Open(c[2])
    [] c[1] = "write"  -> Write(c[2], c[3], c[4])
    [] c[1] = "affirm" -> Affirm(c[2], c[3], c[4])
    [] c[1] = "rewind" -> Rewind(c[2], c[3])
    [] c[1] = "close"  -> Close(c[2])

\* as ../01-common-reading.md has it; row numbers in the comments
Story == <<
  <<"learn", "E5">>,                                                        \* 1  08:30
  <<"open", "F">>, <<"write", "F", "c", 2>>, <<"write", "F", "d", 2>>,
  <<"learn", "E6">>,                                                        \* 2  09:00
  <<"rewind", "F", 0>>,                                                     \* 3  10:00
  <<"write", "F", "c", 3>>, <<"write", "F", "d", 3>>, <<"write", "F", "k", 2>>,
  <<"affirm", "F", "e", "c">>,                                              \* 4  10:30
  <<"learn", "E7">>, <<"learn", "E8">>,                                     \* 5  11:00
  <<"write", "F", "d", 4>>,                                                 \* 6  11:30
  <<"learn", "E9">>,                                                        \* 7  12:00
  <<"write", "F", "u", 2>>, <<"learn", "E10">>,                             \* 8  13:00
  <<"learn", "E11">>, <<"learn", "E12">>,                                   \* 9  14:00
  <<"close", "F">> >>

\* the same with the eli8 looked at beside the description when it was rewritten
StoryK == SubSeq(Story, 1, 10) \o << <<"affirm", "F", "k", "e">> >> \o SubSeq(Story, 11, Len(Story))

\* StoryK with A's discovery at 11:30 put on the record as a finding against d2
StoryKF == SubSeq(StoryK, 1, 13) \o << <<"learn", "E13">> >> \o SubSeq(StoryK, 14, Len(StoryK))

\* StoryKF with d3 then looked at for that error
StoryKFA == SubSeq(StoryKF, 1, 16) \o << <<"learn", "E14">> >> \o SubSeq(StoryKF, 17, Len(StoryKF))

NoScript == <<>>
SInit == Init /\ pc = 1
SNext == /\ pc <= Len(Script) /\ Do(Script[pc]) /\ pc' = pc + 1
SSpec == SInit /\ [][SNext]_<<vars, pc>>
NotDone == pc <= Len(Script)

View == [ step  |-> IF pc = 1 THEN <<"S0">> ELSE Script[pc - 1],
          main  |-> FrontierOf(main, base),
          onFork |-> IF fork["F"].open THEN FrontierOf(Line("F"), base) ELSE {<<"-", "no fork">>} ]

-----------------------------------------------------------------------------
(* free search: what the model lets a fork do with this perturbation.        *)
(* Evidence is learned as soon as it can be, lowest number first.  That is   *)
(* a reduction, sound for which stationary states are reachable only because *)
(* every piece of evidence still to come holds and nothing here reads time   *)
(* except a guard's "later than the finding", and E5 is already in the base. *)
Learnable == {e \in EvPool : ~Known(e) /\ Avail(e)}
FNext ==
  /\ pc' = pc
  /\ IF Learnable # {}
       THEN Learn(CHOOSE e \in Learnable : \A x \in Learnable : e.n <= x.n)
       ELSE \/ Close("F")
            \/ \E p \in Pieces : \E v \in Vers[p] : Write("F", p, v)
            \/ \E pq \in AffPairs : Affirm("F", pq[1], pq[2])
FInit == /\ main = Line0 /\ base = Base0 \cup {[e |-> E5, t |-> Now0]} /\ now = Now0 + 1
         /\ cpBase = Base0 /\ fork = [f \in Forks |-> [open |-> TRUE, snap |-> Line0, ev |-> <<>>]]
         /\ pc = 0
FSpec == FInit /\ [][FNext]_<<vars, pc>>

HasClosed       == main # Line0
NeverCloses     == ~HasClosed
\* note 22: "Neither d2 nor c1' was ever in it."
ClosesAsStory   == HasClosed => (Sel(main, "c") = 3 /\ Sel(main, "d") = 4 /\ Sel(main, "k") = 2 /\ Sel(main, "u") = 2)
NeverWithC1p    == HasClosed => Sel(main, "c") # 2
NeverWithD2     == HasClosed => Sel(main, "d") # 3
NeverWithK1     == HasClosed => Sel(main, "k") # 1
FView == [ sel |-> [p \in {"c", "d", "k", "u"} |-> Sel(IF fork["F"].open THEN Line("F") ELSE main, p)],
           frontier |-> FrontierOf(IF fork["F"].open THEN Line("F") ELSE main, base) ]
=============================================================================
