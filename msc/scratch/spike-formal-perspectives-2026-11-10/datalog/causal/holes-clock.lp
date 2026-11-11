% Five small cases the two builds reported in the guard and merge wording, for M0 on the clock footing (../m0.lp).
% One root o pointing at a claim c (and x where needed). Each case has its own branch names and view.
slot(o,o1,c,point,firm). asks_valid(c).
write(s0,1,c,c0). write(s0,2,o,o1). markroot(s0,3,o). evidence(k0,4,c,c0,valid,holds).

% A. the lost rewrite (TLA+ fork, forks-3b): two forks each rewrite c and have it checked
write(a1,20,c,ca). evidence(ka,21,c,ca,valid,holds).
write(a2,30,c,cb). evidence(kb,31,c,cb,valid,holds).
view(a_fork1,40). vis(a_fork1,s0). vis(a_fork1,a1).
view(a_fork2,40). vis(a_fork2,s0). vis(a_fork2,a2).
view(a_union,40). vis(a_union,s0). vis(a_union,a1). vis(a_union,a2).

% C. the round trip (OCaml 3.3): found wrong at c0, fixed and answered at c1, c0 put back, then any edit
evidence(fc,50,c,c0,casex,fails).
write(cc,51,c,c1). evidence(kc1,52,c,c1,valid,holds). evidence(kc2,53,c,c1,casex,holds).
write(cc,54,c,c0). write(cc,55,c,c9). evidence(kc3,56,c,c9,valid,holds).
view(c_roundtrip,60). vis(c_roundtrip,s0). vis(c_roundtrip,cc).

% D. checked before selected (OCaml 3.2): the fix is checked for the case before this line has it
evidence(kd1,57,c,c7,casex,holds). evidence(kd2,58,c,c7,valid,holds).
write(dd,59,c,c7).
view(d_checked_first,60). vis(d_checked_first,s0). vis(d_checked_first,dd).

% E. an old pass meets a new finding (Ada G2): c0 passed casex before it failed casex; reworded, the old pass carried
evidence(ke0,5,c,c0,casex,holds).
write(ee,59,c,c8). same(ke0,c,c0,c8). same(k0,c,c0,c8).
view(e_old_pass,60). vis(e_old_pass,s0). vis(e_old_pass,ee).

% F. a rewind erases the footing (Ada G3): a draft is found wrong on a fork, the fork is rewound, the draft is re-entered reworded
write(ff_dead,45,c,cdraft). evidence(ff,46,c,cdraft,casey,fails).
write(ff,47,c,cdraft2). evidence(kf,48,c,cdraft2,valid,holds).
view(f_rewound,49). vis(f_rewound,s0). vis(f_rewound,ff).
#defined reads/3. #defined setaside/3. #defined raise/4. #defined waive/4. #defined inner/3. #defined result/1. #defined pred/3. #defined affirm/6. #defined wrote_against/4.
