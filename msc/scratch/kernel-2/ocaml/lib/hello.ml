(* Placeholder: a log of events and a fold over it. Delete freely. *)

type event = Add of int | Reset
[@@deriving show { with_path = false }, eq, ord]

type log = event list [@@deriving show, eq]

let step total = function Add n -> total + n | Reset -> 0
let total (log : log) : int = List.fold_left step 0 log
