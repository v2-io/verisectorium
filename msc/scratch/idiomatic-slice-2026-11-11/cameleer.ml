(* The slice as ordinary OCaml with its specification written beside it
   (GOSPEL, in the comments that begin with an at-sign), checked by Cameleer:
   the OCaml is translated to Why3 and each obligation is sent to a solver.

   Run it:    ocaml cameleer_run.ml           (any OCaml; the comments are comments)
   Check it:  ./cameleer-check.sh             (needs the switch cameleer-try)

   What is different here from ocaml.ml beside it: nothing is in the types
   that a solver would have to see through. A kind is a value. "Only a claim
   fills the formal-claim slot" is an INVARIANT written under the record, and
   building a result is a proof obligation. Canon is stated as two rules in
   the specification, and the function that computes it is plain recursion
   over lists whose postconditions say what it returns.

   Notes on what the tool accepted and refused are in cameleer-NOTES.md. *)

(* ---------- what exists ---------- *)

type kind = Claim | Step | Explanation

(* One piece of content of a declared kind. *)
type veritoid = { v_id : int; kind : kind; content : string }

(* A slot holds one that lives in it, or points at one, by id. The flag on a
   filled slot is "provisional". *)
type 'a filler = Holds of 'a | Points_at of int

type 'a slot =
  | Untouched  (* declared by the kind; nobody has said anything yet *)
  | Suggested of string
  | Promised
  | Filled of 'a filler * bool

(*@ predicate takes (k: kind) (s: veritoid slot) =
      match s with
      | Filled (Holds v) _ -> v.kind = k
      | _ -> true *)

(*@ predicate all_take (k: kind) (l: veritoid slot list) =
      match l with
      | [] -> true
      | s :: r -> takes k s && all_take k r *)

(* The kind derived-result. The record says how many of each slot; the
   invariant says what kind of thing each one takes. *)
type derived_result = {
  r_id : int;
  formal_claim : veritoid slot;  (* one *)
  derivation : veritoid slot list;  (* any number, in order *)
  description : veritoid slot;  (* one *)
  eli8 : veritoid slot option;  (* at most one *)
}
(*@ invariant takes Claim formal_claim
    invariant all_take Step derivation
    invariant takes Explanation description
    invariant match eli8 with None -> true | Some s -> takes Explanation s *)

(* An outline takes anything, in order. It may hold a veritoid or a result;
   another outline it can only point at. A gap is an entry, not a slot. *)
type held = Held_veritoid of veritoid | Held_result of derived_result
type entry = Entry of held slot | Gap
type outline = { o_id : int; entries : entry list }

(* What lives on its own, and which ids are marked as roots. *)
type living = Result of derived_result | An_outline of outline
type verisectorium = { store : living list; roots : int list }

(* ---------- what one assembly reaches in one step ---------- *)

(* Through a slot that is filled and not provisional, to what it holds or
   points at. Each function adds (from, to) pairs to a list. *)

let reach_v (from : int) (s : veritoid slot) (acc : (int * int) list) :
    (int * int) list =
  match s with
  | Filled (Holds v, false) -> (from, v.v_id) :: acc
  | Filled (Points_at n, false) -> (from, n) :: acc
  | _ -> acc

let rec reach_vs (from : int) (l : veritoid slot list) (acc : (int * int) list)
    : (int * int) list =
  match l with [] -> acc | s :: r -> reach_v from s (reach_vs from r acc)
(*@ r = reach_vs from l acc
      variant l *)

let reach_result (r : derived_result) (acc : (int * int) list) :
    (int * int) list =
  let acc = reach_v r.r_id r.formal_claim acc in
  let acc = reach_vs r.r_id r.derivation acc in
  let acc = reach_v r.r_id r.description acc in
  match r.eli8 with None -> acc | Some s -> reach_v r.r_id s acc

let reach_entry (from : int) (e : entry) (acc : (int * int) list) :
    (int * int) list =
  match e with
  | Gap -> acc
  | Entry (Filled (Holds (Held_veritoid v), false)) -> (from, v.v_id) :: acc
  | Entry (Filled (Holds (Held_result r), false)) ->
      (from, r.r_id) :: reach_result r acc
  | Entry (Filled (Holds (Held_result r), true)) -> reach_result r acc
  | Entry (Filled (Points_at n, false)) -> (from, n) :: acc
  | Entry _ -> acc

let rec reach_entries (from : int) (l : entry list) (acc : (int * int) list) :
    (int * int) list =
  match l with [] -> acc | e :: r -> reach_entry from e (reach_entries from r acc)
(*@ r = reach_entries from l acc
      variant l *)

let rec reach_store (l : living list) : (int * int) list =
  match l with
  | [] -> []
  | Result r :: rest -> reach_result r (reach_store rest)
  | An_outline o :: rest -> reach_entries o.o_id o.entries (reach_store rest)
(*@ r = reach_store l
      variant l *)

(* ---------- what canon is ---------- *)

(*@ predicate mem (x: int) (l: int list) =
      match l with [] -> false | y :: r -> x = y || mem x r *)

(*@ predicate edge (x y: int) (es: (int * int) list) =
      match es with
      | [] -> false
      | (a, b) :: r -> (a = x && b = y) || edge x y r *)

(* A root is in canon. What something in canon reaches is in canon. *)
(*@ inductive canon (roots: int list) (es: (int * int) list) (x: int) =
      | canon_root: forall roots es x. mem x roots -> canon roots es x
      | canon_step: forall roots es x y.
          canon roots es x -> edge x y es -> canon roots es y *)

(* A list is closed when it has the roots and everything its members reach. *)
(*@ predicate closed (roots: int list) (es: (int * int) list) (s: int list) =
      (forall x. mem x roots -> mem x s) &&
      (forall x y. mem x s -> edge x y es -> mem y s) *)

(* Proved by induction on the two rules. *)
(*@ lemma closed_has_canon: forall roots es s x.
      closed roots es s -> canon roots es x -> mem x s *)

(* ---------- a function that computes it ---------- *)

let rec is_in (x : int) (l : int list) : bool =
  match l with [] -> false | y :: r -> x = y || is_in x r
(*@ b = is_in x l
      variant l
      ensures b <-> mem x l *)

(* One pass over the pairs: add what anything already seen reaches. *)
let rec pass (roots : int list) (all : (int * int) list) (seen : int list)
    (es : (int * int) list) : int list =
  match es with
  | [] -> seen
  | (a, b) :: r ->
      if is_in a seen && not (is_in b seen) then pass roots all (b :: seen) r
      else pass roots all seen r
(*@ s = pass roots all seen es
      requires forall x. mem x seen -> canon roots all x
      requires forall x y. edge x y es -> edge x y all
      variant es
      ensures forall x. mem x s -> canon roots all x
      ensures forall x. mem x seen -> mem x s *)

(* The tool will not take a function without a reason it stops; following
   pointers has none of its own. So: a number of passes, counted down. *)
let rec close (fuel : int) (roots : int list) (all : (int * int) list)
    (seen : int list) : int list =
  if fuel <= 0 then seen
  else close (fuel - 1) roots all (pass roots all seen all)
(*@ s = close fuel roots all seen
      requires forall x. mem x seen -> canon roots all x
      variant fuel
      ensures forall x. mem x s -> canon roots all x
      ensures forall x. mem x seen -> mem x s *)

let rec count (l : (int * int) list) : int =
  match l with [] -> 0 | _ :: r -> 1 + count r
(*@ n = count l
      variant l
      ensures n >= 0 *)

(* Everything this returns is in canon. Proved, for every input. *)
let canon_list (roots : int list) (es : (int * int) list) : int list =
  close (count es + 1) roots es roots
(*@ s = canon_list roots es
      ensures forall x. mem x s -> canon roots es x
      ensures forall x. mem x roots -> mem x s *)

(* The check that a list is closed. *)
let rec all_in (l : int list) (s : int list) : bool =
  match l with [] -> true | x :: r -> is_in x s && all_in r s
(*@ b = all_in l s
      variant l
      ensures b -> forall x. mem x l -> mem x s *)

let rec pairs_closed (es : (int * int) list) (s : int list) : bool =
  match es with
  | [] -> true
  | (a, b) :: r -> ((not (is_in a s)) || is_in b s) && pairs_closed r s
(*@ b = pairs_closed es s
      variant es
      ensures b -> forall x y. mem x s -> edge x y es -> mem y s *)

(* Canon, exactly, or nothing: the list is returned only if it passed the
   check, and then it is proved to be all of canon and nothing else. *)
let canon_checked (roots : int list) (es : (int * int) list) : int list option
    =
  let s = canon_list roots es in
  if all_in roots s && pairs_closed es s then Some s else None
(*@ r = canon_checked roots es
      ensures match r with
              | None -> true
              | Some s -> forall x. mem x s <-> canon roots es x *)

(* ---------- which slots are promised and empty ---------- *)

let promised_v (owner : int) (label : string) (s : veritoid slot)
    (acc : (int * string) list) : (int * string) list =
  match s with Promised -> (owner, label) :: acc | _ -> acc

let rec promised_vs (owner : int) (label : string) (l : veritoid slot list)
    (acc : (int * string) list) : (int * string) list =
  match l with
  | [] -> acc
  | s :: r -> promised_v owner label s (promised_vs owner label r acc)
(*@ r = promised_vs owner label l acc
      variant l *)

let promised_result (r : derived_result) (acc : (int * string) list) :
    (int * string) list =
  let acc = promised_v r.r_id "formal-claim" r.formal_claim acc in
  let acc = promised_vs r.r_id "derivation" r.derivation acc in
  let acc = promised_v r.r_id "description" r.description acc in
  match r.eli8 with None -> acc | Some s -> promised_v r.r_id "eli8" s acc

let rec promised_store (l : living list) : (int * string) list =
  match l with
  | [] -> []
  | Result r :: rest -> promised_result r (promised_store rest)
  | An_outline _ :: rest -> promised_store rest
(*@ r = promised_store l
      variant l *)

(* ---------- the instance ---------- *)

(* ids: O 1, T 2, U 3, c 4, d 5, k 6, u 7 *)

let c =
  { v_id = 4; kind = Claim;
    content = "Every bounded monotone sequence of reals converges." }

let d =
  { v_id = 5; kind = Step;
    content =
      "Take the least upper bound of the terms and show the terms come \
       within any ε of it." }

let k =
  { v_id = 6; kind = Explanation;
    content =
      "If you keep stepping forward and there is a wall you cannot pass, you \
       end up settling somewhere at or before the wall." }

(* Building T is four proof obligations, one per line of the invariant. *)
let t =
  { r_id = 2;
    formal_claim = Filled (Holds c, false);
    derivation = [ Filled (Holds d, false) ];
    description = Promised;
    eli8 = Some (Filled (Holds k, false)) }

let u = { v_id = 7; kind = Claim; content = "Every Cauchy sequence of reals converges." }

let uu =
  { r_id = 3;
    formal_claim = Filled (Holds u, false);
    derivation = [];
    description = Untouched;
    eli8 = None }

let o =
  { o_id = 1;
    entries =
      [ Entry (Filled (Points_at 2, false));
        Entry (Filled (Points_at 3, true));
        Entry (Suggested "a result about series is probably wanted here");
        Gap ] }

let here = { store = [ Result t; Result uu; An_outline o ]; roots = [ 1 ] }
let canon_here = canon_checked here.roots (reach_store here.store)
let promised_here = promised_store here.store
