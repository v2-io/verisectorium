(* Runs the OCaml that Why3 extracted from the slice. *)
let () =
  let canon, promised = Slice_extracted.answer () in
  (match canon with
   | Some ids -> Printf.printf "canon (ids): %s\n" (String.concat ", " (List.map Z.to_string ids))
   | None -> print_endline "canon: the check did not pass, so no answer is given");
  List.iter (fun (owner, slot) -> Printf.printf "promised and empty: %s of %s\n" slot (Z.to_string owner)) promised;
  print_endline "ids: c=1 d=2 k=3 T=4 u=5 U=6 O=7"
