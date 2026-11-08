--  Porcelain: names for the kernel's integer ids, a line format for the
--  log, and printing of a state and its frontier.  Not SPARK (it does
--  string handling and file I/O); its correctness is tested, not proved.
--
--  The log file format, one record per line, tokens separated by spaces:
--
--    veritoid c            -- declares names, in id order, so a file read
--    segment T             -- back gets exactly the same ids
--    actor B
--    criterion rederive
--    changeset author=A segment=T result=accepted item=c@2:rederived
--       item=d@2:rederived ref=c:drafted@1 item=e@1:drafted affirmed
--       ref=c:drafted@2                     (all on one line)
--    act actor=B criterion=rederive kind=check level=rederived
--       result=accepted read=c@2 read=d@2   (all on one line)
--
--  "ref" and "affirmed" belong to the most recent "item".  Lines starting
--  with "#" and blank lines are ignored.

with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Kernel.Model;          use Kernel.Model;
with Kernel.Store;          use Kernel.Store;

package Kernel.Text with SPARK_Mode => Off is

   Max_Names : constant := 32;
   type Name_Array is array (1 .. Max_Names) of Unbounded_String;

   type Name_Table is record
      Count : Natural := 0;
      Names : Name_Array;
   end record;

   type Names is record
      Veritoids : Name_Table;
      Segments  : Name_Table;
      Actors    : Name_Table;
      Criteria  : Name_Table;
   end record;

   Format_Error : exception;

   --  The id for a name, adding it if new.  Raises Format_Error when a
   --  table is full or the name cannot be written as a token.
   function Veritoid_Named (N : in out Names; Name : String) return Veritoid_Id;
   function Segment_Named (N : in out Names; Name : String) return Segment_Id;
   function Actor_Named (N : in out Names; Name : String) return Actor_Id;
   function Criterion_Named (N : in out Names; Name : String) return Criterion_Id;

   function Veritoid_Name (N : Names; Id : Veritoid_Id) return String;
   function Segment_Name (N : Names; Id : Segment_Id) return String;
   function Actor_Name (N : Names; Id : Actor_Id) return String;
   function Criterion_Name (N : Names; Id : Criterion_Id) return String;

   function Rung_Name (R : Rung) return String;
   function Outcome_Name (O : Outcome) return String;

   --  One record as a line, and back.
   function To_Line (N : Names; E : Log_Entry) return String;
   function From_Line (N : in out Names; Line : String) return Log_Entry;

   --  The whole log, names first.
   procedure Save (Path : String; N : Names; L : Log);
   procedure Load (Path : String; N : out Names; L : out Log);

   --  Human-readable state and frontier.
   function Describe_State (N : Names; S : State) return String;
   function Describe_Frontier (N : Names; S : State) return String;

   --  Each frontier item as "overclaim(c)", "stale-reference(d, c)",
   --  "unmet-need(u, c)", in id order, for tests to compare.
   type Item_List is array (Positive range <>) of Unbounded_String;
   function Frontier_Items (N : Names; S : State) return Item_List;

end Kernel.Text;
