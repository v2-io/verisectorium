--  Evidence, kept deliberately: what "=" on a State does and does not
--  give the prover. Each procedure has a null body, so its postcondition
--  is exactly the claim "the precondition implies this".
--
--  Measured with gnatprove 16.1.0 at levels 2 and 4 (same outcome):
--    Congruence_Fields   proved     A = B gives component equality
--    Congruence_Pos      proved     ... and equal Positions (via the
--                                   characterization Is_Position, which
--                                   pins the maximum uniquely)
--    Congruence_Hash     unproved   but NOT F (A) = F (B) for an opaque F
--    Congruence          unproved   not even Valid (B) from Valid (A)
--    Congruence_Try/Step unproved   nor equal results of Try / Step
--
--  So "=" on a record with array components is structural for the
--  provers and is not carried through uninterpreted functions. This is
--  why Kernel.Logs states its equalities with Same (Logical_Equal). The
--  four failures are justified in the body so that `alr gnatprove`
--  passes; delete the justifications to watch them fail again.
with Kernel.States; use Kernel.States;
with Kernel.Logs;   use Kernel.Logs;

package Kernel.Equality_Probe with SPARK_Mode => On is

   procedure Congruence_Fields (A, B : State)
   with Ghost, Pre => A = B,
        Post => A.Veritoids = B.Veritoids and then A.Acts = B.Acts;

   procedure Congruence_Pos (A, B : State; V : Veritoid_Id)
   with Ghost, Pre => A = B, Post => Position (A, V) = Position (B, V);

   function Hash (S : State) return Natural;

   procedure Congruence_Hash (A, B : State)
   with Ghost, Pre => A = B, Post => Hash (A) = Hash (B);

   procedure Congruence (A, B : State)
   with Ghost, Pre => A = B and then Valid (A), Post => Valid (B);

   procedure Congruence_Try (A, B : State; R : Log_Record)
   with Ghost, Pre => A = B and then Valid (A) and then Valid (B),
        Post => Try (A, R) = Try (B, R);

   procedure Congruence_Step (A, B : State; R : Log_Record)
   with Ghost, Pre => A = B and then Valid (A) and then Valid (B),
        Post => Step (A, R) = Step (B, R);

   --  And the same four claims with Same, which do prove.
   procedure Same_Hash (A, B : State)
   with Ghost, Pre => Same (A, B), Post => Hash (A) = Hash (B);

   procedure Same_Valid (A, B : State)
   with Ghost, Pre => Same (A, B) and then Valid (A), Post => Valid (B);

   procedure Same_Step (A, B : State; R : Log_Record)
   with Ghost, Pre => Same (A, B) and then Valid (A) and then Valid (B),
        Post => Same (Step (A, R), Step (B, R));

end Kernel.Equality_Probe;
