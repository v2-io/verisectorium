type kind = Claim | Step | Explanation

type veritoid = { v_id : int; kind : kind; content : string }

type 'a filler = Holds of 'a | Points_at of int

type 'a slot =
  | Untouched
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

type derived_result = {
  r_id : int;
  formal_claim : veritoid slot;
  derivation : veritoid slot list;
  description : veritoid slot;
  eli8 : veritoid slot option;
}
(*@ invariant takes Claim formal_claim
    invariant all_take Step derivation
    invariant takes Explanation description
    invariant match eli8 with None -> true | Some s -> takes Explanation s *)

let c = { v_id = 1; kind = Claim; content = "Every bounded monotone sequence of reals converges." }
let d = { v_id = 2; kind = Step; content = "Take the least upper bound." }
let k = { v_id = 3; kind = Explanation; content = "A wall you cannot pass." }

let t =
  { r_id = 4;
    formal_claim = Filled (Holds d, false);
    derivation = [ Filled (Holds d, false) ];
    description = Promised;
    eli8 = Some (Filled (Holds k, false)) }
