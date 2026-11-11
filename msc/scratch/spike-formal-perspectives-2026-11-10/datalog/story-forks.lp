% Two forks from one checkpoint, read as sets of events; closing both is their union.
% Outline o (root) points at results t {c}, v {x}, n {w}.  w is a description-like piece,
% predicated on c, of which the root asks nothing but placement.
asks_valid(c;x).  result(t;v;n).
pred(w,w1,c). pred(w,w2,c).
slot(t,t1,c,hold,firm). slot(v,v1,x,hold,firm). slot(n,n1,w,hold,firm).
slot(o,o1,t,point,firm). slot(o,o1,v,point,firm). slot(o,o1,n,point,firm).
% checkpoint S0
write(s0,1,c,c1). write(s0,2,x,x1). write(s0,3,w,w1). wrote_against(s0,3,c,c1).
write(s0,4,t,t1). write(s0,5,v,v1). write(s0,6,n,n1). write(s0,7,o,o1). markroot(s0,8,o).
evidence(g1,10,c,c1,valid,holds). evidence(g2,11,x,x1,valid,holds).
evidence(g3,12,t,t1,whole,holds). reads(g3,c,c1).
evidence(g4,13,v,v1,whole,holds). reads(g4,x,x1).
evidence(g5,14,n,n1,whole,holds). reads(g5,w,w1).
% fork A: rewrites c, has it checked, looks at w beside the new c and keeps it, T read whole
write(fa,30,c,c2).
evidence(a1,31,c,c2,valid,holds).
affirm(fa,32,w,w1,c,c2).
evidence(a2,33,t,t1,whole,holds). reads(a2,c,c2).
% fork B: an unrelated repair of x, under the same outline
write(fb,40,x,x2).
evidence(b1,41,x,x2,valid,holds).
evidence(b2,42,v,v1,whole,holds). reads(b2,x,x2).
% fork B2: rewords w, having seen c at c1 (its writer never saw fork A). Later by the clock than A's write of c.
write(fb2,50,w,w2). wrote_against(fb2,50,c,c1).
evidence(d1,51,n,n1,whole,holds). reads(d1,w,w2).

view(s0,60). vis(s0,s0).
view(a_alone,60).  vis(a_alone,s0).  vis(a_alone,fa).
view(b_alone,60).  vis(b_alone,s0).  vis(b_alone,fb).
view(b2_alone,60). vis(b2_alone,s0). vis(b2_alone,fb2).
view(a_and_b,60).  vis(a_and_b,s0).  vis(a_and_b,fa).  vis(a_and_b,fb).
view(a_and_b2,60). vis(a_and_b2,s0). vis(a_and_b2,fa). vis(a_and_b2,fb2).
#defined same/4. #defined setaside/3. #defined raise/4. #defined waive/4. #defined inner/3.
