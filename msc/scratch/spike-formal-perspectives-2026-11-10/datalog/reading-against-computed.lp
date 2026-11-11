% The other reading of "written against": not what the write recorded, but what the line
% says the target was at when the write was made. On a union of two forks this is read
% from the union, and credits a writer with having seen what it never saw.
against(R,P,V,Q,W) :- selwrite(R,P,V,T), pred(P,V,Q), selat(R,T,Q,W).
