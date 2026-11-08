--  Serialization of the log (spec §5, P8). Porcelain: one record per
--  line, space-separated tokens, names in double quotes. Not SPARK:
--  it talks to files. Load goes through Logs.Append, so a record the
--  kernel would refuse is refused on load too and reported by line.
--
--    changeset <segment> <n> { v <id> <version> <rung> <k> { <target> <rung> <seen> } }
--    act <check|affirmation> <rung> "<actor>" "<criterion>" <n> { <id> <version> }
with Kernel.Logs; use Kernel.Logs;

package Kernel.Store with SPARK_Mode => Off is

   procedure Save (L : Log; Path : String);

   --  Ok is False when a line could not be parsed or was refused;
   --  Message then says which line and why, and L holds the records
   --  before it.
   procedure Load
     (Path    : String;
      L       : out Log;
      Ok      : out Boolean;
      Message : out String;
      Last    : out Natural);

   --  The same, in memory.
   function To_Lines (L : Log) return String;

   function Line_Of (R : Log_Record) return String;

end Kernel.Store;
