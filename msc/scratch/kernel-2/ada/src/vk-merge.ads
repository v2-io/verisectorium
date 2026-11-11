--  R12 and R9 of KERNEL-SPEC draft 4, proved about the function from a
--  state to its frontier.
--
--  Frame: if two states agree on a region (Vk.Frames.Agree), then what
--  is owed about the pieces of the region is the same in both. Nothing
--  outside the region can change it.
--
--  Forks_Compose and Meeting_Is_Local are its two corollaries for two
--  forks A and B and their union M. "A" and "B" here are any two
--  states; that they came from one checkpoint is not used.
with Vk.Model;  use Vk.Model;
with Vk.Frames; use Vk.Frames;

package Vk.Merge with SPARK_Mode => On, Ghost is

   procedure Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; N : Instance)
   with
     Pre  => Agree (O, T, R, S1, F1, L1, S2, F2, L2) and then R (N.P),
     Post => On_Frontier (O, T, S1, F1, L1, N)
             = On_Frontier (O, T, S2, F2, L2, N)
             and then Uncovered (O, T, S1, F1, L1, N)
                      = Uncovered (O, T, S2, F2, L2, N);

   All_Ids : constant Id_Set := [others => True];

   --  R9, first form. If the union agrees with fork A on a region RA
   --  and with fork B on a region RB, the two regions between them
   --  cover every piece, and each fork is stationary on its own
   --  region, then the union is stationary.
   procedure Forks_Compose
     (O : Ontology; T : Version_Table;
      SA : Selection; FA : Facts; LA : Line_View;
      SB : Selection; FB : Facts; LB : Line_View;
      SM : Selection; FM : Facts; LM : Line_View; RA, RB : Id_Set)
   with
     Pre  => Agree (O, T, RA, SA, FA, LA, SM, FM, LM)
             and then Agree (O, T, RB, SB, FB, LB, SM, FM, LM)
             and then (for all P in Id => RA (P) or else RB (P))
             and then Stationary_On (O, T, SA, FA, LA, RA)
             and then Stationary_On (O, T, SB, FB, LB, RB),
     Post => Stationary_On (O, T, SM, FM, LM, All_Ids);

   --  R9, second form. Whether or not the regions cover everything:
   --  whatever the union owes, unwaived, is about a piece in neither
   --  region. Resolving there is enough.
   procedure Meeting_Is_Local
     (O : Ontology; T : Version_Table;
      SA : Selection; FA : Facts; LA : Line_View;
      SB : Selection; FB : Facts; LB : Line_View;
      SM : Selection; FM : Facts; LM : Line_View; RA, RB : Id_Set;
      N : Instance)
   with
     Pre  => Agree (O, T, RA, SA, FA, LA, SM, FM, LM)
             and then Agree (O, T, RB, SB, FB, LB, SM, FM, LM)
             and then Stationary_On (O, T, SA, FA, LA, RA)
             and then Stationary_On (O, T, SB, FB, LB, RB)
             and then Uncovered (O, T, SM, FM, LM, N),
     Post => not RA (N.P) and then not RB (N.P);

end Vk.Merge;
