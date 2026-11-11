--  The objects of KERNEL-SPEC draft 3 (sections 2 and 3), as bounded
--  tables. Nothing here computes; Vk.Model does.
--
--  Everything is a small discrete range or an array over one, because
--  that is the shape SPARK proves over most readily. The bounds are
--  constants. An ontology is a VALUE of type Ontology, not a generic
--  parameter: a lemma that takes an Ontology and a precondition on it
--  is then a statement about every ontology of this type satisfying
--  the precondition, which a generic unit would not give (gnatprove
--  proves instances, not generics).
--
--  Where this departs from the letter of draft 3 it says so with
--  "DEPARTS:". The account lists them all.
package Vk with SPARK_Mode => On, Pure is

   type Id       is range 1 .. 5;
   type Ver      is range 1 .. 3;
   type Dim      is range 1 .. 2;
   type Crit     is range 1 .. 2;
   type Warrant  is range 0 .. 3;   --  0 is "never asked"; meet is 'Min
   type Ref_Kind is range 1 .. 3;
   type Ref_Ix   is range 1 .. 2;
   type Slot_Ix  is range 1 .. 3;
   type Kind     is range 1 .. 3;
   type Ev_Ix    is range 1 .. 12;
   type Dec_Ix   is range 1 .. 12;
   type Read_Ix  is range 1 .. 2;
   type Cond_Ix  is range 1 .. 3;

   type Ver_Set is array (Ver) of Boolean;
   type Id_Set  is array (Id) of Boolean;
   type Dim_Flags is array (Dim) of Boolean;

   No_Vers  : constant Ver_Set := [others => False];
   All_Vers : constant Ver_Set := [others => True];

   --  How much of a target something relies on (spec section 2).
   type Relies is (Existence, Assertions, Everything);

   -------------------------------------------------------------------
   --  The ontology (spec section 2), with the switches
   -------------------------------------------------------------------

   type Ref_Kind_Decl is record
      Rests     : Boolean   := False;
      Relies_On : Relies    := Existence;
      Caps      : Dim_Flags := [others => False];
   end record;
   type Ref_Kind_Decls is array (Ref_Kind) of Ref_Kind_Decl;

   --  read_as: from "is there applying evidence that holds, by
   --  criterion 1 / by criterion 2" to a warrant. Two criteria stand
   --  for the dimension's means. DEPARTS: the spec's read_as also
   --  returns a conflict flag; here conflict is C6's business.
   type Read_Table is array (Boolean, Boolean) of Warrant;

   type Dim_Decl is record
      Read_As  : Read_Table := [others => [others => 0]];
      Rule_Min : Warrant    := 0;   --  the rule standard asks this much
   end record;
   type Dim_Decls is array (Dim) of Dim_Decl;

   type Slot_Flags is array (Slot_Ix) of Boolean;
   type Dep_Table  is array (Slot_Ix, Slot_Ix) of Boolean;

   --  DEPARTS: one filler per slot (the spec allows many).
   type Kind_Decl is record
      Is_Assembly : Boolean    := False;
      Opens       : Dim_Flags  := [others => False];
      Used        : Slot_Flags := [others => False];
      Required    : Slot_Flags := [others => False];
      Deps        : Dep_Table  := [others => [others => False]];
   end record;
   type Kind_Decls is array (Kind) of Kind_Decl;

   type Canon_Standard is (By_Decision, By_Rule, By_Placement);

   type Ontology is record
      RK    : Ref_Kind_Decls;
      Dims  : Dim_Decls;
      Kinds : Kind_Decls;
      Point_Kind : Ref_Kind := 1;   --  what a pointing slot is, as a reference
      Canon : Canon_Standard := By_Decision;
      --  Switches. The first is the spec's own (Q10). The rest are
      --  places where the draft can be read two ways.
      Guards_On            : Boolean := True;
      Reads_On             : Boolean := True;   --  evidence has a read set
      Set_Aside_On         : Boolean := True;   --  a decision may set evidence aside
      Waived_Is_Consistent : Boolean := False;  --  a covered violation does not spread
      Slot_Needs_Consistent : Boolean := True;  --  C8: filler asserted AND consistent
      Redirect             : Boolean := True;   --  C3: a sole descendant resolves
   end record;

   -------------------------------------------------------------------
   --  Versions (spec section 3)
   -------------------------------------------------------------------

   type Ref is record
      Present  : Boolean  := False;
      K        : Ref_Kind := 1;
      Target   : Id       := 1;
      Need_Dim : Dim      := 1;
      Need     : Warrant  := 0;   --  0: needs nothing
   end record;
   type Ref_List is array (Ref_Ix) of Ref;

   type Slot_State is (Empty, Holding, Pointing);
   type Slot is record
      State  : Slot_State := Empty;
      Filler : Id         := 1;
   end record;
   type Slot_List is array (Slot_Ix) of Slot;

   --  What a version asserts on each dimension: an opaque small value,
   --  compared only for equality (it is what "relies on assertions"
   --  reads).
   type Assertion is range 0 .. 2;
   type Says_Table is array (Dim) of Assertion;

   --  DEPARTS: at most one standing claim and one reported decision
   --  per version.
   type Claim is record
      Present : Boolean := False;
      About   : Id      := 1;
      D       : Dim     := 1;
      Level   : Warrant := 0;
   end record;

   type Report is record
      Present : Boolean := False;
      Dec     : Dec_Ix  := 1;
   end record;

   type Version is record
      Exists  : Boolean    := False;
      K       : Kind       := 1;
      Says    : Says_Table := [others => 0];
      Refs    : Ref_List   := [others => <>];
      Slots   : Slot_List  := [others => <>];
      Claims  : Claim;
      Reports : Report;
   end record;

   type Version_Table is array (Id, Ver) of Version;

   -------------------------------------------------------------------
   --  Facts (spec section 3). They only accumulate.
   -------------------------------------------------------------------

   type Outcome is (Holds, Part, Fails);

   --  A read: what else the evidence relied on, and how far. NOT in
   --  draft 3 (its evidence is about one version and reads nothing).
   --  With Ontology.Reads_On false, or no read present, this is the
   --  literal draft.
   type Read is record
      Present : Boolean := False;
      Q       : Id      := 1;
      W       : Ver     := 1;
      Same    : Ver_Set := No_Vers;   --  versions of Q "same" for this read
      Level   : Relies  := Everything;
   end record;
   type Read_List is array (Read_Ix) of Read;

   --  DEPARTS: "same(x@v, x@w, for f)" is held closed, per fact, as the
   --  set of versions same as the one the fact is about. The spec's
   --  chain of same facts is that set's reflexive, symmetric,
   --  transitive closure, which is monotone in the facts.
   type Evidence is record
      Present : Boolean := False;
      P       : Id      := 1;
      V       : Ver     := 1;
      Same    : Ver_Set := No_Vers;
      D       : Dim     := 1;
      C       : Crit    := 1;
      Result  : Outcome := Holds;
      Reads   : Read_List := [others => <>];
   end record;
   type Ev_List is array (Ev_Ix) of Evidence;

   --  The constraint instances (spec section 5), named so that a waiver
   --  can be about one. P is the asserted piece the instance is about;
   --  I and J index a reference/slot, an evidence fact, a decision, or
   --  a (dimension, criterion) pair, and are 0 where unused.
   type Inst_Kind is
     (C1_Held,        --  P is held by more than one selected assembly
      C1_Shape,       --  slot I of P does not conform, or holds nothing selected
      C2_Together,    --  inner dependency slot I -> slot J not looked at
      C3_Resolve,     --  edge I of P has no selected target
      C3_Cycle,       --  P is on a cycle along a capping kind
      C4_Reconciled,  --  edge I of P not affirmed against its target
      C5_Standard,    --  the standard for canon is not met for P
      C5_Rests,       --  edge I: what P rests on is not asserted and consistent
      C6_Fails,       --  evidence I applies to P and does not hold
      C6_Guard,       --  guard (dim I, crit J) on P not met
      C7_Claim,       --  P's standing claim exceeds the effective warrant
      C7_Report,      --  P reports a decision that does not hold
      C8_Need,        --  edge I: needed warrant above the target's effective
      C8_Slot,        --  slot I: promised or required, not filled as asked
      C9_Raised);     --  raise decision I about P has no evidence
   type Sub is range 0 .. 12;
   type Instance is record
      K : Inst_Kind := C1_Held;
      P : Id        := 1;
      I : Sub       := 0;
      J : Sub       := 0;
   end record;

   type Cond_Kind is
     (None, Selected_At, Warrant_At_Least, Asserted_Consistent, Slot_Filled);
   type Condition is record
      What   : Cond_Kind := None;
      P      : Id        := 1;
      Vs     : Ver_Set   := No_Vers;  --  Selected_At: the version, and those same
      D      : Dim       := 1;
      W      : Warrant   := 0;
      S      : Slot_Ix   := 1;
      Filler : Id        := 1;
   end record;
   type Cond_List is array (Cond_Ix) of Condition;

   --  Set_Aside is NOT in draft 3: a decision that one evidence fact is
   --  not to count (the exit for a wrong finding that leaves the piece
   --  alone). Switched by Ontology.Set_Aside_On.
   type Dec_Kind is (Admit, Affirm, Promise, Waive, Ask, Set_Aside);

   --  "withdrawn(decision)" is the flag: it only ever goes to True.
   type Decision is record
      Present   : Boolean  := False;
      Withdrawn : Boolean  := False;
      What      : Dec_Kind := Admit;
      P         : Id       := 1;         --  the piece it is about
      PVs       : Ver_Set  := No_Vers;   --  accept, affirm: at these versions
      Q         : Id       := 1;         --  affirm: against this piece
      QV        : Ver      := 1;         --  affirm: as it was at this version
      QSame     : Ver_Set  := No_Vers;   --  affirm: or these, same for it
      S         : Slot_Ix  := 1;         --  promise: this slot of P
      D         : Dim      := 1;         --  raise: on this dimension
      Inst      : Instance;              --  waive: this instance
      Ev        : Ev_Ix    := 1;         --  set aside: this evidence fact
      Conds     : Cond_List := [others => <>];
   end record;
   type Dec_List is array (Dec_Ix) of Decision;

   --  Desc (A, B): B descends from A by a recorded recut. Held
   --  transitively closed (see Vk.Model.WF_Facts).
   type Desc_Table is array (Id, Id) of Boolean;

   type Facts is record
      Ev   : Ev_List    := [others => <>];
      Dec  : Dec_List   := [others => <>];
      Desc : Desc_Table := [others => [others => False]];
   end record;

   -------------------------------------------------------------------
   --  A selection (spec section 3): the state
   -------------------------------------------------------------------

   type Pick is record
      Selected : Boolean := False;
      V        : Ver     := 1;
      Asserted : Boolean := False;
   end record;
   type Selection is array (Id) of Pick;

end Vk;
