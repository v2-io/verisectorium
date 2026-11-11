% One piece with a known defect, and a waiver of it that stands only while p is consistent.
viol(p).
waived(p) :- not fault(p).
owed(p)   :- viol(p), not waived(p).
fault(p)  :- owed(p).
