package body Kernel.Logs with SPARK_Mode => On is

   pragma Assertion_Policy (Ignore);

   function Try (S : State; R : Log_Record) return Outcome is
      O : Outcome := (After => S, Why => Accepted, Culprits => No_Ids);
   begin
      case R.Kind is
         when Changeset_Record =>
            Apply (O.After, R.Write, O.Why, O.Culprits);
         when Act_Record =>
            Record_Act (O.After, R.Did, O.Why);
      end case;
      return O;
   end Try;

   function Fold (L : Log; K : Log_Count) return State is
   begin
      if K = 0 then
         return Initial;
      else
         return Step (Fold (L, K - 1), Record_At (L, K));
      end if;
   end Fold;

   function Step (S : State; R : Log_Record) return State is
   begin
      return Try (S, R).After;
   end Step;

   function State_At (L : Log; K : Log_Count) return State is
      S : State := Initial;
   begin
      for I in 1 .. K loop
         pragma Loop_Invariant (Valid (S));
         pragma Loop_Invariant (Same (S, Fold (L, I - 1)));
         declare
            --  A call in code, so that Fold's postcondition is in hand.
            Next : constant State := Fold (L, I) with Ghost;
         begin
            S := Step (S, Record_At (L, I));
            pragma Assert (Same (S, Next));
         end;
      end loop;
      return S;
   end State_At;

   procedure Lemma_Fold_Prefix (A, B : Log; K : Log_Count) is
      FA : constant State := Fold (A, K);
      FB : constant State := Fold (B, K);
   begin
      if K > 0 then
         Lemma_Fold_Prefix (A, B, K - 1);
         pragma Assert (Same (FA, Step (Fold (A, K - 1), Record_At (A, K))));
         pragma Assert (Same (FB, Step (Fold (B, K - 1), Record_At (B, K))));
      end if;
   end Lemma_Fold_Prefix;

   procedure Append
     (L        : in out Log;
      R        : Log_Record;
      Why      : out Refusal;
      Culprits : out Id_Set)
   is
      Before : constant Log := L with Ghost;
      N      : constant Log_Count := L.Count;
   begin
      Culprits := No_Ids;
      if N = Max_Log then
         Why := Full;
         return;
      end if;
      declare
         O : constant Outcome := Try (Current (L), R);
      begin
         if O.Why /= Accepted then
            Why      := O.Why;
            Culprits := O.Culprits;
            return;
         end if;
         L.Count         := N + 1;
         L.Items (N + 1) := R;
         Why             := Accepted;
         --  Records 1 .. N are as they were, so every Fold up to N is.
         for K in 0 .. N loop
            pragma Loop_Invariant
              (for all J in 0 .. K - 1 => Same (Fold (L, J), Fold (Before, J)));
            Lemma_Fold_Prefix (Before, L, K);
         end loop;
         declare
            Now : constant State := Fold (L, N + 1) with Ghost;
         begin
            pragma Assert (Same (Now, Step (Fold (L, N), R)));
            pragma Assert (Same (Fold (L, N), Fold (Before, N)));
            pragma Assert (Same (Current (L), Now));
            pragma Assert (Same (Current (Before), Fold (Before, N)));
         end;
      end;
   end Append;

end Kernel.Logs;
