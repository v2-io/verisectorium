(* Draft 4: hand-built universes, each small enough to read. A universe's pool
   is its events in time order; a line (with the base it sees) is the set of
   pool indices given to [mask]. *)

open Kernel.Model

let pred = 0 (* rests, relies on everything, validity caps along it *)
let narr = 1 (* does not rest, relies on assertions *)
let names = 2 (* does not rest, relies on existence *)
let leans = 3 (* rests, relies on everything, nothing caps along it *)

let ont ?(read_as = Max_unless_bad) ?(write_affirms = true)
    ?(guard_from_last = false) ?(asks = [ (0, 0, 1) ]) () =
  {
    dims =
      [|
        { read_as; caps = [ pred ]; levels = [| 1; 2 |]; decided = false };
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
        (* 0: an outline; nothing required *)
        {
          slots = [ ("a", false); ("b", false); ("c", false); ("d", false) ];
          deps = [];
        };
        (* 1: a second kind of root, asking nothing unless [asks] says so *)
        { slots = [ ("a", false); ("b", false) ]; deps = [] };
        (* 2: a document: a required claim and an explanation that depends on it *)
        {
          slots = [ ("claim", true); ("expl", false) ];
          deps = [ ("expl", "claim") ];
        };
      |];
    asks;
    write_affirms;
    guard_from_last;
  }

let ver ?(refs = []) ?(claims = []) ?(reports = []) ?(a = 0) content =
  Veritoid { content; asserts = [ (0, a) ]; claims; reports; refs }

let rf ?need rk target = { rk; target; need }
let asm ?(ak = 0) fill = Assembly { ak; fill }

let ev ?(crit = 0) ?(reads = []) p v out =
  Evidence { p; v; d = 0; crit; out; reads }

let w p v = Write { p; v }
let mask l = List.fold_left (fun m i -> m lor (1 lsl i)) 0 l
let range a b = mask (List.init (b - a + 1) (fun i -> a + i))
let viol u s = match frontier u s with Some fr -> fr.viol | None -> []
let b = Alcotest.(check bool)
let has_ctor u s c = List.exists (fun i -> inst_ctor i = c) (viol u s)

(* ---------- impl-a-small-move, as a fork that closes; R4; whole reads ---------- *)

(* c = 0, u = 1 (predicated on c), O = 2 the root outline holding both. *)
let small ?guard_from_last () =
  {
    ont = ont ?guard_from_last ();
    versions =
      [|
        [| ver 0; ver 1 ~a:1; ver 2 ~a:1 |];
        [| ver 0 ~refs:[ rf pred 0 ]; ver 1 ~a:1 ~refs:[ rf pred 0 ] |];
        [| asm [ ("a", Holds 0, false); ("b", Holds 1, false) ] |];
      |];
    pool =
      [|
        (* 0 *) w 2 0;
        (* 1 *) w 0 0;
        (* 2 *) w 1 0;
        (* 3 *) Mark_root 2;
        (* 4 *) ev 0 0 Holds_;
        (* 5 *) ev 1 0 Holds_ ~reads:[ (0, 0, Everything) ];
        (* 6: a read of the whole *)
        ev 2 0 Holds_ ~reads:[ (0, 0, Everything); (1, 0, Everything) ];
        (* 7: the finding *) ev 0 0 Fails ~crit:1;
        (* 8 *) w 0 1;
        (* 9: the finding looked for in the new c and not found *)
        ev 0 1 Holds_ ~crit:1;
        (* 10 *) ev 0 1 Holds_;
        (* 11 *) w 1 1;
        (* 12 *) ev 1 1 Holds_ ~reads:[ (0, 1, Everything) ];
        (* 13 *) ev 2 0 Holds_ ~reads:[ (0, 1, Everything); (1, 1, Everything) ];
        (* 14: a later edit of c *) w 0 2;
        (* 15 *) ev 0 2 Holds_;
        (* 16 *) Affirm { p = 1; v = 1; q = 0; w = 2; conds = [] };
        (* 17 *) Same { x = 0; v = 1; w = 2; for_ = 12 };
        (* 18: c put back as it first was *) w 0 0;
        (* 19: and edited again *) w 0 2;
        (* 20: the wrong-finding way out *) Set_aside 7;
      |];
  }

let small_move () =
  let u = small () in
  b "checkpoint S0 is stationary" true (stationary u (range 0 6));
  b "the whole read applies" true (applies u (range 0 6) 6);
  let f = range 0 7 in
  b "the finding: not stationary" false (stationary u f);
  b "...c is known wrong" true (List.mem (C6_finding (0, 7)) (viol u f));
  b "...the root's ask of c is unmet" true
    (List.mem (C5_ask (0, 2, 0)) (viol u f));
  b "...u rests on something inconsistent" true
    (List.mem (C5_rest (1, 0)) (viol u f));
  (* 09:25: c rewritten *)
  let f = range 0 8 in
  b "c rewritten: the finding no longer applies, its guard does" true
    (List.mem (C6_guard (0, 7)) (viol u f)
    && not (List.mem (C6_finding (0, 7)) (viol u f)));
  b "u's reference to c is unreconciled" true (List.mem (C4 (1, 0)) (viol u f));
  b "the whole read has lapsed" false (applies u f 6);
  b "u's check, which read c, has lapsed" false (applies u f 5);
  (* the fork closes *)
  b "after the answer, the recheck, u rewritten and rechecked: stationary" true
    (stationary u (range 0 12));
  b "the new whole read applies" true (applies u (range 0 13) 13);
  (* R4: answered once *)
  let f = range 0 16 in
  b "a later edit of c carries no guard from the finding" false
    (has_ctor u f "C6_guard");
  b
    "...and with c rechecked, u's reference affirmed and u's check carried, it \
     is stationary"
    true
    (stationary u (range 0 17));
  (* re-selecting the version the finding was about brings it back *)
  b "c put back as it was: the finding applies again" true
    (List.mem (C6_finding (0, 7)) (viol u (range 0 18)))

(* R4's price. Fix, be answered, put the defect back, then touch it. *)
let answered_once_exit () =
  let first = small () and last = small ~guard_from_last:true () in
  let f = range 0 19 in
  b
    "counted from the FIRST selection of the bad version: no guard after the \
     round trip"
    false
    (has_ctor first f "C6_guard");
  b "counted from the LAST selection: the guard is back" true
    (has_ctor last f "C6_guard")

(* R5: impl-a-finding-is-answered, step 4. *)
let wrong_finding () =
  let u = small () in
  let f = range 0 7 lor mask [ 20 ] in
  b "the finding set aside, nothing written: stationary" true (stationary u f);
  b "...and the piece is at the version it was" true (sel u f 0 = 0);
  (* what a set aside can remove: any finding, true or not, and its guard *)
  b "after the rewrite, the guard is there" true
    (List.mem (C6_guard (0, 7)) (viol u (range 0 8)));
  b "...and a set aside removes that too" false
    (has_ctor u (range 0 8 lor mask [ 20 ]) "C6_guard");
  (* and it can add: set aside the check that carries c's warrant *)
  let u' = { u with pool = Array.append u.pool [| Set_aside 4 |] } in
  b "a set aside of good evidence leaves the root's ask unmet" true
    (List.mem (C5_ask (0, 2, 0)) (viol u' (range 0 6 lor mask [ 21 ])))

(* ---------- R9 ---------- *)

(* O = 4 root outline pointing at c = 0, u = 1 (predicated on c), x = 2,
   y = 3 (predicated on x). Checkpoint: events 0..9. *)
let forks () =
  {
    ont = ont ();
    versions =
      [|
        [| ver 0; ver 1 ~a:1 |];
        [| ver 0 ~refs:[ rf pred 0 ]; ver 1 ~refs:[ rf pred 0 ] |];
        [| ver 0; ver 1 ~a:1; ver 2 ~refs:[ rf pred 0 ] |];
        [| ver 0 ~refs:[ rf pred 2 ]; ver 1 ~refs:[ rf pred 2 ] |];
        [|
          asm
            [
              ("a", Points 0, false);
              ("b", Points 1, false);
              ("c", Points 2, false);
              ("d", Points 3, false);
            ];
        |];
      |];
    pool =
      [|
        (* 0 *) w 0 0;
        (* 1 *) w 1 0;
        (* 2 *) w 2 0;
        (* 3 *) w 3 0;
        (* 4 *) w 4 0;
        (* 5 *) Mark_root 4;
        (* 6 *) ev 0 0 Holds_;
        (* 7 *) ev 1 0 Holds_ ~reads:[ (0, 0, Everything) ];
        (* 8 *) ev 2 0 Holds_;
        (* 9 *) ev 3 0 Holds_ ~reads:[ (2, 0, Everything) ];
        (* fork A: repair c and u *)
        (* 10 *)
        w 0 1;
        (* 11 *) w 1 1;
        (* fork B: repair x and y *)
        (* 12 *)
        w 2 1;
        (* 13 *) w 3 1;
        (* evidence, in the base *)
        (* 14 *)
        ev 0 1 Holds_;
        (* 15 *) ev 1 1 Holds_ ~reads:[ (0, 1, Everything) ];
        (* 16 *) ev 2 1 Holds_;
        (* 17 *) ev 3 1 Holds_ ~reads:[ (2, 1, Everything) ];
        (* fork B', in place of B: x comes to rest on c as the checkpoint has it *)
        (* 18 *)
        w 2 2;
        (* 19 *) w 3 1;
        (* 20 *) ev 2 2 Holds_ ~reads:[ (0, 0, Everything) ];
        (* 21 *) ev 3 1 Holds_ ~reads:[ (2, 2, Everything) ];
        (* fork C, in place of B: someone else also rewrites c *)
        (* 22 *)
        w 0 0;
      |];
  }

let two_forks () =
  let u = forks () in
  let k = range 0 9 and base = range 14 17 lor mask [ 20; 21 ] in
  b "the checkpoint is stationary" true (stationary u (k lor base));
  let a = mask [ 10; 11 ] and bb = mask [ 12; 13 ] in
  b "fork A is stationary" true (stationary u (k lor base lor a));
  b "fork B is stationary" true (stationary u (k lor base lor bb));
  b "A and B both closed: stationary" true
    (stationary u (k lor base lor a lor bb));
  (* B' wrote x against the checkpoint's c; A rewrote c *)
  let b' = mask [ 18; 19 ] in
  b "fork B' is stationary" true (stationary u (k lor base lor b'));
  let both = k lor base lor a lor b' in
  b "A and B' both closed: not stationary, though they wrote different ids"
    false (stationary u both);
  b "...x's check read the c that A replaced" false (applies u both 20);
  b "...so the root's ask of x is unmet" true
    (List.mem (C5_ask (2, 4, 0)) (viol u both))

(* A shared dependent d = 2 narrates c = 0 and x = 1. O = 3 is the root. *)
let shared () =
  {
    ont = ont ~asks:[] ();
    versions =
      [|
        [| ver 0; ver 1 ~a:1 |];
        [| ver 0; ver 1 ~a:1 |];
        [|
          ver 0 ~refs:[ rf narr 0; rf narr 1 ];
          ver 1 ~refs:[ rf narr 0; rf narr 1 ];
        |];
        [|
          asm
            [
              ("a", Points 0, false);
              ("b", Points 1, false);
              ("c", Points 2, false);
            ];
        |];
      |];
    pool =
      [|
        w 0 0;
        w 1 0;
        w 2 0;
        w 3 0;
        Mark_root 3;
        (* 5: fork B, early: rewrites d for reasons of its own *) w 2 1;
        (* 6: fork A rewrites c *) w 0 1;
        (* 7: ...and affirms d as it knows it against the new c *)
        Affirm { p = 2; v = 0; q = 0; w = 1; conds = [] };
        (* 8: fork B, late: the same rewrite of d, made later by the clock *)
        w 2 1;
        (* 9: fork B2 rewrites x *) w 1 1;
        (* 10 *) Affirm { p = 2; v = 0; q = 1; w = 1; conds = [] };
      |];
  }

(* Each fork reconciles the shared dependent by a decision of its own: the
   decisions accumulate and the two forks compose. *)
let forks_affirm () =
  let u = shared () in
  let k = range 0 4 in
  b "checkpoint" true (stationary u k);
  b "A alone, dependent not reconciled: not stationary" false
    (stationary u (k lor mask [ 6 ]));
  b "A with its affirm" true (stationary u (k lor mask [ 6; 7 ]));
  b "B2 with its affirm" true (stationary u (k lor mask [ 9; 10 ]));
  b "both closed: stationary" true (stationary u (k lor mask [ 6; 7; 9; 10 ]))

(* The C4 switch against forks. Fork A rewrites c and affirms d. Fork B
   rewrites d and never sees A's c. Whether both may close turns on which of
   two writes, made on lines that could not see each other, has the later
   time. *)
let forks_clock () =
  let u = shared () in
  let k = range 0 4 in
  b "A" true (stationary u (k lor mask [ 6; 7 ]));
  b "B, its rewrite made before A's by the clock" true
    (stationary u (k lor mask [ 5 ]));
  b "B, its rewrite made after A's by the clock" true
    (stationary u (k lor mask [ 8 ]));
  b "A and early B: d's rewrite did not see the new c: not stationary" false
    (stationary u (k lor mask [ 5; 6; 7 ]));
  b
    "A and late B: d's rewrite counts as having seen the new c, which it never \
     did"
    true
    (stationary u (k lor mask [ 6; 7; 8 ]))

(* What "meet" is. A fork's footprint: for each of its events, which piece it
   changes and in which respect (existence, version, facts). Two forks meet
   when some piece reads, in those respects, something of each footprint. *)
let meet u k ea eb =
  let module E = Kernel.Explore in
  let fp e = fold_events u e (fun m g _ -> m lor E.effects u (k lor e) g) 0 in
  let fa = fp ea and fb = fp eb in
  List.exists
    (fun p ->
      let r =
        E.reads_graded u (k lor ea lor eb) p
        lor E.reads_graded u (k lor ea) p
        lor E.reads_graded u (k lor eb) p
      in
      r land fa <> 0 && r land fb <> 0)
    (List.init (nids u) Fun.id)

let what_meeting_is () =
  let u = forks () in
  let k = range 0 9 lor range 14 17 lor mask [ 20; 21 ] in
  b
    "two repairs under one outline do not meet: the outline reads only that \
     they exist"
    false
    (meet u k (mask [ 10; 11 ]) (mask [ 12; 13 ]));
  b "a repair of c, and x coming to rest on c: they meet" true
    (meet u k (mask [ 10; 11 ]) (mask [ 18; 19 ]));
  b "two writes of one id meet" true (meet u k (mask [ 10 ]) (mask [ 22 ]));
  let u = shared () in
  b "the clock case meets, though it happens to close" true
    (meet u (range 0 4) (mask [ 6; 7 ]) (mask [ 8 ]));
  b "two affirmations of one dependent meet, and close" true
    (meet u (range 0 4) (mask [ 6; 7 ]) (mask [ 9; 10 ]))

(* ---------- R2, R3: is "evidence in the base, writes on lines" a clean split? ---------- *)

(* c = 0 under root O = 1. A finding against c@0. The repaired version c@1 is
   checked on the finding's criterion (event 4) BEFORE this line selects it:
   on another fork, or as a draft looked at ahead of time. *)
let ahead () =
  {
    ont = ont ~asks:[] ();
    versions =
      [| [| ver 0; ver 1 ~a:1 |]; [| asm [ ("a", Points 0, false) ] |] |];
    pool =
      [|
        w 0 0;
        w 1 0;
        Mark_root 1;
        (* 3 *) ev 0 0 Fails ~crit:1;
        (* 4: recorded while this line still has c@0 *) ev 0 1 Holds_ ~crit:1;
        (* 5 *) w 0 1;
        (* 6: the same check, word for word, recorded after the write *)
        ev 0 1 Holds_ ~crit:1;
        (* 7: a write of c@1 made earlier on a fork, later rewound *) w 0 1;
      |];
  }

let checked_before_selected () =
  let u = ahead () in
  let s = range 0 5 in
  b "the check of c@1 applies: c is at 1" true (applies u s 4);
  b "yet the guard is unmet: the check did not apply when recorded" true
    (List.mem (C6_guard (0, 3)) (viol u s));
  b "the same check recorded again, after the write, meets it" true
    (stationary u (range 0 6))

(* R3. A fork writes c@1 (event 5') and the check is recorded; the fork is
   rewound past the write; the same write is made again. Model the first
   attempt as events the line no longer has. *)
let rewind_forgets () =
  let u =
    {
      (ahead ()) with
      pool =
        [|
          w 0 0;
          w 1 0;
          Mark_root 1;
          (* 3 *) ev 0 0 Fails ~crit:1;
          (* 4: first attempt *) w 0 1;
          (* 5: the check, applying when recorded *) ev 0 1 Holds_ ~crit:1;
          (* 6: after the rewind, the same write again *) w 0 1;
        |];
    }
  in
  b "first attempt: stationary" true (stationary u (range 0 5));
  let after = mask [ 0; 1; 2; 3; 5; 6 ] in
  b "rewound and redone: same version selected, same evidence in the base" true
    (sel u after 0 = 1 && applies u after 5);
  b
    "...and not stationary: on this line the check was recorded before the \
     write"
    false (stationary u after)

(* ---------- R7 ---------- *)

let fixed_points () =
  let u =
    {
      ont = ont ~asks:[] ();
      versions =
        [|
          [| ver 0 ~refs:[ rf leans 1 ] |];
          [| ver 0 ~refs:[ rf leans 0 ] |];
          [| asm [ ("a", Points 0, false); ("b", Points 1, false) ] |];
        |];
      pool =
        [|
          w 0 0;
          w 1 0;
          w 2 0;
          Mark_root 2;
          Affirm { p = 0; v = 0; q = 1; w = 0; conds = [] };
          Affirm { p = 1; v = 0; q = 0; w = 0; conds = [] };
        |];
    }
  in
  let s = range 0 5 in
  let fps = fixpoints u s in
  b "the greatest fixed point: all three consistent" true (gfp u s = Some 7);
  b "...and stationary" true (stationary u s);
  Alcotest.(check int) "but it is not the only fixed point" 2 (List.length fps)

(* ---------- R8 ---------- *)

let recuts () =
  let u =
    {
      ont = ont ~asks:[] ();
      versions =
        [|
          [| ver 7 |];
          [| ver 8 |];
          [| ver 7 |];
          [|
            asm [ ("a", Points 0, false) ];
            asm [ ("a", Points 1, false) ];
            asm [ ("a", Points 2, false) ];
          |];
        |];
      pool =
        [|
          w 0 0;
          w 3 0;
          Mark_root 3;
          (* 3 *) ev 0 0 Fails;
          (* a recorded replacement *)
          (* 4 *)
          Retire { p = 0; into = [ 1 ] };
          (* 5 *) w 1 0;
          (* 6 *) w 3 1;
          (* 7 *) ev 1 0 Holds_;
          (* an unrecorded one: id 2 has the very content the finding was about *)
          (* 8 *)
          w 2 0;
          (* 9 *) w 3 2;
        |];
    }
  in
  b "the finding" true (List.mem (C6_finding (0, 3)) (viol u (range 0 3)));
  b "replaced, descent recorded: the guard passes to the descendant" true
    (List.mem (C6_guard (1, 3)) (viol u (range 0 6)));
  b "...until looked for there and not found" true (stationary u (range 0 7));
  b "replaced by a fresh id with the same content, no descent: nothing owed"
    true
    (stationary u (range 0 3 lor mask [ 8; 9 ]))

(* ---------- R10, and impl-an-outline-fills-in ---------- *)

(* D = 0 a definition; R2 = 1 a result predicated on D; O = 2 the canonical
   outline; P = 3 a second root, a reading path, asking nothing. *)
let outline () =
  {
    ont = ont ();
    versions =
      [|
        [| ver 0; ver 1 ~a:1 |];
        [| ver 0 ~refs:[ rf pred 0 ] |];
        [|
          (* 0: D held, slot b empty *) asm [ ("a", Holds 0, false) ];
          (* 1: slot b filled with R2, flagged provisional *)
          asm [ ("a", Holds 0, false); ("b", Points 1, true) ];
          (* 2: the flag removed *)
          asm [ ("a", Holds 0, false); ("b", Points 1, false) ];
        |];
        [| asm ~ak:1 [ ("a", Points 0, false); ("b", Points 1, false) ] |];
      |];
    pool =
      [|
        (* 0 *) w 0 0;
        (* 1 *) w 2 0;
        (* 2 *) Mark_root 2;
        (* 3 *) ev 0 0 Holds_;
        (* 4: step 1, the slot is promised *) Promise (2, "b");
        (* 5: step 2, R2 written and offered *) w 1 0;
        (* 6 *) w 2 1;
        (* 7: bad news about the offered draft *) ev 1 0 Fails ~crit:1;
        (* 8 *) Set_aside 7;
        (* 9: step 3, checked *) ev 1 0 Holds_ ~reads:[ (0, 0, Everything) ];
        (* 10: step 4, placed in canon *) w 2 2;
        (* 11: the reading path, a second root *) w 3 0;
        (* 12 *) Mark_root 3;
        (* 13 *) Unmark_root 2;
        (* 14 *) Unmark_root 3;
      |];
  }

let outline_fills_in () =
  let u = outline () in
  b "S0" true (stationary u (range 0 3));
  b "promised and empty: owed" true
    (List.mem (C8_slot (2, "b")) (viol u (range 0 4)));
  let f = range 0 7 in
  b "filled by an offered draft, flagged provisional: the promise is still owed"
    true
    (List.mem (C8_slot (2, "b")) (viol u f));
  b "...the draft has no items of its own" false
    (List.exists (fun i -> inst_piece i = 1) (viol u f));
  b "...and the bad news against it is shown" true (List.mem (1, 7) (shown u f));
  let f = range 0 6 lor mask [ 9; 10 ] in
  b "checked, then placed: stationary, the promise kept" true (stationary u f);
  (* R10 *)
  let two = f lor mask [ 11; 12 ] in
  b "a second root that asks nothing: still stationary" true (stationary u two);
  let two' = range 0 6 lor mask [ 10; 11; 12 ] in
  b "unchecked R2, reached by both roots: held to what the outline asks" true
    (List.mem (C5_ask (1, 2, 0)) (viol u two'));
  b "unmark the outline: its asks go" false
    (has_ctor u (two' lor mask [ 13 ]) "C5_ask");
  (* unmarking adds: R2 is reached only by the path now, D too; fine. But
     unmark the PATH while the outline still flags R2 provisional... *)
  let g = range 0 6 lor mask [ 9; 11; 12 ] in
  b
    "R2 provisional in the outline, in canon through the path: the promise is \
     kept"
    false
    (List.mem (C8_slot (2, "b")) (viol u g));
  b "unmark the path: R2 leaves canon and the outline's promise is owed again"
    true
    (List.mem (C8_slot (2, "b")) (viol u (g lor mask [ 14 ])))

(* ---------- R6: what is left of the promise exception ---------- *)

let promise_downstream () =
  let u =
    {
      ont = ont ~asks:[] ();
      versions =
        [|
          [| ver 0 ~refs:[ rf leans 1 ] |];
          [| asm ~ak:1 [ ("a", Empty, false) ] |];
          [| asm [ ("a", Points 0, false); ("b", Points 1, false) ] |];
        |];
      pool =
        [|
          w 1 0;
          w 0 0;
          w 2 0;
          Mark_root 2;
          (* 4 *) Promise (1, "a");
          (* 5 *) Waive (C8_slot (1, "a"));
        |];
    }
  in
  b "before the promise" true (stationary u (range 0 3));
  let v = viol u (range 0 4) in
  b "the promise is owed" true (List.mem (C8_slot (1, "a")) v);
  b "...and what rests on that assembly is now inconsistent too" true
    (List.mem (C5_rest (0, 1)) v);
  b "waived, the promise no longer spreads" true (stationary u (range 0 5))

let () =
  let t n f = Alcotest.test_case n `Quick f in
  Alcotest.run "kernel, draft 4"
    [
      ( "moves",
        [
          t "a small move, with whole reads" small_move;
          t "a wrong finding, set aside" wrong_finding;
          t "an outline fills in; roots" outline_fills_in;
        ] );
      ("R4", [ t "answered once, and its price" answered_once_exit ]);
      ( "R9",
        [
          t "two forks" two_forks;
          t "a shared dependent, affirmed" forks_affirm;
          t "a shared dependent, and the clock" forks_clock;
          t "what meeting is" what_meeting_is;
        ] );
      ( "R2 R3",
        [
          t "checked before selected" checked_before_selected;
          t "a rewind forgets an answer" rewind_forgets;
        ] );
      ("R7", [ t "more than one fixed point" fixed_points ]);
      ("R8", [ t "recorded and unrecorded replacement" recuts ]);
      ("R6", [ t "a promise spreads" promise_downstream ]);
    ]
