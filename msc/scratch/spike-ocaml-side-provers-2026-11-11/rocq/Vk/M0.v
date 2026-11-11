(* M0, the small model of ../../spike-formal-perspectives-2026-11-10/
   01-common-reading.md, as functions from a line of events to what is owed.

   A line here is the list of every event the state can see, in time order:
   the line's own writes and decisions, and all of the base. *)

From Stdlib Require Import List String Bool Arith Lia.
From Vk Require Import Reach.
Import ListNotations.
Open Scope string_scope.
Open Scope list_scope.

Definition piece := string.
Definition version := string.
Definition eqs := String.eqb.

(* What a version of a piece is. Fixed for good. *)
Inductive shape :=
| Veritoid (is_claim : bool) (predicated_on : list piece)
| Assembly (is_result : bool) (slots : list (string * piece * bool)).
    (* slot name, the piece that fills it, provisional *)

Record ontology := {
  shape_of : piece -> version -> option shape;
  inner : list (string * string);  (* in a result, slot a depends on slot b *)
  write_looks : bool
    (* a reading the story leaves open: does writing a's filler, with b's
       filler as it now is already there, count as having looked at the two
       together? *)
}.

Record evidence := {
  e_name : string;
  e_piece : piece;
  e_version : version;
  e_criterion : string;
  e_holds : bool;
  e_reads : list (piece * version)
}.

Inductive event :=
| Write (p : piece) (v : version)
| Evidence (x : evidence)
| Same (e : string) (p : piece) (v w : version)
| Affirm (p : piece) (v : version) (q : piece) (w : version)
| Raise (p : piece) (criterion : string)
| Promise (a : piece) (slot : string)
| Waive (condition : nat) (p : piece)
| SetAside (e : string)
| MarkRoot (a : piece).

Definition line := list event.

(* ---------- the state read from a line ---------- *)

Definition sel (l : line) (p : piece) : option version :=
  fold_left
    (fun cur e => match e with Write q v => if eqs q p then Some v else cur | _ => cur end)
    l None.

Definition written (l : line) : list piece :=
  nodup string_dec (flat_map (fun e => match e with Write q _ => [q] | _ => [] end) l).

Definition is_written (l : line) (p : piece) : bool := existsb (eqs p) (written l).

Definition shape_now (O : ontology) (l : line) (p : piece) : option shape :=
  match sel l p with Some v => shape_of O p v | None => None end.

Definition slots_of O l p :=
  match shape_now O l p with Some (Assembly _ s) => s | _ => [] end.

Definition fillers_of O l p := map (fun s => snd (fst s)) (slots_of O l p).

Definition preds_of O l p :=
  match shape_now O l p with Some (Veritoid _ ps) => ps | _ => [] end.

Definition roots (l : line) : list piece :=
  flat_map (fun e => match e with MarkRoot a => [a] | _ => [] end) l.

Definition evidence_of (l : line) : list evidence :=
  flat_map (fun e => match e with Evidence x => [x] | _ => [] end) l.

Definition numbered (l : line) : list (nat * event) := combine (seq 0 (List.length l)) l.

(* ---------- canon: what the roots reach through firm slots ---------- *)

Definition out_slots (O : ontology) (l : line) (p : piece) : list piece :=
  if is_written l p
  then flat_map (fun s : string * piece * bool => if snd s then [] else [snd (fst s)]) (slots_of O l p)
  else [].

Definition slot_universe O l := roots l ++ flat_map (out_slots O l) (written l).

Definition canon (O : ontology) (l : line) : list piece :=
  reach (out_slots O l) (roots l) (slot_universe O l).

Lemma is_written_In : forall l p, is_written l p = true -> In p (written l).
Proof.
  intros l p H. unfold is_written in H. apply existsb_exists in H.
  destruct H as [x [Hx He]]. apply String.eqb_eq in He. subst. assumption.
Qed.

(* Canon is what the definition says it is, on every line: the roots, and
   whatever something in canon reaches through a firm slot. *)
Theorem canon_is_reached : forall O l r,
  Reached (out_slots O l) (roots l) r <-> In r (canon O l).
Proof.
  intros O l r. unfold canon. apply reach_is_reached.
  - intros p q H. unfold slot_universe. apply in_or_app. right.
    apply in_flat_map. exists p. split.
    + apply is_written_In. unfold out_slots in H.
      destruct (is_written l p). reflexivity. contradiction.
    + assumption.
  - intros x Hx. unfold slot_universe. apply in_or_app. left. assumption.
Qed.

(* ---------- what a piece rests on: everything it is predicated on, on down ---------- *)

Definition out_preds (O : ontology) (l : line) (p : piece) : list piece :=
  if is_written l p then preds_of O l p else [].

Definition rests_on (O : ontology) (l : line) (p : piece) : list piece :=
  reach (out_preds O l) (preds_of O l p)
        (preds_of O l p ++ flat_map (out_preds O l) (written l)).

Theorem rests_on_is_reached : forall O l p r,
  Reached (out_preds O l) (preds_of O l p) r <-> In r (rests_on O l p).
Proof.
  intros O l p r. unfold rests_on. apply reach_is_reached.
  - intros a q H. apply in_or_app. right. apply in_flat_map. exists a. split.
    + apply is_written_In. unfold out_preds in H.
      destruct (is_written l a). reflexivity. contradiction.
    + assumption.
  - intros x Hx. apply in_or_app. left. assumption.
Qed.

(* ---------- evidence applying ---------- *)

Definition same (l : line) (e : string) (p : piece) (v w : version) : bool :=
  eqs v w
  || existsb
       (fun x => match x with
                 | Same e' p' a b =>
                     eqs e' e && eqs p' p && ((eqs a v && eqs b w) || (eqs a w && eqs b v))
                 | _ => false
                 end)
       l.

Definition at_ (l : line) (e : string) (p : piece) (v : version) : bool :=
  match sel l p with Some w => same l e p v w | None => false end.

Definition set_aside (l : line) (e : string) : bool :=
  existsb (fun x => match x with SetAside e' => eqs e' e | _ => false end) l.

Definition applies (l : line) (x : evidence) : bool :=
  negb (set_aside l (e_name x))
  && at_ l (e_name x) (e_piece x) (e_version x)
  && forallb (fun r => at_ l (e_name x) (fst r) (snd r)) (e_reads x).

(* ---------- the conditions, numbered as note 22 §4.1 ---------- *)

Definition is_some {A} (o : option A) : bool := match o with Some _ => true | None => false end.

(* 1. every reference reaches something that is there *)
Definition c1 O l p : bool :=
  forallb (fun q => is_some (sel l q)) (preds_of O l p ++ fillers_of O l p).

(* What q was at when p was last written. *)
Fixpoint snap (l : line) (p q : piece) (curq shot : option version) : option version :=
  match l with
  | [] => shot
  | Write r v :: l' =>
      let curq' := if eqs r q then Some v else curq in
      snap l' p q curq' (if eqs r p then curq' else shot)
  | _ :: l' => snap l' p q curq shot
  end.

Definition written_against (l : line) (p q : piece) : bool :=
  match snap l p q None None, sel l q with
  | Some a, Some b => eqs a b
  | _, _ => false
  end.

Definition affirmed (l : line) (p q : piece) : bool :=
  match sel l p, sel l q with
  | Some v, Some w =>
      existsb
        (fun x => match x with
                  | Affirm p' v' q' w' => eqs p' p && eqs v' v && eqs q' q && eqs w' w
                  | _ => false
                  end)
        l
  | _, _ => false
  end.

(* 2. every reference was written or re-read against its target as the target now is *)
Definition c2 O l p : bool :=
  forallb (fun q => written_against l p q || affirmed l p q) (preds_of O l p).

(* 4. nothing is known wrong: no finding applies, and every defect found in a
   version the line once had has since been looked for and not found *)
Definition was_selected (l : line) (p : piece) (v : version) : bool :=
  existsb (fun x => match x with Write p' v' => eqs p' p && eqs v' v | _ => false end) l.

Definition c4 (l : line) (p : piece) : bool :=
  forallb
    (fun ie =>
       match snd ie with
       | Evidence f =>
           if eqs (e_piece f) p && negb (e_holds f) && negb (set_aside l (e_name f))
              && was_selected l p (e_version f)
           then
             negb (applies l f)
             && existsb
                  (fun jg =>
                     match snd jg with
                     | Evidence g =>
                         Nat.ltb (fst ie) (fst jg) && eqs (e_piece g) p && e_holds g
                         && eqs (e_criterion g) (e_criterion f) && applies l g
                     | _ => false
                     end)
                  (numbered l)
           else true
       | _ => true
       end)
    (numbered l).

(* 5, first half. what its root asks: a claim has been checked; a result has
   been read whole, as it now is *)
Definition c5_asked O l p : bool :=
  match shape_now O l p with
  | Some (Veritoid true _) =>
      existsb (fun x => eqs (e_piece x) p && eqs (e_criterion x) "valid" && e_holds x && applies l x)
              (evidence_of l)
  | Some (Assembly true _) =>
      existsb
        (fun x =>
           eqs (e_piece x) p && eqs (e_criterion x) "whole" && e_holds x && applies l x
           && forallb (fun q => existsb (fun r => eqs (fst r) q) (e_reads x)) (fillers_of O l p))
        (evidence_of l)
  | _ => true
  end.

(* 6. pieces with an inner dependency between them have been looked at together as they now are *)
Definition filler O l p (slot : string) : option piece :=
  match filter (fun s => eqs (fst (fst s)) slot) (slots_of O l p) with
  | s :: _ => Some (snd (fst s))
  | [] => None
  end.

Definition looked O l (a b : piece) : bool :=
  affirmed l a b
  || existsb (fun x => eqs (e_piece x) a && applies l x
                       && existsb (fun r => eqs (fst r) b) (e_reads x))
             (evidence_of l)
  || (write_looks O && written_against l a b).

Definition c6 O l p : bool :=
  match shape_now O l p with
  | Some (Assembly true _) =>
      forallb
        (fun d => match filler O l p (fst d), filler O l p (snd d) with
                  | Some a, Some b => looked O l a b
                  | _, _ => true
                  end)
        (inner O)
  | _ => true
  end.

(* 8. every promised slot has something in canon in it *)
Definition c8 O l (am : list piece) p : bool :=
  forallb
    (fun x => match x with
              | Promise a slot =>
                  if eqs a p
                  then match filler O l p slot with
                       | Some q => existsb (eqs q) am
                       | None => false
                       end
                  else true
              | _ => true
              end)
    l.

(* 9. every question raised about it has been answered since *)
Definition c9 (l : line) (p : piece) : bool :=
  forallb
    (fun ie =>
       match snd ie with
       | Raise p' criterion =>
           if eqs p' p
           then existsb
                  (fun jg =>
                     match snd jg with
                     | Evidence g =>
                         Nat.ltb (fst ie) (fst jg) && eqs (e_piece g) p
                         && eqs (e_criterion g) criterion && applies l g
                     | _ => false
                     end)
                  (numbered l)
           else true
       | _ => true
       end)
    (numbered l).

Definition waived (l : line) (n : nat) (p : piece) : bool :=
  existsb (fun x => match x with Waive n' p' => Nat.eqb n' n && eqs p' p | _ => false end) l.

(* The conditions that are about p alone, each with whether it is met. *)
Definition checks O l am p : list (nat * bool) :=
  [ (1, c1 O l p); (2, c2 O l p); (4, c4 l p); (5, c5_asked O l p);
    (6, c6 O l p); (8, c8 O l am p); (9, c9 l p) ].

(* What fails on p of its own, not counting what it rests on, and is not waived. *)
Definition own O l am p : list nat :=
  map fst (filter (fun nb => negb (snd nb) && negb (waived l (fst nb) p)) (checks O l am p)).

(* 5, second half. it rests only on pieces in canon with nothing wrong of
   their own *)
Definition c5_rests O l am p : bool :=
  forallb (fun q => existsb (eqs q) am && match own O l am q with [] => true | _ => false end)
          (rests_on O l p).

Definition owed O l am p : list nat :=
  let o := own O l am p in
  if c5_rests O l am p || existsb (Nat.eqb 5) o || waived l 5 p then o
  else filter (fun n => Nat.ltb n 5) o ++ [5] ++ filter (fun n => Nat.ltb 5 n) o.

(* The frontier: every (condition, piece) that fails and is not waived, for
   the pieces in canon. Computed from the line and from nothing else. *)
Definition frontier (O : ontology) (l : line) : list (nat * piece) :=
  let am := canon O l in
  flat_map (fun p => map (fun n => (n, p)) (owed O l am p)) am.

Definition stationary (O : ontology) (l : line) : bool :=
  match frontier O l with [] => true | _ => false end.
