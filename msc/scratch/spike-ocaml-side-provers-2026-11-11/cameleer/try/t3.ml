(*@ predicate mem (x: int) (l: int list) =
      match l with [] -> false | y :: r -> x = y || mem x r *)

(*@ predicate edge (x y: int) (es: (int * int) list) =
      match es with [] -> false | (a, b) :: r -> (a = x && b = y) || edge x y r *)

(*@ inductive canon (roots: int list) (es: (int * int) list) (x: int) =
      | canon_root: forall roots es x. mem x roots -> canon roots es x
      | canon_step: forall roots es x y.
          canon roots es x -> edge x y es -> canon roots es y *)

(*@ predicate closed (roots: int list) (es: (int * int) list) (s: int list) =
      (forall x. mem x roots -> mem x s) &&
      (forall x y. mem x s -> edge x y es -> mem y s) *)

(*@ lemma closed_has_canon: forall roots es s x.
      closed roots es s -> canon roots es x -> mem x s *)

let rec is_in (x : int) (l : int list) : bool =
  match l with [] -> false | y :: r -> x = y || is_in x r
(*@ b = is_in x l
      variant l
      ensures b <-> mem x l *)

let rec all_in (l : int list) (s : int list) : bool =
  match l with [] -> true | x :: r -> is_in x s && all_in r s
(*@ b = all_in l s
      variant l
      ensures b <-> forall x. mem x l -> mem x s *)

let rec edges_closed (es : (int * int) list) (s : int list) : bool =
  match es with
  | [] -> true
  | (a, b) :: r -> ((not (is_in a s)) || is_in b s) && edges_closed r s
(*@ b = edges_closed es s
      variant es
      ensures b -> forall x y. mem x s -> edge x y es -> mem y s *)

let is_closed (roots : int list) (es : (int * int) list) (s : int list) : bool =
  all_in roots s && edges_closed es s
(*@ b = is_closed roots es s
      ensures b -> closed roots es s *)

