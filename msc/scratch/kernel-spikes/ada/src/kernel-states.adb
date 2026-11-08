package body Kernel.States with SPARK_Mode => On is

   function Same (A, B : State) return Boolean with SPARK_Mode => Off is
   begin
      return A = B;
   end Same;

   function Valid (S : State) return Boolean is
   begin
      return Valid_Def (S);
   end Valid;

   -------------------------------------------------------------------
   --  position
   -------------------------------------------------------------------

   function Position (S : State; V : Veritoid_Id) return Rung is
      P : Rung := Sketch;
   begin
      for K in 1 .. S.N_Acts loop
         pragma Loop_Invariant
           (for all J in 1 .. K - 1 =>
              (if Supports (S, J, V) then S.Acts (J).Attests <= P));
         pragma Loop_Invariant
           (P = Sketch
            or else (for some J in 1 .. K - 1 =>
                       Supports (S, J, V) and then S.Acts (J).Attests = P));
         if Supports (S, K, V) and then S.Acts (K).Attests > P then
            P := S.Acts (K).Attests;
         end if;
      end loop;
      return P;
   end Position;

   function Positions (S : State) return Rung_Array is
      P : Rung_Array := [others => Sketch];
   begin
      for V in Veritoid_Id loop
         pragma Loop_Invariant
           (for all W in Veritoid_Id'First .. V - 1 =>
              Is_Position (S, W, P (W)));
         P (V) := Position (S, V);
      end loop;
      return P;
   end Positions;

   -------------------------------------------------------------------
   --  ceiling
   -------------------------------------------------------------------

   function Ceilings (S : State) return Rung_Array is
      T : Veritoid_Table renames S.Veritoids;
      R : Rank_Array renames S.Ranks;
      P : constant Rung_Array := Positions (S);
      C : Rung_Array := [others => Sketch];

      --  Every present W at or below level L has its ceiling in C.
      function Done_Through (C : Rung_Array; L : Rank_T) return Boolean is
        (for all W in Veritoid_Id =>
           (if T (W).Present and then R (W) <= L
            then Is_Ceiling (T, P, C, W)
            elsif not T (W).Present then C (W) = Sketch));

      --  Write V's ceiling. Nothing at or below level L has V as a
      --  present target (its rank would have to be below V's), so no
      --  Rest at or below L moves.
      procedure Set_Ceiling (C : in out Rung_Array; V : Veritoid_Id; M : Rung)
      with Pre  => Valid (S) and then T (V).Present,
           Post => C (V) = M
                   and then (for all W in Veritoid_Id =>
                               (if W /= V then C (W) = C'Old (W)))
                   and then (for all W in Veritoid_Id =>
                               (if T (W).Present and then R (W) <= R (V) then
                                  (for all J in 1 .. T (W).Refs.Count =>
                                     Rest (T, C, W, J) = Rest (T, C'Old, W, J))));

      procedure Set_Ceiling (C : in out Rung_Array; V : Veritoid_Id; M : Rung)
      is
      begin
         pragma Assert
           (for all W in Veritoid_Id =>
              (if T (W).Present and then R (W) <= R (V) then
                 (for all J in 1 .. T (W).Refs.Count =>
                    (if T (Target_Of (T, W, J)).Present
                     then Target_Of (T, W, J) /= V))));
         C (V) := M;
      end Set_Ceiling;

   begin
      --  Level by level: when V is at level L every present target of
      --  V is at a lower level, so its ceiling is already final.
      for L in Rank_T range 1 .. Rank_T'Last loop
         for V in Veritoid_Id loop
            pragma Loop_Invariant
              (for all W in Veritoid_Id =>
                 (if T (W).Present
                       and then (R (W) < L or else (R (W) = L and then W < V))
                  then Is_Ceiling (T, P, C, W)
                  elsif not T (W).Present then C (W) = Sketch));
            if T (V).Present and then R (V) = L then
               declare
                  M : Rung := P (V);
               begin
                  for I in 1 .. T (V).Refs.Count loop
                     pragma Loop_Invariant (M <= P (V));
                     pragma Loop_Invariant
                       (for all J in 1 .. I - 1 => M <= Rest (T, C, V, J));
                     pragma Loop_Invariant
                       (M = P (V)
                        or else (for some J in 1 .. I - 1 =>
                                   M = Rest (T, C, V, J)));
                     M := Rung'Min (M, Rest (T, C, V, I));
                  end loop;
                  Set_Ceiling (C, V, M);
                  pragma Assert (Is_Ceiling (T, P, C, V));
               end;
            end if;
         end loop;
         pragma Loop_Invariant (Done_Through (C, L));
      end loop;
      return C;
   end Ceilings;

   -------------------------------------------------------------------
   --  frontier
   -------------------------------------------------------------------

   procedure Lemma_Steady_Is_Honest (S : State) is null;

   --  Pushing X onto a list adds exactly X to what it contains.
   procedure Lemma_Push (Before, After : Frontier_List; X : Frontier_Item)
   with Ghost,
        Pre  => After.Count = Before.Count + 1
                and then After.Items (After.Count) = X
                and then (for all J in 1 .. Before.Count =>
                            After.Items (J) = Before.Items (J)),
        Post => (for all K in Item_Kind =>
                   (for all W in Veritoid_Id =>
                      (for all I in Ref_Count =>
                         Contains (After, (K, W, I))
                           = (Contains (Before, (K, W, I))
                              or else X = (K, W, I)))));

   procedure Lemma_Push (Before, After : Frontier_List; X : Frontier_Item)
   is null;

   function Frontier (S : State) return Frontier_List is
      T : Veritoid_Table renames S.Veritoids;
      C : constant Rung_Array := Ceilings (S);
      F : Frontier_List;

      --  Shape of every item ever pushed.
      function Shaped (X : Frontier_Item) return Boolean is
        ((X.Kind = Overclaim_Item) = (X.Ref = 0));

      --  The list says exactly the right thing about every W below V.
      function Rows_Done (F : Frontier_List; V : Veritoid_Id) return Boolean
      is
        (for all W in Veritoid_Id'First .. V - 1 =>
           Contains (F, (Overclaim_Item, W, 0)) = Overclaim (S, W)
           and then
           (for all K in Ref_Index =>
              Contains (F, (Stale_Item, W, K)) = Stale (S, W, K)
              and then
              Contains (F, (Unmet_Item, W, K)) = Unmet (S, W, K)))
      with Ghost, Pre => Valid (S);

      --  ... and about V's overclaim and its references below I.
      function Row_Done
        (F : Frontier_List; V : Veritoid_Id; I : Ref_Count) return Boolean
      is
        (Contains (F, (Overclaim_Item, V, 0)) = Overclaim (S, V)
         and then
         (for all K in 1 .. I =>
            Contains (F, (Stale_Item, V, K)) = Stale (S, V, K)
            and then
            Contains (F, (Unmet_Item, V, K)) = Unmet (S, V, K)))
      with Ghost, Pre => Valid (S);

      --  Every row.
      function All_Done (F : Frontier_List) return Boolean is
        (for all W in Veritoid_Id =>
           Contains (F, (Overclaim_Item, W, 0)) = Overclaim (S, W)
           and then
           (for all K in Ref_Index =>
              Contains (F, (Stale_Item, W, K)) = Stale (S, W, K)
              and then
              Contains (F, (Unmet_Item, W, K)) = Unmet (S, W, K)))
      with Ghost, Pre => Valid (S);

      procedure Push (X : Frontier_Item)
      with Pre  => Valid (S) and then F.Count < Max_Items and then Shaped (X),
           Post => F.Count = F.Count'Old + 1
                   and then F.Items (F.Count) = X
                   and then (for all J in 1 .. F.Count'Old =>
                               F.Items (J) = F'Old.Items (J))
                   and then (for all K in Item_Kind =>
                               (for all W in Veritoid_Id =>
                                  (for all I in Ref_Count =>
                                     Contains (F, (K, W, I))
                                       = (Contains (F'Old, (K, W, I))
                                          or else X = (K, W, I)))))
                   --  pushing an item for V disturbs no row below V,
                   --  and none of V's row below the item's reference
                   and then (for all V in Veritoid_Id =>
                               (if X.V >= V and then Rows_Done (F'Old, V)
                                then Rows_Done (F, V)))
                   and then (for all I in Ref_Count =>
                               (if X.Ref > I and then Row_Done (F'Old, X.V, I)
                                then Row_Done (F, X.V, I)));

      procedure Push (X : Frontier_Item) is
         F0 : constant Frontier_List := F with Ghost;
      begin
         F.Count := F.Count + 1;
         F.Items (F.Count) := X;
         Lemma_Push (F0, F, X);
      end Push;

      --  Items for veritoid W are the first V-1 blocks of the list.
      Per_Veritoid : constant := 1 + 2 * Max_Refs;

   begin
      F := (Count => 0, Items => [others => Null_Item]);
      pragma Assert (for all W in Veritoid_Id => Ceiling (S, W) = C (W));
      for V in Veritoid_Id loop
         pragma Loop_Invariant
           (F.Count <= Item_Count (V - Veritoid_Id'First) * Per_Veritoid);
         pragma Loop_Invariant
           (for all J in 1 .. F.Count =>
              Shaped (F.Items (J)) and then F.Items (J).V < V);
         pragma Loop_Invariant (Rows_Done (F, V));
         if T (V).Present and then T (V).Claimed > C (V) then
            Push ((Overclaim_Item, V, 0));
         end if;
         pragma Assert (Row_Done (F, V, 0));
         for I in Ref_Index loop
            pragma Loop_Invariant
              (F.Count <= Item_Count (V - Veritoid_Id'First) * Per_Veritoid
                          + 1 + 2 * Item_Count (I - 1));
            pragma Loop_Invariant
              (for all J in 1 .. F.Count =>
                 Shaped (F.Items (J))
                 and then F.Items (J).V <= V
                 and then (if F.Items (J).V = V then F.Items (J).Ref < I));
            pragma Loop_Invariant (Rows_Done (F, V));
            pragma Loop_Invariant (Row_Done (F, V, I - 1));
            if Stale (S, V, I) then
               Push ((Stale_Item, V, I));
            end if;
            pragma Assert (Contains (F, (Stale_Item, V, I)) = Stale (S, V, I));
            if T (V).Present
              and then I <= T (V).Refs.Count
              and then C (Target_Of (T, V, I)) < T (V).Refs.Items (I).Needed
            then
               Push ((Unmet_Item, V, I));
            end if;
            pragma Assert (Contains (F, (Unmet_Item, V, I)) = Unmet (S, V, I));
            pragma Assert (Contains (F, (Stale_Item, V, I)) = Stale (S, V, I));
         end loop;
      end loop;
      pragma Assert (All_Done (F));
      --  An empty list is a steady state and a non-empty one is not:
      --  its first item is a shaped key whose predicate holds.
      if F.Count > 0 then
         declare
            X : constant Frontier_Item := F.Items (1);
         begin
            pragma Assert (Contains (F, X));
            pragma Assert (Shaped (X));
            pragma Assert (X = (X.Kind, X.V, X.Ref));
            case X.Kind is
               when Overclaim_Item =>
                  pragma Assert (X.Ref = 0);
                  pragma Assert (Overclaim (S, X.V));
               when Stale_Item =>
                  pragma Assert (X.Ref in Ref_Index);
                  pragma Assert (Stale (S, X.V, X.Ref));
               when Unmet_Item =>
                  pragma Assert (X.Ref in Ref_Index);
                  pragma Assert (Unmet (S, X.V, X.Ref));
            end case;
            pragma Assert (not Steady (S));
         end;
      else
         pragma Assert (Steady (S));
      end if;
      return F;
   end Frontier;

   -------------------------------------------------------------------
   --  changesets
   -------------------------------------------------------------------

   function Candidate_Table
     (T : Veritoid_Table; C : Changeset) return Veritoid_Table
   is
      Res : Veritoid_Table := T;
   begin
      for V in Veritoid_Id loop
         pragma Loop_Invariant
           (for all W in Veritoid_Id'First .. V - 1 =>
              Res (W) = Candidate (T, C, W));
         pragma Loop_Invariant
           (for all W in V .. Veritoid_Id'Last => Res (W) = T (W));
         Res (V) := Candidate (T, C, V);
      end loop;
      return Res;
   end Candidate_Table;

   --  All present targets of V were ranked before pass P.
   function Rankable
     (T : Veritoid_Table; R : Rank_Array; V : Veritoid_Id; P : Rank_T)
      return Boolean
   is
     (for all I in 1 .. T (V).Refs.Count =>
        (if T (Target_Of (T, V, I)).Present
         then R (Target_Of (T, V, I)) in 1 .. P - 1));

   function Rank_All (T : Veritoid_Table) return Ranking is
      R        : Rank_Array := [others => 0];
      Progress : Boolean;
      Culprits : Id_Set;
   begin
      for P in Rank_T range 1 .. Rank_T'Last loop
         pragma Loop_Invariant
           (for all V in Veritoid_Id =>
              (if R (V) /= 0 then T (V).Present and then R (V) < P));
         pragma Loop_Invariant
           (for all V in Veritoid_Id =>
              (if R (V) /= 0 then
                 (for all I in 1 .. T (V).Refs.Count =>
                    (if T (Target_Of (T, V, I)).Present
                     then R (Target_Of (T, V, I)) in 1 .. R (V) - 1))));
         declare
            Before : constant Rank_Array := R with Ghost;
         begin
            Progress := False;
            for V in Veritoid_Id loop
               pragma Loop_Invariant
                 (for all W in Veritoid_Id =>
                    (if R (W) /= 0 then T (W).Present and then R (W) <= P));
               pragma Loop_Invariant
                 (for all W in Veritoid_Id =>
                    (if Before (W) /= 0 then R (W) = Before (W)));
               pragma Loop_Invariant
                 (for all W in Veritoid_Id =>
                    (if R (W) /= 0 and then Before (W) = 0 then R (W) = P));
               pragma Loop_Invariant
                 (for all W in Veritoid_Id =>
                    (if R (W) /= 0 then
                       (for all I in 1 .. T (W).Refs.Count =>
                          (if T (Target_Of (T, W, I)).Present
                           then R (Target_Of (T, W, I)) in 1 .. R (W) - 1))));
               pragma Loop_Invariant
                 (Progress = (for some W in Veritoid_Id =>
                                R (W) /= 0 and then Before (W) = 0));
               pragma Loop_Invariant
                 (for all W in Veritoid_Id'First .. V - 1 =>
                    (if T (W).Present and then R (W) = 0
                     then not Rankable (T, Before, W, P)));
               pragma Loop_Invariant
                 (for all W in Veritoid_Id =>
                    Rankable (T, R, W, P) = Rankable (T, Before, W, P));
               if T (V).Present and then R (V) = 0
                 and then Rankable (T, R, V, P)
               then
                  R (V) := P;
                  Progress := True;
               end if;
            end loop;
            if (for all V in Veritoid_Id => (R (V) /= 0) = T (V).Present) then
               return (Why => Accepted, Ranks => R, Culprits => No_Ids);
            elsif not Progress then
               Culprits := [for V in Veritoid_Id =>
                              T (V).Present and then R (V) = 0];
               pragma Assert
                 (for all V in Veritoid_Id =>
                    Culprits (V) = (T (V).Present and then R (V) = 0));
               pragma Assert
                 (for some V in Veritoid_Id =>
                    T (V).Present and then R (V) = 0);
               return (Why => Cycle, Ranks => R, Culprits => Culprits);
            end if;
         end;
      end loop;
      return (Why => Exhausted, Ranks => R, Culprits => No_Ids);
   end Rank_All;

   procedure Apply
     (S        : in out State;
      C        : Changeset;
      Why      : out Refusal;
      Culprits : out Id_Set)
   is
   begin
      Culprits := No_Ids;
      if not Distinct_Ids (C) then
         Why := Duplicate_Id;
         return;
      end if;
      if not Owns_Or_Fresh (S.Veritoids, C) then
         Why := Foreign_Id;
         return;
      end if;
      declare
         T  : constant Veritoid_Table := Candidate_Table (S.Veritoids, C);
         Rk : constant Ranking        := Rank_All (T);
      begin
         if Rk.Why /= Accepted then
            Why      := Rk.Why;
            Culprits := Rk.Culprits;
            return;
         end if;
         S.Veritoids := T;
         S.Ranks     := Rk.Ranks;
         Why         := Accepted;
      end;
   end Apply;

   -------------------------------------------------------------------
   --  acts
   -------------------------------------------------------------------

   procedure Record_Act (S : in out State; A : Act; Why : out Refusal) is
   begin
      if S.N_Acts = Max_Acts then
         Why := Full;
         return;
      end if;
      if not Reads_Known (S.Veritoids, A) then
         Why := Unknown_Id;
         return;
      end if;
      S.N_Acts          := S.N_Acts + 1;
      S.Acts (S.N_Acts) := A;
      Why               := Accepted;
   end Record_Act;

end Kernel.States;
