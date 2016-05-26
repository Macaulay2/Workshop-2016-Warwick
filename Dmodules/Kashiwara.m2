needsPackage "Dmodules"

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


R = QQ[x, y]; f1 = y^2 - x^3;
R = QQ[x, y]; f2 = x*y*(x+y^2)*(x^2+y);
R = QQ[x, y]; f3 = -(x^9/9 + y^4/4) + 1*x^7*y + 1*x^5*y^2;
R = QQ[x, y]; f4 = -(x^9/9 + y^4/4) + 1*x^7*y + -7/2*x^5*y^2;
R = QQ[x, y, z]; f5 = 1/4*(x^4 + y^4 + z^4) - x*y*z;

