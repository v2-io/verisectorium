with Ada.Text_IO; use Ada.Text_IO;
with Vk.Frames;

package body Lab is

   function Tick (Sc : in out Scene) return Natural is
   begin
      Sc.Clock := Sc.Clock + 1;
      return Sc.Clock;
   end Tick;

   procedure Write (Sc : in out Scene; Ln : in out Timeline; P : Id; V : Ver) is
      E : Event := (Present => True, Time => Tick (Sc), What => Write,
                    P => P, V => V, others => <>);
      Pk : Pick;
      Tg : Id;
      Has_Edge : Boolean;
   begin
      for I in Edge_Ix loop
         if I <= 2 then
            Has_Edge := Sc.T (P, V).Refs (Ref_Ix (I)).Present;
            Tg := Sc.T (P, V).Refs (Ref_Ix (I)).Target;
         else
            Has_Edge := Sc.T (P, V).Slots (Slot_Ix (I - 2)).State = Pointing;
            Tg := Sc.T (P, V).Slots (Slot_Ix (I - 2)).Filler;
         end if;
         if Has_Edge then
            Pk := Version_At (Ln, Tg, E.Time);
            if Pk.Selected then
               E.Saw (I) := (Has => True, V => Pk.V);
            end if;
         end if;
      end loop;
      Add (Ln, E);
   end Write;

   procedure Retire (Sc : in out Scene; Ln : in out Timeline; P : Id;
                     Heirs : Id_Set := [others => False]) is
   begin
      Add (Ln, (Present => True, Time => Tick (Sc), What => Retire, P => P,
                Heirs => Heirs, others => <>));
   end Retire;

   procedure Mark (Sc : in out Scene; Ln : in out Timeline; P : Id) is
   begin
      Add (Ln, (Present => True, Time => Tick (Sc), What => Mark, P => P,
                others => <>));
   end Mark;

   procedure Unmark (Sc : in out Scene; Ln : in out Timeline; P : Id) is
   begin
      Add (Ln, (Present => True, Time => Tick (Sc), What => Unmark, P => P,
                others => <>));
   end Unmark;

   procedure Decide (Sc : in out Scene; Ln : in out Timeline; J : Dec_Ix;
                     D : Decision) is
   begin
      Sc.B.Dec (J) := D;
      Add (Ln, (Present => True, Time => Tick (Sc), What => Decide, J => J,
                others => <>));
   end Decide;

   procedure Withdraw (Sc : in out Scene; Ln : in out Timeline; J : Dec_Ix) is
   begin
      Add (Ln, (Present => True, Time => Tick (Sc), What => Withdraw, J => J,
                others => <>));
   end Withdraw;

   procedure Observe (Sc : in out Scene; I : Ev_Ix; E : Evidence) is
   begin
      Sc.B.Ev (I) := E;
      Sc.B.Ev (I).Time := Tick (Sc);
   end Observe;

   function Only (V : Ver) return Ver_Set is
      X : Ver_Set := No_Vers;
   begin
      X (V) := True;
      return X;
   end Only;

   function R (K : Ref_Kind; Target : Id; Need : Warrant := 0;
               Need_Dim : Dim := 1) return Ref is
     (Present => True, K => K, Target => Target,
      Need_Dim => Need_Dim, Need => Need);

   function Hold (P : Id; Provisional : Boolean := False) return Slot is
     (State => Holding, Filler => P, Provisional => Provisional);
   function Point (P : Id; Provisional : Boolean := False) return Slot is
     (State => Pointing, Filler => P, Provisional => Provisional);

   function Rd (Q : Id; W : Ver; Level : Relies := Everything;
                Same : Ver_Set := No_Vers) return Read is
     (Present => True, Q => Q, W => W, Same => Same, Level => Level);

   function Evid (P : Id; V : Ver; D : Dim; C : Crit;
                  Result : Outcome := Holds; Same : Ver_Set := No_Vers;
                  R1, R2 : Read := No_Read) return Evidence is
     (Present => True, P => P, V => V, Same => Same, D => D, C => C,
      Result => Result, Reads => [R1, R2], Time => 0);

   function Claim_V (Says : Assertion := 1; R1, R2 : Ref := (others => <>))
      return Version is
     (Exists => True, K => 1, Says => [Says, 0], Refs => [R1, R2],
      others => <>);

   function Asm_V (K : Kind; S1, S2, S3 : Slot := (others => <>))
      return Version is
     (Exists => True, K => K, Slots => [S1, S2, S3], others => <>);

   function Sound (P : Id) return Condition is
     (What => Asserted_Consistent, P => P, others => <>);

   function Admit_D (P : Id; PVs : Ver_Set; D : Dim) return Decision is
     (Present => True, What => Admit, P => P, PVs => PVs, D => D,
      others => <>);

   function Affirm_D (P : Id; PVs : Ver_Set; Q : Id; QV : Ver;
                      C1 : Condition := No_Cond) return Decision is
     (Present => True, What => Affirm, P => P, PVs => PVs, Q => Q,
      QV => QV, Conds => [C1, No_Cond, No_Cond], others => <>);

   function Promise_D (P : Id; S : Slot_Ix) return Decision is
     (Present => True, What => Promise, P => P, S => S, others => <>);

   function Waive_D (N : Instance) return Decision is
     (Present => True, What => Waive, Inst => N, others => <>);

   function Ask_D (P : Id; D : Dim) return Decision is
     (Present => True, What => Ask, P => P, D => D, others => <>);

   function Aside_D (E : Ev_Ix) return Decision is
     (Present => True, What => Set_Aside, Ev => E, others => <>);

   function Theory (Decided_2 : Boolean := False;
                    Ask_Outline : Boolean := False) return Ontology is
      O : Ontology;
   begin
      O.RK (1) := (Rests => True, Relies_On => Everything,
                   Caps => [True, False]);
      O.RK (2) := (Rests => False, Relies_On => Assertions,
                   Caps => [False, False]);
      O.RK (3) := (Rests => False, Relies_On => Existence,
                   Caps => [False, False]);
      O.Point_Kind := 3;
      O.Dims (1) := (Read_As => [False => [False => 0, True => 1],
                                 True  => [False => 1, True => 2]],
                     Decided => False);
      O.Dims (2) := (Read_As => [False => [False => 0, True => 0],
                                 True  => [False => 1, True => 1]],
                     Decided => Decided_2);
      O.Kinds (1) := (Is_Assembly => False, Opens => [True, False],
                      others => <>);
      O.Kinds (2) := (Is_Assembly => True, Opens => [False, True],
                      Used => [True, True, True],
                      Required => [True, False, False],
                      Deps => [1 => [others => False],
                               2 => [True, False, False],
                               3 => [others => False]]);
      O.Kinds (3) := (Is_Assembly => True, Opens => [False, True],
                      Used => [True, True, True],
                      Required => [others => False],
                      Deps => [others => [others => False]]);
      for KR in Kind range 2 .. 3 loop
         O.Asks (KR, 1, 1) := 1;
         O.Asks (KR, 2, 2) := 1;
         if Decided_2 then
            O.Asks (KR, 1, 2) := 1;
         end if;
         if Ask_Outline then
            O.Asks (KR, 3, 2) := 1;
         end if;
      end loop;
      return O;
   end Theory;

   function St (Sc : Scene; Ln : Timeline) return State is
     (Read_State (Sc.O, Sc.T, Ln, Sc.B, Sc.Clock, Sc.Opt));

   function Image (N : Instance) return String is
     (N.K'Image & "(p" & N.P'Image & (if N.I /= 0 then "," & N.I'Image else "")
      & (if N.J /= 0 then "," & N.J'Image else "") & ")");

   type Tally is record
      Owed, Uncovered : Natural := 0;
   end record;

   function Count (Sc : Scene; Ln : Timeline; Print : Boolean := False)
      return Tally
   is
      S : constant State := St (Sc, Ln);
      C : constant Context := Derive (Sc.O, Sc.T, S.S, S.F);
      X : constant Id_Set := Consistent (Sc.O, Sc.T, S.S, S.F, S.L, C);
      R : Tally;
   begin
      for K in Inst_Kind loop
         for P in Id loop
            for I in Sub loop
               for J in Sub range 0 .. 3 loop
                  if Violated (Sc.O, Sc.T, S.S, S.F, S.L, C, X, (K, P, I, J))
                  then
                     R.Owed := R.Owed + 1;
                     if Covered (Sc.T, S.S, S.F, C, X, (K, P, I, J)) then
                        if Print then
                           Put_Line ("    owed: " & Image ((K, P, I, J))
                                     & "  [waived]");
                        end if;
                     else
                        R.Uncovered := R.Uncovered + 1;
                        if Print then
                           Put_Line ("    owed: " & Image ((K, P, I, J)));
                        end if;
                     end if;
                  end if;
               end loop;
            end loop;
         end loop;
      end loop;
      return R;
   end Count;

   function Owed (Sc : Scene; Ln : Timeline) return Natural is
     (Count (Sc, Ln).Owed);
   function Uncovered (Sc : Scene; Ln : Timeline) return Natural is
     (Count (Sc, Ln).Uncovered);
   function Stationary (Sc : Scene; Ln : Timeline) return Boolean is
     (Count (Sc, Ln).Uncovered = 0);

   function Has (Sc : Scene; Ln : Timeline; K : Inst_Kind; P : Id) return Boolean
   is
      S : constant State := St (Sc, Ln);
      C : constant Context := Derive (Sc.O, Sc.T, S.S, S.F);
      X : constant Id_Set := Consistent (Sc.O, Sc.T, S.S, S.F, S.L, C);
   begin
      for I in Sub loop
         for J in Sub range 0 .. 3 loop
            if Violated (Sc.O, Sc.T, S.S, S.F, S.L, C, X, (K, P, I, J)) then
               return True;
            end if;
         end loop;
      end loop;
      return False;
   end Has;

   function Cons (Sc : Scene; Ln : Timeline) return Id_Set is
      S : constant State := St (Sc, Ln);
   begin
      return Consistent (Sc.O, Sc.T, S.S, S.F, S.L,
                         Derive (Sc.O, Sc.T, S.S, S.F));
   end Cons;

   function Conditions (Sc : Scene; Ln : Timeline) return Natural is
      S : constant State := St (Sc, Ln);
      C : constant Context := Derive (Sc.O, Sc.T, S.S, S.F);
      N : Natural := 0;
   begin
      for P in Id loop
         if S.S (P).Selected and then not S.S (P).Asserted
           and then
             ((for some I in Ev_Ix =>
                 C.App (I) and then S.F.Ev (I).P = P
                 and then S.F.Ev (I).Result /= Holds)
              or else
              (for some D in Dim => (for some Cr in Crit =>
                 S.L.Guard (P, D, Cr))))
         then
            N := N + 1;
         end if;
      end loop;
      return N;
   end Conditions;

   procedure Show (Title : String; Sc : Scene; Ln : Timeline) is
      S : constant State := St (Sc, Ln);
      R : Tally;
   begin
      Put_Line ("  " & Title & "  (time" & Sc.Clock'Image & ")");
      Put ("    selected:");
      for P in Id loop
         if S.S (P).Selected then
            Put (" p" & P'Image (2 .. P'Image'Last) & "@"
                 & S.S (P).V'Image (2 .. S.S (P).V'Image'Last)
                 & (if S.L.Roots (P) then "(root)"
                    elsif S.S (P).Asserted then "" else "(not in canon)"));
         end if;
      end loop;
      New_Line;
      R := Count (Sc, Ln, Print => True);
      if R.Owed = 0 then
         Put_Line ("    frontier empty");
      end if;
   end Show;

   function Region (Sc : Scene; A, M : Timeline) return Id_Set is
      SA : constant State := St (Sc, A);
      SM : constant State := St (Sc, M);
   begin
      return Vk.Frames.Largest_Region
        (Sc.O, Sc.T, SA.S, SA.F, SA.L, SM.S, SM.F, SM.L);
   end Region;

   function Set_Image (R : Id_Set) return String is
     ("{" & (if R (1) then " p1" else "") & (if R (2) then " p2" else "")
      & (if R (3) then " p3" else "") & (if R (4) then " p4" else "")
      & (if R (5) then " p5" else "") & " }");

   function Stationary_On (Sc : Scene; Ln : Timeline; R : Id_Set)
      return Boolean
   is
      S : constant State := St (Sc, Ln);
   begin
      return Vk.Frames.Stationary_On (Sc.O, Sc.T, S.S, S.F, S.L, R);
   end Stationary_On;

   procedure Expect (Cond : Boolean; What : String) is
   begin
      Checks := Checks + 1;
      if Cond then
         Put_Line ("    ok:   " & What);
      else
         Failures := Failures + 1;
         Put_Line ("    FAIL: " & What);
      end if;
   end Expect;

end Lab;
