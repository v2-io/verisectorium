(* The slice in Rocq, and the OCaml it extracts to.

   Check:    opam exec --switch=rocq-try -- rocq compile rocq.v
   That also writes rocq_extracted.ml: the same functions as plain OCaml.

   Three things are said here, in this order:
     1. what exists (types; the kind of a veritoid is in its type);
     2. what canon IS: two rules, with nothing about how to find it;
     3. a function that computes a list, and a proof that the list is canon
        exactly, for any verisectorium whatever.
   Notes on what Rocq made natural, refused, and made awkward are at the
   foot of the file. *)

From Stdlib Require Import List String Bool Arith Lia.
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

(* ---------- 3. a function, and the proof that it computes canon ---------- *)

(* Add what everything in S reaches. *)
Definition step (V : verisectorium) (S : list name) : list name :=
  nodup string_dec (S ++ flat_map (out V) S).

Fixpoint iter {A} (n : nat) (f : A -> A) (x : A) : A :=
  match n with 0 => x | S n => iter n f (f x) end.

(* Every name there is to reach. *)
Definition universe (V : verisectorium) : list name :=
  roots V ++ flat_map snd (assemblies V).

(* Rocq will not take a function that might not stop, and following pointers
   might not: an outline can point at itself. So the function has to say how
   long it will go on, and the proof has to say why that is long enough: each
   round either adds a name or changes nothing, and there are only so many
   names. *)
Definition canon_list (V : verisectorium) : list name :=
  iter (S (List.length (universe V))) (step V) (roots V).

(* -- everything listed is in canon -- *)

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
  apply iter_sound with (S (List.length (universe V))) (roots V).
  - intros r Hr. apply canon_root. assumption.
  - assumption.
Qed.

(* -- everything in canon is listed -- *)

Definition closed_under (V : verisectorium) (S : list name) : Prop :=
  forall r q, In r S -> In q (out V r) -> In q S.

Lemma step_keeps : forall V S x, In x S -> In x (step V S).
Proof.
  intros V S x H. unfold step. apply nodup_In. apply in_or_app. left. assumption.
Qed.

Lemma step_adds : forall V S r q, In r S -> In q (out V r) -> In q (step V S).
Proof.
  intros V S r q Hr Hq. unfold step. apply nodup_In. apply in_or_app. right.
  apply in_flat_map. exists r. split; assumption.
Qed.

Lemma iter_keeps : forall V n S x, In x S -> In x (iter n (step V) S).
Proof.
  intros V n. induction n; simpl; intros S x H.
  - assumption.
  - apply IHn. apply step_keeps. assumption.
Qed.

Lemma step_of_closed : forall V S,
  closed_under V S -> forall x, In x (step V S) -> In x S.
Proof.
  intros V S Hc x Hx. unfold step in Hx. apply nodup_In in Hx.
  apply in_app_or in Hx. destruct Hx as [Hx | Hx].
  - assumption.
  - apply in_flat_map in Hx. destruct Hx as [r [Hr Hq]]. apply Hc with r; assumption.
Qed.

Lemma closed_stays_closed : forall V n S,
  closed_under V S -> closed_under V (iter n (step V) S).
Proof.
  intros V n. induction n; simpl; intros S Hc.
  - assumption.
  - apply IHn. intros r q Hr Hq. apply step_keeps.
    apply Hc with r. apply (step_of_closed V S Hc). assumption. assumption.
Qed.

Lemma out_in_universe : forall V r q, In q (out V r) -> In q (universe V).
Proof.
  intros V r q H. unfold out in H. apply in_flat_map in H.
  destruct H as [p [Hp Hq]]. unfold universe. apply in_or_app. right.
  apply in_flat_map. exists p. split. assumption.
  destruct (String.eqb (fst p) r). assumption. contradiction.
Qed.

Lemma step_in_universe : forall V S,
  incl S (universe V) -> incl (step V S) (universe V).
Proof.
  intros V S H x Hx. unfold step in Hx. apply nodup_In in Hx.
  apply in_app_or in Hx. destruct Hx as [Hx | Hx].
  - apply H. assumption.
  - apply in_flat_map in Hx. destruct Hx as [r [Hr Hq]].
    apply out_in_universe with r. assumption.
Qed.

(* The counting argument. A list without repeats, inside the universe, with
   n rounds still to go and at most n names still missing, ends closed. *)
Lemma enough_rounds : forall V n S,
  NoDup S -> incl S (universe V) ->
  List.length (nodup string_dec (universe V)) <= List.length S + n ->
  closed_under V (iter n (step V) S).
Proof.
  intros V n. induction n; intros S Hnd Hin Hlen.
  - simpl. intros r q Hr Hq.
    assert (incl (nodup string_dec (universe V)) S) as Hall.
    { apply NoDup_length_incl.
      - assumption.
      - rewrite Nat.add_0_r in Hlen. exact Hlen.
      - intros x Hx. apply nodup_In. apply Hin. assumption. }
    apply Hall. apply nodup_In. apply out_in_universe with r. assumption.
  - simpl.
    destruct (Nat.le_gt_cases (List.length (step V S)) (List.length S)) as [Hle | Hgt].
    + (* the round added nothing: S was already closed *)
      assert (incl (step V S) S) as Hback.
      { apply NoDup_length_incl. assumption. assumption.
        intros x Hx. apply step_keeps. assumption. }
      apply closed_stays_closed. intros r q Hr Hq. apply step_keeps.
      apply Hback. apply step_adds with r. apply Hback. assumption. assumption.
    + (* the round added a name: one fewer missing *)
      apply IHn.
      * unfold step. apply NoDup_nodup.
      * apply step_in_universe. assumption.
      * lia.
Qed.

Theorem canon_list_closed : forall V, closed_under V (canon_list V).
Proof.
  intros V. unfold canon_list. simpl. apply enough_rounds.
  - unfold step. apply NoDup_nodup.
  - apply step_in_universe. intros x Hx. unfold universe. apply in_or_app. left. assumption.
  - assert (List.length (nodup string_dec (universe V)) <= List.length (universe V)).
    { apply NoDup_incl_length. apply NoDup_nodup.
      intros x Hx. apply nodup_In in Hx. assumption. }
    lia.
Qed.

Theorem canon_list_complete : forall V r, Canon V r -> In r (canon_list V).
Proof.
  intros V r H. induction H.
  - unfold canon_list. apply iter_keeps. assumption.
  - apply canon_list_closed with r; assumption.
Qed.

(* The function computes canon. For every verisectorium there could be,
   rings of pointers included; no bound, no check to pass. *)
Theorem canon_list_is_canon : forall V r, Canon V r <-> In r (canon_list V).
Proof.
  intros V r. split. apply canon_list_complete. apply canon_list_sound.
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
Fail Definition wrong := DerivedResult "T" (holds d) [] Promised None.

Compute canon_list here.
Compute promised here.

Example the_list : canon_list here = ["O"; "T"; "c"; "d"; "k"].
Proof. reflexivity. Qed.

(* Canon here is O, T, c, d, k: by the two rules, not by the function. *)
Theorem canon_here : forall r, Canon here r <-> In r ["O"; "T"; "c"; "d"; "k"].
Proof.
  intros r. rewrite <- the_list. apply canon_list_is_canon.
Qed.

Theorem U_is_not_in_canon : ~ Canon here "U".
Proof.
  intros H. apply canon_here in H. simpl in H.
  repeat (destruct H as [H | H]; [discriminate H |]). assumption.
Qed.

Theorem u_is_not_in_canon : ~ Canon here "u".
Proof.
  intros H. apply canon_here in H. simpl in H.
  repeat (destruct H as [H | H]; [discriminate H |]). assumption.
Qed.

(* A ring: an outline that points at itself. The function stops, because it
   was never allowed not to. *)
Definition ring : verisectorium :=
  {| store := [AnOutline (Outline "X" [Entry (points_at "X")])]; roots := ["X"] |}.

Example the_ring : canon_list ring = ["X"].
Proof. reflexivity. Qed.

(* What the main theorem rests on: nothing but the definitions. *)
Print Assumptions canon_list_is_canon.

(* ---------- the OCaml it extracts to ---------- *)

From Stdlib Require Extraction.
From Stdlib Require Import ExtrOcamlBasic ExtrOcamlNativeString.
Extraction "rocq_extracted.ml" canon_list promised here.

(* ---------- notes ----------

   WHAT I REACHED FOR, AND WHY

   - Saying a thing twice, and proving the two are one. [Canon] is canon as
     the slice words it: the roots, and what something in canon reaches,
     and nothing else. [canon_list] is a program. [canon_list_is_canon] says
     they agree for every verisectorium there could be. This is the one
     thing here no other OCaml-side tool gives, and it is what I would show
     first.
   - An index on the type for a veritoid's kind: [veritoid Claim] and
     [veritoid Step] are different types made from one record.
   - A record per assembly kind, with one, any number, one, at most one as a
     field, a list, a field, an option. The same move as the OCaml slice.
   - [Fail], to keep a refusal in the file as a checked fact: if Rocq ever
     starts accepting a step in the claim slot, this file stops compiling.
   - Extraction. The last three lines turn the functions into OCaml.

   WHAT IT REFUSES (each tried; messages in the spike's rocq/runs/refusals.txt)

   - A step in the formal-claim slot; a second formal claim; a gap in a
     typed slot. Type errors, as in OCaml.
   - A function that follows pointers with no account of why it stops.
     "Cannot guess decreasing argument of fix." OCaml let me write that
     function, and it ran for ever on an outline that points at itself.
     Rocq would not take it, so the function counts its rounds and the proof
     says why that many are enough: each round adds a name or changes
     nothing, and there are only so many names.

   WHAT IT DOES NOT REFUSE

   - A root that is a veritoid, or a root that does not exist: roots are
     names. A pointer to nothing: pointing is by name too. Both are states
     that can be written, and canon is still definite for them (the name is
     in canon and reaches nothing).
   - Holding one segment in two places.

   WHERE THIS DEPARTS FROM THE SLICE AS WORDED

   1. A fifth slot state, [Untouched], and a gap as an entry of an outline
      and not a state of a slot. Both as in the OCaml slice, for the same
      reasons; I am the same mind and did not rediscover them.
   2. Pointing is by name, into a store of what lives on its own. (The OCaml
      slice shared values instead.) So a pointer can dangle and can go round
      in a ring, and the proof covers both.
   3. An outline may hold a veritoid or a derived result, and can only point
      at another outline. With "a segment is a veritoid or an assembly whose
      slots hold segments" as one recursive type, Rocq's own induction
      principle is too weak to prove anything about it without writing a
      better one by hand. I cut the recursion instead. This is the largest
      departure and it was made for the prover, not for the model.

   WHAT WAS AWKWARD

   - Three notations for "is this less than that" and "how long is this",
     for strings, lists and numbers, all spelled the same. Three of my nine
     failed compiles, across the slice and the small model, were the wrong
     one being picked. All were loud.
   - The proof is about 150 lines for a two-line definition and a five-line
     function. None of it is hard and none of it can be read without
     running it: each line changes a goal that is not on the page.
   - What comes out the other end. The extracted OCaml has one [veritoid]
     type: the kind is gone, and with it the refusal of a step in the claim
     slot. What is proved in Rocq is proved of the functions; what the types
     refused, the OCaml no longer refuses.
   - Speed, for the reason above the function: the version that is easy to
     prove is slow. On an outline of 200 results the extracted function
     takes 2.7 s; the same rounds written by hand in OCaml 1.3 s; a walk
     with a set, which is what one would write unproved, 0.0002 s
     (rocq/runs/extracted-02.txt). Extraction did not cost the speed. The
     proof did, and a faster function would need its own. *)
