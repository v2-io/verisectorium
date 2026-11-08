package body Kernel.Store with SPARK_Mode => On is

   ---------------------------------------------------------------------
   --  Validation
   ---------------------------------------------------------------------

   function Same_Refs (Vt : Veritoid; It : Item) return Boolean is
     (Vt.N_Refs = It.N_Refs
      and then (for all R in 1 .. It.N_Refs => Vt.Refs (R) = It.Refs (R)));

   --  An item kept at its content version whose references were rewritten
   --  must carry the author's affirmation.
   function Reconciles_Affirmed (T : Veritoid_Table; CS : Changeset)
      return Boolean
   is (for all I in 1 .. CS.N_Items =>
         (if In_Segment (T, CS.Segment, CS.Items (I).Id)
            and then T (CS.Items (I).Id).Ver = CS.Items (I).Ver
            and then not Same_Refs (T (CS.Items (I).Id), CS.Items (I))
          then CS.Items (I).Affirmed));

   ---------------------------------------------------------------------
   --  New_Table
   ---------------------------------------------------------------------

   function New_Table (T : Veritoid_Table; CS : Changeset)
      return Veritoid_Table
   is
      Result : Veritoid_Table := T;
   begin
      for V in Veritoid_Id loop
         if In_Segment (T, CS.Segment, V) then
            Result (V) := (others => <>);
         end if;
         pragma Loop_Invariant
           (for all W in 1 .. V =>
              (if In_Segment (T, CS.Segment, W)
               then Result (W) = (others => <>)
               else Result (W) = T (W)));
         pragma Loop_Invariant
           (for all W in V + 1 .. Max_Veritoids => Result (W) = T (W));
      end loop;

      for I in 1 .. CS.N_Items loop
         Result (CS.Items (I).Id) := To_Veritoid (CS.Segment, CS.Items (I));
         pragma Loop_Invariant
           (for all J in 1 .. I =>
              Result (CS.Items (J).Id)
              = To_Veritoid (CS.Segment, CS.Items (J)));
         pragma Loop_Invariant
           (for all W in Veritoid_Id =>
              (if not (for some J in 1 .. I => CS.Items (J).Id = W) then
                 (if In_Segment (T, CS.Segment, W)
                  then Result (W) = (others => <>)
                  else Result (W) = T (W))));
      end loop;
      return Result;
   end New_Table;

   ---------------------------------------------------------------------
   --  Compute_Rank
   ---------------------------------------------------------------------

   function Partial_Ranked (T : Veritoid_Table; R : Rank_Array; Pass : Natural)
      return Boolean
   is (for all W in Veritoid_Id =>
         R (W) <= Pass
         and then
           (if R (W) /= 0 then
              T (W).Present
              and then R (W) in 1 .. Max_Veritoids
              and then
                (for all Q in 1 .. T (W).N_Refs =>
                   (if T (T (W).Refs (Q).Target).Present then
                      R (T (W).Refs (Q).Target) /= 0
                      and then R (T (W).Refs (Q).Target) < R (W)))))
   with Ghost;

   --  Termination measure for the layering: how many are ranked.
   function Count_Ranked (R : Rank_Array; N : Natural) return Natural is
     (if N = 0 then 0
      else Count_Ranked (R, N - 1) + (if R (N) /= 0 then 1 else 0))
   with
     Ghost,
     Pre                => N <= Max_Veritoids,
     Post               => Count_Ranked'Result <= N,
     Subprogram_Variant => (Decreases => N);

   procedure Lemma_Count (A, B : Rank_Array; N : Natural)
   with
     Ghost,
     Global             => null,
     Pre                =>
       N <= Max_Veritoids
       and then (for all I in 1 .. N => (if A (I) /= 0 then B (I) /= 0)),
     Post               =>
       Count_Ranked (B, N) >= Count_Ranked (A, N)
       and then
         (if (for some I in 1 .. N => A (I) = 0 and then B (I) /= 0)
          then Count_Ranked (B, N) > Count_Ranked (A, N))
       and then
         (if (for some I in 1 .. N => A (I) = 0)
          then Count_Ranked (A, N) < N),
     Subprogram_Variant => (Decreases => N);

   procedure Lemma_Count (A, B : Rank_Array; N : Natural) is
   begin
      if N > 0 then
         Lemma_Count (A, B, N - 1);
      end if;
   end Lemma_Count;

   function Compute_Rank (T : Veritoid_Table) return Rank_Result is
      R       : Rank_Array := [others => 0];
      Old     : Rank_Array;
      Pass    : Positive := 1;
      Ready   : Boolean;
      Changed : Boolean;
   begin
      loop
         Old := R;
         Changed := False;
         --  Every unranked id leaves room: Pass cannot pass Max_Veritoids
         --  while something is still unranked.
         Lemma_Count (Old, Old, Max_Veritoids);

         for V in Veritoid_Id loop
            if T (V).Present and then R (V) = 0 then
               Ready := True;
               for Q in 1 .. T (V).N_Refs loop
                  if T (T (V).Refs (Q).Target).Present
                    and then
                      (R (T (V).Refs (Q).Target) = 0
                       or else R (T (V).Refs (Q).Target) >= Pass)
                  then
                     Ready := False;
                  end if;
                  pragma Loop_Invariant
                    (Ready
                     = (for all Z in 1 .. Q =>
                          (if T (T (V).Refs (Z).Target).Present then
                             R (T (V).Refs (Z).Target) /= 0
                             and then R (T (V).Refs (Z).Target) < Pass)));
               end loop;
               if Ready then
                  pragma Assert (Pass <= Max_Veritoids);
                  R (V) := Pass;
                  Changed := True;
               end if;
            end if;
            pragma Loop_Invariant (Partial_Ranked (T, R, Pass));
            pragma Loop_Invariant
              (for all W in Veritoid_Id =>
                 (if Old (W) /= 0 then R (W) = Old (W)));
            pragma Loop_Invariant
              (for all W in V + 1 .. Max_Veritoids => R (W) = Old (W));
            pragma Loop_Invariant
              (for all W in Veritoid_Id =>
                 (if R (W) = Pass then Old (W) = 0 and then Changed));
            pragma Loop_Invariant
              (Changed
               = (for some W in 1 .. V => Old (W) = 0 and then R (W) /= 0));
            --  Every id seen and left unranked has a present target that
            --  is unranked or was ranked in this pass.
            pragma Loop_Invariant
              (for all W in 1 .. V =>
                 (if T (W).Present and then R (W) = 0 then
                    (for some Q in 1 .. T (W).N_Refs =>
                       T (T (W).Refs (Q).Target).Present
                       and then
                         (R (T (W).Refs (Q).Target) = 0
                          or else R (T (W).Refs (Q).Target) = Pass))));
         end loop;

         exit when not Changed;

         Lemma_Count (Old, R, Max_Veritoids);
         Pass := Pass + 1;
         pragma Loop_Invariant (Partial_Ranked (T, R, Pass - 1));
         pragma Loop_Invariant (Count_Ranked (R, Max_Veritoids) >= Pass - 1);
         pragma Loop_Variant
           (Increases => Count_Ranked (R, Max_Veritoids));
      end loop;

      --  Nothing was ranked in the last pass, so no rank equals Pass.
      return
        (Ok   =>
           (for all V in Veritoid_Id =>
              (if T (V).Present then R (V) /= 0)),
         Rank => R);
   end Compute_Rank;

   procedure Lemma_Rank_Complete (T : Veritoid_Table; W : Rank_Array) is
      R : constant Rank_Array := Compute_Rank (T).Rank;
   begin
      for K in 1 .. Max_Veritoids loop
         pragma Loop_Invariant
           (for all V in Veritoid_Id =>
              (if T (V).Present and then W (V) < K then R (V) /= 0));
      end loop;
      pragma Assert
        (for all V in Veritoid_Id =>
           (if T (V).Present and then W (V) <= Max_Veritoids
            then R (V) /= 0));
   end Lemma_Rank_Complete;

   ---------------------------------------------------------------------
   --  One step
   ---------------------------------------------------------------------

   function Append_Act (S : State; A : Act) return State is
      Result : State := S;
   begin
      Result.N_Acts := S.N_Acts + 1;
      Result.Acts (Result.N_Acts) := A;
      return Result;
   end Append_Act;

   function Try
     (S : State; Kind : Record_Kind; CS : Changeset; A : Act)
      return Try_Result
   is
   begin
      if Kind = Act_Record then
         if S.N_Acts = Max_Acts then
            return (Result => Act_Capacity, Next => S);
         end if;
         return (Result => Accepted, Next => Append_Act (S, A));
      end if;

      if not No_Duplicates (CS) then
         return (Result => Duplicate_Item, Next => S);
      elsif not No_Foreign (S.V, CS) then
         return (Result => Foreign_Id, Next => S);
      elsif not Reconciles_Affirmed (S.V, CS) then
         return (Result => Unaffirmed_Reconcile, Next => S);
      end if;

      declare
         T  : constant Veritoid_Table := New_Table (S.V, CS);
         RR : constant Rank_Result := Compute_Rank (T);
      begin
         if not RR.Ok then
            return (Result => Cycle, Next => S);
         end if;
         return
           (Result => Accepted,
            Next   => (V => T, N_Acts => S.N_Acts, Acts => S.Acts,
                       Rank => RR.Rank));
      end;
   end Try;

   ---------------------------------------------------------------------
   --  The log
   ---------------------------------------------------------------------

   procedure Lemma_Prefix (L1, L2 : Log; K : Natural) is
   begin
      if K > 0 then
         Lemma_Prefix (L1, L2, K - 1);
      end if;
   end Lemma_Prefix;

   function Empty_Store return Store is
     ((L => Empty_Log, Cur => Empty_State));

   procedure Append
     (St     : in out Store;
      Kind   : Record_Kind;
      CS     : Changeset;
      A      : Act;
      Result : out Outcome)
   is
      Old_L : constant Log := St.L with Ghost;
      N     : constant Natural := St.L.Len;
      TR    : Try_Result;
      E     : Log_Entry;
   begin
      if N = Max_Log then
         Result := Log_Full;
         return;
      end if;

      E := Canonical (Log_Entry'(Kind => Kind, CS => CS, A => A,
                                 Result => Accepted));
      TR := Try (St.Cur, Kind, E.CS, E.A);
      Result := TR.Result;
      E.Result := TR.Result;
      St.L.Len := N + 1;
      St.L.Items (N + 1) := E;

      Lemma_Prefix (St.L, Old_L, N);
      pragma Assert (Same (State_At (St.L, N), St.Cur));
      St.Cur := TR.Next;
   end Append;

   procedure Push (L : in out Log; E : Log_Entry; Ok : out Boolean) is
   begin
      if L.Len = Max_Log then
         Ok := False;
         return;
      end if;
      L.Len := L.Len + 1;
      L.Items (L.Len) := Canonical (E);
      Ok := True;
   end Push;

   ---------------------------------------------------------------------
   --  P3, P4
   ---------------------------------------------------------------------

   procedure Lemma_Lapse_Exact (S : State; CS : Changeset; A : Act) is
      T2 : constant Veritoid_Table :=
        Try (S, Changeset_Record, CS, A).Next.V;
   begin
      pragma Assert (T2 = New_Table (S.V, CS));
      pragma Assert
        (for all I in 1 .. A.N_Reads =>
           (if not In_Segment (S.V, CS.Segment, A.Reads (I).Id)
              and then not In_Items (CS, A.Reads (I).Id)
            then T2 (A.Reads (I).Id) = S.V (A.Reads (I).Id)));
   end Lemma_Lapse_Exact;

   procedure Lemma_Cycle_Exact (S : State; CS : Changeset; W : Rank_Array) is
   begin
      if Ranked (New_Table (S.V, CS), W) then
         Lemma_Rank_Complete (New_Table (S.V, CS), W);
         pragma Assert (False);
      end if;
   end Lemma_Cycle_Exact;

   procedure Lemma_Monotone (S : State; A : Act) is
      S2 : constant State := Append_Act (S, A);
   begin
      pragma Assert
        (for all J in 1 .. S.N_Acts =>
           (for all V in Veritoid_Id =>
              Counts (S2, J, V) = Counts (S, J, V)));
   end Lemma_Monotone;

end Kernel.Store;
