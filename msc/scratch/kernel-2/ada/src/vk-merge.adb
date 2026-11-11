package body Vk.Merge with SPARK_Mode => On is

   function Reg_Eq (R, A, B : Id_Set) return Boolean is
     (for all P in Id => (if R (P) then A (P) = B (P)));

   function Reg_Tab (R : Id_Set; A, B : Warrant_Table) return Boolean is
     (for all P in Id => (if R (P) then
        (for all D in Dim => A (P, D) = B (P, D))));

   --  Evidence fact I is about a piece of R, in one state or the other.
   function Ev_In (R : Id_Set; F1, F2 : Facts; I : Ev_Ix) return Boolean is
     ((F1.Ev (I).Present and then R (F1.Ev (I).P))
      or else (F2.Ev (I).Present and then R (F2.Ev (I).P)));

   --  Decision J is about a piece of R, in one state or the other.
   function Dec_In (R : Id_Set; F1, F2 : Facts; J : Dec_Ix) return Boolean is
     ((F1.Dec (J).Present and then F1.Dec (J).What /= Set_Aside
       and then R (About (F1.Dec (J))))
      or else
      (F2.Dec (J).Present and then F2.Dec (J).What /= Set_Aside
       and then R (About (F2.Dec (J)))));

   -------------------------------------------------------------------
   --  The contexts agree on the region
   -------------------------------------------------------------------

   procedure App_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; I : Ev_Ix)
   with
     Pre  => Agree (O, T, R, S1, F1, L1, S2, F2, L2)
             and then Ev_In (R, F1, F2, I),
     Post => Applies (O, T, S1, F1, I) = Applies (O, T, S2, F2, I)
             and then F1.Ev (I) = F2.Ev (I);

   procedure App_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; I : Ev_Ix)
   is
      P : constant Id :=
        (if F1.Ev (I).Present and then R (F1.Ev (I).P) then F1.Ev (I).P
         else F2.Ev (I).P);
   begin
      pragma Assert (Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, P));
      pragma Assert (F1.Ev (I) = F2.Ev (I));
      pragma Assert (S1 (P) = S2 (P));
      pragma Assert
        (for all Rd in Read_Ix =>
           (if F1.Ev (I).Reads (Rd).Present then
              Member_OK (O, T, R, S1, F1, L1, S2, F2, L2,
                         F1.Ev (I).Reads (Rd).Q)));
      pragma Assert
        (for all Rd in Read_Ix =>
           Read_OK (T, S1, F1.Ev (I).Reads (Rd))
           = Read_OK (T, S2, F2.Ev (I).Reads (Rd)));
   end App_Agree;

   function Apps_Eq
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; S2 : Selection; F2 : Facts)
      return Boolean
   is
     (for all I in Ev_Ix =>
        (if Ev_In (R, F1, F2, I) then
           Applies (O, T, S1, F1, I) = Applies (O, T, S2, F2, I)
           and then F1.Ev (I) = F2.Ev (I)));

   procedure Apps_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View)
   with
     Pre  => Agree (O, T, R, S1, F1, L1, S2, F2, L2),
     Post => Apps_Eq (O, T, R, S1, F1, S2, F2);

   procedure Apps_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View) is
   begin
      for I in Ev_Ix loop
         if Ev_In (R, F1, F2, I) then
            App_Agree (O, T, R, S1, F1, L1, S2, F2, L2, I);
         end if;
         pragma Loop_Invariant
           (for all K in Ev_Ix range Ev_Ix'First .. I =>
              (if Ev_In (R, F1, F2, K) then
                 Applies (O, T, S1, F1, K) = Applies (O, T, S2, F2, K)
                 and then F1.Ev (K) = F2.Ev (K)));
      end loop;
   end Apps_Agree;

   procedure Own_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; P : Id; D : Dim)
   with
     Pre  => Agree (O, T, R, S1, F1, L1, S2, F2, L2) and then R (P)
             and then Apps_Eq (O, T, R, S1, F1, S2, F2),
     Post => Own_Warrant (O, T, S1, F1, P, D)
             = Own_Warrant (O, T, S2, F2, P, D);

   procedure Own_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; P : Id; D : Dim) is
   begin
      pragma Assert (Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, P));
      pragma Assert
        (for all Cr in Crit =>
           Has_Holds (O, T, S1, F1, P, D, Cr)
           = Has_Holds (O, T, S2, F2, P, D, Cr));
      --  Accept decisions about P are the same rows, and their plain
      --  conditions read pieces of R only.
      pragma Assert
        (for all J in Dec_Ix =>
           (if (F1.Dec (J).Present and then F1.Dec (J).What = Admit
                and then F1.Dec (J).P = P)
              or else (F2.Dec (J).Present and then F2.Dec (J).What = Admit
                       and then F2.Dec (J).P = P)
            then F1.Dec (J) = F2.Dec (J)
                 and then Dec_Closed (R, F1.Dec (J))));
      pragma Assert
        (for all J in Dec_Ix =>
           (if F1.Dec (J).Present and then F1.Dec (J).What = Admit
              and then F1.Dec (J).P = P
            then
              (for all K in Cond_Ix =>
                 (if F1.Dec (J).Conds (K).What /= None then
                    Member_OK (O, T, R, S1, F1, L1, S2, F2, L2,
                               F1.Dec (J).Conds (K).P)))));
      pragma Assert
        (for all J in Dec_Ix =>
           (if F1.Dec (J).Present and then F1.Dec (J).What = Admit
              and then F1.Dec (J).P = P
            then
              (for all K in Cond_Ix =>
                 Plain_True (T, S1, F1.Dec (J).Conds (K))
                 = Plain_True (T, S2, F2.Dec (J).Conds (K)))));
      pragma Assert
        (Accepted (T, S1, F1, P, D) = Accepted (T, S2, F2, P, D));
   end Own_Agree;

   procedure Cap_Step_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; E1, E2 : Warrant_Table)
   with
     Pre  => Agree (O, T, R, S1, F1, L1, S2, F2, L2)
             and then Reg_Tab (R, E1, E2),
     Post => Reg_Tab (R, Cap_Step (O, T, S1, E1), Cap_Step (O, T, S2, E2));

   procedure Cap_Step_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; E1, E2 : Warrant_Table)
   is
   begin
      for P in Id loop
         if R (P) then
            pragma Assert (Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, P));
            pragma Assert
              (for all I in Edge_Ix =>
                 Edge (O, T, S1, P, I) = Edge (O, T, S2, P, I));
            pragma Assert
              (for all I in Edge_Ix => (for all D in Dim =>
                 (if Caps_Along (O, T, S1, P, I, D) then
                    Member_OK (O, T, R, S1, F1, L1, S2, F2, L2,
                               Edge (O, T, S1, P, I).Target))));
            pragma Assert
              (for all I in Edge_Ix => (for all D in Dim =>
                 Lower (O, T, S1, E1, P, D, I)
                 = Lower (O, T, S2, E2, P, D, I)));
         end if;
         pragma Loop_Invariant
           (for all Q in Id range Id'First .. P =>
              (if R (Q) then
                 (for all D in Dim =>
                    Cap_Step (O, T, S1, E1) (Q, D)
                    = Cap_Step (O, T, S2, E2) (Q, D))));
      end loop;
   end Cap_Step_Agree;

   procedure Cap_Iter_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; E1, E2 : Warrant_Table;
      N : Natural)
   with
     Subprogram_Variant => (Decreases => N),
     Pre  => Agree (O, T, R, S1, F1, L1, S2, F2, L2)
             and then Reg_Tab (R, E1, E2),
     Post => Reg_Tab (R, Cap_Iter (O, T, S1, E1, N),
                      Cap_Iter (O, T, S2, E2, N));

   procedure Cap_Iter_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; E1, E2 : Warrant_Table;
      N : Natural) is
   begin
      if N > 0 then
         Cap_Step_Agree (O, T, R, S1, F1, L1, S2, F2, L2, E1, E2);
         Cap_Iter_Agree
           (O, T, R, S1, F1, L1, S2, F2, L2,
            Cap_Step (O, T, S1, E1), Cap_Step (O, T, S2, E2), N - 1);
      end if;
   end Cap_Iter_Agree;

   procedure Deep_Step_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; D1, D2 : Id_Set)
   with
     Pre  => Agree (O, T, R, S1, F1, L1, S2, F2, L2)
             and then Reg_Eq (R, D1, D2),
     Post => Reg_Eq (R, Deep_Step (O, T, S1, D1), Deep_Step (O, T, S2, D2));

   procedure Deep_Step_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; D1, D2 : Id_Set) is
   begin
      for P in Id loop
         if R (P) then
            pragma Assert (Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, P));
            pragma Assert
              (for all I in Edge_Ix =>
                 Edge (O, T, S1, P, I) = Edge (O, T, S2, P, I));
            pragma Assert
              (for all I in Edge_Ix => (for all D in Dim =>
                 (if Caps_Along (O, T, S1, P, I, D) then
                    Member_OK (O, T, R, S1, F1, L1, S2, F2, L2,
                               Edge (O, T, S1, P, I).Target))));
            pragma Assert
              (for all I in Edge_Ix => (for all D in Dim =>
                 (Caps_Along (O, T, S1, P, I, D)
                  and then S1 (Edge (O, T, S1, P, I).Target).Selected
                  and then D1 (Edge (O, T, S1, P, I).Target))
                 =
                 (Caps_Along (O, T, S2, P, I, D)
                  and then S2 (Edge (O, T, S2, P, I).Target).Selected
                  and then D2 (Edge (O, T, S2, P, I).Target))));
            pragma Assert
              (Deep_Step (O, T, S1, D1) (P) = Deep_Step (O, T, S2, D2) (P));
         end if;
         pragma Loop_Invariant
           (for all Q in Id range Id'First .. P =>
              (if R (Q) then
                 Deep_Step (O, T, S1, D1) (Q) = Deep_Step (O, T, S2, D2) (Q)));
      end loop;
   end Deep_Step_Agree;

   procedure Deep_Iter_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; D1, D2 : Id_Set;
      N : Natural)
   with
     Subprogram_Variant => (Decreases => N),
     Pre  => Agree (O, T, R, S1, F1, L1, S2, F2, L2)
             and then Reg_Eq (R, D1, D2),
     Post => Reg_Eq (R, Deep_Iter (O, T, S1, D1, N),
                     Deep_Iter (O, T, S2, D2, N));

   procedure Deep_Iter_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; D1, D2 : Id_Set;
      N : Natural) is
   begin
      if N > 0 then
         Deep_Step_Agree (O, T, R, S1, F1, L1, S2, F2, L2, D1, D2);
         Deep_Iter_Agree
           (O, T, R, S1, F1, L1, S2, F2, L2,
            Deep_Step (O, T, S1, D1), Deep_Step (O, T, S2, D2), N - 1);
      end if;
   end Deep_Iter_Agree;

   function Ctx_Eq
     (R : Id_Set; F1, F2 : Facts; C1, C2 : Context) return Boolean
   is
     ((for all I in Ev_Ix =>
         (if Ev_In (R, F1, F2, I) then
            C1.App (I) = C2.App (I) and then F1.Ev (I) = F2.Ev (I)))
      and then Reg_Tab (R, C1.Own, C2.Own)
      and then Reg_Tab (R, C1.Eff, C2.Eff)
      and then Reg_Eq (R, C1.Cyc, C2.Cyc));

   procedure Ctx_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View)
   with
     Pre  => Agree (O, T, R, S1, F1, L1, S2, F2, L2),
     Post => Ctx_Eq (R, F1, F2, Derive (O, T, S1, F1), Derive (O, T, S2, F2));

   procedure Ctx_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View)
   is
      C1 : constant Context := Derive (O, T, S1, F1);
      C2 : constant Context := Derive (O, T, S2, F2);
   begin
      Apps_Agree (O, T, R, S1, F1, L1, S2, F2, L2);
      for P in Id loop
         for D in Dim loop
            if R (P) then
               Own_Agree (O, T, R, S1, F1, L1, S2, F2, L2, P, D);
            end if;
            pragma Loop_Invariant
              (for all D2 in Dim range Dim'First .. D =>
                 (if R (P) then C1.Own (P, D2) = C2.Own (P, D2)));
         end loop;
         pragma Loop_Invariant
           (for all Q in Id range Id'First .. P =>
              (if R (Q) then
                 (for all D2 in Dim => C1.Own (Q, D2) = C2.Own (Q, D2))));
      end loop;
      pragma Assert (Reg_Tab (R, C1.Own, C2.Own));
      Cap_Iter_Agree
        (O, T, R, S1, F1, L1, S2, F2, L2, C1.Own, C2.Own, Cap_Rounds);
      pragma Assert (Reg_Tab (R, C1.Eff, C2.Eff));
      pragma Assert
        (for all P in Id =>
           (if R (P) then
              Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, P)));
      pragma Assert (Reg_Eq (R, Selected_Set (S1), Selected_Set (S2)));
      Deep_Iter_Agree
        (O, T, R, S1, F1, L1, S2, F2, L2,
         Selected_Set (S1), Selected_Set (S2), 5);
      pragma Assert (Reg_Eq (R, C1.Cyc, C2.Cyc));
   end Ctx_Agree;

   -------------------------------------------------------------------
   --  Decisions, instances
   -------------------------------------------------------------------

   procedure Dec_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; J : Dec_Ix)
   with
     Pre  => Agree (O, T, R, S1, F1, L1, S2, F2, L2)
             and then Ctx_Eq (R, F1, F2, C1, C2)
             and then Reg_Eq (R, X1, X2)
             and then F1.Dec (J) = F2.Dec (J)
             and then Dec_Closed (R, F1.Dec (J)),
     Post => Dec_Holds (T, S1, F1, C1, X1, J)
             = Dec_Holds (T, S2, F2, C2, X2, J);

   procedure Dec_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; J : Dec_Ix) is
   begin
      pragma Assert
        (for all K in Cond_Ix =>
           (if F1.Dec (J).Conds (K).What /= None then
              Member_OK (O, T, R, S1, F1, L1, S2, F2, L2,
                         F1.Dec (J).Conds (K).P)));
      pragma Assert
        (for all K in Cond_Ix =>
           Cond_True (T, S1, C1, X1, F1.Dec (J).Conds (K))
           = Cond_True (T, S2, C2, X2, F2.Dec (J).Conds (K)));
      if F1.Dec (J).What in Admit | Affirm then
         pragma Assert
           (Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, F1.Dec (J).P));
      end if;
   end Dec_Agree;

   --  Every decision an instance about a piece of R can read holds in
   --  one state exactly when it holds in the other: those about a
   --  piece of R, and those a piece of R reports.
   function Decs_Eq
     (T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; S2 : Selection; F2 : Facts;
      C1, C2 : Context; X1, X2 : Id_Set) return Boolean
   is
     ((for all J in Dec_Ix =>
         (if Dec_In (R, F1, F2, J) then
            F1.Dec (J) = F2.Dec (J)
            and then Dec_Holds (T, S1, F1, C1, X1, J)
                     = Dec_Holds (T, S2, F2, C2, X2, J)))
      and then
      (for all P in Id =>
         (if R (P) and then (S1 (P).Selected or else S1 (P).Asserted)
            and then Sel (T, S1, P).Reports.Present
          then
            Dec_Holds (T, S1, F1, C1, X1, Sel (T, S1, P).Reports.Dec)
            = Dec_Holds (T, S2, F2, C2, X2, Sel (T, S1, P).Reports.Dec))));

   procedure Decs_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set)
   with
     Pre  => Agree (O, T, R, S1, F1, L1, S2, F2, L2)
             and then Ctx_Eq (R, F1, F2, C1, C2)
             and then Reg_Eq (R, X1, X2),
     Post => Decs_Eq (T, R, S1, F1, S2, F2, C1, C2, X1, X2);

   procedure Decs_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set) is
   begin
      for J in Dec_Ix loop
         if Dec_In (R, F1, F2, J) then
            declare
               P : constant Id :=
                 (if F1.Dec (J).Present and then F1.Dec (J).What /= Set_Aside
                    and then R (About (F1.Dec (J)))
                  then About (F1.Dec (J)) else About (F2.Dec (J)));
            begin
               pragma Assert
                 (Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, P));
               pragma Assert (F1.Dec (J) = F2.Dec (J));
               pragma Assert (Dec_Closed (R, F1.Dec (J)));
            end;
            Dec_Agree (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2, J);
         end if;
         pragma Loop_Invariant
           (for all K in Dec_Ix range Dec_Ix'First .. J =>
              (if Dec_In (R, F1, F2, K) then
                 F1.Dec (K) = F2.Dec (K)
                 and then Dec_Holds (T, S1, F1, C1, X1, K)
                          = Dec_Holds (T, S2, F2, C2, X2, K)));
      end loop;
      for P in Id loop
         if R (P) and then (S1 (P).Selected or else S1 (P).Asserted)
           and then Sel (T, S1, P).Reports.Present
         then
            pragma Assert (Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, P));
            Dec_Agree (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2,
                       Sel (T, S1, P).Reports.Dec);
         end if;
         pragma Loop_Invariant
           (for all Q in Id range Id'First .. P =>
              (if R (Q) and then (S1 (Q).Selected or else S1 (Q).Asserted)
                 and then Sel (T, S1, Q).Reports.Present
               then
                 Dec_Holds (T, S1, F1, C1, X1, Sel (T, S1, Q).Reports.Dec)
                 = Dec_Holds (T, S2, F2, C2, X2,
                              Sel (T, S1, Q).Reports.Dec)));
      end loop;
   end Decs_Agree;

   --  A context says an evidence fact applies only if it is there.
   function App_WF (F1, F2 : Facts; C1, C2 : Context) return Boolean is
     (for all I in Ev_Ix =>
        (if C1.App (I) then F1.Ev (I).Present)
        and then (if C2.App (I) then F2.Ev (I).Present));

   function Ready
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set) return Boolean
   is
     (Agree (O, T, R, S1, F1, L1, S2, F2, L2)
      and then Ctx_Eq (R, F1, F2, C1, C2)
      and then App_WF (F1, F2, C1, C2)
      and then Reg_Eq (R, X1, X2)
      and then Decs_Eq (T, R, S1, F1, S2, F2, C1, C2, X1, X2));

   --  P at its selected version has been affirmed against Q: the
   --  same in both states, for P and Q in the region.
   procedure Affirmed_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; P, Q : Id; Lv : Relies)
   with
     Pre  => Ready (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2)
             and then R (P) and then R (Q),
     Post => Affirmed (T, S1, F1, C1, X1, P, Q, Lv)
             = Affirmed (T, S2, F2, C2, X2, P, Q, Lv);

   procedure Affirmed_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; P, Q : Id; Lv : Relies) is
   begin
      pragma Assert (Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, Q));
      pragma Assert
        (for all J in Dec_Ix =>
           (if F1.Dec (J).What = Affirm and then F1.Dec (J).P = P
              and then Dec_Holds (T, S1, F1, C1, X1, J)
            then Dec_In (R, F1, F2, J)));
      pragma Assert
        (for all J in Dec_Ix =>
           (if F2.Dec (J).What = Affirm and then F2.Dec (J).P = P
              and then Dec_Holds (T, S2, F2, C2, X2, J)
            then Dec_In (R, F1, F2, J)));
      pragma Assert
        (for all J in Dec_Ix =>
           (F1.Dec (J).What = Affirm and then F1.Dec (J).P = P
            and then F1.Dec (J).Q = Q
            and then Dec_Holds (T, S1, F1, C1, X1, J)
            and then Agrees (T, S1, Q, F1.Dec (J).QV, F1.Dec (J).QSame, Lv))
           =
           (F2.Dec (J).What = Affirm and then F2.Dec (J).P = P
            and then F2.Dec (J).Q = Q
            and then Dec_Holds (T, S2, F2, C2, X2, J)
            and then Agrees (T, S2, Q, F2.Dec (J).QV, F2.Dec (J).QSame, Lv)));
   end Affirmed_Frame;

   --  The evidence about P: the same rows, applying in the same cases.
   function Ev_Same
     (F1, F2 : Facts; C1, C2 : Context; P : Id) return Boolean
   is
     (for all I in Ev_Ix =>
        (C1.App (I) and then F1.Ev (I).P = P)
        = (C2.App (I) and then F2.Ev (I).P = P)
        and then
        (if C1.App (I) and then F1.Ev (I).P = P
         then F1.Ev (I) = F2.Ev (I)));

   procedure Ev_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; P : Id)
   with
     Pre  => Ready (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2)
             and then R (P),
     Post => Ev_Same (F1, F2, C1, C2, P);

   procedure Ev_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; P : Id) is
   begin
      pragma Assert
        (for all I in Ev_Ix =>
           (if (C1.App (I) and then F1.Ev (I).P = P)
              or else (C2.App (I) and then F2.Ev (I).P = P)
            then Ev_In (R, F1, F2, I)));
   end Ev_Frame;

   --  Decisions of kind W about P: the same rows, holding in the same
   --  cases.
   function Decs_Same
     (T : Version_Table; S1 : Selection; F1 : Facts;
      S2 : Selection; F2 : Facts; C1, C2 : Context; X1, X2 : Id_Set;
      P : Id) return Boolean
   is
     (for all J in Dec_Ix =>
        (if (F1.Dec (J).What /= Set_Aside and then About (F1.Dec (J)) = P
             and then Dec_Holds (T, S1, F1, C1, X1, J))
           or else
           (F2.Dec (J).What /= Set_Aside and then About (F2.Dec (J)) = P
             and then Dec_Holds (T, S2, F2, C2, X2, J))
         then
           F1.Dec (J) = F2.Dec (J)
           and then Dec_Holds (T, S1, F1, C1, X1, J)
           and then Dec_Holds (T, S2, F2, C2, X2, J)));

   procedure Decs_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; P : Id)
   with
     Pre  => Ready (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2)
             and then R (P),
     Post => Decs_Same (T, S1, F1, S2, F2, C1, C2, X1, X2, P);

   procedure Decs_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; P : Id) is
   begin
      pragma Assert
        (for all J in Dec_Ix =>
           (if (F1.Dec (J).What /= Set_Aside and then About (F1.Dec (J)) = P
                and then Dec_Holds (T, S1, F1, C1, X1, J))
              or else
              (F2.Dec (J).What /= Set_Aside and then About (F2.Dec (J)) = P
                and then Dec_Holds (T, S2, F2, C2, X2, J))
            then Dec_In (R, F1, F2, J)));
   end Decs_Frame;

   procedure Edge_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; P : Id; I : Edge_Ix)
   with
     Pre  => Ready (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2)
             and then R (P) and then S1 (P).Asserted,
     Post => V_C3_Resolve (O, T, S1, P, I) = V_C3_Resolve (O, T, S2, P, I)
             and then V_C4 (O, T, S1, F1, L1, C1, X1, P, I)
                      = V_C4 (O, T, S2, F2, L2, C2, X2, P, I)
             and then V_C5_Rests (O, T, S1, X1, P, I)
                      = V_C5_Rests (O, T, S2, X2, P, I)
             and then V_C8_Need (O, T, S1, C1, P, I)
                      = V_C8_Need (O, T, S2, C2, P, I);

   procedure Edge_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; P : Id; I : Edge_Ix)
   is
      E : constant Ref := Edge (O, T, S1, P, I);
   begin
      pragma Assert (Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, P));
      pragma Assert (S1 (P) = S2 (P));
      pragma Assert (Edge (O, T, S2, P, I) = E);
      if E.Present then
         pragma Assert
           (R (E.Target)
            or else (Light (O, E) and then Weak (S1, S2, E.Target)));
         if R (E.Target) then
            pragma Assert
              (Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, E.Target));
            Affirmed_Frame
              (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2,
               P, E.Target, O.RK (E.K).Relies_On);
            pragma Assert
              (Written_Against (O, T, S1, L1, P, I)
               = Written_Against (O, T, S2, L2, P, I));
         end if;
      end if;
      pragma Assert
        (V_C3_Resolve (O, T, S1, P, I) = V_C3_Resolve (O, T, S2, P, I));
      pragma Assert
        (V_C4 (O, T, S1, F1, L1, C1, X1, P, I)
         = V_C4 (O, T, S2, F2, L2, C2, X2, P, I));
      pragma Assert
        (V_C5_Rests (O, T, S1, X1, P, I) = V_C5_Rests (O, T, S2, X2, P, I));
      pragma Assert
        (V_C8_Need (O, T, S1, C1, P, I) = V_C8_Need (O, T, S2, C2, P, I));
   end Edge_Frame;

   function Slots_Same
     (O : Ontology; T : Version_Table;
      S1 : Selection; F1 : Facts; S2 : Selection; F2 : Facts;
      C1, C2 : Context; X1, X2 : Id_Set; P : Id) return Boolean
   is
     (for all Sl in Slot_Ix =>
        V_C1_Shape (O, T, S1, P, Sl) = V_C1_Shape (O, T, S2, P, Sl)
        and then V_C8_Slot (O, T, S1, F1, C1, X1, P, Sl)
                 = V_C8_Slot (O, T, S2, F2, C2, X2, P, Sl)
        and then
          (for all Sb in Slot_Ix =>
             V_C2 (O, T, S1, F1, C1, X1, P, Sl, Sb)
             = V_C2 (O, T, S2, F2, C2, X2, P, Sl, Sb)));

   procedure Slots_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; P : Id)
   with
     Pre  => Ready (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2)
             and then R (P) and then S1 (P).Asserted,
     Post => Slots_Same (O, T, S1, F1, S2, F2, C1, C2, X1, X2, P);

   procedure Slots_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; P : Id)
   is
      V : constant Version := Sel (T, S1, P);
   begin
      pragma Assert (Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, P));
      pragma Assert (S1 (P) = S2 (P));
      pragma Assert (Sel (T, S2, P) = V);
      Decs_Frame (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2, P);
      --  Slots: C1, C8 (slot), C2.
      for Sl in Slot_Ix loop
         pragma Assert
           (Promised (T, S1, F1, C1, X1, P, Sl)
            = Promised (T, S2, F2, C2, X2, P, Sl));
         pragma Assert
           (if V.Slots (Sl).State /= Empty then
              Weak (S1, S2, V.Slots (Sl).Filler)
              or else Member_OK (O, T, R, S1, F1, L1, S2, F2, L2,
                                 V.Slots (Sl).Filler));
         pragma Assert
           (V_C8_Slot (O, T, S1, F1, C1, X1, P, Sl)
            = V_C8_Slot (O, T, S2, F2, C2, X2, P, Sl));
         pragma Assert
           (V_C1_Shape (O, T, S1, P, Sl) = V_C1_Shape (O, T, S2, P, Sl));
         for Sb in Slot_Ix loop
            if O.Kinds (V.K).Deps (Sl, Sb)
              and then V.Slots (Sl).State /= Empty
              and then V.Slots (Sb).State /= Empty
            then
               pragma Assert (not No_Deps (O.Kinds (V.K), Sl));
               pragma Assert (not No_Deps (O.Kinds (V.K), Sb));
               pragma Assert (R (V.Slots (Sl).Filler));
               pragma Assert (R (V.Slots (Sb).Filler));
               Affirmed_Frame
                 (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2,
                  V.Slots (Sl).Filler, V.Slots (Sb).Filler, Everything);
               Ev_Frame (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2,
                         V.Slots (Sl).Filler);
               pragma Assert
                 (Member_OK (O, T, R, S1, F1, L1, S2, F2, L2,
                             V.Slots (Sl).Filler));
               pragma Assert
                 (Member_OK (O, T, R, S1, F1, L1, S2, F2, L2,
                             V.Slots (Sb).Filler));
               pragma Assert
                 (Read_Together (F1, C1, V.Slots (Sl).Filler,
                                 V.Slots (Sb).Filler)
                  = Read_Together (F2, C2, V.Slots (Sl).Filler,
                                   V.Slots (Sb).Filler));
            end if;
            pragma Assert
              (V_C2 (O, T, S1, F1, C1, X1, P, Sl, Sb)
               = V_C2 (O, T, S2, F2, C2, X2, P, Sl, Sb));
            pragma Loop_Invariant
              (for all B2 in Slot_Ix range Slot_Ix'First .. Sb =>
                 V_C2 (O, T, S1, F1, C1, X1, P, Sl, B2)
                 = V_C2 (O, T, S2, F2, C2, X2, P, Sl, B2));
         end loop;
         pragma Loop_Invariant
           (for all A2 in Slot_Ix range Slot_Ix'First .. Sl =>
              V_C1_Shape (O, T, S1, P, A2) = V_C1_Shape (O, T, S2, P, A2)
              and then V_C8_Slot (O, T, S1, F1, C1, X1, P, A2)
                       = V_C8_Slot (O, T, S2, F2, C2, X2, P, A2)
              and then
                (for all B2 in Slot_Ix =>
                   V_C2 (O, T, S1, F1, C1, X1, P, A2, B2)
                   = V_C2 (O, T, S2, F2, C2, X2, P, A2, B2)));
      end loop;
   end Slots_Frame;

   --  What P holds is held elsewhere: the same in both states.
   procedure Held_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; P : Id; Sl : Slot_Ix)
   with
     Pre  => Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, P),
     Post => V_C1_Held (T, S1, P, Sl) = V_C1_Held (T, S2, P, Sl);

   procedure Held_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; P : Id; Sl : Slot_Ix) is
   begin
      pragma Assert
        (Held_Elsewhere (T, S1, P, Sl) = Held_Elsewhere (T, S2, P, Sl));
   end Held_Frame;

   --  One lemma per kind of instance.
   procedure Kind_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; P : Id)
   with
     Pre  => Ready (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2)
             and then R (P) and then S1 (P).Asserted,
     Post =>
       Slots_Same (O, T, S1, F1, S2, F2, C1, C2, X1, X2, P)
       and then
       (for all I in Edge_Ix =>
          V_C3_Resolve (O, T, S1, P, I) = V_C3_Resolve (O, T, S2, P, I)
          and then V_C4 (O, T, S1, F1, L1, C1, X1, P, I)
                   = V_C4 (O, T, S2, F2, L2, C2, X2, P, I)
          and then V_C5_Rests (O, T, S1, X1, P, I)
                   = V_C5_Rests (O, T, S2, X2, P, I)
          and then V_C8_Need (O, T, S1, C1, P, I)
                   = V_C8_Need (O, T, S2, C2, P, I))
       and then
       (for all Rt in Id => (for all D in Dim =>
          V_C5_Asks (O, T, S1, L1, C1, P, Rt, D)
          = V_C5_Asks (O, T, S2, L2, C2, P, Rt, D)))
       and then
       (for all I in Ev_Ix =>
          V_C6_Fails (F1, C1, P, I) = V_C6_Fails (F2, C2, P, I))
       and then
       (for all D in Dim => (for all Cr in Crit =>
          V_C6_Guard (L1, P, D, Cr) = V_C6_Guard (L2, P, D, Cr)))
       and then V_C7_Claim (T, S1, C1, P) = V_C7_Claim (T, S2, C2, P)
       and then V_C7_Report (T, S1, F1, C1, X1, P)
                = V_C7_Report (T, S2, F2, C2, X2, P)
       and then
       (for all J in Dec_Ix =>
          V_C9 (T, S1, F1, C1, X1, P, J) = V_C9 (T, S2, F2, C2, X2, P, J))
       and then C1.Cyc (P) = C2.Cyc (P)
       and then S1 (P).Asserted = S2 (P).Asserted;

   procedure Kind_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; P : Id)
   is
      V : constant Version := Sel (T, S1, P);
   begin
      pragma Assert (Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, P));
      pragma Assert (S1 (P) = S2 (P));
      pragma Assert (Sel (T, S2, P) = V);
      Ev_Frame (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2, P);
      Decs_Frame (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2, P);
      pragma Assert
        (for all I in Edge_Ix =>
           Edge (O, T, S1, P, I) = Edge (O, T, S2, P, I));

      Slots_Frame (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2, P);

      --  Edges: C3, C4, C5 (rests), C8 (need).
      for I in Edge_Ix loop
         Edge_Frame (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2, P, I);
         pragma Loop_Invariant
           (for all I2 in Edge_Ix range Edge_Ix'First .. I =>
              V_C3_Resolve (O, T, S1, P, I2) = V_C3_Resolve (O, T, S2, P, I2)
              and then V_C4 (O, T, S1, F1, L1, C1, X1, P, I2)
                       = V_C4 (O, T, S2, F2, L2, C2, X2, P, I2)
              and then V_C5_Rests (O, T, S1, X1, P, I2)
                       = V_C5_Rests (O, T, S2, X2, P, I2)
              and then V_C8_Need (O, T, S1, C1, P, I2)
                       = V_C8_Need (O, T, S2, C2, P, I2));
      end loop;

      pragma Assert
        (for all Rt in Id => (for all D in Dim =>
           V_C5_Asks (O, T, S1, L1, C1, P, Rt, D)
           = V_C5_Asks (O, T, S2, L2, C2, P, Rt, D)));
      pragma Assert
        (for all I in Ev_Ix =>
           V_C6_Fails (F1, C1, P, I) = V_C6_Fails (F2, C2, P, I));
      pragma Assert (V_C7_Claim (T, S1, C1, P) = V_C7_Claim (T, S2, C2, P));
      pragma Assert
        (V_C7_Report (T, S1, F1, C1, X1, P)
         = V_C7_Report (T, S2, F2, C2, X2, P));
      pragma Assert
        (for all J in Dec_Ix =>
           V_C9 (T, S1, F1, C1, X1, P, J) = V_C9 (T, S2, F2, C2, X2, P, J));
      pragma Assert (C1.Cyc (P) = C2.Cyc (P));
   end Kind_Frame;

   procedure Inst_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; N : Instance)
   with
     Pre  => Ready (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2)
             and then R (N.P),
     Post => Violated (O, T, S1, F1, L1, C1, X1, N)
             = Violated (O, T, S2, F2, L2, C2, X2, N)
             and then Covered (T, S1, F1, C1, X1, N)
                      = Covered (T, S2, F2, C2, X2, N);

   procedure Inst_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; N : Instance) is
   begin
      pragma Assert (Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, N.P));
      if N.I in 1 .. 3 then
         Held_Frame (O, T, R, S1, F1, L1, S2, F2, L2, N.P, Slot_Ix (N.I));
      end if;
      pragma Assert (S1 (N.P) = S2 (N.P));
      if S1 (N.P).Asserted then
         Kind_Frame (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2, N.P);
      end if;
      Decs_Frame (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2, N.P);
      pragma Assert
        (Violated (O, T, S1, F1, L1, C1, X1, N)
         = Violated (O, T, S2, F2, L2, C2, X2, N));
      pragma Assert
        (for all J in Dec_Ix =>
           (F1.Dec (J).What = Waive and then F1.Dec (J).Inst = N
            and then Dec_Holds (T, S1, F1, C1, X1, J))
           = (F2.Dec (J).What = Waive and then F2.Dec (J).Inst = N
              and then Dec_Holds (T, S2, F2, C2, X2, J)));
   end Inst_Frame;

   procedure Row_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; K : Inst_Kind; P : Id; I : Sub)
   with
     Pre  => Ready (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2)
             and then R (P),
     Post => (for all J in Sub =>
                Violated (O, T, S1, F1, L1, C1, X1, (K, P, I, J))
                = Violated (O, T, S2, F2, L2, C2, X2, (K, P, I, J))
                and then Covered (T, S1, F1, C1, X1, (K, P, I, J))
                         = Covered (T, S2, F2, C2, X2, (K, P, I, J)));

   procedure Row_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; K : Inst_Kind; P : Id; I : Sub) is
   begin
      for J in Sub loop
         Inst_Frame (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2,
                     (K, P, I, J));
         pragma Loop_Invariant
           (for all J2 in Sub range Sub'First .. J =>
              Violated (O, T, S1, F1, L1, C1, X1, (K, P, I, J2))
              = Violated (O, T, S2, F2, L2, C2, X2, (K, P, I, J2))
              and then Covered (T, S1, F1, C1, X1, (K, P, I, J2))
                       = Covered (T, S2, F2, C2, X2, (K, P, I, J2)));
      end loop;
   end Row_Frame;

   procedure Kind_Rows_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; K : Inst_Kind; P : Id)
   with
     Pre  => Ready (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2)
             and then R (P),
     Post => (for all I in Sub => (for all J in Sub =>
                Violated (O, T, S1, F1, L1, C1, X1, (K, P, I, J))
                = Violated (O, T, S2, F2, L2, C2, X2, (K, P, I, J))
                and then Covered (T, S1, F1, C1, X1, (K, P, I, J))
                         = Covered (T, S2, F2, C2, X2, (K, P, I, J))));

   procedure Kind_Rows_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; K : Inst_Kind; P : Id) is
   begin
      for I in Sub loop
         Row_Frame (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2, K, P, I);
         pragma Loop_Invariant
           (for all I2 in Sub range Sub'First .. I =>
              (for all J2 in Sub =>
                 Violated (O, T, S1, F1, L1, C1, X1, (K, P, I2, J2))
                 = Violated (O, T, S2, F2, L2, C2, X2, (K, P, I2, J2))
                 and then Covered (T, S1, F1, C1, X1, (K, P, I2, J2))
                          = Covered (T, S2, F2, C2, X2, (K, P, I2, J2))));
      end loop;
   end Kind_Rows_Frame;

   procedure Own_OK_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; P : Id)
   with
     Pre  => Ready (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2)
             and then R (P),
     Post => Own_OK (O, T, S1, F1, L1, C1, X1, P)
             = Own_OK (O, T, S2, F2, L2, C2, X2, P);

   procedure Own_OK_Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; P : Id) is
   begin
      pragma Assert (Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, P));
      for K in Inst_Kind loop
         Kind_Rows_Frame
           (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2, K, P);
         pragma Loop_Invariant
           (for all K2 in Inst_Kind range Inst_Kind'First .. K =>
              (for all I2 in Sub =>
                 (for all J2 in Sub =>
                    Violated (O, T, S1, F1, L1, C1, X1, (K2, P, I2, J2))
                    = Violated (O, T, S2, F2, L2, C2, X2, (K2, P, I2, J2))
                    and then Covered (T, S1, F1, C1, X1, (K2, P, I2, J2))
                             = Covered (T, S2, F2, C2, X2,
                                        (K2, P, I2, J2)))));
      end loop;
   end Own_OK_Frame;

   -------------------------------------------------------------------
   --  The consistent sets agree on the region
   -------------------------------------------------------------------

   procedure Stepped_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set)
   with
     Pre  => Agree (O, T, R, S1, F1, L1, S2, F2, L2)
             and then Ctx_Eq (R, F1, F2, C1, C2)
             and then App_WF (F1, F2, C1, C2)
             and then Reg_Eq (R, X1, X2),
     Post => Reg_Eq (R, Stepped (O, T, S1, F1, L1, C1, X1),
                     Stepped (O, T, S2, F2, L2, C2, X2));

   procedure Stepped_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set) is
   begin
      Decs_Agree (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2);
      for P in Id loop
         if R (P) then
            Own_OK_Frame (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2, P);
         end if;
         pragma Loop_Invariant
           (for all Q in Id range Id'First .. P =>
              (if R (Q) then
                 Own_OK (O, T, S1, F1, L1, C1, X1, Q)
                 = Own_OK (O, T, S2, F2, L2, C2, X2, Q)));
      end loop;
   end Stepped_Agree;

   --  The two descents may stop at different rounds (one state may
   --  still be settling outside the region when the other is done).
   procedure Iter_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; N : Natural)
   with
     Subprogram_Variant => (Decreases => N),
     Pre  => Agree (O, T, R, S1, F1, L1, S2, F2, L2)
             and then Ctx_Eq (R, F1, F2, C1, C2)
             and then App_WF (F1, F2, C1, C2)
             and then Reg_Eq (R, X1, X2),
     Post => Reg_Eq (R, Iter (O, T, S1, F1, L1, C1, X1, N),
                     Iter (O, T, S2, F2, L2, C2, X2, N));

   procedure Iter_Agree
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View;
      C1, C2 : Context; X1, X2 : Id_Set; N : Natural)
   is
      Y1 : constant Id_Set := Stepped (O, T, S1, F1, L1, C1, X1);
      Y2 : constant Id_Set := Stepped (O, T, S2, F2, L2, C2, X2);
   begin
      if N = 0 then
         return;
      end if;
      Stepped_Agree (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2);
      pragma Assert (Reg_Eq (R, Y1, Y2));
      if Y1 = X1 and then Y2 = X2 then
         null;
      elsif Y1 = X1 then
         --  State 1 has stopped at X1; state 2 goes on from Y2, which
         --  agrees with X1 on the region.
         pragma Assert (Reg_Eq (R, X1, Y2));
         Iter_Agree (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, Y2, N - 1);
         pragma Assert (Iter (O, T, S1, F1, L1, C1, X1, N - 1) = X1);
      elsif Y2 = X2 then
         pragma Assert (Reg_Eq (R, Y1, X2));
         Iter_Agree (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, Y1, X2, N - 1);
         pragma Assert (Iter (O, T, S2, F2, L2, C2, X2, N - 1) = X2);
      else
         Iter_Agree (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, Y1, Y2, N - 1);
      end if;
   end Iter_Agree;

   -------------------------------------------------------------------
   --  The theorems
   -------------------------------------------------------------------

   procedure Frame
     (O : Ontology; T : Version_Table; R : Id_Set;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View; N : Instance)
   is
      C1 : constant Context := Derive (O, T, S1, F1);
      C2 : constant Context := Derive (O, T, S2, F2);
      X1 : constant Id_Set := Consistent (O, T, S1, F1, L1, C1);
      X2 : constant Id_Set := Consistent (O, T, S2, F2, L2, C2);
   begin
      Ctx_Agree (O, T, R, S1, F1, L1, S2, F2, L2);
      pragma Assert (App_WF (F1, F2, C1, C2));
      pragma Assert
        (for all P in Id =>
           (if R (P) then
              Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, P)));
      pragma Assert (Reg_Eq (R, Asserted_Set (S1), Asserted_Set (S2)));
      Iter_Agree (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2,
                  Asserted_Set (S1), Asserted_Set (S2), Rounds);
      pragma Assert (Reg_Eq (R, X1, X2));
      Decs_Agree (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2);
      Inst_Frame (O, T, R, S1, F1, L1, S2, F2, L2, C1, C2, X1, X2, N);
   end Frame;

   procedure Forks_Compose
     (O : Ontology; T : Version_Table;
      SA : Selection; FA : Facts; LA : Line_View;
      SB : Selection; FB : Facts; LB : Line_View;
      SM : Selection; FM : Facts; LM : Line_View; RA, RB : Id_Set) is
   begin
      for K in Inst_Kind loop
         for P in Id loop
            for I in Sub loop
               for J in Sub loop
                  if RA (P) then
                     Frame (O, T, RA, SA, FA, LA, SM, FM, LM, (K, P, I, J));
                  else
                     Frame (O, T, RB, SB, FB, LB, SM, FM, LM, (K, P, I, J));
                  end if;
                  pragma Loop_Invariant
                    (for all J2 in Sub range Sub'First .. J =>
                       not Uncovered (O, T, SM, FM, LM, (K, P, I, J2)));
               end loop;
               pragma Loop_Invariant
                 (for all I2 in Sub range Sub'First .. I =>
                    (for all J2 in Sub =>
                       not Uncovered (O, T, SM, FM, LM, (K, P, I2, J2))));
            end loop;
            pragma Loop_Invariant
              (for all P2 in Id range Id'First .. P =>
                 (for all I2 in Sub => (for all J2 in Sub =>
                    not Uncovered (O, T, SM, FM, LM, (K, P2, I2, J2)))));
         end loop;
         pragma Loop_Invariant
           (for all K2 in Inst_Kind range Inst_Kind'First .. K =>
              (for all P2 in Id => (for all I2 in Sub => (for all J2 in Sub =>
                 not Uncovered (O, T, SM, FM, LM, (K2, P2, I2, J2))))));
      end loop;
   end Forks_Compose;

   procedure Meeting_Is_Local
     (O : Ontology; T : Version_Table;
      SA : Selection; FA : Facts; LA : Line_View;
      SB : Selection; FB : Facts; LB : Line_View;
      SM : Selection; FM : Facts; LM : Line_View; RA, RB : Id_Set;
      N : Instance) is
   begin
      if RA (N.P) then
         Frame (O, T, RA, SA, FA, LA, SM, FM, LM, N);
         pragma Assert
           (not Uncovered (O, T, SA, FA, LA, (N.K, N.P, N.I, N.J)));
      end if;
      if RB (N.P) then
         Frame (O, T, RB, SB, FB, LB, SM, FM, LM, N);
         pragma Assert
           (not Uncovered (O, T, SB, FB, LB, (N.K, N.P, N.I, N.J)));
      end if;
   end Meeting_Is_Local;

end Vk.Merge;
