(* Runs the slice in cameleer.ml and prints what it computes. Kept apart
   because Cameleer stops with an internal error on a file that prints. *)
#use "cameleer.ml"

let label = function
  | 1 -> "O" | 2 -> "T" | 3 -> "U" | 4 -> "c" | 5 -> "d" | 6 -> "k" | 7 -> "u"
  | n -> string_of_int n

let () =
  (match canon_here with
  | Some s ->
      Printf.printf "canon (checked closed, so exact): %s\n"
        (String.concat ", " (List.map label (List.sort compare s)))
  | None -> print_endline "the list did not pass its own check");
  List.iter
    (fun (owner, slot) ->
      Printf.printf "promised and empty: %s of %s\n" slot (label owner))
    promised_here;
  Printf.printf "c says: %s\n" c.content
