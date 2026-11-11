% Reads the story's stored facts into the split vocabulary, so the two programs can be compared.
evd(E,T,P,V,C) :- evidence(E,T,P,V,C,_).
rec_h(E) :- evidence(E,_,_,_,_,holds).
rec_f(E) :- evidence(E,_,_,_,_,fails).
#defined same_h/4. #defined same_f/4. #defined setaside_h/3. #defined setaside_f/3.
#defined rec_raise/2. #defined qd/4. #defined waive/4.
