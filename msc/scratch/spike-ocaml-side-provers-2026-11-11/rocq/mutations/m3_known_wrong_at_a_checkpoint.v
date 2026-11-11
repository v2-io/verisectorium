From Stdlib Require Import List String Bool. From Vk Require Import Reach M0 Story Checkpoint.
Import ListNotations. Open Scope string_scope. Open Scope list_scope.
(* A waived finding IS compatible with a checkpoint: this must SUCCEED, and
   shows the theorem's "unless waived" is not decoration. *)
Definition waived_line := S0 ++ [E5; Waive 4 "c"; Waive 5 "u"].
Example waived_checkpoint : checkpoint looks := exist _ waived_line eq_refl.
Example still_known_wrong : c4 waived_line "c" = false.
Proof. reflexivity. Qed.
(* must fail: the theorem's conclusion for that checkpoint, without the hypothesis *)
Example wrong : c4 waived_line "c" = true.
Proof. reflexivity. Qed.
