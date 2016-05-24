initialIdeal = method()
initialIdeal (List,Ideal) := (L,I) -> (
   wts := L;
   if any(wts, i -> i <= 0) then (
     if not isHomogeneous I then 
     error "for negative weights, expected a homogeneous ideal";
     m := min wts;
     wts = wts + toList(#wts:-m+1);
     );
   S := ring I;
   K := coefficientRing S;
   R := K(monoid[gens S, Weights => wts]);
   fromS := map(R,S, gens R);
   toS := map(S,R, gens S);
   toS ideal leadTerm fromS I
  )

containsMonomial = method()
containsMonomial Ideal := Boolean => I -> (
  S := ring I;
  n := numgens S;
  return ideal(1_S) == saturate(I, S_(toList(n:1)))
  )

end
------------------------------------------------------------
restart
path = prepend("~/Desktop/", path)
needs "initialIdeals.m2"
S = QQ[a,b,c,d];
I = minors(2,matrix{{a,b,c},{b,c,d}})
J = initialIdeal({ -2,-3,-5,-2},I)
containsMonomial J


numgens S
S_(toList(4:1))

