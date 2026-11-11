--  Events, lines, forks, and the state read from a line (spec draft 4,
--  sections 3, 4 "Guards, with order", and 6). Executable, not proved:
--  SPARK_Mode is off here. What is proved is about Vk.Model, the
--  function from the state this unit reads to the frontier.
--
--  THE READING TAKEN (the spec's sections 3 and 6 cannot both be read
--  literally; see the account): a line is a SET of events, each with a
--  time; times are unique across everything; the order is time. A
--  state is read as of a time Now. A checkpoint is a snapshot of the
--  set. Closing a fork is set union.
with Vk.Model;

package Vk.Lines with SPARK_Mode => Off is

   type Event_Kind is (Write, Retire, Decide, Withdraw, Mark, Unmark);

   type Seen_Row is array (Edge_Ix) of Seen;

   type Event is record
      Present : Boolean    := False;
      Time    : Natural    := 0;
      What    : Event_Kind := Write;
      P       : Id         := 1;   --  write, retire, mark, unmark
      V       : Ver        := 1;   --  write: the version now selected
      Heirs   : Id_Set     := [others => False];   --  retire: descends to
      J       : Dec_Ix     := 1;   --  decide, withdraw: which decision
      Saw     : Seen_Row   := [others => <>];
      --  write: what each of the new version's edges pointed at, at
      --  which version, on the line the write was made on
   end record;

   type Event_Ix is range 1 .. 40;
   type Timeline is array (Event_Ix) of Event;
   Empty_Line : constant Timeline := [others => <>];

   --  The base: evidence (with its same sets), each with its time; and
   --  the wording of every decision anyone has made. Whether a decision
   --  is in force is a matter of a line (a Decide event names it).
   type Base is record
      Ev  : Ev_List;
      Dec : Dec_List;
   end record;

   --  Letter: section 4 as written (the evidence that meets a guard
   --  need not be later than the finding). Later: it must be later than
   --  the finding, which is what the lead says was meant.
   type Guard_Mode is (Letter, Later);

   type Options is record
      Mode            : Guard_Mode := Later;
      Off_Line_Guards : Boolean := False;
      --  a finding against a version this line never selected (one a
      --  rewind dropped, or another fork's) guards the line's versions
      Written_Counts  : Boolean := True;   --  the C4 switch
      Reads_Shed      : Boolean := False;
      --  True is the letter: a finding at the selected version whose
      --  reads are no longer as they were neither applies nor guards.
      --  False (as built): it guards, like a finding against an
      --  earlier version
      Seen_Recorded   : Boolean := True;
      --  what a version was written against is what its write event
      --  recorded (on the line it was made on). Off: it is worked out
      --  from the line being read, by time (see the account, R9)
   end record;

   type State is record
      S : Selection;
      F : Facts;
      L : Line_View;
   end record;

   function Read_State
     (O : Ontology; T : Version_Table; Ln : Timeline; B : Base; Now : Natural;
      Opt : Options := (others => <>)) return State;

   procedure Add (Ln : in out Timeline; E : Event);
   function Union (A, B : Timeline) return Timeline;
   --  Drop every event later than Upto.
   function Rewind (Ln : Timeline; Upto : Natural) return Timeline;

   --  What P was at, on this line, as of time At_T.
   function Version_At (Ln : Timeline; P : Id; At_T : Natural) return Pick;

end Vk.Lines;
