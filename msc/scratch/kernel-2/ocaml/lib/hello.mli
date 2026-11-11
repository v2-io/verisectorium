type event = Add of int | Reset [@@deriving show, eq, ord]
type log = event list [@@deriving show, eq]

val step : int -> event -> int
val total : log -> int
