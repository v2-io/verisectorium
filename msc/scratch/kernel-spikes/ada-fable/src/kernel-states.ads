--  The state of a store and the five computed things (spec §3), with
--  the properties P3-P7 as contracts on the two ways a state changes.
--
--  A state is the current veritoid table, the acts recorded so far, and
--  one computed thing kept alongside: a rank for every present veritoid
--  such that every reference points strictly downward. The ranks are
--  the acyclicity witness (P5): a table is accepted only when it can be
--  ranked, and the well-founded recursion of "ceiling" (spec §3.3) is
--  the walk down the ranks. Ranks are canonical (a veritoid's rank is
--  the length of the longest reference chain below it), so they do not
--  spoil "state is a function of the log".
--
--  Two rules the spec leaves open are decided here, and the account
--  says why: a veritoid id, once introduced, belongs to its segment for
--  good (a changeset for T may only name fresh ids or T's own; a removed
--  id stays a tombstone), and an act may only read ids that have been
--  introduced. Both are what make P3 true as the spec states it.
package Kernel.States with SPARK_Mode => On is

   type Owner_Id is range 0 .. Max_Segments;
   No_Owner : constant Owner_Id := 0;

   type Veritoid is record
      Present : Boolean  := False;
      Owner   : Owner_Id := No_Owner;  --  set once, never changed
      Vers    : Version  := Version'First;
      Claimed : Rung     := Sketch;
      Refs    : Ref_List := No_Refs;
   end record;
   Null_Veritoid : constant Veritoid := (others => <>);

   type Veritoid_Table is array (Veritoid_Id) of Veritoid;

   type Rank_T is range 0 .. Max_Veritoids;
   type Rank_Array is array (Veritoid_Id) of Rank_T;

   type Act_Count is range 0 .. Max_Acts;
   subtype Act_Index is Act_Count range 1 .. Max_Acts;
   type Act_Array is array (Act_Index) of Act;

   type State is record
      Veritoids : Veritoid_Table := [others => Null_Veritoid];
      Ranks     : Rank_Array     := [others => 0];
      Acts      : Act_Array      := [others => Null_Act];
      N_Acts    : Act_Count      := 0;
   end record;
   Initial : constant State := (others => <>);

   --  Logical equality of states, for the prover (see Kernel.Same).
   function Same (A, B : State) return Boolean
   with Ghost, Global => null, Annotate => (GNATprove, Logical_Equal);

   -------------------------------------------------------------------
   --  The state invariant
   -------------------------------------------------------------------

   function Target_Of
     (T : Veritoid_Table; V : Veritoid_Id; I : Ref_Index) return Veritoid_Id
   is (T (V).Refs.Items (I).Target);

   --  Every present veritoid is ranked, no absent one is, and every
   --  reference to a present target points to a strictly smaller rank.
   --  A table with such ranks has no reference cycle.
   function Well_Ranked (T : Veritoid_Table; R : Rank_Array) return Boolean
   is
     (for all V in Veritoid_Id =>
        (R (V) /= 0) = T (V).Present
        and then
        (for all I in 1 .. T (V).Refs.Count =>
           (if T (V).Present and then T (Target_Of (T, V, I)).Present
            then R (Target_Of (T, V, I)) < R (V))));

   function Reads_Known (T : Veritoid_Table; A : Act) return Boolean is
     (for all I in 1 .. A.Reads.Count =>
        T (A.Reads.Items (I).Id).Owner /= No_Owner);

   function Valid_Def (S : State) return Boolean is
     (Well_Ranked (S.Veritoids, S.Ranks)
      and then
      (for all K in 1 .. S.N_Acts => Reads_Known (S.Veritoids, S.Acts (K))));

   --  Valid is Valid_Def, but opaque to callers outside this package:
   --  with the definition in view, the prover could not carry Valid
   --  across an equality of two states (see the account). The lemma
   --  hands the definition to a caller that needs it.
   function Valid (S : State) return Boolean
   with Post => Valid'Result = Valid_Def (S);

   -------------------------------------------------------------------
   --  1. binds
   -------------------------------------------------------------------

   function Binds (T : Veritoid_Table; A : Act) return Boolean is
     (for all I in 1 .. A.Reads.Count =>
        T (A.Reads.Items (I).Id).Present
        and then T (A.Reads.Items (I).Id).Vers = A.Reads.Items (I).Vers);

   function Binds (S : State; A : Act) return Boolean is
     (Binds (S.Veritoids, A));

   -------------------------------------------------------------------
   --  2. position
   -------------------------------------------------------------------

   --  Act K is a check that binds and read V.
   function Supports
     (S : State; K : Act_Index; V : Veritoid_Id) return Boolean
   is
     (K <= S.N_Acts
      and then S.Acts (K).Kind = Check
      and then Binds (S.Veritoids, S.Acts (K))
      and then Reads_Id (S.Acts (K).Reads, V));

   --  P is the greatest rung among supporting acts, or Sketch if none.
   function Is_Position (S : State; V : Veritoid_Id; P : Rung) return Boolean
   is
     ((for all K in Act_Index =>
         (if Supports (S, K, V) then S.Acts (K).Attests <= P))
      and then
      (P = Sketch
       or else (for some K in Act_Index =>
                  Supports (S, K, V) and then S.Acts (K).Attests = P)));

   function Position (S : State; V : Veritoid_Id) return Rung
   with Post => Is_Position (S, V, Position'Result);

   type Rung_Array is array (Veritoid_Id) of Rung;

   function Positions (S : State) return Rung_Array
   with Post =>
     (for all V in Veritoid_Id => Is_Position (S, V, Positions'Result (V)));

   -------------------------------------------------------------------
   --  3. ceiling
   -------------------------------------------------------------------

   --  What reference I of V can be rested on, given ceilings C: the
   --  target's ceiling, or Sketch when the target no longer exists
   --  (a reference to nothing supports nothing).
   function Rest
     (T : Veritoid_Table; C : Rung_Array; V : Veritoid_Id; I : Ref_Index)
      return Rung
   is
     (if T (Target_Of (T, V, I)).Present then C (Target_Of (T, V, I))
      else Sketch);

   --  C (V) = min (P (V), min over references of Rest), spelled out as
   --  a greatest lower bound: below everything, and equal to something.
   function Is_Ceiling
     (T : Veritoid_Table; P, C : Rung_Array; V : Veritoid_Id) return Boolean
   is
     (C (V) <= P (V)
      and then (for all I in 1 .. T (V).Refs.Count =>
                  C (V) <= Rest (T, C, V, I))
      and then (C (V) = P (V)
                or else (for some I in 1 .. T (V).Refs.Count =>
                           C (V) = Rest (T, C, V, I))));

   function Ceilings (S : State) return Rung_Array
   with Pre  => Valid (S),
        Post =>
          (for all V in Veritoid_Id =>
             (if S.Veritoids (V).Present
              then Is_Ceiling (S.Veritoids, Positions (S), Ceilings'Result, V)
              else Ceilings'Result (V) = Sketch));

   function Ceiling (S : State; V : Veritoid_Id) return Rung is
     (Ceilings (S) (V))
   with Pre => Valid (S);

   -------------------------------------------------------------------
   --  4. frontier, 5. steady
   -------------------------------------------------------------------

   function Overclaim (S : State; V : Veritoid_Id) return Boolean is
     (S.Veritoids (V).Present
      and then S.Veritoids (V).Claimed > Ceiling (S, V))
   with Pre => Valid (S);

   function Stale (S : State; V : Veritoid_Id; I : Ref_Index) return Boolean
   is
     (S.Veritoids (V).Present
      and then I <= S.Veritoids (V).Refs.Count
      and then
      (not S.Veritoids (Target_Of (S.Veritoids, V, I)).Present
       or else S.Veritoids (Target_Of (S.Veritoids, V, I)).Vers
               /= S.Veritoids (V).Refs.Items (I).Seen));

   function Unmet (S : State; V : Veritoid_Id; I : Ref_Index) return Boolean
   is
     (S.Veritoids (V).Present
      and then I <= S.Veritoids (V).Refs.Count
      and then Ceiling (S, Target_Of (S.Veritoids, V, I))
               < S.Veritoids (V).Refs.Items (I).Needed)
   with Pre => Valid (S);

   function Steady (S : State) return Boolean is
     (for all V in Veritoid_Id =>
        not Overclaim (S, V)
        and then (for all I in Ref_Index =>
                    not Stale (S, V, I) and then not Unmet (S, V, I)))
   with Pre => Valid (S);

   --  P7, as a lemma: steady means no veritoid claims above its ceiling.
   procedure Lemma_Steady_Is_Honest (S : State)
   with Ghost,
        Pre  => Valid (S) and then Steady (S),
        Post => (for all V in Veritoid_Id =>
                   (if S.Veritoids (V).Present
                    then S.Veritoids (V).Claimed <= Ceiling (S, V)));

   --  The frontier materialized, for callers that want the list.
   type Item_Kind is (Overclaim_Item, Stale_Item, Unmet_Item);

   type Frontier_Item is record
      Kind : Item_Kind   := Overclaim_Item;
      V    : Veritoid_Id := Veritoid_Id'First;
      Ref  : Ref_Count   := 0;   --  0 for an overclaim
   end record;
   Null_Item : constant Frontier_Item := (others => <>);

   Max_Items : constant := Max_Veritoids * (1 + 2 * Max_Refs);
   type Item_Count is range 0 .. Max_Items;
   subtype Item_Index is Item_Count range 1 .. Max_Items;
   type Item_Array is array (Item_Index) of Frontier_Item;

   type Frontier_List is record
      Count : Item_Count := 0;
      Items : Item_Array := [others => Null_Item];
   end record;

   function Contains (F : Frontier_List; X : Frontier_Item) return Boolean
   is (for some J in 1 .. F.Count => F.Items (J) = X);

   function Frontier (S : State) return Frontier_List
   with Pre  => Valid (S),
        Post =>
          (for all V in Veritoid_Id =>
             Contains (Frontier'Result, (Overclaim_Item, V, 0))
               = Overclaim (S, V)
             and then
             (for all I in Ref_Index =>
                Contains (Frontier'Result, (Stale_Item, V, I)) = Stale (S, V, I)
                and then
                Contains (Frontier'Result, (Unmet_Item, V, I))
                  = Unmet (S, V, I)))
          and then (Frontier'Result.Count = 0) = Steady (S);

   -------------------------------------------------------------------
   --  Changing a state: a segment changeset
   -------------------------------------------------------------------

   type Refusal is
     (Accepted,
      Duplicate_Id,  --  the changeset names an id twice
      Foreign_Id,    --  it names an id another segment owns
      Cycle,         --  it would create a reference cycle (P5)
      Unknown_Id,    --  an act reads an id never introduced
      Full);         --  a spike bound was hit

   type Id_Set is array (Veritoid_Id) of Boolean;
   No_Ids : constant Id_Set := [others => False];

   function Owns_Or_Fresh (T : Veritoid_Table; C : Changeset) return Boolean
   is
     (for all I in 1 .. C.Count =>
        T (C.Items (I).Id).Owner in No_Owner | Owner_Id (C.Segment));

   --  What veritoid V holds after C is applied to T: its entry in C;
   --  a tombstone if it was C's segment's and C dropped it; else as was.
   function Candidate
     (T : Veritoid_Table; C : Changeset; V : Veritoid_Id) return Veritoid
   is
     (if Names (C, V) then
        (Present => True,
         Owner   => Owner_Id (C.Segment),
         Vers    => C.Items (Index_Of (C, V)).Vers,
         Claimed => C.Items (Index_Of (C, V)).Claimed,
         Refs    => C.Items (Index_Of (C, V)).Refs)
      elsif T (V).Owner = Owner_Id (C.Segment) then
        (Present => False,
         Owner   => T (V).Owner,
         Vers    => Version'First,
         Claimed => Sketch,
         Refs    => No_Refs)
      else T (V));

   function Candidate_Table
     (T : Veritoid_Table; C : Changeset) return Veritoid_Table
   with Post => (for all V in Veritoid_Id =>
                   Candidate_Table'Result (V) = Candidate (T, C, V));

   --  Every member of the set has a present reference target in the
   --  set: a finite set like that contains a cycle.
   function Closed (T : Veritoid_Table; Set : Id_Set) return Boolean is
     (for all V in Veritoid_Id =>
        (if Set (V) then
           T (V).Present
           and then (for some I in 1 .. T (V).Refs.Count =>
                       T (Target_Of (T, V, I)).Present
                       and then Set (Target_Of (T, V, I)))));

   function Nonempty (Set : Id_Set) return Boolean is
     (for some V in Veritoid_Id => Set (V));

   type Ranking is record
      Why      : Refusal    := Accepted;
      Ranks    : Rank_Array := [others => 0];
      Culprits : Id_Set     := No_Ids;
   end record;

   --  Layered Kahn: pass P ranks every present veritoid whose present
   --  targets were all ranked in earlier passes. Succeeds exactly when
   --  the present reference graph is acyclic; on a cycle, the unranked
   --  set is returned as the witness. There is no third outcome.
   function Rank_All (T : Veritoid_Table) return Ranking
   with Post =>
     (case Rank_All'Result.Why is
        when Accepted  => Well_Ranked (T, Rank_All'Result.Ranks),
        when Cycle     => Nonempty (Rank_All'Result.Culprits)
                          and then Closed (T, Rank_All'Result.Culprits),
        when others    => False);

   --  Act A read some (id, version) that C changes or removes.
   function Touches (T : Veritoid_Table; C : Changeset; A : Act) return Boolean
   is
     (for some I in 1 .. A.Reads.Count =>
        T (A.Reads.Items (I).Id).Owner = Owner_Id (C.Segment)
        and then
        (not Names (C, A.Reads.Items (I).Id)
         or else C.Items (Index_Of (C, A.Reads.Items (I).Id)).Vers
                 /= A.Reads.Items (I).Vers));

   function Reads_In_Segment
     (T : Veritoid_Table; Seg : Segment_Id; A : Act) return Boolean
   is
     (for some I in 1 .. A.Reads.Count =>
        T (A.Reads.Items (I).Id).Owner = Owner_Id (Seg));

   --  P3 (lapse is exact), stated for one act across a changeset.
   function Lapse_Exact
     (Before, After : Veritoid_Table; C : Changeset; A : Act) return Boolean
   is
     ((Binds (Before, A) and then not Binds (After, A))
        = (Binds (Before, A) and then Touches (Before, C, A))
      and then
      (if not Reads_In_Segment (Before, C.Segment, A)
       then Binds (After, A) = Binds (Before, A)));

   procedure Apply
     (S        : in out State;
      C        : Changeset;
      Why      : out Refusal;
      Culprits : out Id_Set)
   with Pre  => Valid (S),
        Post =>
          Valid (S)
          and then
          (if Why = Accepted then
             S.Acts = S'Old.Acts
             and then S.N_Acts = S'Old.N_Acts
             and then (for all V in Veritoid_Id =>
                         S.Veritoids (V) = Candidate (S'Old.Veritoids, C, V))
             and then (for all K in 1 .. S.N_Acts =>
                         Lapse_Exact
                           (S'Old.Veritoids, S.Veritoids, C, S.Acts (K)))
           else
             S = S'Old
             and then (if Why = Cycle then
                         Nonempty (Culprits)
                         and then Closed
                           (Candidate_Table (S'Old.Veritoids, C), Culprits)));

   -------------------------------------------------------------------
   --  Changing a state: an act
   -------------------------------------------------------------------

   procedure Record_Act (S : in out State; A : Act; Why : out Refusal)
   with Pre  => Valid (S),
        Post =>
          Valid (S)
          and then
          (if Why = Accepted then
             S.Veritoids = S'Old.Veritoids
             and then S.Ranks = S'Old.Ranks
             and then S.N_Acts = S'Old.N_Acts + 1
             and then S.Acts (S.N_Acts) = A
             and then (for all K in 1 .. S'Old.N_Acts =>
                         S.Acts (K) = S'Old.Acts (K))
             --  P4: monotone under acts
             and then (for all V in Veritoid_Id =>
                         Position (S, V) >= Position (S'Old, V)
                         and then
                         (if A.Kind = Affirmation
                            or else not Reads_Id (A.Reads, V)
                          then Position (S, V) = Position (S'Old, V)))
           else S = S'Old);

end Kernel.States;
