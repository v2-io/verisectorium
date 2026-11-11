% The same five cases for M0 on the causal footing (m0-causal.lp).
slot(o,o1,c,point,firm). asks_valid(c).
write(s0,w0,c,c0). wtime(w0,1). write(s0,wo,o,o1). wtime(wo,2). markroot(s0,3,o). evidence(k0,4,c,c0,valid,holds).
% A
write(a1,wa,c,ca). wtime(wa,20). replaces(wa,w0). evidence(ka,21,c,ca,valid,holds).
write(a2,wb,c,cb). wtime(wb,30). replaces(wb,w0). evidence(kb,31,c,cb,valid,holds).
view(a_fork1,40). vis(a_fork1,s0). vis(a_fork1,a1).
view(a_fork2,40). vis(a_fork2,s0). vis(a_fork2,a2).
view(a_union,40). vis(a_union,s0). vis(a_union,a1). vis(a_union,a2).
% C
evidence(fc,50,c,c0,casex,fails).
write(cc,wc1,c,c1). wtime(wc1,51). replaces(wc1,w0). evidence(kc1,52,c,c1,valid,holds). evidence(kc2,53,c,c1,casex,holds).
write(cc,wc2,c,c0). wtime(wc2,54). replaces(wc2,wc1).
write(cc,wc3,c,c9). wtime(wc3,55). replaces(wc3,wc2). evidence(kc3,56,c,c9,valid,holds).
view(c_roundtrip,60). vis(c_roundtrip,s0). vis(c_roundtrip,cc).
% D
evidence(kd1,57,c,c7,casex,holds). evidence(kd2,58,c,c7,valid,holds).
write(dd,wd,c,c7). wtime(wd,59). replaces(wd,w0).
view(d_checked_first,60). vis(d_checked_first,s0). vis(d_checked_first,dd).
% E
evidence(ke0,5,c,c0,casex,holds).
write(ee,we,c,c8). wtime(we,59). replaces(we,w0). same(ke0,c,c0,c8). same(k0,c,c0,c8).
view(e_old_pass,60). vis(e_old_pass,s0). vis(e_old_pass,ee).
% F
write(ff_dead,wf1,c,cdraft). wtime(wf1,45). replaces(wf1,w0). evidence(ff,46,c,cdraft,casey,fails).
write(ff,wf2,c,cdraft2). wtime(wf2,47). replaces(wf2,w0). evidence(kf,48,c,cdraft2,valid,holds).
view(f_rewound,49). vis(f_rewound,s0). vis(f_rewound,ff).
