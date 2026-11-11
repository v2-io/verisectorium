(* Hand-built witnesses and the invented moves of core/src, each a tiny
   universe written out in full. The exhaustive runs (bin/explore_main) found
   most of these; here each is pinned so it can be read and re-run. *)

open Kernel.Model3

let pred = 0 (* rests, relies on everything, validity caps along it *)
let narr = 1 (* does not rest, relies on assertions *)
let names = 2 (* does not rest, relies on existence *)

let ont ?(read_as = Max) ?(guards = true) ?(written_against = true) standard =
  {
    dims = [| { read_as; caps = [ pred ]; levels = [| 1; 2 |] } |];
    refkinds =
      [|
        { rk_name = "predicated-on"; rests = true; relies = Everything };
        { rk_name = "narrates"; rests = false; relies = Assertions };
        { rk_name = "names"; rests = false; relies = Existence };
      |];
    akinds =
      [| { slots = [ ("a", true); ("b", false) ]; deps = [ ("b", "a") ] } |];
    standard;
    guards;
    written_against;
  }

let ver ?(refs = []) ?(claims = []) ?(reports = []) ?(a = 0) content =
  Veritoid { content; asserts = [ (0, a) ]; claims; reports; refs }

let rf ?need ?against rk target = { rk; target; need; against }
let ev ?(crit = 0) p v out = Evidence { p; v; d = 0; crit; out }
let dec ?(conds = []) k subj = Decision { k; subj; conds }
let mask l = List.fold_left (fun m i -> m lor (1 lsl i)) 0 l

(* selection from a list of (id, version, asserted) *)
let sel u l =
  let a = Array.make (nids u) (-1) in
  let m = ref 0 in
  List.iter
    (fun (p, v, s) ->
      a.(p) <- v;
      if s then m := !m lor (1 lsl p))
    l;
  { sel = a; asr_ = !m }

let viol u f s = match frontier u f s with Some fr -> fr.viol | None -> []
let check_bool = Alcotest.(check bool)
let check_int = Alcotest.(check int)

let popcount x =
  let rec go x c = if x = 0 then c else go (x land (x - 1)) (c + 1) in
  go x 0

(* Fewest facts, added to [base] from the pool, under which [s] is stationary. *)
let min_added u base s =
  let m = Array.length u.pool in
  let best = ref None in
  for d = 0 to (1 lsl m) - 1 do
    if d land base = 0 && stationary u (base lor d) s then
      match !best with
      | Some (n, _) when n <= popcount d -> ()
      | _ -> best := Some (popcount d, d)
  done;
  !best

let cost u base s =
  match min_added u base s with Some (n, _) -> n | None -> -1

(* ---------- Q6 ---------- *)

(* One piece, one fact: a question raised on p on condition that p is
   consistent. If p is consistent the question holds and is unanswered, so p
   is not; if p is not, the question does not hold, so p is. *)
let q6_liar () =
  let u =
    {
      ont = ont By_placement;
      versions = [| [| ver 0 |] |];
      descent = [];
      pool = [| dec Raise (Question (0, 0)) ~conds:[ Asserted_consistent 0 ] |];
    }
  in
  let s = sel u [ (0, 0, true) ] in
  check_bool "no fixed point" true (gfp_brute u 1 s = No_fixpoint);
  check_bool "without the fact, fine" true (gfp_brute u 0 s = Greatest 1)

(* Two pieces, two promises... the same shape through a promise: fixed points
   exist and none is greatest. p and q each carry a question that holds only
   while the OTHER is consistent. *)
let q6_no_greatest () =
  let u =
    {
      ont = ont By_placement;
      versions = [| [| ver 0 |]; [| ver 0 |] |];
      descent = [];
      pool =
        [|
          dec Raise (Question (0, 0)) ~conds:[ Asserted_consistent 1 ];
          dec Raise (Question (1, 0)) ~conds:[ Asserted_consistent 0 ];
        |];
    }
  in
  let s = sel u [ (0, 0, true); (1, 0, true) ] in
  match gfp_brute u 3 s with
  | No_greatest fps ->
      check_int "two incomparable fixed points" 2 (List.length fps)
  | _ -> Alcotest.fail "expected fixed points with no greatest"

(* ---------- Q4 ---------- *)

let q4_same_for_bad () =
  let u =
    {
      ont = ont ~guards:false By_placement;
      versions = [| [| ver 0; ver 1 |] |];
      descent = [];
      pool = [| ev 0 0 Fails; Same { x = 0; v = 0; w = 1; for_ = 0 } |];
    }
  in
  let s = sel u [ (0, 1, true) ] in
  check_bool "defect on the old version: stationary at the new" true
    (stationary u 1 s);
  check_bool "a same fact carries the defect forward" false (stationary u 3 s)

(* Holding evidence that raises a warrant makes a conditioned question hold. *)
let q4_holds_wakes_a_question () =
  let u =
    {
      ont = ont By_placement;
      versions = [| [| ver 0 |]; [| ver 0 |] |];
      descent = [];
      pool =
        [|
          dec Raise (Question (1, 0)) ~conds:[ Warrant_ge (0, 0, 1) ];
          ev 0 0 Holds_;
        |];
    }
  in
  let s = sel u [ (0, 0, true); (1, 0, true) ] in
  check_bool "stationary before" true (stationary u 1 s);
  check_bool "C9 after good evidence about another piece" true
    (List.mem (C9 (1, 0, 0)) (viol u 3 s))

(* ---------- Q5, Q10 ---------- *)

let q5_and_q10_guards () =
  let mk guards =
    {
      ont = ont ~guards By_placement;
      versions = [| [| ver 7; ver 8 |]; [| ver 7 |]; [| ver 7 |] |];
      descent = [ (0, 1) ];
      pool = [| ev 0 0 Fails; ev 0 1 Holds_; ev 1 0 Holds_ |];
    }
  in
  let u = mk true in
  check_bool "reworded: guard holds it" false
    (stationary u 1 (sel u [ (0, 1, true) ]));
  check_bool "reworded and looked at: fine" true
    (stationary u 3 (sel u [ (0, 1, true) ]));
  check_bool "replaced by a descendant: guard holds it" false
    (stationary u 1 (sel u [ (1, 0, true) ]));
  check_bool "descendant looked at: fine" true
    (stationary u 5 (sel u [ (1, 0, true) ]));
  check_bool "dropped: fine, openly" true
    (stationary u 1 (sel u [ (0, 1, false) ]));
  (* the hole: id 2 has the very content the defect was found in, and no
     recorded descent from id 0 *)
  check_bool "same content, fresh id, no descent: the defect is shed" true
    (stationary u 1 (sel u [ (2, 0, true) ]));
  (* Q10: guards off, one piece and one fact *)
  let u' = mk false in
  check_bool
    "guards off: a reworded piece with a known, unexamined defect is stationary"
    true
    (stationary u' 1 (sel u' [ (0, 1, true) ]))

(* ---------- Q10, affirmations for a one-word edit ---------- *)

(* p (id 0) is predicated on two premises (1, 2) and two dependents (3, 4) are
   predicated on p. p is reworded: version 1. Count the affirm decisions
   needed to be stationary again, with and without "written against". *)
let q10_affirmations () =
  let mk written_against =
    {
      ont = ont ~written_against By_placement;
      versions =
        [|
          [|
            ver 0 ~refs:[ rf pred 1 ~against:0; rf pred 2 ~against:0 ];
            ver 1 ~refs:[ rf pred 1 ~against:0; rf pred 2 ~against:0 ];
          |];
          [| ver 0 |];
          [| ver 0 |];
          [| ver 0 ~refs:[ rf pred 0 ~against:0 ] |];
          [| ver 0 ~refs:[ rf pred 0 ~against:0 ] |];
        |];
      descent = [];
      pool =
        [|
          dec Affirm (Pair (0, 1, 1, 0));
          dec Affirm (Pair (0, 1, 2, 0));
          dec Affirm (Pair (3, 0, 0, 1));
          dec Affirm (Pair (4, 0, 0, 1));
          dec Affirm (Pair (0, 0, 1, 0));
          dec Affirm (Pair (0, 0, 2, 0));
          dec Affirm (Pair (3, 0, 0, 0));
          dec Affirm (Pair (4, 0, 0, 0));
        |];
    }
  in
  let all u v =
    sel u
      [ (0, v, true); (1, 0, true); (2, 0, true); (3, 0, true); (4, 0, true) ]
  in
  let on = mk true and off = mk false in
  check_int "switch on, before the edit: nothing needed" 0
    (cost on 0 (all on 0));
  check_int "switch on, after: one per dependent" 2 (cost on 0 (all on 1));
  check_int "switch off, before the edit: one per reference in or out" 4
    (cost off 0 (all off 0));
  check_int "switch off, after the edit, starting from those four: four more" 4
    (cost off (mask [ 4; 5; 6; 7 ]) (all off 1))

(* ---------- Q9, what an assertion and a rewrite cost ---------- *)

let q9_costs () =
  let mk standard =
    {
      ont = ont standard;
      versions =
        [| [| ver 0; ver 1 |]; [| ver 0 ~refs:[ rf pred 0 ~against:0 ] |] |];
      descent = [];
      pool =
        [|
          ev 0 0 Holds_;
          ev 0 1 Holds_;
          ev 1 0 Holds_;
          dec Accept (Piece_at (0, 0));
          dec Accept (Piece_at (0, 1));
          dec Accept (Piece_at (1, 0)) ~conds:[ Asserted_consistent 0 ];
          dec Affirm (Pair (1, 0, 0, 1));
          Same { x = 0; v = 0; w = 1; for_ = 0 };
          Same { x = 0; v = 0; w = 1; for_ = 3 };
        |];
    }
  in
  let d = mk By_decision
  and r = mk (By_rule [ (0, 1) ])
  and p = mk By_placement in
  let one u = sel u [ (0, 0, true) ] in
  let two u v = sel u [ (0, v, true); (1, 0, true) ] in
  check_int "assert one piece: decision" 1 (cost d 0 (one d));
  check_int "assert one piece: rule" 1 (cost r 0 (one r));
  check_int "assert one piece: placement" 0 (cost p 0 (one p));
  check_int "assert piece and dependent: decision" 2 (cost d 0 (two d 0));
  check_int "assert piece and dependent: rule" 2 (cost r 0 (two r 0));
  check_int "assert piece and dependent: placement" 0 (cost p 0 (two p 0));
  (* rewrite the premise, from the cheapest stationary fact set of each *)
  check_int
    "rewrite premise: decision (accept anew or carry it, and reconcile the \
     dependent)"
    2
    (cost d (mask [ 3; 5 ]) (two d 1));
  check_int
    "rewrite premise: rule (check anew or carry it, and reconcile the \
     dependent)"
    2
    (cost r (mask [ 0; 2 ]) (two r 1));
  check_int "rewrite premise: placement (reconcile the dependent)" 1
    (cost p 0 (two p 1));
  (* each of decision and rule admits what the other refuses *)
  check_bool "decision without evidence: stationary by decision" true
    (stationary d (mask [ 3 ]) (one d));
  check_bool "...and not by rule" false (stationary r (mask [ 3 ]) (one r));
  check_bool "evidence without decision: stationary by rule" true
    (stationary r (mask [ 0 ]) (one r));
  check_bool "...and not by decision" false (stationary d (mask [ 0 ]) (one d))

(* ---------- §8, the invented moves ---------- *)

(* impl-a-small-move. c = id 0, u = id 1 (predicated on c). Rule for canon:
   warrant at least 1. Criterion 0 is "follows its derivation"; criterion 1 is
   the auditor's "holds as stated, without H". *)
let move_universe () =
  {
    ont = ont ~read_as:Max_unless_bad (By_rule [ (0, 1) ]);
    versions =
      [|
        [| ver 0; ver 1 ~a:1 |];
        [|
          ver 0 ~refs:[ rf pred 0 ~against:0 ];
          ver 1 ~a:1 ~refs:[ rf pred 0 ~against:1 ];
        |];
        (* a second, unrelated pair for two-moves-at-once: x = 2, w = 3 *)
        [| ver 0; ver 1 ~a:1; ver 2 ~a:1 ~refs:[ rf pred 0 ~against:1 ] |];
        [|
          ver 0 ~refs:[ rf pred 2 ~against:0 ];
          ver 1 ~refs:[ rf pred 2 ~against:1 ];
          ver 1 ~refs:[ rf pred 2 ~against:2 ];
        |];
      |];
    descent = [];
    pool =
      [|
        (* 0 *) ev 0 0 Holds_;
        (* B checked c *)
        (* 1 *)
        ev 1 0 Holds_;
        (* B checked u *)
        (* 2 *)
        ev 0 0 Fails ~crit:1;
        (* the finding *)
        (* 3 *)
        ev 0 1 Holds_ ~crit:1;
        (* the finding looked for in the new c, not found *)
        (* 4 *)
        ev 0 1 Holds_;
        (* B checks the new c *)
        (* 5 *)
        ev 1 1 Holds_;
        (* B checks the new u *)
        (* 6 *)
        dec Affirm (Pair (1, 0, 0, 1));
        (* or: u's author keeps u as it was *)
        (* 7 *)
        ev 2 0 Holds_;
        (* 8 *) ev 3 0 Holds_;
        (* 9 *) ev 2 0 Fails ~crit:1;
        (* 10 *) ev 2 1 Holds_ ~crit:1;
        (* 11 *) ev 2 1 Holds_;
        (* 12 *) ev 3 1 Holds_;
        (* 13 *) ev 2 2 Holds_ ~crit:1;
        (* 14 *) ev 2 2 Holds_;
        (* 15 *) ev 3 2 Holds_;
      |];
  }

let small_move () =
  let u = move_universe () in
  let s0 = sel u [ (0, 0, true); (1, 0, true) ] in
  let s1 = sel u [ (0, 1, true); (1, 1, true) ] in
  check_bool "S0 stationary" true (stationary u (mask [ 0; 1 ]) s0);
  let after_finding = viol u (mask [ 0; 1; 2 ]) s0 in
  check_bool "the finding: c is known wrong" true
    (List.mem (C6_fail (0, 0, 1)) after_finding);
  check_bool "...the rule no longer asserts c" true
    (List.mem (C5_std 0) after_finding);
  check_bool "...and u rests on something inconsistent" true
    (List.mem (C5_rest (1, 0)) after_finding);
  (* 09:25: c rewritten, u not yet *)
  let mid = sel u [ (0, 1, true); (1, 0, true) ] in
  let v = viol u (mask [ 0; 1; 2 ]) mid in
  check_bool "rewritten c still carries the finding as a guard" true
    (List.mem (C6_guard (0, 0, 1)) v);
  check_bool "u's reference to c is unreconciled" true (List.mem (C4 (1, 0)) v);
  check_bool "S1 stationary" true (stationary u (mask [ 0; 1; 2; 3; 4; 5 ]) s1);
  (* Two, not the three the move used: with answering being nothing but
     evidence that holds on the finding's criterion, the answer (fact 3) is
     also all the warrant the rule asks of the new c, and B's recheck (fact
     4) is not needed. *)
  check_int "the fewest facts that close it" 2 (cost u (mask [ 0; 1; 2 ]) s1);
  check_bool "...namely the answer and the check of the new u" true
    (stationary u (mask [ 0; 1; 2; 3; 5 ]) s1);
  (* the changeset is the pair: going back to S0 is not stationary, the finding stays learned *)
  check_bool "going back to S0 is not stationary" false
    (stationary u (mask [ 0; 1; 2; 3; 4; 5 ]) s0);
  (* an alternative close the move did not take: keep u as written, affirmed against the new c *)
  check_bool "u kept and affirmed, not rechecked" true
    (stationary u (mask [ 0; 1; 2; 3; 4; 6 ]) mid)

let two_moves () =
  let u = move_universe () in
  let base = mask [ 0; 1; 7; 8 ] in
  let s0 = sel u [ (0, 0, true); (1, 0, true); (2, 0, true); (3, 0, true) ] in
  check_bool "S0 stationary" true (stationary u base s0);
  let both = base lor mask [ 2; 9 ] in
  (* M1 closes while M2 is open *)
  let m1 = sel u [ (0, 1, true); (1, 1, true); (2, 0, true); (3, 0, true) ] in
  let f1 = both lor mask [ 3; 4; 5 ] in
  check_bool "after M1's repair the whole is not stationary" false
    (stationary u f1 m1);
  check_bool "...it is stationary on c and u" true
    (stationary_on u f1 m1 [ 0; 1 ]);
  check_bool "...and not on x and w" false (stationary_on u f1 m1 [ 2; 3 ]);
  (* M2 then closes independently *)
  let m12 = sel u [ (0, 1, true); (1, 1, true); (2, 1, true); (3, 1, true) ] in
  check_bool "both repaired: stationary" true
    (stationary u (f1 lor mask [ 10; 11; 12 ]) m12);
  (* second half: x's repair comes to rest on c's new version (x version 2) *)
  let m2_alone =
    sel u [ (0, 0, true); (1, 0, true); (2, 2, true); (3, 2, true) ]
  in
  let f2 = both lor mask [ 13; 14; 15 ] in
  check_bool "x resting on the new c cannot close while c is unrepaired" false
    (stationary_on u f2 m2_alone [ 2; 3 ]);
  let merged =
    sel u [ (0, 1, true); (1, 1, true); (2, 2, true); (3, 2, true) ]
  in
  check_bool "the two close together" true (stationary u (f1 lor f2) merged)

(* impl-a-finding-is-answered, step 4: a WRONG finding, contested, the piece
   left alone. Here that cannot be said. *)
let wrong_finding () =
  let u =
    {
      ont = ont By_placement;
      versions = [| [| ver 0; ver 0 |] |];
      descent = [];
      pool =
        [|
          ev 0 0 Fails ~crit:1;
          (* D's finding: wrong *)
          ev 0 0 Holds_ ~crit:1;
          (* E's check of the same question, same version *)
          ev 0 1 Holds_ ~crit:1;
          Same { x = 0; v = 0; w = 1; for_ = 1 };
        |];
    }
  in
  let untouched = sel u [ (0, 0, true) ] in
  let any = ref false in
  for d = 0 to 15 do
    if d land 1 = 1 && stationary u d untouched then any := true
  done;
  check_bool "no set of facts makes the untouched piece stationary again" false
    !any;
  check_bool "E's check registers as a conflict" true
    (List.mem (C6_conflict (0, 0, 1)) (viol u 3 untouched));
  (* the only way out without a waiver: a new version, even an identical one *)
  check_bool "an identical new version, looked at afresh, is stationary" true
    (stationary u (mask [ 0; 1; 2 ]) (sel u [ (0, 1, true) ]));
  check_bool "...or E's check carried to it by a same fact" true
    (stationary u (mask [ 0; 1; 3 ]) (sel u [ (0, 1, true) ]))

(* Q8's outline. O (id 2) references c (0) and x (1) by one kind; c and x are
   each repaired. What must the kind rely on for the two repairs not to meet
   through O? *)
let outline relies_kind =
  {
    ont = ont By_placement;
    versions =
      [|
        [| ver 0; ver 1 ~a:1 |];
        [| ver 0; ver 1 ~a:1 |];
        [|
          ver 0
            ~refs:[ rf relies_kind 0 ~against:0; rf relies_kind 1 ~against:0 ];
          ver 0
            ~refs:[ rf relies_kind 0 ~against:1; rf relies_kind 1 ~against:0 ];
          ver 0
            ~refs:[ rf relies_kind 0 ~against:0; rf relies_kind 1 ~against:1 ];
        |];
      |];
    descent = [];
    pool =
      [|
        ev 0 0 Fails;
        ev 1 0 Fails;
        ev 0 1 Holds_;
        ev 1 1 Holds_;
        dec Affirm (Pair (2, 0, 0, 1));
        dec Affirm (Pair (2, 0, 1, 1));
      |];
  }

let q8_outline () =
  let st u f l = stationary u f (sel u l) in
  (* existence only: the repairs never touch O *)
  let u = outline names in
  check_bool "names: both repairs, O untouched" true
    (st u (mask [ 0; 1; 2; 3 ]) [ (0, 1, true); (1, 1, true); (2, 0, true) ]);
  (* assertions or everything: O must be reconciled with each repair *)
  List.iter
    (fun k ->
      let u = outline k in
      check_bool "relying kind: O untouched is not stationary" false
        (st u
           (mask [ 0; 1; 2; 3 ])
           [ (0, 1, true); (1, 1, true); (2, 0, true) ]);
      (* reconciled by affirm decisions: facts, so the two repairs compose *)
      check_bool
        "repair of c alone, O affirmed against it: stationary on c and O" true
        (stationary_on u
           (mask [ 0; 2; 4 ])
           (sel u [ (0, 1, true); (1, 0, true); (2, 0, true) ])
           [ 0; 2 ]);
      check_bool "both repairs, each with its own affirmation of O: composes"
        true
        (st u
           (mask [ 0; 1; 2; 3; 4; 5 ])
           [ (0, 1, true); (1, 1, true); (2, 0, true) ]);
      (* reconciled by rewriting O: each repair selects its own O, and no
         selection holds both *)
      check_bool
        "repair of c with O rewritten against it, then x repaired: O's other \
         reference is unreconciled"
        false
        (st u
           (mask [ 0; 1; 2; 3 ])
           [ (0, 1, true); (1, 1, true); (2, 1, true) ]);
      check_bool "...and the same from the other side" false
        (st u
           (mask [ 0; 1; 2; 3 ])
           [ (0, 1, true); (1, 1, true); (2, 2, true) ]))
    [ narr; pred ]

(* §6: "stationary on the pieces whose selection or consistency differs".
   A piece with a waived defect is inconsistent before and after a second,
   unwaived defect arrives, so it is not among the pieces that differ, and
   the pair counts as an atomic changeset with something uncovered in it. *)
let changeset_blind_spot () =
  let u =
    {
      ont = ont By_placement;
      versions = [| [| ver 0 |] |];
      descent = [];
      pool =
        [|
          ev 0 0 Fails;
          dec Waive (Inst (C6_fail (0, 0, 0)));
          dec Waive (Inst (C6_guard (0, 0, 0)));
          ev 0 0 Fails ~crit:1;
        |];
    }
  in
  let s = sel u [ (0, 0, true) ] in
  let before = mask [ 0; 1; 2 ] and after = mask [ 0; 1; 2; 3 ] in
  check_bool "before: stationary, by waiver" true (stationary u before s);
  check_bool "after a second defect: not stationary" false
    (stationary u after s);
  let x f = match frontier u f s with Some fr -> fr.x | None -> -1 in
  check_bool "yet the piece's consistency did not change" true
    (x before = x after);
  check_bool "so the pair is stationary on the pieces that differ (none)" true
    (stationary_on u after s [])

let () =
  let t n f = Alcotest.test_case n `Quick f in
  Alcotest.run "kernel"
    [
      ( "Q6",
        [
          t "no fixed point" q6_liar; t "no greatest fixed point" q6_no_greatest;
        ] );
      ( "Q4",
        [
          t "same for failing evidence" q4_same_for_bad;
          t "good evidence wakes a question" q4_holds_wakes_a_question;
        ] );
      ( "Q5 Q10",
        [
          t "guards" q5_and_q10_guards;
          t "affirmations per edit" q10_affirmations;
        ] );
      ("Q9", [ t "costs and disagreements" q9_costs ]);
      ("Q8", [ t "an outline over two repairs" q8_outline ]);
      ( "changeset",
        [ t "a second defect on a waived piece" changeset_blind_spot ] );
      ( "moves",
        [
          t "a small move" small_move;
          t "two moves at once" two_moves;
          t "a wrong finding" wrong_finding;
        ] );
    ]
