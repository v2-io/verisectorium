--  What is proved about Vk.Model, for every ontology, version table,
--  selection and set of facts of the bounded types, under the stated
--  preconditions. All ghost: nothing here runs.
--
--  The names say which property of KERNEL-SPEC draft 4 section 7 each
--  bears on (R6, R7, R8, and the cap). They are about the function
--  from a state to its frontier; what Vk.Lines reads from a line is
--  tested, not proved. The account says what is NOT covered by each.
with Vk.Model; use Vk.Model;

package Vk.Lemmas with SPARK_Mode => On, Ghost is

   function Sub_Set (A, B : Id_Set) return Boolean is
     (for all P in Id => (if A (P) then B (P)));

   -------------------------------------------------------------------
   --  Q6, consistency: the greatest fixed point exists
   -------------------------------------------------------------------

   --  Taking more pieces as consistent never makes a piece worse off.
   procedure Mono_X
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      L : Line_View; C : Context; Y, X : Id_Set; P : Id)
   with
     Pre  => Stratified (F) and then Sub_Set (Y, X),
     Post => (if Own_OK (O, T, S, F, L, C, Y, P)
              then Own_OK (O, T, S, F, L, C, X, P));

   --  The consistent set is a fixed point.
   procedure Consistent_Is_Fixed
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      L : Line_View; C : Context)
   with
     Pre  => Stratified (F),
     Post => Is_Fixed (O, T, S, F, L, C, Consistent (O, T, S, F, L, C));

   --  And every set that is consistent with itself lies within it. (Y
   --  need not be a fixed point; it is enough that nothing is violated
   --  about any member when Y is taken as the consistent pieces.)
   procedure Consistent_Is_Greatest
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      L : Line_View; C : Context; Y : Id_Set)
   with
     Pre  => Stratified (F)
             and then (for all P in Id =>
                         (if Y (P) then Own_OK (O, T, S, F, L, C, Y, P))),
     Post => Sub_Set (Y, Consistent (O, T, S, F, L, C));

   -------------------------------------------------------------------
   --  Q6, the cap: at most one solution when there is no cycle
   -------------------------------------------------------------------

   type Rank is range 0 .. 5;
   type Rank_Table is array (Id) of Rank;

   --  A ranking under which every capping edge between selected pieces
   --  points strictly downward: the witness that there is no cycle
   --  along a capping kind for dimension D.
   function Ranked
     (O : Ontology; T : Version_Table; S : Selection; D : Dim;
      Rk : Rank_Table) return Boolean
   is
     (for all P in Id =>
        (for all I in Edge_Ix =>
           (if Caps_Along (O, T, S, P, I, D)
              and then S (Edge (O, T, S, P, I).Target).Selected
            then Rk (Edge (O, T, S, P, I).Target) < Rk (P))));

   procedure Cap_Unique
     (O : Ontology; T : Version_Table; S : Selection;
      Own, E1, E2 : Warrant_Table; D : Dim; Rk : Rank_Table)
   with
     Pre  => Ranked (O, T, S, D, Rk)
             and then Is_Cap_Solution (O, T, S, Own, E1, D)
             and then Is_Cap_Solution (O, T, S, Own, E2, D),
     Post => (for all P in Id => E1 (P, D) = E2 (P, D));

   -------------------------------------------------------------------
   --  R8: an open guard is on the frontier
   -------------------------------------------------------------------

   --  Whatever is consistent, an open guard on an asserted piece is a
   --  violated instance. (Which guards are open is Vk.Lines' to say.)
   procedure Guard_Is_Owed
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      L : Line_View; X : Id_Set; P : Id; D : Dim; Cr : Crit)
   with
     Pre  => L.Guard (P, D, Cr) and then S (P).Asserted,
     Post => Violated
               (O, T, S, F, L, Derive (O, T, S, F), X,
                (C6_Guard, P, Sub (D), Sub (Cr)));

   -------------------------------------------------------------------
   --  The spec's rule (section 2): obligations are unconditional
   -------------------------------------------------------------------

   function Unconditional (F : Facts) return Boolean is
     (for all J in Dec_Ix =>
        (if F.Dec (J).Present
           and then F.Dec (J).What in Promise | Waive | Ask | Set_Aside
         then
           (for all K in Cond_Ix => F.Dec (J).Conds (K).What = None)));

   --  R7 as the spec now has it.
   procedure Well_Defined
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      L : Line_View; C : Context; Y : Id_Set)
   with
     Pre  => Unconditional (F),
     Post => Is_Fixed (O, T, S, F, L, C, Consistent (O, T, S, F, L, C))
             and then
             (if (for all P in Id =>
                    (if Y (P) then Own_OK (O, T, S, F, L, C, Y, P)))
              then Sub_Set (Y, Consistent (O, T, S, F, L, C)));

   -------------------------------------------------------------------
   --  R6: good news does no harm
   -------------------------------------------------------------------

   function Monotone (O : Ontology) return Boolean is
     (for all D in Dim =>
        O.Dims (D).Read_As (False, False) <= O.Dims (D).Read_As (True, False)
        and then
        O.Dims (D).Read_As (False, False) <= O.Dims (D).Read_As (False, True)
        and then
        O.Dims (D).Read_As (True, False) <= O.Dims (D).Read_As (True, True)
        and then
        O.Dims (D).Read_As (False, True) <= O.Dims (D).Read_As (True, True));

   --  A promise or a raise (the decisions that ADD an obligation) is
   --  conditioned on nothing that facts can change.
   function Plain_Obligations (F : Facts) return Boolean is
     (for all J in Dec_Ix =>
        (if F.Dec (J).Present and then F.Dec (J).What in Promise | Ask then
           (for all K in Cond_Ix =>
              F.Dec (J).Conds (K).What
                in None | Selected_At | Slot_Filled)));

   function Read_Grew (A, B : Read) return Boolean is
     (A.Present = B.Present and then A.Q = B.Q and then A.W = B.W
      and then A.Level = B.Level
      and then (for all V in Ver => (if A.Same (V) then B.Same (V))));

   --  B is A, or A with more versions judged the same, A holding; or A
   --  is absent and B holds.
   function Ev_Good (A, B : Evidence) return Boolean is
     (A = B
      or else (not A.Present and then B.Present and then B.Result = Holds)
      or else
        (A.Present and then B.Present
         and then A.Result = Holds and then B.Result = Holds
         and then A.P = B.P and then A.V = B.V
         and then A.D = B.D and then A.C = B.C and then A.Time = B.Time
         and then (for all V in Ver => (if A.Same (V) then B.Same (V)))
         and then (for all R in Read_Ix =>
                     Read_Grew (A.Reads (R), B.Reads (R)))));

   --  F2 is F with good facts added, any number of them: evidence that
   --  holds; "same" facts for evidence that holds; accept and affirm
   --  decisions.
   function Good_Ext (F, F2 : Facts) return Boolean is
     (F.Desc = F2.Desc
      and then (for all I in Ev_Ix => Ev_Good (F.Ev (I), F2.Ev (I)))
      and then
        (for all J in Dec_Ix =>
           F.Dec (J) = F2.Dec (J)
           or else (not F.Dec (J).Present
                    and then F2.Dec (J).What in Admit | Affirm)));

   --  The two views of the line agree, except that the later one may
   --  have fewer guards open. (That good news opens no guard is a
   --  property of Vk.Lines, tested there.)
   function View_Le (L, L2 : Line_View) return Boolean is
     ((for all P in Id =>
         L.Roots (P) = L2.Roots (P)
         and then (for all Q in Id => L.Reach (P, Q) = L2.Reach (P, Q))
         and then (for all I in Edge_Ix => L.Seen (P, I) = L2.Seen (P, I))
         and then
           (for all D in Dim => (for all Cr in Crit =>
              (if L2.Guard (P, D, Cr) then L.Guard (P, D, Cr))))));

   --  Adding good facts adds nothing to the frontier.
   procedure Good_Facts_Do_No_Harm
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      L, L2 : Line_View; N : Instance)
   with
     Pre  => Good_Ext (F, F2)
             and then Monotone (O)
             and then Stratified (F) and then Stratified (F2)
             and then Plain_Obligations (F)
             and then View_Le (L, L2),
     Post => (if On_Frontier (O, T, S, F2, L2, N)
              then On_Frontier (O, T, S, F, L, N));

   --  R6 as the spec now has it: with obligations unconditional, the
   --  one condition left on the ontology is that read_as is monotone.
   procedure Good_News
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      L, L2 : Line_View; N : Instance)
   with
     Pre  => Good_Ext (F, F2) and then Monotone (O)
             and then Unconditional (F) and then View_Le (L, L2),
     Post => (if On_Frontier (O, T, S, F2, L2, N)
              then On_Frontier (O, T, S, F, L, N));

end Vk.Lemmas;
