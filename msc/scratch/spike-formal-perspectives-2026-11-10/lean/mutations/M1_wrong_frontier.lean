-- Mutation 1. A pinned frontier with one item removed must be rejected.
import Vk.Story
open Vk.M0 Vk.Story Pc Cr
example : frontier W row5 = [.unasked T whole, .unreconciled u c] := by decide
