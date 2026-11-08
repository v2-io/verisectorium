--  Test-side helpers: write changesets and acts by name.

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Kernel.Model;          use Kernel.Model;
with Kernel.Store;          use Kernel.Store;
with Kernel.Text;           use Kernel.Text;

package Builder is

   type Read_Spec is record
      Name : Unbounded_String;
      Ver  : Version;
   end record;
   type Read_Specs is array (Positive range <>) of Read_Spec;
   function Rd (Name : String; Ver : Version) return Read_Spec is
     ((To_Unbounded_String (Name), Ver));

   type Ref_Spec is record
      Target : Unbounded_String;
      Needed : Rung;
      Seen   : Version;
   end record;
   type Ref_Specs is array (Positive range <>) of Ref_Spec;
   function Ref (Target : String; Needed : Rung; Seen : Version)
      return Ref_Spec is ((To_Unbounded_String (Target), Needed, Seen));

   function New_CS (N : in out Names; Author, Segment : String)
      return Changeset;

   procedure Add_Item
     (N        : in out Names;
      CS       : in out Changeset;
      Name     : String;
      Ver      : Version;
      Claimed  : Rung;
      Refs     : Ref_Specs := [];
      Affirmed : Boolean := False);

   function New_Act
     (N         : in out Names;
      Actor     : String;
      Criterion : String;
      Level     : Rung;
      Reads     : Read_Specs;
      Kind      : Act_Kind := Check) return Act;

   --  Append and assert the outcome.
   procedure Put_CS
     (St : in out Store; CS : Changeset; Expect : Outcome := Accepted);
   procedure Put_Act
     (St : in out Store; A : Act; Expect : Outcome := Accepted);

   No_Act : constant Act := (others => <>);
   No_CS  : constant Changeset := (others => <>);

end Builder;
