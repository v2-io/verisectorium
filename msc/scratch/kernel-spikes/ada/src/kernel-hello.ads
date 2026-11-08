--  Placeholder: exists only to show build, test and proof working.
--  Replace it freely.
package Kernel.Hello with SPARK_Mode => On is

   --  X + Y, or Natural'Last when that sum would overflow.
   function Saturating_Add (X, Y : Natural) return Natural
   with
     Post =>
       (if X <= Natural'Last - Y then Saturating_Add'Result = X + Y
        else Saturating_Add'Result = Natural'Last);

end Kernel.Hello;
