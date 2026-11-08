--  The v2 kernel spike, in SPARK (see ../KERNEL-SPEC.md).
--
--  This root package holds the objects of the spec: rungs, veritoid ids,
--  versions, references, acts, segment changesets and log records. All of
--  them are bounded, because that is the shape SPARK proves best over:
--  every list below is an array with a count, and every id is a small
--  discrete type. The bounds are spike bounds (they can be raised; they
--  are constants) and the account says what that costs the model.
--
--  Conventions kept throughout so that predefined "=" means what it
--  should: every slot of a list beyond its Count holds the Null_* value,
--  and every constructor here produces values that way. That is what
--  makes "the state is a function of the log prefix" testable as plain
--  equality.
package Kernel with SPARK_Mode => On is

   --  The one ladder (spec §2). Enumeration order is rung order, so
   --  "<" on Rung is the ladder's order and Rung'Min is its meet.
   type Rung is (Sketch, Drafted, Checked, Rederived);

   Max_Veritoids   : constant := 24;
   Max_Segments    : constant := 8;
   Max_Refs        : constant := 6;   --  references per veritoid
   Max_Reads       : constant := 6;   --  reads per act
   Max_Per_Segment : constant := 12;  --  veritoids one changeset may hold
   Max_Acts        : constant := 48;
   Max_Log         : constant := 96;
   Name_Length     : constant := 32;

   type Veritoid_Id is range 1 .. Max_Veritoids;
   type Segment_Id is range 1 .. Max_Segments;

   --  Versions are opaque to the kernel: a counter or a hash, supplied
   --  by whoever writes the changeset. The kernel only compares them.
   type Version is range 1 .. 2**31 - 1;

   --  Actor and criterion are carried, never interpreted. Fixed width
   --  so that an act is a plain record; To_Name pads or truncates.
   subtype Name is String (1 .. Name_Length);
   function To_Name (S : String) return Name;
   Blank_Name : constant Name := (others => ' ');

   -------------------------------------------------------------------
   --  References: (target, needed rung, target version seen)
   -------------------------------------------------------------------

   type Reference is record
      Target : Veritoid_Id := Veritoid_Id'First;
      Needed : Rung        := Sketch;
      Seen   : Version     := Version'First;
   end record;
   Null_Reference : constant Reference := (others => <>);

   type Ref_Count is range 0 .. Max_Refs;
   subtype Ref_Index is Ref_Count range 1 .. Max_Refs;
   type Ref_Array is array (Ref_Index) of Reference;

   type Ref_List is record
      Count : Ref_Count := 0;
      Items : Ref_Array := [others => Null_Reference];
   end record;
   No_Refs : constant Ref_List := (others => <>);

   function Has_Ref (R : Ref_List; I : Ref_Index) return Boolean is
     (I <= R.Count);

   --  The list is well-formed when unused slots are blank.
   function Normal (R : Ref_List) return Boolean is
     (for all I in Ref_Index =>
        (if I > R.Count then R.Items (I) = Null_Reference));

   function Append (R : Ref_List; X : Reference) return Ref_List
   with Pre  => R.Count < Max_Refs,
        Post => Append'Result.Count = R.Count + 1
                and then Append'Result.Items (R.Count + 1) = X
                and then (for all I in 1 .. R.Count =>
                            Append'Result.Items (I) = R.Items (I))
                and then (for all I in Ref_Index =>
                            (if I > R.Count + 1 then
                               Append'Result.Items (I) = R.Items (I)));

   -------------------------------------------------------------------
   --  Acts: (actor, criterion, kind, reads, rung)
   -------------------------------------------------------------------

   type Act_Kind is (Check, Affirmation);

   type Read is record
      Id   : Veritoid_Id := Veritoid_Id'First;
      Vers : Version     := Version'First;
   end record;
   Null_Read : constant Read := (others => <>);

   type Read_Count is range 0 .. Max_Reads;
   subtype Read_Index is Read_Count range 1 .. Max_Reads;
   type Read_Array is array (Read_Index) of Read;

   type Read_List is record
      Count : Read_Count := 0;
      Items : Read_Array := [others => Null_Read];
   end record;
   No_Reads : constant Read_List := (others => <>);

   function Append (R : Read_List; X : Read) return Read_List
   with Pre  => R.Count < Max_Reads,
        Post => Append'Result.Count = R.Count + 1
                and then Append'Result.Items (R.Count + 1) = X
                and then (for all I in 1 .. R.Count =>
                            Append'Result.Items (I) = R.Items (I))
                and then (for all I in Read_Index =>
                            (if I > R.Count + 1 then
                               Append'Result.Items (I) = R.Items (I)));

   --  Whether the act read veritoid V (at any version).
   function Reads_Id (R : Read_List; V : Veritoid_Id) return Boolean is
     (for some I in 1 .. R.Count => R.Items (I).Id = V);

   type Act is record
      Actor     : Name      := Blank_Name;
      Criterion : Name      := Blank_Name;
      Kind      : Act_Kind  := Check;
      Reads     : Read_List := No_Reads;
      Attests   : Rung      := Sketch;
   end record;
   Null_Act : constant Act := (others => <>);

   -------------------------------------------------------------------
   --  Segment changesets: the full new written state of one segment
   -------------------------------------------------------------------

   type Veritoid_Entry is record
      Id      : Veritoid_Id := Veritoid_Id'First;
      Vers    : Version     := Version'First;
      Claimed : Rung        := Sketch;
      Refs    : Ref_List    := No_Refs;
   end record;
   Null_Entry : constant Veritoid_Entry := (others => <>);

   type Entry_Count is range 0 .. Max_Per_Segment;
   subtype Entry_Index is Entry_Count range 1 .. Max_Per_Segment;
   type Entry_Array is array (Entry_Index) of Veritoid_Entry;

   type Changeset is record
      Segment : Segment_Id  := Segment_Id'First;
      Count   : Entry_Count := 0;
      Items   : Entry_Array := [others => Null_Entry];
   end record;
   Null_Changeset : constant Changeset := (others => <>);

   function Append (C : Changeset; X : Veritoid_Entry) return Changeset
   with Pre  => C.Count < Max_Per_Segment,
        Post => Append'Result.Segment = C.Segment
                and then Append'Result.Count = C.Count + 1
                and then Append'Result.Items (C.Count + 1) = X
                and then (for all I in 1 .. C.Count =>
                            Append'Result.Items (I) = C.Items (I))
                and then (for all I in Entry_Index =>
                            (if I > C.Count + 1 then
                               Append'Result.Items (I) = C.Items (I)));

   --  Whether the changeset names veritoid V.
   function Names (C : Changeset; V : Veritoid_Id) return Boolean is
     (for some I in 1 .. C.Count => C.Items (I).Id = V);

   --  Each id at most once.
   function Distinct_Ids (C : Changeset) return Boolean is
     (for all I in 1 .. C.Count =>
        (for all J in 1 .. C.Count =>
           (if I /= J then C.Items (I).Id /= C.Items (J).Id)));

   --  The index at which C names V.
   function Index_Of (C : Changeset; V : Veritoid_Id) return Entry_Index
   with Pre  => Names (C, V),
        Post => Index_Of'Result <= C.Count
                and then C.Items (Index_Of'Result).Id = V;

   -------------------------------------------------------------------
   --  Log records
   -------------------------------------------------------------------

   type Record_Kind is (Changeset_Record, Act_Record);

   --  A plain record rather than a variant one: the unused half holds
   --  its Null_* value, so equality of records is equality of meaning.
   type Log_Record is record
      Kind  : Record_Kind := Changeset_Record;
      Write : Changeset   := Null_Changeset;
      Did   : Act         := Null_Act;
   end record;

   --  Logical equality of two records, for the prover: "=" on a record
   --  with array components is a structural comparison the provers
   --  cannot carry through an uninterpreted function (A = B does not
   --  give them F (A) = F (B); measured, see the account). A function
   --  with this annotation is read by GNATprove as logical equality. At
   --  run time it is predefined "=", which coincides with it because
   --  every slot beyond a list's Count holds the Null_* value.
   function Same (A, B : Log_Record) return Boolean
   with Ghost, Global => null, Annotate => (GNATprove, Logical_Equal);

   function Of_Changeset (C : Changeset) return Log_Record is
     (Kind => Changeset_Record, Write => C, Did => Null_Act);

   function Of_Act (A : Act) return Log_Record is
     (Kind => Act_Record, Write => Null_Changeset, Did => A);

end Kernel;
