open Kernel

(* Re-declaring the type with its manifest lets the deriver build a generator
   here, so the library itself does not depend on QCheck. [qcheck2] derives
   [gen_event : event QCheck2.Gen.t], which shrinks without extra code. *)
type event = Hello.event = Add of int | Reset [@@deriving qcheck2]

let gen_log = QCheck2.Gen.list gen_event

let unit_total () =
  Alcotest.(check int)
    "reset discards what came before" 5
    (Hello.total [ Add 3; Reset; Add 2; Add 3 ])

(* total (a @ b) is the fold of b continued from total a. *)
let prop_fold_splits =
  QCheck2.Test.make ~count:1000 ~name:"total splits over append"
    ~print:QCheck2.Print.(pair Hello.show_log Hello.show_log)
    QCheck2.Gen.(pair gen_log gen_log)
    (fun (a, b) ->
      Hello.total (a @ b) = List.fold_left Hello.step (Hello.total a) b)

let () =
  Alcotest.run "kernel"
    [
      ("unit", [ Alcotest.test_case "total" `Quick unit_total ]);
      ("property", [ QCheck_alcotest.to_alcotest prop_fold_splits ]);
    ]
