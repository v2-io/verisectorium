(* Runs the OCaml that Why3 extracted from M0 and the story. *)
let name p = List.assoc (Z.to_int p) [ (1, "c"); (2, "d"); (3, "e"); (4, "k"); (5, "u"); (6, "T"); (7, "U"); (8, "O") ]
let rows = [ "0 S0"; "1 08:30 E5 fails"; "2 09:00 fork F: c1', d1', E6"; "3 10:00 F rewound"; "4 10:30 c2 d2 k2, affirm(e1,c2)";
             "5 11:00 E7, E8"; "6 11:30 d3"; "7 12:00 E9"; "8 13:00 u2, E10"; "9 14:00 E11, E12"; "9' and k2 affirmed beside e1" ]
let () =
  List.iter2
    (fun row items ->
      Printf.printf "%-34s %s\n" row
        (if items = [] then "(empty: stationary)"
         else String.concat " " (List.map (fun (M0_extracted.Owed (c, p)) -> Printf.sprintf "%s:%s" (Z.to_string c) (name p)) items)))
    rows (M0_extracted.run ())
