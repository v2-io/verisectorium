--  What is proved about Vk.Model, for every ontology, version table,
--  selection and set of facts of the bounded types, under the stated
--  preconditions. All ghost: nothing here runs.
--
--  The names say which property of KERNEL-SPEC draft 3 section 7 each
--  bears on. The account says what is NOT covered by each.
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
      C : Context; Y, X : Id_Set; P : Id)
   with
     Pre  => Stratified (F) and then Sub_Set (Y, X),
     Post => (if Own_OK (O, T, S, F, C, Y, P)
              then Own_OK (O, T, S, F, C, X, P));

   --  The consistent set is a fixed point.
   procedure Consistent_Is_Fixed
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context)
   with
     Pre  => Stratified (F),
     Post => Is_Fixed (O, T, S, F, C, Consistent (O, T, S, F, C));

   --  And every set that is consistent with itself lies within it. (Y
   --  need not be a fixed point; it is enough that nothing is violated
   --  about any member when Y is taken as the consistent pieces.)
   procedure Consistent_Is_Greatest
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; Y : Id_Set)
   with
     Pre  => Stratified (F)
             and then (for all P in Id =>
                         (if Y (P) then Own_OK (O, T, S, F, C, Y, P))),
     Post => Sub_Set (Y, Consistent (O, T, S, F, C));

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
   --  Q5: a known defect cannot be selected away
   -------------------------------------------------------------------

   --  With guards on: a fact that does not hold, not set aside, about P
   --  or about anything P descends from, at ANY version, puts a C6
   --  instance about P on the frontier of every selection that asserts
   --  P (at any version) without holding evidence on that criterion
   --  applying there. X is arbitrary, so this is about the frontier
   --  whatever is consistent.
   procedure Defect_Stays
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      X : Id_Set; P : Id; I : Ev_Ix)
   with
     Pre  => O.Guards_On
             and then F.Ev (I).Present
             and then F.Ev (I).Result /= Holds
             and then not Aside (O, T, S, F, I)
             and then (F.Ev (I).P = P or else F.Desc (F.Ev (I).P, P))
             and then S (P).Asserted
             and then not Has_Holds
               (O, T, S, F, P, F.Ev (I).D, F.Ev (I).C),
     Post => Violated
               (O, T, S, F, Derive (O, T, S, F), X,
                (C6_Guard, P, Sub (F.Ev (I).D), Sub (F.Ev (I).C)));

   -------------------------------------------------------------------
   --  Q4: good facts do no harm
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
         and then A.D = B.D and then A.C = B.C
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

   --  Adding good facts adds nothing to the frontier.
   procedure Good_Facts_Do_No_Harm
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      N : Instance)
   with
     Pre  => Good_Ext (F, F2)
             and then Monotone (O)
             and then Stratified (F) and then Stratified (F2)
             and then Plain_Obligations (F),
     Post => (if On_Frontier (O, T, S, F2, N)
              then On_Frontier (O, T, S, F, N));

end Vk.Lemmas;
