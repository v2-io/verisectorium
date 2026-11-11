(* What plain OCaml gives with no tool at all: values that cannot be typed by
   hand. Two of them.

     ocaml sealed.ml

   1. A derived result whose slots are checked for kind when it is made. The
      record is PRIVATE: it can be read and matched anywhere, and built only
      by [Result.make], which checks. This is the invariant of the Cameleer
      slice, enforced when the program runs and not before.
   2. A checkpoint. The type is abstract; the only way to have one is
      [Checkpoint.close], which computes what is owed and refuses if anything
      is. "Stationary" is then a fact about how the value came to exist. *)
#use "m0.ml"

type kind = Claim | Step | Explanation
type veritoid = { v_id : int; kind : kind; content : string }
type 'a filler = Holds of 'a | Points_at of int
type 'a slot = Untouched | Suggested of string | Promised | Filled of 'a filler * bool

module Result : sig
  type t = private {
    r_id : int;
    formal_claim : veritoid slot;
    derivation : veritoid slot list;
    description : veritoid slot;
    eli8 : veritoid slot option;
  }

  val make :
    r_id:int -> formal_claim:veritoid slot -> derivation:veritoid slot list ->
    description:veritoid slot -> eli8:veritoid slot option -> (t, string) result
end = struct
  type t = {
    r_id : int;
    formal_claim : veritoid slot;
    derivation : veritoid slot list;
    description : veritoid slot;
    eli8 : veritoid slot option;
  }

  let takes k = function Filled (Holds v, _) -> v.kind = k | _ -> true

  let make ~r_id ~formal_claim ~derivation ~description ~eli8 =
    if not (takes Claim formal_claim) then Error "formal-claim takes a claim"
    else if not (List.for_all (takes Step) derivation) then Error "derivation takes steps"
    else if not (takes Explanation description) then Error "description takes an explanation"
    else if not (match eli8 with None -> true | Some s -> takes Explanation s) then
      Error "eli8 takes an explanation"
    else Ok { r_id; formal_claim; derivation; description; eli8 }
end

module Checkpoint : sig
  type t

  type line = {
    sel : (int * int) list;
    evs : evidence list;
    claims : int list;  (* the pieces the root asks be checked *)
  }

  val close : line -> (t, (int * string) list) result
  (** A checkpoint, or what is owed. *)

  val line : t -> line
end = struct
  type line = { sel : (int * int) list; evs : evidence list; claims : int list }
  type t = line

  let owed l =
    List.concat_map
      (fun p ->
        (if known_wrong p l.evs l.sel then [ (p, "known wrong") ] else [])
        @ if checked 0 p l.evs l.sel then [] else [ (p, "unchecked") ])
      l.claims

  let close l = match owed l with [] -> Ok l | o -> Error o
  let line t = t
end

let () =
  let c = { v_id = 4; kind = Claim; content = "Every bounded monotone sequence of reals converges." } in
  let d = { v_id = 5; kind = Step; content = "Take the least upper bound." } in
  (match Result.make ~r_id:2 ~formal_claim:(Filled (Holds c, false)) ~derivation:[ Filled (Holds d, false) ] ~description:Promised ~eli8:None with
   | Ok r -> Printf.printf "T made; its claim slot is %s\n" (match r.formal_claim with Filled _ -> "filled" | _ -> "empty")
   | Error e -> Printf.printf "T refused: %s\n" e);
  (match Result.make ~r_id:2 ~formal_claim:(Filled (Holds d, false)) ~derivation:[] ~description:Promised ~eli8:None with
   | Ok _ -> print_endline "a step in the claim slot: made"
   | Error e -> Printf.printf "a step in the claim slot: refused when run (%s)\n" e);
  let open Checkpoint in
  let s0 = { sel = [ (4, 1) ]; evs = [ { subj = 4; ver = 1; crit = 0; holds = true; reads = [] } ]; claims = [ 4 ] } in
  (match close s0 with Ok _ -> print_endline "S0 closes: a checkpoint" | Error _ -> print_endline "S0 refused");
  let after = { s0 with evs = { subj = 4; ver = 1; crit = 1; holds = false; reads = [] } :: s0.evs } in
  match close after with
  | Ok _ -> print_endline "after the finding: a checkpoint"
  | Error o -> Printf.printf "after the finding: refused, %d owed (%s)\n" (List.length o) (snd (List.hd o))
