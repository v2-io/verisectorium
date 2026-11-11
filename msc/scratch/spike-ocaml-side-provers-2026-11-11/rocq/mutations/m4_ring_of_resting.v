From Stdlib Require Import List String Bool. From Vk Require Import Reach M0.
Import ListNotations. Open Scope string_scope. Open Scope list_scope.
(* Not a mutation: two claims predicated on each other, each checked, each
   written against the other. Does "rests on" stop, and what is owed? *)
Definition shapes (p : piece) (v : version) : option shape :=
  if eqs p "a" then Some (Veritoid true ["b"])
  else if eqs p "b" then Some (Veritoid true ["a"])
  else if eqs p "O" then Some (Assembly false [("1", "a", false); ("2", "b", false)])
  else None.
Definition O := {| shape_of := shapes; inner := []; write_looks := true |}.
Definition ev name p v reads : event :=
  Evidence {| e_name := name; e_piece := p; e_version := v; e_criterion := "valid"; e_holds := true; e_reads := reads |}.
Definition ring : line :=
  [ Write "a" "a1"; Write "b" "b1"; Write "O" "O1"; MarkRoot "O";
    Affirm "a" "a1" "b" "b1"; ev "Ea" "a" "a1" [("b", "b1")]; ev "Eb" "b" "b1" [("a", "a1")] ].
Compute rests_on O ring "a".
Compute frontier O ring.
Compute frontier O (ring ++ [Evidence {| e_name := "F"; e_piece := "b"; e_version := "b1"; e_criterion := "x"; e_holds := false; e_reads := [] |}]).
