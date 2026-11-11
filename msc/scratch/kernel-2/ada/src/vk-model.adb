package body Vk.Model with SPARK_Mode => On is

   --------------
   -- Cap_Step --
   --------------

   function Cap_Step
     (O : Ontology; T : Version_Table; S : Selection; E : Warrant_Table)
      return Warrant_Table
   is
      function One (P : Id; D : Dim) return Warrant is
        (Warrant'Min
           (E (P, D),
            Warrant'Min
              (Lower (O, T, S, E, P, D, 1),
               Warrant'Min
                 (Lower (O, T, S, E, P, D, 2),
                  Warrant'Min
                    (Lower (O, T, S, E, P, D, 3),
                     Warrant'Min
                       (Lower (O, T, S, E, P, D, 4),
                        Lower (O, T, S, E, P, D, 5)))))));
      R : Warrant_Table := [others => [others => 0]];
   begin
      for P in Id loop
         for D in Dim loop
            R (P, D) := One (P, D);
            pragma Loop_Invariant
              (for all D2 in Dim range Dim'First .. D =>
                 R (P, D2) = One (P, D2));
            pragma Loop_Invariant
              (for all P2 in Id range Id'First .. P - 1 =>
                 (for all D2 in Dim => R (P2, D2) = One (P2, D2)));
         end loop;
         pragma Loop_Invariant
           (for all P2 in Id range Id'First .. P =>
              (for all D2 in Dim => R (P2, D2) = One (P2, D2)));
      end loop;
      return R;
   end Cap_Step;

   --------------
   -- Cap_Iter --
   --------------

   function Cap_Iter
     (O : Ontology; T : Version_Table; S : Selection; E : Warrant_Table;
      N : Natural) return Warrant_Table
   is
   begin
      if N = 0 then
         return E;
      else
         return Cap_Iter (O, T, S, Cap_Step (O, T, S, E), N - 1);
      end if;
   end Cap_Iter;

   ----------------
   -- Cap_Cycles --
   ----------------

   function Cap_Cycles
     (O : Ontology; T : Version_Table; S : Selection) return Id_Set
   is
      type Reach_Table is array (Id, Id) of Boolean;
      Reach : Reach_Table := [others => [others => False]];
      Cyc   : Id_Set;
   begin
      for P in Id loop
         for I in Edge_Ix loop
            for D in Dim loop
               if Caps_Along (O, T, S, P, I, D)
                 and then S (Edge (O, T, S, P, I).Target).Selected
               then
                  Reach (P, Edge (O, T, S, P, I).Target) := True;
               end if;
            end loop;
         end loop;
      end loop;
      for K in Id loop
         for P in Id loop
            for Q in Id loop
               if Reach (P, K) and then Reach (K, Q) then
                  Reach (P, Q) := True;
               end if;
            end loop;
         end loop;
      end loop;
      for P in Id loop
         Cyc (P) := Reach (P, P);
      end loop;
      return Cyc;
   end Cap_Cycles;

   ------------
   -- Derive --
   ------------

   function Derive
     (O : Ontology; T : Version_Table; S : Selection; F : Facts)
      return Context
   is
      C : Context :=
        (App => [others => False],
         Own => [others => [others => 0]],
         Eff => [others => [others => 0]],
         Cyc => [others => False]);
   begin
      for I in Ev_Ix loop
         C.App (I) := Applies (O, T, S, F, I);
         pragma Loop_Invariant
           (for all K in Ev_Ix range Ev_Ix'First .. I =>
              C.App (K) = Applies (O, T, S, F, K));
      end loop;

      for P in Id loop
         for D in Dim loop
            C.Own (P, D) := Own_Warrant (O, T, S, F, P, D);
            pragma Loop_Invariant
              (for all D2 in Dim range Dim'First .. D =>
                 C.Own (P, D2) = Own_Warrant (O, T, S, F, P, D2));
            pragma Loop_Invariant
              (for all P2 in Id range Id'First .. P - 1 =>
                 (for all D2 in Dim =>
                    C.Own (P2, D2) = Own_Warrant (O, T, S, F, P2, D2)));
            pragma Loop_Invariant (C.App = C.App'Loop_Entry);
         end loop;
         pragma Loop_Invariant
           (for all P2 in Id range Id'First .. P =>
              (for all D2 in Dim =>
                 C.Own (P2, D2) = Own_Warrant (O, T, S, F, P2, D2)));
         pragma Loop_Invariant (C.App = C.App'Loop_Entry);
      end loop;

      C.Eff := Cap_Iter (O, T, S, C.Own, Cap_Rounds);
      C.Cyc := Cap_Cycles (O, T, S);
      return C;
   end Derive;

   ----------
   -- Iter --
   ----------

   function Iter
     (O : Ontology; T : Version_Table; S : Selection; F : Facts;
      C : Context; X : Id_Set; N : Natural) return Id_Set
   is
   begin
      if N = 0 or else Stepped (O, T, S, F, C, X) = X then
         return X;
      else
         return Iter (O, T, S, F, C, Stepped (O, T, S, F, C, X), N - 1);
      end if;
   end Iter;

end Vk.Model;
