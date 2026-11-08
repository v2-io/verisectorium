package body Kernel with SPARK_Mode => On is

   function To_Name (S : String) return Name is
      N : Name := Blank_Name;
      J : Positive := 1;
   begin
      for I in S'Range loop
         pragma Loop_Invariant (J = I - S'First + 1);
         exit when J > Name_Length;
         N (J) := S (I);
         J := J + 1;
      end loop;
      return N;
   end To_Name;

   function Same (A, B : Log_Record) return Boolean with SPARK_Mode => Off is
   begin
      return A = B;
   end Same;

   function Append (R : Ref_List; X : Reference) return Ref_List is
      Res : Ref_List := R;
   begin
      Res.Count := R.Count + 1;
      Res.Items (Res.Count) := X;
      return Res;
   end Append;

   function Append (R : Read_List; X : Read) return Read_List is
      Res : Read_List := R;
   begin
      Res.Count := R.Count + 1;
      Res.Items (Res.Count) := X;
      return Res;
   end Append;

   function Append (C : Changeset; X : Veritoid_Entry) return Changeset is
      Res : Changeset := C;
   begin
      Res.Count := C.Count + 1;
      Res.Items (Res.Count) := X;
      return Res;
   end Append;

   function Index_Of (C : Changeset; V : Veritoid_Id) return Entry_Index is
   begin
      for I in 1 .. C.Count loop
         pragma Loop_Invariant
           (for all J in 1 .. I - 1 => C.Items (J).Id /= V);
         if C.Items (I).Id = V then
            return I;
         end if;
      end loop;
      --  Unreachable under the precondition; the prover shows it.
      raise Program_Error;
   end Index_Of;

end Kernel;
