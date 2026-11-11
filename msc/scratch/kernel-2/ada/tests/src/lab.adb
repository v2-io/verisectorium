with Ada.Text_IO; use Ada.Text_IO;

package body Lab is

   function Only (V : Ver) return Ver_Set is
      X : Ver_Set := No_Vers;
   begin
      X (V) := True;
      return X;
   end Only;

   function Vers (V1, V2 : Ver) return Ver_Set is
      X : Ver_Set := No_Vers;
   begin
      X (V1) := True;
      X (V2) := True;
      return X;
   end Vers;

   function R (K : Ref_Kind; Target : Id; Need : Warrant := 0;
               Need_Dim : Dim := 1) return Ref is
     (Present => True, K => K, Target => Target,
      Need_Dim => Need_Dim, Need => Need);

   function Hold (P : Id) return Slot is (State => Holding, Filler => P);
   function Point (P : Id) return Slot is (State => Pointing, Filler => P);

   function Rd (Q : Id; W : Ver; Level : Relies := Everything;
                Same : Ver_Set := No_Vers) return Read is
     (Present => True, Q => Q, W => W, Same => Same, Level => Level);

   function Evid (P : Id; V : Ver; D : Dim; C : Crit;
                  Result : Outcome := Holds; Same : Ver_Set := No_Vers;
                  R1, R2 : Read := No_Read) return Evidence is
     (Present => True, P => P, V => V, Same => Same, D => D, C => C,
      Result => Result, Reads => [R1, R2]);

   function Pk (V : Ver; Asserted : Boolean := True) return Pick is
     (Selected => True, V => V, Asserted => Asserted);

   function At_V (P : Id; Vs : Ver_Set) return Condition is
     (What => Selected_At, P => P, Vs => Vs, others => <>);
   function Sound (P : Id) return Condition is
     (What => Asserted_Consistent, P => P, others => <>);
   function W_At_Least (P : Id; D : Dim; W : Warrant) return Condition is
     (What => Warrant_At_Least, P => P, D => D, W => W, others => <>);

   function Admit_D (P : Id; PVs : Ver_Set;
                     C1, C2, C3 : Condition := No_Cond) return Decision is
     (Present => True, What => Admit, P => P, PVs => PVs,
      Conds => [C1, C2, C3], others => <>);

   function Affirm_D (P : Id; PVs : Ver_Set; Q : Id; QV : Ver;
                      QSame : Ver_Set := No_Vers) return Decision is
     (Present => True, What => Affirm, P => P, PVs => PVs, Q => Q,
      QV => QV, QSame => QSame, others => <>);

   function Promise_D (P : Id; S : Slot_Ix;
                       C1 : Condition := No_Cond) return Decision is
     (Present => True, What => Promise, P => P, S => S,
      Conds => [C1, No_Cond, No_Cond], others => <>);

   function Waive_D (N : Instance; C1 : Condition := No_Cond)
      return Decision is
     (Present => True, What => Waive, Inst => N,
      Conds => [C1, No_Cond, No_Cond], others => <>);

   function Ask_D (P : Id; D : Dim; C1 : Condition := No_Cond)
      return Decision is
     (Present => True, What => Ask, P => P, D => D,
      Conds => [C1, No_Cond, No_Cond], others => <>);

   function Aside_D (E : Ev_Ix; C1 : Condition := No_Cond) return Decision is
     (Present => True, What => Set_Aside, Ev => E,
      Conds => [C1, No_Cond, No_Cond], others => <>);

   function Theory (Canon : Canon_Standard := By_Decision) return Ontology is
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
                     Rule_Min => 1);
      O.Dims (2) := (Read_As => [False => [False => 0, True => 0],
                                 True  => [False => 1, True => 1]],
                     Rule_Min => 1);
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
      O.Canon := Canon;
      return O;
   end Theory;

   function Image (N : Instance) return String is
     (N.K'Image & "(p" & N.P'Image & (if N.I /= 0 then "," & N.I'Image else "")
      & (if N.J /= 0 then "," & N.J'Image else "") & ")");

   function Ctx (W : World) return Context is (Derive (W.O, W.T, W.S, W.F));
   function Cons (W : World) return Id_Set is
     (Consistent (W.O, W.T, W.S, W.F, Ctx (W)));

   function Owed (W : World) return Natural is
      C : constant Context := Ctx (W);
      X : constant Id_Set := Consistent (W.O, W.T, W.S, W.F, C);
      N : Natural := 0;
   begin
      for K in Inst_Kind loop
         for P in Id loop
            for I in Sub loop
               for J in Sub loop
                  if Violated (W.O, W.T, W.S, W.F, C, X, (K, P, I, J)) then
                     N := N + 1;
                  end if;
               end loop;
            end loop;
         end loop;
      end loop;
      return N;
   end Owed;

   function Uncovered (W : World) return Natural is
      C : constant Context := Ctx (W);
      X : constant Id_Set := Consistent (W.O, W.T, W.S, W.F, C);
      N : Natural := 0;
   begin
      for K in Inst_Kind loop
         for P in Id loop
            for I in Sub loop
               for J in Sub loop
                  if Violated (W.O, W.T, W.S, W.F, C, X, (K, P, I, J))
                    and then not Covered (W.T, W.S, W.F, C, X, (K, P, I, J))
                  then
                     N := N + 1;
                  end if;
               end loop;
            end loop;
         end loop;
      end loop;
      return N;
   end Uncovered;

   function Stationary (W : World) return Boolean is (Uncovered (W) = 0);

   function Stationary_On (W : World; Ps : Id_Set) return Boolean is
      C : constant Context := Ctx (W);
      X : constant Id_Set := Consistent (W.O, W.T, W.S, W.F, C);
   begin
      for K in Inst_Kind loop
         for P in Id loop
            if Ps (P) then
               for I in Sub loop
                  for J in Sub loop
                     if Violated (W.O, W.T, W.S, W.F, C, X, (K, P, I, J))
                       and then not Covered
                         (W.T, W.S, W.F, C, X, (K, P, I, J))
                     then
                        return False;
                     end if;
                  end loop;
               end loop;
            end if;
         end loop;
      end loop;
      return True;
   end Stationary_On;

   function Has (W : World; K : Inst_Kind; P : Id) return Boolean is
      C : constant Context := Ctx (W);
      X : constant Id_Set := Consistent (W.O, W.T, W.S, W.F, C);
   begin
      for I in Sub loop
         for J in Sub loop
            if Violated (W.O, W.T, W.S, W.F, C, X, (K, P, I, J)) then
               return True;
            end if;
         end loop;
      end loop;
      return False;
   end Has;

   function Fixed (W : World) return Boolean is
      C : constant Context := Ctx (W);
   begin
      return Is_Fixed (W.O, W.T, W.S, W.F, C,
                       Consistent (W.O, W.T, W.S, W.F, C));
   end Fixed;

   procedure Show (Title : String; W : World) is
      C : constant Context := Ctx (W);
      X : constant Id_Set := Consistent (W.O, W.T, W.S, W.F, C);
      Any : Boolean := False;
   begin
      Put_Line ("  " & Title);
      Put ("    selection:");
      for P in Id loop
         if W.S (P).Selected then
            Put (" p" & P'Image (2 .. P'Image'Last) & "@"
                 & W.S (P).V'Image (2 .. W.S (P).V'Image'Last)
                 & (if W.S (P).Asserted then "" else "(not asserted)"));
         end if;
      end loop;
      New_Line;
      for K in Inst_Kind loop
         for P in Id loop
            for I in Sub loop
               for J in Sub loop
                  if Violated (W.O, W.T, W.S, W.F, C, X, (K, P, I, J)) then
                     Any := True;
                     Put_Line
                       ("    owed: " & Image ((K, P, I, J))
                        & (if Covered (W.T, W.S, W.F, C, X, (K, P, I, J))
                           then "  [waived]" else ""));
                  end if;
               end loop;
            end loop;
         end loop;
      end loop;
      if not Any then
         Put_Line ("    frontier empty");
      end if;
   end Show;

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
