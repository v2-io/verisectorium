--  One small slice of the model, the way Ada 2022 would have it.
--  By the Ada/SPARK agent (Fable 5.2), 2026-11-11. This is Ada, not
--  SPARK; the notes at the foot say what SPARK would change and why,
--  and which shapes in the kernel-2 build were the prover's and which
--  were mine.
--
--  Compiled and run with GNAT 16.1.0 (-gnata turns the predicate on):
--
--     gnatmake -gnat2022 -gnata ada_spark.adb && ./ada_spark
--
--  (gnatmake is not on PATH on this machine; from any Alire crate,
--  such as ../kernel-2/ada, it is "alr exec -- gnatmake ...".) Output:
--
--     canon: O T c d k
--     promised and empty: T.description
--     refusal: a derived-result whose formal-claim holds a step was
--       refused when it was made (the type's predicate)
--     refusal: asking a gap for its note is a Constraint_Error
--
--  What Ada reaches for here:
--
--   * A closed choice is an enumeration, and a thing that is one of
--     several shapes is a record with a discriminant. A Slot is such a
--     record: only a suggested slot HAS a note, only a filled one HAS
--     a provisional mark, only a holding one has a segment inside it.
--     Asking a gap for its note is a Constraint_Error, not a blank.
--
--   * Holding is containment. A held segment is a value inside its
--     slot, inside its assembly: there is no name by which anything
--     else could own it, and copying the assembly copies it. Pointing
--     is a name, looked up in the corpus. The model's two ways of
--     filling a slot are the language's two ways of having a thing.
--
--   * A segment is a veritoid or an assembly by type extension: the
--     question "which is it" is a membership test, and no number says.
--
--   * A kind's declaration is a constant table, and "this assembly
--     conforms to its kind" is a predicate ON THE TYPE. A value that
--     does not conform cannot be made: the attempt raises. That is
--     Ada's natural refusal, and the run shows one.
with Ada.Assertions;
with Ada.Containers.Indefinite_Holders;
with Ada.Containers.Indefinite_Ordered_Maps;
with Ada.Containers.Indefinite_Ordered_Sets;
with Ada.Containers.Vectors;
with Ada.Strings.Fixed;
with Ada.Text_IO;

procedure Ada_Spark is

   package Model is

      subtype Text is String;
      --  Content and names are ordinary strings. Segments of different
      --  sizes live in containers of indefinite things; nothing here
      --  is bounded.

      type Veritoid_Kind is (Claim, Step, Explanation);

      --  The root of the two sorts of segment.
      type Segment (Name_Length : Natural) is abstract tagged record
         Name : Text (1 .. Name_Length);
      end record;

      --  A veritoid: one piece of content of a declared kind.
      type Veritoid (Name_Length, Length : Natural) is
        new Segment (Name_Length) with record
         Kind    : Veritoid_Kind;
         Content : Text (1 .. Length);
      end record;

      function A (Kind : Veritoid_Kind; Name, Content : Text) return Veritoid
      is (Name'Length, Content'Length, Name, Kind, Content);

      -----------------------------------------------------------------
      --  What an assembly kind declares
      -----------------------------------------------------------------

      type How_Many is (One, At_Most_One, Any_Number);

      type What_Fills (Any : Boolean := True) is record
         case Any is
            when True  => null;
            when False => Kind : Veritoid_Kind;
         end case;
      end record;
      Anything : constant What_Fills := (Any => True);
      function Only (Kind : Veritoid_Kind) return What_Fills is
        (Any => False, Kind => Kind);

      type Slot_Name is new String (1 .. 12);
      function "+" (S : String) return Slot_Name is
        (Slot_Name (S & [S'Length + 1 .. 12 => ' ']))
      with Pre => S'Length <= 12;

      type Slot_Declaration is record
         Name  : Slot_Name;
         Count : How_Many;
         Fills : What_Fills;
      end record;
      type Slot_Declarations is
        array (Positive range <>) of Slot_Declaration;

      type Assembly_Kind (Slots : Natural; Name_Length : Natural) is record
         Name     : Text (1 .. Name_Length);
         Declares : Slot_Declarations (1 .. Slots);
      end record;
      type Kind_Of_Assembly is not null access constant Assembly_Kind;

      -----------------------------------------------------------------
      --  Slots
      -----------------------------------------------------------------

      package Holders is new Ada.Containers.Indefinite_Holders
        (Segment'Class);
      package Notes is new Ada.Containers.Indefinite_Holders (Text);

      type Slot_State is (Suggested, Promised, Gap, Holds, Points_At);
      subtype Filled is Slot_State range Holds .. Points_At;

      type Slot (State : Slot_State := Gap) is record
         Declared_As : Slot_Name;      --  which of the kind's slots it is
         case State is
            when Suggested =>
               Note : Notes.Holder;
            when Promised | Gap =>
               null;
            when Filled =>
               Provisional : Boolean := False;
               case State is
                  when Holds     => Inside : Holders.Holder;
                  when Points_At => Target : Notes.Holder;   --  a name
                  when others    => null;
               end case;
         end case;
      end record;

      function Holding
        (As : String; S : Segment'Class; Provisional : Boolean := False)
         return Slot
      is (Holds, +As, Provisional, Holders.To_Holder (S));
      function Pointing_At
        (As : String; Target : Text; Provisional : Boolean := False)
         return Slot
      is (Points_At, +As, Provisional, Notes.To_Holder (Target));
      function Suggestion (As : String; Note : Text) return Slot is
        (Suggested, +As, Notes.To_Holder (Note));
      function Promise (As : String) return Slot is (Promised, +As);
      function A_Gap (As : String) return Slot is (Gap, +As);

      package Slot_Lists is new Ada.Containers.Vectors (Positive, Slot);

      -----------------------------------------------------------------
      --  An assembly: slots, in order, as its kind declares
      -----------------------------------------------------------------

      type Unchecked_Assembly (Name_Length : Natural) is
        new Segment (Name_Length) with record
         Kind  : Kind_Of_Assembly;
         Slots : Slot_Lists.Vector;
      end record;

      --  Every slot is one the kind declares; no slot declared "one"
      --  or "at most one" appears twice; and whatever a slot HOLDS is
      --  of the kind the declaration asks for. (What a slot points at
      --  lives elsewhere, so only the corpus can check that.)
      function Conforms (A : Unchecked_Assembly) return Boolean;

      subtype Assembly is Unchecked_Assembly
      with Dynamic_Predicate => Conforms (Assembly);

      --  Making one is where the predicate is checked. (In a package
      --  of its own only so that it is not an inherited operation of
      --  the type, which could not then return the checked subtype.)
      package Making is
         function An
           (Kind : Kind_Of_Assembly; Name : Text; Slots : Slot_Lists.Vector)
            return Assembly
         is (Assembly'(Name'Length, Name, Kind, Slots));
      end Making;

      -----------------------------------------------------------------
      --  A corpus, its roots, its canon
      -----------------------------------------------------------------

      package Segment_Maps is new Ada.Containers.Indefinite_Ordered_Maps
        (Text, Segment'Class);
      package Name_Sets is new Ada.Containers.Indefinite_Ordered_Sets (Text);

      type Corpus is record
         Freestanding : Segment_Maps.Map;   --  the segments nothing holds
         Roots        : Name_Sets.Set;
      end record;

      procedure Add (C : in out Corpus; S : Segment'Class);
      procedure Mark_Root (C : in out Corpus; Name : Text)
      with Pre => C.Freestanding.Contains (Name)
                  and then C.Freestanding (Name) in Unchecked_Assembly'Class;

      --  What the roots reach through slots that are filled and not
      --  provisional.
      function Canon (C : Corpus) return Name_Sets.Set;

      --  "assembly.slot" for every slot, at any depth, that is
      --  promised and so has nothing in it.
      function Promised_And_Empty (C : Corpus) return Name_Sets.Set;

   end Model;

   package body Model is

      function Fits (S : Segment'Class; F : What_Fills) return Boolean is
        (F.Any
         or else (S in Veritoid'Class
                  and then Veritoid'Class (S).Kind = F.Kind));

      function Conforms (A : Unchecked_Assembly) return Boolean is
        ((for all S of A.Slots =>
            (for some D of A.Kind.Declares =>
               D.Name = S.Declared_As
               and then (if S.State = Holds
                         then Fits (S.Inside.Element, D.Fills))))
         and then
         (for all D of A.Kind.Declares =>
            D.Count = Any_Number
            or else
              (for all I in A.Slots.First_Index .. A.Slots.Last_Index =>
                 (for all J in A.Slots.First_Index .. A.Slots.Last_Index =>
                    (if A.Slots (I).Declared_As = D.Name
                       and then A.Slots (J).Declared_As = D.Name
                     then I = J)))));

      procedure Add (C : in out Corpus; S : Segment'Class) is
      begin
         C.Freestanding.Insert (S.Name, S);
      end Add;

      procedure Mark_Root (C : in out Corpus; Name : Text) is
      begin
         C.Roots.Include (Name);
      end Mark_Root;

      function Canon (C : Corpus) return Name_Sets.Set is
         Reached : Name_Sets.Set;

         procedure Reach (S : Segment'Class) is
         begin
            if Reached.Contains (S.Name) then
               return;                  --  pointing may go round; holding cannot
            end if;
            Reached.Insert (S.Name);
            if S in Unchecked_Assembly'Class then
               for Sl of Unchecked_Assembly'Class (S).Slots loop
                  case Sl.State is
                     when Suggested | Promised | Gap =>
                        null;
                     when Holds =>
                        if not Sl.Provisional then
                           Reach (Sl.Inside.Element);
                        end if;
                     when Points_At =>
                        if not Sl.Provisional
                          and then C.Freestanding.Contains (Sl.Target.Element)
                        then
                           Reach (C.Freestanding (Sl.Target.Element));
                        end if;
                  end case;
               end loop;
            end if;
         end Reach;
      begin
         for Root of C.Roots loop
            Reach (C.Freestanding (Root));
         end loop;
         return Reached;
      end Canon;

      function Promised_And_Empty (C : Corpus) return Name_Sets.Set is
         Found : Name_Sets.Set;

         procedure Look (S : Segment'Class) is
         begin
            if S in Unchecked_Assembly'Class then
               for Sl of Unchecked_Assembly'Class (S).Slots loop
                  if Sl.State = Promised then
                     Found.Include
                       (S.Name & "."
                        & Ada.Strings.Fixed.Trim
                            (String (Sl.Declared_As), Ada.Strings.Right));
                  elsif Sl.State = Holds then
                     Look (Sl.Inside.Element);
                  end if;
               end loop;
            end if;
         end Look;
      begin
         for S of C.Freestanding loop
            Look (S);
         end loop;
         return Found;
      end Promised_And_Empty;

   end Model;

   use Model, Model.Making;

   --------------------------------------------------------------------
   --  This verisectorium's two assembly kinds
   --------------------------------------------------------------------

   Derived_Result : aliased constant Assembly_Kind :=
     (Slots => 4, Name_Length => 14, Name => "derived-result",
      Declares =>
        [(+"formal-claim", One,         Only (Claim)),
         (+"derivation",   Any_Number,  Only (Step)),
         (+"description",  One,         Only (Explanation)),
         (+"eli8",         At_Most_One, Only (Explanation))]);

   Outline : aliased constant Assembly_Kind :=
     (Slots => 1, Name_Length => 7, Name => "outline",
      Declares => [1 => (+"entry", Any_Number, Anything)]);

   --------------------------------------------------------------------
   --  The instance
   --------------------------------------------------------------------

   The : Corpus;

   procedure Put (Title : String; S : Name_Sets.Set) is
   begin
      Ada.Text_IO.Put (Title & ":");
      for N of S loop
         Ada.Text_IO.Put (" " & N);
      end loop;
      Ada.Text_IO.New_Line;
   end Put;

begin
   Add (The,
        An (Derived_Result'Access, "T",
            [Holding ("formal-claim",
                      A (Claim, "c",
                         "Every bounded monotone sequence of reals "
                         & "converges.")),
             Holding ("derivation",
                      A (Step, "d",
                         "Take the least upper bound of the terms and "
                         & "show the terms come within any ε of it.")),
             Promise ("description"),
             Holding ("eli8",
                      A (Explanation, "k",
                         "If you keep stepping forward and there is a "
                         & "wall you cannot pass, you end up settling "
                         & "somewhere at or before the wall."))]));

   Add (The,
        An (Derived_Result'Access, "U",
            [Holding ("formal-claim",
                      A (Claim, "u",
                         "Every Cauchy sequence of reals converges."))]));

   Add (The,
        An (Outline'Access, "O",
            [Pointing_At ("entry", "T"),
             Pointing_At ("entry", "U", Provisional => True),
             Suggestion  ("entry",
                          "a result about series is probably wanted here"),
             A_Gap       ("entry")]));
   Mark_Root (The, "O");

   Put ("canon", Canon (The));
   Put ("promised and empty", Promised_And_Empty (The));

   --  The refusal. A derivation step where the formal claim goes: the
   --  value cannot be made.
   declare
      Wrong : Corpus;
   begin
      Add (Wrong,
           An (Derived_Result'Access, "W",
               [Holding ("formal-claim",
                         A (Step, "s", "Suppose not."))]));
      Ada.Text_IO.Put_Line ("refusal: NOT refused (this should not print)");
   exception
      when Ada.Assertions.Assertion_Error =>
         Ada.Text_IO.Put_Line
           ("refusal: a derived-result whose formal-claim holds a step "
            & "was refused when it was made (the type's predicate)");
   end;

   --  And the other refusal, the variant record's: a gap has no note.
   declare
      G : constant Slot := A_Gap ("entry");
   begin
      Ada.Text_IO.Put_Line ("a gap's note: " & G.Note.Element);
   exception
      when Constraint_Error =>
         Ada.Text_IO.Put_Line
           ("refusal: asking a gap for its note is a Constraint_Error");
   end;
end Ada_Spark;

--  NOTES
--
--  Departures from the slice as worded.
--   * A slot here is one ENTRY: each carries the name of the declared
--     slot it is an instance of, so "derivation: any number" is any
--     number of entries so named, in the assembly's one order. "How
--     many" is then a property of the assembly, checked by the
--     predicate. "One" is checked as "not two"; that a required slot
--     is missing (U has no description at all) is something owed, not
--     a malformed value, so the type does not refuse it.
--   * Roots are a designation kept by the corpus, not a field of the
--     assembly: marking a root does not change what the assembly is.
--   * Held veritoids have names (c, d, k) only so the canon can be
--     printed. In the model a held piece is reached through its
--     holder, and nothing here looks one up by name.
--
--  What was awkward, or refused.
--   * A type cannot contain itself, so "a slot holds a segment, an
--     assembly has slots" needs one indirection. Ada's way is a
--     Holder of Segment'Class, which still has value semantics, and
--     for that the root type has to be tagged. With an untagged
--     variant record for veritoid-or-assembly (which is what I would
--     have written first) the generic cannot be instantiated on the
--     unfinished type. So the sum of two sorts is a type extension and
--     the sum of five slot states is a variant record, for no reason
--     the model would recognise.
--   * A predicate cannot sit on the type it is about: its own check
--     would call itself. It goes on a subtype (Assembly) of an
--     unchecked type, and the constructor has to live in a package of
--     its own to be allowed to return that subtype. The compiler says
--     all of this clearly; none of it is the model's.
--   * Strings of different lengths in records mean discriminants
--     (Name_Length, Length) or Unbounded_String. Either is noise.
--   * Slot names are a fixed-width string type padded with blanks. An
--     enumeration would be the Ada answer if the kinds were fixed when
--     the program is compiled; they are a verisectorium's to declare,
--     so they are data.
--   * The predicate can refuse what a value CONTAINS. It cannot refuse
--     a slot that points at the wrong kind of thing, because the thing
--     is elsewhere; that check belongs to the corpus and I left it
--     out.
--   * This file had to be named ada_spark.adb: a file called ada.adb
--     is the body of the language's own root package.
--
--  What SPARK would change, and whose the kernel-2 shapes were.
--   * SPARK is content with variant records. The flat Version record
--     in kernel-2, where a kind number says whether the slots mean
--     anything, was MINE, chosen so that every quantified contract
--     ranged over one uniform array. The prover did not ask for it.
--   * SPARK is not content with this file's containment. Class-wide
--     holders and the standard containers are outside it; a segment
--     inside a slot inside a segment would be an owning pointer with
--     SPARK's ownership rules, or a formal container with a bound. So
--     "holding is an id in a table, like pointing, with a flag" in
--     kernel-2 WAS the prover's. It is the accommodation I would most
--     like back: here, that nothing held is held twice is true because
--     a value has one place; there, it was constraint C1 and a
--     hypothesis of the frame theorem.
--   * The recursive walk with a visited set, in place of "apply the
--     step five times", is ordinary Ada. SPARK would want a
--     termination measure for it, and a contract saying what Canon
--     returns, which needs reachability, which its contracts cannot
--     say. That one was the prover's too.
--   * The numbered slots for facts, the bounds on everything, and the
--     closed "same" sets: the prover's, all of them.
