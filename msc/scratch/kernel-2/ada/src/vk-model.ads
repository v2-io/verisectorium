--  What is derived from an ontology O, a table of versions T, a
--  selection S and a set of facts F (spec sections 4 and 5).
--
--  Every function here has Global => null by construction (the unit
--  has no state), which is Q1 in the language's own terms: nothing is
--  read but (O, T, S, F). There is no log and no fold to get wrong.
package Vk.Model with SPARK_Mode => On is

   function Sel (T : Version_Table; S : Selection; P : Id) return Version is
     (T (P, S (P).V));

   --  A selection is well formed when asserted pieces are selected and
   --  selected versions exist.
   function WF_Sel (T : Version_Table; S : Selection) return Boolean is
     (for all P in Id =>
        (if S (P).Asserted then S (P).Selected)
        and then (if S (P).Selected then T (P, S (P).V).Exists));

   --  Is Q, as selected, the same as it was at version W, as far as
   --  level L relies on it? (Sm: the versions "same" as W for the
   --  purpose at hand.)
   function Agrees
     (T : Version_Table; S : Selection;
      Q : Id; W : Ver; Sm : Ver_Set; L : Relies) return Boolean
   is
     (S (Q).Selected
      and then
        (case L is
           when Existence  => True,
           when Assertions =>
             S (Q).V = W or else Sm (S (Q).V)
             or else T (Q, S (Q).V).Says = T (Q, W).Says,
           when Everything => S (Q).V = W or else Sm (S (Q).V)));

   -------------------------------------------------------------------
   --  Edges: a piece's references and its pointing slots, as one list
   -------------------------------------------------------------------

   type Edge_Ix is range 1 .. 5;   --  1 .. 2 references, 3 .. 5 slots

   function Edge
     (O : Ontology; T : Version_Table; S : Selection; P : Id; I : Edge_Ix)
      return Ref
   is
     (if I <= 2 then Sel (T, S, P).Refs (Ref_Ix (I))
      elsif Sel (T, S, P).Slots (Slot_Ix (I - 2)).State = Pointing then
        Ref'(Present  => True,
             K        => O.Point_Kind,
             Target   => Sel (T, S, P).Slots (Slot_Ix (I - 2)).Filler,
             Need_Dim => 1,
             Need     => 0)
      else Ref'(Present => False, others => <>));

   -------------------------------------------------------------------
   --  Evidence: which facts apply (spec section 4, first bullet)
   -------------------------------------------------------------------

   --  A condition that does not look at warrants or at consistency.
   function Plain_True
     (T : Version_Table; S : Selection; C : Condition) return Boolean
   is
     (case C.What is
        when None        => True,
        when Selected_At => S (C.P).Selected and then C.Vs (S (C.P).V),
        when Slot_Filled =>
          S (C.P).Selected
          and then Sel (T, S, C.P).Slots (C.S).State /= Empty
          and then Sel (T, S, C.P).Slots (C.S).Filler = C.Filler,
        when Warrant_At_Least | Asserted_Consistent => False);

   --  Evidence I has been set aside by a decision that holds. Such a
   --  decision's conditions must be plain: evidence decides warrants,
   --  so it cannot be conditioned on them.
   function Aside
     (O : Ontology; T : Version_Table; S : Selection; F : Facts; I : Ev_Ix)
      return Boolean
   is
     (O.Set_Aside_On
      and then
        (for some J in Dec_Ix =>
           F.Dec (J).Present and then not F.Dec (J).Withdrawn
           and then F.Dec (J).What = Set_Aside
           and then F.Dec (J).Ev = I
           and then
             (for all K in Cond_Ix =>
                Plain_True (T, S, F.Dec (J).Conds (K)))));

   function Read_OK
     (O : Ontology; T : Version_Table; S : Selection; R : Read)
      return Boolean
   is
     (not O.Reads_On or else not R.Present
      or else Agrees (T, S, R.Q, R.W, R.Same, R.Level));

   function Applies
     (O : Ontology; T : Version_Table; S : Selection; F : Facts; I : Ev_Ix)
      return Boolean
   is
     (F.Ev (I).Present
      and then S (F.Ev (I).P).Selected
      and then (S (F.Ev (I).P).V = F.Ev (I).V
                or else F.Ev (I).Same (S (F.Ev (I).P).V))
      and then (for all R in Read_Ix => Read_OK (O, T, S, F.Ev (I).Reads (R)))
      and then not Aside (O, T, S, F, I));

   function Has_Holds
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      P : Id; D : Dim; C : Crit) return Boolean
   is
     (for some I in Ev_Ix =>
        Applies (O, T, S, F, I)
        and then F.Ev (I).P = P and then F.Ev (I).D = D
        and then F.Ev (I).C = C and then F.Ev (I).Result = Holds);

   function Own_Warrant
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      P : Id; D : Dim) return Warrant
   is
     (if S (P).Selected then
        O.Dims (D).Read_As
          (Has_Holds (O, T, S, F, P, D, 1), Has_Holds (O, T, S, F, P, D, 2))
      else 0);

   --  A defect once found, about P at any version or about anything P
   --  descends from, is presumed present until looked for and not
   --  found (spec section 4, "Guards").
   function Guard
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      P : Id; D : Dim; C : Crit) return Boolean
   is
     (O.Guards_On
      and then
        (for some I in Ev_Ix =>
           F.Ev (I).Present and then F.Ev (I).Result /= Holds
           and then F.Ev (I).D = D and then F.Ev (I).C = C
           and then (F.Ev (I).P = P or else F.Desc (F.Ev (I).P, P))
           and then not Aside (O, T, S, F, I)));

   -------------------------------------------------------------------
   --  The context: everything that does not depend on consistency
   -------------------------------------------------------------------

   type Ev_Flags is array (Ev_Ix) of Boolean;
   type Warrant_Table is array (Id, Dim) of Warrant;

   type Context is record
      App : Ev_Flags;        --  Applies
      Own : Warrant_Table;   --  Own_Warrant
      Eff : Warrant_Table;   --  effective: the meet along capping kinds
      Cyc : Id_Set;          --  on a cycle along a capping kind
   end record;

   --  Does edge I of P cap dimension D?
   function Caps_Along
     (O : Ontology; T : Version_Table; S : Selection;
      P : Id; I : Edge_Ix; D : Dim) return Boolean
   is
     (S (P).Selected
      and then Edge (O, T, S, P, I).Present
      and then O.RK (Edge (O, T, S, P, I).K).Caps (D));

   --  E is a solution of the cap equations for dimension D: each
   --  selected piece's value is the least of its own warrant and the
   --  values of what it is capped by, a target not selected counting
   --  as bottom.
   function Is_Cap_Solution
     (O : Ontology; T : Version_Table; S : Selection;
      Own, E : Warrant_Table; D : Dim) return Boolean
   is
     (for all P in Id =>
        (if not S (P).Selected then E (P, D) = 0
         else
           E (P, D) <= Own (P, D)
           and then
             (for all I in Edge_Ix =>
                (if Caps_Along (O, T, S, P, I, D) then
                   E (P, D) <= E (Edge (O, T, S, P, I).Target, D)))
           and then
             (E (P, D) = Own (P, D)
              or else
                (for some I in Edge_Ix =>
                   Caps_Along (O, T, S, P, I, D)
                   and then
                     E (P, D) = E (Edge (O, T, S, P, I).Target, D)))));

   --  What edge I of P allows P on dimension D, given the table E:
   --  the target's value if the edge caps D (bottom if the target is
   --  not selected), and no limit otherwise.
   function Lower
     (O : Ontology; T : Version_Table; S : Selection; E : Warrant_Table;
      P : Id; D : Dim; I : Edge_Ix) return Warrant
   is
     (if Caps_Along (O, T, S, P, I, D) then
        (if S (Edge (O, T, S, P, I).Target).Selected then
           E (Edge (O, T, S, P, I).Target, D)
         else 0)
      else Warrant'Last);

   --  One round of lowering every piece to what its capping edges
   --  allow.
   function Cap_Step
     (O : Ontology; T : Version_Table; S : Selection; E : Warrant_Table)
      return Warrant_Table
   with
     Post =>
       (for all P in Id =>
          (for all D in Dim =>
             Cap_Step'Result (P, D) =
               Warrant'Min
                 (E (P, D),
                  Warrant'Min
                    (Lower (O, T, S, E, P, D, 1),
                     Warrant'Min
                       (Lower (O, T, S, E, P, D, 2),
                        Warrant'Min
                          (Lower (O, T, S, E, P, D, 3),
                           Warrant'Min
                             (Lower (O, T, S, E, P, D, 4),
                              Lower (O, T, S, E, P, D, 5))))))));

   function Cap_Iter
     (O : Ontology; T : Version_Table; S : Selection; E : Warrant_Table;
      N : Natural) return Warrant_Table
   with
     Subprogram_Variant => (Decreases => N),
     Post =>
       (if N = 0 then Cap_Iter'Result = E
        else Cap_Iter'Result =
               Cap_Iter (O, T, S, Cap_Step (O, T, S, E), N - 1));

   --  The pieces on a cycle along a capping kind. It reads the
   --  selection and the versions, and no fact.
   function Cap_Cycles
     (O : Ontology; T : Version_Table; S : Selection) return Id_Set;

   Cap_Rounds : constant := 5;   --  = the number of ids

   --  Effective warrants are the own warrants lowered Cap_Rounds times.
   --  Values only fall, so what is reached is the greatest solution of
   --  the cap equations; with no capping cycle it is the only one
   --  (Vk.Lemmas.Cap_Unique).
   function Derive
     (O : Ontology; T : Version_Table; S : Selection; F : Facts)
      return Context
   with
     Post =>
       (for all I in Ev_Ix =>
          Derive'Result.App (I) = Applies (O, T, S, F, I))
       and then
       (for all P in Id =>
          (for all D in Dim =>
             Derive'Result.Own (P, D) = Own_Warrant (O, T, S, F, P, D)))
       and then Derive'Result.Eff =
                  Cap_Iter (O, T, S, Derive'Result.Own, Cap_Rounds)
       and then Derive'Result.Cyc = Cap_Cycles (O, T, S);

   -------------------------------------------------------------------
   --  Decisions (spec section 4, second bullet)
   -------------------------------------------------------------------

   function Cond_True
     (T : Version_Table; S : Selection; C : Context; X : Id_Set;
      Cd : Condition) return Boolean
   is
     (case Cd.What is
        when None | Selected_At | Slot_Filled => Plain_True (T, S, Cd),
        when Warrant_At_Least    => C.Own (Cd.P, Cd.D) >= Cd.W,
        when Asserted_Consistent => X (Cd.P));

   --  X is the set of pieces taken as consistent.
   function Dec_Holds
     (T : Version_Table; S : Selection; F : Facts; C : Context;
      X : Id_Set; J : Dec_Ix) return Boolean
   is
     (F.Dec (J).Present and then not F.Dec (J).Withdrawn
      and then
        (if F.Dec (J).What in Admit | Affirm then
           S (F.Dec (J).P).Selected
           and then F.Dec (J).PVs (S (F.Dec (J).P).V))
      and then
        (for all K in Cond_Ix =>
           Cond_True (T, S, C, X, F.Dec (J).Conds (K))));

   --  Only accept and affirm decisions may be conditioned on a piece
   --  being consistent. A decision that ADDS an obligation (promise,
   --  raise), or removes one (waive, set aside), conditioned on
   --  consistency makes consistency ill defined (see the account, Q6).
   function Stratified (F : Facts) return Boolean is
     (for all J in Dec_Ix =>
        (if F.Dec (J).Present
           and then F.Dec (J).What not in Admit | Affirm
         then
           (for all K in Cond_Ix =>
              F.Dec (J).Conds (K).What /= Asserted_Consistent)));

   --  P at its selected version has been affirmed against Q as Q is
   --  now selected, as far as level L relies on Q.
   function Affirmed
     (T : Version_Table; S : Selection; F : Facts; C : Context;
      X : Id_Set; P, Q : Id; L : Relies) return Boolean
   is
     (for some J in Dec_Ix =>
        F.Dec (J).What = Affirm
        and then F.Dec (J).P = P and then F.Dec (J).Q = Q
        and then Dec_Holds (T, S, F, C, X, J)
        and then Agrees (T, S, Q, F.Dec (J).QV, F.Dec (J).QSame, L));

   -------------------------------------------------------------------
   --  The constraints (spec section 5), one function per instance kind
   -------------------------------------------------------------------

   function Holds_In_Slot
     (T : Version_Table; S : Selection; A, P : Id; Sl : Slot_Ix)
      return Boolean
   is
     (S (A).Selected
      and then Sel (T, S, A).Slots (Sl).State = Holding
      and then Sel (T, S, A).Slots (Sl).Filler = P);

   function V_C1_Held
     (T : Version_Table; S : Selection; P : Id) return Boolean
   is
     (for some A in Id =>
        (for some Sa in Slot_Ix =>
           Holds_In_Slot (T, S, A, P, Sa)
           and then
             (for some B in Id =>
                (for some Sb in Slot_Ix =>
                   (A /= B or else Sa /= Sb)
                   and then Holds_In_Slot (T, S, B, P, Sb)))));

   function V_C1_Shape
     (O : Ontology; T : Version_Table; S : Selection; P : Id; Sl : Slot_Ix)
      return Boolean
   is
     (Sel (T, S, P).Slots (Sl).State /= Empty
      and then
        (not O.Kinds (Sel (T, S, P).K).Is_Assembly
         or else not O.Kinds (Sel (T, S, P).K).Used (Sl)
         or else
           (Sel (T, S, P).Slots (Sl).State = Holding
            and then not S (Sel (T, S, P).Slots (Sl).Filler).Selected)));

   --  Evidence about A that read B applies.
   function Read_Together
     (O : Ontology; F : Facts; C : Context; A, B : Id) return Boolean
   is
     (O.Reads_On
      and then
        (for some I in Ev_Ix =>
           C.App (I) and then F.Ev (I).P = A
           and then
             (for some R in Read_Ix =>
                F.Ev (I).Reads (R).Present
                and then F.Ev (I).Reads (R).Q = B)));

   function V_C2
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; X : Id_Set; P : Id; Sa, Sb : Slot_Ix) return Boolean
   is
     (O.Kinds (Sel (T, S, P).K).Is_Assembly
      and then O.Kinds (Sel (T, S, P).K).Deps (Sa, Sb)
      and then Sel (T, S, P).Slots (Sa).State /= Empty
      and then Sel (T, S, P).Slots (Sb).State /= Empty
      and then S (Sel (T, S, P).Slots (Sa).Filler).Selected
      and then S (Sel (T, S, P).Slots (Sb).Filler).Selected
      and then not Affirmed
        (T, S, F, C, X, Sel (T, S, P).Slots (Sa).Filler,
         Sel (T, S, P).Slots (Sb).Filler, Everything)
      and then not Read_Together
        (O, F, C, Sel (T, S, P).Slots (Sa).Filler,
         Sel (T, S, P).Slots (Sb).Filler));

   --  Exactly one selected descendant of Q.
   function One_Desc (S : Selection; F : Facts; Q : Id) return Boolean is
     (for some B in Id =>
        F.Desc (Q, B) and then S (B).Selected
        and then
          (for all B2 in Id =>
             (if F.Desc (Q, B2) and then S (B2).Selected then B2 = B)));

   function V_C3_Resolve
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      P : Id; I : Edge_Ix) return Boolean
   is
     (Edge (O, T, S, P, I).Present
      and then not S (Edge (O, T, S, P, I).Target).Selected
      and then not
        (O.Redirect and then One_Desc (S, F, Edge (O, T, S, P, I).Target)));

   function V_C4
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; X : Id_Set; P : Id; I : Edge_Ix) return Boolean
   is
     (Edge (O, T, S, P, I).Present
      and then O.RK (Edge (O, T, S, P, I).K).Relies_On /= Existence
      and then S (Edge (O, T, S, P, I).Target).Selected
      and then not Affirmed
        (T, S, F, C, X, P, Edge (O, T, S, P, I).Target,
         O.RK (Edge (O, T, S, P, I).K).Relies_On));

   function V_C5_Standard
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; X : Id_Set; P : Id) return Boolean
   is
     (case O.Canon is
        when By_Decision =>
          not (for some J in Dec_Ix =>
                 F.Dec (J).What = Admit and then F.Dec (J).P = P
                 and then Dec_Holds (T, S, F, C, X, J)),
        when By_Rule =>
          (for some D in Dim =>
             O.Kinds (Sel (T, S, P).K).Opens (D)
             and then C.Eff (P, D) < O.Dims (D).Rule_Min),
        when By_Placement => False);

   function V_C5_Rests
     (O : Ontology; T : Version_Table; S : Selection; X : Id_Set;
      P : Id; I : Edge_Ix) return Boolean
   is
     (Edge (O, T, S, P, I).Present
      and then O.RK (Edge (O, T, S, P, I).K).Rests
      and then O.RK (Edge (O, T, S, P, I).K).Relies_On /= Existence
      and then not X (Edge (O, T, S, P, I).Target));

   function V_C6_Fails
     (F : Facts; C : Context; P : Id; I : Ev_Ix) return Boolean
   is
     (C.App (I) and then F.Ev (I).P = P and then F.Ev (I).Result /= Holds);

   function Has_Holds_C
     (F : Facts; C : Context; P : Id; D : Dim; Cr : Crit) return Boolean
   is
     (for some I in Ev_Ix =>
        C.App (I) and then F.Ev (I).P = P and then F.Ev (I).D = D
        and then F.Ev (I).C = Cr and then F.Ev (I).Result = Holds);

   function V_C6_Guard
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; P : Id; D : Dim; Cr : Crit) return Boolean
   is
     (Guard (O, T, S, F, P, D, Cr)
      and then not Has_Holds_C (F, C, P, D, Cr));

   function V_C7_Claim
     (T : Version_Table; S : Selection; C : Context; P : Id) return Boolean
   is
     (Sel (T, S, P).Claims.Present
      and then Sel (T, S, P).Claims.Level
               > C.Eff (Sel (T, S, P).Claims.About, Sel (T, S, P).Claims.D));

   function V_C7_Report
     (T : Version_Table; S : Selection; F : Facts; C : Context;
      X : Id_Set; P : Id) return Boolean
   is
     (Sel (T, S, P).Reports.Present
      and then not Dec_Holds (T, S, F, C, X, Sel (T, S, P).Reports.Dec));

   function V_C8_Need
     (O : Ontology; T : Version_Table; S : Selection; C : Context;
      P : Id; I : Edge_Ix) return Boolean
   is
     (Edge (O, T, S, P, I).Present
      and then Edge (O, T, S, P, I).Need
               > C.Eff (Edge (O, T, S, P, I).Target,
                        Edge (O, T, S, P, I).Need_Dim));

   function Promised
     (T : Version_Table; S : Selection; F : Facts; C : Context;
      X : Id_Set; P : Id; Sl : Slot_Ix) return Boolean
   is
     (for some J in Dec_Ix =>
        F.Dec (J).What = Promise and then F.Dec (J).P = P
        and then F.Dec (J).S = Sl
        and then Dec_Holds (T, S, F, C, X, J));

   function V_C8_Slot
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; X : Id_Set; P : Id; Sl : Slot_Ix) return Boolean
   is
     (O.Kinds (Sel (T, S, P).K).Is_Assembly
      and then
        (O.Kinds (Sel (T, S, P).K).Required (Sl)
         or else Promised (T, S, F, C, X, P, Sl))
      and then not
        (Sel (T, S, P).Slots (Sl).State /= Empty
         and then S (Sel (T, S, P).Slots (Sl).Filler).Asserted
         and then
           (not O.Slot_Needs_Consistent
            or else X (Sel (T, S, P).Slots (Sl).Filler))));

   function V_C9
     (T : Version_Table; S : Selection; F : Facts; C : Context;
      X : Id_Set; P : Id; J : Dec_Ix) return Boolean
   is
     (F.Dec (J).What = Ask and then F.Dec (J).P = P
      and then Dec_Holds (T, S, F, C, X, J)
      and then not
        (for some I in Ev_Ix =>
           C.App (I) and then F.Ev (I).P = P
           and then F.Ev (I).D = F.Dec (J).D));

   --  Is instance N violated, taking X as the consistent pieces?
   --  Pieces not asserted have no instances. An instance whose indices
   --  are out of range for its kind is never violated.
   function Violated
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; X : Id_Set; N : Instance) return Boolean
   is
     (S (N.P).Asserted
      and then
        (case N.K is
           when C1_Held =>
             N.I = 0 and then N.J = 0 and then V_C1_Held (T, S, N.P),
           when C1_Shape =>
             N.I in 1 .. 3 and then N.J = 0
             and then V_C1_Shape (O, T, S, N.P, Slot_Ix (N.I)),
           when C2_Together =>
             N.I in 1 .. 3 and then N.J in 1 .. 3
             and then V_C2 (O, T, S, F, C, X, N.P,
                            Slot_Ix (N.I), Slot_Ix (N.J)),
           when C3_Resolve =>
             N.I in 1 .. 5 and then N.J = 0
             and then V_C3_Resolve (O, T, S, F, N.P, Edge_Ix (N.I)),
           when C3_Cycle =>
             N.I = 0 and then N.J = 0 and then C.Cyc (N.P),
           when C4_Reconciled =>
             N.I in 1 .. 5 and then N.J = 0
             and then V_C4 (O, T, S, F, C, X, N.P, Edge_Ix (N.I)),
           when C5_Standard =>
             N.I = 0 and then N.J = 0
             and then V_C5_Standard (O, T, S, F, C, X, N.P),
           when C5_Rests =>
             N.I in 1 .. 5 and then N.J = 0
             and then V_C5_Rests (O, T, S, X, N.P, Edge_Ix (N.I)),
           when C6_Fails =>
             N.I in 1 .. 12 and then N.J = 0
             and then V_C6_Fails (F, C, N.P, Ev_Ix (N.I)),
           when C6_Guard =>
             N.I in 1 .. 2 and then N.J in 1 .. 2
             and then V_C6_Guard (O, T, S, F, C, N.P,
                                  Dim (N.I), Crit (N.J)),
           when C7_Claim =>
             N.I = 0 and then N.J = 0 and then V_C7_Claim (T, S, C, N.P),
           when C7_Report =>
             N.I = 0 and then N.J = 0
             and then V_C7_Report (T, S, F, C, X, N.P),
           when C8_Need =>
             N.I in 1 .. 5 and then N.J = 0
             and then V_C8_Need (O, T, S, C, N.P, Edge_Ix (N.I)),
           when C8_Slot =>
             N.I in 1 .. 3 and then N.J = 0
             and then V_C8_Slot (O, T, S, F, C, X, N.P, Slot_Ix (N.I)),
           when C9_Raised =>
             N.I in 1 .. 12 and then N.J = 0
             and then V_C9 (T, S, F, C, X, N.P, Dec_Ix (N.I))));

   --  A waive decision about N holds.
   function Covered
     (T : Version_Table; S : Selection; F : Facts; C : Context;
      X : Id_Set; N : Instance) return Boolean
   is
     (for some J in Dec_Ix =>
        F.Dec (J).What = Waive and then F.Dec (J).Inst = N
        and then Dec_Holds (T, S, F, C, X, J));

   -------------------------------------------------------------------
   --  Consistency (spec section 4, last bullet) and the frontier
   -------------------------------------------------------------------

   --  Nothing about P is violated, taking X as the consistent pieces.
   --  C5_Rests is among the instances, so "everything P rests on is
   --  consistent" is part of this.
   function Own_OK
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; X : Id_Set; P : Id) return Boolean
   is
     (S (P).Asserted
      and then
        (for all K in Inst_Kind =>
           (for all I in Sub =>
              (for all J in Sub =>
                 not Violated (O, T, S, F, C, X, (K, P, I, J))
                 or else
                   (O.Waived_Is_Consistent
                    and then Covered (T, S, F, C, X, (K, P, I, J)))))));

   --  X is a fixed point of "consistent".
   function Is_Fixed
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; X : Id_Set) return Boolean
   is
     (for all P in Id => X (P) = Own_OK (O, T, S, F, C, X, P));

   --  One round: keep the pieces of X about which nothing is violated
   --  when X is taken as the consistent pieces.
   function Stepped
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; X : Id_Set) return Id_Set
   is
     ([for P in Id => X (P) and then Own_OK (O, T, S, F, C, X, P)]);

   function Iter
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; X : Id_Set; N : Natural) return Id_Set
   with
     Subprogram_Variant => (Decreases => N),
     Post =>
       (if N = 0 or else Stepped (O, T, S, F, C, X) = X then Iter'Result = X
        else Iter'Result =
               Iter (O, T, S, F, C, Stepped (O, T, S, F, C, X), N - 1));

   function Asserted_Set (S : Selection) return Id_Set is
     ([for P in Id => S (P).Asserted]);

   Rounds : constant := 5;   --  = the number of ids

   --  The consistent pieces: descend from "every asserted piece".
   --  When Stratified (F) this is the greatest fixed point
   --  (Vk.Lemmas.Consistent_Is_Fixed, Consistent_Is_Greatest). When
   --  not, there may be no fixed point at all, and the result is
   --  whatever the descent stopped at: test Is_Fixed.
   function Consistent
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context) return Id_Set
   is
     (Iter (O, T, S, F, C, Asserted_Set (S), Rounds));

   --  Instance N is on the frontier.
   function On_Frontier
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      N : Instance) return Boolean
   is
     (Violated (O, T, S, F, Derive (O, T, S, F),
                Consistent (O, T, S, F, Derive (O, T, S, F)), N));

end Vk.Model;
