
(** val negb : bool -> bool **)

let negb = function
| true -> false
| false -> true

(** val fst : ('a1 * 'a2) -> 'a1 **)

let fst = function
| (x, _) -> x

(** val snd : ('a1 * 'a2) -> 'a2 **)

let snd = function
| (_, y) -> y

(** val length : 'a1 list -> int **)

let rec length = function
| [] -> 0
| _ :: l' -> Stdlib.Int.succ (length l')

(** val app : 'a1 list -> 'a1 list -> 'a1 list **)

let rec app l m =
  match l with
  | [] -> m
  | a :: l1 -> a :: (app l1 m)

type 'a sig0 = 'a
  (* singleton inductive, whose constructor was exist *)



module Nat =
 struct
  (** val ltb : int -> int -> bool **)

  let ltb n m =
    (<=) (Stdlib.Int.succ n) m
 end

(** val map : ('a1 -> 'a2) -> 'a1 list -> 'a2 list **)

let rec map f = function
| [] -> []
| a :: l0 -> (f a) :: (map f l0)

(** val seq : int -> int -> int list **)

let rec seq start len =
  (fun fO fS n -> if n=0 then fO () else fS (n-1))
    (fun _ -> [])
    (fun len0 -> start :: (seq (Stdlib.Int.succ start) len0))
    len

(** val in_dec : ('a1 -> 'a1 -> bool) -> 'a1 -> 'a1 list -> bool **)

let rec in_dec h a = function
| [] -> false
| a0 :: l0 -> let s = h a0 a in if s then true else in_dec h a l0

(** val flat_map : ('a1 -> 'a2 list) -> 'a1 list -> 'a2 list **)

let rec flat_map f = function
| [] -> []
| x :: l0 -> app (f x) (flat_map f l0)

(** val fold_left : ('a1 -> 'a2 -> 'a1) -> 'a2 list -> 'a1 -> 'a1 **)

let rec fold_left f l a0 =
  match l with
  | [] -> a0
  | b :: l0 -> fold_left f l0 (f a0 b)

(** val existsb : ('a1 -> bool) -> 'a1 list -> bool **)

let rec existsb f = function
| [] -> false
| a :: l0 -> (||) (f a) (existsb f l0)

(** val forallb : ('a1 -> bool) -> 'a1 list -> bool **)

let rec forallb f = function
| [] -> true
| a :: l0 -> (&&) (f a) (forallb f l0)

(** val filter : ('a1 -> bool) -> 'a1 list -> 'a1 list **)

let rec filter f = function
| [] -> []
| x :: l0 -> if f x then x :: (filter f l0) else filter f l0

(** val combine : 'a1 list -> 'a2 list -> ('a1 * 'a2) list **)

let rec combine l l' =
  match l with
  | [] -> []
  | x :: tl ->
    (match l' with
     | [] -> []
     | y :: tl' -> (x, y) :: (combine tl tl'))

(** val nodup : ('a1 -> 'a1 -> bool) -> 'a1 list -> 'a1 list **)

let rec nodup decA = function
| [] -> []
| x :: xs -> if in_dec decA x xs then nodup decA xs else x :: (nodup decA xs)

(** val step : (string -> string list) -> string list -> string list **)

let step out s =
  nodup (=) (app s (flat_map out s))

(** val iter : int -> ('a1 -> 'a1) -> 'a1 -> 'a1 **)

let rec iter n f x =
  (fun fO fS n -> if n=0 then fO () else fS (n-1))
    (fun _ -> x)
    (fun n0 -> iter n0 f (f x))
    n

(** val reach :
    (string -> string list) -> string list -> string list -> string list **)

let reach out start universe =
  iter (Stdlib.Int.succ (length universe)) (step out) start

type piece = string

type version = string

(** val eqs : string -> string -> bool **)

let eqs =
  (=)

type shape =
| Veritoid of bool * piece list
| Assembly of bool * ((string * piece) * bool) list

type ontology = { shape_of : (piece -> version -> shape option);
                  inner : (string * string) list; write_looks : bool }

type evidence = { e_name : string; e_piece : piece; e_version : version;
                  e_criterion : string; e_holds : bool;
                  e_reads : (piece * version) list }

type event =
| Write of piece * version
| Evidence of evidence
| Same of string * piece * version * version
| Affirm of piece * version * piece * version
| Raise of piece * string
| Promise of piece * string
| Waive of int * piece
| SetAside of string
| MarkRoot of piece

type line = event list

(** val sel : line -> piece -> version option **)

let sel l p =
  fold_left (fun cur e ->
    match e with
    | Write (q, v) -> if eqs q p then Some v else cur
    | _ -> cur) l None

(** val written : line -> piece list **)

let written l =
  nodup (=)
    (flat_map (fun e -> match e with
                        | Write (q, _) -> q :: []
                        | _ -> []) l)

(** val is_written : line -> piece -> bool **)

let is_written l p =
  existsb (eqs p) (written l)

(** val shape_now : ontology -> line -> piece -> shape option **)

let shape_now o l p =
  match sel l p with
  | Some v -> o.shape_of p v
  | None -> None

(** val slots_of :
    ontology -> line -> piece -> ((string * piece) * bool) list **)

let slots_of o l p =
  match shape_now o l p with
  | Some s1 -> (match s1 with
                | Veritoid (_, _) -> []
                | Assembly (_, s) -> s)
  | None -> []

(** val fillers_of : ontology -> line -> piece -> piece list **)

let fillers_of o l p =
  map (fun s -> snd (fst s)) (slots_of o l p)

(** val preds_of : ontology -> line -> piece -> piece list **)

let preds_of o l p =
  match shape_now o l p with
  | Some s -> (match s with
               | Veritoid (_, ps) -> ps
               | Assembly (_, _) -> [])
  | None -> []

(** val roots : line -> piece list **)

let roots l =
  flat_map (fun e -> match e with
                     | MarkRoot a -> a :: []
                     | _ -> []) l

(** val evidence_of : line -> evidence list **)

let evidence_of l =
  flat_map (fun e -> match e with
                     | Evidence x -> x :: []
                     | _ -> []) l

(** val numbered : line -> (int * event) list **)

let numbered l =
  combine (seq 0 (length l)) l

(** val out_slots : ontology -> line -> piece -> piece list **)

let out_slots o l p =
  if is_written l p
  then flat_map (fun s -> if snd s then [] else (snd (fst s)) :: [])
         (slots_of o l p)
  else []

(** val slot_universe : ontology -> line -> piece list **)

let slot_universe o l =
  app (roots l) (flat_map (out_slots o l) (written l))

(** val canon : ontology -> line -> piece list **)

let canon o l =
  reach (out_slots o l) (roots l) (slot_universe o l)

(** val out_preds : ontology -> line -> piece -> piece list **)

let out_preds o l p =
  if is_written l p then preds_of o l p else []

(** val rests_on : ontology -> line -> piece -> piece list **)

let rests_on o l p =
  reach (out_preds o l) (preds_of o l p)
    (app (preds_of o l p) (flat_map (out_preds o l) (written l)))

(** val same : line -> string -> piece -> version -> version -> bool **)

let same l e p v w =
  (||) (eqs v w)
    (existsb (fun x ->
      match x with
      | Same (e', p', a, b) ->
        (&&) ((&&) (eqs e' e) (eqs p' p))
          ((||) ((&&) (eqs a v) (eqs b w)) ((&&) (eqs a w) (eqs b v)))
      | _ -> false) l)

(** val at_ : line -> string -> piece -> version -> bool **)

let at_ l e p v =
  match sel l p with
  | Some w -> same l e p v w
  | None -> false

(** val set_aside : line -> string -> bool **)

let set_aside l e =
  existsb (fun x -> match x with
                    | SetAside e' -> eqs e' e
                    | _ -> false) l

(** val applies : line -> evidence -> bool **)

let applies l x =
  (&&)
    ((&&) (negb (set_aside l x.e_name))
      (at_ l x.e_name x.e_piece x.e_version))
    (forallb (fun r -> at_ l x.e_name (fst r) (snd r)) x.e_reads)

(** val is_some : 'a1 option -> bool **)

let is_some = function
| Some _ -> true
| None -> false

(** val c1 : ontology -> line -> piece -> bool **)

let c1 o l p =
  forallb (fun q -> is_some (sel l q))
    (app (preds_of o l p) (fillers_of o l p))

(** val snap :
    line -> piece -> piece -> version option -> version option -> version
    option **)

let rec snap l p q curq shot =
  match l with
  | [] -> shot
  | e :: l' ->
    (match e with
     | Write (r, v) ->
       let curq' = if eqs r q then Some v else curq in
       snap l' p q curq' (if eqs r p then curq' else shot)
     | _ -> snap l' p q curq shot)

(** val written_against : line -> piece -> piece -> bool **)

let written_against l p q =
  match snap l p q None None with
  | Some a -> (match sel l q with
               | Some b -> eqs a b
               | None -> false)
  | None -> false

(** val affirmed : line -> piece -> piece -> bool **)

let affirmed l p q =
  match sel l p with
  | Some v ->
    (match sel l q with
     | Some w ->
       existsb (fun x ->
         match x with
         | Affirm (p', v', q', w') ->
           (&&) ((&&) ((&&) (eqs p' p) (eqs v' v)) (eqs q' q)) (eqs w' w)
         | _ -> false) l
     | None -> false)
  | None -> false

(** val c2 : ontology -> line -> piece -> bool **)

let c2 o l p =
  forallb (fun q -> (||) (written_against l p q) (affirmed l p q))
    (preds_of o l p)

(** val was_selected : line -> piece -> version -> bool **)

let was_selected l p v =
  existsb (fun x ->
    match x with
    | Write (p', v') -> (&&) (eqs p' p) (eqs v' v)
    | _ -> false) l

(** val c4 : line -> piece -> bool **)

let c4 l p =
  forallb (fun ie ->
    match snd ie with
    | Evidence f ->
      if (&&)
           ((&&) ((&&) (eqs f.e_piece p) (negb f.e_holds))
             (negb (set_aside l f.e_name)))
           (was_selected l p f.e_version)
      then (&&) (negb (applies l f))
             (existsb (fun jg ->
               match snd jg with
               | Evidence g ->
                 (&&)
                   ((&&)
                     ((&&)
                       ((&&) (Nat.ltb (fst ie) (fst jg)) (eqs g.e_piece p))
                       g.e_holds)
                     (eqs g.e_criterion f.e_criterion))
                   (applies l g)
               | _ -> false) (numbered l))
      else true
    | _ -> true) (numbered l)

(** val c5_asked : ontology -> line -> piece -> bool **)

let c5_asked o l p =
  match shape_now o l p with
  | Some s ->
    (match s with
     | Veritoid (is_claim, _) ->
       if is_claim
       then existsb (fun x ->
              (&&)
                ((&&) ((&&) (eqs x.e_piece p) (eqs x.e_criterion "valid"))
                  x.e_holds)
                (applies l x))
              (evidence_of l)
       else true
     | Assembly (is_result, _) ->
       if is_result
       then existsb (fun x ->
              (&&)
                ((&&)
                  ((&&) ((&&) (eqs x.e_piece p) (eqs x.e_criterion "whole"))
                    x.e_holds)
                  (applies l x))
                (forallb (fun q -> existsb (fun r -> eqs (fst r) q) x.e_reads)
                  (fillers_of o l p)))
              (evidence_of l)
       else true)
  | None -> true

(** val filler : ontology -> line -> piece -> string -> piece option **)

let filler o l p slot =
  match filter (fun s -> eqs (fst (fst s)) slot) (slots_of o l p) with
  | [] -> None
  | s :: _ -> Some (snd (fst s))

(** val looked : ontology -> line -> piece -> piece -> bool **)

let looked o l a b =
  (||)
    ((||) (affirmed l a b)
      (existsb (fun x ->
        (&&) ((&&) (eqs x.e_piece a) (applies l x))
          (existsb (fun r -> eqs (fst r) b) x.e_reads))
        (evidence_of l)))
    ((&&) o.write_looks (written_against l a b))

(** val c6 : ontology -> line -> piece -> bool **)

let c6 o l p =
  match shape_now o l p with
  | Some s ->
    (match s with
     | Veritoid (_, _) -> true
     | Assembly (is_result, _) ->
       if is_result
       then forallb (fun d ->
              match filler o l p (fst d) with
              | Some a ->
                (match filler o l p (snd d) with
                 | Some b -> looked o l a b
                 | None -> true)
              | None -> true) o.inner
       else true)
  | None -> true

(** val c8 : ontology -> line -> piece list -> string -> bool **)

let c8 o l am p =
  forallb (fun x ->
    match x with
    | Promise (a, slot) ->
      if eqs a p
      then (match filler o l p slot with
            | Some q -> existsb (eqs q) am
            | None -> false)
      else true
    | _ -> true) l

(** val c9 : line -> piece -> bool **)

let c9 l p =
  forallb (fun ie ->
    match snd ie with
    | Raise (p', criterion) ->
      if eqs p' p
      then existsb (fun jg ->
             match snd jg with
             | Evidence g ->
               (&&)
                 ((&&) ((&&) (Nat.ltb (fst ie) (fst jg)) (eqs g.e_piece p))
                   (eqs g.e_criterion criterion))
                 (applies l g)
             | _ -> false) (numbered l)
      else true
    | _ -> true) (numbered l)

(** val waived : line -> int -> piece -> bool **)

let waived l n p =
  existsb (fun x ->
    match x with
    | Waive (n', p') -> (&&) ((=) n' n) (eqs p' p)
    | _ -> false) l

(** val checks :
    ontology -> line -> piece list -> piece -> (int * bool) list **)

let checks o l am p =
  ((Stdlib.Int.succ 0), (c1 o l p)) :: (((Stdlib.Int.succ (Stdlib.Int.succ
    0)), (c2 o l p)) :: (((Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
    (Stdlib.Int.succ 0)))), (c4 l p)) :: (((Stdlib.Int.succ (Stdlib.Int.succ
    (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ 0))))),
    (c5_asked o l p)) :: (((Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
    (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ 0)))))),
    (c6 o l p)) :: (((Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
    (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
    (Stdlib.Int.succ 0)))))))), (c8 o l am p)) :: (((Stdlib.Int.succ
    (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
    (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
    0))))))))), (c9 l p)) :: []))))))

(** val own : ontology -> line -> piece list -> piece -> int list **)

let own o l am p =
  map fst
    (filter (fun nb -> (&&) (negb (snd nb)) (negb (waived l (fst nb) p)))
      (checks o l am p))

(** val c5_rests : ontology -> line -> string list -> piece -> bool **)

let c5_rests o l am p =
  forallb (fun q ->
    (&&) (existsb (eqs q) am)
      (match own o l am q with
       | [] -> true
       | _ :: _ -> false))
    (rests_on o l p)

(** val owed : ontology -> line -> piece list -> piece -> int list **)

let owed o l am p =
  let o0 = own o l am p in
  if (||)
       ((||) (c5_rests o l am p)
         (existsb
           ((=) (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
             (Stdlib.Int.succ (Stdlib.Int.succ 0))))))
           o0))
       (waived l (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
         (Stdlib.Int.succ (Stdlib.Int.succ 0))))) p)
  then o0
  else app
         (filter (fun n ->
           Nat.ltb n (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
             (Stdlib.Int.succ (Stdlib.Int.succ 0))))))
           o0)
         (app ((Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
           (Stdlib.Int.succ (Stdlib.Int.succ 0))))) :: [])
           (filter (fun n ->
             Nat.ltb (Stdlib.Int.succ (Stdlib.Int.succ (Stdlib.Int.succ
               (Stdlib.Int.succ (Stdlib.Int.succ 0))))) n)
             o0))

(** val frontier : ontology -> line -> (int * piece) list **)

let frontier o l =
  let am = canon o l in
  flat_map (fun p -> map (fun n -> (n, p)) (owed o l am p)) am

(** val shapes : piece -> version -> shape option **)

let shapes p _ =
  if eqs p "c"
  then Some (Veritoid (true, []))
  else if eqs p "u"
       then Some (Veritoid (true, ("c" :: [])))
       else if (||) ((||) (eqs p "d") (eqs p "e")) (eqs p "k")
            then Some (Veritoid (false, []))
            else if eqs p "T"
                 then Some (Assembly (true, ((("claim", "c"),
                        false) :: ((("derivation", "d"),
                        false) :: ((("description", "e"), false) :: ((("eli8",
                        "k"), false) :: []))))))
                 else if eqs p "U"
                      then Some (Assembly (true, ((("claim", "u"),
                             false) :: [])))
                      else if eqs p "O"
                           then Some (Assembly (false, ((("1", "T"),
                                  false) :: ((("2", "U"), false) :: []))))
                           else None

(** val ont : bool -> ontology **)

let ont write_looks0 =
  { shape_of = shapes; inner = (("description", "claim") :: (("eli8",
    "description") :: [])); write_looks = write_looks0 }

(** val ev :
    string -> piece -> version -> string -> bool -> (piece * version) list ->
    event **)

let ev name p v criterion holds reads =
  Evidence { e_name = name; e_piece = p; e_version = v; e_criterion =
    criterion; e_holds = holds; e_reads = reads }

(** val s0 : line **)

let s0 =
  (Write ("c", "c1")) :: ((Write ("d", "d1")) :: ((Write ("e",
    "e1")) :: ((Write ("k", "k1")) :: ((Write ("u", "u1")) :: ((Write ("T",
    "T1")) :: ((Write ("U", "U1")) :: ((Write ("O", "O1")) :: ((MarkRoot
    "O") :: ((ev "E1" "c" "c1" "valid" true (("d", "d1") :: [])) :: (
    (ev "E2" "u" "u1" "valid" true (("c", "c1") :: [])) :: ((ev "E3" "T" "T1"
                                                              "whole" true
                                                              (("c",
                                                              "c1") :: (("d",
                                                              "d1") :: (("e",
                                                              "e1") :: (("k",
                                                              "k1") :: []))))) :: (
    (ev "E4" "U" "U1" "whole" true (("u", "u1") :: [])) :: ((Affirm ("e",
    "e1", "c", "c1")) :: ((Affirm ("k", "k1", "e", "e1")) :: []))))))))))))))

(** val e5 : event **)

let e5 =
  ev "E5" "c" "c1" "caseX" false []

(** val e6 : event **)

let e6 =
  ev "E6" "c" "c1'" "valid" true (("d", "d1'") :: [])

(** val r0830 : event list **)

let r0830 =
  app s0 (e5 :: [])

(** val r0900 : event list **)

let r0900 =
  app r0830 ((Write ("c", "c1'")) :: ((Write ("d", "d1'")) :: (e6 :: [])))

(** val r1000 : event list **)

let r1000 =
  app r0830 (e6 :: [])

(** val r1030 : event list **)

let r1030 =
  app r1000 ((Write ("c", "c2")) :: ((Write ("d", "d2")) :: ((Write ("k",
    "k2")) :: ((Affirm ("e", "e1", "c", "c2")) :: []))))

(** val r1100 : event list **)

let r1100 =
  app r1030
    ((ev "E7" "c" "c2" "valid" true (("d", "d2") :: [])) :: ((ev "E8" "c" "c2"
                                                               "caseX" true
                                                               []) :: []))

(** val r1130 : event list **)

let r1130 =
  app r1100 ((Write ("d", "d3")) :: [])

(** val r1200 : event list **)

let r1200 =
  app r1130 ((ev "E9" "c" "c2" "valid" true (("d", "d3") :: [])) :: [])

(** val r1300 : event list **)

let r1300 =
  app r1200 ((Write ("u",
    "u2")) :: ((ev "E10" "u" "u2" "valid" true (("c", "c2") :: [])) :: []))

(** val r1400 : event list **)

let r1400 =
  app r1300
    ((ev "E11" "T" "T1" "whole" true (("c", "c2") :: (("d", "d3") :: (("e",
       "e1") :: (("k", "k2") :: []))))) :: ((ev "E12" "U" "U1" "whole" true
                                              (("u", "u2") :: [])) :: []))

(** val looks : ontology **)

let looks =
  ont true

(** val strict : ontology **)

let strict =
  ont false

type checkpoint = line

(** val close : ontology -> line -> checkpoint option **)

let close o l =
  match frontier o l with
  | [] -> Some l
  | _ :: _ -> None
