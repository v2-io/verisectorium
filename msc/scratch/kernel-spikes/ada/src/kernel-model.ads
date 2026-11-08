--  The objects of the kernel (KERNEL-SPEC.md section 2) and the computed
--  things over one state (section 3): binds, position, ceiling, frontier,
--  steady.  Everything here is SPARK and every function is a function of
--  its arguments alone (Global => null is checked by flow analysis), which
--  is the language-level half of P1.
--
--  Identifiers are small integers.  Names ("c", "T", "B") belong to the
--  text layer (Kernel.Text), which maps them to these ids.
--
--  Capacities are fixed: SPARK proves best over bounded arrays.  Every
--  bound is a named constant below; exceeding one is a refusal, never a
--  silent truncation.

package Kernel.Model with SPARK_Mode => On is

   ---------------------------------------------------------------------
   --  The one dimension and its ladder
   ---------------------------------------------------------------------

   type Rung is (Sketch, Drafted, Checked, Rederived);
   --  Declaration order is ladder order, so "<" is the ladder.

   ---------------------------------------------------------------------
   --  Capacities and identifiers
   ---------------------------------------------------------------------

   Max_Veritoids : constant := 32;
   Max_Refs      : constant := 4;
   Max_Reads     : constant := 4;
   Max_Acts      : constant := 64;

   subtype Veritoid_Id is Positive range 1 .. Max_Veritoids;
   type Version is new Natural;
   type Segment_Id is range 1 .. 8;
   type Actor_Id is range 1 .. 16;
   type Criterion_Id is range 1 .. 16;

   type Rung_Array is array (Veritoid_Id) of Rung;

   ---------------------------------------------------------------------
   --  Veritoids and references
   ---------------------------------------------------------------------

   subtype Ref_Count is Natural range 0 .. Max_Refs;
   subtype Ref_Index is Positive range 1 .. Max_Refs;

   --  "This piece is predicated on Target, needs it at least at Needed,
   --  and was last reconciled against version Seen of it."
   type Reference is record
      Target : Veritoid_Id := 1;
      Needed : Rung        := Sketch;
      Seen   : Version     := 0;
   end record;

   type Reference_Array is array (Ref_Index) of Reference;

   --  A slot in the store's table.  Present = False means no veritoid
   --  with this id exists in the state (never added, or removed).
   type Veritoid is record
      Present : Boolean         := False;
      Segment : Segment_Id      := 1;
      Ver     : Version         := 0;
      Claimed : Rung            := Sketch;
      N_Refs  : Ref_Count       := 0;
      Refs    : Reference_Array := [others => <>];
   end record;

   type Veritoid_Table is array (Veritoid_Id) of Veritoid;

   ---------------------------------------------------------------------
   --  Acts
   ---------------------------------------------------------------------

   type Act_Kind is (Check, Affirmation);

   subtype Read_Count is Natural range 0 .. Max_Reads;
   subtype Read_Index is Positive range 1 .. Max_Reads;

   type Read_Entry is record
      Id  : Veritoid_Id := 1;
      Ver : Version     := 0;
   end record;

   type Read_Array is array (Read_Index) of Read_Entry;

   type Act is record
      Actor     : Actor_Id     := 1;
      Criterion : Criterion_Id := 1;
      Kind      : Act_Kind     := Check;
      N_Reads   : Read_Count   := 0;
      Reads     : Read_Array   := [others => <>];
      Level     : Rung         := Sketch;
   end record;

   subtype Act_Count is Natural range 0 .. Max_Acts;
   subtype Act_Index is Positive range 1 .. Max_Acts;
   type Act_Array is array (Act_Index) of Act;

   ---------------------------------------------------------------------
   --  Acyclicity, carried as a witness
   ---------------------------------------------------------------------

   --  A rank strictly decreases along every reference between present
   --  veritoids.  A table has such a ranking iff its reference graph has
   --  no cycle; the state carries one so acyclicity is an invariant that
   --  can be stated and proved, not only checked.
   type Rank_Array is array (Veritoid_Id) of Natural;

   function Ranked (T : Veritoid_Table; Rank : Rank_Array) return Boolean is
     (for all V in Veritoid_Id =>
        (if T (V).Present then
           Rank (V) in 1 .. Max_Veritoids
           and then
             (for all R in 1 .. T (V).N_Refs =>
                (if T (T (V).Refs (R).Target).Present then
                   Rank (T (V).Refs (R).Target) < Rank (V)))));

   ---------------------------------------------------------------------
   --  A state
   ---------------------------------------------------------------------

   type State is record
      V      : Veritoid_Table := [others => <>];
      N_Acts : Act_Count      := 0;
      Acts   : Act_Array      := [others => <>];
      Rank   : Rank_Array     := [others => 0];
   end record;

   Empty_State : constant State := (others => <>);

   function Well_Formed (S : State) return Boolean is (Ranked (S.V, S.Rank));

   ---------------------------------------------------------------------
   --  1. binds
   ---------------------------------------------------------------------

   --  Every (id, version) the act read is the current version of id, and
   --  id still exists.
   function Binds (T : Veritoid_Table; A : Act) return Boolean is
     (for all I in 1 .. A.N_Reads =>
        T (A.Reads (I).Id).Present
        and then T (A.Reads (I).Id).Ver = A.Reads (I).Ver);

   function Reads_Id (A : Act; V : Veritoid_Id) return Boolean is
     (for some I in 1 .. A.N_Reads => A.Reads (I).Id = V);

   ---------------------------------------------------------------------
   --  2. position
   ---------------------------------------------------------------------

   --  Act J of S counts toward the position of V.  Only checks count; an
   --  affirmation never does.
   function Counts (S : State; J : Act_Index; V : Veritoid_Id) return Boolean
   is (J <= S.N_Acts
       and then S.Acts (J).Kind = Check
       and then Reads_Id (S.Acts (J), V)
       and then Binds (S.V, S.Acts (J)));

   --  The greatest rung among check acts that bind and read V; Sketch if
   --  there are none.  The postcondition is the definition.
   function Position (S : State; V : Veritoid_Id) return Rung
   with
     Post =>
       (for all J in 1 .. S.N_Acts =>
          (if Counts (S, J, V) then S.Acts (J).Level <= Position'Result))
       and then
         (Position'Result = Sketch
          or else
            (for some J in 1 .. S.N_Acts =>
               Counts (S, J, V) and then S.Acts (J).Level = Position'Result));

   function Positions (S : State) return Rung_Array
   with
     Post =>
       (for all V in Veritoid_Id =>
          Positions'Result (V) = Position (S, V));

   ---------------------------------------------------------------------
   --  3. ceiling
   ---------------------------------------------------------------------

   --  C solves the spec's defining equation over table T with positions
   --  P:  ceiling(v) = min (position(v), min over refs of ceiling(target)),
   --  written as "below each term, and equal to one of them".  An absent
   --  veritoid has ceiling Sketch (the spec leaves a reference to a
   --  removed target undefined here; nothing supports what is not there).
   function Is_Solution (T : Veritoid_Table; P, C : Rung_Array) return Boolean
   is (for all V in Veritoid_Id =>
         (if not T (V).Present then C (V) = Sketch
          else
            C (V) <= P (V)
            and then
              (for all R in 1 .. T (V).N_Refs =>
                 C (V) <= C (T (V).Refs (R).Target))
            and then
              (C (V) = P (V)
               or else
                 (for some R in 1 .. T (V).N_Refs =>
                    C (V) = C (T (V).Refs (R).Target)))));

   --  The ceilings of every veritoid.  Computed as the greatest fixpoint
   --  below the positions; on an acyclic graph the equation has exactly
   --  one solution (Lemma_Ceiling_Unique), so this is the spec's ceiling.
   --  No precondition: the fixpoint exists on any graph.
   function Ceilings (S : State) return Rung_Array
   with Post => Is_Solution (S.V, Positions (S), Ceilings'Result);

   function Ceiling (S : State; V : Veritoid_Id) return Rung is
     (Ceilings (S) (V));

   --  On an acyclic table the defining equation has one solution.
   procedure Lemma_Ceiling_Unique
     (T : Veritoid_Table; Rank : Rank_Array; P, C1, C2 : Rung_Array)
   with
     Ghost,
     Global => null,
     Pre    =>
       Ranked (T, Rank) and then Is_Solution (T, P, C1)
       and then Is_Solution (T, P, C2),
     Post   => C1 = C2;

   ---------------------------------------------------------------------
   --  4. frontier, 5. steady
   ---------------------------------------------------------------------

   type Flag_Array is array (Veritoid_Id) of Boolean;
   type Flag_Matrix is array (Veritoid_Id, Ref_Index) of Boolean;

   --  The frontier as a set: Overclaim (v), Stale (v, r), Unmet (v, r),
   --  where r indexes v's references.
   type Frontier_Set is record
      Overclaim : Flag_Array  := [others => False];
      Stale     : Flag_Matrix := [others => [others => False]];
      Unmet     : Flag_Matrix := [others => [others => False]];
   end record;

   function Is_Overclaim (T : Veritoid_Table; C : Rung_Array; V : Veritoid_Id)
      return Boolean
   is (T (V).Present and then T (V).Claimed > C (V));

   function Is_Stale (T : Veritoid_Table; V : Veritoid_Id; R : Ref_Index)
      return Boolean
   is (T (V).Present
       and then R <= T (V).N_Refs
       and then
         (not T (T (V).Refs (R).Target).Present
          or else T (T (V).Refs (R).Target).Ver /= T (V).Refs (R).Seen));

   function Is_Unmet
     (T : Veritoid_Table; C : Rung_Array; V : Veritoid_Id; R : Ref_Index)
      return Boolean
   is (T (V).Present
       and then R <= T (V).N_Refs
       and then C (T (V).Refs (R).Target) < T (V).Refs (R).Needed);

   --  Exactly the owed items, no more and no fewer.
   function Frontier (S : State) return Frontier_Set
   with
     Post =>
       (for all V in Veritoid_Id =>
          Frontier'Result.Overclaim (V)
          = Is_Overclaim (S.V, Ceilings (S), V)
          and then
            (for all R in Ref_Index =>
               Frontier'Result.Stale (V, R) = Is_Stale (S.V, V, R)
               and then Frontier'Result.Unmet (V, R)
                        = Is_Unmet (S.V, Ceilings (S), V, R)));

   function Is_Empty (F : Frontier_Set) return Boolean is
     (for all V in Veritoid_Id =>
        not F.Overclaim (V)
        and then (for all R in Ref_Index =>
                    not F.Stale (V, R) and then not F.Unmet (V, R)));

   function Steady (S : State) return Boolean is (Is_Empty (Frontier (S)));

   ---------------------------------------------------------------------
   --  Properties over one state, stated as lemmas
   ---------------------------------------------------------------------

   --  P6.  Ceiling bound.
   procedure Lemma_Ceiling_Bound (S : State)
   with
     Ghost,
     Global => null,
     Post   =>
       (for all V in Veritoid_Id =>
          (if S.V (V).Present then
             Ceiling (S, V) <= Position (S, V)
             and then
               (for all R in 1 .. S.V (V).N_Refs =>
                  Ceiling (S, V) <= Ceiling (S, S.V (V).Refs (R).Target))));

   --  P7.  Steady means honest.
   procedure Lemma_Steady_Honest (S : State)
   with
     Ghost,
     Global => null,
     Pre    => Steady (S),
     Post   =>
       (for all V in Veritoid_Id =>
          (if S.V (V).Present then S.V (V).Claimed <= Ceiling (S, V)));

end Kernel.Model;
