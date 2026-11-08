with Ada.Text_IO;
with Ada.Exceptions;
with Ada.Strings.Fixed;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Characters.Handling;
with Kernel.States; use Kernel.States;

package body Kernel.Store with SPARK_Mode => Off is

   function Trim (S : String) return String is
     (Ada.Strings.Fixed.Trim (S, Ada.Strings.Both));

   function Img (N : Integer) return String is (Trim (Integer'Image (N)));

   function Lower (S : String) return String
     renames Ada.Characters.Handling.To_Lower;

   function Quoted (N : Name) return String is ('"' & Trim (N) & '"');

   ----------------------------------------------------------------------
   --  Writing
   ----------------------------------------------------------------------

   function Line_Of (R : Log_Record) return String is
      U : Unbounded_String;
   begin
      case R.Kind is
         when Changeset_Record =>
            Append (U, "changeset " & Img (Integer (R.Write.Segment))
                       & " " & Img (Integer (R.Write.Count)));
            for I in 1 .. R.Write.Count loop
               declare
                  E : Veritoid_Entry renames R.Write.Items (I);
               begin
                  Append (U, " v " & Img (Integer (E.Id))
                             & " " & Img (Integer (E.Vers))
                             & " " & Lower (E.Claimed'Image)
                             & " " & Img (Integer (E.Refs.Count)));
                  for J in 1 .. E.Refs.Count loop
                     Append (U, " " & Img (Integer (E.Refs.Items (J).Target))
                                & " " & Lower (E.Refs.Items (J).Needed'Image)
                                & " " & Img (Integer (E.Refs.Items (J).Seen)));
                  end loop;
               end;
            end loop;
         when Act_Record =>
            Append (U, "act " & Lower (R.Did.Kind'Image)
                       & " " & Lower (R.Did.Attests'Image)
                       & " " & Quoted (R.Did.Actor)
                       & " " & Quoted (R.Did.Criterion)
                       & " " & Img (Integer (R.Did.Reads.Count)));
            for I in 1 .. R.Did.Reads.Count loop
               Append (U, " " & Img (Integer (R.Did.Reads.Items (I).Id))
                          & " " & Img (Integer (R.Did.Reads.Items (I).Vers)));
            end loop;
      end case;
      return To_String (U);
   end Line_Of;

   function To_Lines (L : Log) return String is
      U : Unbounded_String;
   begin
      for K in 1 .. Length (L) loop
         Append (U, Line_Of (Record_At (L, K)) & ASCII.LF);
      end loop;
      return To_String (U);
   end To_Lines;

   procedure Save (L : Log; Path : String) is
      F : Ada.Text_IO.File_Type;
   begin
      Ada.Text_IO.Create (F, Ada.Text_IO.Out_File, Path);
      for K in 1 .. Length (L) loop
         Ada.Text_IO.Put_Line (F, Line_Of (Record_At (L, K)));
      end loop;
      Ada.Text_IO.Close (F);
   end Save;

   ----------------------------------------------------------------------
   --  Reading
   ----------------------------------------------------------------------

   Parse_Error : exception;

   --  A cursor over one line's tokens. Quoted tokens keep their spaces.
   type Cursor is record
      Line : Unbounded_String;
      Pos  : Positive := 1;
   end record;

   function Next (C : in out Cursor) return String is
      S : constant String := To_String (C.Line);
      I : Natural := C.Pos;
   begin
      while I <= S'Last and then S (I) = ' ' loop
         I := I + 1;
      end loop;
      if I > S'Last then
         raise Parse_Error with "unexpected end of line";
      end if;
      if S (I) = '"' then
         declare
            J : Natural := I + 1;
         begin
            while J <= S'Last and then S (J) /= '"' loop
               J := J + 1;
            end loop;
            if J > S'Last then
               raise Parse_Error with "unterminated quote";
            end if;
            C.Pos := J + 1;
            return S (I + 1 .. J - 1);
         end;
      else
         declare
            J : Natural := I;
         begin
            while J <= S'Last and then S (J) /= ' ' loop
               J := J + 1;
            end loop;
            C.Pos := J;
            return S (I .. J - 1);
         end;
      end if;
   end Next;

   function Next_Int (C : in out Cursor; Low, High : Integer) return Integer
   is
      T : constant String := Next (C);
      V : Integer;
   begin
      V := Integer'Value (T);
      if V < Low or else V > High then
         raise Parse_Error with "out of range: " & T;
      end if;
      return V;
   exception
      when Constraint_Error =>
         raise Parse_Error with "not a number: " & T;
   end Next_Int;

   function Next_Rung (C : in out Cursor) return Rung is
      T : constant String := Lower (Next (C));
   begin
      for R in Rung loop
         if Lower (R'Image) = T then
            return R;
         end if;
      end loop;
      raise Parse_Error with "not a rung: " & T;
   end Next_Rung;

   function Parse (Line : String) return Log_Record is
      C    : Cursor := (Line => To_Unbounded_String (Line), Pos => 1);
      Head : constant String := Lower (Next (C));
   begin
      if Head = "changeset" then
         declare
            W : Changeset;
            N : Integer;
         begin
            W.Segment := Segment_Id (Next_Int (C, 1, Max_Segments));
            N := Next_Int (C, 0, Max_Per_Segment);
            for I in 1 .. N loop
               declare
                  E : Veritoid_Entry;
                  K : Integer;
               begin
                  if Lower (Next (C)) /= "v" then
                     raise Parse_Error with "expected v";
                  end if;
                  E.Id      := Veritoid_Id (Next_Int (C, 1, Max_Veritoids));
                  E.Vers    := Version (Next_Int (C, 1, Integer'Last));
                  E.Claimed := Next_Rung (C);
                  K         := Next_Int (C, 0, Max_Refs);
                  for J in 1 .. K loop
                     declare
                        R : Reference;
                     begin
                        R.Target :=
                          Veritoid_Id (Next_Int (C, 1, Max_Veritoids));
                        R.Needed := Next_Rung (C);
                        R.Seen   := Version (Next_Int (C, 1, Integer'Last));
                        E.Refs   := Append (E.Refs, R);
                     end;
                  end loop;
                  W := Append (W, E);
               end;
            end loop;
            return Of_Changeset (W);
         end;
      elsif Head = "act" then
         declare
            A    : Act;
            Kind : constant String := Lower (Next (C));
            N    : Integer;
         begin
            if Kind = "check" then
               A.Kind := Check;
            elsif Kind = "affirmation" then
               A.Kind := Affirmation;
            else
               raise Parse_Error with "not an act kind: " & Kind;
            end if;
            A.Attests   := Next_Rung (C);
            A.Actor     := To_Name (Next (C));
            A.Criterion := To_Name (Next (C));
            N           := Next_Int (C, 0, Max_Reads);
            for I in 1 .. N loop
               declare
                  R : Read;
               begin
                  R.Id    := Veritoid_Id (Next_Int (C, 1, Max_Veritoids));
                  R.Vers  := Version (Next_Int (C, 1, Integer'Last));
                  A.Reads := Append (A.Reads, R);
               end;
            end loop;
            return Of_Act (A);
         end;
      else
         raise Parse_Error with "unknown record: " & Head;
      end if;
   end Parse;

   procedure Load
     (Path    : String;
      L       : out Log;
      Ok      : out Boolean;
      Message : out String;
      Last    : out Natural)
   is
      F      : Ada.Text_IO.File_Type;
      Line_N : Natural := 0;

      procedure Fail (Why : String) is
         M : constant String := "line " & Img (Line_N) & ": " & Why;
         N : constant Natural :=
           Natural'Min (M'Length, Message'Length);
      begin
         Message (Message'First .. Message'First + N - 1) :=
           M (M'First .. M'First + N - 1);
         Last := Message'First + N - 1;
         Ok   := False;
      end Fail;

   begin
      L    := Empty;
      Ok   := True;
      Last := Message'First - 1;
      Ada.Text_IO.Open (F, Ada.Text_IO.In_File, Path);
      while not Ada.Text_IO.End_Of_File (F) loop
         declare
            Line : constant String := Trim (Ada.Text_IO.Get_Line (F));
            Why  : Refusal;
            Cul  : Id_Set;
         begin
            Line_N := Line_N + 1;
            if Line'Length > 0 and then Line (Line'First) /= '#' then
               Append (L, Parse (Line), Why, Cul);
               if Why /= Accepted then
                  Fail ("refused: " & Lower (Why'Image));
                  Ada.Text_IO.Close (F);
                  return;
               end if;
            end if;
         exception
            when E : Parse_Error =>
               Fail (Ada.Exceptions.Exception_Message (E));
               Ada.Text_IO.Close (F);
               return;
         end;
      end loop;
      Ada.Text_IO.Close (F);
   end Load;

end Kernel.Store;
