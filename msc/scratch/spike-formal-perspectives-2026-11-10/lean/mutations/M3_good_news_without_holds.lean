-- Mutation 3. "Good news does no harm" with the hypothesis that the evidence holds
-- dropped. The statement is then false, and the story has the counterexample:
-- S0 is stationary and S0 with the 08:30 finding is not.
import Vk.Story
import Vk.GoodNews
open Vk.M0 Vk.Story
-- (that counterexample is `Vk.Story.more_record_can_owe_more`, in the build.)
-- The proof of `own_sub` cannot be reused without the hypothesis: this must be rejected
example (s : State Pc Cr) (g : Evidence Pc Cr) (cn : List Pc) (p : Pc) (i : Item Pc Cr)
    (h : i ∈ own W (learn s g) cn p) : i ∈ own W s cn p := own_sub W s g (by rfl) cn p i h
