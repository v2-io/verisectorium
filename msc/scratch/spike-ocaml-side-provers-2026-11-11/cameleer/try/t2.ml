(*@ predicate mem (x: int) (l: int list) =
      match l with [] -> false | y :: r -> x = y || mem x r *)

(*@ predicate edge (x y: int) (es: (int * int) list) =
      match es with [] -> false | (a, b) :: r -> (a = x && b = y) || edge x y r *)

(*@ inductive canon (roots: int list) (es: (int * int) list) (x: int) =
      | canon_root: forall roots es x. mem x roots -> canon roots es x
      | canon_step: forall roots es x y.
          canon roots es x -> edge x y es -> canon roots es y *)

let rec is_in (x : int) (l : int list) : bool =
  match l with [] -> false | y :: r -> x = y || is_in x r
(*@ b = is_in x l
      variant l
      ensures b <-> mem x l *)

(* one pass over the edges: add the head of every edge whose tail is in *)
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

let rec close (fuel : int) (roots : int list) (all : (int * int) list)
    (seen : int list) : int list =
  if fuel <= 0 then seen else close (fuel - 1) roots all (pass roots all seen all)
(*@ s = close fuel roots all seen
      requires forall x. mem x seen -> canon roots all x
      variant fuel
      ensures forall x. mem x s -> canon roots all x
      ensures forall x. mem x seen -> mem x s *)

let rec length (l : (int * int) list) : int =
  match l with [] -> 0 | _ :: r -> 1 + length r
(*@ n = length l
      variant l
      ensures n >= 0 *)

let canon_list (roots : int list) (es : (int * int) list) : int list =
  close (length es + 1) roots es roots
(*@ s = canon_list roots es
      ensures forall x. mem x s -> canon roots es x
      ensures forall x. mem x roots -> mem x s *)
