(* explore_main SEED_FROM SEED_TO N M FLAGS CHECKS      (draft 4)
   N ids, M pool events.
   FLAGS: letters among a (a second assembly) m (monotone read_as)
   s (no same event for a finding).
   CHECKS: letters among 2 (R2) 7 (R7) + (R3, R5, R6, R10: one more event)
   l (R12 locality, event added last) L (R12, event at any time) g (R12, graded reads and effects)
   9 (R9 forks, coarse tags) f (R9 forks: footprints, forms a and b). *)
open Kernel

let () =
  let a = Sys.argv in
  let s0 = int_of_string a.(1) and s1 = int_of_string a.(2) in
  let n = int_of_string a.(3) and m = int_of_string a.(4) in
  let fl = a.(5) and ch = a.(6) in
  let cfg =
    {
      Explore.n;
      m;
      asm2 = String.contains fl 'a';
      mono = String.contains fl 'm';
      no_same_bad = String.contains fl 's';
    }
  in
  let w c = String.contains ch c in
  let which =
    {
      Explore.w2 = w '2';
      w7 = w '7';
      wadd = w '+';
      w12 = w 'l';
      w12any = w 'L';
      w12g = w 'g';
      w9 = w '9';
      w9fp = w 'f';
    }
  in
  let t0 = Unix.gettimeofday () in
  for seed = s0 to s1 do
    let st = Random.State.make [| seed |] in
    Explore.run_universe (Explore.genesis_len cfg) which
      (Explore.gen_universe st cfg);
    Printf.eprintf "seed %d done, %.0fs, %d states\n%!" seed
      (Unix.gettimeofday () -. t0)
      !Explore.visited
  done;
  Printf.printf "seeds %d..%d ids=%d pool=%d flags=%s checks=%s\n" s0 s1 n m fl
    ch;
  Explore.report stdout
