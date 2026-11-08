--  The log and how a state is folded from it (KERNEL-SPEC.md sections 2
--  and 4): segment changesets, acts, refusals, the append-only log, the
--  state as of any index, and P2-P5 as contracts and lemmas.

with Kernel.Model; use Kernel.Model;

package Kernel.Store with SPARK_Mode => On is

   Max_Items : constant := 8;
   Max_Log   : constant := 128;

   ---------------------------------------------------------------------
   --  Segment changesets
   ---------------------------------------------------------------------

   --  One veritoid as the changeset writes it.  Affirmed records the
   --  author's statement that this veritoid, left at its content version,
   --  is still right against what changed; it is what lets an unchanged
   --  veritoid's references be reconciled to new target versions.
   type Item is record
      Id       : Veritoid_Id     := 1;
      Ver      : Version         := 0;
      Claimed  : Rung            := Sketch;
      N_Refs   : Ref_Count       := 0;
      Refs     : Reference_Array := [others => <>];
      Affirmed : Boolean         := False;
   end record;

   subtype Item_Count is Natural range 0 .. Max_Items;
   subtype Item_Index is Positive range 1 .. Max_Items;
   type Item_Array is array (Item_Index) of Item;

   --  The full new written state of one segment.  Every veritoid of the
   --  segment not listed is removed.
   type Changeset is record
      Author  : Actor_Id   := 1;
      Segment : Segment_Id := 1;
      N_Items : Item_Count := 0;
      Items   : Item_Array := [others => <>];
   end record;

   ---------------------------------------------------------------------
   --  Records and outcomes
   ---------------------------------------------------------------------

   type Record_Kind is (Changeset_Record, Act_Record);

   type Outcome is
     (Accepted,
      Duplicate_Item,        --  one id twice in a changeset
      Foreign_Id,            --  id already lives in another segment
      Unaffirmed_Reconcile,  --  references of an unchanged veritoid moved
                             --  without the author's affirmation
      Cycle,                 --  the reference graph would have a cycle
      Act_Capacity,          --  Max_Acts reached
      Log_Full);             --  reported only; nothing could be recorded

   --  A record as written to the log.  Result is the outcome computed
   --  when it was appended; a refused record stays in the log, visible,
   --  and the fold skips it.
   type Log_Entry is record
      Kind   : Record_Kind := Act_Record;
      CS     : Changeset;
      A      : Act;
      Result : Outcome     := Accepted;
   end record;

   ---------------------------------------------------------------------
   --  Canonical records
   ---------------------------------------------------------------------

   --  Bounded arrays have slots past their counts.  Nothing the kernel
   --  computes reads them, but equality of values does, so every record is
   --  stored with those slots reset: equal meaning is then equal value,
   --  which is what replay (P8) compares.

   function Canonical (R : Reference_Array; N : Ref_Count)
      return Reference_Array
   is ([for I in Ref_Index => (if I <= N then R (I) else (others => <>))]);

   function Canonical (It : Item) return Item is
     ((Id       => It.Id,
       Ver      => It.Ver,
       Claimed  => It.Claimed,
       N_Refs   => It.N_Refs,
       Refs     => Canonical (It.Refs, It.N_Refs),
       Affirmed => It.Affirmed));

   function Canonical (CS : Changeset) return Changeset is
     ((Author  => CS.Author,
       Segment => CS.Segment,
       N_Items => CS.N_Items,
       Items   =>
         [for I in Item_Index =>
            (if I <= CS.N_Items then Canonical (CS.Items (I))
             else (others => <>))]));

   function Canonical (A : Act) return Act is
     ((Actor     => A.Actor,
       Criterion => A.Criterion,
       Kind      => A.Kind,
       N_Reads   => A.N_Reads,
       Reads     =>
         [for I in Read_Index =>
            (if I <= A.N_Reads then A.Reads (I) else (others => <>))],
       Level     => A.Level));

   --  A record keeps only the payload its kind uses.
   function Canonical (E : Log_Entry) return Log_Entry is
     ((Kind   => E.Kind,
       CS     => (if E.Kind = Changeset_Record then Canonical (E.CS)
                  else (others => <>)),
       A      => (if E.Kind = Act_Record then Canonical (E.A)
                  else (others => <>)),
       Result => E.Result));

   ---------------------------------------------------------------------
   --  Applying a changeset to a table
   ---------------------------------------------------------------------

   function To_Veritoid (Seg : Segment_Id; It : Item) return Veritoid is
     (Present => True,
      Segment => Seg,
      Ver     => It.Ver,
      Claimed => It.Claimed,
      N_Refs  => It.N_Refs,
      Refs    => It.Refs);

   function In_Items (CS : Changeset; V : Veritoid_Id) return Boolean is
     (for some I in 1 .. CS.N_Items => CS.Items (I).Id = V);

   function In_Segment
     (T : Veritoid_Table; Seg : Segment_Id; V : Veritoid_Id) return Boolean
   is (T (V).Present and then T (V).Segment = Seg);

   function No_Foreign (T : Veritoid_Table; CS : Changeset) return Boolean is
     (for all I in 1 .. CS.N_Items =>
        (if T (CS.Items (I).Id).Present then
           T (CS.Items (I).Id).Segment = CS.Segment));

   function No_Duplicates (CS : Changeset) return Boolean is
     (for all I in 1 .. CS.N_Items =>
        (for all J in 1 .. CS.N_Items =>
           (if I /= J then CS.Items (I).Id /= CS.Items (J).Id)));

   --  The table after CS: the segment's old veritoids are gone unless
   --  listed; listed ones are as written; everything else is untouched.
   function New_Table (T : Veritoid_Table; CS : Changeset)
      return Veritoid_Table
   with
     Pre  => No_Duplicates (CS),
     Post =>
       (for all V in Veritoid_Id =>
          (if In_Items (CS, V) then
             (for some I in 1 .. CS.N_Items =>
                CS.Items (I).Id = V
                and then New_Table'Result (V)
                         = To_Veritoid (CS.Segment, CS.Items (I)))
           elsif In_Segment (T, CS.Segment, V) then
             New_Table'Result (V) = (others => <>)
           else New_Table'Result (V) = T (V)));

   --  "The changeset changed or removed (V, its current version)."
   function Changes
     (T : Veritoid_Table; CS : Changeset; V : Veritoid_Id) return Boolean
   is (In_Segment (T, CS.Segment, V)
       and then
         not (for some I in 1 .. CS.N_Items =>
                CS.Items (I).Id = V and then CS.Items (I).Ver = T (V).Ver));

   ---------------------------------------------------------------------
   --  Acyclicity: a ranking, found or not
   ---------------------------------------------------------------------

   type Rank_Result is record
      Ok   : Boolean    := False;
      Rank : Rank_Array := [others => 0];
   end record;

   --  Every present unranked id has a present unranked target: the
   --  layering ran to its fixpoint.
   function Closed (T : Veritoid_Table; R : Rank_Array) return Boolean is
     (for all V in Veritoid_Id =>
        (if T (V).Present and then R (V) = 0 then
           (for some Q in 1 .. T (V).N_Refs =>
              T (T (V).Refs (Q).Target).Present
              and then R (T (V).Refs (Q).Target) = 0)));

   --  Kahn-style layering, run to its fixpoint.  Sound (Ok gives a valid
   --  ranking) and, with Lemma_Rank_Complete, complete: if any ranking
   --  exists, Ok.  So Ok holds exactly when the graph has no cycle.
   function Compute_Rank (T : Veritoid_Table) return Rank_Result
   with Post =>
     (Compute_Rank'Result.Ok
      = (for all V in Veritoid_Id =>
           (if T (V).Present then Compute_Rank'Result.Rank (V) /= 0)))
     and then Closed (T, Compute_Rank'Result.Rank)
     and then (if Compute_Rank'Result.Ok then
                 Ranked (T, Compute_Rank'Result.Rank));

   procedure Lemma_Rank_Complete (T : Veritoid_Table; W : Rank_Array)
   with
     Ghost,
     Global => null,
     Pre    => Ranked (T, W),
     Post   => Compute_Rank (T).Ok;

   ---------------------------------------------------------------------
   --  One step
   ---------------------------------------------------------------------

   type Try_Result is record
      Result : Outcome := Accepted;
      Next   : State;
   end record;

   function Append_Act (S : State; A : Act) return State
   with
     Pre  => S.N_Acts < Max_Acts,
     Post =>
       Append_Act'Result.V = S.V
       and then Append_Act'Result.Rank = S.Rank
       and then Append_Act'Result.N_Acts = S.N_Acts + 1
       and then
         (for all J in 1 .. S.N_Acts =>
            Append_Act'Result.Acts (J) = S.Acts (J))
       and then Append_Act'Result.Acts (S.N_Acts + 1) = A;

   --  What appending a record to a log whose state is S would do.
   function Try
     (S : State; Kind : Record_Kind; CS : Changeset; A : Act)
      return Try_Result
   with
     Pre  => Well_Formed (S),
     Post =>
       Well_Formed (Try'Result.Next)
       and then Try'Result.Result /= Log_Full
       and then
         (if Try'Result.Result = Cycle then
            Kind = Changeset_Record and then No_Duplicates (CS)
            and then not Compute_Rank (New_Table (S.V, CS)).Ok)
       and then
         (if Try'Result.Result /= Accepted then Same (Try'Result.Next, S)
          elsif Kind = Act_Record then
            S.N_Acts < Max_Acts
            and then Try'Result.Next = Append_Act (S, A)
          else
            No_Duplicates (CS)
            and then No_Foreign (S.V, CS)
            and then Compute_Rank (New_Table (S.V, CS)).Ok
            and then Try'Result.Next.V = New_Table (S.V, CS)
            and then Try'Result.Next.N_Acts = S.N_Acts
            and then Try'Result.Next.Acts = S.Acts);

   --  The fold step.  A record whose recorded result is a refusal is
   --  skipped.  A record recorded as accepted is applied again, and if it
   --  no longer applies (a hand-edited log) it is skipped too, so the
   --  fold is total and every state it yields is well formed.
   function Step (S : State; E : Log_Entry) return State is
     (if E.Result /= Accepted then S
      else Try (S, E.Kind, E.CS, E.A).Next)
   with Pre => Well_Formed (S), Post => Well_Formed (Step'Result);

   ---------------------------------------------------------------------
   --  The log
   ---------------------------------------------------------------------

   type Log is private;

   Empty_Log : constant Log;

   function Length (L : Log) return Natural
   with Post => Length'Result <= Max_Log;

   function Get (L : Log; I : Positive) return Log_Entry
   with Pre => I <= Length (L);

   --  The state as of index K: the first K records folded.  P1 in the
   --  language's terms: an expression function of (L, K) with no global
   --  inputs, so equal logs give equal states.
   function State_At (L : Log; K : Natural) return State is
     (if K = 0 then Empty_State
      else Step (State_At (L, K - 1), Get (L, K)))
   with
     Pre                => K <= Length (L),
     Post               => Well_Formed (State_At'Result),
     Subprogram_Variant => (Decreases => K);

   function Eq (X, Y : Item) return Boolean is
     (X.Id = Y.Id and then X.Ver = Y.Ver and then X.Claimed = Y.Claimed
      and then X.N_Refs = Y.N_Refs and then Eq (X.Refs, Y.Refs)
      and then X.Affirmed = Y.Affirmed)
   with Annotate => (GNATprove, Logical_Equal);
   function Eq (X, Y : Item_Array) return Boolean is
     (for all I in Item_Index => Eq (X (I), Y (I)))
   with Annotate => (GNATprove, Logical_Equal);
   function Eq (X, Y : Changeset) return Boolean is
     (X.Author = Y.Author and then X.Segment = Y.Segment
      and then X.N_Items = Y.N_Items and then Eq (X.Items, Y.Items))
   with Annotate => (GNATprove, Logical_Equal);
   function Same_Entry (X, Y : Log_Entry) return Boolean is
     (X.Kind = Y.Kind and then Eq (X.CS, Y.CS) and then Eq (X.A, Y.A)
      and then X.Result = Y.Result)
   with Annotate => (GNATprove, Logical_Equal);

   function Same_Prefix (L1, L2 : Log; K : Natural) return Boolean is
     (K <= Length (L1) and then K <= Length (L2)
      and then (for all I in 1 .. K => Same_Entry (Get (L1, I), Get (L2, I))));

   --  The state as of K depends only on the first K records.
   procedure Lemma_Prefix (L1, L2 : Log; K : Natural)
   with
     Ghost,
     Global             => null,
     Pre                => Same_Prefix (L1, L2, K),
     Post               => Same (State_At (L1, K), State_At (L2, K)),
     Subprogram_Variant => (Decreases => K);

   ---------------------------------------------------------------------
   --  A store: the log with its current state kept alongside
   ---------------------------------------------------------------------

   type Store is record
      L   : Log   := Empty_Log;
      Cur : State := Empty_State;
   end record;

   function Valid (St : Store) return Boolean is
     (Same (St.Cur, State_At (St.L, Length (St.L))));

   function Empty_Store return Store
   with Post => Valid (Empty_Store'Result)
                and then Length (Empty_Store'Result.L) = 0;

   --  Append one record, in canonical form.  P2: the old records are
   --  untouched and the log grows by exactly the new one (a refusal
   --  included), or, if the log is full, nothing changes and Log_Full is
   --  reported.
   procedure Append
     (St     : in out Store;
      Kind   : Record_Kind;
      CS     : Changeset;
      A      : Act;
      Result : out Outcome)
   with
     Global => null,
     Pre    => Valid (St),
     Post   =>
       Valid (St)
       and then
         (if Length (St.L'Old) = Max_Log then
            Result = Log_Full and then St = St'Old
          else
            Length (St.L) = Length (St.L'Old) + 1
            and then Same_Prefix (St.L, St.L'Old, Length (St.L'Old))
            and then Same_Entry
                       (Get (St.L, Length (St.L)),
                        Canonical
                          (Log_Entry'(Kind => Kind, CS => CS, A => A,
                                      Result => Result)))
            and then Result
                     = Try (St'Old.Cur, Kind,
                            Get (St.L, Length (St.L)).CS,
                            Get (St.L, Length (St.L)).A).Result);

   --  Build a log from records read back from a file, keeping each
   --  record's recorded result.  Used by replay (P8).
   procedure Push (L : in out Log; E : Log_Entry; Ok : out Boolean)
   with
     Global => null,
     Post   =>
       (if Length (L'Old) = Max_Log then not Ok and then L = L'Old
        else
          Ok and then Length (L) = Length (L'Old) + 1
          and then Same_Prefix (L, L'Old, Length (L'Old))
          and then Same_Entry (Get (L, Length (L)), Canonical (E)));

   ---------------------------------------------------------------------
   --  P3, P4, P5
   ---------------------------------------------------------------------

   --  P3.  Lapse is exact.  For an act that binds before an accepted
   --  changeset, it binds after iff it read nothing the changeset changed
   --  or removed; an act that reads nothing in the segment (before or
   --  after) binds after exactly as it did before.
   procedure Lemma_Lapse_Exact (S : State; CS : Changeset; A : Act)
   with
     Ghost,
     Global => null,
     Pre    =>
       Well_Formed (S)
       and then Try (S, Changeset_Record, CS, A).Result = Accepted,
     Post   =>
       (if Binds (S.V, A) then
          Binds (Try (S, Changeset_Record, CS, A).Next.V, A)
          = (for all I in 1 .. A.N_Reads =>
               not Changes (S.V, CS, A.Reads (I).Id)))
       and then
         (if (for all I in 1 .. A.N_Reads =>
                not In_Segment (S.V, CS.Segment, A.Reads (I).Id)
                and then not In_Items (CS, A.Reads (I).Id))
          then
            Binds (Try (S, Changeset_Record, CS, A).Next.V, A)
            = Binds (S.V, A));

   --  P4.  Monotone under acts.  Appending a check never lowers any
   --  position; positions of veritoids it does not read are unchanged;
   --  a read veritoid rises to at most the act's level.
   procedure Lemma_Monotone (S : State; A : Act)
   with
     Ghost,
     Global => null,
     Pre    => S.N_Acts < Max_Acts and then A.Kind = Check,
     Post   =>
       (for all V in Veritoid_Id =>
          Position (Append_Act (S, A), V) >= Position (S, V)
          and then
            (if not Reads_Id (A, V) then
               Position (Append_Act (S, A), V) = Position (S, V))
          and then
            Position (Append_Act (S, A), V)
            <= Rung'Max (Position (S, V), A.Level));

   --  P5, both directions.  A changeset refused as a cycle leaves a table
   --  that has no ranking at all, i.e. it truly has a cycle.
   procedure Lemma_Cycle_Exact (S : State; CS : Changeset; W : Rank_Array)
   with
     Ghost,
     Global => null,
     Pre    =>
       Well_Formed (S)
       and then Try (S, Changeset_Record, CS, (others => <>)).Result = Cycle,
     Post   => not Ranked (New_Table (S.V, CS), W);

   --  P5 (soundness) is Try's postcondition: an accepted changeset leaves a state
   --  that carries a valid ranking (Well_Formed), so the graph is acyclic;
   --  a changeset whose graph has no ranking is refused with Cycle and the
   --  refusal is recorded in the log by Append.

private

   type Entry_Array is array (1 .. Max_Log) of Log_Entry;

   type Log is record
      Len   : Natural range 0 .. Max_Log := 0;
      Items : Entry_Array := [others => <>];
   end record;

   Empty_Log : constant Log := (Len => 0, Items => [others => <>]);

   function Length (L : Log) return Natural is (L.Len);

   function Get (L : Log; I : Positive) return Log_Entry is (L.Items (I));

end Kernel.Store;
