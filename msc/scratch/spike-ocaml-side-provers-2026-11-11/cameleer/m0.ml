(* A cut of the small model M0 (../../spike-formal-perspectives-2026-11-10/
   01-common-reading.md) as plain OCaml with its specification beside it.

   What is here: the state of one line as of now; when evidence applies; and
   three things owed about a piece: a finding applies to it (part of
   condition 4), it has no applying evidence that holds on a criterion (the
   "what its root asks" part of 5), and a reference of it was written against
   a version its target no longer has, with no affirm (condition 2).

   What is not: guards (4's second half), resting on what is owed (5's second
   half), inner dependencies (6), promises (8), questions (9), canon (in the
   slice file), set aside, same, forks. The story file says what that costs.

   Every function is ordinary OCaml, marked [@logic] so that the
   specification may speak of it directly: there is ONE text for each
   condition, and the lemmas at the foot are about that text. *)

type evidence = {
  subj : int;  (* the piece it is about *)
  ver : int;  (* at this version *)
  crit : int;  (* asked by this criterion *)
  holds : bool;
  reads : (int * int) list;  (* having read these pieces at these versions *)
}

(* Which version of each piece is selected: latest write first. *)
let[@logic] rec selected (p : int) (sel : (int * int) list) : int =
  match sel with
  | [] -> -1
  | (q, v) :: r -> if q = p then v else selected p r
(*@ v = selected p sel
      variant sel *)

let[@logic] rec reads_stand (reads : (int * int) list) (sel : (int * int) list)
    : bool =
  match reads with
  | [] -> true
  | (q, w) :: r -> selected q sel = w && reads_stand r sel
(*@ b = reads_stand reads sel
      variant reads *)

(* Evidence applies: its subject is at the version it is about, and
   everything it read is as it was read. *)
let[@logic] applies (e : evidence) (sel : (int * int) list) : bool =
  selected e.subj sel = e.ver && reads_stand e.reads sel
(*@ b = applies e sel *)

(* Condition 4, first half: a finding applies to p. *)
let[@logic] rec known_wrong (p : int) (evs : evidence list)
    (sel : (int * int) list) : bool =
  match evs with
  | [] -> false
  | e :: r ->
      (e.subj = p && (not e.holds) && applies e sel) || known_wrong p r sel
(*@ b = known_wrong p evs sel
      variant evs *)

(* Condition 5, first half: p has applying evidence that holds on c. *)
let[@logic] rec checked (c : int) (p : int) (evs : evidence list)
    (sel : (int * int) list) : bool =
  match evs with
  | [] -> false
  | e :: r ->
      (e.subj = p && e.holds && e.crit = c && applies e sel) || checked c p r sel
(*@ b = checked c p evs sel
      variant evs *)

(* Does any evidence about p read q? *)
let[@logic] rec in_reads (q : int) (reads : (int * int) list) : bool =
  match reads with [] -> false | (x, _) :: r -> x = q || in_reads q r
(*@ b = in_reads q reads
      variant reads *)

let[@logic] rec reads_of (p : int) (q : int) (evs : evidence list) : bool =
  match evs with
  | [] -> false
  | e :: r -> (e.subj = p && in_reads q e.reads) || reads_of p q r
(*@ b = reads_of p q evs
      variant evs *)

(* Condition 2: p's references, as (target, version written against), and
   the affirms on the line as (p, p's version, target, target's version). *)
let[@logic] rec affirmed (p : int) (pv : int) (q : int) (qv : int)
    (aff : (int * int * int * int) list) : bool =
  match aff with
  | [] -> false
  | (a, av, b, bv) :: r ->
      (a = p && av = pv && b = q && bv = qv) || affirmed p pv q qv r
(*@ b = affirmed p pv q qv aff
      variant aff *)

let[@logic] rec unreconciled (p : int) (refs : (int * int) list)
    (sel : (int * int) list) (aff : (int * int * int * int) list) : bool =
  match refs with
  | [] -> false
  | (q, w) :: r ->
      (selected q sel <> w
       && not (affirmed p (selected p sel) q (selected q sel) aff))
      || unreconciled p r sel aff
(*@ b = unreconciled p refs sel aff
      variant refs *)

(* ---------- what is proved, for every state ---------- *)

(* Good news does no harm, for these two conditions. *)
(*@ lemma holding_evidence_adds_no_finding:
      forall p e evs sel. e.holds ->
        known_wrong p (e :: evs) sel = known_wrong p evs sel *)

(*@ lemma evidence_never_unchecks:
      forall c p e evs sel. checked c p evs sel -> checked c p (e :: evs) sel *)

(* A write to q changes the selected version of q and of nothing else. *)
(*@ lemma write_is_local:
      forall p q v sel. p <> q -> selected p ((q, v) :: sel) = selected p sel *)

(* Evidence that did not read q still stands as it stood. *)
(*@ lemma unread_reads_stand:
      forall reads q v sel. not (in_reads q reads) ->
        reads_stand reads ((q, v) :: sel) = reads_stand reads sel *)

(* Locality: a write to a piece that p is not, and that no evidence about p
   read, changes neither of the two things owed about p from evidence. *)
(*@ lemma write_elsewhere_leaves_findings:
      forall p q v evs sel. p <> q -> not (reads_of p q evs) ->
        known_wrong p evs ((q, v) :: sel) = known_wrong p evs sel *)

(*@ lemma write_elsewhere_leaves_checks:
      forall c p q v evs sel. p <> q -> not (reads_of p q evs) ->
        checked c p evs ((q, v) :: sel) = checked c p evs sel *)

(* And the other way: evidence that read q lapses when q is written at a
   version other than the one read. Stated of the list of reads, so that the
   induction has a list to go down; the statement about evidence follows. *)
(*@ lemma a_write_selects:
      forall q v sel. selected q ((q, v) :: sel) = v *)

(*@ lemma a_read_lapses_in_the_list:
      forall reads q v sel. in_reads q reads -> reads_stand reads sel ->
        v <> selected q sel -> not (reads_stand reads ((q, v) :: sel)) *)

(*@ lemma a_read_lapses:
      forall e q v sel. in_reads q e.reads -> applies e sel ->
        v <> selected q sel -> not (applies e ((q, v) :: sel)) *)
