--  Random search over small worlds for counterexamples to Q2, Q4, Q5,
--  Q6, Q7 and Q9 of KERNEL-SPEC draft 3, with greedy shrinking of what
--  it finds. Deterministic (a fixed-seed generator), so a run can be
--  repeated. This is sampling, not exhaustive enumeration: "no
--  counterexample in N worlds" is what it can say, never "none exists".
--
--  usage: search [N]      (default 200000 worlds per property)
with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line;
with Interfaces;       use Interfaces;
with Vk;               use Vk;
with Vk.Model;         use Vk.Model;
with Lab;              use Lab;

procedure Search is

   N_Worlds : Natural := 200_000;

   -------------------------------------------------------------------
   --  A small deterministic generator (splitmix64)
   -------------------------------------------------------------------
   State : Unsigned_64 := 16#9E37_79B9_7F4A_7C15#;

   function Next return Unsigned_64 is
      Z : Unsigned_64;
   begin
      State := State + 16#9E37_79B9_7F4A_7C15#;
      Z := State;
      Z := (Z xor Shift_Right (Z, 30)) * 16#BF58_476D_1CE4_E5B9#;
      Z := (Z xor Shift_Right (Z, 27)) * 16#94D0_49BB_1331_11EB#;
      return Z xor Shift_Right (Z, 31);
   end Next;

   function Rnd (N : Positive) return Natural is
     (Natural (Next mod Unsigned_64 (N)));          --  0 .. N-1
   function Chance (Pct : Natural) return Boolean is (Rnd (100) < Pct);

   function R_Id return Id is (Id (1 + Rnd (5)));
   function R_Ver return Ver is (Ver (1 + Rnd (3)));
   function R_Dim return Dim is (Dim (1 + Rnd (2)));
   function R_Crit return Crit is (Crit (1 + Rnd (2)));
   function R_Vers (Pct : Natural) return Ver_Set is
     ([for V in Ver => Chance (Pct)]);
   function R_Relies return Relies is (Relies'Val (Rnd (3)));

   -------------------------------------------------------------------
   --  Generation
   -------------------------------------------------------------------
   type Gen_Opts is record
      Monotone     : Boolean := True;   --  read_as monotone
      Stratified   : Boolean := True;   --  no consistency cond on non accept/affirm
      Plain_Oblig  : Boolean := True;   --  promise/ask conditions are plain
      Force_Guards : Boolean := False;
   end record;

   function Gen_Cond (Allow_Sound, Allow_Warrant : Boolean) return Condition
   is
      C : Condition;
   begin
      if not Chance (25) then
         return C;
      end if;
      C.P := R_Id;
      case Rnd (4) is
         when 0 => C.What := Selected_At; C.Vs := R_Vers (50);
         when 1 =>
            if Allow_Warrant then
               C.What := Warrant_At_Least;
               C.D := R_Dim;
               C.W := Warrant (Rnd (3));
            end if;
         when 2 =>
            if Allow_Sound then
               C.What := Asserted_Consistent;
            end if;
         when others =>
            C.What := Slot_Filled;
            C.S := Slot_Ix (1 + Rnd (3));
            C.Filler := R_Id;
      end case;
      return C;
   end Gen_Cond;

   function Gen_Decision (G : Gen_Opts) return Decision is
      D : Decision;
      Plain : Boolean;
   begin
      D.Present := True;
      D.What := Dec_Kind'Val (Rnd (6));
      D.P := R_Id;
      D.PVs := R_Vers (60);
      D.Q := R_Id;
      D.QV := R_Ver;
      D.QSame := R_Vers (20);
      D.S := Slot_Ix (1 + Rnd (3));
      D.D := R_Dim;
      D.Inst := (K => Inst_Kind'Val (Rnd (15)), P => R_Id,
                 I => Sub (Rnd (4)), J => Sub (Rnd (3)));
      D.Ev := Ev_Ix (1 + Rnd (12));
      D.Withdrawn := Chance (10);
      Plain := D.What = Set_Aside
        or else (G.Plain_Oblig and then D.What in Promise | Ask);
      for K in Cond_Ix loop
         D.Conds (K) := Gen_Cond
           (Allow_Sound   => not Plain
              and then (D.What in Admit | Affirm or else not G.Stratified),
            Allow_Warrant => not Plain);
      end loop;
      return D;
   end Gen_Decision;

   function Gen_Evidence return Evidence is
      E : Evidence;
   begin
      E.Present := True;
      E.P := R_Id;
      E.V := R_Ver;
      E.Same := R_Vers (20);
      E.D := R_Dim;
      E.C := R_Crit;
      E.Result := (if Chance (60) then Holds
                   elsif Chance (50) then Fails else Part);
      for R in Read_Ix loop
         if Chance (25) then
            E.Reads (R) := (Present => True, Q => R_Id, W => R_Ver,
                            Same => R_Vers (20), Level => R_Relies);
         end if;
      end loop;
      return E;
   end Gen_Evidence;

   function Gen (G : Gen_Opts) return World is
      W : World;
      Is_Asm : array (Id) of Boolean;
      Kd     : array (Id) of Kind;
   begin
      --  Ontology
      for K in Ref_Kind loop
         W.O.RK (K) := (Rests => Chance (50), Relies_On => R_Relies,
                        Caps => [for D in Dim => Chance (40)]);
      end loop;
      for D in Dim loop
         declare
            A, B, C, E : Warrant;
         begin
            if G.Monotone then
               A := Warrant (Rnd (2));
               B := Warrant (Natural (A) + Rnd (2));
               C := Warrant (Natural (A) + Rnd (2));
               E := Warrant (Natural (Warrant'Max (B, C)) + Rnd (2));
            else
               A := Warrant (Rnd (4));
               B := Warrant (Rnd (4));
               C := Warrant (Rnd (4));
               E := Warrant (Rnd (4));
            end if;
            W.O.Dims (D) :=
              (Read_As => [False => [False => A, True => C],
                           True  => [False => B, True => E]],
               Rule_Min => Warrant (Rnd (3)));
         end;
      end loop;
      W.O.Kinds (1) := (Is_Assembly => False,
                        Opens => [for D in Dim => Chance (70)],
                        others => <>);
      for K in Kind range 2 .. 3 loop
         W.O.Kinds (K) :=
           (Is_Assembly => True,
            Opens    => [for D in Dim => Chance (50)],
            Used     => [for S in Slot_Ix => Chance (85)],
            Required => [for S in Slot_Ix => Chance (25)],
            Deps     => [for A in Slot_Ix =>
                           [for B in Slot_Ix => A /= B and then Chance (15)]]);
      end loop;
      W.O.Point_Kind := Ref_Kind (1 + Rnd (3));
      W.O.Canon := Canon_Standard'Val (Rnd (3));
      W.O.Guards_On := G.Force_Guards or else Chance (80);
      W.O.Reads_On := Chance (70);
      W.O.Set_Aside_On := Chance (70);
      W.O.Waived_Is_Consistent := Chance (30);
      W.O.Slot_Needs_Consistent := Chance (60);
      W.O.Redirect := Chance (60);

      --  Versions
      for P in Id loop
         Is_Asm (P) := Chance (35);
         Kd (P) := (if Is_Asm (P) then Kind (2 + Rnd (2)) else 1);
         for V in Ver loop
            if V = 1 or else Chance (75) then
               W.T (P, V).Exists := True;
               W.T (P, V).K := Kd (P);
               W.T (P, V).Says := [for D in Dim => Assertion (Rnd (3))];
               for I in Ref_Ix loop
                  if Chance (30) then
                     W.T (P, V).Refs (I) :=
                       (Present => True, K => Ref_Kind (1 + Rnd (3)),
                        Target => R_Id, Need_Dim => R_Dim,
                        Need => (if Chance (25) then Warrant (1 + Rnd (2))
                                 else 0));
                  end if;
               end loop;
               if Is_Asm (P) or else Chance (3) then
                  for S in Slot_Ix loop
                     if Chance (50) then
                        W.T (P, V).Slots (S) :=
                          (State => (if Chance (50) then Holding
                                     else Pointing),
                           Filler => R_Id);
                     end if;
                  end loop;
               end if;
               if Chance (10) then
                  W.T (P, V).Claims :=
                    (Present => True, About => R_Id, D => R_Dim,
                     Level => Warrant (1 + Rnd (3)));
               end if;
               if Chance (10) then
                  W.T (P, V).Reports :=
                    (Present => True, Dec => Dec_Ix (1 + Rnd (12)));
               end if;
            end if;
         end loop;
      end loop;

      --  Selection
      for P in Id loop
         if Chance (80) then
            declare
               V : Ver := R_Ver;
            begin
               if not W.T (P, V).Exists then
                  V := 1;
               end if;
               W.S (P) := (Selected => True, V => V,
                           Asserted => Chance (75));
            end;
         end if;
      end loop;

      --  Facts
      for I in Ev_Ix loop
         if Chance (40) then
            W.F.Ev (I) := Gen_Evidence;
         end if;
      end loop;
      for J in Dec_Ix loop
         if Chance (45) then
            W.F.Dec (J) := Gen_Decision (G);
         end if;
      end loop;
      for A in Id loop
         for B in Id loop
            if A < B and then Chance (8) then
               W.F.Desc (A, B) := True;      --  acyclic by construction
            end if;
         end loop;
      end loop;
      for K in Id loop
         for A in Id loop
            for B in Id loop
               if W.F.Desc (A, K) and then W.F.Desc (K, B) then
                  W.F.Desc (A, B) := True;
               end if;
            end loop;
         end loop;
      end loop;
      return W;
   end Gen;

   -------------------------------------------------------------------
   --  Frontiers as values
   -------------------------------------------------------------------
   type Front is array (Inst_Kind, Id, Sub, Sub) of Boolean;

   function Frontier (W : World) return Front is
      C : constant Context := Ctx (W);
      X : constant Id_Set := Consistent (W.O, W.T, W.S, W.F, C);
      Fr : Front := [others => [others => [others => [others => False]]]];
   begin
      for K in Inst_Kind loop
         for P in Id loop
            if W.S (P).Asserted then
               for I in Sub loop
                  for J in Sub range 0 .. 3 loop
                     Fr (K, P, I, J) :=
                       Violated (W.O, W.T, W.S, W.F, C, X, (K, P, I, J));
                  end loop;
               end loop;
            end if;
         end loop;
      end loop;
      return Fr;
   end Frontier;

   function Subset (A, B : Front) return Boolean is
     (for all K in Inst_Kind => (for all P in Id => (for all I in Sub =>
        (for all J in Sub => (if A (K, P, I, J) then B (K, P, I, J))))));

   function Same_On (A, B : Front; Ps : Id_Set) return Boolean is
     (for all K in Inst_Kind => (for all P in Id => (for all I in Sub =>
        (for all J in Sub =>
           (if Ps (P) then A (K, P, I, J) = B (K, P, I, J))))));

   function First_Extra
     (A, B : Front; Ps : Id_Set := [others => True]) return String is
   begin
      for K in Inst_Kind loop
         for P in Id loop
            for I in Sub loop
               for J in Sub loop
                  if Ps (P) and then A (K, P, I, J)
                    and then not B (K, P, I, J)
                  then
                     return Image ((K, P, I, J));
                  end if;
               end loop;
            end loop;
         end loop;
      end loop;
      return "(none)";
   end First_Extra;

   -------------------------------------------------------------------
   --  Printing a world
   -------------------------------------------------------------------
   function Img (N : Integer) return String is
      S : constant String := N'Image;
   begin
      return (if N >= 0 then S (2 .. S'Last) else S);
   end Img;

   function Img (Vs : Ver_Set) return String is
     ("{" & (if Vs (1) then "1" else "") & (if Vs (2) then "2" else "")
      & (if Vs (3) then "3" else "") & "}");

   function Img (C : Condition) return String is
     (case C.What is
        when None => "",
        when Selected_At => " if p" & Img (Integer (C.P)) & "@" & Img (C.Vs),
        when Warrant_At_Least =>
          " if warrant(p" & Img (Integer (C.P)) & ",d" & Img (Integer (C.D))
          & ")>=" & Img (Integer (C.W)),
        when Asserted_Consistent =>
          " if p" & Img (Integer (C.P)) & " consistent",
        when Slot_Filled =>
          " if p" & Img (Integer (C.P)) & ".slot" & Img (Integer (C.S))
          & "=p" & Img (Integer (C.Filler)));

   procedure Dump (W : World) is
   begin
      Put_Line ("      ontology: canon " & W.O.Canon'Image
                & "; guards " & W.O.Guards_On'Image
                & "; reads " & W.O.Reads_On'Image
                & "; set-aside " & W.O.Set_Aside_On'Image
                & "; waived-is-consistent " & W.O.Waived_Is_Consistent'Image
                & "; slot-needs-consistent " & W.O.Slot_Needs_Consistent'Image
                & "; redirect " & W.O.Redirect'Image
                & "; pointing is kind" & W.O.Point_Kind'Image);
      for K in Ref_Kind loop
         Put_Line ("      ref kind" & K'Image & ": rests "
                   & W.O.RK (K).Rests'Image & ", relies on "
                   & W.O.RK (K).Relies_On'Image & ", caps d1 "
                   & W.O.RK (K).Caps (1)'Image & " d2 "
                   & W.O.RK (K).Caps (2)'Image);
      end loop;
      for D in Dim loop
         Put_Line ("      dim" & D'Image & ": read_as(none,c2,c1,both) ="
                   & W.O.Dims (D).Read_As (False, False)'Image
                   & W.O.Dims (D).Read_As (False, True)'Image
                   & W.O.Dims (D).Read_As (True, False)'Image
                   & W.O.Dims (D).Read_As (True, True)'Image
                   & "; rule asks" & W.O.Dims (D).Rule_Min'Image);
      end loop;
      for P in Id loop
         if W.S (P).Selected then
            declare
               V : constant Version := W.T (P, W.S (P).V);
               Kd : constant Kind_Decl := W.O.Kinds (V.K);
            begin
               Put ("      p" & Img (Integer (P)) & "@"
                    & Img (Integer (W.S (P).V))
                    & (if W.S (P).Asserted then " asserted" else " selected")
                    & (if Kd.Is_Assembly then " assembly" else " veritoid")
                    & " kind" & V.K'Image);
               for I in Ref_Ix loop
                  if V.Refs (I).Present then
                     Put ("; ref kind" & V.Refs (I).K'Image & " -> p"
                          & Img (Integer (V.Refs (I).Target))
                          & (if V.Refs (I).Need > 0 then
                               " needs" & V.Refs (I).Need'Image & " on d"
                               & Img (Integer (V.Refs (I).Need_Dim))
                             else ""));
                  end if;
               end loop;
               for S in Slot_Ix loop
                  if V.Slots (S).State /= Empty then
                     Put ("; slot" & S'Image & " " & V.Slots (S).State'Image
                          & " p" & Img (Integer (V.Slots (S).Filler))
                          & (if Kd.Is_Assembly and then Kd.Required (S)
                             then " (required)" else ""));
                  elsif Kd.Is_Assembly and then Kd.Required (S) then
                     Put ("; slot" & S'Image & " empty (required)");
                  end if;
               end loop;
               if V.Claims.Present then
                  Put ("; claims p" & Img (Integer (V.Claims.About))
                       & " stands at" & V.Claims.Level'Image & " on d"
                       & Img (Integer (V.Claims.D)));
               end if;
               if V.Reports.Present then
                  Put ("; reports decision" & V.Reports.Dec'Image);
               end if;
               New_Line;
            end;
         end if;
      end loop;
      for I in Ev_Ix loop
         if W.F.Ev (I).Present then
            declare
               E : constant Evidence := W.F.Ev (I);
            begin
               Put ("      evidence" & I'Image & ": p" & Img (Integer (E.P))
                    & "@" & Img (Integer (E.V)) & " d" & Img (Integer (E.D))
                    & " c" & Img (Integer (E.C)) & " " & E.Result'Image
                    & (if E.Same /= No_Vers then " same" & Img (E.Same)
                       else ""));
               for R in Read_Ix loop
                  if E.Reads (R).Present then
                     Put ("; read p" & Img (Integer (E.Reads (R).Q)) & "@"
                          & Img (Integer (E.Reads (R).W)) & " "
                          & E.Reads (R).Level'Image
                          & (if E.Reads (R).Same /= No_Vers then
                               " same" & Img (E.Reads (R).Same) else ""));
                  end if;
               end loop;
               New_Line;
            end;
         end if;
      end loop;
      for J in Dec_Ix loop
         if W.F.Dec (J).Present then
            declare
               D : constant Decision := W.F.Dec (J);
            begin
               Put ("      decision" & J'Image & ": " & D.What'Image);
               case D.What is
                  when Admit =>
                     Put (" p" & Img (Integer (D.P)) & "@" & Img (D.PVs));
                  when Affirm =>
                     Put (" p" & Img (Integer (D.P)) & "@" & Img (D.PVs)
                          & " against p" & Img (Integer (D.Q)) & "@"
                          & Img (Integer (D.QV)));
                  when Promise =>
                     Put (" p" & Img (Integer (D.P)) & ".slot"
                          & Img (Integer (D.S)));
                  when Waive => Put (" " & Image (D.Inst));
                  when Ask =>
                     Put (" p" & Img (Integer (D.P)) & " on d"
                          & Img (Integer (D.D)));
                  when Set_Aside => Put (" evidence" & D.Ev'Image);
               end case;
               for K in Cond_Ix loop
                  Put (Img (D.Conds (K)));
               end loop;
               if D.Withdrawn then
                  Put (" WITHDRAWN");
               end if;
               New_Line;
            end;
         end if;
      end loop;
      for A in Id loop
         for B in Id loop
            if W.F.Desc (A, B) then
               Put_Line ("      descent: p" & Img (Integer (B))
                         & " descends from p" & Img (Integer (A)));
            end if;
         end loop;
      end loop;
   end Dump;

   -------------------------------------------------------------------
   --  Shrinking: drop things one at a time while Bad still holds
   -------------------------------------------------------------------
   type Bad_Fn is access function (W : World) return Boolean;

   procedure Shrink (W : in out World; Bad : Bad_Fn) is
      Changed : Boolean := True;
      Try : World;
   begin
      while Changed loop
         Changed := False;
         for I in Ev_Ix loop
            if W.F.Ev (I).Present then
               Try := W;
               Try.F.Ev (I) := (others => <>);
               if Bad (Try) then
                  W := Try; Changed := True;
               else
                  for R in Read_Ix loop
                     if W.F.Ev (I).Reads (R).Present then
                        Try := W;
                        Try.F.Ev (I).Reads (R) := (others => <>);
                        if Bad (Try) then
                           W := Try; Changed := True;
                        end if;
                     end if;
                  end loop;
                  if W.F.Ev (I).Same /= No_Vers then
                     Try := W;
                     Try.F.Ev (I).Same := No_Vers;
                     if Bad (Try) then
                        W := Try; Changed := True;
                     end if;
                  end if;
               end if;
            end if;
         end loop;
         for J in Dec_Ix loop
            if W.F.Dec (J).Present then
               Try := W;
               Try.F.Dec (J) := (others => <>);
               if Bad (Try) then
                  W := Try; Changed := True;
               else
                  for K in Cond_Ix loop
                     if W.F.Dec (J).Conds (K).What /= None then
                        Try := W;
                        Try.F.Dec (J).Conds (K) := (others => <>);
                        if Bad (Try) then
                           W := Try; Changed := True;
                        end if;
                     end if;
                  end loop;
               end if;
            end if;
         end loop;
         for A in Id loop
            for B in Id loop
               if W.F.Desc (A, B) then
                  Try := W;
                  Try.F.Desc (A, B) := False;
                  if Bad (Try) then
                     W := Try; Changed := True;
                  end if;
               end if;
            end loop;
         end loop;
         for P in Id loop
            if W.S (P).Selected then
               Try := W;
               Try.S (P) := (others => <>);
               if Bad (Try) then
                  W := Try; Changed := True;
               else
                  if W.S (P).Asserted then
                     Try := W;
                     Try.S (P).Asserted := False;
                     if Bad (Try) then
                        W := Try; Changed := True;
                     end if;
                  end if;
                  for I in Ref_Ix loop
                     if W.T (P, W.S (P).V).Refs (I).Present then
                        Try := W;
                        Try.T (P, W.S (P).V).Refs (I) := (others => <>);
                        if Bad (Try) then
                           W := Try; Changed := True;
                        end if;
                     end if;
                  end loop;
                  for S in Slot_Ix loop
                     if W.T (P, W.S (P).V).Slots (S).State /= Empty then
                        Try := W;
                        Try.T (P, W.S (P).V).Slots (S) := (others => <>);
                        if Bad (Try) then
                           W := Try; Changed := True;
                        end if;
                     end if;
                  end loop;
                  if W.T (P, W.S (P).V).Claims.Present then
                     Try := W;
                     Try.T (P, W.S (P).V).Claims := (others => <>);
                     if Bad (Try) then
                        W := Try; Changed := True;
                     end if;
                  end if;
                  if W.T (P, W.S (P).V).Reports.Present then
                     Try := W;
                     Try.T (P, W.S (P).V).Reports := (others => <>);
                     if Bad (Try) then
                        W := Try; Changed := True;
                     end if;
                  end if;
               end if;
            end if;
         end loop;
      end loop;
   end Shrink;

   -------------------------------------------------------------------
   --  Q4: good facts do no harm
   -------------------------------------------------------------------
   type Good_Kind is
     (Holds_Evidence, Same_For_Holds, Same_For_Any, Admit_Dec, Affirm_Dec);

   --  The fact to add is held in globals so that the Bad function for
   --  shrinking can be a plain access-to-function.
   Add_Kind : Good_Kind;
   Add_Ev_I : Ev_Ix;
   Add_Ev   : Evidence;
   Add_Ver  : Ver;
   Add_Dec_J : Dec_Ix;
   Add_Dec  : Decision;

   function With_Added (W : World) return World is
      W2 : World := W;
   begin
      case Add_Kind is
         when Holds_Evidence =>
            W2.F.Ev (Add_Ev_I) := Add_Ev;
         when Same_For_Holds | Same_For_Any =>
            W2.F.Ev (Add_Ev_I).Same (Add_Ver) := True;
         when Admit_Dec | Affirm_Dec =>
            W2.F.Dec (Add_Dec_J) := Add_Dec;
      end case;
      return W2;
   end With_Added;

   function Q4_Applicable (W : World) return Boolean is
     (case Add_Kind is
        when Holds_Evidence => not W.F.Ev (Add_Ev_I).Present,
        when Same_For_Holds =>
          W.F.Ev (Add_Ev_I).Present
          and then W.F.Ev (Add_Ev_I).Result = Holds
          and then not W.F.Ev (Add_Ev_I).Same (Add_Ver),
        when Same_For_Any =>
          W.F.Ev (Add_Ev_I).Present
          and then not W.F.Ev (Add_Ev_I).Same (Add_Ver),
        when Admit_Dec | Affirm_Dec => not W.F.Dec (Add_Dec_J).Present);

   function Q4_Bad (W : World) return Boolean is
     (Q4_Applicable (W)
      and then not Subset (Frontier (With_Added (W)), Frontier (W)));

   procedure Run_Q4 (Name : String; G : Gen_Opts; GK : Good_Kind) is
      W : World;
      Tried, Bad_N : Natural := 0;
      Shown : Boolean := False;
   begin
      for N in 1 .. N_Worlds loop
         W := Gen (G);
         Add_Kind := GK;
         Add_Ev_I := Ev_Ix (1 + Rnd (12));
         Add_Ev := Gen_Evidence;
         Add_Ev.Result := Holds;
         Add_Ver := R_Ver;
         Add_Dec_J := Dec_Ix (1 + Rnd (12));
         Add_Dec := Gen_Decision (G);
         Add_Dec.What := (if GK = Affirm_Dec then Affirm else Admit);
         Add_Dec.Withdrawn := False;
         if GK in Admit_Dec | Affirm_Dec then
            for K in Cond_Ix loop
               Add_Dec.Conds (K) := Gen_Cond (True, True);
            end loop;
         end if;
         if Q4_Applicable (W) then
            Tried := Tried + 1;
            if Q4_Bad (W) then
               Bad_N := Bad_N + 1;
               if not Shown then
                  Shown := True;
                  Shrink (W, Q4_Bad'Access);
                  Put_Line ("    smallest found (after shrinking); adding "
                            & GK'Image & " puts "
                            & First_Extra (Frontier (With_Added (W)),
                                           Frontier (W))
                            & " on the frontier:");
                  Dump (W);
                  case GK is
                     when Holds_Evidence =>
                        Put_Line ("      ADD evidence" & Add_Ev_I'Image
                                  & ": p" & Img (Integer (Add_Ev.P)) & "@"
                                  & Img (Integer (Add_Ev.V)) & " d"
                                  & Img (Integer (Add_Ev.D)) & " c"
                                  & Img (Integer (Add_Ev.C)) & " HOLDS");
                     when Same_For_Holds | Same_For_Any =>
                        Put_Line ("      ADD same: evidence" & Add_Ev_I'Image
                                  & " also at version" & Add_Ver'Image);
                     when Admit_Dec | Affirm_Dec =>
                        Put_Line ("      ADD decision" & Add_Dec_J'Image
                                  & " " & Add_Dec.What'Image & " p"
                                  & Img (Integer (Add_Dec.P)));
                  end case;
               end if;
            end if;
         end if;
      end loop;
      Put_Line ("  " & Name & ": " & Img (Tried) & " tried, "
                & Img (Bad_N) & " counterexamples");
   end Run_Q4;

   -------------------------------------------------------------------
   --  Q2: dead ends are inert
   -------------------------------------------------------------------
   function Q2_Dead (W : World) return Boolean is
     --  Add_Ev is about a version nothing selects, reaches none by
     --  same, and (if it does not hold) guards nothing selected.
     (not (W.S (Add_Ev.P).Selected
           and then (W.S (Add_Ev.P).V = Add_Ev.V
                     or else Add_Ev.Same (W.S (Add_Ev.P).V)))
      and then
        (Add_Ev.Result = Holds or else not W.O.Guards_On
         or else
           (not W.S (Add_Ev.P).Selected
            and then (for all B in Id =>
                        (if W.F.Desc (Add_Ev.P, B) then
                           not W.S (B).Selected)))));

   function Q2_Bad (W : World) return Boolean is
     (not W.F.Ev (Add_Ev_I).Present and then Q2_Dead (W)
      and then Frontier (With_Added (W)) /= Frontier (W));

   procedure Run_Q2 (G : Gen_Opts) is
      W : World;
      Tried, Bad_N : Natural := 0;
   begin
      Add_Kind := Holds_Evidence;     --  reused: "add Add_Ev at Add_Ev_I"
      for N in 1 .. N_Worlds loop
         W := Gen (G);
         Add_Ev_I := Ev_Ix (1 + Rnd (12));
         Add_Ev := Gen_Evidence;
         if not W.F.Ev (Add_Ev_I).Present and then Q2_Dead (W) then
            Tried := Tried + 1;
            if Q2_Bad (W) then
               Bad_N := Bad_N + 1;
               if Bad_N = 1 then
                  Shrink (W, Q2_Bad'Access);
                  Put_Line ("    smallest found: adding dead evidence"
                            & Add_Ev_I'Image & " (p"
                            & Img (Integer (Add_Ev.P)) & "@"
                            & Img (Integer (Add_Ev.V)) & " "
                            & Add_Ev.Result'Image & ") changes the frontier:");
                  Dump (W);
               end if;
            end if;
         end if;
      end loop;
      Put_Line ("  Q2 dead evidence is inert: " & Img (Tried) & " tried, "
                & Img (Bad_N) & " counterexamples");
   end Run_Q2;

   -------------------------------------------------------------------
   --  Q5: a known defect cannot be selected away
   -------------------------------------------------------------------
   procedure Run_Q5 is
      W : World;
      Tried, Bad_N : Natural := 0;
      G : constant Gen_Opts := (Force_Guards => True, others => <>);
   begin
      for N in 1 .. N_Worlds loop
         W := Gen (G);
         declare
            C : constant Context := Ctx (W);
            X : constant Id_Set := Consistent (W.O, W.T, W.S, W.F, C);
         begin
            for I in Ev_Ix loop
               if W.F.Ev (I).Present and then W.F.Ev (I).Result /= Holds
                 and then not Aside (W.O, W.T, W.S, W.F, I)
               then
                  for Q in Id loop
                     if W.S (Q).Asserted
                       and then (Q = W.F.Ev (I).P
                                 or else W.F.Desc (W.F.Ev (I).P, Q))
                       and then not Has_Holds_C
                         (W.F, C, Q, W.F.Ev (I).D, W.F.Ev (I).C)
                     then
                        Tried := Tried + 1;
                        if not Violated
                          (W.O, W.T, W.S, W.F, C, X,
                           (C6_Guard, Q, Sub (W.F.Ev (I).D),
                            Sub (W.F.Ev (I).C)))
                        then
                           Bad_N := Bad_N + 1;
                        end if;
                     end if;
                  end loop;
               end if;
            end loop;
         end;
      end loop;
      Put_Line ("  Q5 (guards on) a failing fact not set aside, about p or "
                & "an ancestor, with no holding evidence on its criterion "
                & "applying, puts C6 on the frontier of every asserted "
                & "version: " & Img (Tried) & " cases, " & Img (Bad_N)
                & " counterexamples");
   end Run_Q5;

   -------------------------------------------------------------------
   --  Q6: well defined
   -------------------------------------------------------------------
   procedure Run_Q6 is
      W : World;
      Strat_N, Strat_Unfixed, Strat_Not_Greatest, Many_Fixed : Natural := 0;
      Free_N, Free_Unfixed, Free_None : Natural := 0;
      Acyc_N, Acyc_Not_Unique, Cyc_N, Cyc_Many, Not_Solution : Natural := 0;
      Shown_Many : Boolean := False;
   begin
      for N in 1 .. N_Worlds loop
         W := Gen ((Stratified => N mod 2 = 0, others => <>));
         declare
            C : constant Context := Ctx (W);
            X : constant Id_Set := Consistent (W.O, W.T, W.S, W.F, C);
            Fx : constant Boolean := Is_Fixed (W.O, W.T, W.S, W.F, C, X);
            N_Fixed : Natural := 0;
            Greatest : Boolean := True;
            Y : Id_Set;
         begin
            for M in 0 .. 31 loop
               Y := [for P in Id => (M / 2 ** (Integer (P) - 1)) mod 2 = 1];
               if Is_Fixed (W.O, W.T, W.S, W.F, C, Y) then
                  N_Fixed := N_Fixed + 1;
                  if not (for all P in Id => (if Y (P) then X (P))) then
                     Greatest := False;
                  end if;
               end if;
            end loop;
            if Stratified (W.F) then
               Strat_N := Strat_N + 1;
               if not Fx then
                  Strat_Unfixed := Strat_Unfixed + 1;
               end if;
               if not Greatest then
                  Strat_Not_Greatest := Strat_Not_Greatest + 1;
               end if;
               if N_Fixed > 1 then
                  Many_Fixed := Many_Fixed + 1;
                  if not Shown_Many and then Owed (W) < 4 then
                     Shown_Many := True;
                     Put_Line ("    a stratified world with" & N_Fixed'Image
                               & " fixed points (the greatest is taken):");
                     Dump (W);
                  end if;
               end if;
            else
               Free_N := Free_N + 1;
               if not Fx then
                  Free_Unfixed := Free_Unfixed + 1;
               end if;
               if N_Fixed = 0 then
                  Free_None := Free_None + 1;
               end if;
            end if;

            --  The cap: count the solutions of the equations by brute
            --  force, one dimension at a time (4**5 tables each).
            if N mod 20 = 0 then
               for D in Dim loop
                  declare
                     E : Warrant_Table := C.Eff;
                     Sols : Natural := 0;
                     Any_Cyc : constant Boolean :=
                       (for some P in Id => C.Cyc (P));
                  begin
                     if not Is_Cap_Solution (W.O, W.T, W.S, C.Own, C.Eff, D)
                     then
                        Not_Solution := Not_Solution + 1;
                     end if;
                     for M in 0 .. 4 ** 5 - 1 loop
                        for P in Id loop
                           E (P, D) := Warrant
                             ((M / 4 ** (Integer (P) - 1)) mod 4);
                        end loop;
                        if Is_Cap_Solution (W.O, W.T, W.S, C.Own, E, D) then
                           Sols := Sols + 1;
                        end if;
                     end loop;
                     if Any_Cyc then
                        Cyc_N := Cyc_N + 1;
                        if Sols > 1 then
                           Cyc_Many := Cyc_Many + 1;
                        end if;
                     else
                        Acyc_N := Acyc_N + 1;
                        if Sols /= 1 then
                           Acyc_Not_Unique := Acyc_Not_Unique + 1;
                        end if;
                     end if;
                  end;
               end loop;
            end if;
         end;
      end loop;
      Put_Line ("  Q6 consistency, stratified facts: " & Img (Strat_N)
                & " worlds; result not a fixed point: " & Img (Strat_Unfixed)
                & "; some fixed point not below it: "
                & Img (Strat_Not_Greatest)
                & "; worlds with more than one fixed point: "
                & Img (Many_Fixed));
      Put_Line ("  Q6 consistency, unstratified facts: " & Img (Free_N)
                & " worlds; result not a fixed point: " & Img (Free_Unfixed)
                & "; worlds with NO fixed point at all: " & Img (Free_None));
      Put_Line ("  Q6 effective, no capping cycle: " & Img (Acyc_N)
                & " (world, dimension) pairs; not exactly one solution: "
                & Img (Acyc_Not_Unique));
      Put_Line ("  Q6 effective, with a capping cycle: " & Img (Cyc_N)
                & " pairs; more than one solution: " & Img (Cyc_Many)
                & "; computed table not a solution (either case): "
                & Img (Not_Solution));
   end Run_Q6;

   -------------------------------------------------------------------
   --  Q7: locality
   -------------------------------------------------------------------
   type Closure_Opts is record
      Holders, Descent, Reported, Aside_Conds, Waive_Conds : Boolean := True;
   end record;

   function Mentions (D : Decision; Ps : Id_Set) return Boolean is
     (for some K in Cond_Ix => D.Conds (K).What /= None
                               and then Ps (D.Conds (K).P));

   --  The least set containing Seed and closed under what an instance
   --  about a member can read, over EVERY version of each member (the
   --  outside may be reselected, the inside may not, but closure over
   --  all versions is simpler to state and is what a region is).
   function Close (W : World; Seed : Id_Set; CO : Closure_Opts) return Id_Set
   is
      Rg : Id_Set := Seed;
      Changed : Boolean := True;
      procedure Add (P : Id) is
      begin
         if not Rg (P) then
            Rg (P) := True;
            Changed := True;
         end if;
      end Add;
      procedure Add_Conds (D : Decision) is
      begin
         for K in Cond_Ix loop
            if D.Conds (K).What /= None then
               Add (D.Conds (K).P);
               if D.Conds (K).What = Slot_Filled then
                  null;
               end if;
            end if;
         end loop;
      end Add_Conds;
   begin
      while Changed loop
         Changed := False;
         for P in Id loop
            if Rg (P) then
               for V in Ver loop
                  if W.T (P, V).Exists then
                     for I in Ref_Ix loop
                        if W.T (P, V).Refs (I).Present then
                           Add (W.T (P, V).Refs (I).Target);
                        end if;
                     end loop;
                     for S in Slot_Ix loop
                        if W.T (P, V).Slots (S).State /= Empty then
                           Add (W.T (P, V).Slots (S).Filler);
                        end if;
                     end loop;
                     if W.T (P, V).Claims.Present then
                        Add (W.T (P, V).Claims.About);
                     end if;
                     if CO.Reported and then W.T (P, V).Reports.Present then
                        Add (W.F.Dec (W.T (P, V).Reports.Dec).P);
                        Add_Conds (W.F.Dec (W.T (P, V).Reports.Dec));
                     end if;
                  end if;
               end loop;
               for I in Ev_Ix loop
                  if W.F.Ev (I).Present and then W.F.Ev (I).P = P then
                     for R in Read_Ix loop
                        if W.F.Ev (I).Reads (R).Present then
                           Add (W.F.Ev (I).Reads (R).Q);
                        end if;
                     end loop;
                  end if;
               end loop;
               for J in Dec_Ix loop
                  if W.F.Dec (J).Present then
                     if W.F.Dec (J).What in Admit | Affirm | Promise | Ask
                       and then W.F.Dec (J).P = P
                     then
                        Add_Conds (W.F.Dec (J));
                        if W.F.Dec (J).What = Affirm then
                           Add (W.F.Dec (J).Q);
                        end if;
                     end if;
                     if CO.Waive_Conds and then W.F.Dec (J).What = Waive
                       and then W.F.Dec (J).Inst.P = P
                     then
                        Add_Conds (W.F.Dec (J));
                     end if;
                     if CO.Aside_Conds and then W.F.Dec (J).What = Set_Aside
                       and then W.F.Ev (W.F.Dec (J).Ev).P = P
                     then
                        Add_Conds (W.F.Dec (J));
                     end if;
                  end if;
               end loop;
               if CO.Descent then
                  for B in Id loop
                     if W.F.Desc (B, P) or else W.F.Desc (P, B) then
                        Add (B);
                     end if;
                  end loop;
               end if;
               if CO.Holders then
                  for A in Id loop
                     for V in Ver loop
                        for S in Slot_Ix loop
                           if W.T (A, V).Exists
                             and then W.T (A, V).Slots (S).State = Holding
                             and then W.T (A, V).Slots (S).Filler = P
                           then
                              Add (A);
                           end if;
                        end loop;
                     end loop;
                  end loop;
               end if;
            end if;
         end loop;
      end loop;
      return Rg;
   end Close;

   --  Rewrite everything outside Rg: reselect the pieces, and replace
   --  every fact that is about a piece outside by a fresh one about a
   --  piece outside.
   function Scramble_Outside (W : World; Rg : Id_Set; G : Gen_Opts)
      return World
   is
      W2 : World := W;
      function Outside return Id is
         P : Id := R_Id;
      begin
         for Tries in 1 .. 40 loop
            exit when not Rg (P);
            P := R_Id;
         end loop;
         return P;
      end Outside;
      function About (D : Decision) return Id is
        (case D.What is
           when Admit | Affirm | Promise | Ask => D.P,
           when Waive => D.Inst.P,
           when Set_Aside => W.F.Ev (D.Ev).P);
   begin
      for P in Id loop
         if not Rg (P) then
            if Chance (80) then
               declare
                  V : Ver := R_Ver;
               begin
                  if not W.T (P, V).Exists then
                     V := 1;
                  end if;
                  W2.S (P) := (True, V, Chance (75));
               end;
            else
               W2.S (P) := (others => <>);
            end if;
         end if;
      end loop;
      for I in Ev_Ix loop
         if not W.F.Ev (I).Present or else not Rg (W.F.Ev (I).P) then
            --  only where no decision inside sets this slot aside
            if not (for some J in Dec_Ix =>
                      W.F.Dec (J).Present
                      and then W.F.Dec (J).What = Set_Aside
                      and then W.F.Dec (J).Ev = I)
            then
               W2.F.Ev (I) := (others => <>);
               if Chance (40) then
                  W2.F.Ev (I) := Gen_Evidence;
                  W2.F.Ev (I).P := Outside;
                  if Rg (W2.F.Ev (I).P) then
                     W2.F.Ev (I) := (others => <>);
                  end if;
               end if;
            end if;
         end if;
      end loop;
      for J in Dec_Ix loop
         if not W.F.Dec (J).Present
           or else (not Rg (About (W.F.Dec (J)))
                    and then W.F.Dec (J).What /= Set_Aside)
         then
            --  a decision slot a piece inside reports stays as it is
            if not (for some P in Id => (for some V in Ver =>
                      Rg (P) and then W.T (P, V).Reports.Present
                      and then W.T (P, V).Reports.Dec = J))
            then
               W2.F.Dec (J) := (others => <>);
               if Chance (45) then
                  W2.F.Dec (J) := Gen_Decision (G);
                  W2.F.Dec (J).P := Outside;
                  W2.F.Dec (J).Inst.P := W2.F.Dec (J).P;
                  if Rg (W2.F.Dec (J).P)
                    or else W2.F.Dec (J).What = Set_Aside
                  then
                     W2.F.Dec (J) := (others => <>);
                  end if;
               end if;
            end if;
         end if;
      end loop;
      return W2;
   end Scramble_Outside;

   procedure Run_Q7 (Name : String; CO : Closure_Opts) is
      W, W2 : World;
      Rg : Id_Set;
      Tried, Bad_N : Natural := 0;
      G : constant Gen_Opts := (others => <>);
      Size : Natural;
   begin
      for N in 1 .. N_Worlds loop
         W := Gen (G);
         Rg := Close (W, [for P in Id => P = R_Id], CO);
         Size := 0;
         for P in Id loop
            if Rg (P) then
               Size := Size + 1;
            end if;
         end loop;
         if Size < 5 then
            Tried := Tried + 1;
            W2 := Scramble_Outside (W, Rg, G);
            if not Same_On (Frontier (W), Frontier (W2), Rg) then
               Bad_N := Bad_N + 1;
               if Bad_N = 1 then
                  Put_Line ("    first found (not shrunk): the region is");
                  for P in Id loop
                     if Rg (P) then
                        Put ("      p" & Img (Integer (P)));
                     end if;
                  end loop;
                  New_Line;
                  Put_Line ("    differing instance: "
                            & First_Extra (Frontier (W), Frontier (W2), Rg)
                            & " before only / "
                            & First_Extra (Frontier (W2), Frontier (W), Rg)
                            & " after only");
               end if;
            end if;
         end if;
      end loop;
      Put_Line ("  Q7 " & Name & ": " & Img (Tried)
                & " (world, proper closed region) pairs; frontier on the "
                & "region changed when the outside was rewritten: "
                & Img (Bad_N));
   end Run_Q7;

   -------------------------------------------------------------------
   --  Q9: the three standards on the same selection and facts
   -------------------------------------------------------------------
   procedure Run_Q9 is
      W : World;
      Fd, Fr, Fp : Front;
      P_Not_In_D, P_Not_In_R, D_Only, R_Only : Natural := 0;
      St_D, St_R, St_P, St_P_Not_D, St_P_Not_R, St_D_Not_R, St_R_Not_D
        : Natural := 0;
      function Empty (F : Front) return Boolean is
        (for all K in Inst_Kind => (for all P in Id => (for all I in Sub =>
           (for all J in Sub => not F (K, P, I, J)))));
   begin
      for N in 1 .. N_Worlds loop
         W := Gen ((others => <>));
         W.O.Canon := By_Decision;  Fd := Frontier (W);
         W.O.Canon := By_Rule;      Fr := Frontier (W);
         W.O.Canon := By_Placement; Fp := Frontier (W);
         if not Subset (Fp, Fd) then P_Not_In_D := P_Not_In_D + 1; end if;
         if not Subset (Fp, Fr) then P_Not_In_R := P_Not_In_R + 1; end if;
         if not Subset (Fd, Fr) then D_Only := D_Only + 1; end if;
         if not Subset (Fr, Fd) then R_Only := R_Only + 1; end if;
         if Empty (Fd) then St_D := St_D + 1; end if;
         if Empty (Fr) then St_R := St_R + 1; end if;
         if Empty (Fp) then St_P := St_P + 1; end if;
         if Empty (Fp) and then not Empty (Fd) then
            St_P_Not_D := St_P_Not_D + 1;
         end if;
         if Empty (Fp) and then not Empty (Fr) then
            St_P_Not_R := St_P_Not_R + 1;
         end if;
         if Empty (Fd) and then not Empty (Fr) then
            St_D_Not_R := St_D_Not_R + 1;
         end if;
         if Empty (Fr) and then not Empty (Fd) then
            St_R_Not_D := St_R_Not_D + 1;
         end if;
      end loop;
      Put_Line ("  Q9 over " & Img (N_Worlds) & " worlds, same selection "
                & "and facts under each standard:");
      Put_Line ("    frontier(placement) not within frontier(decision): "
                & Img (P_Not_In_D) & "; not within frontier(rule): "
                & Img (P_Not_In_R));
      Put_Line ("    decision owes something rule does not: " & Img (D_Only)
                & "; rule owes something decision does not: "
                & Img (R_Only));
      Put_Line ("    empty frontier under decision / rule / placement: "
                & Img (St_D) & " / " & Img (St_R) & " / " & Img (St_P));
      Put_Line ("    empty under placement and not decision: "
                & Img (St_P_Not_D) & "; under placement and not rule: "
                & Img (St_P_Not_R) & "; under decision and not rule: "
                & Img (St_D_Not_R) & "; under rule and not decision: "
                & Img (St_R_Not_D));
   end Run_Q9;

begin
   if Ada.Command_Line.Argument_Count >= 1 then
      N_Worlds := Natural'Value (Ada.Command_Line.Argument (1));
   end if;
   Put_Line ("worlds per property:" & N_Worlds'Image
             & "; bounds: 5 ids, 3 versions each, 2 dimensions, 2 criteria, "
             & "4 warrant levels, 3 reference kinds, 12 evidence facts, "
             & "12 decisions");

   New_Line;
   Put_Line ("Q2. Dead ends are inert");
   Run_Q2 ((others => <>));

   New_Line;
   Put_Line ("Q4. Good facts do no harm (frontier after is within "
             & "frontier before)");
   Put_Line (" monotone read_as; promise/ask conditions plain; stratified:");
   for GK in Good_Kind loop
      Run_Q4 ("add " & GK'Image, (others => <>), GK);
   end loop;
   Put_Line (" read_as NOT required monotone:");
   Run_Q4 ("add HOLDS_EVIDENCE", (Monotone => False, others => <>),
           Holds_Evidence);
   Put_Line (" promise/ask may be conditioned on a warrant:");
   Run_Q4 ("add HOLDS_EVIDENCE", (Plain_Oblig => False, others => <>),
           Holds_Evidence);
   Put_Line (" not stratified (promise/ask/waive may be conditioned on "
             & "consistency):");
   Run_Q4 ("add ADMIT_DEC",
           (Plain_Oblig => False, Stratified => False, others => <>),
           Admit_Dec);

   New_Line;
   Put_Line ("Q5. A known defect cannot be selected away");
   Run_Q5;

   New_Line;
   Put_Line ("Q6. Well defined");
   Run_Q6;

   New_Line;
   Put_Line ("Q7. Locality");
   Run_Q7 ("full closure", (others => <>));
   Run_Q7 ("closure without holders", (Holders => False, others => <>));
   Run_Q7 ("closure without descent", (Descent => False, others => <>));
   Run_Q7 ("closure without reported decisions",
           (Reported => False, others => <>));

   New_Line;
   Put_Line ("Q9. The three standards for canon");
   Run_Q9;
end Search;
