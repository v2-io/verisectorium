
type nat =
| O
| S of nat

val fst : ('a1 * 'a2) -> 'a1

val snd : ('a1 * 'a2) -> 'a2

val length : 'a1 list -> nat

val app : 'a1 list -> 'a1 list -> 'a1 list

val in_dec : ('a1 -> 'a1 -> bool) -> 'a1 -> 'a1 list -> bool

val flat_map : ('a1 -> 'a2 list) -> 'a1 list -> 'a2 list

val nodup : ('a1 -> 'a1 -> bool) -> 'a1 list -> 'a1 list

type name = string

type vkind =
| Claim
| Step
| Explanation

type veritoid = { v_name : name; content : string }

type 'a filler =
| Holds of 'a
| PointsAt of name

type 'a slot =
| Untouched
| Suggested of string
| Promised
| Filled of 'a filler * bool

val holds : 'a1 -> 'a1 slot

val points_at : name -> 'a1 slot

val provisionally_points_at : name -> 'a1 slot

type derived_result = { r_name : name; formal_claim : veritoid slot;
                        derivation : veritoid slot list;
                        description : veritoid slot;
                        eli8 : veritoid slot option }

type held =
| HeldV of vkind * veritoid
| HeldR of derived_result

type entry =
| Entry of held slot
| Gap

type outline = { o_name : name; entries : entry list }

type living =
| Result of derived_result
| AnOutline of outline

type verisectorium = { store : living list; roots : name list }

val firm : ('a1 -> name) -> 'a1 slot -> name list

val reaches_result : derived_result -> name list

val held_name : held -> name

val reaches_outline : outline -> name list

val assemblies : verisectorium -> (name * name list) list

val out : verisectorium -> name -> name list

val step : verisectorium -> name list -> name list

val iter : nat -> ('a1 -> 'a1) -> 'a1 -> 'a1

val universe : verisectorium -> name list

val canon_list : verisectorium -> name list

val promised_in_result : derived_result -> (name * string) list

val promised : verisectorium -> (name * string) list

val c : veritoid

val d : veritoid

val k : veritoid

val t : derived_result

val u : veritoid

val u0 : derived_result

val o : outline

val here : verisectorium
