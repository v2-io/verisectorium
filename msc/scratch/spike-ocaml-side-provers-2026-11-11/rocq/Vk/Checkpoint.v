(* A checkpoint as a thing that cannot be had without its proof; and one
   statement about every checkpoint there could be. *)

From Stdlib Require Import List String Bool Arith.
From Vk Require Import Reach M0 Story.
Import ListNotations.
Open Scope string_scope.
Open Scope list_scope.

(* A line together with a proof that nothing is owed on it. There is no field
   in which "stationary" could be written by hand. *)
Definition checkpoint (O : ontology) : Type := { l : line | frontier O l = [] }.

Definition close (O : ontology) (l : line) : option (checkpoint O) :=
  match frontier O l as f return (frontier O l = f -> option (checkpoint O)) with
  | [] => fun H => Some (exist _ l H)
  | _ :: _ => fun _ => None
  end eq_refl.

Example S0_is_a_checkpoint : checkpoint looks := exist _ S0 eq_refl.
Example S1_is_a_checkpoint : checkpoint looks := exist _ r1400 eq_refl.

(* Refused: there is no such proof. *)
Fail Example a_checkpoint_at_1300 : checkpoint looks := exist _ r1300 eq_refl.

Example close_refuses_at_1300 : close looks r1300 = None.
Proof. reflexivity. Qed.

Example close_refuses_at_1400_strict : close strict r1400 = None.
Proof. reflexivity. Qed.

(* S0 is a checkpoint. S0 with the finding recorded is another line, and is
   not one. Both are true; they are about two lines. *)
Example S0_after_the_finding : close looks (S0 ++ [E5]) = None.
Proof. reflexivity. Qed.

(* ---------- one statement about every checkpoint ---------- *)

Lemma flat_map_nil : forall {A B} (f : A -> list B) l x,
  flat_map f l = [] -> In x l -> f x = [].
Proof.
  intros A B f l. induction l; simpl; intros x H Hx.
  - contradiction.
  - apply app_eq_nil in H. destruct H as [H1 H2].
    destruct Hx as [Hx | Hx]. subst. assumption. apply IHl; assumption.
Qed.

Lemma owed_nil_own_nil : forall O l am p, owed O l am p = [] -> own O l am p = [].
Proof.
  intros O l am p H. unfold owed in H.
  destruct (c5_rests O l am p || existsb (Nat.eqb 5) (own O l am p) || waived l 5 p).
  - assumption.
  - exfalso. destruct (filter (fun n => Nat.ltb n 5) (own O l am p)); discriminate H.
Qed.

(* At any checkpoint, for any ontology and any line whatever: nothing in
   canon is known wrong, unless that has been waived. No finding applies to
   it, and every defect found in a version the line once had has since been
   looked for and not found. *)
Theorem at_a_checkpoint_nothing_is_known_wrong :
  forall (O : ontology) (cp : checkpoint O) (p : piece),
    let l := proj1_sig cp in
    In p (canon O l) -> waived l 4 p = false -> c4 l p = true.
Proof.
  intros O [l Hl] p. simpl. intros Hp Hw.
  unfold frontier in Hl.
  assert (map (fun n => (n, p)) (owed O l (canon O l) p) = []) as Hm.
  { apply (flat_map_nil (fun p => map (fun n => (n, p)) (owed O l (canon O l) p)) (canon O l) p Hl Hp). }
  apply map_eq_nil in Hm. apply owed_nil_own_nil in Hm.
  unfold own in Hm.
  destruct (c4 l p) eqn:E4. reflexivity. exfalso.
  assert (In 4 (filter (fun n => negb (waived l n p))
     ((if c1 O l p then [] else [1]) ++ (if c2 O l p then [] else [2])
      ++ [4] ++ (if c5_asked O l p then [] else [5])
      ++ (if c6 O l p then [] else [6]) ++ (if c8 O l (canon O l) p then [] else [8])
      ++ (if c9 l p then [] else [9])))) as Hin.
  { apply filter_In. split.
    - apply in_or_app. right. apply in_or_app. right. simpl. left. reflexivity.
    - rewrite Hw. reflexivity. }
  rewrite Hm in Hin. contradiction.
Qed.

Print Assumptions at_a_checkpoint_nothing_is_known_wrong.
Print Assumptions canon_is_reached.
