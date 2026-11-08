with AUnit.Assertions; use AUnit.Assertions;

package body Builder is

   function New_CS (N : in out Names; Author, Segment : String)
      return Changeset is
   begin
      return (Author  => Actor_Named (N, Author),
              Segment => Segment_Named (N, Segment),
              others  => <>);
   end New_CS;

   procedure Add_Item
     (N        : in out Names;
      CS       : in out Changeset;
      Name     : String;
      Ver      : Version;
      Claimed  : Rung;
      Refs     : Ref_Specs := [];
      Affirmed : Boolean := False)
   is
      It : Kernel.Store.Item;
   begin
      It.Id := Veritoid_Named (N, Name);
      It.Ver := Ver;
      It.Claimed := Claimed;
      It.Affirmed := Affirmed;
      for R of Refs loop
         It.N_Refs := It.N_Refs + 1;
         It.Refs (It.N_Refs) :=
           (Target => Veritoid_Named (N, To_String (R.Target)),
            Needed => R.Needed,
            Seen   => R.Seen);
      end loop;
      CS.N_Items := CS.N_Items + 1;
      CS.Items (CS.N_Items) := It;
   end Add_Item;

   function New_Act
     (N         : in out Names;
      Actor     : String;
      Criterion : String;
      Level     : Rung;
      Reads     : Read_Specs;
      Kind      : Act_Kind := Check) return Act
   is
      A : Act;
   begin
      A.Actor := Actor_Named (N, Actor);
      A.Criterion := Criterion_Named (N, Criterion);
      A.Kind := Kind;
      A.Level := Level;
      for R of Reads loop
         A.N_Reads := A.N_Reads + 1;
         A.Reads (A.N_Reads) :=
           (Id => Veritoid_Named (N, To_String (R.Name)), Ver => R.Ver);
      end loop;
      return A;
   end New_Act;

   procedure Put_CS
     (St : in out Store; CS : Changeset; Expect : Outcome := Accepted)
   is
      O : Outcome;
   begin
      Append (St, Changeset_Record, CS, No_Act, O);
      Assert (O = Expect,
              "changeset outcome " & O'Image & ", expected " & Expect'Image);
   end Put_CS;

   procedure Put_Act
     (St : in out Store; A : Act; Expect : Outcome := Accepted)
   is
      O : Outcome;
   begin
      Append (St, Act_Record, No_CS, A, O);
      Assert (O = Expect,
              "act outcome " & O'Image & ", expected " & Expect'Image);
   end Put_Act;

end Builder;
