(* Note 22 §4.3, the ten rows, as lines of events; and what M0's conditions
   say is owed at each. *)

From Stdlib Require Import List String Bool.
From Vk Require Import Reach M0.
Import ListNotations.
Open Scope string_scope.
Open Scope list_scope.

Definition shapes (p : piece) (v : version) : option shape :=
  if eqs p "c" then Some (Veritoid true [])
  else if eqs p "u" then Some (Veritoid true ["c"])
  else if eqs p "d" || eqs p "e" || eqs p "k" then Some (Veritoid false [])
  else if eqs p "T" then
    Some (Assembly true [("claim", "c", false); ("derivation", "d", false);
                         ("description", "e", false); ("eli8", "k", false)])
  else if eqs p "U" then Some (Assembly true [("claim", "u", false)])
  else if eqs p "O" then Some (Assembly false [("1", "T", false); ("2", "U", false)])
  else None.

Definition ont (write_looks : bool) : ontology :=
  {| shape_of := shapes;
     inner := [("description", "claim"); ("eli8", "description")];
     write_looks := write_looks |}.

Definition ev name p v criterion holds reads : event :=
  Evidence {| e_name := name; e_piece := p; e_version := v; e_criterion := criterion;
              e_holds := holds; e_reads := reads |}.

Definition S0 : line :=
  [ Write "c" "c1"; Write "d" "d1"; Write "e" "e1"; Write "k" "k1"; Write "u" "u1";
    Write "T" "T1"; Write "U" "U1"; Write "O" "O1"; MarkRoot "O";
    ev "E1" "c" "c1" "valid" true [("d", "d1")];
    ev "E2" "u" "u1" "valid" true [("c", "c1")];
    ev "E3" "T" "T1" "whole" true [("c", "c1"); ("d", "d1"); ("e", "e1"); ("k", "k1")];
    ev "E4" "U" "U1" "whole" true [("u", "u1")];
    Affirm "e" "e1" "c" "c1"; Affirm "k" "k1" "e" "e1" ].

Definition E5 := ev "E5" "c" "c1" "caseX" false [].
Definition E6 := ev "E6" "c" "c1'" "valid" true [("d", "d1'")].

Definition r0830 := S0 ++ [E5].
Definition r0900 := r0830 ++ [Write "c" "c1'"; Write "d" "d1'"; E6].
(* the rewind: the fork's two writes are gone; E6 is in the base and stays *)
Definition r1000 := r0830 ++ [E6].
Definition r1030 := r1000 ++ [Write "c" "c2"; Write "d" "d2"; Write "k" "k2"; Affirm "e" "e1" "c" "c2"].
Definition r1100 := r1030 ++ [ev "E7" "c" "c2" "valid" true [("d", "d2")]; ev "E8" "c" "c2" "caseX" true []].
Definition r1130 := r1100 ++ [Write "d" "d3"].
Definition r1200 := r1130 ++ [ev "E9" "c" "c2" "valid" true [("d", "d3")]].
Definition r1300 := r1200 ++ [Write "u" "u2"; ev "E10" "u" "u2" "valid" true [("c", "c2")]].
Definition r1400 := r1300 ++ [ev "E11" "T" "T1" "whole" true [("c", "c2"); ("d", "d3"); ("e", "e1"); ("k", "k2")];
                              ev "E12" "U" "U1" "whole" true [("u", "u2")]].

(* ---------- what is owed at each row ----------

   Each pair is (condition of note 22 §4.1, piece). [looks] is the reading in
   which writing k2, with e1 already there, counts as having looked at the
   two together; [strict] is the reading in which it does not. The story does
   not say which. They differ from 10:30 on, by one item. *)

Definition looks := ont true.
Definition strict := ont false.

Example canon_S0 : canon looks S0 = ["O"; "T"; "U"; "c"; "d"; "e"; "k"; "u"].
Proof. reflexivity. Qed.

Example at_S0 : frontier looks S0 = [] /\ frontier strict S0 = [].
Proof. split; reflexivity. Qed.

(* 08:30. c is known wrong; u rests on it. As the note says. *)
Example at_0830 : frontier looks r0830 = [(4, "c"); (5, "u")].
Proof. reflexivity. Qed.

(* 09:00. The note: "c1' is fine. But u1 needs the stronger conclusion."
   The conditions: c1' is NOT fine (the case found in c1 has not been looked
   for in c1'); T has not been read whole as it now is; e1 has not been looked
   at beside c1'; u was written against c1 and rests on c. *)
Example at_0900 : frontier looks r0900 = [(5, "T"); (6, "T"); (4, "c"); (2, "u"); (5, "u")].
Proof. reflexivity. Qed.

(* 10:00. "As at 08:30": exactly, though the line now has one more event. *)
Example at_1000 : frontier looks r1000 = frontier looks r0830.
Proof. reflexivity. Qed.

(* 10:30. The note lists c2 unchecked, T's whole read, u1 against c1. The
   conditions add: the case has not yet been looked for in c2 (4 on c). *)
Example at_1030 : frontier looks r1030 = [(5, "T"); (4, "c"); (5, "c"); (2, "u"); (5, "u")].
Proof. reflexivity. Qed.

Example at_1030_strict :
  frontier strict r1030 = [(5, "T"); (6, "T"); (4, "c"); (5, "c"); (2, "u"); (5, "u")].
Proof. reflexivity. Qed.

Example at_1100 : frontier looks r1100 = [(5, "T"); (2, "u"); (5, "u")].
Proof. reflexivity. Qed.

(* 11:30. d is rewritten; the check of c read the old d; c is unchecked again. *)
Example at_1130 : frontier looks r1130 = [(5, "T"); (5, "c"); (2, "u"); (5, "u")].
Proof. reflexivity. Qed.

Example at_1200 : frontier looks r1200 = [(5, "T"); (2, "u"); (5, "u")].
Proof. reflexivity. Qed.

(* 13:00. The whole reads of T and U. As the note says. *)
Example at_1300 : frontier looks r1300 = [(5, "T"); (5, "U")].
Proof. reflexivity. Qed.

(* 14:00. Empty, and the fork can close: under one reading. Under the other,
   k2 was never looked at beside e1, and it cannot. *)
Example at_1400 : frontier looks r1400 = [].
Proof. reflexivity. Qed.

Example at_1400_strict : frontier strict r1400 = [(6, "T")].
Proof. reflexivity. Qed.

(* The first repair, c1', was abandoned at 10:00. Its check E6 is still in
   the base. It changes nothing on the line that no longer has c1'. *)
Example abandoned_work_is_inert : frontier looks (r0830 ++ [E6]) = frontier looks r0830.
Proof. reflexivity. Qed.

(* Canon at S0, by its definition and not by the function. *)
Theorem canon_S0_by_the_rules : forall r,
  Reached (out_slots looks S0) (roots S0) r
  <-> In r ["O"; "T"; "U"; "c"; "d"; "e"; "k"; "u"].
Proof. intros r. rewrite <- canon_S0. apply canon_is_reached. Qed.
