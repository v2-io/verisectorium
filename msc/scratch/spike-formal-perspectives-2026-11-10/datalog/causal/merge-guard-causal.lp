% The same case on the causal footing.
slot(o,o1,c,point,firm). asks_valid(c).
write(s0,w0,c,c0). wtime(w0,1). write(s0,wo,o,o1). wtime(wo,2). markroot(s0,3,o). evidence(k0,4,c,c0,valid,holds).
evidence(f,10,c,c0,casex,fails).
write(a,wa,c,c1). wtime(wa,20). replaces(wa,w0). evidence(ka,21,c,c1,valid,holds). evidence(kx,22,c,c1,casex,holds).
write(b,wb,c,c2). wtime(wb,30). replaces(wb,w0). evidence(kb,31,c,c2,valid,holds).
view(g_b,40). vis(g_b,s0). vis(g_b,b).
view(g_union,40). vis(g_union,s0). vis(g_union,a). vis(g_union,b).
