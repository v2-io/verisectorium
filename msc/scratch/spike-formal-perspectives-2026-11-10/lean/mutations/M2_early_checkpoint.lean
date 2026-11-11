-- Mutation 2. A checkpoint at 13:00, when two whole reads are still owed, must be rejected.
import Vk.Story
open Vk.M0 Vk.Story
def S1_early : Checkpoint W := close W row8 (by decide)
