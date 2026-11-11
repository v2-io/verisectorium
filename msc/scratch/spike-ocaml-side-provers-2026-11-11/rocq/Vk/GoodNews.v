(* Good news does no harm, for M0, on every line: recording evidence that
   HOLDS, as the latest event, adds nothing to what is owed.

   For any ontology, any line of any length over any pieces, any evidence
   about anything. Not a search. *)

From Stdlib Require Import List String Bool Arith Lia.
From Vk Require Import Reach M0.
Import ListNotations.
Open Scope string_scope.
Open Scope list_scope.

Lemma existsb_mono : forall {A} (f g : A -> bool) l,
  (forall a, f a = true -> g a = true) -> existsb f l = true -> existsb g l = true.
Proof.
  intros A f g l H. induction l; simpl; intros E.
  - discriminate.
  - apply orb_prop in E. apply orb_true_intro. destruct E as [E | E].
    left. apply H. assumption. right. apply IHl. assumption.
Qed.

Lemma forallb_mono : forall {A} (f g : A -> bool) l,
  (forall a, f a = true -> g a = true) -> forallb f l = true -> forallb g l = true.
Proof.
  intros A f g l H. induction l; simpl; intros E.
  - reflexivity.
  - apply andb_prop in E. destruct E as [E1 E2]. apply andb_true_intro. split.
    apply H. assumption. apply IHl. assumption.
Qed.

Lemma forallb_same : forall {A} (f g : A -> bool) l,
  (forall a, f a = g a) -> forallb f l = forallb g l.
Proof.
  intros A f g l H. induction l; simpl. reflexivity. rewrite H, IHl. reflexivity.
Qed.

Lemma combine_snoc : forall {A B} (a : list A) (b : list B) x y,
  List.length a = List.length b -> combine (a ++ [x]) (b ++ [y]) = combine a b ++ [(x, y)].
Proof.
  intros A B a. induction a; destruct b; simpl; intros x y H; try discriminate.
  - reflexivity.
  - f_equal. apply IHa. injection H. auto.
Qed.

Section GoodNews.

Variable O : ontology.
Variable l : line.
Variable x : evidence.
Hypothesis x_holds : e_holds x = true.

Definition l' : line := l ++ [Evidence x].

(* -- what the new evidence leaves exactly as it was -- *)

Lemma sel_same : forall p, sel l' p = sel l p.
Proof. intros p. unfold l', sel. rewrite fold_left_app. reflexivity. Qed.

Lemma written_same : written l' = written l.
Proof. unfold l', written. rewrite flat_map_app. simpl. rewrite app_nil_r. reflexivity. Qed.

Lemma is_written_same : forall p, is_written l' p = is_written l p.
Proof. intros p. unfold is_written. rewrite written_same. reflexivity. Qed.

Lemma shape_now_same : forall p, shape_now O l' p = shape_now O l p.
Proof. intros p. unfold shape_now. rewrite sel_same. reflexivity. Qed.

Lemma slots_of_same : forall p, slots_of O l' p = slots_of O l p.
Proof. intros p. unfold slots_of. rewrite shape_now_same. reflexivity. Qed.

Lemma fillers_of_same : forall p, fillers_of O l' p = fillers_of O l p.
Proof. intros p. unfold fillers_of. rewrite slots_of_same. reflexivity. Qed.

Lemma preds_of_same : forall p, preds_of O l' p = preds_of O l p.
Proof. intros p. unfold preds_of. rewrite shape_now_same. reflexivity. Qed.

Lemma roots_same : roots l' = roots l.
Proof. unfold l', roots. rewrite flat_map_app. simpl. rewrite app_nil_r. reflexivity. Qed.

Lemma out_slots_same : forall p, out_slots O l' p = out_slots O l p.
Proof. intros p. unfold out_slots. rewrite is_written_same, slots_of_same. reflexivity. Qed.

Lemma out_preds_same : forall p, out_preds O l' p = out_preds O l p.
Proof. intros p. unfold out_preds. rewrite is_written_same, preds_of_same. reflexivity. Qed.

Lemma canon_same : canon O l' = canon O l.
Proof.
  unfold canon, slot_universe. rewrite roots_same, written_same.
  rewrite (flat_map_ext _ _ out_slots_same). apply reach_ext. exact out_slots_same.
Qed.

Lemma rests_on_same : forall p, rests_on O l' p = rests_on O l p.
Proof.
  intros p. unfold rests_on. rewrite preds_of_same, written_same.
  rewrite (flat_map_ext _ _ out_preds_same). apply reach_ext. exact out_preds_same.
Qed.

Lemma same_same : forall e p v w, same l' e p v w = same l e p v w.
Proof.
  intros e p v w. unfold l', same. rewrite existsb_app. simpl.
  rewrite orb_false_r. reflexivity.
Qed.

Lemma at_same : forall e p v, at_ l' e p v = at_ l e p v.
Proof.
  intros e p v. unfold at_. rewrite sel_same. destruct (sel l p).
  apply same_same. reflexivity.
Qed.

Lemma set_aside_same : forall e, set_aside l' e = set_aside l e.
Proof.
  intros e. unfold l', set_aside. rewrite existsb_app. simpl.
  rewrite orb_false_r. reflexivity.
Qed.

Lemma applies_same : forall y, applies l' y = applies l y.
Proof.
  intros y. unfold applies. rewrite set_aside_same, at_same.
  rewrite (forallb_same _ (fun r => at_ l (e_name y) (fst r) (snd r))).
  reflexivity. intros r. apply at_same.
Qed.

Lemma was_selected_same : forall p v, was_selected l' p v = was_selected l p v.
Proof.
  intros p v. unfold l', was_selected. rewrite existsb_app. simpl.
  rewrite orb_false_r. reflexivity.
Qed.

Lemma waived_same : forall n p, waived l' n p = waived l n p.
Proof.
  intros n p. unfold l', waived. rewrite existsb_app. simpl.
  rewrite orb_false_r. reflexivity.
Qed.

Lemma evidence_of_more : evidence_of l' = evidence_of l ++ [x].
Proof. unfold l', evidence_of. rewrite flat_map_app. reflexivity. Qed.

Lemma numbered_more : numbered l' = numbered l ++ [(List.length l, Evidence x)].
Proof.
  unfold l', numbered. rewrite length_app. simpl. rewrite Nat.add_1_r.
  rewrite seq_S. simpl. apply combine_snoc. apply length_seq.
Qed.

Lemma snap_same : forall m p q a b, snap (m ++ [Evidence x]) p q a b = snap m p q a b.
Proof.
  intros m. induction m; simpl; intros p q a0 b.
  - reflexivity.
  - destruct a; apply IHm.
Qed.

Lemma written_against_same : forall p q, written_against l' p q = written_against l p q.
Proof.
  intros p q. unfold written_against. unfold l' at 1. rewrite snap_same, sel_same. reflexivity.
Qed.

Lemma affirmed_same : forall p q, affirmed l' p q = affirmed l p q.
Proof.
  intros p q. unfold affirmed. rewrite !sel_same.
  destruct (sel l p); try reflexivity. destruct (sel l q); try reflexivity.
  unfold l'. rewrite existsb_app. simpl. rewrite orb_false_r. reflexivity.
Qed.

Lemma filler_same : forall p slot, filler O l' p slot = filler O l p slot.
Proof. intros p slot. unfold filler. rewrite slots_of_same. reflexivity. Qed.

(* -- each condition: if it was met, it still is -- *)

Lemma c1_kept : forall p, c1 O l p = true -> c1 O l' p = true.
Proof.
  intros p. unfold c1. rewrite preds_of_same, fillers_of_same.
  apply forallb_mono. intros q. rewrite sel_same. auto.
Qed.

Lemma c2_kept : forall p, c2 O l p = true -> c2 O l' p = true.
Proof.
  intros p. unfold c2. rewrite preds_of_same.
  apply forallb_mono. intros q. rewrite written_against_same, affirmed_same. auto.
Qed.

Lemma c4_kept : forall p, c4 l p = true -> c4 l' p = true.
Proof.
  intros p. unfold c4. rewrite numbered_more. intros H.
  rewrite forallb_app. apply andb_true_intro. split.
  - revert H. apply forallb_mono. intros [i e]. simpl. destruct e; auto.
    rewrite set_aside_same, was_selected_same, applies_same.
    destruct (eqs (e_piece x0) p && negb (e_holds x0) && negb (set_aside l (e_name x0))
              && was_selected l p (e_version x0)); auto.
    intros H. apply andb_prop in H. destruct H as [H1 H2].
    apply andb_true_intro. split. assumption.
    rewrite existsb_app. apply orb_true_intro. left.
    revert H2. apply existsb_mono. intros [j g]. simpl. destruct g; auto.
    rewrite applies_same. auto.
  - simpl. rewrite x_holds. simpl. rewrite andb_false_r. reflexivity.
Qed.

Lemma c5_asked_kept : forall p, c5_asked O l p = true -> c5_asked O l' p = true.
Proof.
  intros p. unfold c5_asked. rewrite shape_now_same, evidence_of_more, fillers_of_same.
  destruct (shape_now O l p) as [[[|] ps | [|] ss] |]; auto.
  - intros H. rewrite existsb_app. apply orb_true_intro. left.
    revert H. apply existsb_mono. intros y. rewrite applies_same. auto.
  - intros H. rewrite existsb_app. apply orb_true_intro. left.
    revert H. apply existsb_mono. intros y. rewrite applies_same. auto.
Qed.

Lemma looked_kept : forall a b, looked O l a b = true -> looked O l' a b = true.
Proof.
  intros a b. unfold looked. rewrite affirmed_same, written_against_same, evidence_of_more.
  intros H. apply orb_prop in H. destruct H as [H | H].
  - apply orb_prop in H. destruct H as [H | H].
    + rewrite H. reflexivity.
    + apply orb_true_intro. left. apply orb_true_intro. right.
      rewrite existsb_app. apply orb_true_intro. left.
      revert H. apply existsb_mono. intros y. rewrite applies_same. auto.
  - rewrite H. apply orb_true_r.
Qed.

Lemma c6_kept : forall p, c6 O l p = true -> c6 O l' p = true.
Proof.
  intros p. unfold c6. rewrite shape_now_same.
  destruct (shape_now O l p) as [[c ps | [|] ss] |]; auto.
  apply forallb_mono. intros d. rewrite !filler_same.
  destruct (filler O l p (fst d)); auto. destruct (filler O l p (snd d)); auto.
  apply looked_kept.
Qed.

Lemma c8_kept : forall am p, c8 O l am p = true -> c8 O l' am p = true.
Proof.
  intros am p. unfold c8. intros H. unfold l'.
  rewrite forallb_app. fold l'. apply andb_true_intro. split.
  - revert H. apply forallb_mono. intros e. destruct e; auto.
    rewrite filler_same. auto.
  - reflexivity.
Qed.

Lemma c9_kept : forall p, c9 l p = true -> c9 l' p = true.
Proof.
  intros p. unfold c9. rewrite numbered_more. intros H.
  rewrite forallb_app. apply andb_true_intro. split.
  - revert H. apply forallb_mono. intros [i e]. simpl. destruct e; auto.
    destruct (eqs p0 p); auto. intros H.
    rewrite existsb_app. apply orb_true_intro. left.
    revert H. apply existsb_mono. intros [j g]. simpl. destruct g; auto.
    rewrite applies_same. auto.
  - reflexivity.
Qed.

(* -- so nothing new is owed -- *)

Lemma still_false : forall (b b' : bool), (b = true -> b' = true) -> b' = false -> b = false.
Proof. intros b b' H E. destruct b. rewrite H in E. discriminate. reflexivity. reflexivity. Qed.

Lemma own_no_more : forall am p n, In n (own O l' am p) -> In n (own O l am p).
Proof.
  intros am p n H. unfold own in *. apply in_map_iff in H.
  destruct H as [[k b] [Hk H]]. simpl in Hk. subst k.
  apply filter_In in H. destruct H as [Hin Hf]. simpl in Hf.
  apply andb_prop in Hf. destruct Hf as [Hb Hw].
  apply negb_true_iff in Hb. subst b. rewrite waived_same in Hw.
  apply in_map_iff. exists (n, false). split. reflexivity.
  apply filter_In. split; [| simpl; assumption].
  unfold checks in *. simpl in Hin. simpl.
  destruct Hin as [E | [E | [E | [E | [E | [E | [E | []]]]]]]]; injection E as En Eb; subst n.
  - left. f_equal. apply (still_false _ _ (c1_kept p)). exact Eb.
  - right. left. f_equal. apply (still_false _ _ (c2_kept p)). exact Eb.
  - right. right. left. f_equal. apply (still_false _ _ (c4_kept p)). exact Eb.
  - right. right. right. left. f_equal. apply (still_false _ _ (c5_asked_kept p)). exact Eb.
  - right. right. right. right. left. f_equal. apply (still_false _ _ (c6_kept p)). exact Eb.
  - right. right. right. right. right. left. f_equal. apply (still_false _ _ (c8_kept am p)). exact Eb.
  - right. right. right. right. right. right. left. f_equal. apply (still_false _ _ (c9_kept p)). exact Eb.
Qed.

Lemma own_nil_kept : forall am q, own O l am q = [] -> own O l' am q = [].
Proof.
  intros am q H. destruct (own O l' am q) eqn:E. reflexivity.
  exfalso. assert (In n (own O l am q)). { apply own_no_more. rewrite E. left. reflexivity. }
  rewrite H in H0. contradiction.
Qed.

Lemma c5_rests_kept : forall am p, c5_rests O l am p = true -> c5_rests O l' am p = true.
Proof.
  intros am p. unfold c5_rests. rewrite rests_on_same.
  apply forallb_mono. intros q H. apply andb_prop in H. destruct H as [H1 H2].
  apply andb_true_intro. split. assumption.
  destruct (own O l am q) eqn:E. rewrite (own_nil_kept am q E). reflexivity. discriminate.
Qed.

Lemma own_in_owed : forall m am p n, In n (own O m am p) -> In n (owed O m am p).
Proof.
  intros m am p n H. unfold owed.
  destruct (c5_rests O m am p || existsb (Nat.eqb 5) (own O m am p) || waived m 5 p) eqn:C.
  - assumption.
  - apply orb_false_elim in C. destruct C as [C _].
    apply orb_false_elim in C. destruct C as [_ C].
    assert (n <> 5) as Hn.
    { intros E. subst. assert (existsb (Nat.eqb 5) (own O m am p) = true).
      { apply existsb_exists. exists 5. split. assumption. reflexivity. }
      rewrite H0 in C. discriminate. }
    destruct (Nat.ltb n 5) eqn:L.
    + apply in_or_app. left. apply filter_In. split; assumption.
    + apply in_or_app. right. apply in_or_app. right. apply filter_In. split. assumption.
      apply Nat.ltb_lt. apply Nat.ltb_ge in L. lia.
Qed.

Lemma owed_no_more : forall am p n, In n (owed O l' am p) -> In n (owed O l am p).
Proof.
  intros am p n H.
  assert (In n (own O l' am p) \/ (n = 5 /\ c5_rests O l' am p = false /\ waived l' 5 p = false)) as Hc.
  { unfold owed in H.
    destruct (c5_rests O l' am p || existsb (Nat.eqb 5) (own O l' am p) || waived l' 5 p) eqn:C.
    - left. assumption.
    - apply orb_false_elim in C. destruct C as [C Cw].
      apply orb_false_elim in C. destruct C as [Cr _].
      apply in_app_or in H. destruct H as [H | H].
      + left. apply filter_In in H. destruct H. assumption.
      + apply in_app_or in H. destruct H as [H | H].
        * right. simpl in H. destruct H as [H | []]. subst. auto.
        * left. apply filter_In in H. destruct H. assumption. }
  destruct Hc as [Hc | [Hn [Hr Hw]]].
  - apply own_in_owed. apply own_no_more. assumption.
  - subst n. rewrite waived_same in Hw.
    assert (c5_rests O l am p = false) as Hr0.
    { apply (still_false _ _ (c5_rests_kept am p)). assumption. }
    unfold owed. rewrite Hr0, Hw. rewrite orb_false_r, orb_false_l.
    destruct (existsb (Nat.eqb 5) (own O l am p)) eqn:E.
    + apply existsb_exists in E. destruct E as [k [Hk Ek]].
      apply Nat.eqb_eq in Ek. subst. assumption.
    + apply in_or_app. right. left. reflexivity.
Qed.

Theorem good_news_does_no_harm :
  forall item, In item (frontier O l') -> In item (frontier O l).
Proof.
  intros [n p] H. unfold frontier in *. rewrite canon_same in H.
  apply in_flat_map in H. destruct H as [q [Hq H]].
  apply in_map_iff in H. destruct H as [k [Hk H]]. inversion Hk. subst.
  apply in_flat_map. exists p. split. assumption.
  apply in_map_iff. exists n. split. reflexivity. apply owed_no_more. assumption.
Qed.

End GoodNews.

(* Stated whole. *)
Theorem good_news : forall (O : ontology) (l : line) (x : evidence),
  e_holds x = true ->
  forall item, In item (frontier O (l ++ [Evidence x])) -> In item (frontier O l).
Proof. intros O l x H. apply good_news_does_no_harm. assumption. Qed.

Print Assumptions good_news.
