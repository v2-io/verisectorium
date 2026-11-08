package body Kernel.Model with SPARK_Mode => On is

   ---------------------------------------------------------------------
   --  position
   ---------------------------------------------------------------------

   function Position (S : State; V : Veritoid_Id) return Rung is
      Result : Rung := Sketch;
   begin
      for J in 1 .. S.N_Acts loop
         if Counts (S, J, V) and then S.Acts (J).Level > Result then
            Result := S.Acts (J).Level;
         end if;
         pragma Loop_Invariant
           (for all K in 1 .. J =>
              (if Counts (S, K, V) then S.Acts (K).Level <= Result));
         pragma Loop_Invariant
           (Result = Sketch
            or else
              (for some K in 1 .. J =>
                 Counts (S, K, V) and then S.Acts (K).Level = Result));
      end loop;
      return Result;
   end Position;

   function Positions (S : State) return Rung_Array is
      Result : Rung_Array := [others => Sketch];
   begin
      for V in Veritoid_Id loop
         Result (V) := Position (S, V);
         pragma Loop_Invariant
           (for all W in 1 .. V => Result (W) = Position (S, W));
      end loop;
      return Result;
   end Positions;

   ---------------------------------------------------------------------
   --  ceiling: termination measure
   ---------------------------------------------------------------------

   function Sum (C : Rung_Array; N : Natural) return Natural is
     (if N = 0 then 0 else Sum (C, N - 1) + Rung'Pos (C (N)))
   with
     Ghost,
     Pre                => N <= Max_Veritoids,
     Post               => Sum'Result <= 3 * N,
     Subprogram_Variant => (Decreases => N);

   procedure Lemma_Sum_Mono (A, B : Rung_Array; N : Natural)
   with
     Ghost,
     Global             => null,
     Pre                =>
       N <= Max_Veritoids and then (for all I in 1 .. N => B (I) <= A (I)),
     Post               =>
       Sum (B, N) <= Sum (A, N)
       and then
         (if (for some I in 1 .. N => B (I) < A (I))
          then Sum (B, N) < Sum (A, N)),
     Subprogram_Variant => (Decreases => N);

   procedure Lemma_Sum_Mono (A, B : Rung_Array; N : Natural) is
   begin
      if N > 0 then
         Lemma_Sum_Mono (A, B, N - 1);
      end if;
   end Lemma_Sum_Mono;

   ---------------------------------------------------------------------
   --  ceiling: the fixpoint
   ---------------------------------------------------------------------

   --  Invariant across passes: below positions, absent at Sketch, and
   --  each present value either still its position or at least as high
   --  as one of its targets.  Together with "no pass changed anything"
   --  this is exactly Is_Solution.
   function Pass_Inv (T : Veritoid_Table; P, C : Rung_Array) return Boolean is
     (for all V in Veritoid_Id =>
        (if not T (V).Present then C (V) = Sketch
         else
           C (V) <= P (V)
           and then
             (C (V) = P (V)
              or else
                (for some R in 1 .. T (V).N_Refs =>
                   C (V) >= C (T (V).Refs (R).Target)))))
   with Ghost;

   function Ceilings (S : State) return Rung_Array is
      T       : constant Veritoid_Table := S.V;
      P       : constant Rung_Array := Positions (S);
      C       : Rung_Array := [others => Sketch];
      Old     : Rung_Array;
      Changed : Boolean;
      M       : Rung;
   begin
      for V in Veritoid_Id loop
         if T (V).Present then
            C (V) := P (V);
         end if;
         pragma Loop_Invariant
           (for all W in 1 .. V =>
              C (W) = (if T (W).Present then P (W) else Sketch));
         pragma Loop_Invariant
           (for all W in V + 1 .. Max_Veritoids => C (W) = Sketch);
      end loop;

      pragma Assert (Pass_Inv (T, P, C));
      loop
         Old := C;
         Changed := False;

         for V in Veritoid_Id loop
            if T (V).Present then
               M := Old (V);
               for R in 1 .. T (V).N_Refs loop
                  M := Rung'Min (M, Old (T (V).Refs (R).Target));
                  pragma Loop_Invariant (M <= Old (V));
                  pragma Loop_Invariant
                    (for all Q in 1 .. R => M <= Old (T (V).Refs (Q).Target));
                  pragma Loop_Invariant
                    (M = Old (V)
                     or else
                       (for some Q in 1 .. R =>
                          M = Old (T (V).Refs (Q).Target)));
               end loop;
               if M /= Old (V) then
                  Changed := True;
               end if;
               C (V) := M;
            end if;

            pragma Loop_Invariant
              (for all W in 1 .. V =>
                 C (W) <= Old (W)
                 and then
                   (if T (W).Present then
                      (for all R in 1 .. T (W).N_Refs =>
                         C (W) <= Old (T (W).Refs (R).Target))
                      and then
                        (C (W) = Old (W)
                         or else
                           (for some R in 1 .. T (W).N_Refs =>
                              C (W) = Old (T (W).Refs (R).Target)))));
            pragma Loop_Invariant
              (for all W in V + 1 .. Max_Veritoids => C (W) = Old (W));
            pragma Loop_Invariant
              (Changed = (for some W in 1 .. V => C (W) /= Old (W)));
         end loop;

         exit when not Changed;

         Lemma_Sum_Mono (Old, C, Max_Veritoids);
         pragma Loop_Invariant (Pass_Inv (T, P, C));
         pragma Loop_Variant (Decreases => Sum (C, Max_Veritoids));
      end loop;

      return C;
   end Ceilings;

   ---------------------------------------------------------------------
   --  uniqueness on an acyclic table
   ---------------------------------------------------------------------

   procedure Lemma_Ceiling_Unique
     (T : Veritoid_Table; Rank : Rank_Array; P, C1, C2 : Rung_Array) is
   begin
      for K in 1 .. Max_Veritoids loop
         pragma Loop_Invariant
           (for all V in Veritoid_Id =>
              (if T (V).Present and then Rank (V) < K
               then C1 (V) = C2 (V)));
         pragma Loop_Invariant
           (for all V in Veritoid_Id =>
              (if not T (V).Present then C1 (V) = C2 (V)));
      end loop;
      pragma Assert
        (for all V in Veritoid_Id =>
           (if T (V).Present and then Rank (V) <= Max_Veritoids
            then C1 (V) = C2 (V)));
   end Lemma_Ceiling_Unique;

   ---------------------------------------------------------------------
   --  frontier
   ---------------------------------------------------------------------

   function Frontier (S : State) return Frontier_Set is
      C      : constant Rung_Array := Ceilings (S);
      Result : Frontier_Set;
   begin
      for V in Veritoid_Id loop
         Result.Overclaim (V) := Is_Overclaim (S.V, C, V);
         for R in Ref_Index loop
            Result.Stale (V, R) := Is_Stale (S.V, V, R);
            Result.Unmet (V, R) := Is_Unmet (S.V, C, V, R);
            pragma Loop_Invariant
              (for all Q in 1 .. R =>
                 Result.Stale (V, Q) = Is_Stale (S.V, V, Q)
                 and then Result.Unmet (V, Q) = Is_Unmet (S.V, C, V, Q));
            pragma Loop_Invariant
              (for all W in 1 .. V - 1 =>
                 Result.Overclaim (W) = Is_Overclaim (S.V, C, W)
                 and then
                   (for all Q in Ref_Index =>
                      Result.Stale (W, Q) = Is_Stale (S.V, W, Q)
                      and then Result.Unmet (W, Q)
                               = Is_Unmet (S.V, C, W, Q)));
         end loop;
         pragma Loop_Invariant
           (for all W in 1 .. V =>
              Result.Overclaim (W) = Is_Overclaim (S.V, C, W)
              and then
                (for all Q in Ref_Index =>
                   Result.Stale (W, Q) = Is_Stale (S.V, W, Q)
                   and then Result.Unmet (W, Q) = Is_Unmet (S.V, C, W, Q)));
      end loop;
      return Result;
   end Frontier;

   ---------------------------------------------------------------------
   --  P6, P7
   ---------------------------------------------------------------------

   procedure Lemma_Ceiling_Bound (S : State) is
      C : constant Rung_Array := Ceilings (S);
      P : constant Rung_Array := Positions (S);
   begin
      pragma Assert (Is_Solution (S.V, P, C));
   end Lemma_Ceiling_Bound;

   procedure Lemma_Steady_Honest (S : State) is
      C : constant Rung_Array := Ceilings (S);
      F : constant Frontier_Set := Frontier (S);
   begin
      pragma Assert
        (for all V in Veritoid_Id => not Is_Overclaim (S.V, C, V));
   end Lemma_Steady_Honest;

end Kernel.Model;
