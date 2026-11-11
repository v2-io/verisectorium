--  KERNEL-SPEC draft 4: random search over small scenes and lines for
--  R6 (good news, at the level of events), R7 (consistency), R8 (a
--  defect survives) and R9 (when two forks compose). Deterministic.
--  Sampling, not exhaustive enumeration.
--
--  usage: search [N]      (default 100000 scenes per property)
with Ada.Text_IO;      use Ada.Text_IO;
with Ada.Command_Line;
with Interfaces;       use Interfaces;
with Vk;               use Vk;
with Vk.Model;         use Vk.Model;
with Vk.Lines;         use Vk.Lines;
with Lab;              use Lab;

procedure Search is

   N_Scenes : Natural := 100_000;

   Seed : Unsigned_64 := 16#9E37_79B9_7F4A_7C15#;

   function Next return Unsigned_64 is
      Z : Unsigned_64;
   begin
      Seed := Seed + 16#9E37_79B9_7F4A_7C15#;
      Z := Seed;
      Z := (Z xor Shift_Right (Z, 30)) * 16#BF58_476D_1CE4_E5B9#;
      Z := (Z xor Shift_Right (Z, 27)) * 16#94D0_49BB_1331_11EB#;
      return Z xor Shift_Right (Z, 31);
   end Next;

   function Rnd (N : Positive) return Natural is
     (Natural (Next mod Unsigned_64 (N)));
   function Chance (Pct : Natural) return Boolean is (Rnd (100) < Pct);
   function R_Id return Id is (Id (1 + Rnd (5)));
   function R_Ver return Ver is (Ver (1 + Rnd (3)));
   function R_Dim return Dim is (Dim (1 + Rnd (2)));
   function R_Crit return Crit is (Crit (1 + Rnd (2)));
   function R_Vers (Pct : Natural) return Ver_Set is
     ([for V in Ver => Chance (Pct)]);
   function R_Relies return Relies is (Relies'Val (Rnd (3)));

   -------------------------------------------------------------------
   --  A scene: ontology and versions
   -------------------------------------------------------------------
   Is_Asm : array (Id) of Boolean;

   procedure Gen_Scene (Sc : out Scene; Monotone : Boolean := True) is
      Kd : array (Id) of Kind;
   begin
      Sc := (others => <>);
      for K in Ref_Kind loop
         Sc.O.RK (K) := (Rests => Chance (50), Relies_On => R_Relies,
                         Caps => [for D in Dim => Chance (40)]);
      end loop;
      Sc.O.Point_Kind := Ref_Kind (1 + Rnd (3));
      if Chance (70) then      --  the spec's [lead] choice, mostly
         Sc.O.RK (Sc.O.Point_Kind).Relies_On := Existence;
      end if;
      for D in Dim loop
         declare
            A, B, C, E : Warrant;
         begin
            if Monotone then
               A := Warrant (Rnd (2));
               B := Warrant (Natural (A) + Rnd (2));
               C := Warrant (Natural (A) + Rnd (2));
               E := Warrant (Natural (Warrant'Max (B, C)) + Rnd (2));
            else
               A := Warrant (Rnd (4));  B := Warrant (Rnd (4));
               C := Warrant (Rnd (4));  E := Warrant (Rnd (4));
            end if;
            Sc.O.Dims (D) :=
              (Read_As => [False => [False => A, True => C],
                           True  => [False => B, True => E]],
               Decided => D = 2 and then Chance (25));
         end;
      end loop;
      Sc.O.Kinds (1) := (Is_Assembly => False, others => <>);
      for K in Kind range 2 .. 3 loop
         Sc.O.Kinds (K) :=
           (Is_Assembly => True,
            Opens    => [others => False],
            Used     => [for S in Slot_Ix => Chance (90)],
            Required => [for S in Slot_Ix => Chance (20)],
            Deps     => [for A in Slot_Ix =>
                           [for B in Slot_Ix => A /= B and then Chance (12)]]);
         for KP in Kind loop
            for D in Dim loop
               if Chance (45) then
                  Sc.O.Asks (K, KP, D) := Warrant (1 + Rnd (2));
               end if;
            end loop;
         end loop;
      end loop;
      Sc.O.Waived_Is_Consistent := Chance (70);
      Sc.Opt.Mode := (if Chance (50) then Letter else Later);
      Sc.Opt.Off_Line_Guards := Chance (30);
      Sc.Opt.Written_Counts := Chance (70);
      Sc.Opt.Seen_Recorded := Chance (70);

      for P in Id loop
         Is_Asm (P) := Chance (35);
         Kd (P) := (if Is_Asm (P) then Kind (2 + Rnd (2)) else 1);
         for V in Ver loop
            Sc.T (P, V).Exists := True;
            Sc.T (P, V).K := Kd (P);
            Sc.T (P, V).Says := [for D in Dim => Assertion (Rnd (3))];
            for I in Ref_Ix loop
               if Chance (30) then
                  Sc.T (P, V).Refs (I) :=
                    (Present => True, K => Ref_Kind (1 + Rnd (3)),
                     Target => R_Id, Need_Dim => R_Dim,
                     Need => (if Chance (20) then Warrant (1 + Rnd (2))
                              else 0));
               end if;
            end loop;
            if Is_Asm (P) then
               for S in Slot_Ix loop
                  if Chance (55) then
                     Sc.T (P, V).Slots (S) :=
                       (State => (if Chance (40) then Holding else Pointing),
                        Filler => R_Id, Provisional => Chance (20));
                  end if;
               end loop;
            end if;
            if Chance (8) then
               Sc.T (P, V).Claims :=
                 (Present => True, About => R_Id, D => R_Dim,
                  Level => Warrant (1 + Rnd (3)));
            end if;
            if Chance (6) then
               Sc.T (P, V).Reports :=
                 (Present => True, Dec => Dec_Ix (1 + Rnd (12)));
            end if;
         end loop;
      end loop;
   end Gen_Scene;

   function Gen_Decision return Decision is
      D : Decision;
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
                 I => Sub (Rnd (6)), J => Sub (Rnd (3)));
      D.Ev := Ev_Ix (1 + Rnd (12));
      --  Section 2: only accept and affirm have conditions; an
      --  accept's are plain (my reading).
      if D.What in Admit | Affirm then
         for K in Cond_Ix loop
            if Chance (25) then
               D.Conds (K).P := R_Id;
               case Rnd (if D.What = Admit then 2 else 4) is
                  when 0 =>
                     D.Conds (K).What := Selected_At;
                     D.Conds (K).Vs := R_Vers (50);
                  when 1 =>
                     D.Conds (K).What := Slot_Filled;
                     D.Conds (K).S := Slot_Ix (1 + Rnd (3));
                     D.Conds (K).Filler := R_Id;
                  when 2 =>
                     D.Conds (K).What := Warrant_At_Least;
                     D.Conds (K).D := R_Dim;
                     D.Conds (K).W := Warrant (Rnd (3));
                  when others =>
                     D.Conds (K).What := Asserted_Consistent;
               end case;
            end if;
         end loop;
      end if;
      return D;
   end Gen_Decision;

   function Gen_Evidence (Sc : Scene; Ln : Timeline) return Evidence is
      E : Evidence;
      Pk : Pick;
   begin
      E.Present := True;
      E.P := R_Id;
      Pk := Version_At (Ln, E.P, Sc.Clock);
      E.V := (if Pk.Selected and then Chance (75) then Pk.V else R_Ver);
      E.Same := R_Vers (15);
      E.D := R_Dim;
      E.C := R_Crit;
      E.Result := (if Chance (60) then Holds
                   elsif Chance (50) then Fails else Part);
      for R in Read_Ix loop
         if Chance (25) then
            E.Reads (R).Present := True;
            E.Reads (R).Q := R_Id;
            Pk := Version_At (Ln, E.Reads (R).Q, Sc.Clock);
            E.Reads (R).W :=
              (if Pk.Selected and then Chance (75) then Pk.V else R_Ver);
            E.Reads (R).Same := R_Vers (15);
            E.Reads (R).Level := R_Relies;
         end if;
      end loop;
      return E;
   end Gen_Evidence;

   --  Who did what, for R9.
   type Owner is (Nobody, Trunk, Fork_A, Fork_B);
   Ev_Owner  : array (Ev_Ix) of Owner;
   Dec_Owner : array (Dec_Ix) of Owner;
   type Touch is record
      Wrote    : Id_Set := [others => False];   --  written or retired
      Marked   : Boolean := False;              --  marked or unmarked a root
      Withdrew : Boolean := False;
      Set_Aside : Boolean := False;             --  set some evidence aside
   end record;

   procedure Step (Sc : in out Scene; Ln : in out Timeline; Who : Owner;
                   Tc : in out Touch) is
      Roll : constant Natural := Rnd (100);
      P : constant Id := R_Id;
   begin
      if Roll < 42 then
         Write (Sc, Ln, P, R_Ver);
         Tc.Wrote (P) := True;
      elsif Roll < 70 then
         for I in Ev_Ix loop
            if Ev_Owner (I) = Nobody then
               Ev_Owner (I) := Who;
               Observe (Sc, I, Gen_Evidence (Sc, Ln));
               exit;
            end if;
         end loop;
      elsif Roll < 86 then
         for J in Dec_Ix loop
            if Dec_Owner (J) = Nobody then
               Dec_Owner (J) := Who;
               Decide (Sc, Ln, J, Gen_Decision);
               if Sc.B.Dec (J).What = Set_Aside then
                  Tc.Set_Aside := True;
               end if;
               exit;
            end if;
         end loop;
      elsif Roll < 90 then
         declare
            J : constant Dec_Ix := Dec_Ix (1 + Rnd (12));
         begin
            if Dec_Owner (J) /= Nobody then
               Withdraw (Sc, Ln, J);
               Tc.Withdrew := True;
            end if;
         end;
      elsif Roll < 95 then
         if Is_Asm (P) then
            Mark (Sc, Ln, P);
            Tc.Marked := True;
         end if;
      elsif Roll < 97 then
         Unmark (Sc, Ln, P);
         Tc.Marked := True;
      else
         Retire (Sc, Ln, P, [for H in Id => H /= P and then Chance (25)]);
         Tc.Wrote (P) := True;
      end if;
   end Step;

   procedure Gen_Trunk (Sc : in out Scene; Ln : out Timeline;
                        Steps : Natural := 8) is
      Tc : Touch;
   begin
      Ln := Empty_Line;
      Ev_Owner := [others => Nobody];
      Dec_Owner := [others => Nobody];
      for P in Id loop
         if Chance (90) then
            Write (Sc, Ln, P, R_Ver);
         end if;
      end loop;
      for P in Id loop
         if Is_Asm (P) and then Chance (70) then
            Mark (Sc, Ln, P);
         end if;
      end loop;
      for K in 1 .. Steps loop
         Step (Sc, Ln, Trunk, Tc);
      end loop;
   end Gen_Trunk;

   -------------------------------------------------------------------
   --  Frontiers as values
   -------------------------------------------------------------------
   type Front is array (Inst_Kind, Id, Sub, Sub range 0 .. 3) of Boolean;

   function Frontier (Sc : Scene; Ln : Timeline) return Front is
      S : constant State := St (Sc, Ln);
      C : constant Context := Derive (Sc.O, Sc.T, S.S, S.F);
      X : constant Id_Set := Consistent (Sc.O, Sc.T, S.S, S.F, S.L, C);
      Fr : Front := [others => [others => [others => [others => False]]]];
   begin
      for K in Inst_Kind loop
         for P in Id loop
            if S.S (P).Asserted then
               for I in Sub loop
                  for J in Sub range 0 .. 3 loop
                     Fr (K, P, I, J) :=
                       Violated (Sc.O, Sc.T, S.S, S.F, S.L, C, X,
                                 (K, P, I, J));
                  end loop;
               end loop;
            end if;
         end loop;
      end loop;
      return Fr;
   end Frontier;

   function Subset (A, B : Front) return Boolean is
     (for all K in Inst_Kind => (for all P in Id => (for all I in Sub =>
        (for all J in Sub range 0 .. 3 =>
           (if A (K, P, I, J) then B (K, P, I, J))))));

   function First_Extra (A, B, B2 : Front) return String is
   begin
      for K in Inst_Kind loop
         for P in Id loop
            for I in Sub loop
               for J in Sub range 0 .. 3 loop
                  if A (K, P, I, J) and then not B (K, P, I, J)
                    and then not B2 (K, P, I, J)
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
   --  R6 at the level of events
   -------------------------------------------------------------------
   type Good is (Holding_Evidence, An_Affirm, An_Accept, A_Same);

   procedure Run_R6 (Name : String; Monotone : Boolean; G : Good) is
      Sc : Scene;
      Ln, Ln2 : Timeline;
      Before, After : Front;
      Tried, Bad_N : Natural := 0;
      Slot_E : Ev_Ix;
      Slot_D : Dec_Ix;
      Free : Boolean;
      D : Decision;
      E : Evidence;
   begin
      for N in 1 .. N_Scenes loop
         Gen_Scene (Sc, Monotone);
         Gen_Trunk (Sc, Ln);
         Before := Frontier (Sc, Ln);
         Ln2 := Ln;
         Free := False;
         case G is
            when Holding_Evidence =>
               for I in Ev_Ix loop
                  if Ev_Owner (I) = Nobody then
                     Slot_E := I;  Free := True;  exit;
                  end if;
               end loop;
               if Free then
                  E := Gen_Evidence (Sc, Ln);
                  E.Result := Holds;
                  Observe (Sc, Slot_E, E);
               end if;
            when A_Same =>
               Slot_E := Ev_Ix (1 + Rnd (12));
               Free := Sc.B.Ev (Slot_E).Present
                 and then Sc.B.Ev (Slot_E).Result = Holds;
               if Free then
                  Sc.B.Ev (Slot_E).Same (R_Ver) := True;
                  Sc.Clock := Sc.Clock + 1;
               end if;
            when An_Affirm | An_Accept =>
               for J in Dec_Ix loop
                  if Dec_Owner (J) = Nobody then
                     Slot_D := J;  Free := True;  exit;
                  end if;
               end loop;
               if Free then
                  loop
                     D := Gen_Decision;
                     exit when D.What =
                       (if G = An_Affirm then Affirm else Admit);
                  end loop;
                  Decide (Sc, Ln2, Slot_D, D);
               end if;
         end case;
         if Free then
            --  Compare as of the same later time: Before was read one
            --  tick earlier, with nothing else between.
            After := Frontier (Sc, Ln2);
            Tried := Tried + 1;
            if not Subset (After, Before) then
               Bad_N := Bad_N + 1;
               if Bad_N = 1 then
                  Put_Line ("    first found: adds "
                            & First_Extra (After, Before, Before)
                            & "; guard mode " & Sc.Opt.Mode'Image
                            & ", off-line guards "
                            & Sc.Opt.Off_Line_Guards'Image);
               end if;
            end if;
         end if;
      end loop;
      Put_Line ("  " & Name & ": " & Tried'Image & " tried,"
                & Bad_N'Image & " counterexamples");
   end Run_R6;

   -------------------------------------------------------------------
   --  R7
   -------------------------------------------------------------------
   procedure Run_R7 is
      Sc : Scene;
      Ln : Timeline;
      Unfixed, Not_Greatest, Many : Natural := 0;
   begin
      for N in 1 .. N_Scenes loop
         Gen_Scene (Sc);
         Gen_Trunk (Sc, Ln);
         declare
            S : constant State := St (Sc, Ln);
            C : constant Context := Derive (Sc.O, Sc.T, S.S, S.F);
            X : constant Id_Set :=
              Consistent (Sc.O, Sc.T, S.S, S.F, S.L, C);
            N_Fixed : Natural := 0;
            Y : Id_Set;
         begin
            if not Is_Fixed (Sc.O, Sc.T, S.S, S.F, S.L, C, X) then
               Unfixed := Unfixed + 1;
            end if;
            for M in 0 .. 31 loop
               Y := [for P in Id => (M / 2 ** (Integer (P) - 1)) mod 2 = 1];
               if Is_Fixed (Sc.O, Sc.T, S.S, S.F, S.L, C, Y) then
                  N_Fixed := N_Fixed + 1;
                  if not (for all P in Id => (if Y (P) then X (P))) then
                     Not_Greatest := Not_Greatest + 1;
                  end if;
               end if;
            end loop;
            if N_Fixed > 1 then
               Many := Many + 1;
            end if;
         end;
      end loop;
      Put_Line ("  R7: " & N_Scenes'Image & " states read from random "
                & "lines; result not a fixed point:" & Unfixed'Image
                & "; a fixed point not within it:" & Not_Greatest'Image
                & "; states with more than one fixed point:" & Many'Image);
   end Run_R7;

   -------------------------------------------------------------------
   --  R8
   -------------------------------------------------------------------
   procedure Run_R8 is
      Sc : Scene;
      Ln : Timeline;
      Cases, Bad_N, Letter_Sheds, Off_Line : Natural := 0;
   begin
      for N in 1 .. N_Scenes loop
         Gen_Scene (Sc);
         Gen_Trunk (Sc, Ln, Steps => 10);
         Sc.Opt.Mode := Later;
         Sc.Opt.Off_Line_Guards := False;
         declare
            S  : constant State := St (Sc, Ln);
            C  : constant Context := Derive (Sc.O, Sc.T, S.S, S.F);
            X  : constant Id_Set :=
              Consistent (Sc.O, Sc.T, S.S, S.F, S.L, C);
            Sc_L : Scene := Sc;
            Sc_O : Scene := Sc;
         begin
            Sc_L.Opt.Mode := Letter;
            Sc_O.Opt.Off_Line_Guards := True;
            declare
               SL : constant State := St (Sc_L, Ln);
               SO : constant State := St (Sc_O, Ln);
            begin
               for P in Id loop
                  for D in Dim loop
                     for Cr in Crit loop
                        if S.S (P).Asserted and then S.L.Guard (P, D, Cr)
                          and then not SL.L.Guard (P, D, Cr)
                        then
                           Letter_Sheds := Letter_Sheds + 1;
                        end if;
                        if S.S (P).Asserted and then SO.L.Guard (P, D, Cr)
                          and then not S.L.Guard (P, D, Cr)
                        then
                           Off_Line := Off_Line + 1;
                        end if;
                     end loop;
                  end loop;
               end loop;
            end;
            --  The property: a finding, not set aside, against a
            --  version the line once selected, with NO holding evidence
            --  on its criterion later than it anywhere, is owed (C6) on
            --  the piece and on every descendant in canon.
            for I in Ev_Ix loop
               if S.F.Ev (I).Present and then S.F.Ev (I).Result /= Holds
                 and then not Aside (S.F, I)
                 and then (for some E in Event_Ix =>
                             Ln (E).Present and then Ln (E).What = Write
                             and then Ln (E).P = S.F.Ev (I).P
                             and then Ln (E).V = S.F.Ev (I).V)
                 and then not
                   (for some H in Ev_Ix =>
                      S.F.Ev (H).Present and then S.F.Ev (H).Result = Holds
                      and then S.F.Ev (H).D = S.F.Ev (I).D
                      and then S.F.Ev (H).C = S.F.Ev (I).C
                      and then S.F.Ev (H).Time > S.F.Ev (I).Time)
               then
                  for Q in Id loop
                     if S.S (Q).Asserted
                       and then (Q = S.F.Ev (I).P
                                 or else S.F.Desc (S.F.Ev (I).P, Q))
                     then
                        Cases := Cases + 1;
                        if not
                          (Violated (Sc.O, Sc.T, S.S, S.F, S.L, C, X,
                                     (C6_Guard, Q, Sub (S.F.Ev (I).D),
                                      Sub (S.F.Ev (I).C)))
                           or else
                           (Q = S.F.Ev (I).P
                            and then Violated
                              (Sc.O, Sc.T, S.S, S.F, S.L, C, X,
                               (C6_Fails, Q, Sub (I), 0))))
                        then
                           Bad_N := Bad_N + 1;
                        end if;
                     end if;
                  end loop;
               end if;
            end loop;
         end;
      end loop;
      Put_Line ("  R8 (mode LATER): an unanswered finding against a "
                & "once-selected version is owed on the piece and its "
                & "descendants in canon:" & Cases'Image & " cases,"
                & Bad_N'Image & " counterexamples");
      Put_Line ("  guards open under LATER that the LETTER counts as met "
                & "(by evidence no later than the finding):"
                & Letter_Sheds'Image);
      Put_Line ("  guards that exist only if findings against versions the "
                & "line never selected count:" & Off_Line'Image);
   end Run_R8;

   -------------------------------------------------------------------
   --  R9
   -------------------------------------------------------------------
   function Mentions (Sc : Scene; D : Decision; Ps : Id_Set) return Boolean is
     (Ps (D.P)
      or else (D.What = Affirm and then Ps (D.Q))
      or else (D.What = Waive and then Ps (D.Inst.P))
      or else (D.What = Set_Aside and then Ps (Sc.B.Ev (D.Ev).P))
      or else (for some K in Cond_Ix =>
                 D.Conds (K).What /= None and then Ps (D.Conds (K).P)));

   --  Some version of a piece in Mine that a fork selected points (by
   --  a reference or a slot) at a piece in Theirs.
   function Points_Into
     (Sc : Scene; Ln : Timeline; Mine, Theirs : Id_Set) return Boolean is
     (for some E in Event_Ix =>
        Ln (E).Present and then Ln (E).What = Write and then Mine (Ln (E).P)
        and then
          ((for some I in Ref_Ix =>
              Sc.T (Ln (E).P, Ln (E).V).Refs (I).Present
              and then Theirs (Sc.T (Ln (E).P, Ln (E).V).Refs (I).Target))
           or else
           (for some S in Slot_Ix =>
              Sc.T (Ln (E).P, Ln (E).V).Slots (S).State /= Empty
              and then Theirs (Sc.T (Ln (E).P, Ln (E).V).Slots (S).Filler))));

   procedure Run_R9 is
      Sc : Scene;
      K, A, B, M : Timeline;
      TA, TB : Touch;
      FA, FB, FM : Front;
      Both_Wrote, Ev_Read : Boolean;
      Total, Meet, C1, C2, C_Dec, C_Point, C_Root, C_Wd, C_Trunk_Ev,
        C_Aside, C_Other : Natural := 0;
      Covering, Covering_And_Meet, Frame_Broken, Not_Covering_No_Meet,
        Region_Total : Natural := 0;
      Shown : Natural := 0;
   begin
      for N in 1 .. N_Scenes loop
         Gen_Scene (Sc);
         Sc.Opt := (others => <>);         --  LATER, recorded, as built
         Gen_Trunk (Sc, K);
         A := K;  B := K;
         TA := (others => <>);  TB := (others => <>);
         for I in 1 .. 3 loop
            Step (Sc, A, Fork_A, TA);
            Step (Sc, B, Fork_B, TB);
         end loop;
         M := Union (A, B);
         FA := Frontier (Sc, A);
         FB := Frontier (Sc, B);
         FM := Frontier (Sc, M);
         Total := Total + 1;
         --  The proved theorem, applied to these three states: on the
         --  region where the union agrees with a fork, its frontier is
         --  that fork's.
         declare
            RA : constant Id_Set := Region (Sc, A, M);
            RB : constant Id_Set := Region (Sc, B, M);
            Cover : constant Boolean :=
              (for all P in Id => RA (P) or else RB (P));
            Is_Meet : constant Boolean :=
              not (for all Kd in Inst_Kind => (for all P in Id =>
                     (for all I in Sub => (for all J in Sub range 0 .. 3 =>
                        (if FM (Kd, P, I, J)
                         then FA (Kd, P, I, J) or else FB (Kd, P, I, J))))));
         begin
            for P in Id loop
               if RA (P) then
                  Region_Total := Region_Total + 1;
               end if;
               if RB (P) then
                  Region_Total := Region_Total + 1;
               end if;
               for Kd in Inst_Kind loop
                  for I in Sub loop
                     for J in Sub range 0 .. 3 loop
                        if (RA (P) and then FM (Kd, P, I, J) /= FA (Kd, P, I, J))
                          or else
                           (RB (P) and then FM (Kd, P, I, J) /= FB (Kd, P, I, J))
                        then
                           Frame_Broken := Frame_Broken + 1;
                        end if;
                     end loop;
                  end loop;
               end loop;
            end loop;
            if Cover then
               Covering := Covering + 1;
               if Is_Meet then
                  Covering_And_Meet := Covering_And_Meet + 1;
               end if;
            elsif not Is_Meet then
               Not_Covering_No_Meet := Not_Covering_No_Meet + 1;
            end if;
         end;
         --  They MEET when the union owes something neither owes alone.
         if not (for all Kd in Inst_Kind => (for all P in Id =>
                   (for all I in Sub => (for all J in Sub range 0 .. 3 =>
                      (if FM (Kd, P, I, J)
                       then FA (Kd, P, I, J) or else FB (Kd, P, I, J))))))
         then
            Meet := Meet + 1;
            Both_Wrote := (for some P in Id => TA.Wrote (P) and TB.Wrote (P));
            Ev_Read :=
              (for some I in Ev_Ix =>
                 Sc.B.Ev (I).Present
                 and then
                   ((Ev_Owner (I) = Fork_A
                     and then
                       (TB.Wrote (Sc.B.Ev (I).P)
                        or else (for some R in Read_Ix =>
                                   Sc.B.Ev (I).Reads (R).Present
                                   and then TB.Wrote (Sc.B.Ev (I).Reads (R).Q))))
                    or else
                    (Ev_Owner (I) = Fork_B
                     and then
                       (TA.Wrote (Sc.B.Ev (I).P)
                        or else (for some R in Read_Ix =>
                                   Sc.B.Ev (I).Reads (R).Present
                                   and then TA.Wrote (Sc.B.Ev (I).Reads (R).Q))))));
            if Both_Wrote then
               C1 := C1 + 1;
            elsif Ev_Read then
               C2 := C2 + 1;
            elsif (for some J in Dec_Ix =>
                     (Dec_Owner (J) = Fork_A
                      and then Mentions (Sc, Sc.B.Dec (J), TB.Wrote))
                     or else
                     (Dec_Owner (J) = Fork_B
                      and then Mentions (Sc, Sc.B.Dec (J), TA.Wrote)))
            then
               C_Dec := C_Dec + 1;
            elsif Points_Into (Sc, A, TA.Wrote, TB.Wrote)
              or else Points_Into (Sc, B, TB.Wrote, TA.Wrote)
            then
               C_Point := C_Point + 1;
            elsif TA.Marked or else TB.Marked then
               C_Root := C_Root + 1;
            elsif TA.Withdrew or else TB.Withdrew then
               C_Wd := C_Wd + 1;
            elsif (for some I in Ev_Ix =>
                     Sc.B.Ev (I).Present and then Ev_Owner (I) = Trunk
                     and then
                       (TA.Wrote (Sc.B.Ev (I).P) or else TB.Wrote (Sc.B.Ev (I).P)
                        or else (for some R in Read_Ix =>
                                   Sc.B.Ev (I).Reads (R).Present
                                   and then
                                     (TA.Wrote (Sc.B.Ev (I).Reads (R).Q)
                                      or else TB.Wrote
                                        (Sc.B.Ev (I).Reads (R).Q)))))
            then
               C_Trunk_Ev := C_Trunk_Ev + 1;
            elsif TA.Set_Aside and then TB.Set_Aside then
               C_Aside := C_Aside + 1;
            else
               C_Other := C_Other + 1;
               if Shown < 3 then
                  Shown := Shown + 1;
                  Put_Line ("    unclassified: the union alone owes "
                            & First_Extra (FM, FA, FB));
               end if;
            end if;
         end if;
      end loop;
      Put_Line ("  R9:" & Total'Image & " pairs of forks from one "
                & "checkpoint (three events each); the union owes "
                & "something neither fork owes alone in" & Meet'Image);
      Put_Line ("    of those, by the first cause that fits:");
      Put_Line ("      both wrote or retired one id (the spec's first "
                & "case):" & C1'Image);
      Put_Line ("      one's evidence is about, or read, what the other "
                & "wrote (the spec's second case):" & C2'Image);
      Put_Line ("      one's decision is about what the other wrote:"
                & C_Dec'Image);
      Put_Line ("      one's new version refers to, holds or points at "
                & "what the other wrote:" & C_Point'Image);
      Put_Line ("      one marked or unmarked a root:" & C_Root'Image);
      Put_Line ("      one withdrew a decision:" & C_Wd'Image);
      Put_Line ("      evidence from before the checkpoint that read what "
                & "a fork wrote:" & C_Trunk_Ev'Image);
      Put_Line ("      each set some evidence aside:" & C_Aside'Image);
      Put_Line ("      none of these:" & C_Other'Image);
      Put_Line ("    the proved theorem on the same pairs:");
      Put_Line ("      instances, on a region where the union agrees with "
                & "a fork, on which the union's frontier and the fork's "
                & "differ (must be 0):" & Frame_Broken'Image);
      Put_Line ("      pairs whose two regions cover every piece (the "
                & "union's frontier is then the two forks' frontiers, each "
                & "on its region):" & Covering'Image
                & "; of those, pairs that nonetheless meet (must be 0):"
                & Covering_And_Meet'Image);
      Put_Line ("      pairs the regions do NOT cover and that do not "
                & "meet (the theorem is silent, nothing went wrong):"
                & Not_Covering_No_Meet'Image);
      Put_Line ("      mean size of a region, of 5 pieces:"
                & Natural'Image ((Region_Total * 10) / (2 * Total))
                & " tenths");
   end Run_R9;

begin
   if Ada.Command_Line.Argument_Count >= 1 then
      N_Scenes := Natural'Value (Ada.Command_Line.Argument (1));
   end if;
   Put_Line ("scenes per property:" & N_Scenes'Image
             & "; bounds: 5 ids, 3 versions each, 2 dimensions, 2 criteria, "
             & "4 warrant levels, 12 evidence facts, 12 decisions, lines of "
             & "about 20 events");

   New_Line;
   Put_Line ("R6. Good news does no harm, as events on a line (frontier "
             & "after is within frontier before)");
   Put_Line (" read_as monotone:");
   for G in Good loop
      Run_R6 ("add " & G'Image, True, G);
   end loop;
   Put_Line (" read_as not required monotone:");
   Run_R6 ("add HOLDING_EVIDENCE", False, Holding_Evidence);

   New_Line;
   Put_Line ("R7. Consistency");
   Run_R7;

   New_Line;
   Put_Line ("R8. A defect survives");
   Run_R8;

   New_Line;
   Put_Line ("R9. Forks compose");
   Run_R9;
end Search;
