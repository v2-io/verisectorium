From Stdlib Require Import List String. From Vk Require Import Reach M0 Story Checkpoint.
(* must fail: there is no proof that nothing is owed at 13:00 *)
Example wrong : checkpoint looks := exist _ r1300 eq_refl.
