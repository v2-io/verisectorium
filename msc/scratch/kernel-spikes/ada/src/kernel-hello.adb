package body Kernel.Hello with SPARK_Mode => On is

   function Saturating_Add (X, Y : Natural) return Natural is
   begin
      if X > Natural'Last - Y then
         return Natural'Last;
      else
         return X + Y;
      end if;
   end Saturating_Add;

end Kernel.Hello;
