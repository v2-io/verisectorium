% With "written against" worked out from the line (the other reading): is there a pair whose
% union is stationary although the write that now selects x was made by a fork that saw c at
% a version the union does not have, and nobody affirmed x beside the union's c?
:- not stationary(both).
:- not credited.
credited :- selwrite(both,x,X,T), saw(T,C), sel(both,c,C2), C != C2, not affirmed(both,x,X,c,C2).
