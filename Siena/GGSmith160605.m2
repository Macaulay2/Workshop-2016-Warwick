points = method()
points Matrix := (M) -> (
        V := vars ring M;
	if not isPolynomialRing(ring M) then error "expected a matrix over a polynomial ring";
	if rank source V =!= rank target M then 
	               error "given matrix has not expected number of rows";
	Points := ideal(V*(gens ker transpose M_{0}));
	scan(rank(source M)-1, i -> Points = intersect(Points,ideal(V*(gens ker transpose M_{i+1}))));
	Points
	)
testMatrix = method()
testMatrix ZZ := d ->(
(p,r) =  getPrimeWithRootOfUnity(d,5, Range => (50,1000));
x := symbol a; y:=symbol b;
S := ZZ/p[a_1..a_d,b_1..b_d];
C := map(S^d, S^d, (i,j) -> if (j-i-1) % d == 0 then 1 else 0);
A := diagonalMatrix toList(a_1..a_d);
--B := diagonalMatrix toList(b_1..b_d);
B := diagonalMatrix join({b_d},toList(b_1..b_(d-1)));
--(cycle^(1)*A*cycle^(-1),B*cycle)
X := apply(d, i-> C^(i)*A*C^(-i)+r^i*B*C^(-1));
(X,A,B, C)
)

///
restart
load"GGSmith160605.m2"
(X,A,B,C) = testMatrix 1

product X
sub (AA_0*BB_1-BB_1*AA_0, R)
sub (AA_1*BB_0-BB_0*AA_1, R)
sub (AA_0*AA_1-AA_1*AA_0, R)
product X
presentation R
A
netList flatten entries product X
(B*C)^3
B*(C*B*C^(-1))*C^2*B*C^(-2)
(B*C)^2
(B*C*B*C^(-1))*C^2

(B^2)*(C^2)
C*B
product X
///

testMatrix(ZZ,ZZ) := (d,m)->(
    --block matrices with m x m blocks; cyclic commuting within AA and, and
    --BB_i commutes with everything.
--do it in char p for readability
(p,r) =  getPrimeWithRootOfUnity(d,5, Range => (50,1000));
z =(i,n)-> (n+i)%d;

--building blocks
x := symbol a; y:=symbol b;
S = ZZ/p[a_(0,0,0)..a_(d-1,m-1,m-1),b_(0,0,0)..b_(d-1, m-1,m-1)];
one = map(S^m,S^m, 1);
zer = map(S^m,S^m, 0);
AA = apply(d, i-> transpose genericMatrix(S,a_(i,0,0),m,m));
BB = apply(d, i-> transpose genericMatrix(S,b_(i,0,0),m,m));
--BB = join({genericMatrix(S,b_(d-1,0,0),m,m)}, apply(d-1, i-> genericMatrix(S,b_(i,0,0),m,m)));
--Now make the block matrices
--the cyclic permutation
C = map((S^m)^d, (S^m)^d, 
    matrix apply(d, i-> apply(d, j-> if (j-i-1) % d == 0 then one else zer)));
--A_i and B_i down the diagonal
A = map((S^m)^d,(S^{m:-1})^d, 
    matrix apply(d, i-> apply(d,j-> if i == j then AA_i else zer))
    );
--B = map((S^m)^d,(S^{m:-1})^d, 
--    matrix apply(d, i-> apply(d,j-> if i == j then  BB_i else zer))
--    );
B = map((S^m)^d,(S^{m:-1})^d, 
    matrix apply(d, i-> apply(d,j-> if i-(1+j) %d ==0 then  BB_j else zer))
    );
--X = apply(d, i-> C^(i)*A*C^(-i)+r^i*B*C^(-1));

X = apply(d, i-> C^(i)*A*C^(-i)+r^i*B);
--Now construct what *should* be the answer (ie X == Y mod the commutativity conditions).
--Note the sign in the Y_i
Yblock = product(d,i->AA_i)-(-1)^(d)*product(d, i->BB_(d-1-i));
Y = map(S^(m*d), S^{m*d:-d}, matrix apply(d, i-> apply(d,j-> if i==j then Yblock else 0)));

--VARIOUS partial commutativity that I tried.
--eqns that say A_i commutes with B_j for i !=j
--uneq = select (subsets(d,2), s -> s_0 !=s_1);
--eq2 = sum apply(uneq, s -> ideal (AA_(s_0)*BB_(s_1)-BB_(s_1)*AA_(s_0)));
--eq3 = sum apply(uneq, s -> ideal (AA_(s_1)*BB_(s_0)-BB_(s_0)*AA_(s_1)));
--eq2 = sum flatten apply(d,i->ideal(AA_i*BB_i-BB_i*AA_i));
--eq = eqA+eqB+eq2; -- +eq3;
--eq = eqA+eqB+eq2;
--eqAall = sum flatten apply(d, s-> apply(d, t-> ideal(AA_s*AA_t-AA_t*AA_s)));
--eq = eq2+eqAall+eqBall;

--eqns that say As and the Bs each cyclically commute:
PA = product apply(d, i-> AA_i);
eqA = sum apply(d-1, j -> ideal(
	product apply(d, i -> AA_(z(j+1,i))) -  PA));
PB = product apply(d, i-> BB_(d-1-i));
eqB = sum apply(d-1, j -> ideal(
	product apply(d, i -> BB_(d-1-z(j+1,i))) - PB));
--eqns that say A_i commutes with B_j for i !=j
uneq1 = select (subsets(d,2), s -> s_0 !=s_1);
uneq = join(uneq1, uneq1/reverse);
eq3 = sum apply(uneq, s -> ideal (AA_(s_1)*BB_(s_0)-BB_(s_0)*AA_(s_1)));

eq = eqA+eqB+eq3;

--What previously worked best:
--PA = product apply(d, i-> AA_i);
--eqA = sum apply(d-1, j -> ideal(
--	product apply(d, i -> AA_(z(j+1,i))) -  PA));
--eqBall = sum flatten apply(d, s-> apply(d, t-> ideal(BB_s*BB_t-BB_t*BB_s)));
--eq2 = sum flatten apply(d, s-> apply(d, t-> ideal(AA_s*BB_t-BB_t*AA_s)));
--eq = eq2+eqA+eqBall;
--avoid a problem that plagued an earlier version:
assert isHomogeneous eq;

--check the commutativity relations, and that the answer comes out right

--for m>=3 the program is SLOW. It would be nice to compute the GB of eq only up to 
--degree d or d+1, but I can't figure out how to keep R = S/seq from computing the rest.
--The following does not work.
--eq = ideal forceGB gens (gb(gens eq, DegreeLimit => d));
--error();

R = S/eq;
--assert all(flatten apply(d, i->apply(d,j-> (sub(AA_i*BB_j -BB_j*AA_i, R) ==0))), i->i);
--assert all(flatten apply(d, i->apply(d,j-> (sub(BB_i*BB_j -BB_j*BB_i, R) ==0))), i->i);

XR = sub(product X,R);
YR = sub(Y, R);
assert(XR - YR == 0);

--with this minimal commutativity assumption, the X's do NOT satisfy cyclic
--commutativity mod the equations, eg for d=3, m=2! This is shown by the following 
--asserts, which are commented out Of course if they are really a matrix factorization,
--then they do automatically.
--PX = product apply(d, i-> X_i);
--eqX = sum apply(d-1, j -> ideal(
--	product apply(d, i -> X_(z(j+1,i))) -  PX));
--the X_i do not commute cyclically in this order.
--assert (sub(eqX, R) == 0);

--And also not in the reversed order:
--PX = product apply(d, i-> X_(d-1-i));
--eqX = sum apply(d-1, j -> ideal(
--	product apply(d, i -> X_(d-1-z(j+1,i))) -  PX));
--assert (sub(eqX, R) == 0);

(XR, YR, AA,BB,C,R)
)
end--
--when the AA_i commute cyclically in the order AA_0..AA_(d-1),
--and the BB_i commute cyclically in the opposite order BB_(d-1)..BB_0,
--and BB_i commutes with AA_j for all i !=j,
--then the product is correct
--BUT the resulting X_i do NOT commute cyclically, as tested by an assert
--assert statements in the script.

-- note: testMatrix(d,m) is relatively fast for m=1,2, but testMatrix(3,3) is slow.
-- could limit the degree of the gb to make it faster if we needed to.

restart
--gbTrace = 3
load"GGSmith160605.m2"
testMatrix 3

(XR,YR, AA,BB,C,R) = testMatrix(5,2);

A
B
C

eq



restart
S = ZZ/101[a_(0,0)..a_(1,1), b_(0,0)..b_(1,1), c_(0,0)..c_(1,1)]


A = transpose genericMatrix(S,a_(0,0),2,2)
B = transpose genericMatrix(S,b_(0,0),2,2)
C = transpose genericMatrix(S,c_(0,0),2,2)
X = A*B*C
x = X_(0,0)
I = ideal(X_(0,0)-X_(1,1), X_(0,1), X_(1,0))
netList (P = decompose(I + ideal(b_(1,0),b_(0,1))))
R = S/P_0
AR = sub(A,R)
BR = sub(B,R)
CR = sub(C,R)
AR*BR*CR
transpose presentation R
dim R
restart
S = ZZ/101[a,b,c,x,y,z]
factor det diagonalMatrix{a*b*c+x*y*z,a*b*c+x*y*z}

--explorations of Childs' Thm etc
viewHelp
restart
--the lone cubic that is NOT a determinant 
--(according to Dickson)
--IS the pfaffian of a 6x6 linear matrix phi,
--defined below.
S = ZZ/101[a..d]
I = ideal"a2b+c3+d3"
R = S/I
J = ideal matrix {{a*c-d^2, -c^2-a*d+b*d, b^2}}
J = ideal matrix {{a*c-d^2, a*d, a*b+c*d}}
betti (F =res J)
--linear matrix, secretly skew symmetric, with
--Pfaffian equal to the cubic:
F.dd_3
JS = sub(J,S)
decompose JS
decompose (JS+I)
netList primaryDecomposition (JS+I)
K = (primaryDecomposition (JS+I))_1
betti res (KR = sub(K,R))
betti res intersect(KR,ideal(b, c-d, a))

use S
--a skew-symmetric matrix whose pfaffian is
--the special cubic.
mm1 = matrix"
0,d,0,-c,-d,-b;
0,0,a,-b,-c,0;
0,0,0,d,0,-c;
0,0,0,0,-a,0;
0,0,0,0,0,d;
0,0,0,0,0,0";
mm = mm1-transpose mm1
pfaffians(6, mm)

phi = map(S^6,,mm)
betti res coker (R**phi)
psi = R**phi
betti res coker psi^{0,1,2}

---
restart
S = ZZ/101[x,y,z,w]
R = S/ideal(x*y*z)
betti res ideal"x2,y2,z2"

--7 general points on a cubic surface
--lie on 3 quadrics.
--they have 6 first syzygies, and there are
--exactly 6  syzygies on them, all linear.
--when lifted to P3 this matrix has determinant
--the square of the cubic. In the example above,
--the matrix can be made skew symmetric, so presumably
--the cubic is the pfaffian in general. (But this
--might need a special choice of the points!?)
--(note that ALL but the cubics equivalent to
--a^2b+c^3+d^3, having one D4 singularity and
--an Eckhardt point (see Bruce and Wall), are determinants of 3x3,
--as shown by Dickson. In the example above,
--with skew-symmetric matrix, the scheme 
--defined by the quadrics was a 6-fold point
--at the singular point of the cubic plus 
--the Eckhardt point

use S 
pmat = id_(S^4)|transpose matrix"1,1,1,1"|random(S^4,S^2)
factor i_3 -- Groebner chooses a reducible cubic in the ideal!
i = points pmat
R = S/i_3
j = trim sub(i,R)
betti (F=res j)


----
restart
d = 3
S = ZZ/101[x_0..x_(d-1),y_0..y_(d-1)]
f = product(d, i->x_i)-product(d,i->y_i)
R = S/f
i = ideal(x_0*x_1-y_0*y_1, x_0*y_0)
betti (F =  res i)
toString F.dd_3
m = matrix {{x_0, 0, -y_1}, {y_2, x_2, 0}, {0, y_0, x_1}}
F.dd_4
use S
m = matrix{{x_0,0,y_0},{y_1,x_1,0},{0,y_2,x_2}}
R = S/det m
syz sub(m,R)
m^2

restart
S = ZZ/101[a..i]
f = a*b*c+d*e*f+g*h*i
betti res trim ideal presentation singularLocus (S/f)

