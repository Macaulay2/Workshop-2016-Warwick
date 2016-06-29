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
