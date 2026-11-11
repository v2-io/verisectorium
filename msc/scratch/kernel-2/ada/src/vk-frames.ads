--  What it is for two states to agree on a region of pieces, as far as
--  the frontier reads them (spec draft 4: R9 and R12).
--
--  A state here is (S, F, L): a selection, the facts in force, and the
--  view of the line it was read from. The ontology and the version
--  table are shared. Vk.Merge proves that the frontier on a region is
--  the same in any two states that agree on it; this unit only says
--  what "agree" asks, and is executable so that the tests can compute
--  regions for real forks.
with Vk.Model; use Vk.Model;

package Vk.Frames with SPARK_Mode => On is

   --  The same as far as existence and canon go: what an instance may
   --  read of a piece it only points at.
   function Weak (S1, S2 : Selection; Q : Id) return Boolean is
     (S1 (Q).Selected = S2 (Q).Selected
      and then S1 (Q).Asserted = S2 (Q).Asserted);

   --  An edge through which nothing but the target's existence is
   --  read: its kind relies on existence only, caps nothing, and the
   --  edge needs no warrant.
   function Light (O : Ontology; E : Ref) return Boolean is
     (O.RK (E.K).Relies_On = Existence
      and then (for all D in Dim => not O.RK (E.K).Caps (D))
      and then E.Need = 0);

   function No_Deps (K : Kind_Decl; Sl : Slot_Ix) return Boolean is
     (for all T in Slot_Ix => not K.Deps (Sl, T) and then not K.Deps (T, Sl));

   --  The piece a decision is about (not for set asides, which are
   --  about evidence and are handled with it).
   function About (D : Decision) return Id is
     (if D.What = Waive then D.Inst.P else D.P);

   --  Everything decision D reads lies in R.
   function Dec_Closed (R : Id_Set; D : Decision) return Boolean is
     ((for all K in Cond_Ix =>
         (if D.Conds (K).What /= None then R (D.Conds (K).P)))
      and then (if D.What = Affirm then R (D.Q))
      and then (if D.What in Admit | Affirm then R (D.P)));

   --  Root Rt, marked and selected, is P or reaches P.
   function Asked_By
     (S : Selection; L : Line_View; Rt, P : Id) return Boolean
   is
     (L.Roots (Rt) and then S (Rt).Selected
      and then (Rt = P or else L.Reach (Rt, P)));

   --  What slot Sl of A holds is held elsewhere as well (C1). A named
   --  function, not an expression function, so that the provers see
   --  one term per slot and not two nested quantifiers.
   function Held_Elsewhere
     (T : Version_Table; S : Selection; A : Id; Sl : Slot_Ix) return Boolean
   with
     Post => Held_Elsewhere'Result = V_C1_Held (T, S, A, Sl);

   --  The two states agree on everything an instance about P reads,
   --  given that they agree on the rest of R.
   function Member_OK
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; P : Id) return Boolean
   is
     (S1 (P) = S2 (P)
      --  what P's selected version reads downward
      and then
        (if S1 (P).Selected or else S1 (P).Asserted then
           (for all I in Edge_Ix =>
              (if Edge (O, T, S1, P, I).Present then
                 R (Edge (O, T, S1, P, I).Target)
                 or else
                   (Light (O, Edge (O, T, S1, P, I))
                    and then Weak (S1, S2, Edge (O, T, S1, P, I).Target))))
           and then
           (for all Sl in Slot_Ix =>
              (if Sel (T, S1, P).Slots (Sl).State /= Empty then
                 R (Sel (T, S1, P).Slots (Sl).Filler)
                 or else
                   (Weak (S1, S2, Sel (T, S1, P).Slots (Sl).Filler)
                    and then No_Deps (O.Kinds (Sel (T, S1, P).K), Sl))))
           and then
           (if Sel (T, S1, P).Claims.Present then
              R (Sel (T, S1, P).Claims.About))
           and then
           (if Sel (T, S1, P).Reports.Present then
              F1.Dec (Sel (T, S1, P).Reports.Dec)
              = F2.Dec (Sel (T, S1, P).Reports.Dec)
              and then Dec_Closed (R, F1.Dec (Sel (T, S1, P).Reports.Dec))))
      --  what the line says of P
      and then
        (for all D in Dim => (for all Cr in Crit =>
           L1.Guard (P, D, Cr) = L2.Guard (P, D, Cr)))
      and then (for all I in Edge_Ix => L1.Seen (P, I) = L2.Seen (P, I))
      and then
        (for all Rt in Id =>
           Asked_By (S1, L1, Rt, P) = Asked_By (S2, L2, Rt, P)
           and then
             (if Asked_By (S1, L1, Rt, P) then
                Sel (T, S1, Rt).K = Sel (T, S2, Rt).K))
      and then
        (for all Sl in Slot_Ix =>
           Held_Elsewhere (T, S1, P, Sl) = Held_Elsewhere (T, S2, P, Sl))
      --  the evidence about P, and whether each is set aside
      and then
        (for all I in Ev_Ix =>
           (if (F1.Ev (I).Present and then F1.Ev (I).P = P)
              or else (F2.Ev (I).Present and then F2.Ev (I).P = P)
            then
              F1.Ev (I) = F2.Ev (I)
              and then Aside (F1, I) = Aside (F2, I)
              and then
                (for all Rd in Read_Ix =>
                   (if F1.Ev (I).Reads (Rd).Present then
                      R (F1.Ev (I).Reads (Rd).Q)))))
      --  the decisions about P
      and then
        (for all J in Dec_Ix =>
           (if (F1.Dec (J).Present and then F1.Dec (J).What /= Set_Aside
                and then About (F1.Dec (J)) = P)
              or else
              (F2.Dec (J).Present and then F2.Dec (J).What /= Set_Aside
                and then About (F2.Dec (J)) = P)
            then
              F1.Dec (J) = F2.Dec (J)
              and then Dec_Closed (R, F1.Dec (J)))));

   --  The two states agree on the region R.
   function Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View) return Boolean
   is
     (for all P in Id =>
        (if R (P) then Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, P)));

   --  The largest region on which the two states agree (found by
   --  striking out pieces until none fails).
   function Largest_Region
     (O : Ontology; T : Version_Table;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View) return Id_Set
   with
     Post => Agree (O, T, Largest_Region'Result,
                    S1, F1, L1, S2, F2, L2);

   --  Instance N is owed and not waived.
   function Uncovered
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      L : Line_View; N : Instance) return Boolean
   is
     (On_Frontier (O, T, S, F, L, N)
      and then not Covered
        (T, S, F, Derive (O, T, S, F),
         Consistent (O, T, S, F, L, Derive (O, T, S, F)), N));

   --  Nothing about any piece of R is owed and unwaived.
   function Stationary_On
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      L : Line_View; R : Id_Set) return Boolean
   is
     (for all K in Inst_Kind => (for all P in Id =>
        (for all I in Sub => (for all J in Sub =>
           (if R (P) then not Uncovered (O, T, S, F, L, (K, P, I, J)))))));

end Vk.Frames;
