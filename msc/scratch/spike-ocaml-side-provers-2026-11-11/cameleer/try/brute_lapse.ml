#use "../m0.ml"
(* every reads list of length <= 3 and sel of length <= 3 over 2 pieces, 3 versions *)
let pairs = List.concat_map (fun q -> List.map (fun v -> (q, v)) [0;1;2]) [0;1]
let rec lists n = if n = 0 then [[]] else
  let shorter = lists (n-1) in shorter @ List.concat_map (fun l -> List.map (fun p -> p :: l) pairs) (List.filter (fun l -> List.length l = n-1) shorter)
let () =
  let n = ref 0 and bad = ref 0 in
  List.iter (fun reads -> List.iter (fun sel -> List.iter (fun q -> List.iter (fun v ->
    if in_reads q reads && reads_stand reads sel && v <> selected q sel then begin
      incr n; if reads_stand reads ((q, v) :: sel) then incr bad end) [0;1;2]) [0;1]) (lists 3)) (lists 3);
  Printf.printf "a_read_lapses_in_the_list: %d cases where the premises hold, %d counterexamples\n" !n !bad
