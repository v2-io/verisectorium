(* note 22 §4.3, row by row, through the cut in m0.ml. Plain OCaml:
     ocaml m0_story.ml
   The functions it calls are the ones the lemmas in m0.ml are about. *)
#use "m0.ml"

let o = 1 and t = 2 and uu = 3 and c = 4 and d = 5 and e = 6 and k = 7 and u = 8
let valid = 0 and case_x = 1 and whole = 2
let name = function
  | 1 -> "O" | 2 -> "T" | 3 -> "U" | 4 -> "c" | 5 -> "d" | 6 -> "e" | 7 -> "k" | 8 -> "u" | _ -> "?"

type line = {
  sel : (int * int) list;
  evs : evidence list;
  aff : (int * int * int * int) list;
  u_refs : (int * int) list;  (* u is predicated on c, written against this version *)
}

let ev subj ver crit holds reads = { subj; ver; crit; holds; reads }
let write p v l = { l with sel = (p, v) :: l.sel }
let learn x l = { l with evs = x :: l.evs }

let owed l =
  let claim p refs =
    (if known_wrong p l.evs l.sel then [ name p ^ " is known wrong" ] else [])
    @ (if checked valid p l.evs l.sel then [] else [ name p ^ " is unchecked" ])
    @ if unreconciled p refs l.sel l.aff then [ name p ^ " was written against another c" ] else []
  and result p = if checked whole p l.evs l.sel then [] else [ name p ^ " is not read whole" ] in
  claim c [] @ claim u l.u_refs @ result t @ result uu

let show row l =
  Printf.printf "%-28s %s\n" row
    (match owed l with [] -> "(nothing owed in this cut)" | xs -> String.concat "; " xs)

let () =
  let s0 =
    { sel = [ (c, 1); (d, 1); (e, 1); (k, 1); (u, 1); (t, 1); (uu, 1); (o, 1) ];
      evs =
        [ ev c 1 valid true [ (d, 1) ]; ev u 1 valid true [ (c, 1) ];
          ev t 1 whole true [ (c, 1); (d, 1); (e, 1); (k, 1) ];
          ev uu 1 whole true [ (u, 1) ] ];
      aff = [ (e, 1, c, 1); (k, 1, e, 1) ];
      u_refs = [ (c, 1) ] }
  in
  show "0  S0" s0;
  let r1 = learn (ev c 1 case_x false []) s0 in
  show "1  08:30 a finding on c" r1;
  let r2 = r1 |> write c 11 |> write d 11 |> learn (ev c 11 valid true [ (d, 11) ]) in
  show "2  09:00 fork: c1', d1'" r2;
  let r3 = { r1 with evs = r2.evs } in
  show "3  10:00 rewind" r3;
  let r4 = r3 |> write c 2 |> write d 2 |> write k 2 in
  let r4 = { r4 with aff = (e, 1, c, 2) :: r4.aff } in
  show "4  10:30 c2, d2, k2" r4;
  let r5 = r4 |> learn (ev c 2 valid true [ (d, 2) ]) |> learn (ev c 2 case_x true []) in
  show "5  11:00 c2 checked" r5;
  let r6 = write d 3 r5 in
  show "6  11:30 d3" r6;
  let r7 = learn (ev c 2 valid true [ (d, 3) ]) r6 in
  show "7  12:00 c2 checked again" r7;
  let r8 = write u 2 r7 in
  let r8 = { r8 with u_refs = [ (c, 2) ] } |> learn (ev u 2 valid true [ (c, 2) ]) in
  show "8  13:00 u2" r8;
  let r9 =
    r8
    |> learn (ev t 1 whole true [ (c, 2); (d, 3); (e, 1); (k, 2) ])
    |> learn (ev uu 1 whole true [ (u, 2) ])
  in
  show "9  14:00 whole reads" r9
