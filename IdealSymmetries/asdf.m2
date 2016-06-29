needsPackage("PHCpack");
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
doStuff = I -> (
    n := numgens ring I;
    myVars = c_(1,1)..c_(n,n);
    justCs = coefficientRing R [myVars];
    csAsCoeffs := justCs[gens R];
    S := R ** justCs;
    m := matrix pack(3,(gens S)_{n..(n+n^2-1)});
    combo := first entries transpose (m*(transpose matrix {(gens S)_{0..n-1}}));
    subList = for i in 0..n-1 list S_i => combo_i;
    relationsOnC = flatten for row in entries m list (
        {sum row - 1,row_0*row_1,row_1*row_2,row_0*row_2}
        );
    newI = substitute(I,S)+ideal relationsOnC;
    newI = substitute(I,S);
    firstPoly = substitute(substitute(I_0,S),subList);
    modded = firstPoly % newI;
    --o145 = first entries gens gb ideal flatten entries (coefficients substitute(modded,csAsCoeffs))_1;
    o145 = flatten entries (coefficients substitute(modded,csAsCoeffs))_1;
    --return sub(o145,justCs);
    coeffLocus = ideal relationsOnC + substitute(ideal o145,S);
    --return substitute(coeffLocus,justCs);
    I1 = sub(ideal relationsOnC,justCs);
    I2 = sub(ideal o145,justCs);
    print getPHCsols I1;
    print roundSols(getPHCsols I2);
    print roundSols(getPHCsols ideal first entries gens gb (I1+I2));
)

R = QQ[x,y,z];
I = ideal {x+y^2+z^3, z+x^2+y^3,y+z^2+x^3};
J = doStuff I;
