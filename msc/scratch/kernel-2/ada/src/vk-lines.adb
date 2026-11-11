package body Vk.Lines with SPARK_Mode => Off is

   use Vk.Model;

   procedure Add (Ln : in out Timeline; E : Event) is
   begin
      for I in Event_Ix loop
         if Ln (I).Present and then Ln (I).Time = E.Time then
            return;                       --  already there (a set)
         end if;
      end loop;
      for I in Event_Ix loop
         if not Ln (I).Present then
            Ln (I) := E;
            Ln (I).Present := True;
            return;
         end if;
      end loop;
      raise Constraint_Error with "line full";
   end Add;

   function Union (A, B : Timeline) return Timeline is
      R : Timeline := A;
   begin
      for I in Event_Ix loop
         if B (I).Present then
            Add (R, B (I));
         end if;
      end loop;
      return R;
   end Union;

   function Rewind (Ln : Timeline; Upto : Natural) return Timeline is
      R : Timeline := Ln;
   begin
      for I in Event_Ix loop
         if R (I).Present and then R (I).Time > Upto then
            R (I) := (others => <>);
         end if;
      end loop;
      return R;
   end Rewind;

   function Version_At (Ln : Timeline; P : Id; At_T : Natural) return Pick is
      Best : Natural := 0;
      R    : Pick := (others => <>);
   begin
      for I in Event_Ix loop
         if Ln (I).Present and then Ln (I).P = P
           and then Ln (I).What in Write | Retire
           and then Ln (I).Time <= At_T and then Ln (I).Time >= Best
         then
            Best := Ln (I).Time;
            R := (Selected => Ln (I).What = Write, V => Ln (I).V,
                  Asserted => False);
         end if;
      end loop;
      return R;
   end Version_At;

   --  The first time, up to Now, that the line selected P at V; 0 if
   --  never (times start at 1).
   function First_Selected
     (Ln : Timeline; P : Id; V : Ver; Now : Natural) return Natural
   is
      Best : Natural := 0;
   begin
      for I in Event_Ix loop
         if Ln (I).Present and then Ln (I).What = Write
           and then Ln (I).P = P and then Ln (I).V = V
           and then Ln (I).Time <= Now
           and then (Best = 0 or else Ln (I).Time < Best)
         then
            Best := Ln (I).Time;
         end if;
      end loop;
      return Best;
   end First_Selected;

   --  Was P selected at V by a write at or after From (and up to Now)?
   function Selected_Since
     (Ln : Timeline; P : Id; V : Ver; From, Now : Natural) return Boolean
   is
     (for some I in Event_Ix =>
        Ln (I).Present and then Ln (I).What = Write
        and then Ln (I).P = P and then Ln (I).V = V
        and then Ln (I).Time >= From and then Ln (I).Time <= Now);

   function Read_State
     (O : Ontology; T : Version_Table; Ln : Timeline; B : Base; Now : Natural;
      Opt : Options := (others => <>)) return State
   is
      St : State;
      Latest : Natural;
   begin
      --  Selection.
      for P in Id loop
         St.S (P) := Version_At (Ln, P, Now);
      end loop;

      --  Descent, from retirements.
      for I in Event_Ix loop
         if Ln (I).Present and then Ln (I).What = Retire
           and then Ln (I).Time <= Now
         then
            for H in Id loop
               if Ln (I).Heirs (H) then
                  St.F.Desc (Ln (I).P, H) := True;
               end if;
            end loop;
         end if;
      end loop;
      for K in Id loop
         for A in Id loop
            for C in Id loop
               if St.F.Desc (A, K) and then St.F.Desc (K, C) then
                  St.F.Desc (A, C) := True;
               end if;
            end loop;
         end loop;
      end loop;

      --  Decisions in force: the latest of decide / withdraw wins.
      for J in Dec_Ix loop
         Latest := 0;
         for I in Event_Ix loop
            if Ln (I).Present and then Ln (I).What in Decide | Withdraw
              and then Ln (I).J = J and then Ln (I).Time <= Now
              and then Ln (I).Time >= Latest
            then
               Latest := Ln (I).Time;
               if Ln (I).What = Decide then
                  St.F.Dec (J) := B.Dec (J);
                  St.F.Dec (J).Present := True;
                  St.F.Dec (J).Withdrawn := False;
                  St.F.Dec (J).Time := Ln (I).Time;
               else
                  St.F.Dec (J) := (others => <>);
               end if;
            end if;
         end loop;
      end loop;

      --  Evidence: everything in the base up to now.
      for I in Ev_Ix loop
         if B.Ev (I).Present and then B.Ev (I).Time <= Now then
            St.F.Ev (I) := B.Ev (I);
         end if;
      end loop;

      --  Roots, and what each reaches through filled slots not flagged
      --  provisional.
      for P in Id loop
         Latest := 0;
         for I in Event_Ix loop
            if Ln (I).Present and then Ln (I).What in Mark | Unmark
              and then Ln (I).P = P and then Ln (I).Time <= Now
              and then Ln (I).Time >= Latest
            then
               Latest := Ln (I).Time;
               St.L.Roots (P) := Ln (I).What = Mark;
            end if;
         end loop;
      end loop;
      for R in Id loop
         if St.L.Roots (R) and then St.S (R).Selected then
            declare
               In_Set  : Id_Set := [others => False];
               Changed : Boolean := True;
            begin
               In_Set (R) := True;
               while Changed loop
                  Changed := False;
                  for A in Id loop
                     if In_Set (A) and then St.S (A).Selected then
                        for Sl in Slot_Ix loop
                           declare
                              Slt : constant Slot :=
                                T (A, St.S (A).V).Slots (Sl);
                           begin
                              if Slt.State /= Empty
                                and then not Slt.Provisional
                                and then St.S (Slt.Filler).Selected
                                and then not In_Set (Slt.Filler)
                              then
                                 In_Set (Slt.Filler) := True;
                                 Changed := True;
                              end if;
                           end;
                        end loop;
                     end if;
                  end loop;
               end loop;
               for P in Id loop
                  if In_Set (P) then
                     St.S (P).Asserted := True;
                     if P /= R then
                        St.L.Reach (R, P) := True;
                     end if;
                  end if;
               end loop;
            end;
         end if;
      end loop;

      --  What each selected version was written against.
      if Opt.Written_Counts then
         for P in Id loop
            if St.S (P).Selected then
               Latest := 0;
               for I in Event_Ix loop
                  if Ln (I).Present and then Ln (I).What = Write
                    and then Ln (I).P = P and then Ln (I).Time <= Now
                    and then Ln (I).Time >= Latest
                  then
                     Latest := Ln (I).Time;
                  end if;
               end loop;
               for E in Edge_Ix loop
                  declare
                     Rf : constant Ref := Edge (O, T, St.S, P, E);
                     Pk : Pick;
                  begin
                     if Rf.Present and then not Opt.Seen_Recorded then
                        Pk := Version_At (Ln, Rf.Target, Latest);
                        if Pk.Selected then
                           St.L.Seen (P, E) := (Has => True, V => Pk.V);
                        end if;
                     elsif Rf.Present then
                        for I in Event_Ix loop
                           if Ln (I).Present and then Ln (I).What = Write
                             and then Ln (I).P = P
                             and then Ln (I).Time = Latest
                           then
                              St.L.Seen (P, E) := Ln (I).Saw (E);
                           end if;
                        end loop;
                     end if;
                  end;
               end loop;
            end if;
         end loop;
      end if;

      --  Guards.
      for Fi in Ev_Ix loop
         declare
            Fd : constant Evidence := St.F.Ev (Fi);
            TV : Natural;
         begin
            if Fd.Present and then Fd.Result /= Holds
              and then not Aside (St.F, Fi)
            then
               TV := First_Selected (Ln, Fd.P, Fd.V, Now);
               if TV /= 0 or else Opt.Off_Line_Guards then
                  for Q in Id loop
                     if St.S (Q).Selected
                       and then
                         ((Q = Fd.P
                           and then
                             (if Opt.Reads_Shed then
                                not (St.S (Q).V = Fd.V
                                     or else Fd.Same (St.S (Q).V))
                              else not Applies (O, T, St.S, St.F, Fi)))
                          or else St.F.Desc (Fd.P, Q))
                     then
                        declare
                           Met : Boolean := False;
                        begin
                           for Hi in Ev_Ix loop
                              declare
                                 H : constant Evidence := St.F.Ev (Hi);
                                 On_Path, Then_Applied : Boolean;
                                 Pk : Pick;
                              begin
                                 if H.Present and then H.Result = Holds
                                   and then H.D = Fd.D and then H.C = Fd.C
                                   and then not Aside (St.F, Hi)
                                 then
                                    On_Path :=
                                      (H.P = Fd.P
                                       and then
                                         ((H.V = Fd.V and then TV /= 0)
                                          or else Selected_Since
                                            (Ln, H.P, H.V, TV, Now)))
                                      or else
                                      (St.F.Desc (Fd.P, H.P)
                                       and then
                                         (H.P = Q
                                          or else St.F.Desc (H.P, Q))
                                       and then Selected_Since
                                         (Ln, H.P, H.V, 0, Now));
                                    Pk := Version_At (Ln, H.P, H.Time);
                                    Then_Applied :=
                                      Pk.Selected
                                      and then (Pk.V = H.V
                                                or else H.Same (Pk.V));
                                    if On_Path and then Then_Applied
                                      and then (Opt.Mode = Letter
                                                or else H.Time > Fd.Time)
                                    then
                                       Met := True;
                                    end if;
                                 end if;
                              end;
                           end loop;
                           if not Met then
                              St.L.Guard (Q, Fd.D, Fd.C) := True;
                           end if;
                        end;
                     end if;
                  end loop;
               end if;
            end if;
         end;
      end loop;

      return St;
   end Read_State;

end Vk.Lines;
