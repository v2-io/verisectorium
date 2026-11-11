% A reading, parallel to condition 2: a write of a dependent counts as having
% looked at what it depends on, as that then stood, and the write records it.
% Without this the story's S1 is not stationary by the letter of condition 6:
% the story never says anyone looked at k2 beside e1.
together(R,X,VX,Y,VY) :- against(R,X,VX,Y,VY).
wrote_against(fb,62,e,e1).
