% note 22 section 4.3, as stored facts. Times are arbitrary increasing integers.
% ---------- ontology and versions (written)
asks_valid(c;u).  result(t;uu).  inner(t,e,c).  inner(t,k,e).
pred(u,u1,c).  pred(u,u2,c).
slot(t,t1,c,hold,firm). slot(t,t1,d,hold,firm). slot(t,t1,e,hold,firm). slot(t,t1,k,hold,firm).
slot(uu,uu1,u,hold,firm).
slot(o,o1,t,point,firm). slot(o,o1,uu,point,firm).

% ---------- S0 (branch s0)
write(s0,1,c,c1). write(s0,2,d,d1). write(s0,3,e,e1). write(s0,4,k,k1).
write(s0,5,u,u1). wrote_against(s0,5,c,c1).
write(s0,6,t,t1). write(s0,7,uu,uu1). write(s0,8,o,o1).
markroot(s0,9,o).
affirm(s0,10,e,e1,c,c1). affirm(s0,11,k,k1,e,e1).
evidence(e1_,12,c,c1,valid,holds).  reads(e1_,d,d1).
evidence(e2_,13,u,u1,valid,holds).  reads(e2_,c,c1).
evidence(e3_,14,t,t1,whole,holds).  reads(e3_,c,c1). reads(e3_,d,d1). reads(e3_,e,e1). reads(e3_,k,k1).
evidence(e4_,15,uu,uu1,whole,holds). reads(e4_,u,u1).
% 08:30 the auditor
evidence(e5_,30,c,c1,casex,fails).
% 09:00 first repair, on a fork (branch fa): weaken the conclusion
write(fa,40,c,c1p). write(fa,41,d,d1p).
evidence(e6_,42,c,c1p,valid,holds). reads(e6_,d,d1p).
% 10:30 second repair (branch fb): add H
write(fb,60,c,c2). write(fb,61,d,d2). write(fb,62,k,k2).
affirm(fb,63,e,e1,c,c2).
% 11:00
evidence(e7_,70,c,c2,valid,holds). reads(e7_,d,d2).
evidence(e8_,71,c,c2,casex,holds).
% 11:30
write(fb,80,d,d3).
% 12:00
evidence(e9_,90,c,c2,valid,holds). reads(e9_,d,d3).
% 13:00
write(fb,100,u,u2). wrote_against(fb,100,c,c2).
evidence(e10_,101,u,u2,valid,holds). reads(e10_,c,c2).
% 14:00
evidence(e11_,110,t,t1,whole,holds). reads(e11_,c,c2). reads(e11_,d,d3). reads(e11_,e,e1). reads(e11_,k,k2).
evidence(e12_,111,uu,uu1,whole,holds). reads(e12_,u,u2).

% ---------- the rows of the table: a line (which branches) read as of a time
view(r0_S0,20).      vis(r0_S0,s0).
view(r1_0830,30).    vis(r1_0830,s0).
view(r2_0900,45).    vis(r2_0900,s0). vis(r2_0900,fa).
view(r3_1000,50).    vis(r3_1000,s0).
view(r4_1030,65).    vis(r4_1030,s0). vis(r4_1030,fb).
view(r5_1100,75).    vis(r5_1100,s0). vis(r5_1100,fb).
view(r6_1130,85).    vis(r6_1130,s0). vis(r6_1130,fb).
view(r7_1200,95).    vis(r7_1200,s0). vis(r7_1200,fb).
view(r8_1300,105).   vis(r8_1300,s0). vis(r8_1300,fb).
view(r9_1400,115).   vis(r9_1400,s0). vis(r9_1400,fb).
% the main line, never forked, read at the end: what S0 owes once everything is known
view(rX_S0_at_1400,115). vis(rX_S0_at_1400,s0).
% the abandoned fork, read at the end
view(rY_fa_at_1400,115). vis(rY_fa_at_1400,s0). vis(rY_fa_at_1400,fa).

% unused stored relations, declared so the rules have something to range over
#defined same/4. #defined setaside/3. #defined raise/4. #defined waive/4.
