
type nat =
| O
| S of nat

(** val fst : ('a1 * 'a2) -> 'a1 **)

let fst = function
| (x, _) -> x

(** val snd : ('a1 * 'a2) -> 'a2 **)

let snd = function
| (_, y) -> y

(** val length : 'a1 list -> nat **)

let rec length = function
| [] -> O
| _ :: l' -> S (length l')

(** val app : 'a1 list -> 'a1 list -> 'a1 list **)

let rec app l m =
  match l with
  | [] -> m
  | a :: l1 -> a :: (app l1 m)

(** val in_dec : ('a1 -> 'a1 -> bool) -> 'a1 -> 'a1 list -> bool **)

let rec in_dec h a = function
| [] -> false
| a0 :: l0 -> let s = h a0 a in if s then true else in_dec h a l0

(** val flat_map : ('a1 -> 'a2 list) -> 'a1 list -> 'a2 list **)

let rec flat_map f = function
| [] -> []
| x :: l0 -> app (f x) (flat_map f l0)

(** val nodup : ('a1 -> 'a1 -> bool) -> 'a1 list -> 'a1 list **)

let rec nodup decA = function
| [] -> []
| x :: xs -> if in_dec decA x xs then nodup decA xs else x :: (nodup decA xs)

type name = string

type vkind =
| Claim
| Step
| Explanation

type veritoid = { v_name : name; content : string }

type 'a filler =
| Holds of 'a
| PointsAt of name

type 'a slot =
| Untouched
| Suggested of string
| Promised
| Filled of 'a filler * bool

(** val holds : 'a1 -> 'a1 slot **)

let holds x =
  Filled ((Holds x), false)

(** val points_at : name -> 'a1 slot **)

let points_at n =
  Filled ((PointsAt n), false)

(** val provisionally_points_at : name -> 'a1 slot **)

let provisionally_points_at n =
  Filled ((PointsAt n), true)

type derived_result = { r_name : name; formal_claim : veritoid slot;
                        derivation : veritoid slot list;
                        description : veritoid slot;
                        eli8 : veritoid slot option }

type held =
| HeldV of vkind * veritoid
| HeldR of derived_result

type entry =
| Entry of held slot
| Gap

type outline = { o_name : name; entries : entry list }

type living =
| Result of derived_result
| AnOutline of outline

type verisectorium = { store : living list; roots : name list }

(** val firm : ('a1 -> name) -> 'a1 slot -> name list **)

let firm name_of = function
| Filled (f, provisional) ->
  (match f with
   | Holds x -> if provisional then [] else (name_of x) :: []
   | PointsAt n -> if provisional then [] else n :: [])
| _ -> []

(** val reaches_result : derived_result -> name list **)

let reaches_result r =
  app (firm (fun v -> v.v_name) r.formal_claim)
    (app (flat_map (firm (fun v -> v.v_name)) r.derivation)
      (app (firm (fun v -> v.v_name) r.description)
        (match r.eli8 with
         | Some s -> firm (fun v -> v.v_name) s
         | None -> [])))

(** val held_name : held -> name **)

let held_name = function
| HeldV (_, v) -> v.v_name
| HeldR r -> r.r_name

(** val reaches_outline : outline -> name list **)

let reaches_outline o0 =
  flat_map (fun e -> match e with
                     | Entry s -> firm held_name s
                     | Gap -> [])
    o0.entries

(** val assemblies : verisectorium -> (name * name list) list **)

let assemblies v =
  flat_map (fun l ->
    match l with
    | Result r -> (r.r_name, (reaches_result r)) :: []
    | AnOutline o0 ->
      (o0.o_name,
        (reaches_outline o0)) :: (flat_map (fun e ->
                                   match e with
                                   | Entry s ->
                                     (match s with
                                      | Filled (f, _) ->
                                        (match f with
                                         | Holds x ->
                                           (match x with
                                            | HeldV (_, _) -> []
                                            | HeldR r ->
                                              (r.r_name,
                                                (reaches_result r)) :: [])
                                         | PointsAt _ -> [])
                                      | _ -> [])
                                   | Gap -> []) o0.entries))
    v.store

(** val out : verisectorium -> name -> name list **)

let out v n =
  flat_map (fun p -> if (=) (fst p) n then snd p else []) (assemblies v)

(** val step : verisectorium -> name list -> name list **)

let step v s =
  nodup (=) (app s (flat_map (out v) s))

(** val iter : nat -> ('a1 -> 'a1) -> 'a1 -> 'a1 **)

let rec iter n f x =
  match n with
  | O -> x
  | S n0 -> iter n0 f (f x)

(** val universe : verisectorium -> name list **)

let universe v =
  app v.roots (flat_map snd (assemblies v))

(** val canon_list : verisectorium -> name list **)

let canon_list v =
  iter (S (length (universe v))) (step v) v.roots

(** val promised_in_result : derived_result -> (name * string) list **)

let promised_in_result r =
  let p = fun label s ->
    match s with
    | Untouched -> []
    | Suggested _ -> []
    | Promised -> (r.r_name, label) :: []
    | Filled (_, _) -> []
  in
  app (p "formal-claim" r.formal_claim)
    (app (flat_map (p "derivation") r.derivation)
      (app (p "description" r.description)
        (match r.eli8 with
         | Some s -> p "eli8" s
         | None -> [])))

(** val promised : verisectorium -> (name * string) list **)

let promised v =
  flat_map (fun l ->
    match l with
    | Result r -> promised_in_result r
    | AnOutline o0 ->
      flat_map (fun e ->
        match e with
        | Entry s ->
          (match s with
           | Promised -> (o0.o_name, "entry") :: []
           | Filled (f, _) ->
             (match f with
              | Holds x ->
                (match x with
                 | HeldV (_, _) -> []
                 | HeldR r -> promised_in_result r)
              | PointsAt _ -> [])
           | _ -> [])
        | Gap -> []) o0.entries)
    v.store

(** val c : veritoid **)

let c =
  { v_name = "c"; content =
    "Every bounded monotone sequence of reals converges." }

(** val d : veritoid **)

let d =
  { v_name = "d"; content =
    "Take the least upper bound of the terms and show the terms come within any \206\181 of it." }

(** val k : veritoid **)

let k =
  { v_name = "k"; content =
    "If you keep stepping forward and there is a wall you cannot pass, you end up settling somewhere at or before the wall." }

(** val t : derived_result **)

let t =
  { r_name = "T"; formal_claim = (holds c); derivation = ((holds d) :: []);
    description = Promised; eli8 = (Some (holds k)) }

(** val u : veritoid **)

let u =
  { v_name = "u"; content = "Every Cauchy sequence of reals converges." }

(** val u0 : derived_result **)

let u0 =
  { r_name = "U"; formal_claim = (holds u); derivation = []; description =
    Untouched; eli8 = None }

(** val o : outline **)

let o =
  { o_name = "O"; entries = ((Entry (points_at "T")) :: ((Entry
    (provisionally_points_at "U")) :: ((Entry (Suggested
    "a result about series is probably wanted here")) :: (Gap :: [])))) }

(** val here : verisectorium **)

let here =
  { store = ((Result t) :: ((Result u0) :: ((AnOutline o) :: []))); roots =
    ("O" :: []) }
