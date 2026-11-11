% Two pieces. A question about a that stands only while b is consistent, and the reverse.
stands(qa) :- not fault(b).   owed(a) :- stands(qa).   fault(a) :- owed(a).
stands(qb) :- not fault(a).   owed(b) :- stands(qb).   fault(b) :- owed(b).
