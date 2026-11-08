with Builder; use Builder;

package body Worked_Example is

   procedure Build
     (N : out Names; St : out Store; At_Mark : out Marks;
      Affirm_E : Boolean := True)
   is
      CS : Changeset;

      procedure Mark_Here (M : Mark) is
      begin
         At_Mark (M) := Length (St.L);
      end Mark_Here;
   begin
      N := (others => <>);
      St := Empty_Store;
      At_Mark := [others => 0];

      --  S0.  Segment T: c, d, e.  Segment U: u.
      CS := New_CS (N, "A", "T");
      Add_Item (N, CS, "c", 1, Rederived);
      Add_Item (N, CS, "d", 1, Rederived, [Ref ("c", Drafted, 1)]);
      Add_Item (N, CS, "e", 1, Drafted, [Ref ("c", Drafted, 1)]);
      Put_CS (St, CS);

      CS := New_CS (N, "C", "U");
      Add_Item (N, CS, "u", 1, Rederived, [Ref ("c", Rederived, 1)]);
      Put_CS (St, CS);

      Put_Act (St, New_Act (N, "B", "rederive", Rederived,
                            [Rd ("c", 1), Rd ("d", 1)]));
      Put_Act (St, New_Act (N, "A", "check", Drafted, [Rd ("e", 1)]));
      Put_Act (St, New_Act (N, "B", "rederive", Rederived, [Rd ("u", 1)]));
      Mark_Here (S0);

      --  The auditor's finding: A rewrites T.
      CS := New_CS (N, "A", "T");
      Add_Item (N, CS, "c", 2, Rederived);
      Add_Item (N, CS, "d", 2, Rederived, [Ref ("c", Drafted, 1)]);
      if Affirm_E then
         Add_Item (N, CS, "e", 1, Drafted, [Ref ("c", Drafted, 2)],
               Affirmed => True);
      else
         Add_Item (N, CS, "e", 1, Drafted, [Ref ("c", Drafted, 1)]);
      end if;
      Put_CS (St, CS);
      Mark_Here (Perturbed);

      Put_Act (St, New_Act (N, "B", "rederive", Rederived,
                            [Rd ("c", 2), Rd ("d", 2)]));
      Mark_Here (Rederived_1);

      --  A fixes step 3 of d.  e is carried with its references unchanged,
      --  so it needs no affirmation here.
      CS := New_CS (N, "A", "T");
      Add_Item (N, CS, "c", 2, Rederived);
      Add_Item (N, CS, "d", 3, Rederived, [Ref ("c", Drafted, 2)]);
      Add_Item (N, CS, "e", 1, Drafted,
            [Ref ("c", Drafted, (if Affirm_E then 2 else 1))]);
      Put_CS (St, CS);
      Mark_Here (Fixed);

      Put_Act (St, New_Act (N, "B", "rederive", Rederived,
                            [Rd ("c", 2), Rd ("d", 3)]));
      Mark_Here (Rederived_2);

      CS := New_CS (N, "C", "U");
      Add_Item (N, CS, "u", 2, Rederived, [Ref ("c", Rederived, 2)]);
      Put_CS (St, CS);
      Mark_Here (U_Changed);

      Put_Act (St, New_Act (N, "B", "rederive", Rederived, [Rd ("u", 2)]));
      Mark_Here (S1);
   end Build;

end Worked_Example;
