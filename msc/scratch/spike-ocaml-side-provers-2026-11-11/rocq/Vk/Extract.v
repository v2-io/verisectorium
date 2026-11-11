(* The OCaml that M0 extracts to. *)
From Stdlib Require Import List String.
From Vk Require Import Reach M0 Story Checkpoint.
From Stdlib Require Extraction.
From Stdlib Require Import ExtrOcamlBasic ExtrOcamlNativeString ExtrOcamlNatInt.
Set Extraction Output Directory "extract".
Extraction "m0_extracted.ml"
  frontier canon close looks strict
  S0 r0830 r0900 r1000 r1030 r1100 r1130 r1200 r1300 r1400.
