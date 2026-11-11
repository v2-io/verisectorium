% What E 3.1 does with $distinct. Asked: are O and U different segments?
tff(seg, type, seg: $tType).
tff(o, type, o: seg). tff(uu, type, uu: seg).
tff(differ, axiom, $distinct(o, uu)).
tff(q, conjecture, o != uu).
