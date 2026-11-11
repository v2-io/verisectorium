From Stdlib Require Import List String. From Vk Require Import Reach M0 Story.
Import ListNotations. Open Scope string_scope.
(* must fail: the 08:30 frontier with "u rests on c" left out *)
Example wrong : frontier looks r0830 = [(4, "c")].
Proof. reflexivity. Qed.
