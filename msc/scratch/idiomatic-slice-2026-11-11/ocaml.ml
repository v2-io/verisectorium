(* The slice in OCaml, written the way I would want it.

   Run:  opam exec --switch=kernel-2 -- ocaml ocaml.ml
   (standard library only; no build file)

   The idea in one line: a KIND IS A TYPE. An assembly kind's declaration of
   its slots is a record type; "one", "at most one" and "any number" are a
   field, an option and a list; what may fill a slot is the field's type.
   Notes on what that bought, what it refused, and where it departs from the
   slice as worded are at the foot of the file. *)

[@@@warning "@8@9"]
(* 8: a match that forgets a case is an error.
   9: a record pattern that forgets a field is an error. [slots] relies on it. *)

(* ---------- identity: minted, never reused, and not a string or an int ---------- *)

module Id : sig
  type t

  val mint : string -> t
  (** A fresh identity. The label is for people; it is not the identity. *)

  val label : t -> string

  module Set : Set.S with type elt = t
end = struct
  type t = { n : int; label : string }

  let next = ref 0

  let mint label =
    incr next;
    { n = !next; label }

  let label t = t.label

  module Set = Set.Make (struct
    type nonrec t = t

    let compare a b = Int.compare a.n b.n
  end)
end

(* ---------- veritoids: one piece of content of a declared kind ---------- *)

(* The kind is in the type. A claim and an explanation are both "a sentence
   with an id", and the compiler will not take one for the other. The type is
   abstract, so the only way to have a claim is to have made one with
   [claim]. *)
module Veritoid : sig
  type 'kind t
  type claim = [ `Claim ] t
  type step = [ `Step ] t
  type explanation = [ `Explanation ] t

  val claim : string -> string -> claim
  val step : string -> string -> step
  val explanation : string -> string -> explanation
  val id : _ t -> Id.t
  val content : _ t -> string
end = struct
  type 'kind t = { id : Id.t; content : string }
  type claim = [ `Claim ] t
  type step = [ `Step ] t
  type explanation = [ `Explanation ] t

  let make label content = { id = Id.mint label; content }
  let claim = make
  let step = make
  let explanation = make
  let id v = v.id
  let content v = v.content
end

open Veritoid

(* ---------- slots ---------- *)

(* A slot for an ['a] holds one that lives in it, or points at one that lives
   elsewhere. Pointing is sharing: the same immutable value, reached from a
   second place. *)
type 'a filler = Holds of 'a | Points_at of 'a

type 'a slot =
  | Open  (** declared by the kind; nobody has said anything yet *)
  | Suggested of string
  | Promised
  | Filled of { filler : 'a filler; provisional : bool }

let holds x = Filled { filler = Holds x; provisional = false }
let points_at x = Filled { filler = Points_at x; provisional = false }

let provisionally = function
  | Filled f -> Filled { f with provisional = true }
  | (Open | Suggested _ | Promised) as empty -> empty

let map_slot f = function
  | Open -> Open
  | Suggested note -> Suggested note
  | Promised -> Promised
  | Filled { filler = Holds x; provisional } ->
      Filled { filler = Holds (f x); provisional }
  | Filled { filler = Points_at x; provisional } ->
      Filled { filler = Points_at (f x); provisional }

(* ---------- assemblies: each kind's slots, declared as a record ---------- *)

type derived_result = {
  id : Id.t;
  formal_claim : claim slot;  (** one *)
  derivation : step slot list;  (** any number, in order *)
  description : explanation slot;  (** one *)
  eli8 : explanation slot option;  (** at most one *)
}

(* An outline takes anything, in order. A gap is not a state of a slot: it
   says something is missing here and not what, so it has no type to be a
   slot of. *)
type outline = { id : Id.t; entries : entry list }
and entry = Slot of segment slot | Gap

(* A segment is a veritoid or an assembly. *)
and segment = Veritoid of veritoid | Assembly of assembly
and veritoid = Claim of claim | Step of step | Explanation of explanation
and assembly = Derived_result of derived_result | Outline of outline

let id_of = function
  | Veritoid (Claim v) -> Veritoid.id v
  | Veritoid (Step v) -> Veritoid.id v
  | Veritoid (Explanation v) -> Veritoid.id v
  | Assembly (Derived_result r) -> r.id
  | Assembly (Outline o) -> o.id

(* The one place a kind's slots are read back as plain data: a name and a
   slot of "some segment". Every field is named in the pattern, so a slot
   added to the record and forgotten here does not compile. *)
let slots : assembly -> (string * segment slot) list = function
  | Derived_result { id = _; formal_claim; derivation; description; eli8 } -> (
      let claim c = Veritoid (Claim c)
      and step s = Veritoid (Step s)
      and explanation e = Veritoid (Explanation e) in
      [ ("formal-claim", map_slot claim formal_claim) ]
      @ List.map (fun s -> ("derivation", map_slot step s)) derivation
      @ [ ("description", map_slot explanation description) ]
      @
      match eli8 with
      | None -> []
      | Some s -> [ ("eli8", map_slot explanation s) ])
  | Outline { id = _; entries } ->
      List.concat
        (List.mapi
           (fun i -> function
             | Slot s -> [ (string_of_int (i + 1), s) ] | Gap -> [])
           entries)

(* ---------- canon ---------- *)

(* What the roots reach through slots that are filled and not provisional.
   A root is an assembly; marking a veritoid as a root is a type error. *)
let canon (roots : assembly list) : Id.Set.t =
  let rec reach seen segment =
    if Id.Set.mem (id_of segment) seen then seen
    else
      let seen = Id.Set.add (id_of segment) seen in
      match segment with
      | Veritoid _ -> seen
      | Assembly a ->
          List.fold_left
            (fun seen (_, slot) ->
              match slot with
              | Filled { filler = Holds s | Points_at s; provisional = false }
                ->
                  reach seen s
              | Filled { provisional = true; _ } | Open | Suggested _ | Promised
                ->
                  seen)
            seen (slots a)
  in
  List.fold_left (fun seen r -> reach seen (Assembly r)) Id.Set.empty roots

(* Which slots are promised and empty. Asked of the segments that live on
   their own; it follows what each HOLDS, so every slot is met once, where it
   lives. *)
let rec promised (segment : segment) : (Id.t * string) list =
  match segment with
  | Veritoid _ -> []
  | Assembly a ->
      List.concat_map
        (fun (name, slot) ->
          match slot with
          | Promised -> [ (id_of segment, name) ]
          | Filled { filler = Holds s; _ } -> promised s
          | Filled { filler = Points_at _; _ } | Open | Suggested _ -> [])
        (slots a)

(* ---------- the instance ---------- *)

let c = claim "c" "Every bounded monotone sequence of reals converges."

let d =
  step "d"
    "Take the least upper bound of the terms and show the terms come within \
     any ε of it."

let k =
  explanation "k"
    "If you keep stepping forward and there is a wall you cannot pass, you end \
     up settling somewhere at or before the wall."

let t =
  {
    id = Id.mint "T";
    formal_claim = holds c;
    derivation = [ holds d ];
    description = Promised;
    eli8 = Some (holds k);
  }

let u = claim "u" "Every Cauchy sequence of reals converges."

let u' =
  {
    id = Id.mint "U";
    formal_claim = holds u;
    derivation = [];
    description = Open;
    eli8 = None;
  }

let o =
  {
    id = Id.mint "O";
    entries =
      [
        Slot (points_at (Assembly (Derived_result t)));
        Slot (provisionally (points_at (Assembly (Derived_result u'))));
        Slot (Suggested "a result about series is probably wanted here");
        Gap;
      ];
  }

let roots = [ Outline o ]
let living_on_their_own = [ Derived_result t; Derived_result u'; Outline o ]

let () =
  let labels set =
    String.concat ", " (List.map Id.label (Id.Set.elements set))
  in
  Printf.printf "canon: %s\n" (labels (canon roots));
  List.iter
    (fun a ->
      List.iter
        (fun (id, slot) ->
          Printf.printf "promised and empty: %s of %s\n" slot (Id.label id))
        (promised (Assembly a)))
    living_on_their_own;
  Printf.printf "c says: %s\n" (Veritoid.content c)

(* ---------- notes ----------

   WHAT I REACHED FOR, AND WHY

   - A record type per assembly kind. The kind's declaration of its slots and
     the type of a value of that kind are then the same text. Cardinality is
     the shape of the field: [claim slot] is one, [explanation slot option]
     is at most one, [step slot list] is any number in order.
   - A variant for the state of a slot, with what fills it as a type
     parameter, so "a slot for a claim" and "a slot for a step" are different
     types built from one definition.
   - Abstract types with a phantom tag for veritoid kinds. Three kinds, one
     representation, no way to confuse them and no way to forge one.
   - An abstract [Id] with a minting function. Identity is not a string and
     not an int; the label is only for printing.
   - Matches with no catch-all. [canon] names every state of a slot. Add a
     state and the file stops compiling at each place that has to decide.
   - Immutable values, shared. Pointing at T is using the value [t] again.

   WHAT THE COMPILER REFUSES (each tried; each is a type error)

   - A step in the formal-claim slot:      { t with formal_claim = holds d }
   - A second formal claim: there is nowhere to put it.
   - A veritoid marked as a root:          canon [ Claim c ]
   - Retagging a veritoid:                 (c :> explanation)
   - A gap in a typed slot:                { t with description = Gap }
   - A pointer to something that does not exist: with pointing as sharing,
     there is no way to write one.

   WHAT IT DOES NOT REFUSE

   - Holding one segment in two places. [holds c] can be written twice.
     OCaml has no notion of a value having one owner; this would be a check
     that runs, as it is in the kernel builds.
   - A ring. I expected sharing to rule out an outline that points at
     itself, and wrote that here before trying it. It is wrong: [let rec]
     builds a cyclic value from constructors alone, and my first [canon]
     then never returned. [reach] now stops at an id it has seen.
   - A required slot left [Open] for ever. "One" here means the slot is
     there, not that it is filled. That is the model's meaning too (an
     unfilled required slot is owed, not impossible), so I count this as the
     types agreeing with the model and not as a gap.

   WHERE THIS DEPARTS FROM THE SLICE AS WORDED

   1. A fifth slot state, [Open]. With a kind's slot as a record field, the
      field has to have a value, and U's description is none of suggested,
      promised or a gap. The types made me say what an untouched declared
      slot is.
   2. A gap is an entry of an outline and not a state of a slot. In a typed
      slot the kind of what is missing is known, which is exactly what a gap
      denies. Only an assembly that takes anything can have one. I did not
      set out to say this; the type of [Gap] would not go anywhere else.
   3. Roots are a list beside the segments, not a mark on an outline. Being
      a root is something said about an assembly, and nothing in the
      assembly changes when it is said.
   4. Pointing is sharing a value, with no table of ids behind it. So a
      dangling pointer cannot be written, which the model allows and here
      would have to be a [Promised] slot instead. This is the departure I
      would not keep once versions arrive: a pointer then has to name an id
      whose version can move under it, and that needs a store and ids typed
      by what they name. For one state with no history, sharing is the
      honest OCaml.

   WHAT WAS AWKWARD

   - [slots]. Typed fields cannot be walked generically, so each kind writes
     out, by hand, its slots as (name, slot of any segment). It is the one
     place slot names are strings. The all-fields pattern keeps it in step
     with the record; nothing keeps the strings in step with the field names.
   - Three constructors deep to say "T, as a segment":
     [Assembly (Derived_result t)]. That is the price of "a segment is a
     veritoid or an assembly" being literally the type.
   - THE LARGE ONE. Kinds are types, so the ontology is the program. A
     verisectorium cannot declare a new kind without this file being edited
     and recompiled; two versions of a kind cannot sit side by side; an
     ontology change is not an event the model can see. For one
     verisectorium's own kinds written once, this is the best thing in the
     file. For a tool that must load any verisectorium's ontology, it is the
     wrong shape, and the kinds would have to become data again (as they are
     in the kernel builds), giving up every refusal listed above. I do not
     see a middle in OCaml short of generating this file from the ontology. *)
