(* The kernel of KERNEL-SPEC draft 4 (5e2cffd) as an executable model.

   An ordered, additive base of events. A universe fixes a pool of events,
   each with a time (its index in the pool). A line, together with the part
   of the base it can see, is a SET of pool events (a bitmask); order comes
   from the times. Everything below is a pure function of (universe, mask).

   Places where the spec had to be read one way are marked CHOICE and listed
   in ACCOUNT.md §4. *)

type id = int [@@deriving show, eq, ord]
type vid = int [@@deriving show, eq, ord]
type eid = int [@@deriving show, eq, ord]

(* §2 *)
type relies = Existence | Assertions | Everything [@@deriving show, eq, ord]

type refkind = { rk_name : string; rests : bool; relies : relies }
[@@deriving show]

type read_as = Max | Max_unless_bad | Odd [@@deriving show, eq]

type dimension = {
  read_as : read_as;
  caps : int list;
  levels : int array;  (** criterion -> warrant when it holds *)
  decided : bool;  (** answered by accept decisions, not by evidence *)
}
[@@deriving show]

type akind = { slots : (string * bool) list; deps : (string * string) list }
[@@deriving show]

type ontology = {
  dims : dimension array;
  refkinds : refkind array;
  akinds : akind array;
  asks : (int * int * int) list;
      (** what a root of this assembly kind asks: (kind, dimension, least
          warrant) *)
  write_affirms : bool;  (** C4 switch *)
  guard_from_last : bool;
      (** CHOICE switch: "at or after v" counted from the last time the line
          selected v (true) or the first (false) *)
}
[@@deriving show]

(* §3 *)
type reference = { rk : int; target : id; need : (int * int) option }
[@@deriving show, eq, ord]

type filler = Empty | Holds of id | Points of id [@@deriving show, eq, ord]

type version =
  | Veritoid of {
      content : int;
      asserts : (int * int) list;
      claims : (id * int * int) list;
      reports : eid list;
      refs : reference list;
    }
  | Assembly of { ak : int; fill : (string * filler * bool) list }
      (** slot, filler, provisional *)
[@@deriving show, eq, ord]

type outcome = Holds_ | Fails | Part [@@deriving show, eq, ord]

type inst =
  | C1 of id * id
      (** assembly, an id it holds that another assembly also holds *)
  | C2 of id * string * string
  | C3_ref of id * int
  | C3_slot of id * string
  | C3_cycle of id
  | C4 of id * int
  | C5_ask of id * id * int  (** piece, root, dimension *)
  | C5_rest of id * id
  | C6_finding of id * eid
  | C6_guard of id * eid
  | C7_claim of id * int
  | C7_report of id * eid
  | C8_need of id * int
  | C8_slot of id * string
  | C9 of id * eid
[@@deriving show, eq, ord]

let inst_piece = function
  | C1 (p, _)
  | C2 (p, _, _)
  | C3_ref (p, _)
  | C3_slot (p, _)
  | C3_cycle p
  | C4 (p, _)
  | C5_ask (p, _, _)
  | C5_rest (p, _)
  | C6_finding (p, _)
  | C6_guard (p, _)
  | C7_claim (p, _)
  | C7_report (p, _)
  | C8_need (p, _)
  | C8_slot (p, _)
  | C9 (p, _) ->
      p

let inst_ctor = function
  | C1 _ -> "C1"
  | C2 _ -> "C2"
  | C3_ref _ -> "C3_ref"
  | C3_slot _ -> "C3_slot"
  | C3_cycle _ -> "C3_cycle"
  | C4 _ -> "C4"
  | C5_ask _ -> "C5_ask"
  | C5_rest _ -> "C5_rest"
  | C6_finding _ -> "C6_finding"
  | C6_guard _ -> "C6_guard"
  | C7_claim _ -> "C7_claim"
  | C7_report _ -> "C7_report"
  | C8_need _ -> "C8_need"
  | C8_slot _ -> "C8_slot"
  | C9 _ -> "C9"

type cond =
  | Selected_at of id * vid
  | Warrant_ge of id * int * int
  | Asserted_consistent of id
[@@deriving show, eq, ord]

type event =
  (* on a line *)
  | Write of { p : id; v : vid }
  | Retire of { p : id; into : id list }
  | Accept of { p : id; v : vid; d : int; conds : cond list }
  | Affirm of { p : id; v : vid; q : id; w : vid; conds : cond list }
  | Promise of id * string
  | Waive of inst
  | Raise of id * int
  | Set_aside of eid
  | Mark_root of id
  | Unmark_root of id
  | Withdraw of eid
  (* in the base *)
  | Evidence of {
      p : id;
      v : vid;
      d : int;
      crit : int;
      out : outcome;
      reads : (id * vid * relies) list;
    }
  | Same of { x : id; v : vid; w : vid; for_ : eid }
[@@deriving show, eq, ord]

let is_base = function Evidence _ | Same _ -> true | _ -> false

type universe = {
  ont : ontology;
  versions : version array array;
  pool : event array;
}

let nids u = Array.length u.versions
let has s i = i >= 0 && s land (1 lsl i) <> 0
let upto i = (1 lsl (i + 1)) - 1
let npool u = Array.length u.pool

let fold_events u s f init =
  let acc = ref init in
  Array.iteri (fun i e -> if has s i then acc := f !acc i e) u.pool;
  !acc

let exists_event u s f = fold_events u s (fun a i e -> a || f i e) false

(* a decision or set-aside at i is withdrawn by a later withdraw on the line *)
let withdrawn u s i =
  exists_event u s (fun j e ->
      match e with Withdraw k -> k = i && j > i | _ -> false)

let live u s i = has s i && not (withdrawn u s i)

let set_aside u s i =
  exists_event u s (fun j e ->
      match e with Set_aside k -> k = i && not (withdrawn u s j) | _ -> false)

(* §3: the selected version of p: its latest write, unless retired since. *)
let sel u s p =
  fold_events u s
    (fun cur _ e ->
      match e with
      | Write w when w.p = p -> w.v
      | Retire r when r.p = p -> -1
      | _ -> cur)
    (-1)

(* the order in which p's versions were selected on the line: (time, version) *)
let history u s p =
  List.rev
    (fold_events u s
       (fun acc i e ->
         match e with Write w when w.p = p -> (i, w.v) :: acc | _ -> acc)
       [])

let rec ancestors u s p =
  fold_events u s
    (fun acc _ e ->
      match e with
      | Retire r when List.mem p r.into && r.p <> p && not (List.mem r.p acc) ->
          (r.p :: ancestors u s r.p) @ acc
      | _ -> acc)
    []
  |> List.sort_uniq compare

let reach u s fid x v w =
  if v = w then true
  else
    let n = Array.length u.versions.(x) in
    if v < 0 || w < 0 || v >= n || w >= n then false
    else
      let seen = Array.make n false in
      let rec go v =
        if not seen.(v) then (
          seen.(v) <- true;
          Array.iteri
            (fun i e ->
              if has s i && not (set_aside u s i) then
                match e with
                | Same sm when sm.for_ = fid && sm.x = x ->
                    if sm.v = v && sm.w < n then go sm.w
                    else if sm.w = v && sm.v < n then go sm.v
                | _ -> ())
            u.pool)
      in
      go v;
      seen.(w)

let asserts_of u p v =
  if v < 0 || v >= Array.length u.versions.(p) then []
  else
    match u.versions.(p).(v) with Veritoid x -> x.asserts | Assembly _ -> []

(* §4: evidence applies. *)
let applies u s i =
  has s i
  && (not (set_aside u s i))
  &&
  match u.pool.(i) with
  | Evidence e ->
      let cur = sel u s e.p in
      cur >= 0 && reach u s i e.p e.v cur
      && List.for_all
           (fun (q, w, rel) ->
             let c = sel u s q in
             c >= 0
             && (rel = Existence || reach u s i q w c
                || (rel = Assertions && asserts_of u q w = asserts_of u q c)))
           e.reads
  | _ -> false

(* "provided that evidence applied when recorded": in the line as it stood at
   the evidence's own time. CHOICE: and it has not been set aside since. *)
let applied_when_recorded u s i =
  applies u (s land upto i) i && not (set_aside u s i)

let applying u s p d =
  fold_events u s
    (fun acc i e ->
      match e with
      | Evidence ev when ev.p = p && ev.d = d && applies u s i ->
          (i, ev.crit, ev.out) :: acc
      | _ -> acc)
    []

let cond_pieces conds =
  List.map
    (function
      | Selected_at (p, _) | Warrant_ge (p, _, _) | Asserted_consistent p -> p)
    conds

let refs_of u s p =
  let c = sel u s p in
  if c < 0 then []
  else match u.versions.(p).(c) with Veritoid v -> v.refs | Assembly _ -> []

(* canon: reachable from a marked root through filled, non-provisional slots *)
let marked u s r =
  fold_events u s
    (fun cur _ e ->
      match e with
      | Mark_root x when x = r -> true
      | Unmark_root x when x = r -> false
      | _ -> cur)
    false

let reached_from u s r =
  let rec go seen p =
    if List.mem p seen || sel u s p < 0 then seen
    else
      let seen = p :: seen in
      match u.versions.(p).(sel u s p) with
      | Assembly a ->
          List.fold_left
            (fun seen (_, fl, prov) ->
              match fl with
              | (Holds q | Points q) when not prov -> go seen q
              | _ -> seen)
            seen a.fill
      | Veritoid _ -> seen
  in
  if marked u s r then go [] r else []

let roots u s = List.filter (marked u s) (List.init (nids u) Fun.id)

let asserted_mask u s =
  List.fold_left
    (fun m r ->
      List.fold_left (fun m p -> m lor (1 lsl p)) m (reached_from u s r))
    0 (roots u s)

let rec warrant u s x p d =
  let dim = u.ont.dims.(d) in
  if sel u s p < 0 then 0
  else if dim.decided then
    if
      exists_event u s (fun i e ->
          match e with
          | Accept a when a.p = p && a.d = d -> decision_holds u s x i
          | _ -> false)
    then 1
    else 0
  else
    let ev = applying u s p d in
    let holds =
      List.sort_uniq compare
        (List.filter_map
           (fun (_, c, o) -> if o = Holds_ then Some c else None)
           ev)
    in
    let bad = List.exists (fun (_, _, o) -> o <> Holds_) ev in
    let top = List.fold_left (fun m c -> max m dim.levels.(c)) 0 holds in
    match dim.read_as with
    | Max -> top
    | Max_unless_bad -> if bad then 0 else top
    | Odd -> List.length holds mod 2

(* [x]: bitmask of pieces assumed consistent; [am]: the asserted pieces are
   read from the state. *)
and decision_holds u s x i =
  live u s i
  &&
  let conds_ok conds =
    List.for_all
      (function
        | Selected_at (p, v) -> sel u s p >= 0 && reach u s i p v (sel u s p)
        | Warrant_ge (p, d, w) ->
            (* CHOICE: a condition on a decided dimension's warrant could loop
               through this very decision; such a condition reads false. *)
            (not u.ont.dims.(d).decided) && warrant u s x p d >= w
        | Asserted_consistent p -> has (asserted_mask u s) p && has x p)
      conds
  in
  match u.pool.(i) with
  | Accept a ->
      sel u s a.p >= 0 && reach u s i a.p a.v (sel u s a.p) && conds_ok a.conds
  | Affirm a ->
      sel u s a.p >= 0 && reach u s i a.p a.v (sel u s a.p) && conds_ok a.conds
  | Promise _ | Waive _ | Raise _ | Set_aside _ | Mark_root _ | Unmark_root _ ->
      true
  | _ -> false

let rec effective ?(path = []) u s x p d =
  if sel u s p < 0 || List.mem p path then 0
  else
    List.fold_left
      (fun w r ->
        if List.mem r.rk u.ont.dims.(d).caps then
          min w (effective ~path:(p :: path) u s x r.target d)
        else w)
      (warrant u s x p d) (refs_of u s p)

let on_cycle u s p =
  let capping rk = Array.exists (fun dm -> List.mem rk dm.caps) u.ont.dims in
  let rec go seen q =
    List.exists
      (fun r ->
        capping r.rk
        && sel u s r.target >= 0
        && (r.target = p
           || ((not (List.mem r.target seen)) && go (r.target :: seen) r.target)
           ))
      (refs_of u s q)
  in
  go [ p ] p

(* §4 guards, with order. The findings whose guard on p is unmet. *)
let unmet_guards u s p =
  let cur = sel u s p in
  let anc = ancestors u s p in
  fold_events u s
    (fun acc i e ->
      match e with
      | Evidence f
        when f.out <> Holds_
             && (f.p = p || List.mem f.p anc)
             && not (set_aside u s i) ->
          let hist = history u s f.p in
          let times =
            List.filter_map
              (fun (t, v) -> if v = f.v then Some t else None)
              hist
          in
          if times = [] then acc (* the line never selected that version *)
          else if f.p = p && reach u s i p f.v cur then acc
            (* it applies outright: C6_finding *)
          else
            let t0 =
              if u.ont.guard_from_last then List.fold_left max 0 times
              else List.fold_left min max_int times
            in
            let met =
              exists_event u s (fun j h ->
                  match h with
                  | Evidence g
                    when g.out = Holds_ && g.d = f.d && g.crit = f.crit ->
                      applied_when_recorded u s j
                      && (g.p = f.p
                          && List.exists (fun (t, v) -> v = g.v && t >= t0) hist
                         || (g.p = p && f.p <> p))
                  | _ -> false)
            in
            if met then acc else i :: acc
      | _ -> acc)
    []

let affirmed u s x a b rel =
  exists_event u s (fun i e ->
      match e with
      | Affirm f when f.p = a && f.q = b ->
          decision_holds u s x i
          && (reach u s i b f.w (sel u s b)
             || rel = Assertions
                && asserts_of u b f.w = asserts_of u b (sel u s b))
      | _ -> false)

(* C4 switch: a write of p counts as affirming p's references as they then
   stood. *)
let written_against u s p q rel =
  u.ont.write_affirms
  &&
  match List.rev (history u s p) with
  | (t, _) :: _ ->
      let then_ = sel u (s land upto t) q and now = sel u s q in
      then_ >= 0
      && (then_ = now
         || (rel = Assertions && asserts_of u q then_ = asserts_of u q now))
  | [] -> false

let violated u s x =
  let acc = ref [] in
  let add i = acc := i :: !acc in
  let n = nids u in
  let am = asserted_mask u s in
  let rts = List.map (fun r -> (r, reached_from u s r)) (roots u s) in
  for p = 0 to n - 1 do
    if has am p then (
      let c = sel u s p in
      (match u.versions.(p).(c) with
      | Assembly a ->
          let k = u.ont.akinds.(a.ak) in
          let filler nm =
            List.find_map
              (fun (n', fl, _) ->
                if n' = nm then
                  match fl with Holds q | Points q -> Some q | Empty -> None
                else None)
              a.fill
          in
          (* C1 *)
          List.iter
            (fun (_, fl, _) ->
              match fl with
              | Holds q ->
                  let other = ref false in
                  for b = 0 to n - 1 do
                    if b <> p && sel u s b >= 0 then
                      match u.versions.(b).(sel u s b) with
                      | Assembly o ->
                          if List.exists (fun (_, f, _) -> f = Holds q) o.fill
                          then other := true
                      | Veritoid _ -> ()
                  done;
                  if !other then add (C1 (p, q))
              | _ -> ())
            a.fill;
          (* C2 *)
          List.iter
            (fun (sa, sb) ->
              match (filler sa, filler sb) with
              | Some fa, Some fb when sel u s fa >= 0 && sel u s fb >= 0 ->
                  let read_by a b =
                    exists_event u s (fun i e ->
                        match e with
                        | Evidence ev when ev.p = a ->
                            applies u s i
                            && List.exists (fun (q, _, _) -> q = b) ev.reads
                        | _ -> false)
                  in
                  if
                    not
                      (affirmed u s x fa fb Everything
                      || read_by fa fb || read_by fb fa)
                  then add (C2 (p, sa, sb))
              | _ -> ())
            k.deps;
          (* C3 for a pointing slot; C8 for required and promised slots *)
          List.iter
            (fun (nm, fl, _) ->
              match fl with
              | Points q when sel u s q < 0 -> add (C3_slot (p, nm))
              | _ -> ())
            a.fill;
          List.iter
            (fun (nm, req) ->
              let promised =
                exists_event u s (fun i e ->
                    match e with
                    | Promise (a', nm') -> a' = p && nm' = nm && live u s i
                    | _ -> false)
              in
              let ok =
                match filler nm with Some q -> has am q | None -> false
              in
              if (req || promised) && not ok then add (C8_slot (p, nm)))
            k.slots
      | Veritoid v ->
          List.iteri
            (fun i r ->
              let k = u.ont.refkinds.(r.rk) in
              if sel u s r.target < 0 then add (C3_ref (p, i))
              else (
                if
                  k.relies <> Existence
                  && not
                       (written_against u s p r.target k.relies
                       || affirmed u s x p r.target k.relies)
                then add (C4 (p, i));
                match r.need with
                | Some (d, w) ->
                    if w > effective u s x r.target d then add (C8_need (p, i))
                | None -> ()))
            v.refs;
          if on_cycle u s p then add (C3_cycle p);
          List.iteri
            (fun i (q, d, w) ->
              if w > effective u s x q d then add (C7_claim (p, i)))
            v.claims;
          List.iter
            (fun e ->
              if not (decision_holds u s x e) then add (C7_report (p, e)))
            v.reports;
          (* C5, what its roots ask *)
          List.iter
            (fun (r, reached) ->
              if List.mem p reached then
                match u.versions.(r).(sel u s r) with
                | Assembly ra ->
                    List.iter
                      (fun (ak, d, w) ->
                        if ak = ra.ak && effective u s x p d < w then
                          add (C5_ask (p, r, d)))
                      u.ont.asks
                | Veritoid _ -> ())
            rts);
      (* C5, what it rests on *)
      List.iter
        (fun r ->
          let k = u.ont.refkinds.(r.rk) in
          if k.rests && k.relies <> Existence && r.target <> p then
            if not (has am r.target && has x r.target) then
              add (C5_rest (p, r.target)))
        (refs_of u s p);
      (* C6 *)
      Array.iteri
        (fun d _ ->
          List.iter
            (fun (i, _, o) -> if o <> Holds_ then add (C6_finding (p, i)))
            (applying u s p d))
        u.ont.dims;
      List.iter (fun i -> add (C6_guard (p, i))) (unmet_guards u s p);
      (* C9 *)
      Array.iteri
        (fun i e ->
          match e with
          | Raise (q, d) when q = p && live u s i ->
              if not (List.exists (fun (j, _, _) -> j > i) (applying u s p d))
              then add (C9 (p, i))
          | _ -> ())
        u.pool)
  done;
  List.sort_uniq compare !acc

let covered u s inst =
  exists_event u s (fun i e ->
      match e with Waive j -> j = inst && live u s i | _ -> false)

(* T(X): asserted pieces with no uncovered violated instance under X.
   (§5: a waived instance does not make its piece inconsistent.) *)
let step u s x =
  let bad =
    List.fold_left
      (fun m i -> if covered u s i then m else m lor (1 lsl inst_piece i))
      0 (violated u s x)
  in
  asserted_mask u s land lnot bad

let fixpoints u s =
  let rec subsets m =
    if m = 0 then [ 0 ]
    else
      let low = m land -m in
      let rest = subsets (m lxor low) in
      rest @ List.map (fun r -> r lor low) rest
  in
  List.filter (fun x -> step u s x = x) (subsets (asserted_mask u s))

let gfp u s =
  let rec go x k =
    let x' = step u s x in
    if x' = x then Some x else if k = 0 then None else go x' (k - 1)
  in
  go (asserted_mask u s) (nids u + 2)

type frontier = { x : int; viol : inst list; uncovered : inst list }

let frontier u s =
  match gfp u s with
  | None -> None
  | Some x ->
      let viol = violated u s x in
      Some
        { x; viol; uncovered = List.filter (fun i -> not (covered u s i)) viol }

(* stationary for every root: every asserted piece is reached by some root *)
let stationary u s =
  match frontier u s with Some fr -> fr.uncovered = [] | None -> false

(* R10: bad news against selected pieces that are not in canon: shown, not owed *)
let shown u s =
  let am = asserted_mask u s in
  List.concat_map
    (fun p ->
      if sel u s p >= 0 && not (has am p) then
        List.concat
          (Array.to_list
             (Array.mapi
                (fun d _ ->
                  List.filter_map
                    (fun (i, _, o) -> if o <> Holds_ then Some (p, i) else None)
                    (applying u s p d))
                u.ont.dims))
        @ List.map (fun i -> (p, i)) (unmet_guards u s p)
      else [])
    (List.init (nids u) Fun.id)

(* the pieces an event is about *)
let rec event_pieces u i =
  if i < 0 || i >= npool u then []
  else
    match u.pool.(i) with
    | Write w -> [ w.p ]
    | Retire r -> r.p :: r.into
    | Evidence e -> e.p :: List.map (fun (q, _, _) -> q) e.reads
    | Same sm -> sm.x :: event_pieces u sm.for_
    | Accept a -> a.p :: cond_pieces a.conds
    | Affirm a -> a.p :: a.q :: cond_pieces a.conds
    | Promise (a, _) -> [ a ]
    | Waive j ->
        inst_piece j
        ::
        (match j with
        | C1 (_, q) | C5_ask (_, q, _) | C5_rest (_, q) -> [ q ]
        | _ -> [])
    | Raise (p, _) -> [ p ]
    | Set_aside e | Withdraw e -> event_pieces u e
    | Mark_root r | Unmark_root r -> [ r ]
