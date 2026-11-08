--  Small constructors shared by the tests and the CLI.
with Kernel;        use Kernel;
with Kernel.States; use Kernel.States;
with Kernel.Logs;   use Kernel.Logs;

package Fixtures is

   function Ref (Target : Veritoid_Id; Needed : Rung; Seen : Version)
     return Reference
   is ((Target => Target, Needed => Needed, Seen => Seen));

   function Refs (A : Reference) return Ref_List is (Append (No_Refs, A));
   function Refs (A, B : Reference) return Ref_List is
     (Append (Append (No_Refs, A), B));

   function Make_Entry
     (Id : Veritoid_Id; Vers : Version; Claimed : Rung; R : Ref_List := No_Refs)
      return Veritoid_Entry
   is ((Id => Id, Vers => Vers, Claimed => Claimed, Refs => R));

   function Reads (A : Read) return Read_List is (Append (No_Reads, A));
   function Reads (A, B : Read) return Read_List is
     (Append (Append (No_Reads, A), B));
   function Reads (A, B, C : Read) return Read_List is
     (Append (Append (Append (No_Reads, A), B), C));

   function Rd (Id : Veritoid_Id; Vers : Version) return Read is
     ((Id => Id, Vers => Vers));

   function Make_Act
     (Actor, Criterion : String;
      Kind             : Act_Kind;
      Attests          : Rung;
      R                : Read_List) return Act
   is ((Actor     => To_Name (Actor),
        Criterion => To_Name (Criterion),
        Kind      => Kind,
        Reads     => R,
        Attests   => Attests));

   --  Append to the log and fail loudly if refused.
   procedure Must_Append (L : in out Log; R : Log_Record; What : String);

   --  Append and return the refusal.
   function Try_Append (L : in out Log; R : Log_Record) return Refusal;

   function Has
     (F : Frontier_List; Kind : Item_Kind; V : Veritoid_Id;
      R : Ref_Count := 0) return Boolean
   is (Contains (F, (Kind, V, R)));

end Fixtures;
