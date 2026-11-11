(* Reaching: everything some starting names lead to along a relation given as
   a function from a name to the names it leads to.

   Stated twice. [Reached] is what it IS: the starting names, and whatever
   something reached leads to, and nothing else. [reach] is a function that
   computes a list. The theorem at the end says they are the same, for any
   [out] whatever, rings included, given only a finite list that every name
   led to is in.

   M0 uses this twice: for canon (what the roots reach through slots) and for
   what a piece rests on (what it reaches through "predicated on"). *)

From Stdlib Require Import List String Bool Arith Lia.
Import ListNotations.

Section Reach.

Variable out : string -> list string.
Variable start : list string.
Variable universe : list string.
Hypothesis out_in_universe : forall r q, In q (out r) -> In q universe.
Hypothesis start_in_universe : incl start universe.

Inductive Reached : string -> Prop :=
| reached_start : forall r, In r start -> Reached r
| reached_step : forall r q, Reached r -> In q (out r) -> Reached q.

Definition step (S : list string) : list string :=
  nodup string_dec (S ++ flat_map out S).

Fixpoint iter {A} (n : nat) (f : A -> A) (x : A) : A :=
  match n with 0 => x | S n => iter n f (f x) end.

Definition reach : list string := iter (S (List.length universe)) step start.

Lemma step_sound : forall S,
  (forall x, In x S -> Reached x) -> forall x, In x (step S) -> Reached x.
Proof.
  intros S H x Hx. unfold step in Hx. apply nodup_In in Hx.
  apply in_app_or in Hx. destruct Hx as [Hx | Hx].
  - apply H. assumption.
  - apply in_flat_map in Hx. destruct Hx as [r [Hr Hq]].
    apply reached_step with r. apply H. assumption. assumption.
Qed.

Lemma iter_sound : forall n S,
  (forall x, In x S -> Reached x) -> forall x, In x (iter n step S) -> Reached x.
Proof.
  intros n. induction n; simpl; intros S H x Hx.
  - apply H. assumption.
  - apply IHn with (step S). apply step_sound. assumption. assumption.
Qed.

Definition closed_under (S : list string) : Prop :=
  forall r q, In r S -> In q (out r) -> In q S.

Lemma step_keeps : forall S x, In x S -> In x (step S).
Proof.
  intros S x H. unfold step. apply nodup_In. apply in_or_app. left. assumption.
Qed.

Lemma step_adds : forall S r q, In r S -> In q (out r) -> In q (step S).
Proof.
  intros S r q Hr Hq. unfold step. apply nodup_In. apply in_or_app. right.
  apply in_flat_map. exists r. split; assumption.
Qed.

Lemma iter_keeps : forall n S x, In x S -> In x (iter n step S).
Proof.
  intros n. induction n; simpl; intros S x H.
  - assumption.
  - apply IHn. apply step_keeps. assumption.
Qed.

Lemma step_of_closed : forall S, closed_under S -> forall x, In x (step S) -> In x S.
Proof.
  intros S Hc x Hx. unfold step in Hx. apply nodup_In in Hx.
  apply in_app_or in Hx. destruct Hx as [Hx | Hx].
  - assumption.
  - apply in_flat_map in Hx. destruct Hx as [r [Hr Hq]]. apply Hc with r; assumption.
Qed.

Lemma closed_stays_closed : forall n S, closed_under S -> closed_under (iter n step S).
Proof.
  intros n. induction n; simpl; intros S Hc.
  - assumption.
  - apply IHn. intros r q Hr Hq. apply step_keeps.
    apply Hc with r. apply (step_of_closed S Hc). assumption. assumption.
Qed.

Lemma step_in_universe : forall S, incl S universe -> incl (step S) universe.
Proof.
  intros S H x Hx. unfold step in Hx. apply nodup_In in Hx.
  apply in_app_or in Hx. destruct Hx as [Hx | Hx].
  - apply H. assumption.
  - apply in_flat_map in Hx. destruct Hx as [r [Hr Hq]].
    apply out_in_universe with r. assumption.
Qed.

(* Each round either adds a name or changes nothing, and there are only so
   many names. *)
Lemma enough_rounds : forall n S,
  NoDup S -> incl S universe ->
  List.length (nodup string_dec universe) <= List.length S + n ->
  closed_under (iter n step S).
Proof.
  intros n. induction n; intros S Hnd Hin Hlen.
  - simpl. intros r q Hr Hq.
    assert (incl (nodup string_dec universe) S) as Hall.
    { apply NoDup_length_incl.
      - assumption.
      - rewrite Nat.add_0_r in Hlen. exact Hlen.
      - intros x Hx. apply nodup_In. apply Hin. assumption. }
    apply Hall. apply nodup_In. apply out_in_universe with r. assumption.
  - simpl.
    destruct (Nat.le_gt_cases (List.length (step S)) (List.length S)) as [Hle | Hgt].
    + assert (incl (step S) S) as Hback.
      { apply NoDup_length_incl. assumption. assumption.
        intros x Hx. apply step_keeps. assumption. }
      apply closed_stays_closed. intros r q Hr Hq. apply step_keeps.
      apply Hback. apply step_adds with r. apply Hback. assumption. assumption.
    + apply IHn.
      * unfold step. apply NoDup_nodup.
      * apply step_in_universe. assumption.
      * lia.
Qed.

Theorem reach_closed : closed_under reach.
Proof.
  unfold reach. simpl. apply enough_rounds.
  - unfold step. apply NoDup_nodup.
  - apply step_in_universe. assumption.
  - assert (List.length (nodup string_dec universe) <= List.length universe).
    { apply NoDup_incl_length. apply NoDup_nodup.
      intros x Hx. apply nodup_In in Hx. assumption. }
    lia.
Qed.

Theorem reach_is_reached : forall r, Reached r <-> In r reach.
Proof.
  intros r. split.
  - intros H. induction H.
    + unfold reach. apply iter_keeps. assumption.
    + apply reach_closed with r; assumption.
  - unfold reach. apply iter_sound. intros x Hx. apply reached_start. assumption.
Qed.

End Reach.
