--  The log (spec §2): the ordered, append-only sequence of records, and
--  the state as of any point in it (P1, P2).
--
--  Fold is the definition: the state as of K is Step applied K times
--  from Initial. State_At is the loop that computes it, proved equal to
--  Fold. "The state is a function of the log prefix" is then the lemma
--  Lemma_Fold_Prefix: two logs that agree on records 1 .. K have the
--  same Fold at K. Append-only is the postcondition of Append: the old
--  records are where they were, and Log has no other mutator.
with Kernel.States; use Kernel.States;

package Kernel.Logs with SPARK_Mode => On is

   --  This unit's contracts are proved, not executed: the ghost lemma
   --  loop in Append would cost a fold per record per append at run
   --  time, and the invariant of State_At a fold per step. Kernel.States
   --  keeps its contracts on at run time, so a test still runs every
   --  state-level postcondition.
   pragma Assertion_Policy (Ignore);

   type Log_Count is range 0 .. Max_Log;
   subtype Log_Index is Log_Count range 1 .. Max_Log;

   type Log is private;

   function Length (L : Log) return Log_Count;

   function Record_At (L : Log; K : Log_Index) return Log_Record
   with Pre => K <= Length (L);

   Empty : constant Log;

   -------------------------------------------------------------------
   --  One record applied to one state
   -------------------------------------------------------------------

   type Outcome is record
      After    : State;
      Why      : Refusal;
      Culprits : Id_Set;
   end record;

   --  Apply or Record_Act, as a function. Everything their contracts
   --  say is restated here so that it travels with the log.
   function Try (S : State; R : Log_Record) return Outcome
   with Pre  => Valid (S),
        Post =>
          Valid (Try'Result.After)
          and then
          (if Try'Result.Why /= Accepted then Try'Result.After = S
           elsif R.Kind = Changeset_Record then
             Try'Result.After.Acts = S.Acts
             and then Try'Result.After.N_Acts = S.N_Acts
             and then (for all V in Veritoid_Id =>
                         Try'Result.After.Veritoids (V)
                           = Candidate (S.Veritoids, R.Write, V))
             and then (for all K in 1 .. S.N_Acts =>
                         Lapse_Exact (S.Veritoids,
                                      Try'Result.After.Veritoids,
                                      R.Write, S.Acts (K)))
           else
             Try'Result.After.Veritoids = S.Veritoids
             and then Try'Result.After.Ranks = S.Ranks
             and then Try'Result.After.N_Acts = S.N_Acts + 1
             and then Try'Result.After.Acts (S.N_Acts + 1) = R.Did
             and then (for all K in 1 .. S.N_Acts =>
                         Try'Result.After.Acts (K) = S.Acts (K))
             and then (for all V in Veritoid_Id =>
                         Position (Try'Result.After, V) >= Position (S, V)
                         and then
                         (if R.Did.Kind = Affirmation
                            or else not Reads_Id (R.Did.Reads, V)
                          then Position (Try'Result.After, V)
                               = Position (S, V))));

   --  The state after R; a record that would be refused changes nothing.
   function Step (S : State; R : Log_Record) return State
   with Pre  => Valid (S),
        Post => Valid (Step'Result) and then Step'Result = Try (S, R).After;

   function Admits (S : State; R : Log_Record) return Boolean is
     (Try (S, R).Why = Accepted)
   with Pre => Valid (S);

   -------------------------------------------------------------------
   --  The state as of a point in the log
   -------------------------------------------------------------------

   --  The definition.
   function Fold (L : Log; K : Log_Count) return State
   with Ghost,
        Pre  => K <= Length (L),
        Post => Valid (Fold'Result)
                and then
                (if K = 0 then Same (Fold'Result, Initial)
                 else Same (Fold'Result,
                            Step (Fold (L, K - 1), Record_At (L, K)))),
        Subprogram_Variant => (Decreases => K);

   --  The computation.
   function State_At (L : Log; K : Log_Count) return State
   with Pre  => K <= Length (L),
        Post => Valid (State_At'Result)
                and then Same (State_At'Result, Fold (L, K));

   function Current (L : Log) return State;

   --  P1: the state as of K depends on records 1 .. K only.
   function Same_Prefix (A, B : Log; K : Log_Count) return Boolean is
     (K <= Length (A) and then K <= Length (B)
      and then (for all J in 1 .. K =>
                  Same (Record_At (A, J), Record_At (B, J))))
   with Ghost;

   procedure Lemma_Fold_Prefix (A, B : Log; K : Log_Count)
   with Ghost,
        Pre  => Same_Prefix (A, B, K),
        Post => Same (Fold (A, K), Fold (B, K)),
        Subprogram_Variant => (Decreases => K);

   --  Every record was admitted by the state before it. Logs built
   --  through Append have this; a log read from a file may not.
   function Well_Formed (L : Log) return Boolean is
     (for all K in 1 .. Length (L) => Admits (Fold (L, K - 1), Record_At (L, K)))
   with Ghost;

   -------------------------------------------------------------------
   --  P2: the only way the log changes
   -------------------------------------------------------------------

   function Prefix_Preserved (Before, After : Log) return Boolean is
     (Length (After) >= Length (Before)
      and then (for all K in 1 .. Length (Before) =>
                  Record_At (After, K) = Record_At (Before, K)));

   procedure Append
     (L        : in out Log;
      R        : Log_Record;
      Why      : out Refusal;
      Culprits : out Id_Set)
   with Post =>
     (if Why = Accepted then
        Length (L) = Length (L'Old) + 1
        and then Record_At (L, Length (L)) = R
        and then Prefix_Preserved (L'Old, L)
        and then Same (Current (L), Step (Current (L'Old), R))
        and then (if Well_Formed (L'Old) then Well_Formed (L))
      else L = L'Old);

private

   type Record_Array is array (Log_Index) of Log_Record;

   type Log is record
      Count : Log_Count    := 0;
      Items : Record_Array := [others => <>];
   end record;

   Empty : constant Log := (others => <>);

   function Length (L : Log) return Log_Count is (L.Count);

   function Record_At (L : Log; K : Log_Index) return Log_Record is
     (L.Items (K));

   function Current (L : Log) return State is (State_At (L, Length (L)));

end Kernel.Logs;
