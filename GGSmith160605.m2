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

bidiag =  (d,r) ->
 map(S^d,S^{d:-1}, (i,j) -> 
    if i == j then S_((i+r)%d) else
    if (i-j-1) % d == 0 then S_(d+i) else 0_S)
end--

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
0,0,0,0,0,0"
mm = mm1-transpose mm1
pfaffians(6, mm)

S = ZZ/101[a..z]
mm2 = matrix"
0,a,d,-x,e,c;
0,0,b,e,-y,0;
0,0,0,c,0,-z;
0,0,0,0,a,d;
0,0,0,0,0,b;
0,0,0,0,0,0"
mm = mm2-transpose mm2
pfaffians(6, mm)
 

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
load"GGSmith160605.m2"
d = 3
S = ZZ/101[x_0..x_(d-1),y_0..y_(d-1)]
f = product(d, i->x_i)+product(d,i->y_i)
m = bidiag(3,0)
B = apply(d, i-> bidiag(d,i))
mm = bidiag(3,1)*bidiag(3,2)
factor det mm
(f*id_(S^d))//m
mmm = ((f^2*id_(S^d))//mm)

factor det mm
R = S/det m
mR = sub(m,R)
mmR = sub(mm,R)
betti res coker mmR

d=3
S = ZZ/101[x_0..x_(d-1),y_0..y_(d-1)]
f = product(d, i->x_i)-product(d,i->y_i)
R = S/f

product B
betti res coker sub(product B, R)


i = ideal(x_0*x_1-y_0*y_1, x_0*y_0)
betti (F =  res i)
toString F.dd_3
om = matrix {{x_0, 0, -y_1}, {y_2, x_2, 0}, {0, y_0, x_1}}
F.dd_4
use S
m = matrix{{x_0,0,y_0},{y_1,x_1,0},{0,y_2,x_2}}
R = S/det m
syz sub(m,R)
m^2

S = ZZ/101[vars(0..14)]

M = genericSkewMatrix(S,a,6)
pfaffians(6, M)
spec = map(S,S,{a,0,c,0,e,f,f,h,0,j,k,l,m,0,o})
sM = spec M
pfaffians(6, sM)

f = a*b*c+d*e*f+g*h*i
R = S/f
I = intersect{ideal(a,d,g),ideal(a,d,h),ideal(a,d,i),
    ideal(a,e,h),ideal(b,e,h), ideal(c,e,h),
    ideal(c,d,g)}
betti res I
codim(ideal(f)+q)
betti res q

restart
S = ZZ/101[a,b,c,x,y,z,u,v,w,p_0..p_5]
f = ideal"abc+xyz+uvw"
R = S/f
I = product toList(
    ideal"a,b", 
    ideal"a,c",
    ideal"b,c",
    ideal"x,y", 
    ideal"x,z",
    ideal"y,z",
    ideal"u,v", 
    ideal"u,w",
    ideal"v,w"
    )

betti res I
use S
m = matrix{
{0,a,0,u,0,x},
{0,0,0,z,v,0},
{0,0,0,0,y,w},
{0,0,0,0,b,0},
{0,0,0,0,0,c},
{0,0,0,0,0,0}}

mm = m-transpose m
pfaffians(6,matrix mm)

restart
S = ZZ/101[x_0..x_14]
subs = subsets(15,6);
M = genericSkewMatrix(S,x_0,6)
L = subs_0
varlist = toList(x_0..x_14)

zeroOut = L ->
pfaffians(6,(map(S,S,apply(15, i->if member(i,L) then 0 else x_i))) M)

polys = apply(subs, L -> if numgens zeroOut L == 0 then 0_S else (zeroOut L)_0);
polys3 = select(polys, p-> size p == 3);

select(polys3, p->all(0..14, i->size sub(p,{x_i =>0})>1))


