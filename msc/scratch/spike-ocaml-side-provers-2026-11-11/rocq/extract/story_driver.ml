(* The story of note 22 §4.3, run by the OCaml that Rocq extracted from M0.
   The lines of events and the conditions both come from the Rocq files;
   nothing here is written by hand except the printing. *)
open M0_extracted

let show f =
  if f = [] then "nothing"
  else String.concat ", " (List.map (fun (n, p) -> Printf.sprintf "%d on %s" n p) f)

let () =
  List.iter
    (fun (t, l) ->
      let a = frontier looks l and b = frontier strict l in
      Printf.printf "%-6s owed: %s%s\n" t (show a)
        (if a = b then "" else "\n       (if a write does not count as a look: " ^ show b ^ ")");
      Printf.printf "       close: %s\n"
        (match close looks l with Some _ -> "yes, a checkpoint" | None -> "refused"))
    [ ("S0", s0); ("08:30", r0830); ("09:00", r0900); ("10:00", r1000);
      ("10:30", r1030); ("11:00", r1100); ("11:30", r1130); ("12:00", r1200);
      ("13:00", r1300); ("14:00", r1400) ];
  (* how fast: the whole story's ten frontiers, many times over *)
  let t = Sys.time () in
  let n = 2000 in
  for _ = 1 to n do
    List.iter (fun l -> ignore (frontier looks l))
      [ s0; r0830; r0900; r1000; r1030; r1100; r1130; r1200; r1300; r1400 ]
  done;
  Printf.printf "%d frontiers in %.2f s\n" (n * 10) (Sys.time () -. t)
