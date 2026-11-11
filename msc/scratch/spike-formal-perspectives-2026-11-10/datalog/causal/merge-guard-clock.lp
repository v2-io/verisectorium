% A guard across a merge. The case is the independent reader's (de-novo-feedback-1 section 1c).
% A finding on c0. Fork a fixes it (c1) and the case is looked for in c1. Fork b, from the same
% checkpoint, rewrites c0 to c2, later by the clock; nobody looks for the case in c2.
slot(o,o1,c,point,firm). asks_valid(c).
write(s0,1,c,c0). write(s0,2,o,o1). markroot(s0,3,o). evidence(k0,4,c,c0,valid,holds).
evidence(f,10,c,c0,casex,fails).
write(a,20,c,c1). evidence(ka,21,c,c1,valid,holds). evidence(kx,22,c,c1,casex,holds).
write(b,30,c,c2). evidence(kb,31,c,c2,valid,holds).
view(g_b,40). vis(g_b,s0). vis(g_b,b).
view(g_union,40). vis(g_union,s0). vis(g_union,a). vis(g_union,b).
#defined reads/3. #defined setaside/3. #defined raise/4. #defined waive/4. #defined inner/3. #defined result/1. #defined pred/3. #defined affirm/6. #defined wrote_against/4. #defined same/4.
