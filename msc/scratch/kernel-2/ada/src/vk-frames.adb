package body Vk.Frames with SPARK_Mode => On is

   function Held_Elsewhere
     (T : Version_Table; S : Selection; A : Id; Sl : Slot_Ix) return Boolean
   is
   begin
      return V_C1_Held (T, S, A, Sl);
   end Held_Elsewhere;

   function Largest_Region
     (O : Ontology; T : Version_Table;
      S1 : Selection; F1 : Facts; L1 : Line_View;
      S2 : Selection; F2 : Facts; L2 : Line_View) return Id_Set
   is
      R : Id_Set := [others => True];
      Struck : Boolean;
   begin
      --  Each round strikes at least one piece or stops; five pieces.
      for Round in 1 .. 6 loop
         Struck := False;
         for P in Id loop
            if R (P)
              and then not Member_OK (O, T, R, S1, F1, L1, S2, F2, L2, P)
            then
               R (P) := False;
               Struck := True;
            end if;
         end loop;
         exit when not Struck;
      end loop;
      --  If the bound was reached without settling, give the empty
      --  region, which agrees trivially.
      if not Agree (O, T, R, S1, F1, L1, S2, F2, L2) then
         R := [others => False];
      end if;
      return R;
   end Largest_Region;

end Vk.Frames;
