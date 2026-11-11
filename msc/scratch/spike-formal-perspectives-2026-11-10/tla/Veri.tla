------------------------------- MODULE Veri -------------------------------
(* M0 of ../01-common-reading.md as a TLA+ specification.                   *)
(* The state-to-frontier function is a set of operators on (line, base).    *)
(* The steps are: learn (evidence into the base), and, on a fork: open,     *)
(* write, affirm, rewind, abandon, close.                                   *)
(* Cuts from M0, all deliberate: assemblies are written once and never      *)
(* rewritten (so canon is fixed); no same events, no set-aside, no raise,   *)
(* promise or waiver; a fork does not re-select a version it has already    *)
(* selected (it rewinds instead).                                           *)
EXTENDS Naturals, Sequences, FiniteSets

CONSTANTS
  Pieces,          \* ids
  Kind,            \* [Pieces -> {"claim","plain","result","outline"}]
  Fill,            \* [Pieces -> SUBSET Pieces]   fillers of an assembly
  InnerDep,        \* [Pieces -> SUBSET (Pieces \X Pieces)]  <<x,y>>: x depends on y
  Roots,           \* SUBSET Pieces
  Pred(_,_),       \* Pred(p,n): what claim p at version n is predicated on
  Vers,            \* [Pieces -> SUBSET Nat]  versions a fork may write
  AffPairs,        \* SUBSET (Pieces \X Pieces)  pairs someone may affirm
  EvPool,          \* evidence that minds could record: [id,n,subj,ver,crit,out,reads]
  Line0, Base0, Now0,   \* the first checkpoint
  Forks,
  RecordAgainst,   \* TRUE: a write records what its references pointed at (Ada G10)
                   \* FALSE: that is worked out from the line being read
  CloseMode,       \* "merge": union in time order (both builders' reading)
                   \* "append": the fork's events go after the main line's
  CloseRule,       \* "stationary": may close if the resulting line is stationary
                   \* "both": and the fork's own line is stationary too
                   \* "fresh": and only if no other fork has closed since it opened
  MaxForkLen, MaxNow

VARIABLES main, base, fork, now, cpBase
vars == <<main, base, fork, now, cpBase>>

-----------------------------------------------------------------------------
(* line events, one record shape *)
W(p, v, t, saw, prev, by) ==
  [k |-> "w", p |-> p, v |-> v, q |-> "-", w |-> 0, t |-> t, saw |-> saw, prev |-> prev, by |-> by]
A(p, v, q, w, t, by) ==
  [k |-> "a", p |-> p, v |-> v, q |-> q, w |-> w, t |-> t, saw |-> {}, prev |-> 0, by |-> by]

MaxOf(S) == CHOOSE m \in S : \A n \in S : n <= m
Range(s) == {s[i] : i \in DOMAIN s}
IsPrefix(s, t) == Len(s) <= Len(t) /\ SubSeq(t, 1, Len(s)) = s

RECURSIVE Merge(_,_)
Merge(a, b) ==
  IF a = <<>> THEN b
  ELSE IF b = <<>> THEN a
  ELSE IF Head(a).t < Head(b).t THEN <<Head(a)>> \o Merge(Tail(a), b)
  ELSE <<Head(b)>> \o Merge(a, Tail(b))

-----------------------------------------------------------------------------
(* THE STATE OF A LINE L, WITH BASE B.  Nothing below is a variable.        *)

WIdx(L, p)    == {i \in DOMAIN L : L[i].k = "w" /\ L[i].p = p}
Sel(L, p)     == IF WIdx(L, p) = {} THEN 0 ELSE L[MaxOf(WIdx(L, p))].v
EverSel(L, p) == {L[i].v : i \in WIdx(L, p)}

RECURSIVE Reach(_)
Reach(S) == LET N == S \cup (UNION {Fill[p] : p \in S}) IN IF N = S THEN S ELSE Reach(N)
Canon == Reach(Roots)

Applies(L, e) ==
  /\ Sel(L, e.subj) = e.ver
  /\ \A r \in e.reads : Sel(L, r[1]) = r[2]

PredNow(L, p) == IF Kind[p] = "claim" /\ Sel(L, p) # 0 THEN Pred(p, Sel(L, p)) ELSE {}

Against(L, p, q) ==
  LET i == MaxOf(WIdx(L, p)) IN
  IF RecordAgainst
    THEN IF \E s \in L[i].saw : s[1] = q THEN (CHOOSE s \in L[i].saw : s[1] = q)[2] ELSE 0
    ELSE Sel(SubSeq(L, 1, i), q)

Affirmed(L, p, q) ==
  \E i \in DOMAIN L : /\ L[i].k = "a" /\ L[i].p = p /\ L[i].v = Sel(L, p)
                      /\ L[i].q = q /\ L[i].w = Sel(L, q)

\* the conditions of note 22 section 4.1 that M0 keeps, each of one piece
C1(L, p) == \A q \in PredNow(L, p) : Sel(L, q) # 0
C2(L, p) == \A q \in PredNow(L, p) : Against(L, p, q) = Sel(L, q) \/ Affirmed(L, p, q)

KnownWrong(L, B, p) == \E b \in B : b.e.subj = p /\ b.e.out = "fails" /\ Applies(L, b.e)
GuardOpen(L, B, p) ==
  \E b \in B :
    /\ b.e.subj = p /\ b.e.out = "fails"
    /\ b.e.ver \in EverSel(L, p) /\ b.e.ver # Sel(L, p)
    /\ ~ \E h \in B : /\ h.e.subj = p /\ h.e.crit = b.e.crit /\ h.e.out = "holds"
                      /\ Applies(L, h.e) /\ h.t > b.t
C4(L, B, p) == ~ KnownWrong(L, B, p) /\ ~ GuardOpen(L, B, p)

Has(L, B, p, crit) ==
  \E b \in B : b.e.subj = p /\ b.e.crit = crit /\ b.e.out = "holds" /\ Applies(L, b.e)
C5(L, B, p) ==
  CASE Kind[p] = "claim"  -> Has(L, B, p, "valid")
    [] Kind[p] = "result" ->
         \E b \in B : /\ b.e.subj = p /\ b.e.crit = "whole" /\ b.e.out = "holds"
                      /\ Applies(L, b.e) /\ {r[1] : r \in b.e.reads} = Fill[p]
    [] OTHER -> TRUE

\* condition 6 is about the dependent filler x of an inner dependency x -> y
Deps(x) == {d \in UNION {InnerDep[a] : a \in Pieces} : d[1] = x}
C6(L, B, x) ==
  \A d \in Deps(x) :
    \/ Affirmed(L, x, d[2])
    \/ \E b \in B : b.e.subj = x /\ Applies(L, b.e) /\ <<d[2], Sel(L, d[2])>> \in b.e.reads

Own(L, B, p) ==
  (IF C1(L, p) THEN {} ELSE {"1 dangling"}) \cup
  (IF C1(L, p) /\ ~C2(L, p) THEN {"2 not reconciled"} ELSE {}) \cup
  (IF KnownWrong(L, B, p) THEN {"4 known wrong"} ELSE {}) \cup
  (IF GuardOpen(L, B, p) THEN {"4 guard open"} ELSE {}) \cup
  (IF C5(L, B, p) THEN {} ELSE {"5 root's ask"}) \cup
  (IF C6(L, B, p) THEN {} ELSE {"6 not looked at together"})

\* resting: fault is inherited along predicated-on.  Reachability, no fixed point.
RECURSIVE Clo(_,_)
Clo(L, S) == LET N == S \cup (UNION {PredNow(L, q) : q \in S}) IN IF N = S THEN S ELSE Clo(L, N)
Up(L, p) == Clo(L, PredNow(L, p))

FrontierOf(L, B) ==
  (UNION {{<<n, p>> : n \in Own(L, B, p)} : p \in Canon})
  \cup {<<"5 rests on a fault", p>> :
          p \in {x \in Canon : \E q \in Up(L, x) : q \notin Canon \/ Own(L, B, q) # {}}}
Stationary(L, B) == FrontierOf(L, B) = {}

-----------------------------------------------------------------------------
(* STEPS *)

Closed == [open |-> FALSE, snap |-> <<>>, ev |-> <<>>]
Line(f) == fork[f].snap \o fork[f].ev

Init ==
  /\ main = Line0 /\ base = Base0 /\ now = Now0 /\ cpBase = Base0
  /\ fork = [f \in Forks |-> Closed]

Known(e)  == \E b \in base : b.e.id = e.id
\* a check can be made of whatever is selected on some live line
Avail(e)  == Applies(main, e) \/ \E f \in Forks : fork[f].open /\ Applies(Line(f), e)
Learn(e) ==
  /\ ~Known(e) /\ Avail(e)
  /\ base' = base \cup {[e |-> e, t |-> now]}
  /\ now' = now + 1
  /\ UNCHANGED <<main, fork, cpBase>>

Open(f) ==
  /\ ~fork[f].open
  /\ fork' = [fork EXCEPT ![f] = [open |-> TRUE, snap |-> main, ev |-> <<>>]]
  /\ UNCHANGED <<main, base, now, cpBase>>

Write(f, p, v) ==
  LET L == Line(f) IN
  /\ fork[f].open /\ Len(fork[f].ev) < MaxForkLen
  /\ v \in Vers[p] /\ v \notin EverSel(L, p)
  /\ fork' = [fork EXCEPT ![f].ev =
       Append(@, W(p, v, now, {<<q, Sel(L, q)>> : q \in Pred(p, v)}, Sel(L, p), f))]
  /\ now' = now + 1
  /\ UNCHANGED <<main, base, cpBase>>

Affirm(f, p, q) ==
  LET L == Line(f) IN
  /\ fork[f].open /\ Len(fork[f].ev) < MaxForkLen
  /\ <<p, q>> \in AffPairs /\ Sel(L, p) # 0 /\ Sel(L, q) # 0
  /\ ~Affirmed(L, p, q)
  /\ fork' = [fork EXCEPT ![f].ev = Append(@, A(p, Sel(L, p), q, Sel(L, q), now, f))]
  /\ now' = now + 1
  /\ UNCHANGED <<main, base, cpBase>>

Rewind(f, n) ==
  /\ fork[f].open /\ n < Len(fork[f].ev)
  /\ fork' = [fork EXCEPT ![f].ev = SubSeq(@, 1, n)]
  /\ UNCHANGED <<main, base, now, cpBase>>

Abandon(f) ==
  /\ fork[f].open
  /\ fork' = [fork EXCEPT ![f] = Closed]
  /\ UNCHANGED <<main, base, now, cpBase>>

Close(f) ==
  LET M == IF CloseMode = "merge" THEN Merge(main, fork[f].ev) ELSE main \o fork[f].ev IN
  /\ fork[f].open /\ fork[f].ev # <<>>
  /\ (CloseRule = "fresh" => fork[f].snap = main)
  /\ (CloseRule = "both"  => Stationary(Line(f), base))
  /\ Stationary(M, base)
  /\ main' = M /\ cpBase' = base
  /\ fork' = [fork EXCEPT ![f] = Closed]
  /\ UNCHANGED <<base, now>>

Next ==
  \/ \E e \in EvPool : Learn(e)
  \/ \E f \in Forks :
       \/ Open(f) \/ Abandon(f) \/ Close(f)
       \/ \E p \in Pieces : \E v \in Vers[p] : Write(f, p, v)
       \/ \E pq \in AffPairs : Affirm(f, pq[1], pq[2])
       \/ \E n \in 0..MaxForkLen : Rewind(f, n)

Spec == Init /\ [][Next]_vars
Bound == now <= MaxNow

-----------------------------------------------------------------------------
(* WHAT IS CLAIMED OF EVERY BEHAVIOUR *)

\* R11 as the spec words it: the verisectorium (the main line) is stationary.
R11_Plain  == Stationary(main, base)
\* R11 as both builders reworded it: stationary with what was known when it closed.
R11_AsOf   == Stationary(main, cpBase)

\* The checkpoint-level specification.  Its whole state is <<main, base>>.
\* Two kinds of step, and nothing a fork does is one of them.
AbsLearn      == base' # base /\ base \subseteq base' /\ main' = main
AbsClosePre   == main' # main /\ base' = base /\ Stationary(main', base) /\ IsPrefix(main, main')
AbsCloseSet   == main' # main /\ base' = base /\ Stationary(main', base)
                   /\ Range(main) \subseteq Range(main')
RefinesPrefix == [][AbsLearn \/ AbsClosePre]_<<main, base>>
RefinesSet    == [][AbsLearn \/ AbsCloseSet]_<<main, base>>

\* a write's true view, kept whatever RecordAgainst says
TrueSaw(L, p, q) ==
  LET i == MaxOf(WIdx(L, p)) IN
  IF \E s \in L[i].saw : s[1] = q THEN (CHOOSE s \in L[i].saw : s[1] = q)[2] ELSE 0
\* no reference on the main line counts as reconciled against a version its
\* writer never saw and nobody affirmed
NoPhantomReconcile ==
  \A p \in Canon : \A q \in PredNow(main, p) :
    (Against(main, p, q) = Sel(main, q) /\ ~Affirmed(main, p, q)) => TrueSaw(main, p, q) = Sel(main, q)

\* the same, not counting a case where some write of that very version of p,
\* by anyone, did see the target as it now is
SomeWriteSaw(L, p, q) ==
  \E i \in WIdx(L, p) : L[i].v = Sel(L, p) /\ <<q, Sel(L, q)>> \in L[i].saw
NoPhantomReconcileStrict ==
  \A p \in Canon : \A q \in PredNow(main, p) :
    (Against(main, p, q) = Sel(main, q) /\ ~Affirmed(main, p, q)) => SomeWriteSaw(main, p, q)

\* each write on the main line replaced the version that stands before it there
\* (or wrote that same version again, which loses nothing)
NoLostUpdate ==
  \A p \in Pieces :
    \A i \in WIdx(main, p) :
      LET before == {j \in WIdx(main, p) : j < i} IN
      before # {} => \/ main[i].prev = main[MaxOf(before)].v
                     \/ main[i].v = main[MaxOf(before)].v
=============================================================================
