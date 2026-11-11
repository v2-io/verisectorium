% impl-an-outline-fills-in, steps 4 and 7. Result r2 holds a claim c2 and a named assumption x
% ("X is finite"), which is a piece like any other. The root asks that c2 be checked and that r2
% be accepted. The acceptance names x as a condition. Later a check shows x false in one case.
asks_valid(c2). asks_accepted(r2).
slot(r2,r2v,c2,hold,firm). slot(r2,r2v,x,hold,firm). slot(o,o1,r2,point,firm).
write(s0,1,c2,c2a). write(s0,2,x,xa). write(s0,3,r2,r2v). write(s0,4,o,o1). markroot(s0,5,o).
evidence(v1,6,c2,c2a,valid,holds).
accept(s0,7,dec1,r2). cond(dec1,x).
evidence(v2,20,x,xa,finite,fails).           % step 7: nothing is rewritten
view(before,10). vis(before,s0).
view(after,25).  vis(after,s0).
#defined same/4. #defined setaside/3. #defined raise/4. #defined waive/4. #defined inner/3. #defined result/1. #defined pred/3. #defined affirm/6. #defined wrote_against/4. #defined reads/3.
