(* Runs the OCaml that Rocq extracted from rocq.v: first on the shared
   instance, then on made-up outlines of n results, beside the same naive
   algorithm written by hand in OCaml and beside a depth-first walk with a
   set (what one would write without having to prove it). *)
open Rocq_extracted

let time f =
  let t = Sys.time () in
  let r = f () in
  (r, Sys.time () -. t)

(* an outline pointing at n results, each holding a claim and a step; every
   third pointer provisional *)
let big n =
  let result i =
    let s = string_of_int i in
    Result
      { r_name = "T" ^ s;
        formal_claim = holds { v_name = "c" ^ s; content = "claim " ^ s };
        derivation = [ holds { v_name = "d" ^ s; content = "step " ^ s } ];
        description = Promised;
        eli8 = None }
  in
  let entry i =
    Entry (Filled (PointsAt ("T" ^ string_of_int i), i mod 3 = 0))
  in
  { store =
      AnOutline { o_name = "O"; entries = List.init n entry }
      :: List.init n result;
    roots = [ "O" ] }

(* the same algorithm, by hand, with the standard library *)
let hand_canon v =
  let asm = assemblies v in
  let out n = List.concat_map (fun (m, l) -> if m = n then l else []) asm in
  let rec nodup = function
    | [] -> []
    | x :: xs -> if List.mem x xs then nodup xs else x :: nodup xs
  in
  let step s = nodup (s @ List.concat_map out s) in
  let rec iter n x = if n = 0 then x else iter (n - 1) (step x) in
  let universe = v.roots @ List.concat_map snd asm in
  iter (List.length universe + 1) v.roots

(* what one would write unproved: a walk that remembers where it has been *)
module SS = Set.Make (String)

let walk_canon v =
  let tbl = Hashtbl.create 64 in
  List.iter (fun (m, l) -> Hashtbl.replace tbl m l) (assemblies v);
  let rec go seen n =
    if SS.mem n seen then seen
    else
      List.fold_left go (SS.add n seen)
        (Option.value ~default:[] (Hashtbl.find_opt tbl n))
  in
  List.fold_left go SS.empty v.roots

let () =
  Printf.printf "instance, extracted canon_list: %s\n"
    (String.concat ", " (canon_list here));
  Printf.printf "instance, extracted promised: %s\n"
    (String.concat "; "
       (List.map (fun (a, s) -> s ^ " of " ^ a) (promised here)));
  List.iter
    (fun n ->
      let v = big n in
      let e, te = time (fun () -> canon_list v) in
      let h, th = time (fun () -> hand_canon v) in
      let w, tw = time (fun () -> walk_canon v) in
      Printf.printf
        "n=%4d  in canon: extracted %d, by hand %d, walk %d\n\
        \        seconds: extracted %.3f, same rounds by hand %.3f, walk %.4f\n"
        n (List.length e) (List.length h) (SS.cardinal w) te th tw;
      assert (List.sort compare e = List.sort compare h);
      assert (List.sort compare e = SS.elements w))
    [ 50; 100; 200 ]
