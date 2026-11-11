--  Helpers for building small worlds and reading their frontiers.
with Vk;       use Vk;
with Vk.Model; use Vk.Model;

package Lab is

   type World is record
      O : Ontology;
      T : Version_Table;
      S : Selection;
      F : Facts;
   end record;

   --  Builders
   function Only (V : Ver) return Ver_Set;
   function Vers (V1, V2 : Ver) return Ver_Set;
   function R (K : Ref_Kind; Target : Id; Need : Warrant := 0;
               Need_Dim : Dim := 1) return Ref;
   function Hold (P : Id) return Slot;
   function Point (P : Id) return Slot;
   function Rd (Q : Id; W : Ver; Level : Relies := Everything;
                Same : Ver_Set := No_Vers) return Read;
   No_Read : constant Read := (Present => False, others => <>);
   function Evid (P : Id; V : Ver; D : Dim; C : Crit;
                  Result : Outcome := Holds; Same : Ver_Set := No_Vers;
                  R1, R2 : Read := No_Read) return Evidence;
   function Pk (V : Ver; Asserted : Boolean := True) return Pick;
   No_Pick : constant Pick := (Selected => False, V => 1, Asserted => False);

   No_Cond : constant Condition := (What => None, others => <>);
   function At_V (P : Id; Vs : Ver_Set) return Condition;
   function Sound (P : Id) return Condition;   --  asserted and consistent
   function W_At_Least (P : Id; D : Dim; W : Warrant) return Condition;

   function Admit_D (P : Id; PVs : Ver_Set;
                     C1, C2, C3 : Condition := No_Cond) return Decision;
   function Affirm_D (P : Id; PVs : Ver_Set; Q : Id; QV : Ver;
                      QSame : Ver_Set := No_Vers) return Decision;
   function Promise_D (P : Id; S : Slot_Ix;
                       C1 : Condition := No_Cond) return Decision;
   function Waive_D (N : Instance; C1 : Condition := No_Cond) return Decision;
   function Ask_D (P : Id; D : Dim; C1 : Condition := No_Cond)
      return Decision;
   function Aside_D (E : Ev_Ix; C1 : Condition := No_Cond) return Decision;

   --  A small theory-like ontology used by the scenarios.
   --  Reference kinds: 1 predicated-on (rests, relies on everything,
   --  caps dim 1); 2 narrates (no rest, relies on assertions); 3
   --  pointing (no rest, existence only).
   --  Dimensions: 1 validity (two criteria; one gives 1, both give 2;
   --  rule asks 1); 2 coherence (criterion 1 gives 1; rule asks 1).
   --  Kinds: 1 claim (opens validity); 2 document (assembly, opens
   --  coherence, slot 1 required, slot 2 depends on slot 1); 3 outline
   --  (assembly, opens coherence, nothing required).
   function Theory (Canon : Canon_Standard := By_Decision) return Ontology;

   --  Readers
   function Image (N : Instance) return String;
   function Ctx (W : World) return Context;
   function Cons (W : World) return Id_Set;
   function Owed (W : World) return Natural;            --  violated
   function Uncovered (W : World) return Natural;        --  and not waived
   function Stationary (W : World) return Boolean;
   function Stationary_On (W : World; Ps : Id_Set) return Boolean;
   function Has (W : World; K : Inst_Kind; P : Id) return Boolean;
   function Fixed (W : World) return Boolean;
   procedure Show (Title : String; W : World);

   --  Bookkeeping for expectations
   Failures : Natural := 0;
   Checks   : Natural := 0;
   procedure Expect (Cond : Boolean; What : String);

end Lab;
