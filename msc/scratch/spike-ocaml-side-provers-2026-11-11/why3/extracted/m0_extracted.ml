let c : Z.t = Z.one

let d : Z.t = Z.of_string "2"

let e : Z.t = Z.of_string "3"

let k : Z.t = Z.of_string "4"

let u : Z.t = Z.of_string "5"

let tt : Z.t = Z.of_string "6"

let uu : Z.t = Z.of_string "7"

let oo : Z.t = Z.of_string "8"

type kind =
  | Claim
  | Other
  | Result
  | Outline

type ontology = {
  kinds: ((Z.t) * kind) list;
  deps: ((Z.t) * (Z.t)) list;
  }

let ont : ontology =
  { kinds =
    (c, Claim) :: (d, Other) :: (e, Other) :: (k, Other) :: (u, Claim) :: 
    (tt, Result) :: (uu, Result) :: (oo, Outline) :: [] ; deps =
    (e, c) :: (k, e) :: []  }

type criterion =
  | Valid
  | CaseX
  | Whole

type event =
  | Write of (Z.t) * (Z.t) * (Z.t) * (((Z.t) * (Z.t)) list) *
      (((Z.t) * (bool)) list)
  | Evidence of (Z.t) * (Z.t) * (Z.t) * (Z.t) * criterion * (bool) *
      (((Z.t) * (Z.t)) list)
  | Affirm of (Z.t) * (Z.t) * (Z.t) * (Z.t) * (Z.t)
  | SetAside of (Z.t) * (Z.t)
  | MarkRoot of (Z.t) * (Z.t)

let plain (t: Z.t) (p: Z.t) (v: Z.t) : event = Write (t, p, v, [] , [] )

let t_slots : ((Z.t) * (bool)) list =
  (c, false) :: (d, false) :: (e, false) :: (k, false) :: [] 

let s0 : event list =
  plain Z.one c Z.one :: plain (Z.of_string "2") d Z.one :: plain (Z.of_string "3")
                                                            e
                                                            Z.one :: 
  plain (Z.of_string "4")
  k
  Z.one :: Write (Z.of_string "5", u, Z.one, (c, Z.one) :: [] , [] ) :: 
  Write (Z.of_string "6",
  tt,
  Z.one,
  [] ,
  t_slots) :: Write (Z.of_string "7", uu, Z.one, [] , (u, false) :: [] ) :: 
  Write (Z.of_string "8",
  oo,
  Z.one,
  [] ,
  (tt, false) :: (uu, false) :: [] ) :: MarkRoot (Z.of_string "9", oo) :: 
  Evidence (Z.of_string "10",
  Z.one,
  c,
  Z.one,
  Valid,
  true,
  (d, Z.one) :: [] ) :: Evidence (Z.of_string "11",
                        Z.of_string "2",
                        u,
                        Z.one,
                        Valid,
                        true,
                        (c, Z.one) :: [] ) :: Evidence (Z.of_string "12",
                                              Z.of_string "3",
                                              tt,
                                              Z.one,
                                              Whole,
                                              true,
                                              (c, Z.one) :: (d, Z.one) :: 
                                              (e, Z.one) :: (k, Z.one) :: 
                                              [] ) :: Evidence (Z.of_string "13",
                                                      Z.of_string "4",
                                                      uu,
                                                      Z.one,
                                                      Whole,
                                                      true,
                                                      (u, Z.one) :: [] ) :: 
  Affirm (Z.of_string "14",
  e,
  Z.one,
  c,
  Z.one) :: Affirm (Z.of_string "15", k, Z.one, e, Z.one) :: [] 

let e5 : event list =
  Evidence (Z.of_string "20", Z.of_string "5", c, Z.one, CaseX, false, [] ) :: 
  [] 

let row1 : event list = List.append s0 e5

let e6 : event list =
  Evidence (Z.of_string "32",
  Z.of_string "6",
  c,
  Z.of_string "11",
  Valid,
  true,
  (d, Z.of_string "11") :: [] ) :: [] 

let row2 : event list =
  List.append (List.append row1
               (plain (Z.of_string "30") c (Z.of_string "11") :: plain 
                                                                 (Z.of_string "31")
                                                                 d
                                                                 (Z.of_string "11") :: 
               [] ))
  e6

let row3 : event list = List.append row1 e6

let row4 : event list =
  List.append row3
  (plain (Z.of_string "40") c (Z.of_string "2") :: plain (Z.of_string "41")
                                                   d
                                                   (Z.of_string "2") :: 
  plain (Z.of_string "42")
  k
  (Z.of_string "2") :: Affirm (Z.of_string "43",
                       e,
                       Z.one,
                       c,
                       Z.of_string "2") :: [] )

let row5 : event list =
  List.append row4
  (Evidence (Z.of_string "50",
   Z.of_string "7",
   c,
   Z.of_string "2",
   Valid,
   true,
   (d, Z.of_string "2") :: [] ) :: Evidence (Z.of_string "51",
                                   Z.of_string "8",
                                   c,
                                   Z.of_string "2",
                                   CaseX,
                                   true,
                                   [] ) :: [] )

let row6 : event list =
  List.append row5 (plain (Z.of_string "60") d (Z.of_string "3") :: [] )

let row7 : event list =
  List.append row6
  (Evidence (Z.of_string "70",
   Z.of_string "9",
   c,
   Z.of_string "2",
   Valid,
   true,
   (d, Z.of_string "3") :: [] ) :: [] )

let row8 : event list =
  List.append row7
  (Write (Z.of_string "80",
   u,
   Z.of_string "2",
   (c, Z.of_string "2") :: [] ,
   [] ) :: Evidence (Z.of_string "81",
           Z.of_string "10",
           u,
           Z.of_string "2",
           Valid,
           true,
           (c, Z.of_string "2") :: [] ) :: [] )

let row9 : event list =
  List.append row8
  (Evidence (Z.of_string "90",
   Z.of_string "11",
   tt,
   Z.one,
   Whole,
   true,
   (c, Z.of_string "2") :: (d, Z.of_string "3") :: (e, Z.one) :: (k,
                                                                 Z.of_string "2") :: 
   [] ) :: Evidence (Z.of_string "91",
           Z.of_string "12",
           uu,
           Z.one,
           Whole,
           true,
           (u, Z.of_string "2") :: [] ) :: [] )

let row9_with_k_affirmed : event list =
  List.append row9
  (Affirm (Z.of_string "92", k, Z.of_string "2", e, Z.one) :: [] )

type item =
  | Owed of (Z.t) * (Z.t)

let rec has (x: Z.t) (s: (Z.t) list) : bool =
  match s with
  | [] -> false
  | y :: r -> Z.equal x y || has x r

let rec add_new (xs: (Z.t) list) (s: (Z.t) list) : (Z.t) list =
  match xs with
  | [] -> s
  | x :: r -> (let s' = add_new r s in if has x s' then s' else x :: s')

type version = {
  v: Z.t;
  refs: ((Z.t) * (Z.t)) list;
  slots: ((Z.t) * (bool)) list;
  }

let rec selected (l: event list) (p: Z.t) : version option =
  match l with
  | [] -> None 
  | ev :: rest ->
    begin match selected rest p with
    | Some x -> Some x
    | None ->
      begin match ev with
      | Write (_,
        q,
        v1,
        refs1,
        slots1) ->
        if Z.equal q p
        then Some { v = v1; refs = refs1; slots = slots1 }
        else None 
      | _ -> None 
      end
    end

let rec firm (slots1: ((Z.t) * (bool)) list) : (Z.t) list =
  match slots1 with
  | [] -> [] 
  | (q, provisional) :: rest ->
    if provisional then firm rest else q :: firm rest

let reaches (l: event list) (p: Z.t) : (Z.t) list =
  match selected l p with
  | Some x -> firm x.slots
  | None -> [] 

let rec reached_from (l: event list) (s: (Z.t) list) : (Z.t) list =
  match s with
  | [] -> [] 
  | p :: rest -> List.append (reaches l p) (reached_from l rest)

let rec grow (l: event list) (rounds: Z.t) (s: (Z.t) list) : (Z.t) list =
  if Z.leq rounds Z.zero
  then s
  else grow l (Z.sub rounds Z.one) (add_new (reached_from l s) s)

let rec roots (l: event list) : (Z.t) list =
  match l with
  | [] -> [] 
  | MarkRoot (_, a) :: rest -> a :: roots rest
  | _ :: rest -> roots rest

let canon (o: ontology) (l: event list) : (Z.t) list =
  grow l (Z.of_int (List.length o.kinds)) (roots l)

let ver_of (l: event list) (p: Z.t) : Z.t =
  match selected l p with
  | Some x -> x.v
  | None -> Z.of_string "-1"

let rec all_there (l: event list) (refs1: ((Z.t) * (Z.t)) list) : bool =
  match refs1 with
  | [] -> true
  | (q, _) :: rest -> Z.geq (ver_of l q) Z.zero && all_there l rest

let owes1 (l: event list) (p: Z.t) : bool =
  match selected l p with
  | Some x -> not (all_there l x.refs)
  | None -> false

let rec affirmed (l: event list) (p: Z.t) (pv: Z.t) (q: Z.t) (qv: Z.t) : 
  bool =
  match l with
  | [] -> false
  | Affirm (_, a, av, b, bv) :: rest ->
    Z.equal a p && Z.equal av pv && Z.equal b q && Z.equal bv qv || affirmed rest
                                                                    p
                                                                    pv
                                                                    q
                                                                    qv
  | _ :: rest -> affirmed rest p pv q qv

let rec all_reconciled (l: event list) (p: Z.t) (pv: Z.t)
                       (refs1: ((Z.t) * (Z.t)) list) : bool =
  match refs1 with
  | [] -> true
  | (q, written_against) :: rest ->
    (Z.equal (ver_of l q) written_against || affirmed l p pv q (ver_of l q)) && 
    all_reconciled l
    p
    pv
    rest

let owes2 (l: event list) (p: Z.t) : bool =
  match selected l p with
  | Some x -> not (all_reconciled l p x.v x.refs)
  | None -> false

let rec set_aside (l: event list) (e1: Z.t) : bool =
  match l with
  | [] -> false
  | SetAside (_, e') :: rest -> Z.equal e' e1 || set_aside rest e1
  | _ :: rest -> set_aside rest e1

let rec reads_as_now (l: event list) (was_read: ((Z.t) * (Z.t)) list) : 
  bool =
  match was_read with
  | [] -> true
  | (q, w) :: rest -> Z.equal (ver_of l q) w && reads_as_now l rest

let applies (l: event list) (e1: Z.t) (p: Z.t) (v1: Z.t)
            (was_read: ((Z.t) * (Z.t)) list) : bool =
  not (set_aside l e1) && Z.equal (ver_of l p) v1 && reads_as_now l was_read

let rec finding_applies (whole: event list) (l: event list) (p: Z.t) : 
  bool =
  match l with
  | [] -> false
  | Evidence (_, e1, q, v1, _, false, was_read) :: rest ->
    Z.equal q p && applies whole e1 q v1 was_read || finding_applies whole
                                                     rest
                                                     p
  | _ :: rest -> finding_applies whole rest p

let rec once_at (l: event list) (p: Z.t) (v1: Z.t) : bool =
  match l with
  | [] -> false
  | Write (_, q, w, _, _) :: rest ->
    Z.equal q p && Z.equal w v1 || once_at rest p v1
  | _ :: rest -> once_at rest p v1

let rec answered_since (whole: event list) (l: event list) (p: Z.t)
                       (c1: criterion) (t: Z.t) : bool =
  match l with
  | [] -> false
  | Evidence (t', e1, q, v1, c', true, was_read) :: rest ->
    Z.equal q p && begin match (c1, c') with
                   | ((Valid, Valid) | ((CaseX, CaseX) | (Whole, Whole))) ->
                     true
                   | _ -> false
                   end && Z.gt t' t && applies whole e1 q v1 was_read || 
    answered_since whole
    rest
    p
    c1
    t
  | _ :: rest -> answered_since whole rest p c1 t

let rec guard_open (whole: event list) (l: event list) (p: Z.t) : bool =
  match l with
  | [] -> false
  | Evidence (t, e1, q, v1, c1, false, _) :: rest ->
    Z.equal q p && not (set_aside whole e1) && not (Z.equal (ver_of whole p)
                                                    v1) && once_at whole p v1 && 
                                                           not (answered_since whole
                                                                whole p c1 t) || 
    guard_open whole
    rest
    p
  | _ :: rest -> guard_open whole rest p

let owes4 (l: event list) (p: Z.t) : bool =
  finding_applies l l p || guard_open l l p

let rec kind_of (ks: ((Z.t) * kind) list) (p: Z.t) : kind =
  match ks with
  | [] -> Other
  | (q, k1) :: rest -> if Z.equal q p then k1 else kind_of rest p

let rec checked (whole: event list) (l: event list) (p: Z.t) : bool =
  match l with
  | [] -> false
  | Evidence (_, e1, q, v1, Valid, true, was_read) :: rest ->
    Z.equal q p && applies whole e1 q v1 was_read || checked whole rest p
  | _ :: rest -> checked whole rest p

let rec read_each (was_read: ((Z.t) * (Z.t)) list)
                  (fillers: ((Z.t) * (bool)) list) : bool =
  match fillers with
  | [] -> true
  | (f, _) :: rest -> read_one was_read f && read_each was_read rest
and read_one (was_read: ((Z.t) * (Z.t)) list) (f: Z.t) : bool =
  match was_read with
  | [] -> false
  | (q, _) :: rest -> Z.equal q f || read_one rest f

let rec read_whole (whole: event list) (l: event list) (p: Z.t)
                   (fillers: ((Z.t) * (bool)) list) : bool =
  match l with
  | [] -> false
  | Evidence (_, e1, q, v1, Whole, true, was_read) :: rest ->
    Z.equal q p && applies whole e1 q v1 was_read && read_each was_read
                                                     fillers || read_whole whole
                                                                rest
                                                                p
                                                                fillers
  | _ :: rest -> read_whole whole rest p fillers

let owes5_ask (o: ontology) (l: event list) (p: Z.t) : bool =
  match kind_of o.kinds p with
  | Claim -> not (checked l l p)
  | Result ->
    begin match selected l p with
    | Some x -> not (read_whole l l p x.slots)
    | None -> false
    end
  | (Other | Outline) -> false

let rec read_together (whole: event list) (l: event list) (a: Z.t) (b: Z.t) :
  bool =
  match l with
  | [] -> false
  | Evidence (_, e1, q, v1, _, _, was_read) :: rest ->
    Z.equal q a && applies whole e1 q v1 was_read && read_one was_read b || 
    read_together whole
    rest
    a
    b
  | _ :: rest -> read_together whole rest a b

let rec owes6_in (l: event list) (ds: ((Z.t) * (Z.t)) list) (p: Z.t) : 
  bool =
  match ds with
  | [] -> false
  | (a, b) :: rest ->
    Z.equal a p && Z.geq (ver_of l a) Z.zero && Z.geq (ver_of l b) Z.zero && 
                                                not (affirmed l a
                                                     (ver_of l a) b
                                                     (ver_of l b)) && 
                                                not (read_together l l a b) || 
    owes6_in l
    rest
    p

let owes6 (o: ontology) (l: event list) (p: Z.t) : bool = owes6_in l o.deps p

let own_violation (o: ontology) (l: event list) (p: Z.t) : bool =
  owes1 l p || owes2 l p || owes4 l p || owes5_ask o l p || owes6 o l p

let rec any_bad (o: ontology) (l: event list) (cn: (Z.t) list)
                (s: (Z.t) list) : bool =
  match s with
  | [] -> false
  | q :: rest -> not (has q cn) || own_violation o l q || any_bad o l cn rest

let rec targets (refs1: ((Z.t) * (Z.t)) list) : (Z.t) list =
  match refs1 with
  | [] -> [] 
  | (q, _) :: rest -> q :: targets rest

let predicated_on (l: event list) (p: Z.t) : (Z.t) list =
  match selected l p with
  | Some x -> targets x.refs
  | None -> [] 

let rec predicated_from (l: event list) (s: (Z.t) list) : (Z.t) list =
  match s with
  | [] -> [] 
  | p :: rest -> List.append (predicated_on l p) (predicated_from l rest)

let rec rests_on (l: event list) (rounds: Z.t) (s: (Z.t) list) : (Z.t) list =
  if Z.leq rounds Z.zero
  then s
  else rests_on l (Z.sub rounds Z.one) (add_new (predicated_from l s) s)

let owes5_rest (o: ontology) (l: event list) (cn: (Z.t) list) (p: Z.t) : 
  bool =
  any_bad o
  l
  cn
  (rests_on l (Z.of_int (List.length o.kinds)) (predicated_on l p))

let owed_by (o: ontology) (l: event list) (cn: (Z.t) list) (p: Z.t) :
  item list =
  List.append (List.append (List.append (List.append (if owes1 l p
                                                      then
                                                        Owed (Z.one, p) :: 
                                                        [] 
                                                      else [] )
                                         (if owes2 l p
                                          then
                                            Owed (Z.of_string "2", p) :: 
                                            [] 
                                          else [] ))
                            (if owes4 l p
                             then Owed (Z.of_string "4", p) :: [] 
                             else [] ))
               (if owes5_ask o l p || owes5_rest o l cn p
                then Owed (Z.of_string "5", p) :: [] 
                else [] ))
  (if owes6 o l p then Owed (Z.of_string "6", p) :: []  else [] )

let rec frontier_of (o: ontology) (l: event list) (cn: (Z.t) list)
                    (ps: (Z.t) list) : item list =
  match ps with
  | [] -> [] 
  | p :: rest -> List.append (owed_by o l cn p) (frontier_of o l cn rest)

let frontier (o: ontology) (l: event list) : item list =
  let cn = canon o l in frontier_of o l cn cn

let run (_: unit) : (item list) list =
  frontier ont s0 :: frontier ont row1 :: frontier ont row2 :: frontier ont
                                                               row3 :: 
  frontier ont
  row4 :: frontier ont row5 :: frontier ont row6 :: frontier ont row7 :: 
  frontier ont
  row8 :: frontier ont row9 :: frontier ont row9_with_k_affirmed :: [] 

