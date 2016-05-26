-- 5 random sextics in the ideal of the veronese, random: hard to compute.

-- Tritangent surface of an affine space curve
restart
KK = ZZ/31991
-- KK = QQ

S = KK[x,y,z];
I = ideal(x*y+x*z+y*z+x+y+z, x^3+y^3+z^3-1);
--I = ideal(x*y+x*z+y*z+x+y+z, x^2+y^2+z^2-1);

-- Formulation #1
-- take 3 points on the curve, let (x,y,z) be on a line connecting them
-- eliminate all vars except x,y,z.
-- Result for above ideal should be a degree 4 polynomial in x,y,z.
-- Need to remove the loci where 2 of the points are equal.
R = KK[x,y,z, u,v,w, a,b,c, d,e,f];
f1 = map(R,S,{u,v,w}); I1 = f1(I);
f2 = map(R,S,{a,b,c}); I2 = f2(I);
f3 = map(R,S,{d,e,f}); I3 = f3(I);
collinear = trim minors(3,matrix {{x,y,z,1},{u,v,w,1},{a,b,c,1},{d,e,f,1}});
{codim I1, codim I2, codim I3, codim collinear}
L = collinear+I1+I2+I3;
elapsedTime gbL = groebnerBasis(L, Strategy=>"F4");


-- Take 2
KK = ZZ/31991
S = KK[x,y,z];
I = ideal(x*y+x*z+y*z+x+y+z, x^3+y^3+z^3-1);
R = KK[u,v,w, a,b,c, d,e,f];
f1 = map(R,S,{u,v,w}); I1 = f1(I);
f2 = map(R,S,{a,b,c}); I2 = f2(I);
f3 = map(R,S,{d,e,f}); I3 = f3(I);
collinear = trim minors(3,matrix {{u,v,w,1},{a,b,c,1},{d,e,f,1}});
{codim I1, codim I2, codim I3, codim collinear}
L = collinear+I1+I2+I3;
elapsedTime gens gb L;

elapsedTime gbL = groebnerBasis(L, Strategy=>"F4");
codim ideal leadTerm gbL

-- The following takes too long for Mike
loadPackage "MinimalPrimes"
elapsedTime C = minprimes(L, Verbosity=>2)

R = KK[t, u,v,w, a,b,c, d,e,f, MonomialOrder=>Eliminate 1];
Lt = sub(L, R) + ideal(t*(a-d)-1)
elapsedTime gbLt = groebnerBasis(Lt, Strategy=>"F4");
J = ideal selectInSubring(1, gbLt);
codim ideal leadTerm J
J_*/size
J1 = J + ideal(t*(a-u)-1);
elapsedTime gbJ1 = groebnerBasis(J1, Strategy=>"F4");
J2 = ideal selectInSubring(1, gbJ1);
codim ideal leadTerm J2

J2 = J2 + ideal(t*(d-u)-1);
elapsedTime gbJ2 = groebnerBasis(J2, Strategy=>"F4");
J3 = ideal selectInSubring(1, gbJ2);
codim ideal leadTerm J3

S = KK[x,y,z, u,v,w, a,b,c, d,e,f];
C = sub(J3,S);
codim C
collinear = trim minors(3,matrix {{x,y,z,1},{u,v,w,1},{a,b,c,1},{d,e,f,1}});
C1 = C + collinear;
elapsedTime gbC1 = groebnerBasis(C1, Strategy=>"F4");
codim ideal leadTerm gbC1
eliminate({a,b,c,d,e,f,u,v,w},C1)
