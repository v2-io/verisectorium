--  KERNEL-SPEC.md section 6, as a log.  Shared by the tests and the CLI.
--
--  Inputs the spec leaves open, and how they are set here:
--  * Who wrote segment U at first: C (the spec names C only for the later
--    change to U).
--  * d@2's reference to c: seen at c@1.  A changed d's content in the
--    perturbing changeset but had not yet reconciled it against c@2; this
--    is what makes stale-reference(d, c) appear, as the spec expects.  d@3
--    ("A fixes step 3") is reconciled against c@2.
--  * "e@1 affirmed": e stays at content version 1, and A's affirmation
--    reconciles its reference to c@2.  This is the only reading under which
--    S1 can be steady, since nothing later touches e (see account.md).

with Kernel.Model; use Kernel.Model;
with Kernel.Store; use Kernel.Store;
with Kernel.Text;  use Kernel.Text;

package Worked_Example is

   type Mark is
     (S0,              --  steady start
      Perturbed,       --  after A's changeset on T
      Rederived_1,     --  after B re-derives c@2, d@2
      Fixed,           --  after A's d@3
      Rederived_2,     --  after B re-derives c@2, d@3
      U_Changed,       --  after C's u@2
      S1);             --  after B re-derives u@2: steady

   type Marks is array (Mark) of Natural;   --  log index of each mark

   procedure Build
     (N : out Names; St : out Store; At_Mark : out Marks;
      Affirm_E : Boolean := True);
   --  Affirm_E => False builds the literal reading in which e@1 keeps its
   --  reference to c@1, to show that S1 is then unreachable.

end Worked_Example;
