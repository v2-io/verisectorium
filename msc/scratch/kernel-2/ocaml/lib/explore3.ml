(* Exhaustive checking of Q2-Q9 over small universes.

   A universe fixes an ontology, a few ids with a few versions each, and a
   pool of candidate facts. Within a universe EVERY subset of the pool and
   EVERY selection is visited. Universes themselves are drawn at random from
   a seed, so "smallest" below means smallest found in the universes visited,
   and "no counterexample" means none within them. *)

open Model3

(* ---------- generating universes ---------- *)

type cfg = {
  n : int;  (** ids *)
  nv : int;  (** versions per id *)
  m : int;  (** pool size *)
  asm : bool;  (** make the last id an assembly *)
  mono : bool;  (** read_as never [Odd] *)
  no_same_bad : bool;  (** no same fact for failing evidence *)
  no_neg_cond : bool;
      (** raise, promise and waive decisions carry no conditions *)
  no_bad : bool;  (** no failing or partial evidence at all *)
}

let pick st l = List.nth l (Random.State.int st (List.length l))
let chance st p = Random.State.float st 1.0 < p

let gen_universe st cfg =
  let n = cfg.n and nv = cfg.nv in
  let refkinds =
    [|
      { rk_name = "predicated-on"; rests = true; relies = Everything };
      { rk_name = "narrates"; rests = false; relies = Assertions };
      { rk_name = "names"; rests = false; relies = Existence };
      { rk_name = "leans-on"; rests = true; relies = Existence };
    |]
  in
  let read_as =
    if cfg.mono then pick st [ Max; Max; Max_unless_bad ]
    else pick st [ Max; Max_unless_bad; Odd ]
  in
  let ont =
    {
      dims = [| { read_as; caps = [ 0 ]; levels = [| 1; 2 |] } |];
      refkinds;
      akinds =
        [| { slots = [ ("a", true); ("b", false) ]; deps = [ ("b", "a") ] } |];
      standard = pick st [ By_decision; By_rule [ (0, 1) ]; By_placement ];
      guards = chance st 0.8;
      written_against = chance st 0.7;
    }
  in
  let m = cfg.m in
  let n_base = m - (m / 4) - 1 in
  let rid () = Random.State.int st n in
  let rv () = Random.State.int st nv in
  let other p = (p + 1 + Random.State.int st (n - 1)) mod n in
  let gen_conds () =
    List.init
      (pick st [ 0; 0; 1; 1; 2 ])
      (fun _ ->
        match Random.State.int st 3 with
        | 0 -> Selected_at (rid (), rv ())
        | 1 -> Warrant_ge (rid (), 0, 1 + Random.State.int st 2)
        | _ -> Asserted_consistent (rid ()))
  in
  let gen_inst () =
    let p = rid () and c = Random.State.int st 2 in
    pick st
      [
        C6_fail (p, 0, c);
        C6_guard (p, 0, c);
        C6_conflict (p, 0, c);
        C5_std p;
        C5_rest (p, other p);
        C3_resolve (p, 0);
        C4 (p, 0);
        C8_need (p, 0);
        C7_claim (p, 0);
        C8_required (n - 1, "a");
      ]
  in
  let base =
    Array.init n_base (fun _ ->
        if chance st 0.45 then
          Evidence
            {
              p = rid ();
              v = rv ();
              d = 0;
              crit = Random.State.int st 2;
              out =
                (if cfg.no_bad then Holds_
                 else pick st [ Holds_; Holds_; Holds_; Fails; Fails; Part ]);
            }
        else
          let k =
            pick st [ Accept; Accept; Affirm; Affirm; Promise; Waive; Raise ]
          in
          let subj =
            match k with
            | Accept -> Piece_at (rid (), rv ())
            | Affirm ->
                let p = rid () in
                Pair (p, rv (), other p, rv ())
            | Promise ->
                Slot ((if cfg.asm then n - 1 else rid ()), pick st [ "a"; "b" ])
            | Waive -> Inst (gen_inst ())
            | Raise -> Question (rid (), 0)
          in
          let conds =
            if cfg.no_neg_cond && (k = Raise || k = Promise || k = Waive) then
              []
            else gen_conds ()
          in
          Decision { k; subj; conds })
  in
  let decs =
    List.filter
      (fun i -> match base.(i) with Decision _ -> true | _ -> false)
      (List.init n_base Fun.id)
  in
  let meta =
    Array.init (m - n_base) (fun _ ->
        let same () =
          let ok i =
            match base.(i) with
            | Evidence e -> not (cfg.no_same_bad && e.out <> Holds_)
            | _ -> true
          in
          let cands = List.filter ok (List.init n_base Fun.id) in
          if cands = [] then Withdrawn (-1)
          else
            let for_ = pick st cands in
            let x =
              match
                fact_pieces_shallow
                  { ont; versions = [||]; descent = []; pool = base }
                  for_
              with
              | p :: _ when chance st 0.8 -> p
              | _ -> rid ()
            in
            let v = rv () in
            Same { x; v; w = (v + 1) mod nv; for_ }
        in
        if decs <> [] && chance st 0.35 then Withdrawn (pick st decs)
        else same ())
  in
  let pool = Array.append base meta in
  let gen_veritoid p =
    Veritoid
      {
        content = Random.State.int st 2;
        asserts = [ (0, Random.State.int st 2) ];
        refs =
          (if chance st 0.55 then
             [
               {
                 rk = Random.State.int st (Array.length refkinds);
                 target = other p;
                 need =
                   (if chance st 0.3 then Some (0, 1 + Random.State.int st 2)
                    else None);
                 against = (if chance st 0.5 then Some (rv ()) else None);
               };
             ]
           else []);
        claims =
          (if chance st 0.2 then [ (rid (), 0, 1 + Random.State.int st 2) ]
           else []);
        reports =
          (if decs <> [] && chance st 0.15 then [ pick st decs ] else []);
      }
  in
  let gen_filler () =
    match Random.State.int st 3 with
    | 0 -> Empty
    | 1 -> Holds (Random.State.int st (n - 1))
    | _ -> Points (Random.State.int st (n - 1))
  in
  let versions =
    Array.init n (fun p ->
        Array.init nv (fun _ ->
            if cfg.asm && p = n - 1 then
              Assembly
                {
                  ak = 0;
                  fill = [ ("a", gen_filler ()); ("b", gen_filler ()) ];
                }
            else gen_veritoid p))
  in
  let descent =
    if chance st 0.35 then
      let a = Random.State.int st (n - 1) in
      [ (a, a + 1 + Random.State.int st (n - 1 - a)) ]
    else []
  in
  { ont; versions; descent; pool }

(* ---------- enumerating selections ---------- *)

let all_selections u =
  let n = nids u in
  let rec go p =
    if p = n then [ ([], 0) ]
    else
      let rest = go (p + 1) in
      List.concat_map
        (fun (vs, a) ->
          (-1 :: vs, a)
          :: List.concat_map
               (fun v -> [ (v :: vs, a); (v :: vs, a lor (1 lsl p)) ])
               (List.init (Array.length u.versions.(p)) Fun.id))
        rest
  in
  List.map (fun (vs, a) -> { sel = Array.of_list vs; asr_ = a }) (go 0)

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

let show_sel u s =
  String.concat "; "
    (List.filter_map
       (fun p ->
         if selected s p then
           Some
             (Printf.sprintf "%d@%d%s = %s" p s.sel.(p)
                (if asserted s p then " ASSERTED" else "")
                (show_version u.versions.(p).(s.sel.(p))))
         else None)
       (List.init (nids u) Fun.id))

let show_facts u f =
  String.concat "\n"
    (List.filter_map
       (fun i ->
         if has f i then
           Some (Printf.sprintf "    f%d: %s" i (show_fact u.pool.(i)))
         else None)
       (List.init (Array.length u.pool) Fun.id))

let show_frontier = function
  | None -> "(no fixed point reached)"
  | Some fr ->
      Printf.sprintf "violated=[%s] uncovered=[%s] consistent-mask=%d"
        (String.concat ", " (List.map show_inst fr.viol))
        (String.concat ", " (List.map show_inst fr.uncovered))
        fr.x

let describe u f s extra =
  Printf.sprintf
    "  ontology: standard=%s guards=%b written_against=%b read_as=%s descent=%s\n\
    \  selection: %s\n\
    \  facts:\n\
     %s\n\
    \  frontier: %s\n\
    \  %s"
    (show_standard u.ont.standard)
    u.ont.guards u.ont.written_against
    (show_read_as u.ont.dims.(0).read_as)
    (String.concat ","
       (List.map (fun (a, c) -> Printf.sprintf "%d->%d" a c) u.descent))
    (show_sel u s) (show_facts u f)
    (show_frontier (frontier u f s))
    extra

let record tag u f s extra =
  let size =
    popcount f
    + Array.fold_left (fun c v -> if v >= 0 then c + 1 else c) 0 s.sel
  in
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
    e.witness <- describe u f s (extra ()))

let tally tag =
  match Hashtbl.find_opt table tag with
  | Some e -> e.count <- e.count + 1
  | None -> Hashtbl.add table tag { count = 1; size = max_int; witness = "" }

let report oc =
  let l = Hashtbl.fold (fun k e acc -> (k, e) :: acc) table [] in
  let l = List.sort compare l in
  Printf.fprintf oc "states visited: %d\n\n" !visited;
  List.iter
    (fun (k, e) ->
      Printf.fprintf oc "== %s : %d\n" k e.count;
      if e.witness <> "" then
        Printf.fprintf oc "  smallest (size %d):\n%s\n" e.size e.witness)
    l

(* ---------- the checks ---------- *)

let fact_class u i =
  match u.pool.(i) with
  | Evidence { out = Holds_; _ } -> "evidence-holds"
  | Evidence _ -> "evidence-bad"
  | Decision d -> "decision-" ^ show_dkind d.k
  | Withdrawn _ -> "withdrawn"
  | Same s -> (
      if s.for_ < 0 || s.for_ >= Array.length u.pool then "same-for-nothing"
      else
        match u.pool.(s.for_) with
        | Evidence { out = Holds_; _ } -> "same-for-evidence-holds"
        | Evidence _ -> "same-for-evidence-bad"
        | Decision d -> "same-for-decision-" ^ show_dkind d.k
        | _ -> "same-for-other")

let good u i =
  match u.pool.(i) with
  | Evidence { out = Holds_; _ } | Same _ -> true
  | Decision { k = Accept | Affirm | Promise; _ } -> true
  | _ -> false

let diff a b = List.filter (fun i -> not (List.mem i b)) a

(* Does F hold a raise, promise or waive decision with a condition? *)
let neg_cond u f =
  exists_fact u f (fun _ fa ->
      match fa with
      | Decision { k = Raise | Promise | Waive; conds = _ :: _; _ } -> true
      | _ -> false)

let q6 u f s =
  match gfp_brute u f s with
  | Greatest x ->
      if gfp_iter u f s <> Some x then
        record "Q6 iteration-from-top misses the greatest fixed point" u f s
          (fun () -> "")
      else tally "Q6 ok: unique greatest fixed point"
  | No_fixpoint ->
      record
        (Printf.sprintf
           "Q6 FAIL no fixed point (conditioned raise/promise/waive present=%b)"
           (neg_cond u f))
        u f s
        (fun () -> "")
  | No_greatest fps ->
      record
        (Printf.sprintf
           "Q6 FAIL fixed points with no greatest (conditioned \
            raise/promise/waive present=%b)"
           (neg_cond u f))
        u f s
        (fun () ->
          "fixed points: " ^ String.concat "," (List.map string_of_int fps))

(* Q2: dead facts are inert. *)
let dead u f s i =
  let unreached fid p v =
    (not (selected s p)) || not (reach u f fid p v s.sel.(p))
  in
  match u.pool.(i) with
  | Evidence e ->
      unreached i e.p e.v
      && not
           (u.ont.guards && e.out <> Holds_
           && List.exists (selected s) (e.p :: descendants u e.p))
  | Same sm -> unreached sm.for_ sm.x sm.v && unreached sm.for_ sm.x sm.w
  | Decision { subj = Piece_at (p, v); _ } -> unreached i p v
  | Decision { subj = Pair (p, v, q, w); _ } ->
      unreached i p v || unreached i q w
  | _ -> false

let q2 u f s fr =
  for i = 0 to Array.length u.pool - 1 do
    if has f i && dead u f s i then
      let f' = f lxor (1 lsl i) in
      match frontier u f' s with
      | Some fr' when fr'.viol = fr.viol && fr'.uncovered = fr.uncovered ->
          tally "Q2 ok"
      | fr' ->
          record
            (Printf.sprintf "Q2 FAIL a dead %s changes the frontier"
               (fact_class u i))
            u f s
            (fun () ->
              Printf.sprintf "dead fact: f%d; without it: %s" i
                (show_frontier fr'))
  done

(* Q4: good facts do no harm. *)
let q4 u f s fr =
  for g = 0 to Array.length u.pool - 1 do
    if (not (has f g)) && good u g then
      match frontier u (f lor (1 lsl g)) s with
      | None ->
          record
            (Printf.sprintf "Q4 adding %s leaves no fixed point"
               (fact_class u g))
            u f s
            (fun () -> Printf.sprintf "added: f%d %s" g (show_fact u.pool.(g)))
      | Some fr' ->
          let fresh =
            List.filter
              (function C8_promise (_, _, i) when i = g -> false | _ -> true)
              (diff fr'.viol fr.viol)
          in
          (* Two expected exceptions, tallied apart: a promise (its own C8
             instance is already excluded above; what remains is what follows
             from the promised slot's assembly becoming inconsistent), and a
             conflict on a criterion already failing on that piece. *)
          let excused inst =
            match (u.pool.(g), inst) with
            | Decision { k = Promise; _ }, _ ->
                Some "a promise's consequences downstream"
            | _, C6_conflict (p, d, c) when List.mem (C6_fail (p, d, c)) fr.viol
              ->
                Some "a conflict where the criterion already fails"
            | _ -> None
          in
          let ex = List.filter_map excused fresh in
          List.iter (fun e -> tally ("Q4 excepted: " ^ e)) ex;
          let fresh = List.filter (fun i -> excused i = None) fresh in
          if fresh = [] then (if ex = [] then tally "Q4 ok")
          else
            List.iter
              (fun inst ->
                record
                  (Printf.sprintf "Q4 FAIL %s adds %s (read_as=%s)"
                     (fact_class u g) (inst_ctor inst)
                     (show_read_as u.ont.dims.(0).read_as))
                  u f s
                  (fun () ->
                    Printf.sprintf "added: f%d %s\n  new violated: %s" g
                      (show_fact u.pool.(g))
                      (show_inst inst)))
              fresh
  done

(* Q3, read per fact: with sigma stationary under F, and two facts added, is
   sigma stationary under both exactly when it is under each alone? *)
let q3 u f s =
  let m = Array.length u.pool in
  for g1 = 0 to m - 1 do
    if not (has f g1) then
      for g2 = g1 + 1 to m - 1 do
        if not (has f g2) then
          let a = stationary u (f lor (1 lsl g1)) s in
          let b = stationary u (f lor (1 lsl g2)) s in
          let both = stationary u (f lor (1 lsl g1) lor (1 lsl g2)) s in
          if both = (a && b) then tally "Q3 ok (per-fact reading)"
          else
            let c1, c2 = (fact_class u g1, fact_class u g2) in
            let c1, c2 = if c1 <= c2 then (c1, c2) else (c2, c1) in
            record
              (Printf.sprintf "Q3 FAIL %s: %s + %s"
                 (if both then "one alone breaks it, together fine"
                  else "each alone harmless, together break it")
                 c1 c2)
              u f s
              (fun () ->
                Printf.sprintf
                  "added: f%d %s, f%d %s; alone: %b, %b; together: %b" g1
                  (show_fact u.pool.(g1))
                  g2
                  (show_fact u.pool.(g2))
                  a b both)
      done
  done

(* Q5, the part not true by construction: a known defect shed by asserting a
   different id with the same content and no recorded descent. *)
let q5 u f s fr =
  if u.ont.guards then
    iter_facts u f (fun _ fa ->
        match fa with
        | Evidence e when e.out = Fails && e.v < Array.length u.versions.(e.p)
          ->
            let related = e.p :: descendants u e.p in
            (* by construction: *)
            List.iter
              (fun q ->
                if asserted s q then
                  let held = List.mem (e.crit, Holds_) (applying u f s q e.d) in
                  let flagged =
                    List.exists
                      (function
                        | C6_guard (q', d, c) | C6_fail (q', d, c) ->
                            q' = q && d = e.d && c = e.crit
                        | _ -> false)
                      fr.viol
                  in
                  if held || flagged then tally "Q5 ok (related piece)"
                  else
                    record "Q5 FAIL related piece asserted, unflagged" u f s
                      (fun () -> ""))
              related;
            (* the clone: *)
            for r = 0 to nids u - 1 do
              if asserted s r && not (List.mem r related) then
                match (u.versions.(r).(s.sel.(r)), u.versions.(e.p).(e.v)) with
                | Veritoid a, Veritoid b
                  when a.content = b.content && a.asserts = b.asserts
                       && (not
                             (List.exists (fun i -> inst_piece i = r) fr.viol))
                       && not (List.exists (selected s) related) ->
                    record
                      "Q5 clone: same content under an unrelated id is \
                       asserted with nothing violated on it"
                      u f s (fun () ->
                        Printf.sprintf
                          "defect was found on %d@%d; asserted clone is %d" e.p
                          e.v r)
                | _ -> ()
            done
        | _ -> ())

(* Q7: what an instance about p reads. Three candidate neighbourhoods. *)
let reads level u f s p =
  let n = nids u in
  let ids = List.init n Fun.id in
  let targets = List.map (fun r -> r.target) (refs_of u s p) in
  let resolved =
    List.filter_map (fun r -> resolve u s r.target) (refs_of u s p)
  in
  let fillers =
    if selected s p then
      match u.versions.(p).(s.sel.(p)) with
      | Assembly a ->
          List.filter_map
            (function _, (Holds q | Points q) -> Some q | _ -> None)
            a.fill
      | Veritoid _ -> []
    else []
  in
  let spec = targets @ resolved @ fillers @ rests_all u f s p in
  if level = 0 then spec
  else
    let claims, reported =
      if selected s p then
        match u.versions.(p).(s.sel.(p)) with
        | Veritoid v ->
            ( List.map (fun (q, _, _) -> q) v.claims,
              List.concat_map (fact_pieces u) v.reports )
        | Assembly _ -> ([], [])
      else ([], [])
    in
    let about = ref [] in
    Array.iteri
      (fun i fa ->
        match fa with
        | Decision _
          when (level = 2 || has f i) && List.mem p (fact_pieces_shallow u i) ->
            about := fact_pieces u i @ !about
        | _ -> ())
      u.pool;
    let holds_p q v =
      match u.versions.(q).(v) with
      | Assembly a -> List.exists (fun (_, fl) -> fl = Holds p) a.fill
      | Veritoid _ -> false
    in
    let holders =
      List.filter
        (fun q ->
          if level = 2 then
            List.exists (holds_p q)
              (List.init (Array.length u.versions.(q)) Fun.id)
          else selected s q && holds_p q s.sel.(q))
        ids
    in
    let desc =
      List.concat_map
        (fun t ->
          List.filter (fun q -> level = 2 || selected s q) (descendants u t))
        targets
    in
    spec @ claims @ reported @ !about @ holders @ desc
    @ if level = 2 then ancestors u p else []

let closure level u f s p =
  let rec go seen = function
    | [] -> seen
    | q :: rest ->
        if List.mem q seen then go seen rest
        else go (q :: seen) (reads level u f s q @ rest)
  in
  go [] [ p ]

let about p (fr : frontier) =
  ( List.filter (fun i -> inst_piece i = p) fr.viol,
    List.filter (fun i -> inst_piece i = p) fr.uncovered )

let level_name = function 0 -> "spec" | 1 -> "wider" | _ -> "static"

let q7 u f s fr =
  let n = nids u in
  for p = 0 to n - 1 do
    if asserted s p then
      for level = 0 to 2 do
        let nb = closure level u f s p in
        let here = about p fr in
        (* change the selection of one id outside the neighbourhood *)
        for q = 0 to n - 1 do
          if not (List.mem q nb) then
            let alts =
              (-1, false)
              :: List.concat_map
                   (fun v -> [ (v, false); (v, true) ])
                   (List.init (Array.length u.versions.(q)) Fun.id)
            in
            List.iter
              (fun (v, a) ->
                if not (v = s.sel.(q) && a = asserted s q) then (
                  let sel = Array.copy s.sel in
                  sel.(q) <- v;
                  let asr_ =
                    if a then s.asr_ lor (1 lsl q)
                    else s.asr_ land lnot (1 lsl q)
                  in
                  let s' = { sel; asr_ } in
                  match frontier u f s' with
                  | None -> ()
                  | Some fr' ->
                      if about p fr' = here then
                        tally
                          ("Q7 ok selection, neighbourhood=" ^ level_name level)
                      else
                        let d =
                          diff (fst (about p fr')) (fst here)
                          @ diff (fst here) (fst (about p fr'))
                        in
                        let what =
                          match d with
                          | i :: _ -> inst_ctor i
                          | [] -> "coverage"
                        in
                        record
                          (Printf.sprintf
                             "Q7 FAIL selection outside the %s neighbourhood \
                              changes %s"
                             (level_name level) what)
                          u f s
                          (fun () ->
                            Printf.sprintf
                              "piece %d, neighbourhood {%s}; id %d moved to \
                               version %d asserted=%b; then about the piece: \
                               %s"
                              p
                              (String.concat "," (List.map string_of_int nb))
                              q v a
                              (String.concat ", "
                                 (List.map show_inst (fst (about p fr')))))))
              alts
        done;
        (* add one fact that is not about the neighbourhood *)
        for g = 0 to Array.length u.pool - 1 do
          if
            (not (has f g))
            && not (List.exists (fun x -> List.mem x nb) (fact_pieces u g))
          then
            match frontier u (f lor (1 lsl g)) s with
            | None -> ()
            | Some fr' ->
                if about p fr' = here then
                  tally ("Q7 ok fact, neighbourhood=" ^ level_name level)
                else
                  record
                    (Printf.sprintf
                       "Q7 FAIL a %s outside the %s neighbourhood changes it"
                       (fact_class u g) (level_name level))
                    u f s
                    (fun () ->
                      Printf.sprintf
                        "piece %d, neighbourhood {%s}; added f%d %s; then \
                         about the piece: %s"
                        p
                        (String.concat "," (List.map string_of_int nb))
                        g
                        (show_fact u.pool.(g))
                        (String.concat ", "
                           (List.map show_inst (fst (about p fr')))))
        done
      done
  done

(* Q9: the three standards on the same (selection, facts). *)
let q9 u f s =
  let st std = stationary { u with ont = { u.ont with standard = std } } f s in
  let d = st By_decision
  and r = st (By_rule [ (0, 1) ])
  and p = st By_placement in
  let go name a b =
    if a && not b then
      record
        ("Q9 stationary under " ^ name)
        { u with ont = { u.ont with standard = By_placement } }
        f s
        (fun () -> Printf.sprintf "decision=%b rule=%b placement=%b" d r p)
  in
  go "decision, not under rule" d r;
  go "rule, not under decision" r d;
  go "decision, not under placement" d p;
  go "rule, not under placement" r p;
  go "placement, not under decision" p d;
  go "placement, not under rule" p r;
  if d || r || p then tally "Q9 stationary under at least one"

(* Q8: two changes from one stationary selection. Each change moves one id
   and adds at most two facts. *)
let q8 u f s =
  if stationary u f s then
    let n = nids u and m = Array.length u.pool in
    let free = List.filter (fun i -> not (has f i)) (List.init m Fun.id) in
    let adds =
      0
      :: List.concat_map
           (fun i ->
             (1 lsl i)
             :: List.filter_map
                  (fun j ->
                    if j > i then Some ((1 lsl i) lor (1 lsl j)) else None)
                  free)
           free
    in
    let moves q =
      List.filter_map
        (fun (v, a) ->
          if v = s.sel.(q) && a = asserted s q then None
          else
            let sel = Array.copy s.sel in
            sel.(q) <- v;
            Some
              {
                sel;
                asr_ =
                  (if a then s.asr_ lor (1 lsl q) else s.asr_ land lnot (1 lsl q));
              })
        ((-1, false)
        :: List.concat_map
             (fun v -> [ (v, false); (v, true) ])
             (List.init (Array.length u.versions.(q)) Fun.id))
    in
    let changed s' f' =
      match (frontier u f s, frontier u f' s') with
      | Some a, Some b ->
          List.filter
            (fun p ->
              s.sel.(p) <> s'.sel.(p)
              || asserted s p <> asserted s' p
              || has a.x p <> has b.x p)
            (List.init n Fun.id)
      | _ -> []
    in
    (* changes: (id moved, new selection, new facts, changed pieces) that are stationary on what they changed *)
    let changes =
      List.concat_map
        (fun q ->
          List.concat_map
            (fun s' ->
              List.filter_map
                (fun add ->
                  let f' = f lor add in
                  let ch = changed s' f' in
                  if ch <> [] && stationary_on u f' s' ch then
                    Some (q, s', add, ch)
                  else None)
                adds)
            (moves q))
        (List.init n Fun.id)
    in
    List.iter
      (fun (q1, s1, a1, ch1) ->
        List.iter
          (fun (q2, s2, a2, ch2) ->
            if q1 < q2 then (
              let sel = Array.copy s.sel in
              sel.(q1) <- s1.sel.(q1);
              sel.(q2) <- s2.sel.(q2);
              let bit q src = if asserted src q then 1 lsl q else 0 in
              let asr_ =
                s.asr_
                land lnot ((1 lsl q1) lor (1 lsl q2))
                lor bit q1 s1 lor bit q2 s2
              in
              let s12 = { sel; asr_ } in
              let f12 = f lor a1 lor a2 in
              let cl level s' f' ch =
                List.sort_uniq compare
                  (List.concat_map (closure level u f' s') ch)
              in
              let meet level =
                let c1 =
                  cl level s1 (f lor a1) ch1
                  @ List.concat_map (fact_pieces u)
                      (List.filter (has a1) (List.init m Fun.id))
                and c2 =
                  cl level s2 (f lor a2) ch2
                  @ List.concat_map (fact_pieces u)
                      (List.filter (has a2) (List.init m Fun.id))
                in
                List.exists (fun x -> List.mem x c2) c1
              in
              let ok = stationary_on u f12 s12 (ch1 @ ch2) in
              let tag =
                Printf.sprintf "Q8 %s; neighbourhoods meet: spec=%b static=%b"
                  (if ok then "composes" else "DOES NOT compose")
                  (meet 0) (meet 2)
              in
              if ok then tally tag
              else
                record tag u f s (fun () ->
                    Printf.sprintf
                      "change 1: id %d -> version %d asserted=%b, adds facts \
                       mask %d, changed %s\n\
                      \  change 2: id %d -> version %d asserted=%b, adds facts \
                       mask %d, changed %s\n\
                      \  both: %s"
                      q1 s1.sel.(q1) (asserted s1 q1) a1
                      (String.concat "," (List.map string_of_int ch1))
                      q2 s2.sel.(q2) (asserted s2 q2) a2
                      (String.concat "," (List.map string_of_int ch2))
                      (show_frontier (frontier u f12 s12)))))
          changes)
      changes

type which = {
  w2 : bool;
  w3 : bool;
  w4 : bool;
  w5 : bool;
  w6 : bool;
  w7 : bool;
  w8 : bool;
  w9 : bool;
}

let run_universe which u =
  let sels = all_selections u in
  let m = Array.length u.pool in
  for f = 0 to (1 lsl m) - 1 do
    List.iter
      (fun s ->
        incr visited;
        if which.w6 then q6 u f s;
        if which.w9 then q9 u f s;
        if which.w8 then q8 u f s;
        match frontier u f s with
        | None ->
            tally
              "states with no fixed point reached by iteration (skipped by \
               Q2-Q5, Q7)"
        | Some fr ->
            if which.w2 then q2 u f s fr;
            if which.w4 then q4 u f s fr;
            if which.w5 then q5 u f s fr;
            if which.w7 then q7 u f s fr;
            if which.w3 && fr.uncovered = [] then q3 u f s)
      sels
  done
