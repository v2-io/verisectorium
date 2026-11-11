
val negb : bool -> bool

val fst : ('a1 * 'a2) -> 'a1

val snd : ('a1 * 'a2) -> 'a2

val length : 'a1 list -> int

val app : 'a1 list -> 'a1 list -> 'a1 list

type 'a sig0 = 'a
  (* singleton inductive, whose constructor was exist *)



module Nat :
 sig
  val ltb : int -> int -> bool
 end

val map : ('a1 -> 'a2) -> 'a1 list -> 'a2 list

val seq : int -> int -> int list

val in_dec : ('a1 -> 'a1 -> bool) -> 'a1 -> 'a1 list -> bool

val flat_map : ('a1 -> 'a2 list) -> 'a1 list -> 'a2 list

val fold_left : ('a1 -> 'a2 -> 'a1) -> 'a2 list -> 'a1 -> 'a1

val existsb : ('a1 -> bool) -> 'a1 list -> bool

val forallb : ('a1 -> bool) -> 'a1 list -> bool

val filter : ('a1 -> bool) -> 'a1 list -> 'a1 list

val combine : 'a1 list -> 'a2 list -> ('a1 * 'a2) list

val nodup : ('a1 -> 'a1 -> bool) -> 'a1 list -> 'a1 list

val step : (string -> string list) -> string list -> string list

val iter : int -> ('a1 -> 'a1) -> 'a1 -> 'a1

val reach :
  (string -> string list) -> string list -> string list -> string list

type piece = string

type version = string

val eqs : string -> string -> bool

type shape =
| Veritoid of bool * piece list
| Assembly of bool * ((string * piece) * bool) list

type ontology = { shape_of : (piece -> version -> shape option);
                  inner : (string * string) list; write_looks : bool }

type evidence = { e_name : string; e_piece : piece; e_version : version;
                  e_criterion : string; e_holds : bool;
                  e_reads : (piece * version) list }

type event =
| Write of piece * version
| Evidence of evidence
| Same of string * piece * version * version
| Affirm of piece * version * piece * version
| Raise of piece * string
| Promise of piece * string
| Waive of int * piece
| SetAside of string
| MarkRoot of piece

type line = event list

val sel : line -> piece -> version option

val written : line -> piece list

val is_written : line -> piece -> bool

val shape_now : ontology -> line -> piece -> shape option

val slots_of : ontology -> line -> piece -> ((string * piece) * bool) list

val fillers_of : ontology -> line -> piece -> piece list

val preds_of : ontology -> line -> piece -> piece list

val roots : line -> piece list

val evidence_of : line -> evidence list

val numbered : line -> (int * event) list

val out_slots : ontology -> line -> piece -> piece list

val slot_universe : ontology -> line -> piece list

val canon : ontology -> line -> piece list

val out_preds : ontology -> line -> piece -> piece list

val rests_on : ontology -> line -> piece -> piece list

val same : line -> string -> piece -> version -> version -> bool

val at_ : line -> string -> piece -> version -> bool

val set_aside : line -> string -> bool

val applies : line -> evidence -> bool

val is_some : 'a1 option -> bool

val c1 : ontology -> line -> piece -> bool

val snap :
  line -> piece -> piece -> version option -> version option -> version option

val written_against : line -> piece -> piece -> bool

val affirmed : line -> piece -> piece -> bool

val c2 : ontology -> line -> piece -> bool

val was_selected : line -> piece -> version -> bool

val c4 : line -> piece -> bool

val c5_asked : ontology -> line -> piece -> bool

val filler : ontology -> line -> piece -> string -> piece option

val looked : ontology -> line -> piece -> piece -> bool

val c6 : ontology -> line -> piece -> bool

val c8 : ontology -> line -> piece list -> string -> bool

val c9 : line -> piece -> bool

val waived : line -> int -> piece -> bool

val own : ontology -> line -> piece list -> piece -> int list

val c5_rests : ontology -> line -> string list -> piece -> bool

val owed : ontology -> line -> piece list -> piece -> int list

val frontier : ontology -> line -> (int * piece) list

val shapes : piece -> version -> shape option

val ont : bool -> ontology

val ev :
  string -> piece -> version -> string -> bool -> (piece * version) list ->
  event

val s0 : line

val e5 : event

val e6 : event

val r0830 : event list

val r0900 : event list

val r1000 : event list

val r1030 : event list

val r1100 : event list

val r1130 : event list

val r1200 : event list

val r1300 : event list

val r1400 : event list

val looks : ontology

val strict : ontology

type checkpoint = line

val close : ontology -> line -> checkpoint option
