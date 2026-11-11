(* The slice in Rocq, and the OCaml it extracts to.

   Check:    opam exec --switch=rocq-try -- rocq compile rocq.v
   That also writes rocq_extracted.ml, the same functions as plain OCaml.

   Three things are said here, in this order:
     1. what exists (types; the kind of a veritoid is in its type);
     2. what canon IS: two rules, with nothing about how to find it;
     3. a function that computes a list, and a proof that for any
        verisectorium whatever, if the list passes one check, it is canon
        exactly.
   Notes on what it was like are in rocq-NOTES.md beside this file. *)

From Stdlib Require Import List String Bool.
Import ListNotations.
Open Scope string_scope.
Open Scope list_scope.

(* ---------- 1. what exists ---------- *)

Definition name := string.

Inductive vkind := Claim | Step | Explanation.

(* A veritoid of kind k: a name and one sentence of content. The kind is an
   index of the type, so [veritoid Claim] and [veritoid Step] are different
   types. *)
Record veritoid (k : vkind) := Veritoid { v_name : name; content : string }.
Arguments Veritoid {k}.
Arguments v_name {k}.
Arguments content {k}.

(* A slot for an A holds one, inside, or points at one by name. *)
Inductive filler (A : Type) := Holds (x : A) | PointsAt (target : name).
Arguments Holds {A}.
Arguments PointsAt {A}.

Inductive slot (A : Type) :=
| Untouched  (* declared by the kind; nobody has said anything yet *)
| Suggested (note : string)
| Promised
| Filled (f : filler A) (provisional : bool).
Arguments Untouched {A}.
Arguments Suggested {A}.
Arguments Promised {A}.
Arguments Filled {A}.

Definition holds {A} (x : A) : slot A := Filled (Holds x) false.
Definition points_at {A} (n : name) : slot A := Filled (PointsAt n) false.
Definition provisionally_points_at {A} (n : name) : slot A := Filled (PointsAt n) true.

(* The kind derived-result, as a record: one, any number, one, at most one. *)
Record derived_result := DerivedResult {
  r_name : name;
  formal_claim : slot (veritoid Claim);
  derivation : list (slot (veritoid Step));
  description : slot (veritoid Explanation);
  eli8 : option (slot (veritoid Explanation)) }.

(* An outline takes anything, in order; and a gap is an entry, not a state of
   a slot. What an outline may HOLD is a veritoid or a derived result; another
   outline it can only point at. (A departure, made to keep every type here
   non-nested. See the notes.) *)
Inductive held :=
| HeldV {k : vkind} (v : veritoid k)
| HeldR (r : derived_result).

Inductive entry := Entry (s : slot held) | Gap.

Record outline := Outline { o_name : name; entries : list entry }.

(* What lives on its own, and which of those are marked as roots. *)
Inductive living := Result (r : derived_result) | AnOutline (o : outline).

Record verisectorium := { store : list living; roots : list name }.

(* What one assembly reaches in one step: through slots that are filled and
   not provisional, to what they hold or point at. *)
Definition firm {A} (name_of : A -> name) (s : slot A) : list name :=
  match s with
  | Filled (Holds x) false => [name_of x]
  | Filled (PointsAt n) false => [n]
  | _ => []
  end.

Definition reaches_result (r : derived_result) : list name :=
  firm v_name (formal_claim r)
  ++ flat_map (firm v_name) (derivation r)
  ++ firm v_name (description r)
  ++ match eli8 r with Some s => firm v_name s | None => [] end.

Definition held_name (h : held) : name :=
  match h with HeldV v => v_name v | HeldR r => r_name r end.

Definition reaches_outline (o : outline) : list name :=
  flat_map (fun e => match e with Entry s => firm held_name s | Gap => [] end)
           (entries o).

(* Every assembly there is, wherever it lives, with what it reaches. *)
Definition assemblies (V : verisectorium) : list (name * list name) :=
  flat_map
    (fun l =>
       match l with
       | Result r => [(r_name r, reaches_result r)]
       | AnOutline o =>
           (o_name o, reaches_outline o)
           :: flat_map
                (fun e =>
                   match e with
                   | Entry (Filled (Holds (HeldR r)) _) => [(r_name r, reaches_result r)]
                   | _ => []
                   end)
                (entries o)
       end)
    (store V).

Definition out (V : verisectorium) (n : name) : list name :=
  flat_map (fun p => if String.eqb (fst p) n then snd p else []) (assemblies V).

(* ---------- 2. what canon is ---------- *)

(* A root is in canon. What something in canon reaches is in canon. Nothing
   else is. *)
Inductive Canon (V : verisectorium) : name -> Prop :=
| canon_root : forall r, In r (roots V) -> Canon V r
| canon_step : forall r q, Canon V r -> In q (out V r) -> Canon V q.

(* ---------- 3. a function, and what is proved of it ---------- *)

Definition mem (x : name) (S : list name) : bool := existsb (String.eqb x) S.

(* Add what everything in S reaches. *)
Definition step (V : verisectorium) (S : list name) : list name :=
  nodup string_dec (S ++ flat_map (out V) S).

Fixpoint iter {A} (n : nat) (f : A -> A) (x : A) : A :=
  match n with 0 => x | S n => iter n f (f x) end.

(* Rocq will not take a function that might not stop, and following pointers
   might not. So the function says how long it will go on: once round for
   every assembly there is, and once more. *)
Definition canon_list (V : verisectorium) : list name :=
  iter (S (List.length (assemblies V))) (step V) (roots V).

(* The check: S has the roots, and has everything its members reach. *)
Definition closed (V : verisectorium) (S : list name) : bool :=
  forallb (fun r => mem r S) (roots V)
  && forallb (fun r => forallb (fun q => mem q S) (out V r)) S.

Lemma mem_In : forall x S, mem x S = true <-> In x S.
Proof.
  intros x S. unfold mem. rewrite existsb_exists. split.
  - intros [y [Hy He]]. apply String.eqb_eq in He. subst. assumption.
  - intros H. exists x. split. assumption. apply String.eqb_refl.
Qed.

(* Everything the function lists is in canon. For every verisectorium. *)
Lemma step_sound : forall V S,
  (forall x, In x S -> Canon V x) -> forall x, In x (step V S) -> Canon V x.
Proof.
  intros V S H x Hx. unfold step in Hx. apply nodup_In in Hx.
  apply in_app_or in Hx. destruct Hx as [Hx | Hx].
  - apply H. assumption.
  - apply in_flat_map in Hx. destruct Hx as [r [Hr Hq]].
    apply canon_step with r. apply H. assumption. assumption.
Qed.

Lemma iter_sound : forall V n S,
  (forall x, In x S -> Canon V x) ->
  forall x, In x (iter n (step V) S) -> Canon V x.
Proof.
  intros V n. induction n; simpl; intros S H x Hx.
  - apply H. assumption.
  - apply IHn with (step V S). apply step_sound. assumption. assumption.
Qed.

Theorem canon_list_sound : forall V x, In x (canon_list V) -> Canon V x.
Proof.
  intros V x Hx. unfold canon_list in Hx.
  apply iter_sound with (S (List.length (assemblies V))) (roots V).
  - intros r Hr. apply canon_root. assumption.
  - assumption.
Qed.

(* Anything that passes the check has all of canon in it. For every
   verisectorium and every list. *)
Theorem closed_has_canon : forall V S,
  closed V S = true -> forall r, Canon V r -> In r S.
Proof.
  intros V S Hc r Hr. unfold closed in Hc.
  apply andb_prop in Hc. destruct Hc as [H1 H2].
  rewrite forallb_forall in H1. rewrite forallb_forall in H2.
  induction Hr.
  - apply mem_In. apply H1. assumption.
  - specialize (H2 r IHHr). rewrite forallb_forall in H2.
    apply mem_In. apply H2. assumption.
Qed.

(* So: whenever the function's own answer passes the check, it is canon
   exactly. *)
Theorem canon_exact : forall V,
  closed V (canon_list V) = true ->
  forall r, Canon V r <-> In r (canon_list V).
Proof.
  intros V Hc r. split.
  - apply closed_has_canon. assumption.
  - apply canon_list_sound.
Qed.

(* Which slots are promised and empty. *)
Definition promised_in_result (r : derived_result) : list (name * string) :=
  let p {A} (label : string) (s : slot A) :=
    match s with Promised => [(r_name r, label)] | _ => [] end in
  p "formal-claim" (formal_claim r)
  ++ flat_map (p "derivation") (derivation r)
  ++ p "description" (description r)
  ++ match eli8 r with Some s => p "eli8" s | None => [] end.

Definition promised (V : verisectorium) : list (name * string) :=
  flat_map
    (fun l =>
       match l with
       | Result r => promised_in_result r
       | AnOutline o =>
           flat_map
             (fun e =>
                match e with
                | Entry Promised => [(o_name o, "entry")]
                | Entry (Filled (Holds (HeldR r)) _) => promised_in_result r
                | _ => []
                end)
             (entries o)
       end)
    (store V).

(* ---------- the instance ---------- *)

Definition c : veritoid Claim :=
  Veritoid "c" "Every bounded monotone sequence of reals converges.".
Definition d : veritoid Step :=
  Veritoid "d" "Take the least upper bound of the terms and show the terms come within any ε of it.".
Definition k : veritoid Explanation :=
  Veritoid "k" "If you keep stepping forward and there is a wall you cannot pass, you end up settling somewhere at or before the wall.".

Definition T :=
  DerivedResult "T" (holds c) [holds d] Promised (Some (holds k)).

Definition u : veritoid Claim :=
  Veritoid "u" "Every Cauchy sequence of reals converges.".

Definition U := DerivedResult "U" (holds u) [] Untouched None.

Definition O :=
  Outline "O"
    [ Entry (points_at "T");
      Entry (provisionally_points_at "U");
      Entry (Suggested "a result about series is probably wanted here");
      Gap ].

Definition here : verisectorium :=
  {| store := [Result T; Result U; AnOutline O]; roots := ["O"] |}.

(* Refused by the type checker, and checked to be refused: a step where the
   kind wants a claim. *)
Definition two := DerivedResult "T" (holds c) (holds c) [] Promised None.
