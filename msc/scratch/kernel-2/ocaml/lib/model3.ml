(* The kernel of KERNEL-SPEC draft 3 (9305775) as an executable model.

   No log and no fold: immutable versions, a set of facts, a selection, and
   nine constraints. Everything here is a pure function of (universe,
   selection, fact set). Section numbers refer to the spec. Places where the
   spec had to be read one way to be built are marked CHOICE and listed in
   ACCOUNT.md. *)

type id = int [@@deriving show, eq, ord]
type vid = int [@@deriving show, eq, ord]
type fid = int [@@deriving show, eq, ord]

(* §2 parameters *)
type relies = Existence | Assertions | Everything [@@deriving show, eq, ord]

type refkind = { rk_name : string; rests : bool; relies : relies }
[@@deriving show]

(* [Max]: highest level among criteria with holding evidence.
   [Max_unless_bad]: the same, but bottom while any failing evidence applies.
   [Odd]: 1 when an odd number of criteria hold; deliberately not monotone. *)
type read_as = Max | Max_unless_bad | Odd [@@deriving show, eq]

type dimension = {
  read_as : read_as;
  caps : int list;  (** reference kinds this dimension caps along *)
  levels : int array;  (** criterion -> the warrant a holding answer gives *)
}
[@@deriving show]

type akind = {
  slots : (string * bool) list;  (** name, required *)
  deps : (string * string) list;
      (** inner dependency: (a, b) = a depends on b *)
}
[@@deriving show]

type standard = By_decision | By_rule of (int * int) list | By_placement
[@@deriving show, eq]

type ontology = {
  dims : dimension array;
  refkinds : refkind array;
  akinds : akind array;
  standard : standard;
  guards : bool;  (** Q10 switch *)
  written_against : bool;  (** Q10 switch: C4's "written against counts" *)
}
[@@deriving show]

(* §3 objects *)
type reference = {
  rk : int;
  target : id;
  need : (int * int) option;  (** dimension, warrant *)
  against : vid option;  (** the target version this was written against *)
}
[@@deriving show, eq, ord]

type filler = Empty | Holds of id | Points of id [@@deriving show, eq, ord]

type version =
  | Veritoid of {
      content : int;
      asserts : (int * int) list;  (** dimension -> assertion token *)
      claims : (id * int * int) list;  (** piece, dimension, standing claimed *)
      reports : fid list;  (** decisions the content reports *)
      refs : reference list;
    }
  | Assembly of { ak : int; fill : (string * filler) list }
[@@deriving show, eq, ord]

type outcome = Holds_ | Fails | Part [@@deriving show, eq, ord]

type dkind = Accept | Affirm | Promise | Waive | Raise
[@@deriving show, eq, ord]

type inst =
  | C1_multi of id
  | C1_shape of id
  | C2 of id * string * string
  | C3_resolve of id * int
  | C3_cycle of id
  | C4 of id * int
  | C5_std of id
  | C5_rest of id * id
  | C6_fail of id * int * int
  | C6_guard of id * int * int
  | C6_conflict of id * int * int
  | C7_claim of id * int
  | C7_report of id * fid
  | C8_need of id * int
  | C8_promise of id * string * fid
  | C8_required of id * string
  | C9 of id * int * fid
[@@deriving show, eq, ord]

let inst_piece = function
  | C1_multi p
  | C1_shape p
  | C2 (p, _, _)
  | C3_resolve (p, _)
  | C3_cycle p
  | C4 (p, _)
  | C5_std p
  | C5_rest (p, _)
  | C6_fail (p, _, _)
  | C6_guard (p, _, _)
  | C6_conflict (p, _, _)
  | C7_claim (p, _)
  | C7_report (p, _)
  | C8_need (p, _)
  | C8_promise (p, _, _)
  | C8_required (p, _)
  | C9 (p, _, _) ->
      p

let inst_ctor = function
  | C1_multi _ -> "C1_multi"
  | C1_shape _ -> "C1_shape"
  | C2 _ -> "C2"
  | C3_resolve _ -> "C3_resolve"
  | C3_cycle _ -> "C3_cycle"
  | C4 _ -> "C4"
  | C5_std _ -> "C5_std"
  | C5_rest _ -> "C5_rest"
  | C6_fail _ -> "C6_fail"
  | C6_guard _ -> "C6_guard"
  | C6_conflict _ -> "C6_conflict"
  | C7_claim _ -> "C7_claim"
  | C7_report _ -> "C7_report"
  | C8_need _ -> "C8_need"
  | C8_promise _ -> "C8_promise"
  | C8_required _ -> "C8_required"
  | C9 _ -> "C9"

type subject =
  | Piece_at of id * vid
  | Slot of id * string
  | Pair of id * vid * id * vid
  | Inst of inst
  | Question of id * int
[@@deriving show, eq, ord]

type cond =
  | Selected_at of id * vid
  | Warrant_ge of id * int * int
  | Asserted_consistent of id
  | Slot_filled of id * string * filler
[@@deriving show, eq, ord]

type fact =
  | Evidence of { p : id; v : vid; d : int; crit : int; out : outcome }
  | Same of { x : id; v : vid; w : vid; for_ : fid }
  | Decision of { k : dkind; subj : subject; conds : cond list }
  | Withdrawn of fid
[@@deriving show, eq, ord]

type universe = {
  ont : ontology;
  versions : version array array;  (** id -> its versions *)
  descent : (id * id) list;  (** parent, child *)
  pool : fact array;
      (** every fact that may be in F; a fact's fid is its index *)
}

(* A selection. [sel.(p) = -1] when p is not selected. [asr_] is a bitmask of
   asserted ids, always a subset of the selected ones. *)
type sel = { sel : int array; asr_ : int }

let selected s p = s.sel.(p) >= 0
let asserted s p = s.asr_ land (1 lsl p) <> 0
let has f i = f land (1 lsl i) <> 0
let nids u = Array.length u.versions
let iter_facts u f k = Array.iteri (fun i fa -> if has f i then k i fa) u.pool

let exists_fact u f k =
  let r = ref false in
  iter_facts u f (fun i fa -> if (not !r) && k i fa then r := true);
  !r

(* §4: versions v and w of x do not differ for the purposes of fact [fid].
   CHOICE: same is symmetric and chains. *)
let reach u f fid x v w =
  if v = w then true
  else
    let n = Array.length u.versions.(x) in
    if v < 0 || w < 0 || v >= n || w >= n then false
    else
      let seen = Array.make n false in
      let rec go v =
        if not seen.(v) then (
          seen.(v) <- true;
          iter_facts u f (fun _ fa ->
              match fa with
              | Same s when s.for_ = fid && s.x = x ->
                  if s.v = v && s.w < n then go s.w
                  else if s.w = v && s.v < n then go s.v
              | _ -> ()))
      in
      go v;
      seen.(w)

let withdrawn u f fid =
  exists_fact u f (fun _ fa ->
      match fa with Withdrawn g -> g = fid | _ -> false)

let rec ancestors u p =
  List.concat_map
    (fun (a, c) -> if c = p then a :: ancestors u a else [])
    u.descent
  |> List.sort_uniq compare

let descendants u p =
  List.filter (fun q -> List.mem p (ancestors u q)) (List.init (nids u) Fun.id)

(* C3: a reference resolves to its target if selected, else to its one
   selected descendant. CHOICE: "one" is read as exactly one. *)
let resolve u s q =
  if selected s q then Some q
  else
    match List.filter (selected s) (descendants u q) with
    | [ d ] -> Some d
    | _ -> None

(* Evidence applying to p on d: (criterion, outcome) pairs. *)
let applying u f s p d =
  let acc = ref [] in
  if selected s p then
    iter_facts u f (fun i fa ->
        match fa with
        | Evidence e when e.p = p && e.d = d && reach u f i p e.v s.sel.(p) ->
            acc := (e.crit, e.out) :: !acc
        | _ -> ());
  !acc

let warrant u f s p d =
  let ev = applying u f s p d in
  let dim = u.ont.dims.(d) in
  let holds =
    List.sort_uniq compare
      (List.filter_map (fun (c, o) -> if o = Holds_ then Some c else None) ev)
  in
  let bad = List.exists (fun (_, o) -> o <> Holds_) ev in
  let top = List.fold_left (fun m c -> max m dim.levels.(c)) 0 holds in
  match dim.read_as with
  | Max -> top
  | Max_unless_bad -> if bad then 0 else top
  | Odd -> List.length holds mod 2

let refs_of u s p =
  if not (selected s p) then []
  else
    match u.versions.(p).(s.sel.(p)) with
    | Veritoid v -> v.refs
    | Assembly _ -> []

let rec effective ?(path = []) u f s p d =
  if (not (selected s p)) || List.mem p path then 0
  else
    List.fold_left
      (fun w r ->
        if List.mem r.rk u.ont.dims.(d).caps then
          match resolve u s r.target with
          | None -> 0
          | Some q -> min w (effective ~path:(p :: path) u f s q d)
        else w)
      (warrant u f s p d) (refs_of u s p)

let on_cycle u s p =
  let capping rk = Array.exists (fun dm -> List.mem rk dm.caps) u.ont.dims in
  let rec go seen q =
    List.exists
      (fun r ->
        capping r.rk
        &&
        match resolve u s r.target with
        | None -> false
        | Some t -> t = p || ((not (List.mem t seen)) && go (t :: seen) t))
      (refs_of u s q)
  in
  go [ p ] p

(* Guards on p: criteria of any failing or partial evidence about p at any
   version, or about any id p descends from. *)
let guards u f p =
  let ids = p :: ancestors u p in
  let acc = ref [] in
  iter_facts u f (fun _ fa ->
      match fa with
      | Evidence e when e.out <> Holds_ && List.mem e.p ids ->
          acc := (e.d, e.crit) :: !acc
      | _ -> ());
  List.sort_uniq compare !acc

(* §4: a decision holds. [x] is the bitmask of pieces assumed consistent. *)
let decision_holds u f s x fid =
  fid >= 0
  && fid < Array.length u.pool
  && has f fid
  && (not (withdrawn u f fid))
  &&
  match u.pool.(fid) with
  | Decision d ->
      List.for_all
        (function
          | Selected_at (p, v) -> selected s p && reach u f fid p v s.sel.(p)
          | Warrant_ge (p, dm, w) -> selected s p && warrant u f s p dm >= w
          | Asserted_consistent p -> asserted s p && has x p
          | Slot_filled (a, slot, fl) -> (
              selected s a
              &&
              match u.versions.(a).(s.sel.(a)) with
              | Assembly asm -> List.assoc_opt slot asm.fill = Some fl
              | Veritoid _ -> false))
        d.conds
  | _ -> false

let cond_pieces conds =
  List.map
    (function
      | Selected_at (p, _)
      | Warrant_ge (p, _, _)
      | Asserted_consistent p
      | Slot_filled (p, _, _) ->
          p)
    conds

(* Accept decisions offered for p at its selected version (not withdrawn). *)
let accepts_for u f s p =
  let acc = ref [] in
  if selected s p then
    iter_facts u f (fun i fa ->
        match fa with
        | Decision { k = Accept; subj = Piece_at (q, v); conds }
          when q = p && (not (withdrawn u f i)) && reach u f i p v s.sel.(p) ->
            acc := (i, conds) :: !acc
        | _ -> ());
  !acc

(* What p rests on. References by a resting kind; and, under the decision
   standard, the pieces its accept decisions have conditions about. *)
let rests_refs u s p ~strict =
  List.filter_map
    (fun r ->
      let k = u.ont.refkinds.(r.rk) in
      if k.rests && ((not strict) || k.relies <> Existence) then
        Some (match resolve u s r.target with Some q -> q | None -> r.target)
      else None)
    (refs_of u s p)

let rests_all u f s p =
  let dec =
    if u.ont.standard = By_decision then
      List.concat_map (fun (_, c) -> cond_pieces c) (accepts_for u f s p)
    else []
  in
  List.sort_uniq compare
    (List.filter (( <> ) p) (rests_refs u s p ~strict:false @ dec))

let asserts_of u p v =
  match u.versions.(p).(v) with Veritoid x -> x.asserts | Assembly _ -> []

(* Is an affirm decision on record, holding, for (a at its selected version,
   b as far as [rel] relies on it at its selected version), up to same? *)
let affirmed u f s x a b rel =
  exists_fact u f (fun i fa ->
      match fa with
      | Decision { k = Affirm; subj = Pair (a', va, b', vb); _ }
        when a' = a && b' = b ->
          decision_holds u f s x i
          && reach u f i a va s.sel.(a)
          && (reach u f i b vb s.sel.(b)
             || rel = Assertions && vb >= 0
                && vb < Array.length u.versions.(b)
                && asserts_of u b vb = asserts_of u b s.sel.(b))
      | _ -> false)

(* §5: the violated instances, given an assumption [x] about which asserted
   pieces are consistent. *)
let violated u f s x =
  let acc = ref [] in
  let add i = acc := i :: !acc in
  let n = nids u in
  for p = 0 to n - 1 do
    if asserted s p then (
      (* C1 *)
      let holders = ref 0 in
      for q = 0 to n - 1 do
        if selected s q then
          match u.versions.(q).(s.sel.(q)) with
          | Assembly a ->
              if List.exists (fun (_, fl) -> fl = Holds p) a.fill then
                incr holders
          | Veritoid _ -> ()
      done;
      if !holders >= 2 then add (C1_multi p);
      (match u.versions.(p).(s.sel.(p)) with
      | Assembly a ->
          let k = u.ont.akinds.(a.ak) in
          let names l = List.sort compare (List.map fst l) in
          if names a.fill <> names k.slots then add (C1_shape p);
          let filler nm =
            match List.assoc_opt nm a.fill with
            | Some (Holds q) | Some (Points q) -> Some q
            | _ -> None
          in
          (* C2 *)
          List.iter
            (fun (sa, sb) ->
              match (filler sa, filler sb) with
              | Some fa, Some fb when selected s fa && selected s fb ->
                  if not (affirmed u f s x fa fb Everything) then
                    add (C2 (p, sa, sb))
              | _ -> ())
            k.deps;
          (* C8, slots *)
          List.iter
            (fun (nm, req) ->
              let ok =
                match filler nm with
                | Some q -> asserted s q && has x q
                | None -> false
              in
              if req && not ok then add (C8_required (p, nm));
              iter_facts u f (fun i fa ->
                  match fa with
                  | Decision { k = Promise; subj = Slot (a', nm'); _ }
                    when a' = p && nm' = nm ->
                      if decision_holds u f s x i && not ok then
                        add (C8_promise (p, nm, i))
                  | _ -> ()))
            k.slots
      | Veritoid v ->
          List.iteri
            (fun i r ->
              let k = u.ont.refkinds.(r.rk) in
              match resolve u s r.target with
              | None -> add (C3_resolve (p, i))
              | Some q -> (
                  (* C4 *)
                  (if k.relies <> Existence then
                     let written =
                       u.ont.written_against && q = r.target
                       &&
                       match r.against with
                       | Some w ->
                           w = s.sel.(q)
                           || k.relies = Assertions
                              && w < Array.length u.versions.(q)
                              && asserts_of u q w = asserts_of u q s.sel.(q)
                       | None -> false
                     in
                     if not (written || affirmed u f s x p q k.relies) then
                       add (C4 (p, i)));
                  (* C8, need *)
                  match r.need with
                  | Some (d, w) ->
                      if w > effective u f s q d then add (C8_need (p, i))
                  | None -> ()))
            v.refs;
          if on_cycle u s p then add (C3_cycle p);
          (* C7 *)
          List.iteri
            (fun i (q, d, w) ->
              if w > effective u f s q d then add (C7_claim (p, i)))
            v.claims;
          List.iter
            (fun fid ->
              if not (decision_holds u f s x fid) then add (C7_report (p, fid)))
            v.reports);
      (* C5. CHOICE: under the decision standard, C5 is met when SOME accept
         decision holds and everything that decision has a condition about is
         asserted and consistent. *)
      let ok q = asserted s q && has x q in
      (match u.ont.standard with
      | By_placement -> ()
      | By_rule l ->
          if not (List.for_all (fun (d, w) -> warrant u f s p d >= w) l) then
            add (C5_std p)
      | By_decision ->
          if
            not
              (List.exists
                 (fun (i, conds) ->
                   decision_holds u f s x i
                   && List.for_all (fun q -> q = p || ok q) (cond_pieces conds))
                 (accepts_for u f s p))
          then add (C5_std p));
      List.iter
        (fun q -> if q <> p && not (ok q) then add (C5_rest (p, q)))
        (rests_refs u s p ~strict:true);
      (* C6 *)
      Array.iteri
        (fun d _ ->
          let ev = applying u f s p d in
          let crits = List.sort_uniq compare (List.map fst ev) in
          List.iter
            (fun c ->
              let outs =
                List.sort_uniq compare
                  (List.filter_map
                     (fun (c', o) -> if c' = c then Some o else None)
                     ev)
              in
              if List.exists (( <> ) Holds_) outs then add (C6_fail (p, d, c));
              if List.length outs > 1 then add (C6_conflict (p, d, c)))
            crits;
          if u.ont.guards then
            List.iter
              (fun (d', c) ->
                if d' = d && not (List.mem (c, Holds_) ev) then
                  add (C6_guard (p, d, c)))
              (guards u f p))
        u.ont.dims;
      (* C9 *)
      iter_facts u f (fun i fa ->
          match fa with
          | Decision { k = Raise; subj = Question (q, d); _ }
            when q = p && d < Array.length u.ont.dims ->
              if decision_holds u f s x i && applying u f s p d = [] then
                add (C9 (p, d, i))
          | _ -> ()))
  done;
  List.sort_uniq compare !acc

(* §4 consistency. T(X) = asserted pieces with no violated instance under X.
   (C5_rest already carries "everything it rests on is consistent".) *)
let step u f s x =
  let v = violated u f s x in
  let bad = List.fold_left (fun m i -> m lor (1 lsl inst_piece i)) 0 v in
  s.asr_ land lnot bad

(* All fixed points, by brute force over subsets of the asserted pieces. *)
let fixpoints u f s =
  let rec subsets m =
    if m = 0 then [ 0 ]
    else
      let low = m land -m in
      let rest = subsets (m lxor low) in
      rest @ List.map (fun r -> r lor low) rest
  in
  List.filter (fun x -> step u f s x = x) (subsets s.asr_)

type gfp = Greatest of int | No_fixpoint | No_greatest of int list

let gfp_brute u f s =
  match fixpoints u f s with
  | [] -> No_fixpoint
  | fps ->
      let top = List.fold_left ( lor ) 0 fps in
      if List.mem top fps then Greatest top else No_greatest fps

(* Iteration from the top; the greatest fixed point when T is monotone. *)
let gfp_iter u f s =
  let rec go x k =
    let x' = step u f s x in
    if x' = x then Some x else if k = 0 then None else go x' (k - 1)
  in
  go s.asr_ (nids u + 2)

type frontier = { x : int; viol : inst list; uncovered : inst list }

let covered u f s x inst =
  exists_fact u f (fun i fa ->
      match fa with
      | Decision { k = Waive; subj = Inst j; _ } ->
          j = inst && decision_holds u f s x i
      | _ -> false)

let frontier u f s =
  match gfp_iter u f s with
  | None -> None
  | Some x ->
      let viol = violated u f s x in
      Some
        {
          x;
          viol;
          uncovered = List.filter (fun i -> not (covered u f s x i)) viol;
        }

let stationary u f s =
  match frontier u f s with Some fr -> fr.uncovered = [] | None -> false

let rests_closure u f s set =
  let rec go seen = function
    | [] -> seen
    | p :: rest ->
        if List.mem p seen then go seen rest
        else go (p :: seen) (rests_all u f s p @ rest)
  in
  go [] set

(* §5: stationary on a set of pieces. *)
let stationary_on u f s set =
  match frontier u f s with
  | None -> false
  | Some fr ->
      let cl = rests_closure u f s set in
      not (List.exists (fun i -> List.mem (inst_piece i) cl) fr.uncovered)

(* The pieces a fact is about. *)
let rec fact_pieces u i =
  if i < 0 || i >= Array.length u.pool then []
  else
    match u.pool.(i) with
    | Evidence e -> [ e.p ]
    | Same s -> s.x :: fact_pieces_shallow u s.for_
    | Withdrawn g -> fact_pieces_shallow u g
    | Decision _ -> fact_pieces_shallow u i

and fact_pieces_shallow u i =
  if i < 0 || i >= Array.length u.pool then []
  else
    match u.pool.(i) with
    | Evidence e -> [ e.p ]
    | Same s -> [ s.x ]
    | Withdrawn _ -> []
    | Decision d ->
        (match d.subj with
          | Piece_at (p, _) | Slot (p, _) | Question (p, _) -> [ p ]
          | Pair (p, _, q, _) -> [ p; q ]
          | Inst j -> [ inst_piece j ])
        @ cond_pieces d.conds
