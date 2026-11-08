with Ada.Characters.Handling; use Ada.Characters.Handling;
with Ada.Strings.Fixed;       use Ada.Strings.Fixed;
with Ada.Text_IO;

package body Kernel.Text with SPARK_Mode => Off is

   LF : constant Character := Character'Val (10);

   ---------------------------------------------------------------------
   --  Names
   ---------------------------------------------------------------------

   function Valid_Token (S : String) return Boolean is
   begin
      if S'Length = 0 then
         return False;
      end if;
      for C of S loop
         if C in ' ' | '=' | '@' | ':' | '#' | ',' | '(' | ')'
           or else Is_Control (C)
         then
            return False;
         end if;
      end loop;
      return True;
   end Valid_Token;

   function Intern (T : in out Name_Table; Name : String; Limit : Positive)
      return Positive
   is
   begin
      for I in 1 .. T.Count loop
         if To_String (T.Names (I)) = Name then
            return I;
         end if;
      end loop;
      if not Valid_Token (Name) then
         raise Format_Error with "not a usable name: """ & Name & """";
      end if;
      if T.Count >= Limit then
         raise Format_Error with "too many names; cannot add " & Name;
      end if;
      T.Count := T.Count + 1;
      T.Names (T.Count) := To_Unbounded_String (Name);
      return T.Count;
   end Intern;

   function Lookup (T : Name_Table; I : Positive) return String is
     (if I <= T.Count then To_String (T.Names (I))
      else "#" & Trim (I'Image, Ada.Strings.Left));

   function Veritoid_Named (N : in out Names; Name : String) return Veritoid_Id is
     (Intern (N.Veritoids, Name, Max_Veritoids));
   function Segment_Named (N : in out Names; Name : String) return Segment_Id is
     (Segment_Id (Intern (N.Segments, Name, Positive (Segment_Id'Last))));
   function Actor_Named (N : in out Names; Name : String) return Actor_Id is
     (Actor_Id (Intern (N.Actors, Name, Positive (Actor_Id'Last))));
   function Criterion_Named (N : in out Names; Name : String) return Criterion_Id
   is (Criterion_Id (Intern (N.Criteria, Name, Positive (Criterion_Id'Last))));

   function Veritoid_Name (N : Names; Id : Veritoid_Id) return String is
     (Lookup (N.Veritoids, Id));
   function Segment_Name (N : Names; Id : Segment_Id) return String is
     (Lookup (N.Segments, Positive (Id)));
   function Actor_Name (N : Names; Id : Actor_Id) return String is
     (Lookup (N.Actors, Positive (Id)));
   function Criterion_Name (N : Names; Id : Criterion_Id) return String is
     (Lookup (N.Criteria, Positive (Id)));

   function Rung_Name (R : Rung) return String is (To_Lower (R'Image));
   function Outcome_Name (O : Outcome) return String is
     (To_Lower (O'Image));

   function Img (V : Version) return String is
     (Trim (V'Image, Ada.Strings.Left));

   ---------------------------------------------------------------------
   --  To_Line
   ---------------------------------------------------------------------

   function To_Line (N : Names; E : Log_Entry) return String is
      R : Unbounded_String;
   begin
      if E.Kind = Changeset_Record then
         Append (R, "changeset author=" & Actor_Name (N, E.CS.Author)
                 & " segment=" & Segment_Name (N, E.CS.Segment)
                 & " result=" & Outcome_Name (E.Result));
         for I in 1 .. E.CS.N_Items loop
            declare
               It : Item renames E.CS.Items (I);
            begin
               Append (R, " item=" & Veritoid_Name (N, It.Id) & "@"
                       & Img (It.Ver) & ":" & Rung_Name (It.Claimed));
               if It.Affirmed then
                  Append (R, " affirmed");
               end if;
               for Q in 1 .. It.N_Refs loop
                  Append (R, " ref="
                          & Veritoid_Name (N, It.Refs (Q).Target) & ":"
                          & Rung_Name (It.Refs (Q).Needed) & "@"
                          & Img (It.Refs (Q).Seen));
               end loop;
            end;
         end loop;
      else
         Append (R, "act actor=" & Actor_Name (N, E.A.Actor)
                 & " criterion=" & Criterion_Name (N, E.A.Criterion)
                 & " kind=" & To_Lower (E.A.Kind'Image)
                 & " level=" & Rung_Name (E.A.Level)
                 & " result=" & Outcome_Name (E.Result));
         for I in 1 .. E.A.N_Reads loop
            Append (R, " read=" & Veritoid_Name (N, E.A.Reads (I).Id) & "@"
                    & Img (E.A.Reads (I).Ver));
         end loop;
      end if;
      return To_String (R);
   end To_Line;

   ---------------------------------------------------------------------
   --  From_Line
   ---------------------------------------------------------------------

   function Split_At (S : String; C : Character; Before : Boolean)
      return String
   is
      P : constant Natural := Index (S, (1 => C));
   begin
      if P = 0 then
         raise Format_Error with "expected '" & C & "' in """ & S & """";
      end if;
      return (if Before then S (S'First .. P - 1) else S (P + 1 .. S'Last));
   end Split_At;

   function Parse_Rung (S : String) return Rung is
   begin
      return Rung'Value (S);
   exception
      when Constraint_Error =>
         raise Format_Error with "not a rung: """ & S & """";
   end Parse_Rung;

   function Parse_Version (S : String) return Version is
   begin
      return Version'Value (S);
   exception
      when Constraint_Error =>
         raise Format_Error with "not a version: """ & S & """";
   end Parse_Version;

   function From_Line (N : in out Names; Line : String) return Log_Entry is
      E     : Log_Entry;
      Pos   : Natural := Line'First;
      First : Boolean := True;
      Have  : Boolean := False;   --  an item is open
   begin
      while Pos <= Line'Last loop
         if Line (Pos) = ' ' then
            Pos := Pos + 1;
         else
            declare
               Stop : Natural := Index (Line (Pos .. Line'Last), " ");
            begin
               if Stop = 0 then
                  Stop := Line'Last + 1;
               end if;
               declare
                  Tok : constant String := Line (Pos .. Stop - 1);
                  Key : constant String :=
                    (if Index (Tok, "=") = 0 then Tok
                     else Split_At (Tok, '=', True));
                  Val : constant String :=
                    (if Index (Tok, "=") = 0 then ""
                     else Split_At (Tok, '=', False));
               begin
                  if First then
                     if Tok = "changeset" then
                        E.Kind := Changeset_Record;
                     elsif Tok = "act" then
                        E.Kind := Act_Record;
                     else
                        raise Format_Error with "unknown record: " & Tok;
                     end if;
                     First := False;
                  elsif Key = "result" then
                     begin
                        E.Result := Outcome'Value (Val);
                     exception
                        when Constraint_Error =>
                           raise Format_Error with "not a result: " & Val;
                     end;
                  elsif E.Kind = Changeset_Record then
                     if Key = "author" then
                        E.CS.Author := Actor_Named (N, Val);
                     elsif Key = "segment" then
                        E.CS.Segment := Segment_Named (N, Val);
                     elsif Key = "item" then
                        if E.CS.N_Items = Max_Items then
                           raise Format_Error with "too many items";
                        end if;
                        E.CS.N_Items := E.CS.N_Items + 1;
                        declare
                           Head : constant String := Split_At (Val, ':', True);
                           It   : Item renames E.CS.Items (E.CS.N_Items);
                        begin
                           It := (others => <>);
                           It.Id := Veritoid_Named (N, Split_At (Head, '@', True));
                           It.Ver := Parse_Version
                             (Split_At (Head, '@', False));
                           It.Claimed := Parse_Rung
                             (Split_At (Val, ':', False));
                        end;
                        Have := True;
                     elsif Key = "affirmed" and then Have then
                        E.CS.Items (E.CS.N_Items).Affirmed := True;
                     elsif Key = "ref" and then Have then
                        declare
                           It   : Item renames E.CS.Items (E.CS.N_Items);
                           Tail : constant String := Split_At (Val, ':', False);
                        begin
                           if It.N_Refs = Max_Refs then
                              raise Format_Error with "too many refs";
                           end if;
                           It.N_Refs := It.N_Refs + 1;
                           It.Refs (It.N_Refs) :=
                             (Target => Veritoid_Named (N, Split_At (Val, ':', True)),
                              Needed => Parse_Rung (Split_At (Tail, '@', True)),
                              Seen   => Parse_Version
                                          (Split_At (Tail, '@', False)));
                        end;
                     else
                        raise Format_Error with "unexpected token: " & Tok;
                     end if;
                  else
                     if Key = "actor" then
                        E.A.Actor := Actor_Named (N, Val);
                     elsif Key = "criterion" then
                        E.A.Criterion := Criterion_Named (N, Val);
                     elsif Key = "kind" then
                        begin
                           E.A.Kind := Act_Kind'Value (Val);
                        exception
                           when Constraint_Error =>
                              raise Format_Error with "not a kind: " & Val;
                        end;
                     elsif Key = "level" then
                        E.A.Level := Parse_Rung (Val);
                     elsif Key = "read" then
                        if E.A.N_Reads = Max_Reads then
                           raise Format_Error with "too many reads";
                        end if;
                        E.A.N_Reads := E.A.N_Reads + 1;
                        E.A.Reads (E.A.N_Reads) :=
                          (Id  => Veritoid_Named (N, Split_At (Val, '@', True)),
                           Ver => Parse_Version (Split_At (Val, '@', False)));
                     else
                        raise Format_Error with "unexpected token: " & Tok;
                     end if;
                  end if;
               end;
               Pos := Stop;
            end;
         end if;
      end loop;
      if First then
         raise Format_Error with "empty record";
      end if;
      return E;
   end From_Line;

   ---------------------------------------------------------------------
   --  Save / Load
   ---------------------------------------------------------------------

   procedure Save (Path : String; N : Names; L : Log) is
      use Ada.Text_IO;
      F : File_Type;
      procedure Put_Names (Kind : String; T : Name_Table) is
      begin
         for I in 1 .. T.Count loop
            Put_Line (F, Kind & " " & To_String (T.Names (I)));
         end loop;
      end Put_Names;
   begin
      Create (F, Out_File, Path);
      Put_Line (F, "# v2 kernel log (ada-opus spike); see Kernel.Text");
      Put_Names ("veritoid", N.Veritoids);
      Put_Names ("segment", N.Segments);
      Put_Names ("actor", N.Actors);
      Put_Names ("criterion", N.Criteria);
      for I in 1 .. Length (L) loop
         Put_Line (F, To_Line (N, Get (L, I)));
      end loop;
      Close (F);
   end Save;

   procedure Load (Path : String; N : out Names; L : out Log) is
      use Ada.Text_IO;
      F  : File_Type;
      Ok : Boolean;
   begin
      N := (others => <>);
      L := Empty_Log;
      Open (F, In_File, Path);
      while not End_Of_File (F) loop
         declare
            Line : constant String := Trim (Get_Line (F), Ada.Strings.Both);
            Sp   : constant Natural := Index (Line, " ");
            Head : constant String :=
              (if Sp = 0 then Line else Line (Line'First .. Sp - 1));
            Rest : constant String :=
              (if Sp = 0 then "" else Trim (Line (Sp + 1 .. Line'Last),
                                            Ada.Strings.Both));
            Id   : Positive;
         begin
            if Line'Length = 0 or else Line (Line'First) = '#' then
               null;
            elsif Head = "veritoid" then
               Id := Veritoid_Named (N, Rest);
            elsif Head = "segment" then
               Id := Positive (Segment_Named (N, Rest));
            elsif Head = "actor" then
               Id := Positive (Actor_Named (N, Rest));
            elsif Head = "criterion" then
               Id := Positive (Criterion_Named (N, Rest));
            else
               Push (L, From_Line (N, Line), Ok);
               if not Ok then
                  raise Format_Error with "log longer than Max_Log";
               end if;
            end if;
            pragma Unreferenced (Id);
         end;
      end loop;
      Close (F);
   exception
      when others =>
         if Is_Open (F) then
            Close (F);
         end if;
         raise;
   end Load;

   ---------------------------------------------------------------------
   --  Describing a state
   ---------------------------------------------------------------------

   function Describe_State (N : Names; S : State) return String is
      R : Unbounded_String;
      P : constant Rung_Array := Positions (S);
      C : constant Rung_Array := Ceilings (S);
   begin
      for V in Veritoid_Id loop
         if S.V (V).Present then
            Append (R, "  " & Veritoid_Name (N, V) & "@" & Img (S.V (V).Ver)
                    & "  segment " & Segment_Name (N, S.V (V).Segment)
                    & "  claimed " & Rung_Name (S.V (V).Claimed)
                    & "  position " & Rung_Name (P (V))
                    & "  ceiling " & Rung_Name (C (V)) & LF);
            for Q in 1 .. S.V (V).N_Refs loop
               declare
                  Rf : Reference renames S.V (V).Refs (Q);
               begin
                  Append (R, "      -> " & Veritoid_Name (N, Rf.Target)
                          & " needs " & Rung_Name (Rf.Needed)
                          & ", seen @" & Img (Rf.Seen)
                          & (if S.V (Rf.Target).Present
                             then ", current @" & Img (S.V (Rf.Target).Ver)
                             else ", target gone") & LF);
               end;
            end loop;
         end if;
      end loop;
      Append (R, "  acts:" & LF);
      for J in 1 .. S.N_Acts loop
         declare
            A : Act renames S.Acts (J);
         begin
            Append (R, "    " & Trim (J'Image, Ada.Strings.Left) & ". "
                    & To_Lower (A.Kind'Image) & " by "
                    & Actor_Name (N, A.Actor) & " ["
                    & Criterion_Name (N, A.Criterion) & "] at "
                    & Rung_Name (A.Level) & " reads");
            for I in 1 .. A.N_Reads loop
               Append (R, " " & Veritoid_Name (N, A.Reads (I).Id) & "@"
                       & Img (A.Reads (I).Ver));
            end loop;
            Append (R, (if Binds (S.V, A) then "  (binds)" else "  (lapsed)")
                    & LF);
         end;
      end loop;
      return To_String (R);
   end Describe_State;

   function Frontier_Items (N : Names; S : State) return Item_List is
      F     : constant Frontier_Set := Frontier (S);
      Out_L : Item_List (1 .. Max_Veritoids * (1 + 2 * Max_Refs));
      K     : Natural := 0;
      procedure Add (X : String) is
      begin
         K := K + 1;
         Out_L (K) := To_Unbounded_String (X);
      end Add;
   begin
      for V in Veritoid_Id loop
         if F.Overclaim (V) then
            Add ("overclaim(" & Veritoid_Name (N, V) & ")");
         end if;
         for Q in Ref_Index loop
            if F.Stale (V, Q) then
               Add ("stale-reference(" & Veritoid_Name (N, V) & ", "
                    & Veritoid_Name (N, S.V (V).Refs (Q).Target) & ")");
            end if;
            if F.Unmet (V, Q) then
               Add ("unmet-need(" & Veritoid_Name (N, V) & ", "
                    & Veritoid_Name (N, S.V (V).Refs (Q).Target) & ")");
            end if;
         end loop;
      end loop;
      return Out_L (1 .. K);
   end Frontier_Items;

   function Describe_Frontier (N : Names; S : State) return String is
      Items : constant Item_List := Frontier_Items (N, S);
      R     : Unbounded_String;
   begin
      if Items'Length = 0 then
         return "  (empty: steady)" & LF;
      end if;
      for X of Items loop
         Append (R, "  " & To_String (X) & LF);
      end loop;
      return To_String (R);
   end Describe_Frontier;

end Kernel.Text;
