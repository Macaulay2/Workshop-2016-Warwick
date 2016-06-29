--needsPackage("PHCpack");
fixPrefixBug = method()
fixPrefixBug (PolynomialRing) := R1 -> (
  R1Gens := gens R1;
  numDigits := length (toString (#R1Gens));
  R2 = CC[for i in 1..#R1Gens list (
    value ("x" | demark ("",for i from 1 to numDigits-(length toString i) list "0") | toString i)
  ) ];
  R2Gens = gens R2;
  generatorMapping := for i in 0..#(gens R1) - 1 list (R1Gens#i =>R2Gens#i);
  return map(R2, R1, generatorMapping);
)

getPHCsols = method()
getPHCsols (Ideal) := I -> (
    ourMap = fixPrefixBug(ring I);
    mappedI = ourMap(I);
    return solveSystem (first entries gens mappedI,Verbose=>true);
)

roundSols = l -> (
    return (l/ matrix / clean_1e-14 / entries / flatten);
)
clearDenoms = p -> (
    return p*lcm(first entries transpose sub((coefficients p)_1,QQ) / denominator);
)

findIdealSymmetries = I -> (
    n := numgens ring I;
    myVars := c_(1,1)..c_(n,n);
    justCs := coefficientRing R [myVars];
    csAsCoeffs := justCs[gens R];
    S := R ** justCs;
    m := sub(matrix pack(n,gens justCs),S);
    combo := first entries transpose (m*(transpose matrix {(gens S)_{0..n-1}}));
    subList := for i in 0..n-1 list S_i => combo_i;
    varProd = product (for i in 1..n list sub(c_(i,i),S));
    relationsOnC := (flatten for row in entries m list {sum row - 1});-- | {varProd};
    newI := substitute(I,S);
    polys = (I_*) / (a->substitute(substitute(a,S),subList));
    modded = polys / (a-> a % newI);
    coeffIdeal = sum (modded / (a->sub(a,csAsCoeffs)) / content);
    coeffIdeal = coeffIdeal + sub(ideal relationsOnC,justCs);
    coeffIdeal = ideal ((first entries gens coeffIdeal) / clearDenoms);
    return ideal first entries gens gb sub(coeffIdeal,ZZ/2[myVars,MonomialOrder => Lex]);
)

R = QQ[x,y,z];
I = ideal {x+y^2+z^3, z+x^2+y^3,y+z^2+x^3};
--R = QQ[vars {53..59}];
--I = ideal {x5^2 - 4*x4*x6 + x6^2 + 2*x1*x7 - 2*x7, x3^2 - x2*x6 - x5*x6 - x3, -x3*x4 + x1*x5 - x6*x7 + x4, 4*x2*x4 + x4*x6 - 6*x3*x7 - x7^2 + 2*x7, -7*x2*x4 - 5*x2*x6 - 11*x1*x7 + 4*x5*x7};
J = findIdealSymmetries I;
J
