(* explore_main SEED_FROM SEED_TO N NV M FLAGS CHECKS
   FLAGS: letters among a (assembly) m (monotone read_as) s (no same for bad
   evidence) c (no conditions on raise/promise/waive) b (no bad evidence).
   CHECKS: digits among 2..9. *)
open Kernel

let () =
  let a = Sys.argv in
  let s0 = int_of_string a.(1) and s1 = int_of_string a.(2) in
  let n = int_of_string a.(3)
  and nv = int_of_string a.(4)
  and m = int_of_string a.(5) in
  let fl = a.(6) and ch = a.(7) in
  let cfg =
    {
      Explore.n;
      nv;
      m;
      asm = String.contains fl 'a';
      mono = String.contains fl 'm';
      no_same_bad = String.contains fl 's';
      no_neg_cond = String.contains fl 'c';
      no_bad = String.contains fl 'b';
    }
  in
  let w c = String.contains ch c in
  let which =
    {
      Explore.w2 = w '2';
      w3 = w '3';
      w4 = w '4';
      w5 = w '5';
      w6 = w '6';
      w7 = w '7';
      w8 = w '8';
      w9 = w '9';
    }
  in
  let t0 = Unix.gettimeofday () in
  for seed = s0 to s1 do
    let st = Random.State.make [| seed |] in
    Explore.run_universe which (Explore.gen_universe st cfg);
    (* progress on stderr as it goes, so a long run is never silent *)
    Printf.eprintf "seed %d done, %.0fs, %d states\n%!" seed
      (Unix.gettimeofday () -. t0)
      !Explore.visited
  done;
  Printf.printf "seeds %d..%d ids=%d versions=%d pool=%d flags=%s checks=%s\n"
    s0 s1 n nv m fl ch;
  Explore.report stdout
