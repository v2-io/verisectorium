(* A trial, made for AS-A-HOME.md: four of the nine conditions of
   msc/notes/22 §4.1, each as one function named for its sentence, over a
   state computed once. Checked against [Model.violated] in the test
   "pulled out". Not used by the model or the explorer. *)

open Model

type state = { u : universe; line : int; at : int array; canon : int }

let state u line =
  {
    u;
    line;
    at = Array.init (nids u) (sel u line);
    canon = asserted_mask u line;
  }

let there st q = st.at.(q) >= 0
let in_canon st q = has st.canon q
let version st p = st.u.versions.(p).(st.at.(p))

(* 1. every reference reaches something that is there *)
let references_reach st p =
  match version st p with
  | Veritoid v ->
      List.concat
        (List.mapi
           (fun i r -> if there st r.target then [] else [ C3_ref (p, i) ])
           v.refs)
  | Assembly a ->
      List.filter_map
        (fun (slot, filler, _) ->
          match filler with
          | Points q when not (there st q) -> Some (C3_slot (p, slot))
          | _ -> None)
        a.fill

(* 4. nothing is known wrong: no finding applies to it, and every defect
   found in it has since been looked for and not found *)
let nothing_known_wrong st p =
  let findings =
    List.concat
      (List.init (Array.length st.u.ont.dims) (fun d ->
           List.filter_map
             (fun (e, _, outcome) ->
               if outcome <> Holds_ then Some (C6_finding (p, e)) else None)
             (applying st.u st.line p d)))
  in
  findings @ List.map (fun e -> C6_guard (p, e)) (unmet_guards st.u st.line p)

(* 8. every promised or required slot has something in canon in it *)
let slots_filled st p =
  match version st p with
  | Veritoid _ -> []
  | Assembly a ->
      List.filter_map
        (fun (slot, required) ->
          let promised =
            exists_event st.u st.line (fun i e ->
                e = Promise (p, slot) && live st.u st.line i)
          in
          let filled =
            List.exists
              (fun (name, filler, _) ->
                name = slot
                &&
                match filler with
                | Holds q | Points q -> in_canon st q
                | Empty -> false)
              a.fill
          in
          if (required || promised) && not filled then Some (C8_slot (p, slot))
          else None)
        st.u.ont.akinds.(a.ak).slots

(* 9. every question raised about it has been answered since *)
let questions_answered st p =
  fold_events st.u st.line
    (fun owed i e ->
      match e with
      | Raise (q, d)
        when q = p && live st.u st.line i
             && not
                  (List.exists
                     (fun (j, _, _) -> j > i)
                     (applying st.u st.line p d)) ->
          C9 (p, i) :: owed
      | _ -> owed)
    []

let four st =
  List.sort_uniq compare
    (List.concat_map
       (fun p ->
         if in_canon st p then
           references_reach st p @ nothing_known_wrong st p @ slots_filled st p
           @ questions_answered st p
         else [])
       (List.init (nids st.u) Fun.id))
