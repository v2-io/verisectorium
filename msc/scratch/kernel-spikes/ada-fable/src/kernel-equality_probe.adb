package body Kernel.Equality_Probe with SPARK_Mode => On is
   procedure Congruence_Fields (A, B : State) is null;
   procedure Congruence_Pos (A, B : State; V : Veritoid_Id) is null;
   function Hash (S : State) return Natural is
   begin
      return Natural (S.N_Acts);
   end Hash;
   procedure Congruence_Hash (A, B : State) is null;
   pragma Annotate
     (GNATprove, Intentional, "postcondition might fail",
      "evidence: = on State gives no congruence for an opaque function");
   procedure Congruence (A, B : State) is null;
   pragma Annotate
     (GNATprove, Intentional, "postcondition might fail",
      "evidence: = on State does not carry Valid across");
   procedure Congruence_Try (A, B : State; R : Log_Record) is null;
   pragma Annotate
     (GNATprove, Intentional, "postcondition might fail",
      "evidence: = on State does not carry Try across");
   procedure Congruence_Step (A, B : State; R : Log_Record) is null;
   pragma Annotate
     (GNATprove, Intentional, "postcondition might fail",
      "evidence: = on State does not carry Step across");
   procedure Same_Hash (A, B : State) is null;
   procedure Same_Valid (A, B : State) is null;
   procedure Same_Step (A, B : State; R : Log_Record) is null;
end Kernel.Equality_Probe;
