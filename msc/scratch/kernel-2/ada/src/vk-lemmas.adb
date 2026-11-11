package body Vk.Lemmas with SPARK_Mode => On is

   -------------------------------------------------------------------
   --  Decisions and instances are monotone in the consistent set
   -------------------------------------------------------------------

   procedure Dec_Mono
     (T : Version_Table; S : Selection; F : Facts; C : Context;
      Y, X : Id_Set; J : Dec_Ix)
   with
     Pre  => Stratified (F) and then Sub_Set (Y, X),
     Post => (if Dec_Holds (T, S, F, C, Y, J)
              then Dec_Holds (T, S, F, C, X, J))
             and then
             (if F.Dec (J).What not in Admit | Affirm
              then Dec_Holds (T, S, F, C, Y, J)
                   = Dec_Holds (T, S, F, C, X, J));

   procedure Dec_Mono
     (T : Version_Table; S : Selection; F : Facts; C : Context;
      Y, X : Id_Set; J : Dec_Ix) is
   begin
      pragma Assert
        (for all K in Cond_Ix =>
           (if Cond_True (T, S, C, Y, F.Dec (J).Conds (K))
            then Cond_True (T, S, C, X, F.Dec (J).Conds (K))));
      if F.Dec (J).Present and then F.Dec (J).What not in Admit | Affirm then
         pragma Assert
           (for all K in Cond_Ix =>
              F.Dec (J).Conds (K).What /= Asserted_Consistent);
         pragma Assert
           (for all K in Cond_Ix =>
              Cond_True (T, S, C, Y, F.Dec (J).Conds (K))
              = Cond_True (T, S, C, X, F.Dec (J).Conds (K)));
      end if;
   end Dec_Mono;

   --  All decisions at once, as one quantified fact.
   procedure Decs_Mono
     (T : Version_Table; S : Selection; F : Facts; C : Context;
      Y, X : Id_Set)
   with
     Pre  => Stratified (F) and then Sub_Set (Y, X),
     Post => (for all J in Dec_Ix =>
                (if Dec_Holds (T, S, F, C, Y, J)
                 then Dec_Holds (T, S, F, C, X, J))
                and then
                (if F.Dec (J).What not in Admit | Affirm
                 then Dec_Holds (T, S, F, C, Y, J)
                      = Dec_Holds (T, S, F, C, X, J)));

   procedure Decs_Mono
     (T : Version_Table; S : Selection; F : Facts; C : Context;
      Y, X : Id_Set) is
   begin
      for J in Dec_Ix loop
         Dec_Mono (T, S, F, C, Y, X, J);
         pragma Loop_Invariant
           (for all J2 in Dec_Ix range Dec_Ix'First .. J =>
              (if Dec_Holds (T, S, F, C, Y, J2)
               then Dec_Holds (T, S, F, C, X, J2))
              and then
              (if F.Dec (J2).What not in Admit | Affirm
               then Dec_Holds (T, S, F, C, Y, J2)
                    = Dec_Holds (T, S, F, C, X, J2)));
      end loop;
   end Decs_Mono;

   --  One instance: violated under the larger set => violated under
   --  the smaller; covered under the smaller => covered under the
   --  larger.
   procedure Inst_Mono
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; Y, X : Id_Set; N : Instance)
   with
     Pre  => Stratified (F) and then Sub_Set (Y, X),
     Post => (if Violated (O, T, S, F, C, X, N)
              then Violated (O, T, S, F, C, Y, N))
             and then
             (if Covered (T, S, F, C, Y, N)
              then Covered (T, S, F, C, X, N));

   procedure Inst_Mono
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; Y, X : Id_Set; N : Instance) is
   begin
      Decs_Mono (T, S, F, C, Y, X);
   end Inst_Mono;

   procedure Mono_X
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; Y, X : Id_Set; P : Id) is
   begin
      for K in Inst_Kind loop
         for I in Sub loop
            for J in Sub loop
               Inst_Mono (O, T, S, F, C, Y, X, (K, P, I, J));
               pragma Loop_Invariant
                 (for all J2 in Sub range Sub'First .. J =>
                    (if Violated (O, T, S, F, C, X, (K, P, I, J2))
                     then Violated (O, T, S, F, C, Y, (K, P, I, J2)))
                    and then
                    (if Covered (T, S, F, C, Y, (K, P, I, J2))
                     then Covered (T, S, F, C, X, (K, P, I, J2))));
            end loop;
            pragma Loop_Invariant
              (for all I2 in Sub range Sub'First .. I =>
                 (for all J2 in Sub =>
                    (if Violated (O, T, S, F, C, X, (K, P, I2, J2))
                     then Violated (O, T, S, F, C, Y, (K, P, I2, J2)))
                    and then
                    (if Covered (T, S, F, C, Y, (K, P, I2, J2))
                     then Covered (T, S, F, C, X, (K, P, I2, J2)))));
         end loop;
         pragma Loop_Invariant
           (for all K2 in Inst_Kind range Inst_Kind'First .. K =>
              (for all I2 in Sub =>
                 (for all J2 in Sub =>
                    (if Violated (O, T, S, F, C, X, (K2, P, I2, J2))
                     then Violated (O, T, S, F, C, Y, (K2, P, I2, J2)))
                    and then
                    (if Covered (T, S, F, C, Y, (K2, P, I2, J2))
                     then Covered (T, S, F, C, X, (K2, P, I2, J2))))));
      end loop;
   end Mono_X;

   -------------------------------------------------------------------
   --  The descent reaches a fixed point, and it is the greatest
   -------------------------------------------------------------------

   function Card (X : Id_Set) return Natural is
     ((if X (1) then 1 else 0) + (if X (2) then 1 else 0)
      + (if X (3) then 1 else 0) + (if X (4) then 1 else 0)
      + (if X (5) then 1 else 0));

   --  What has been dropped stays dropped.
   function Dropped
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; X : Id_Set) return Boolean
   is
     (for all P in Id =>
        (if not X (P) then not Own_OK (O, T, S, F, C, X, P)));

   --  Two sets with the same members: if one is a fixed point, so is
   --  the other. (Stated and proved through Mono_X both ways, because
   --  the provers do not get F (A) = F (B) from A = B on arrays.)
   procedure Fixed_Transfer
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; A, B : Id_Set)
   with
     Pre  => Stratified (F) and then Sub_Set (A, B) and then Sub_Set (B, A)
             and then Is_Fixed (O, T, S, F, C, B),
     Post => Is_Fixed (O, T, S, F, C, A);

   procedure Fixed_Transfer
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; A, B : Id_Set) is
   begin
      for P in Id loop
         Mono_X (O, T, S, F, C, A, B, P);
         Mono_X (O, T, S, F, C, B, A, P);
         pragma Loop_Invariant
           (for all Q in Id range Id'First .. P =>
              A (Q) = Own_OK (O, T, S, F, C, A, Q));
      end loop;
   end Fixed_Transfer;

   procedure Fixed_Rec
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; X : Id_Set; N : Natural)
   with
     Subprogram_Variant => (Decreases => N),
     Pre  => Stratified (F) and then Card (X) <= N
             and then Dropped (O, T, S, F, C, X),
     Post => Is_Fixed (O, T, S, F, C, Iter (O, T, S, F, C, X, N));

   procedure Fixed_Rec
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; X : Id_Set; N : Natural)
   is
      X2 : constant Id_Set := Stepped (O, T, S, F, C, X);
      R  : constant Id_Set := Iter (O, T, S, F, C, X, N);
   begin
      if X2 = X then
         pragma Assert (R = X);
         pragma Assert
           (for all P in Id => X (P) = Own_OK (O, T, S, F, C, X, P));
         pragma Assert (Is_Fixed (O, T, S, F, C, X));
         Fixed_Transfer (O, T, S, F, C, R, X);
      else
         pragma Assert (Sub_Set (X2, X));
         pragma Assert (for some P in Id => X (P) and then not X2 (P));
         pragma Assert (Card (X2) < Card (X));
         pragma Assert (N > 0);
         for P in Id loop
            Mono_X (O, T, S, F, C, X2, X, P);
            pragma Loop_Invariant
              (for all Q in Id range Id'First .. P =>
                 (if Own_OK (O, T, S, F, C, X2, Q)
                  then Own_OK (O, T, S, F, C, X, Q)));
         end loop;
         pragma Assert (Dropped (O, T, S, F, C, X2));
         Fixed_Rec (O, T, S, F, C, X2, N - 1);
         pragma Assert (R = Iter (O, T, S, F, C, X2, N - 1));
         Fixed_Transfer (O, T, S, F, C, R, Iter (O, T, S, F, C, X2, N - 1));
      end if;
   end Fixed_Rec;

   procedure Consistent_Is_Fixed
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context) is
   begin
      pragma Assert (Card (Asserted_Set (S)) <= Rounds);
      pragma Assert (Dropped (O, T, S, F, C, Asserted_Set (S)));
      Fixed_Rec (O, T, S, F, C, Asserted_Set (S), Rounds);
   end Consistent_Is_Fixed;

   procedure Greatest_Rec
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; Y, X : Id_Set; N : Natural)
   with
     Subprogram_Variant => (Decreases => N),
     Pre  => Stratified (F) and then Sub_Set (Y, X)
             and then (for all P in Id =>
                         (if Y (P) then Own_OK (O, T, S, F, C, Y, P))),
     Post => Sub_Set (Y, Iter (O, T, S, F, C, X, N));

   procedure Greatest_Rec
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; Y, X : Id_Set; N : Natural) is
   begin
      if N > 0 then
         for P in Id loop
            Mono_X (O, T, S, F, C, Y, X, P);
            pragma Loop_Invariant
              (for all Q in Id range Id'First .. P =>
                 (if Own_OK (O, T, S, F, C, Y, Q)
                  then Own_OK (O, T, S, F, C, X, Q)));
         end loop;
         pragma Assert (Sub_Set (Y, Stepped (O, T, S, F, C, X)));
         Greatest_Rec (O, T, S, F, C, Y, Stepped (O, T, S, F, C, X), N - 1);
      end if;
   end Greatest_Rec;

   procedure Consistent_Is_Greatest
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; Y : Id_Set) is
   begin
      pragma Assert (Sub_Set (Y, Asserted_Set (S)));
      Greatest_Rec (O, T, S, F, C, Y, Asserted_Set (S), Rounds);
   end Consistent_Is_Greatest;

   -------------------------------------------------------------------
   --  The cap
   -------------------------------------------------------------------

   procedure Cap_Unique
     (O : Ontology; T : Version_Table; S : Selection;
      Own, E1, E2 : Warrant_Table; D : Dim; Rk : Rank_Table) is
   begin
      for R in Rank loop
         for P in Id loop
            if Rk (P) = R and then S (P).Selected then
               pragma Assert
                 (for all I in Edge_Ix =>
                    (if Caps_Along (O, T, S, P, I, D) then
                       E1 (Edge (O, T, S, P, I).Target, D)
                       = E2 (Edge (O, T, S, P, I).Target, D)));
               pragma Assert (E1 (P, D) <= E2 (P, D));
               pragma Assert (E2 (P, D) <= E1 (P, D));
            end if;
            pragma Loop_Invariant
              (for all Q in Id =>
                 (if Rk (Q) < R then E1 (Q, D) = E2 (Q, D)));
            pragma Loop_Invariant
              (for all Q in Id range Id'First .. P =>
                 (if Rk (Q) = R then E1 (Q, D) = E2 (Q, D)));
         end loop;
         pragma Loop_Invariant
           (for all Q in Id => (if Rk (Q) <= R then E1 (Q, D) = E2 (Q, D)));
      end loop;
   end Cap_Unique;

   -------------------------------------------------------------------
   --  Q5
   -------------------------------------------------------------------

   procedure Defect_Stays
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      X : Id_Set; P : Id; I : Ev_Ix)
   is
      C : constant Context := Derive (O, T, S, F);
   begin
      pragma Assert (Guard (O, T, S, F, P, F.Ev (I).D, F.Ev (I).C));
      pragma Assert
        (not Has_Holds_C (F, C, P, F.Ev (I).D, F.Ev (I).C));
   end Defect_Stays;

   -------------------------------------------------------------------
   --  Q4
   -------------------------------------------------------------------

   --  How evidence fact I stands in the two worlds.
   function Ev_Rel
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      I : Ev_Ix) return Boolean
   is
     (Aside (O, T, S, F, I) = Aside (O, T, S, F2, I)
      and then (if Applies (O, T, S, F, I) then
                  Applies (O, T, S, F2, I)
                  and then F.Ev (I).P = F2.Ev (I).P
                  and then F.Ev (I).D = F2.Ev (I).D
                  and then F.Ev (I).C = F2.Ev (I).C
                  and then F.Ev (I).Result = F2.Ev (I).Result
                  and then F.Ev (I).Reads (1).Present
                           = F2.Ev (I).Reads (1).Present
                  and then F.Ev (I).Reads (2).Present
                           = F2.Ev (I).Reads (2).Present
                  and then F.Ev (I).Reads (1).Q = F2.Ev (I).Reads (1).Q
                  and then F.Ev (I).Reads (2).Q = F2.Ev (I).Reads (2).Q)
      and then (if F2.Ev (I).Present and then F2.Ev (I).Result /= Holds then
                  F.Ev (I) = F2.Ev (I)
                  and then Applies (O, T, S, F, I)
                           = Applies (O, T, S, F2, I))
      and then (if F.Ev (I).Present and then F.Ev (I).Result /= Holds then
                  F.Ev (I) = F2.Ev (I)));

   procedure Ev_Transfer
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      I : Ev_Ix)
   with
     Pre  => Good_Ext (F, F2),
     Post => Ev_Rel (O, T, S, F, F2, I);

   procedure Ev_Transfer
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      I : Ev_Ix) is
   begin
      pragma Assert
        (for all J in Dec_Ix =>
           (if F.Dec (J).Present and then F.Dec (J).What = Set_Aside
            then F.Dec (J) = F2.Dec (J)));
      pragma Assert
        (for all J in Dec_Ix =>
           (if F2.Dec (J).Present and then F2.Dec (J).What = Set_Aside
            then F.Dec (J) = F2.Dec (J)));
      pragma Assert (Aside (O, T, S, F, I) = Aside (O, T, S, F2, I));
      pragma Assert (Ev_Good (F.Ev (I), F2.Ev (I)));
      if F.Ev (I) = F2.Ev (I) then
         pragma Assert
           (Applies (O, T, S, F, I) = Applies (O, T, S, F2, I));
      elsif F.Ev (I).Present then
         pragma Assert
           (for all R in Read_Ix =>
              (if Read_OK (O, T, S, F.Ev (I).Reads (R))
               then Read_OK (O, T, S, F2.Ev (I).Reads (R))));
      end if;
   end Ev_Transfer;

   procedure Evs_Transfer
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts)
   with
     Pre  => Good_Ext (F, F2),
     Post => (for all I in Ev_Ix => Ev_Rel (O, T, S, F, F2, I));

   procedure Evs_Transfer
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts) is
   begin
      for I in Ev_Ix loop
         Ev_Transfer (O, T, S, F, F2, I);
         pragma Loop_Invariant
           (for all K in Ev_Ix range Ev_Ix'First .. I =>
              Ev_Rel (O, T, S, F, F2, K));
      end loop;
   end Evs_Transfer;

   function Table_Le (A, B : Warrant_Table) return Boolean is
     (for all P in Id => (for all D in Dim => A (P, D) <= B (P, D)));

   procedure Own_Mono
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      P : Id; D : Dim)
   with
     Pre  => Monotone (O)
             and then (for all I in Ev_Ix => Ev_Rel (O, T, S, F, F2, I)),
     Post => Own_Warrant (O, T, S, F, P, D)
             <= Own_Warrant (O, T, S, F2, P, D);

   procedure Own_Mono
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      P : Id; D : Dim) is
   begin
      pragma Assert
        (for all Cr in Crit =>
           (if Has_Holds (O, T, S, F, P, D, Cr)
            then Has_Holds (O, T, S, F2, P, D, Cr)));
   end Own_Mono;

   procedure Cap_Step_Mono
     (O : Ontology; T : Version_Table; S : Selection; E, E2 : Warrant_Table)
   with
     Pre  => Table_Le (E, E2),
     Post => Table_Le (Cap_Step (O, T, S, E), Cap_Step (O, T, S, E2));

   procedure Cap_Step_Mono
     (O : Ontology; T : Version_Table; S : Selection; E, E2 : Warrant_Table)
   is
   begin
      pragma Assert
        (for all P in Id => (for all D in Dim => (for all I in Edge_Ix =>
           Lower (O, T, S, E, P, D, I) <= Lower (O, T, S, E2, P, D, I))));
   end Cap_Step_Mono;

   procedure Cap_Iter_Mono
     (O : Ontology; T : Version_Table; S : Selection; E, E2 : Warrant_Table;
      N : Natural)
   with
     Subprogram_Variant => (Decreases => N),
     Pre  => Table_Le (E, E2),
     Post => Table_Le (Cap_Iter (O, T, S, E, N), Cap_Iter (O, T, S, E2, N));

   procedure Cap_Iter_Mono
     (O : Ontology; T : Version_Table; S : Selection; E, E2 : Warrant_Table;
      N : Natural) is
   begin
      if N > 0 then
         Cap_Step_Mono (O, T, S, E, E2);
         Cap_Iter_Mono
           (O, T, S, Cap_Step (O, T, S, E), Cap_Step (O, T, S, E2), N - 1);
      end if;
   end Cap_Iter_Mono;

   --  The two contexts, as far as the frontier reads them.
   function Ctx_Le
     (F2 : Facts; C, C2 : Context) return Boolean
   is
     ((for all I in Ev_Ix =>
         (if C.App (I) then C2.App (I))
         and then
         (if F2.Ev (I).Present and then F2.Ev (I).Result /= Holds
          then C.App (I) = C2.App (I)))
      and then Table_Le (C.Own, C2.Own)
      and then Table_Le (C.Eff, C2.Eff)
      and then C.Cyc = C2.Cyc);

   function World_Le
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      C, C2 : Context; X, X2 : Id_Set) return Boolean
   is
     (Good_Ext (F, F2)
      and then Stratified (F) and then Stratified (F2)
      and then Plain_Obligations (F)
      and then (for all I in Ev_Ix => Ev_Rel (O, T, S, F, F2, I))
      and then (for all I in Ev_Ix =>
                  C.App (I) = Applies (O, T, S, F, I)
                  and then C2.App (I) = Applies (O, T, S, F2, I))
      and then Ctx_Le (F2, C, C2)
      and then Sub_Set (X, X2));

   procedure Dec_Transfer
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      C, C2 : Context; X, X2 : Id_Set; J : Dec_Ix)
   with
     Pre  => World_Le (O, T, S, F, F2, C, C2, X, X2),
     Post => (if Dec_Holds (T, S, F, C, X, J)
              then Dec_Holds (T, S, F2, C2, X2, J)
                   and then F.Dec (J) = F2.Dec (J))
             and then
             (if F2.Dec (J).What in Promise | Ask
                and then Dec_Holds (T, S, F2, C2, X2, J)
              then Dec_Holds (T, S, F, C, X, J)
                   and then F.Dec (J) = F2.Dec (J));

   procedure Dec_Transfer
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      C, C2 : Context; X, X2 : Id_Set; J : Dec_Ix) is
   begin
      if F.Dec (J) = F2.Dec (J) then
         pragma Assert
           (for all K in Cond_Ix =>
              (if Cond_True (T, S, C, X, F.Dec (J).Conds (K))
               then Cond_True (T, S, C2, X2, F2.Dec (J).Conds (K))));
         if F.Dec (J).Present and then F.Dec (J).What in Promise | Ask then
            pragma Assert
              (for all K in Cond_Ix =>
                 F.Dec (J).Conds (K).What in None | Selected_At | Slot_Filled);
            pragma Assert
              (for all K in Cond_Ix =>
                 Cond_True (T, S, C, X, F.Dec (J).Conds (K))
                 = Cond_True (T, S, C2, X2, F2.Dec (J).Conds (K)));
         end if;
      end if;
   end Dec_Transfer;

   function Decs_Rel
     (T : Version_Table; S : Selection; F, F2 : Facts;
      C, C2 : Context; X, X2 : Id_Set) return Boolean
   is
     (for all J in Dec_Ix =>
        (if Dec_Holds (T, S, F, C, X, J)
         then Dec_Holds (T, S, F2, C2, X2, J)
              and then F.Dec (J) = F2.Dec (J))
        and then
        (if F2.Dec (J).What in Promise | Ask
           and then Dec_Holds (T, S, F2, C2, X2, J)
         then Dec_Holds (T, S, F, C, X, J)
              and then F.Dec (J) = F2.Dec (J)));

   procedure Decs_Transfer
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      C, C2 : Context; X, X2 : Id_Set)
   with
     Pre  => World_Le (O, T, S, F, F2, C, C2, X, X2),
     Post => Decs_Rel (T, S, F, F2, C, C2, X, X2);

   procedure Decs_Transfer
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      C, C2 : Context; X, X2 : Id_Set) is
   begin
      for J in Dec_Ix loop
         Dec_Transfer (O, T, S, F, F2, C, C2, X, X2, J);
         pragma Loop_Invariant
           (for all J2 in Dec_Ix range Dec_Ix'First .. J =>
              (if Dec_Holds (T, S, F, C, X, J2)
               then Dec_Holds (T, S, F2, C2, X2, J2)
                    and then F.Dec (J2) = F2.Dec (J2))
              and then
              (if F2.Dec (J2).What in Promise | Ask
                 and then Dec_Holds (T, S, F2, C2, X2, J2)
               then Dec_Holds (T, S, F, C, X, J2)
                    and then F.Dec (J2) = F2.Dec (J2)));
      end loop;
   end Decs_Transfer;

   procedure Inst_Transfer
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      C, C2 : Context; X, X2 : Id_Set; N : Instance)
   with
     Pre  => World_Le (O, T, S, F, F2, C, C2, X, X2)
             and then Decs_Rel (T, S, F, F2, C, C2, X, X2),
     Post => (if Violated (O, T, S, F2, C2, X2, N)
              then Violated (O, T, S, F, C, X, N))
             and then
             (if Covered (T, S, F, C, X, N)
              then Covered (T, S, F2, C2, X2, N));

   procedure Inst_Transfer
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      C, C2 : Context; X, X2 : Id_Set; N : Instance) is
   begin
      null;
   end Inst_Transfer;

   procedure Own_Transfer
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      C, C2 : Context; X, X2 : Id_Set; P : Id)
   with
     Pre  => World_Le (O, T, S, F, F2, C, C2, X, X2),
     Post => (if Own_OK (O, T, S, F, C, X, P)
              then Own_OK (O, T, S, F2, C2, X2, P));

   procedure Own_Transfer
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      C, C2 : Context; X, X2 : Id_Set; P : Id) is
   begin
      Decs_Transfer (O, T, S, F, F2, C, C2, X, X2);
      for K in Inst_Kind loop
         for I in Sub loop
            for J in Sub loop
               Inst_Transfer (O, T, S, F, F2, C, C2, X, X2, (K, P, I, J));
               pragma Loop_Invariant
                 (for all J2 in Sub range Sub'First .. J =>
                    (if Violated (O, T, S, F2, C2, X2, (K, P, I, J2))
                     then Violated (O, T, S, F, C, X, (K, P, I, J2)))
                    and then
                    (if Covered (T, S, F, C, X, (K, P, I, J2))
                     then Covered (T, S, F2, C2, X2, (K, P, I, J2))));
            end loop;
            pragma Loop_Invariant
              (for all I2 in Sub range Sub'First .. I =>
                 (for all J2 in Sub =>
                    (if Violated (O, T, S, F2, C2, X2, (K, P, I2, J2))
                     then Violated (O, T, S, F, C, X, (K, P, I2, J2)))
                    and then
                    (if Covered (T, S, F, C, X, (K, P, I2, J2))
                     then Covered (T, S, F2, C2, X2, (K, P, I2, J2)))));
         end loop;
         pragma Loop_Invariant
           (for all K2 in Inst_Kind range Inst_Kind'First .. K =>
              (for all I2 in Sub =>
                 (for all J2 in Sub =>
                    (if Violated (O, T, S, F2, C2, X2, (K2, P, I2, J2))
                     then Violated (O, T, S, F, C, X, (K2, P, I2, J2)))
                    and then
                    (if Covered (T, S, F, C, X, (K2, P, I2, J2))
                     then Covered (T, S, F2, C2, X2, (K2, P, I2, J2))))));
      end loop;
   end Own_Transfer;

   procedure Good_Facts_Do_No_Harm
     (O : Ontology; T : Version_Table; S : Selection; F, F2 : Facts;
      N : Instance)
   is
      C  : constant Context := Derive (O, T, S, F);
      C2 : constant Context := Derive (O, T, S, F2);
      X  : constant Id_Set := Consistent (O, T, S, F, C);
      X2 : constant Id_Set := Consistent (O, T, S, F2, C2);
   begin
      Evs_Transfer (O, T, S, F, F2);
      for P in Id loop
         for D in Dim loop
            Own_Mono (O, T, S, F, F2, P, D);
            pragma Loop_Invariant
              (for all D2 in Dim range Dim'First .. D =>
                 C.Own (P, D2) <= C2.Own (P, D2));
         end loop;
         pragma Loop_Invariant
           (for all P2 in Id range Id'First .. P =>
              (for all D2 in Dim => C.Own (P2, D2) <= C2.Own (P2, D2)));
      end loop;
      pragma Assert (Table_Le (C.Own, C2.Own));
      Cap_Iter_Mono (O, T, S, C.Own, C2.Own, Cap_Rounds);
      pragma Assert (Table_Le (C.Eff, C2.Eff));
      pragma Assert (Ctx_Le (F2, C, C2));

      --  X, the consistent set of the smaller world, is consistent
      --  with itself in the larger one; so it lies within X2.
      Consistent_Is_Fixed (O, T, S, F, C);
      pragma Assert (World_Le (O, T, S, F, F2, C, C2, X, X));
      for P in Id loop
         Own_Transfer (O, T, S, F, F2, C, C2, X, X, P);
         pragma Loop_Invariant
           (for all Q in Id range Id'First .. P =>
              (if X (Q) then Own_OK (O, T, S, F2, C2, X, Q)));
      end loop;
      Consistent_Is_Greatest (O, T, S, F2, C2, X);
      pragma Assert (World_Le (O, T, S, F, F2, C, C2, X, X2));
      Decs_Transfer (O, T, S, F, F2, C, C2, X, X2);
      Inst_Transfer (O, T, S, F, F2, C, C2, X, X2, N);
   end Good_Facts_Do_No_Harm;

end Vk.Lemmas;
