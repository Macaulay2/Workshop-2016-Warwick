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

M1 = trim collinear -- this is a prime ideal
L = M1 + I1 + I2 + I3
G1 = flatten entries gens gb(L, DegreeLimit=>5);
G1/(f -> apply(factorize f, x -> if first degree x#1 > 1 then x#1 else 0));
L = L + ideal flatten oo;
L = trim L
L = ideal L_*;

R1 = KK[t, u,v,w, a,b,c, d,e,f, x,y,z, MonomialOrder=>Eliminate 1];
L1 = sub(L,R1);
L1 = L1 + ideal(t*(c-f)-1)
groebnerBasis(L1, Strategy=>"F4", "MGBOptions"=>{"Log"=>"F4"});

R = KK[u,v,w, a,b,c, d,e,f, x,y,z, MonomialOrder=>Eliminate 9];
L = sub(L,R)
see L
codim L

groebnerBasis(L, Strategy=>"F4", "MGBOptions"=>{"Log"=>"F4"});
ideal(a-u,b-v,c-w,a-d,b-e,c-f);
see M1
use ring I1
(I1 + I2) : 



gbTrace=3
L1 = L : (u-a);
L2 = L1 : (a-d);
L3 = L2 : (a-d);
L2 == L3
L1 == L2
codim L2

-- formulation #2
S = KK[x,y,z];
I = ideal(x*y+x*z+y*z+x+y+z, x^3+y^3+z^3-1);
R = KK[x,y,z, u,v,w][t, Join=>false]

-- parametric line through (x,y,z)
-- f(t) = (x,y,z) + t(u,v,w)
-- want G1(f(t)) = G2(f(t)) = 0 to have >= 3 solutions
use coefficientRing R
--J = ideal(x+t*u, y+t*v, z+t*w)
phi = map(R,S,{S_0=>x+t*u, S_1=>y+t*v, S_2=>z+t*w})
L = phi I
groebnerBasis(L, Strategy=>"F4");
Lgb = ideal oo;
Lgb_0
gens gb L;
see ideal oo
La = L : ideal(a-u,b-v,c-w);
Lb = La : ideal(a-d,b-e,c-f);
Lc = Lb : ideal(u-d,v-e,w-f);
codim La
codim Lb
La = saturate(L, u-a);
L1 = L : (u-a);
L1 = trim L1;
codim L1
L2 = L1 : (a-d);
L2 == L1
L2 = trim L2
((w-f)*(a-d)) % L1
L11 = L1 : ideal(w-f, a-d);
L11 = trim L11
L11 == L1 -- true
codim L2
eliminate({a,b,c,d,e,f,u,v,w},L)
gens gb L;


Rh = KK[u,v,w, a,b,c, d,e,f, x,y,z, MonomialOrder=>Eliminate 9];
Lh = sub(L, Rh)

Lh = ideal homogenize(gens Lh, t)
gbLh = groebnerBasis(Lh, Strategy=>"F4");
selectInSubring(1,gbLh)
gens gb Lh;


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
