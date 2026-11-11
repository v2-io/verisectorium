% note 22 section 4.3 on the causal footing. Each write has a name, a time (used only for
% "as of"), the write it replaces, and what it was written against or beside.
asks_valid(c;u).  result(t;uu).  inner(t,e,c).  inner(t,k,e).
pred(u,u1,c).  pred(u,u2,c).
slot(t,t1,c,hold,firm). slot(t,t1,d,hold,firm). slot(t,t1,e,hold,firm). slot(t,t1,k,hold,firm).
slot(uu,uu1,u,hold,firm). slot(o,o1,t,point,firm). slot(o,o1,uu,point,firm).
write(s0,w_c1,c,c1). wtime(w_c1,1).   write(s0,w_d1,d,d1). wtime(w_d1,2).
write(s0,w_e1,e,e1). wtime(w_e1,3).   write(s0,w_k1,k,k1). wtime(w_k1,4).
write(s0,w_u1,u,u1). wtime(w_u1,5).   wrote_against(w_u1,c,c1).
write(s0,w_t,t,t1). wtime(w_t,6). write(s0,w_uu,uu,uu1). wtime(w_uu,7). write(s0,w_o,o,o1). wtime(w_o,8).
markroot(s0,9,o).
affirm(s0,10,e,e1,c,c1). affirm(s0,11,k,k1,e,e1).
evidence(e1_,12,c,c1,valid,holds).  reads(e1_,d,d1).
evidence(e2_,13,u,u1,valid,holds).  reads(e2_,c,c1).
evidence(e3_,14,t,t1,whole,holds).  reads(e3_,c,c1). reads(e3_,d,d1). reads(e3_,e,e1). reads(e3_,k,k1).
evidence(e4_,15,uu,uu1,whole,holds). reads(e4_,u,u1).
evidence(e5_,30,c,c1,casex,fails).
write(fa,w_c1p,c,c1p). wtime(w_c1p,40). replaces(w_c1p,w_c1).
write(fa,w_d1p,d,d1p). wtime(w_d1p,41). replaces(w_d1p,w_d1).
evidence(e6_,42,c,c1p,valid,holds). reads(e6_,d,d1p).
write(fb,w_c2,c,c2). wtime(w_c2,60). replaces(w_c2,w_c1).
write(fb,w_d2,d,d2). wtime(w_d2,61). replaces(w_d2,w_d1).
write(fb,w_k2,k,k2). wtime(w_k2,62). replaces(w_k2,w_k1). wrote_against(w_k2,e,e1).
affirm(fb,63,e,e1,c,c2).
evidence(e7_,70,c,c2,valid,holds). reads(e7_,d,d2).
evidence(e8_,71,c,c2,casex,holds).
write(fb,w_d3,d,d3). wtime(w_d3,80). replaces(w_d3,w_d2).
evidence(e9_,90,c,c2,valid,holds). reads(e9_,d,d3).
write(fb,w_u2,u,u2). wtime(w_u2,100). replaces(w_u2,w_u1). wrote_against(w_u2,c,c2).
evidence(e10_,101,u,u2,valid,holds). reads(e10_,c,c2).
evidence(e11_,110,t,t1,whole,holds). reads(e11_,c,c2). reads(e11_,d,d3). reads(e11_,e,e1). reads(e11_,k,k2).
evidence(e12_,111,uu,uu1,whole,holds). reads(e12_,u,u2).
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
view(rX_S0_at_1400,115). vis(rX_S0_at_1400,s0).
view(rY_fa_at_1400,115). vis(rY_fa_at_1400,s0). vis(rY_fa_at_1400,fa).
