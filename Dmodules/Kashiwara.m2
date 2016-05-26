needsPackage "Dmodules"

---------------------
---- experiments...
---------------------
--QQ[x, y]; f = y^2 - x^3
--QQ[x,y]; f = (x + 1)*(x - y + 2)*(x + 2*y)
--QQ[x,y]; f = (x + 1)*(x - y + 2)
--
--A = AnnFs(f)
--
---- this may not work, need "gbw of gbw"
--C = newRing(ring A, MonomialOrder => {Weights => {0, 0, 0, 0, 1}, Weights => {0, 0, 1, 1, 1}})
--A' = sub(A,C)
--s = last gens C
--groebnerBasis A'
--
--gbw(A,{0,0,1,1,1}) -- need to implement a version for the case D[s]
---- R = newRing(ring A,Weights=>{0,0,1,1,1})
--W = ring A;
--s = last gens W
--R = (coefficientRing W) [x,y,s,dx,dy, WeylAlgebra=>{x=>dx,y=>dy}]
--A' = sub(A,R)
--s = R_2
--
---- suppose m = 1
--B = {s,dx,dy}
---- suppose m = 2
--B = {s^2, s*dx,s*dy,dx^2,dx*dy,dy^2}
--apply(B, b->b % A')
--
--B' = flatten apply(B,b->apply(
--	flatten for i to 2 list
--	((ideal{x,y})^i)_*
--	,
--	t->t*b))
--apply(B', b->b % A')
--
----------------------------------------
---- this works (for 2/3 examples below)
----------------------------------------
--
---- pick one
--W = makeWA(QQ[x,y]); f = (x + 1)*(x - y + 2)*(x + 2*y)
--W = makeWA(QQ[x,y]); f = (x + 3*y)*(x - y)*(x + 2*y)
--W = makeWA(QQ[x,y]); f = y^2 - x^3
--
--A = AnnFs {f}
--RA = ring A
--NRA = newRing(RA,Weights=>{0,0,1,1,1,1})
--G = sub(gbw(A,{0,0,1,1,1,1}),NRA)
--use NRA
--s = - NRA_5*NRA_2
--m = 1
--m = 2
--m = 3
--m = 4
--m = 5
----monomials in a K-operator of s-degree m
--B = flatten for i to m list ((ideal s^(m-i))*sum(i+1,j->(ideal {dx,dy})^j))_*
--
--B' = apply(B, b->b % G);
--fakeR = (coefficientRing NRA)[x,y][NRA_2,NRA_3,NRA_4,NRA_5];
--CM = last coefficients matrix {apply(B',b'->sub(b',fakeR))};
--syz CM
--

R = QQ[x, y]; f1 = y^2 - x^3;
R = QQ[x, y]; f2 = x*y*(x+y^2)*(x^2+y);
R = QQ[x, y]; f3 = -(x^9/9 + y^4/4) + 1*x^7*y + 1*x^5*y^2;
R = QQ[x, y]; f4 = -(x^9/9 + y^4/4) + 1*x^7*y + -7/2*x^5*y^2;
R = QQ[x, y, z]; f5 = 1/4*(x^4 + y^4 + z^4) - x*y*z;

isKoperator = method()
isKoperator RingElement := Boolean => (D) -> (
  -- Sanity checks.
  W := ring D;
  if #(options W)#WeylAlgebra == 0 then
    error "expected an element of the Weyl algebra";
  createDpairs W;
  if #(W.dpairVars#2) == 0 then
    error "expected central element in the Weyl algebra";

  n := (numgens W - 1)//2;
  -- K[x, y, ...][dx, dy, ..., s]
  R := (coefficientRing W)[take(gens W, n)];
  W' := R[drop(gens W, n)];
  D' := sub(D, W');
  m := first degree D';

  s := last gens W';
  C0 := coefficient(s^m, D');
  return sub(C0, flatten apply(gens R, xi -> {xi => 0})) != 0;
);

Koperator = method()
Koperator RingElement := RingElement => (f) -> (
  -- Sanity checks.
  if not isPolynomialRing ring f then
    error "expected a polynomial";

  A := AnnFs(f);
  W := ring A;
  n := numgens ring f;
  G := gbw(A, toList(n:0) | toList(n:1) | {1});

  L := select(flatten entries gens G, isKoperator);
  if #L == 0 then error "Koperator not found.";

  W' := (coefficientRing W)[take(gens W, n)][drop(gens W, n)];
  L' := apply(L, l -> sub(l, W'));
  idx := minPosition(apply(L', degree));
  return L'#idx;
);



TEST ///

///
