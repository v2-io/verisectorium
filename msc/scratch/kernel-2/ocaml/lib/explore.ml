(* Draft 4: exhaustive checking of R2-R12 over small universes.

   A universe is an ontology, a few ids with two versions each, and a pool of
   events in a fixed time order. EVERY subset of the pool is visited as a
   line with the base it sees. Universes are drawn at random from a seed, so
   "smallest" means smallest found, and "no counterexample" means none in the
   universes visited. *)

open Model

type cfg = {
  n : int;
  m : int;
  asm2 : bool;  (** the id before the root is a second assembly *)
  mono : bool;  (** read_as never [Odd] *)
  no_same_bad : bool;  (** no same event for a finding *)
}

let pick st l = List.nth l (Random.State.int st (List.length l))
let chance st p = Random.State.float st 1.0 < p
let genesis_len cfg = cfg.n + (cfg.n - if cfg.asm2 then 2 else 1) + 1

let gen_universe_once st cfg =
  let n = cfg.n and nv = 2 and m = cfg.m in
  let root = n - 1 in
  let is_asm p = p = root || (cfg.asm2 && p = n - 2) in
  let verit = List.filter (fun p -> not (is_asm p)) (List.init n Fun.id) in
  let ont =
    {
      dims =
        [|
          {
            read_as =
              (if cfg.mono then pick st [ Max; Max_unless_bad ]
               else pick st [ Max; Max_unless_bad; Odd ]);
            caps = [ 0 ];
            levels = [| 1; 2 |];
            decided = false;
          };
          { read_as = Max; caps = []; levels = [||]; decided = true };
        |];
      refkinds =
        [|
          { rk_name = "predicated-on"; rests = true; relies = Everything };
          { rk_name = "narrates"; rests = false; relies = Assertions };
          { rk_name = "names"; rests = false; relies = Existence };
          { rk_name = "leans-on"; rests = true; relies = Everything };
        |];
      akinds =
        [|
          { slots = [ ("a", false); ("b", false); ("c", false) ]; deps = [] };
          { slots = [ ("a", true); ("b", false) ]; deps = [ ("b", "a") ] };
        |];
      asks =
        pick st
          [
            [];
            [ (0, 0, 1) ];
            [ (0, 0, 1) ];
            [ (0, 0, 1); (1, 0, 2) ];
            [ (0, 1, 1) ];
          ];
      write_affirms = chance st 0.7;
      guard_from_last = chance st 0.5;
    }
  in
  let rid () = Random.State.int st n in
  let rver () = pick st verit in
  let rv () = Random.State.int st nv in
  let other p = (p + 1 + Random.State.int st (n - 1)) mod n in
  let gen_conds () =
    List.init
      (pick st [ 0; 0; 0; 1 ])
      (fun _ ->
        match Random.State.int st 3 with
        | 0 -> Selected_at (rid (), rv ())
        | 1 -> Warrant_ge (rver (), 0, 1 + Random.State.int st 2)
        | _ -> Asserted_consistent (rid ()))
  in
  let pool = Array.make m (Mark_root root) in
  let earlier i f = List.filter (fun j -> f pool.(j)) (List.init i Fun.id) in
  (* genesis: every id written once and the root marked; every state visited
     includes these, so that something is in canon *)
  for i = 0 to n - 1 do
    pool.(i) <- Write { p = i; v = 0 }
  done;
  List.iteri
    (fun i p ->
      pool.(n + i) <-
        Evidence { p; v = 0; d = 0; crit = 0; out = Holds_; reads = [] })
    verit;
  for i = genesis_len cfg to m - 1 do
    let x = Random.State.int st 100 in
    pool.(i) <-
      (if x < 30 then Write { p = rid (); v = rv () }
       else if x < 33 then
         match verit with
         | a :: (_ :: _ as rest) when chance st 0.9 ->
             Retire { p = a; into = [ pick st rest ] }
         | _ -> Write { p = rid (); v = rv () }
       else if x < 58 then
         let p = rid () in
         Evidence
           {
             p;
             v = rv ();
             d = 0;
             crit = Random.State.int st 2;
             out = pick st [ Holds_; Holds_; Holds_; Fails; Fails; Part ];
             reads =
               (if chance st 0.4 then
                  [
                    ( other p,
                      rv (),
                      pick st [ Existence; Assertions; Everything ] );
                  ]
                else []);
           }
       else if x < 64 then
         match
           earlier i (function
             | Evidence e -> not (cfg.no_same_bad && e.out <> Holds_)
             | Accept _ | Affirm _ -> true
             | _ -> false)
         with
         | [] -> Write { p = rid (); v = rv () }
         | l ->
             let for_ = pick st l in
             let x' =
               match event_pieces { ont; versions = [||]; pool } for_ with
               | p :: _ -> p
               | [] -> rid ()
             in
             Same { x = x'; v = 0; w = 1; for_ }
       else if x < 68 then
         Accept { p = rid (); v = rv (); d = 1; conds = gen_conds () }
       else if x < 75 then
         let p = rver () in
         Affirm { p; v = rv (); q = other p; w = rv (); conds = gen_conds () }
       else if x < 78 then
         Promise
           ( (if cfg.asm2 && chance st 0.5 then n - 2 else root),
             pick st [ "a"; "b" ] )
       else if x < 82 then
         let p = rver () in
         Waive
           (pick st
              [
                C6_finding (p, Random.State.int st m);
                C6_guard (p, Random.State.int st m);
                C5_ask (p, root, 0);
                C5_rest (p, other p);
                C4 (p, 0);
                C3_ref (p, 0);
                C8_slot (root, "a");
                C8_need (p, 0);
              ])
       else if x < 86 then Raise (rver (), 0)
       else if x < 91 then
         match earlier i is_base with
         | [] -> Mark_root root
         | l -> Set_aside (pick st l)
       else if x < 96 then
         Mark_root (if cfg.asm2 && chance st 0.3 then n - 2 else root)
       else if x < 98 then
         Unmark_root (if cfg.asm2 && chance st 0.3 then n - 2 else root)
       else
         match
           earlier i (function
             | Accept _ | Affirm _ | Promise _ | Waive _ | Raise _ | Set_aside _
               ->
                 true
             | _ -> false)
         with
         | [] -> Mark_root root
         | l -> Withdraw (pick st l))
  done;
  let decs =
    List.filter
      (fun i ->
        match pool.(i) with
        | Accept _ | Affirm _ | Promise _ | Raise _ -> true
        | _ -> false)
      (List.init m Fun.id)
  in
  let gen_veritoid p =
    Veritoid
      {
        content = Random.State.int st 2;
        asserts = [ (0, Random.State.int st 2) ];
        refs =
          (if chance st 0.5 then
             [
               {
                 rk = Random.State.int st 4;
                 target =
                   (let q = other p in
                    if is_asm q then pick st verit else q);
                 need =
                   (if chance st 0.25 then Some (0, 1 + Random.State.int st 2)
                    else None);
               };
             ]
           else []);
        claims =
          (if chance st 0.15 then [ (rver (), 0, 1 + Random.State.int st 2) ]
           else []);
        reports =
          (if decs <> [] && chance st 0.12 then [ pick st decs ] else []);
      }
  in
  let gen_filler p =
    let q () =
      let q = Random.State.int st (n - 1) in
      if q = p then 0 else q
    in
    match Random.State.int st 5 with
    | 0 -> Empty
    | 1 | 2 -> Holds (q ())
    | _ -> Points (q ())
  in
  let versions =
    Array.init n (fun p ->
        Array.init nv (fun _ ->
            if p = root then
              Assembly
                {
                  ak = 0;
                  fill =
                    List.map
                      (fun s -> (s, gen_filler p, chance st 0.25))
                      [ "a"; "b"; "c" ];
                }
            else if is_asm p then
              Assembly
                {
                  ak = 1;
                  fill =
                    List.map
                      (fun s ->
                        ( s,
                          (match gen_filler p with
                          | (Holds q | Points q) when is_asm q -> Empty
                          | f -> f),
                          chance st 0.2 ))
                      [ "a"; "b" ];
                }
            else gen_veritoid p))
  in
  { ont; versions; pool }

(* Prefer universes whose opening state is stationary, so that checkpoints
   exist; give up after 300 draws and take what comes. *)
let gen_universe st cfg =
  let rec go k =
    let u = gen_universe_once st cfg in
    if k = 0 || stationary u (upto (genesis_len cfg - 1)) then u else go (k - 1)
  in
  go 300

(* ---------- recording ---------- *)

type entry = {
  mutable count : int;
  mutable size : int;
  mutable witness : string;
}

let table : (string, entry) Hashtbl.t = Hashtbl.create 64
let visited = ref 0

let popcount x =
  let rec go x c = if x = 0 then c else go (x land (x - 1)) (c + 1) in
  go x 0

let show_events u s =
  String.concat "\n"
    (List.filter_map
       (fun i ->
         if has s i then
           Some (Printf.sprintf "    t%d: %s" i (show_event u.pool.(i)))
         else None)
       (List.init (npool u) Fun.id))

let show_state u s =
  String.concat "; "
    (List.filter_map
       (fun p ->
         let c = sel u s p in
         if c >= 0 then
           Some
             (Printf.sprintf "%d@%d%s = %s" p c
                (if has (asserted_mask u s) p then " IN CANON" else "")
                (show_version u.versions.(p).(c)))
         else None)
       (List.init (nids u) Fun.id))

let show_frontier = function
  | None -> "(no fixed point reached)"
  | Some (fr : frontier) ->
      Printf.sprintf "violated=[%s] uncovered=[%s] consistent-mask=%d"
        (String.concat ", " (List.map show_inst fr.viol))
        (String.concat ", " (List.map show_inst fr.uncovered))
        fr.x

let describe u s extra =
  Printf.sprintf
    "  ontology: asks=%s write_affirms=%b guard_from_last=%b read_as=%s\n\
    \  state: %s\n\
    \  events:\n\
     %s\n\
    \  frontier: %s\n\
    \  %s"
    (String.concat ","
       (List.map
          (fun (a, d, w) -> Printf.sprintf "(kind %d, dim %d, >=%d)" a d w)
          u.ont.asks))
    u.ont.write_affirms u.ont.guard_from_last
    (show_read_as u.ont.dims.(0).read_as)
    (show_state u s) (show_events u s)
    (show_frontier (frontier u s))
    extra

let record tag u s extra =
  let size = popcount s in
  let e =
    match Hashtbl.find_opt table tag with
    | Some e -> e
    | None ->
        let e = { count = 0; size = max_int; witness = "" } in
        Hashtbl.add table tag e;
        e
  in
  e.count <- e.count + 1;
  if size < e.size then (
    e.size <- size;
    e.witness <- describe u s (extra ()))

let tally tag =
  match Hashtbl.find_opt table tag with
  | Some e -> e.count <- e.count + 1
  | None -> Hashtbl.add table tag { count = 1; size = max_int; witness = "" }

let report oc =
  let l =
    List.sort compare (Hashtbl.fold (fun k e acc -> (k, e) :: acc) table [])
  in
  Printf.fprintf oc "states visited: %d\n\n" !visited;
  List.iter
    (fun (k, e) ->
      Printf.fprintf oc "== %s : %d\n" k e.count;
      if e.witness <> "" then
        Printf.fprintf oc "  smallest (%d events):\n%s\n" e.size e.witness)
    l

(* ---------- helpers ---------- *)

let rec event_class u i =
  if i < 0 || i >= npool u then "nothing"
  else
    match u.pool.(i) with
    | Write _ -> "write"
    | Retire _ -> "retire"
    | Evidence { out = Holds_; _ } -> "evidence-holds"
    | Evidence _ -> "finding"
    | Same s -> "same-for-" ^ event_class u s.for_
    | Accept _ -> "accept"
    | Affirm _ -> "affirm"
    | Promise _ -> "promise"
    | Waive _ -> "waive"
    | Raise _ -> "raise"
    | Set_aside k -> "set-aside-of-" ^ event_class u k
    | Mark_root _ -> "mark-root"
    | Unmark_root _ -> "unmark-root"
    | Withdraw k -> "withdraw-of-" ^ event_class u k

let rec good u i =
  i >= 0
  && i < npool u
  &&
  match u.pool.(i) with
  | Evidence { out = Holds_; _ } | Accept _ | Affirm _ -> true
  | Same s -> good u s.for_
  | _ -> false

let diff a b = List.filter (fun i -> not (List.mem i b)) a

let last s =
  let rec go i = if i < 0 then -1 else if has s i then i else go (i - 1) in
  go 62

(* ---------- R7 ---------- *)

let r7 u s =
  let fps = fixpoints u s in
  let top = List.fold_left ( lor ) 0 fps in
  if fps = [] then record "R7 FAIL no fixed point" u s (fun () -> "")
  else if not (List.mem top fps) then
    record "R7 FAIL fixed points with no greatest" u s (fun () -> "")
  else if gfp u s <> Some top then
    record "R7 FAIL iteration from the top misses the greatest" u s (fun () ->
        "")
  else if List.length fps = 1 then tally "R7 ok: one fixed point"
  else
    record "R7 the greatest fixed point exists and is not the only fixed point"
      u s (fun () ->
        "fixed points: " ^ String.concat "," (List.map string_of_int fps))

(* ---------- R6, R3, R5, R10: what one more event does ---------- *)

let additions u s (fr : frontier) =
  let l = last s in
  let was_stationary = fr.uncovered = [] in
  for g = l + 1 to npool u - 1 do
    let s' = s lor (1 lsl g) in
    match frontier u s' with
    | None ->
        record
          ("adding " ^ event_class u g ^ " leaves no fixed point")
          u s
          (fun () -> "")
    | Some fr' -> (
        let fresh = diff fr'.viol fr.viol and gone = diff fr.viol fr'.viol in
        let cls = event_class u g in
        let ex () =
          Printf.sprintf "added t%d: %s\n  then: %s" g
            (show_event u.pool.(g))
            (show_frontier (Some fr'))
        in
        (* R6 *)
        if good u g then
          if fresh = [] then tally "R6 ok"
          else
            List.iter
              (fun i ->
                record
                  (Printf.sprintf "R6 FAIL %s adds %s (read_as=%s)" cls
                     (inst_ctor i)
                     (show_read_as u.ont.dims.(0).read_as))
                  u s ex)
              fresh;
        (match u.pool.(g) with
        | Promise _ ->
            if fresh = [] then tally "R6 promise: adds nothing here"
            else
              List.iter
                (fun i -> record ("R6 a promise adds " ^ inst_ctor i) u s ex)
                fresh
        | _ -> ());
        (* R3 *)
        if was_stationary && is_base u.pool.(g) then
          if fr'.uncovered = [] then
            tally "R3 ok: still stationary after a base event"
          else
            record ("R3 a stationary state is broken by a later " ^ cls) u s ex;
        (* R5 *)
        (match u.pool.(g) with
        | Set_aside k when has s k ->
            if fresh = [] && gone = [] then
              tally "R5 set aside changes nothing here"
            else (
              List.iter
                (fun i ->
                  record
                    (Printf.sprintf "R5 %s removes %s" cls (inst_ctor i))
                    u s ex)
                gone;
              List.iter
                (fun i ->
                  record
                    (Printf.sprintf "R5 %s adds %s" cls (inst_ctor i))
                    u s ex)
                fresh)
        | _ -> ());
        (* R10 *)
        match u.pool.(g) with
        | Unmark_root r when marked u s r ->
            let am' = asserted_mask u s' in
            if fresh = [] then tally "R10 unmark adds nothing here"
            else
              List.iter
                (fun i ->
                  record
                    ("R10 FAIL unmarking a root adds " ^ inst_ctor i)
                    u s ex)
                fresh;
            List.iter
              (fun i ->
                if has am' (inst_piece i) then
                  match i with
                  | C5_ask (_, r', _) when r' = r ->
                      tally "R10 ok: an ask of the unmarked root goes"
                  | _ ->
                      record
                        ("R10 unmarking a root removes, from a piece still in \
                          canon, " ^ inst_ctor i)
                        u s ex)
              gone
        | _ -> ())
  done

(* ---------- R2: evidence about a version this line never selected ---------- *)

let r2 u s (fr : frontier) =
  for i = 0 to npool u - 1 do
    if has s i then
      match u.pool.(i) with
      | Evidence e
        when (not (List.exists (fun (_, v) -> v = e.v) (history u s e.p)))
             && not
                  (exists_event u s (fun _ x ->
                       match x with Same sm -> sm.for_ = i | _ -> false)) -> (
          match frontier u (s lxor (1 lsl i)) with
          | Some fr' when fr'.viol = fr.viol && fr'.uncovered = fr.uncovered ->
              tally "R2 ok"
          | fr' ->
              record
                ("R2 FAIL evidence about a version this line never selected \
                  changes its frontier: " ^ event_class u i)
                u s
                (fun () ->
                  Printf.sprintf "the evidence: t%d; without it: %s" i
                    (show_frontier fr')))
      | _ -> ()
  done

(* ---------- R12: what the instances about a piece read ---------- *)

let reads level u s p =
  let n = nids u in
  let ids = List.init n Fun.id in
  let c = sel u s p in
  let slots_of q v =
    match u.versions.(q).(v) with
    | Assembly a ->
        List.filter_map
          (fun (_, fl, _) ->
            match fl with Holds x | Points x -> Some x | Empty -> None)
          a.fill
    | Veritoid _ -> []
  in
  let held_of q v =
    match u.versions.(q).(v) with
    | Assembly a ->
        List.filter_map
          (fun (_, fl, _) -> match fl with Holds x -> Some x | _ -> None)
          a.fill
    | Veritoid _ -> []
  in
  let targets = List.map (fun r -> r.target) (refs_of u s p) in
  let fillers = if c >= 0 then slots_of p c else [] in
  let spec = targets @ fillers in
  if level = 0 then spec
  else
    let claims, reported =
      if c >= 0 then
        match u.versions.(p).(c) with
        | Veritoid v ->
            ( List.map (fun (q, _, _) -> q) v.claims,
              List.concat_map (event_pieces u) v.reports )
        | Assembly _ -> ([], [])
      else ([], [])
    in
    let about =
      fold_events u s
        (fun acc i _ ->
          let ps = event_pieces u i in
          if List.mem p ps then ps @ acc else acc)
        []
    in
    let all_versions q = List.init (Array.length u.versions.(q)) Fun.id in
    let above =
      List.filter
        (fun q ->
          if level = 2 then
            List.exists (fun v -> List.mem p (slots_of q v)) (all_versions q)
          else sel u s q >= 0 && List.mem p (slots_of q (sel u s q)))
        ids
    in
    let held = if c >= 0 then held_of p c else [] in
    let co_holders =
      if held = [] then []
      else
        List.filter
          (fun q ->
            q <> p
            &&
            let hv v = List.exists (fun x -> List.mem x held) (held_of q v) in
            if level = 2 then List.exists hv (all_versions q)
            else sel u s q >= 0 && hv (sel u s q))
          ids
    in
    spec @ claims @ reported @ about @ above @ co_holders @ ancestors u s p

let closure level u s ps =
  let rec go seen = function
    | [] -> seen
    | q :: rest ->
        if List.mem q seen then go seen rest
        else go (q :: seen) (reads level u s q @ rest)
  in
  go [] ps

let about u s p (fr : frontier) =
  ( has (asserted_mask u s) p,
    List.filter (fun i -> inst_piece i = p) fr.viol,
    List.filter (fun i -> inst_piece i = p) fr.uncovered )

let level_name = function 0 -> "spec" | 1 -> "wider" | _ -> "static"

let r12 ?(any_time = false) u s (fr : frontier) =
  let l = if any_time then -1 else last s in
  for p = 0 to nids u - 1 do
    if has (asserted_mask u s) p then
      for level = 0 to 2 do
        let nb = closure level u s [ p ] in
        let here = about u s p fr in
        for g = l + 1 to npool u - 1 do
          if
            (not (has s g))
            && not (List.exists (fun x -> List.mem x nb) (event_pieces u g))
          then
            let s' = s lor (1 lsl g) in
            match frontier u s' with
            | None -> ()
            | Some fr' ->
                if about u s' p fr' = here then
                  tally
                    ((if any_time then
                        "R12 (event at any time) ok, neighbourhood="
                      else "R12 ok, neighbourhood=")
                    ^ level_name level)
                else
                  record
                    (Printf.sprintf
                       "R12%s FAIL a %s outside the %s neighbourhood changes \
                        what is owed on the piece"
                       (if any_time then " (event at any time)" else "")
                       (event_class u g) (level_name level))
                    u s
                    (fun () ->
                      let _, v, _ = about u s' p fr' in
                      Printf.sprintf
                        "piece %d, neighbourhood {%s}; added t%d %s; then \
                         about the piece: in canon=%b %s"
                        p
                        (String.concat "," (List.map string_of_int nb))
                        g
                        (show_event u.pool.(g))
                        (has (asserted_mask u s') p)
                        (String.concat ", " (List.map show_inst v)))
        done
      done
  done

(* ---------- a graded account of what is read and what is changed ----------

   The neighbourhoods above are sets of pieces, and under an outline that
   reaches everything they all meet at the outline. Here a piece is read in
   one of three respects, and an event changes a piece in one of three:
     Ex  whether it is selected at all
     Co  which version is selected (and, for an assembly, its slots; and for
         a root, whether it is marked)
     Fa  the evidence and decisions about it
   A set of (piece, respect) pairs is a bitmask. *)

let ex p = 1 lsl (3 * p)
let co p = 1 lsl ((3 * p) + 1)
let fa p = 1 lsl ((3 * p) + 2)
let all p = ex p lor co p lor fa p

let rec subject_fa u i =
  if i < 0 || i >= npool u then 0
  else
    match u.pool.(i) with
    | Evidence e -> fa e.p
    | Same sm -> subject_fa u sm.for_
    | Accept a -> fa a.p
    | Affirm a -> fa a.p
    | Promise (a, _) -> fa a
    | Waive j -> fa (inst_piece j)
    | Raise (p, _) -> fa p
    | Set_aside k | Withdraw k -> subject_fa u k
    | _ -> 0

(* what event g changes, when added to the events s *)
let effects u s g =
  match u.pool.(g) with
  | Write w ->
      let earlier =
        fold_events u
          (s land upto g)
          (fun a i e ->
            a || (i < g && match e with Write x -> x.p = w.p | _ -> false))
          false
      in
      let retired =
        exists_event u s (fun _ e ->
            match e with Retire r -> r.p = w.p | _ -> false)
      in
      co w.p lor if earlier && not retired then 0 else ex w.p
  | Retire r ->
      List.fold_left (fun m q -> m lor fa q) (ex r.p lor co r.p) r.into
  | Mark_root r | Unmark_root r -> co r
  | _ -> subject_fa u g

(* every id that can reach p through a slot of any of its versions, upward *)
let above u p =
  let n = nids u in
  let slot_to q x =
    Array.exists
      (function
        | Assembly a ->
            List.exists (fun (_, fl, _) -> fl = Holds x || fl = Points x) a.fill
        | Veritoid _ -> false)
      u.versions.(q)
  in
  let rec go seen x =
    List.fold_left
      (fun seen q ->
        if q <> x && (not (List.mem q seen)) && slot_to q x then
          go (q :: seen) q
        else seen)
      seen (List.init n Fun.id)
  in
  go [] p

let canon_reads u p =
  List.fold_left (fun m z -> m lor ex z lor co z) 0 (above u p)

(* what the instances about p read, in the state s. [full] collects pieces
   whose whole status is read (rested on, or conditioned on as consistent). *)
let iter_in u s f = Array.iteri (fun i e -> if has s i then f e) u.pool

(* Only events present in s are consulted: an event not yet there is itself
   the change, and its effect is on the piece it is about. *)
let reads_graded u s p =
  let seen = ref [] in
  let acc = ref 0 in
  (* evidence about a version of q matters only if the line has selected that
     version, or a same event may carry it *)
  let counts q v =
    List.exists (fun (_, v') -> v' = v) (history u s q)
    || exists_event u s (fun _ e ->
        match e with Same sm -> sm.x = q | _ -> false)
  in
  let capping rk = Array.exists (fun dm -> List.mem rk dm.caps) u.ont.dims in
  let cond_reads full = function
    | Selected_at (x, _) -> acc := !acc lor ex x lor co x
    | Warrant_ge (x, _, _) -> acc := !acc lor all x
    | Asserted_consistent x -> full x
  in
  let rec warrant_reads path q =
    if not (List.mem q path) then (
      acc := !acc lor all q;
      iter_in u s (function
        | Evidence e when e.p = q && counts q e.v ->
            List.iter
              (fun (x, _, rel) ->
                acc := !acc lor ex x lor if rel = Existence then 0 else co x)
              e.reads
        | Accept a when a.p = q -> List.iter (cond_reads full) a.conds
        | _ -> ());
      List.iter
        (fun r -> if capping r.rk then warrant_reads (q :: path) r.target)
        (refs_of u s q))
  and full q =
    if not (List.mem q !seen) then (
      seen := q :: !seen;
      acc := !acc lor all q lor canon_reads u q;
      warrant_reads [] q;
      List.iter
        (fun a -> acc := !acc lor fa a lor co a lor ex a)
        (ancestors u s q);
      (* decisions about q, on the line or not *)
      iter_in u s (function
        | Accept a when a.p = q -> List.iter (cond_reads full) a.conds
        | Affirm a when a.p = q ->
            acc := !acc lor ex a.q lor co a.q;
            List.iter (cond_reads full) a.conds
        | _ -> ());
      let c = sel u s q in
      if c >= 0 then
        match u.versions.(q).(c) with
        | Veritoid v ->
            List.iter
              (fun r ->
                let k = u.ont.refkinds.(r.rk) in
                acc := !acc lor ex r.target;
                if k.relies <> Existence then acc := !acc lor co r.target;
                if r.need <> None then warrant_reads [] r.target;
                if k.rests && k.relies <> Existence then full r.target)
              v.refs;
            List.iter (fun (x, _, _) -> warrant_reads [] x) v.claims;
            List.iter
              (fun e ->
                acc := !acc lor subject_fa u e;
                if e >= 0 && e < npool u then
                  match u.pool.(e) with
                  | Accept a ->
                      acc := !acc lor ex a.p lor co a.p;
                      List.iter (cond_reads full) a.conds
                  | Affirm a ->
                      acc := !acc lor ex a.p lor co a.p;
                      List.iter (cond_reads full) a.conds
                  | _ -> ())
              v.reports
        | Assembly a ->
            let k = u.ont.akinds.(a.ak) in
            List.iter
              (fun (nm, fl, _) ->
                match fl with
                | Holds x | Points x ->
                    (* existence, and whether it is in canon by any path *)
                    acc := !acc lor ex x lor canon_reads u x;
                    (* C1: anything else that may hold it *)
                    List.iter
                      (fun z -> acc := !acc lor ex z lor co z)
                      (above u x);
                    (* C2: the fillers of slots with an inner dependency are read whole *)
                    if List.exists (fun (sa, sb) -> sa = nm || sb = nm) k.deps
                    then (
                      acc := !acc lor all x;
                      iter_in u s (function
                        | Evidence e when e.p = x && counts x e.v ->
                            List.iter
                              (fun (y, _, rel) ->
                                acc :=
                                  !acc lor ex y
                                  lor if rel = Existence then 0 else co y)
                              e.reads
                        | Affirm f when f.p = x ->
                            List.iter (cond_reads full) f.conds
                        | _ -> ()))
                | Empty -> ())
              a.fill)
  in
  full p;
  !acc

(* R12, graded: an event (added at any time) whose effects no instance about
   p reads leaves what is owed on p as it was. *)
let r12_graded u s (fr : frontier) =
  for p = 0 to nids u - 1 do
    if has (asserted_mask u s) p then
      let rd = reads_graded u s p in
      let here = about u s p fr in
      for g = 0 to npool u - 1 do
        if not (has s g) then
          let s' = s lor (1 lsl g) in
          if effects u s' g land (rd lor reads_graded u s' p) = 0 then
            match frontier u s' with
            | None -> ()
            | Some fr' ->
                if about u s' p fr' = here then tally "R12 graded ok"
                else
                  record
                    (Printf.sprintf
                       "R12 graded FAIL a %s that changes nothing the piece \
                        reads changes what is owed on it"
                       (event_class u g))
                    u s
                    (fun () ->
                      let _, v, _ = about u s' p fr' in
                      Printf.sprintf
                        "piece %d reads mask %d; added t%d %s with effects \
                         mask %d; then about the piece: in canon=%b %s"
                        p rd g
                        (show_event u.pool.(g))
                        (effects u s' g)
                        (has (asserted_mask u s') p)
                        (String.concat ", " (List.map show_inst v)))
      done
  done

(* ---------- R9: two forks from one checkpoint ---------- *)

let r9 ?(fp = false) glen u =
  let m = npool u in
  let cache = Hashtbl.create 4096 in
  let stat s =
    match Hashtbl.find_opt cache s with
    | Some b -> b
    | None ->
        let b = stationary u s in
        Hashtbl.add cache s b;
        b
  in
  let rec subsets = function
    | [] -> [ 0 ]
    | i :: rest ->
        let r = subsets rest in
        r @ List.map (fun x -> x lor (1 lsl i)) r
  in
  let rec splits = function
    | [] -> [ (0, 0) ]
    | i :: rest ->
        List.concat_map
          (fun (a, b) -> [ (a, b); (a lor (1 lsl i), b); (a, b lor (1 lsl i)) ])
          (splits rest)
  in
  let written e =
    List.sort_uniq compare
      (fold_events u e
         (fun acc _ ev ->
           match ev with
           | Write w -> w.p :: acc
           | Retire r -> (r.p :: r.into) @ acc
           | _ -> acc)
         [])
  in
  let touched e =
    List.sort_uniq compare
      (fold_events u e (fun acc i _ -> event_pieces u i @ acc) [])
  in
  let global e =
    exists_event u e (fun _ ev ->
        match ev with
        | Set_aside _ | Withdraw _ | Mark_root _ | Unmark_root _ -> true
        | _ -> false)
  in
  let meet a b = List.exists (fun x -> List.mem x b) a in
  let g = glen in
  let tk = g + ((m - g) / 2) in
  let late = List.init (m - tk) (fun i -> tk + i) in
  let late_base = List.filter (fun i -> is_base u.pool.(i)) late in
  let late_line = List.filter (fun i -> not (is_base u.pool.(i))) late in
  let ds = subsets late_base
  and sp =
    List.filter (fun (a, b) -> a <> 0 && b <> 0 && a < b) (splits late_line)
  in
  for k' = 0 to (1 lsl (tk - g)) - 1 do
    let k = upto (g - 1) lor (k' lsl g) in
    List.iter
      (fun d ->
        let kd = k lor d in
        (* the checkpoint was stationary on the base it had *)
        if stat k then
          List.iter
            (fun (ea, eb) ->
              incr visited;
              let sa = kd lor ea and sb = kd lor eb in
              if stat sa && stat sb then (
                let su = kd lor ea lor eb in
                let ok = stat su in
                let wa = written ea and wb = written eb in
                let ta = touched ea and tb = touched eb in
                let same_id = meet wa wb in
                let cl level =
                  meet wa (closure level u sb tb @ closure level u su tb)
                  || meet wb (closure level u sa ta @ closure level u su ta)
                in
                (* Footprints. A fork's footprint is every piece any of its
                   events is about. Two forks MEET (at a level of
                   neighbourhood) when some piece's neighbourhood, in the
                   merged state or in either fork's, contains a piece of
                   each footprint. *)
                let ids = List.init (nids u) Fun.id in
                let cone level p =
                  List.sort_uniq compare
                    (closure level u su [ p ] @ closure level u sa [ p ]
                   @ closure level u sb [ p ])
                in
                let sees level p =
                  let c = cone level p in
                  (meet c ta, meet c tb)
                in
                let meets level =
                  List.exists
                    (fun p ->
                      let a, b = sees level p in
                      a && b)
                    ids
                in
                if fp then (
                  (* graded: footprints as (piece, respect) masks *)
                  let fpm e =
                    fold_events u e
                      (fun m g _ -> m lor effects u (kd lor e) g)
                      0
                  in
                  let fa_ = fpm ea and fb_ = fpm eb in
                  let rg p =
                    reads_graded u su p lor reads_graded u sa p
                    lor reads_graded u sb p
                  in
                  let sees_g p =
                    let r = rg p in
                    (r land fa_ <> 0, r land fb_ <> 0)
                  in
                  let mt =
                    List.exists
                      (fun p ->
                        let a, b = sees_g p in
                        a && b)
                      ids
                  in
                  tally
                    (Printf.sprintf "R9a [graded] footprints %s, %s"
                       (if mt then "meet" else "do NOT meet")
                       (if ok then "both close" else "cannot both close"));
                  if (not mt) && not ok then
                    record
                      "R9a FAIL [graded] footprints do not meet and the forks \
                       cannot both close"
                      u su (fun () ->
                        Printf.sprintf
                          "checkpoint mask %d; A adds %d (effects %d); B adds \
                           %d (effects %d); base since %d"
                          k ea fa_ eb fb_ d);
                  (if not ok then
                     match frontier u su with
                     | None -> ()
                     | Some fr ->
                         List.iter
                           (fun i ->
                             let a, b = sees_g (inst_piece i) in
                             if a && b then
                               tally
                                 "R9b [graded] ok: the item is on a piece that \
                                  reads something each fork changed"
                             else
                               record
                                 (Printf.sprintf
                                    "R9b FAIL [graded] an item on a piece that \
                                     reads %s: %s"
                                    (if a || b then "what only one fork changed"
                                     else "nothing either fork changed")
                                    (inst_ctor i))
                                 u su
                                 (fun () ->
                                   Printf.sprintf
                                     "item %s; checkpoint mask %d; A adds %d \
                                      (effects %d); B adds %d (effects %d); \
                                      base since %d"
                                     (show_inst i) k ea fa_ eb fb_ d))
                           fr.uncovered);
                  List.iter
                    (fun level ->
                      let mt = meets level in
                      tally
                        (Printf.sprintf
                           "R9a [%s neighbourhood] footprints %s, %s"
                           (level_name level)
                           (if mt then "meet" else "do NOT meet")
                           (if ok then "both close" else "cannot both close"));
                      if (not mt) && not ok then
                        record
                          (Printf.sprintf
                             "R9a FAIL [%s] footprints do not meet and the \
                              forks cannot both close"
                             (level_name level))
                          u su
                          (fun () ->
                            Printf.sprintf
                              "checkpoint mask %d; A adds %d; B adds %d; base \
                               since %d"
                              k ea eb d);
                      (* (b): every item owed in the merged state is on a
                          piece that sees both footprints *)
                      if not ok then
                        match frontier u su with
                        | None -> ()
                        | Some fr ->
                            List.iter
                              (fun i ->
                                let a, b = sees level (inst_piece i) in
                                if a && b then
                                  tally
                                    (Printf.sprintf
                                       "R9b [%s] ok: the item is on a piece \
                                        that sees both footprints"
                                       (level_name level))
                                else
                                  record
                                    (Printf.sprintf
                                       "R9b FAIL [%s] an item on a piece that \
                                        sees %s: %s"
                                       (level_name level)
                                       (if a || b then "only one footprint"
                                        else "neither footprint")
                                       (inst_ctor i))
                                    u su
                                    (fun () ->
                                      Printf.sprintf
                                        "item %s; checkpoint mask %d; A adds \
                                         %d (footprint %s); B adds %d \
                                         (footprint %s); base since %d"
                                        (show_inst i) k ea
                                        (String.concat ","
                                           (List.map string_of_int ta))
                                        eb
                                        (String.concat ","
                                           (List.map string_of_int tb))
                                        d))
                              fr.uncovered)
                    [ 0; 1; 2 ]);
                let tag =
                  Printf.sprintf
                    "R9 %s | same id written by both=%b | one wrote what the \
                     other reads: wider=%b static=%b | set-aside, withdraw or \
                     root event in either=%b | touch a common piece=%b"
                    (if ok then "both close" else "CANNOT both close")
                    same_id (cl 1) (cl 2)
                    (global ea || global eb)
                    (meet ta tb)
                in
                if fp then ()
                else if ok then tally tag
                else
                  record tag u su (fun () ->
                      Printf.sprintf
                        "checkpoint: events of mask %d; fork A adds mask %d, \
                         fork B adds mask %d; base since: mask %d"
                        k ea eb d)))
            sp)
      ds
  done

type which = {
  w2 : bool;
  w7 : bool;
  wadd : bool;
  w12 : bool;
  w12any : bool;
  w12g : bool;
  w9 : bool;
  w9fp : bool;
}

let run_universe glen which u =
  if which.w9 then r9 glen u;
  if which.w9fp then r9 ~fp:true glen u;
  if
    which.w2 || which.w7 || which.wadd || which.w12 || which.w12any
    || which.w12g
  then
    let g = glen in
    for s' = 0 to (1 lsl (npool u - g)) - 1 do
      let s = upto (g - 1) lor (s' lsl g) in
      incr visited;
      if which.w7 then r7 u s;
      match frontier u s with
      | None -> tally "states with no fixed point reached by iteration"
      | Some fr ->
          if which.w2 then r2 u s fr;
          if which.wadd then additions u s fr;
          if which.w12 then r12 u s fr;
          if which.w12any then r12 ~any_time:true u s fr;
          if which.w12g then r12_graded u s fr
    done
