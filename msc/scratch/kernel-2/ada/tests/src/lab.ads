--  Helpers for building small scenes (an ontology, versions, a base,
--  a clock) and lines over them, and for reading frontiers.
with Vk;       use Vk;
with Vk.Model; use Vk.Model;
with Vk.Lines; use Vk.Lines;

package Lab is

   type Scene is record
      O     : Ontology;
      T     : Version_Table;
      B     : Base;
      Clock : Natural := 0;      --  the last time handed out
      Opt   : Options;
   end record;

   --  Events. Each takes the next time from the scene's clock.
   procedure Write (Sc : in out Scene; Ln : in out Timeline; P : Id; V : Ver);
   procedure Retire (Sc : in out Scene; Ln : in out Timeline; P : Id;
                     Heirs : Id_Set := [others => False]);
   procedure Mark (Sc : in out Scene; Ln : in out Timeline; P : Id);
   procedure Unmark (Sc : in out Scene; Ln : in out Timeline; P : Id);
   --  Record the wording of decision J in the base and put it in force
   --  on the line.
   procedure Decide (Sc : in out Scene; Ln : in out Timeline; J : Dec_Ix;
                     D : Decision);
   procedure Withdraw (Sc : in out Scene; Ln : in out Timeline; J : Dec_Ix);
   --  Evidence goes to the base, not to any line.
   procedure Observe (Sc : in out Scene; I : Ev_Ix; E : Evidence);

   --  Builders (as for draft 3)
   function Only (V : Ver) return Ver_Set;
   function R (K : Ref_Kind; Target : Id; Need : Warrant := 0;
               Need_Dim : Dim := 1) return Ref;
   function Hold (P : Id; Provisional : Boolean := False) return Slot;
   function Point (P : Id; Provisional : Boolean := False) return Slot;
   function Rd (Q : Id; W : Ver; Level : Relies := Everything;
                Same : Ver_Set := No_Vers) return Read;
   No_Read : constant Read := (Present => False, others => <>);
   function Evid (P : Id; V : Ver; D : Dim; C : Crit;
                  Result : Outcome := Holds; Same : Ver_Set := No_Vers;
                  R1, R2 : Read := No_Read) return Evidence;
   function Claim_V (Says : Assertion := 1; R1, R2 : Ref := (others => <>))
      return Version;
   function Asm_V (K : Kind; S1, S2, S3 : Slot := (others => <>))
      return Version;

   No_Cond : constant Condition := (What => None, others => <>);
   function Sound (P : Id) return Condition;
   function Admit_D (P : Id; PVs : Ver_Set; D : Dim) return Decision;
   function Affirm_D (P : Id; PVs : Ver_Set; Q : Id; QV : Ver;
                      C1 : Condition := No_Cond) return Decision;
   function Promise_D (P : Id; S : Slot_Ix) return Decision;
   function Waive_D (N : Instance) return Decision;
   function Ask_D (P : Id; D : Dim) return Decision;
   function Aside_D (E : Ev_Ix) return Decision;

   --  Reference kinds: 1 predicated-on (rests, relies on everything,
   --  caps validity); 2 narrates (no rest, relies on assertions); 3
   --  pointing (no rest, existence only). Dimensions: 1 validity (one
   --  criterion gives 1, both give 2); 2 coherence (criterion 1 gives
   --  1), or, with Decided_2, "accepted". Kinds: 1 claim; 2 document
   --  (slot 1 required, slot 2 depends on slot 1); 3 outline.
   --  A root of either assembly kind asks validity 1 of claims and
   --  1 on dimension 2 of documents (Ask_Outline: of outlines too).
   function Theory (Decided_2 : Boolean := False;
                    Ask_Outline : Boolean := False) return Ontology;

   --  Readers, on a line of a scene as of the scene's clock.
   function St (Sc : Scene; Ln : Timeline) return State;
   function Image (N : Instance) return String;
   function Owed (Sc : Scene; Ln : Timeline) return Natural;
   function Uncovered (Sc : Scene; Ln : Timeline) return Natural;
   function Stationary (Sc : Scene; Ln : Timeline) return Boolean;
   function Has (Sc : Scene; Ln : Timeline; K : Inst_Kind; P : Id) return Boolean;
   function Cons (Sc : Scene; Ln : Timeline) return Id_Set;
   --  Section 7, R10: bad news against selected pieces not in canon,
   --  "as a stated condition": how many such pieces.
   function Conditions (Sc : Scene; Ln : Timeline) return Natural;
   procedure Show (Title : String; Sc : Scene; Ln : Timeline);

   --  The largest region on which the states of two lines agree
   --  (Vk.Frames), and its printed form.
   function Region (Sc : Scene; A, M : Timeline) return Id_Set;
   function Set_Image (R : Id_Set) return String;
   --  Nothing about a piece of R is owed and unwaived on this line.
   function Stationary_On (Sc : Scene; Ln : Timeline; R : Id_Set)
      return Boolean;

   Failures : Natural := 0;
   Checks   : Natural := 0;
   procedure Expect (Cond : Boolean; What : String);

end Lab;
