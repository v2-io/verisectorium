with AUnit.Assertions; use AUnit.Assertions;

package body Fixtures is

   procedure Must_Append (L : in out Log; R : Log_Record; What : String) is
      Why : Refusal;
      Cul : Id_Set;
   begin
      Append (L, R, Why, Cul);
      Assert (Why = Accepted, What & ": refused with " & Why'Image);
   end Must_Append;

   function Try_Append (L : in out Log; R : Log_Record) return Refusal is
      Why : Refusal;
      Cul : Id_Set;
   begin
      Append (L, R, Why, Cul);
      return Why;
   end Try_Append;

end Fixtures;
