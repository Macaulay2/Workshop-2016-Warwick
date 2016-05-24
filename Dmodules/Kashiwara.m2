restart
needsPackage "Dmodules"

-------------------
-- experiments...
-------------------
QQ[x, y]; f = y^2 - x^3
QQ[x,y]; f = (x + 1)*(x - y + 2)*(x + 2*y)
QQ[x,y]; f = (x + 1)*(x - y + 2)

A = AnnFs(f)

-- this may not work, need "gbw of gbw" 
C = newRing(ring A, MonomialOrder => {Weights => {0, 0, 0, 0, 1}, Weights => {0, 0, 1, 1, 1}})
A' = sub(A,C)
s = last gens C
groebnerBasis A'
 
gbw(A,{0,0,1,1,1}) -- need to implement a version for the case D[s]
-- R = newRing(ring A,Weights=>{0,0,1,1,1})
W = ring A;
s = last gens W
R = (coefficientRing W) [x,y,s,dx,dy, WeylAlgebra=>{x=>dx,y=>dy}]
A' = sub(A,R)
s = R_2

-- suppose m = 1 
B = {s,dx,dy}
-- suppose m = 2
B = {s^2, s*dx,s*dy,dx^2,dx*dy,dy^2} 
apply(B, b->b % A')

B' = flatten apply(B,b->apply(
	flatten for i to 2 list
	((ideal{x,y})^i)_*
	,
	t->t*b)) 
apply(B', b->b % A')

--------------------------------------
-- this works (for 2/3 examples below)
--------------------------------------

-- pick one
W = makeWA(QQ[x,y]); f = (x + 1)*(x - y + 2)*(x + 2*y)
W = makeWA(QQ[x,y]); f = (x + 3*y)*(x - y)*(x + 2*y)
W = makeWA(QQ[x,y]); f = y^2 - x^3

A = AnnFs {f}
RA = ring A
NRA = newRing(RA,Weights=>{0,0,0,1,1,1},Weights=>{0,0,1,0,0,1})
G = sub(gbw(A,{0,0,0,1,1,1}),NRA)
use NRA
s = - NRA_5*NRA_2
m = 1
m = 2
m = 3 

--monomials in a K-operator of s-degree m
B = flatten for i to m list ((ideal s^(m-i))*sum(i+1,j->(ideal {dx,dy})^j))_*

B' = apply(B, b->b % G)
fakeR = (coefficientRing NRA)[x,y][NRA_2,NRA_3,NRA_4,NRA_5]
CM = last coefficients matrix {apply(B',b'->sub(b',fakeR))}
syz CM
