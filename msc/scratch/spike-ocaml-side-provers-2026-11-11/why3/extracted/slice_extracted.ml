let c_ : Z.t = Z.one

let d_ : Z.t = Z.of_string "2"

let k_ : Z.t = Z.of_string "3"

let t_ : Z.t = Z.of_string "4"

let u_ : Z.t = Z.of_string "5"

let uu_ : Z.t = Z.of_string "6"

let o_ : Z.t = Z.of_string "7"

type 'kind veritoid = {
  name: Z.t;
  content: string;
  }

type claim

let c : claim veritoid =
  { name = c_; content =
    "Every bounded monotone sequence of reals converges." }

type step

let d : step veritoid =
  { name = d_; content =
    "Take the least upper bound of the terms and show the terms come within any \xCE\xB5 of it." }

type explanation

let k : explanation veritoid =
  { name = k_; content =
    "If you keep stepping forward and there is a wall you cannot pass, you end up settling somewhere at or before the wall." }

let u : claim veritoid =
  { name = u_; content = "Every Cauchy sequence of reals converges." }

type 'a filler =
  | Holds of 'a
  | PointsAt of (Z.t)

type 'a slot =
  | Untouched
  | Suggested of (string)
  | Promised
  | Filled of ('a filler) * (bool)

type derived_result = {
  r_name: Z.t;
  formal_claim: (claim veritoid) slot;
  derivation: ((step veritoid) slot) list;
  description: (explanation veritoid) slot;
  eli8: ((explanation veritoid) slot) option;
  }

let holds : type a. a ->  (a slot) = fun x -> Filled (Holds x, false)

let tt : derived_result =
  { r_name = t_; formal_claim = holds c; derivation = holds d :: [] ;
    description = Promised; eli8 = Some (holds k) }

let uu : derived_result =
  { r_name = uu_; formal_claim = holds u; derivation = [] ; description =
    Untouched; eli8 = None  }

type held =
  | AClaim of (claim veritoid)
  | AStep of (step veritoid)
  | AnExplanation of (explanation veritoid)
  | AResult of derived_result

type entry =
  | Entry of (held slot)
  | Gap

type outline = {
  o_name: Z.t;
  entries: entry list;
  }

let points_at : type a. (Z.t) ->  (a slot) =
  fun n -> Filled (PointsAt n, false)

let provisionally_points_at : type a. (Z.t) ->  (a slot) =
  fun n -> Filled (PointsAt n, true)

let o : outline =
  { o_name = o_; entries =
    Entry (points_at t_) :: Entry (provisionally_points_at uu_) :: Entry 
                                                                   (Suggested "a result about series is probably wanted here") :: Gap :: 
    []  }

type living =
  | Result of derived_result
  | AnOutline of outline

type verisectorium = {
  store: living list;
  roots: (Z.t) list;
  }

let here : verisectorium =
  { store = Result tt :: Result uu :: AnOutline o :: [] ; roots = o_ :: []  }

let rec has (x: Z.t) (l: (Z.t) list) : bool =
  match l with
  | [] -> false
  | y :: r -> Z.equal x y || has x r

let rec add_new (xs: (Z.t) list) (s: (Z.t) list) : (Z.t) list =
  match xs with
  | [] -> s
  | x :: r -> (let s' = add_new r s in if has x s' then s' else x :: s')

let rec out_of (a: ((Z.t) * ((Z.t) list)) list) (n: Z.t) : (Z.t) list =
  match a with
  | [] -> [] 
  | (m, reached) :: rest ->
    if Z.equal m n
    then List.append reached (out_of rest n)
    else out_of rest n

let firm_v : type k. ((k veritoid) slot) ->  ((Z.t) list) =
  fun s -> match s with
    | Filled (Holds v, false) -> v.name :: [] 
    | Filled (PointsAt n, false) -> n :: [] 
    | _ -> [] 

let rec firm_steps (l: ((step veritoid) slot) list) : (Z.t) list =
  match l with
  | [] -> [] 
  | s :: r -> List.append (firm_v s) (firm_steps r)

let reaches_result (r: derived_result) : (Z.t) list =
  List.append (List.append (List.append (firm_v r.formal_claim)
                            (firm_steps r.derivation))
               (firm_v r.description))
  begin match r.eli8 with
  | Some s -> firm_v s
  | None -> [] 
  end

let held_name (h: held) : Z.t =
  match h with
  | AClaim v -> v.name
  | AStep v -> v.name
  | AnExplanation v -> v.name
  | AResult r -> r.r_name

let rec reaches_entries (l: entry list) : (Z.t) list =
  match l with
  | [] -> [] 
  | Entry Filled (Holds h, false) :: r -> held_name h :: reaches_entries r
  | Entry Filled (PointsAt n, false) :: r -> n :: reaches_entries r
  | _ :: r -> reaches_entries r

let rec held_results (l: entry list) : ((Z.t) * ((Z.t) list)) list =
  match l with
  | [] -> [] 
  | Entry Filled (Holds AResult r, _) :: rest ->
    (r.r_name, reaches_result r) :: held_results rest
  | _ :: rest -> held_results rest

let rec assemblies (s: living list) : ((Z.t) * ((Z.t) list)) list =
  match s with
  | [] -> [] 
  | Result r :: rest -> (r.r_name, reaches_result r) :: assemblies rest
  | AnOutline o1 :: rest ->
    (o1.o_name, reaches_entries o1.entries) :: List.append (held_results 
                                                            o1.entries)
                                               (assemblies rest)

let out (v: verisectorium) (n: Z.t) : (Z.t) list =
  out_of (assemblies v.store) n

let rec reached_from (v: verisectorium) (l: (Z.t) list) : (Z.t) list =
  match l with
  | [] -> [] 
  | r :: rest ->
    (let here1 = out v r in let further = reached_from v rest in
     List.append here1 further)

let rec grow (v: verisectorium) (rounds: Z.t) (s: (Z.t) list) : (Z.t) list =
  if Z.equal rounds Z.zero
  then s
  else grow v (Z.sub rounds Z.one) (add_new (reached_from v s) s)

let how_many (v: verisectorium) : Z.t =
  Z.of_int (List.length (assemblies v.store))

let roots_of (v: verisectorium) : (Z.t) list = v.roots

let rec all_in (xs: (Z.t) list) (s: (Z.t) list) : bool =
  match xs with
  | [] -> true
  | x :: r -> has x s && all_in r s

let rec reaches_stay_in (v: verisectorium) (xs: (Z.t) list) (s: (Z.t) list) :
  bool =
  match xs with
  | [] -> true
  | r :: rest ->
    (let first = all_in (out v r) s in
     let others = reaches_stay_in v rest s in first && others)

let is_closed (v: verisectorium) (s: (Z.t) list) : bool =
  all_in (roots_of v) s && reaches_stay_in v s s

let canon_of (v: verisectorium) : ((Z.t) list) option =
  let s = grow v (Z.add (how_many v) Z.one) (roots_of v) in
  if is_closed v s then Some s else None 

let promised_v :
  type k. (Z.t) -> (string) -> ((k veritoid) slot) -> 
          (((Z.t) * (string)) list) =
  fun owner slot_name s -> match s with
    | Promised -> (owner, slot_name) :: [] 
    | _ -> [] 

let rec promised_steps (owner: Z.t) (l: ((step veritoid) slot) list) :
  ((Z.t) * (string)) list =
  match l with
  | [] -> [] 
  | s :: r ->
    List.append (promised_v owner "derivation" s) (promised_steps owner r)

let promised_in (r: derived_result) : ((Z.t) * (string)) list =
  List.append (List.append (List.append (promised_v r.r_name "formal-claim"
                                         r.formal_claim)
                            (promised_steps r.r_name r.derivation))
               (promised_v r.r_name "description" r.description))
  begin match r.eli8 with
  | Some s -> promised_v r.r_name "eli8" s
  | None -> [] 
  end

let rec promised (s: living list) : ((Z.t) * (string)) list =
  match s with
  | [] -> [] 
  | Result r :: rest -> List.append (promised_in r) (promised rest)
  | AnOutline _ :: rest -> promised rest

let answer (_: unit) : (((Z.t) list) option) * (((Z.t) * (string)) list) =
  (canon_of here, promised here.store)

