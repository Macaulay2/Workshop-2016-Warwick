--load "phcUtils.m2"

---------------------------------------------------------------------
----TODO:------------------------------------------------------------
-------> Use the nice, triangular (decomposed?) Groebner basis-------
---------to find the ZZ/2 solutions--DONE!!!!!-----------------------
-------> Check these against original ideal to make sure they--------
---------actually satisfy it--DONE!!!!-------------------------------
-------> Write down S_n elements from these solutions----------------
---------------------------------------------------------------------
---------------------------------------------------------------------

clearDenoms = p -> (
    return p*lcm(first entries transpose sub((coefficients p)_1,QQ) / denominator);
)

symmetryIdeals = I -> (
    -- For an ideal in n variables, returns an ideal in n^2
    -- variables whose solutions are ideal-respecting
    -- variable swaps. Returns a tuple of this as an ideal
    -- in Z/2 and over the original coefficient ring.
    curTime = currentTime();
    R = ring I;
    n := numgens R;
    myVars := c_(1,1)..c_(n,n);
    justCs := coefficientRing R [myVars];
    csAsCoeffs := justCs[gens R];
    S := R ** justCs;
    m := sub(matrix pack(n,gens justCs),S);
    combo := first entries transpose (m*(transpose matrix {(gens S)_{0..n-1}}));
    subList := for i in 0..n-1 list S_i => combo_i;
    polys := (I_*) / (a->substitute(substitute(a,S),subList));

    print (currentTime()-curTime);
    diagProd := {product (for i in 1..n list sub(c_(i,i),S))};
    degreeLimiter := for x in gens justCs list sub(x^2-x,S);
    rowSums := flatten for row in entries m list {sum row - 1};
    pairwiseProds := flatten for row in entries m list
        flatten for i in 0..n-1 list for j in (i+1)..n-1 list row_i*row_j;
    relationsOnC := degreeLimiter | rowSums | diagProd | pairwiseProds;

    print (currentTime()-curTime);
    --newI := ideal relationsOnC + substitute(I,S);
    newI := ideal degreeLimiter + substitute(I,S);
    print (currentTime()-curTime);
    modded := polys / (a-> a % newI);
    print (currentTime()-curTime);
    coeffIdeal := sum (modded / (a->sub(a,csAsCoeffs)) / content);
    coeffIdeal = sub(ideal relationsOnC,justCs) + coeffIdeal;
    coeffIdeal = ideal ((first entries gens coeffIdeal) / clearDenoms);
    Z2 := ZZ/2[myVars,MonomialOrder => Lex];
    return (ideal first entries gens gb sub(coeffIdeal,Z2),coeffIdeal);
)

solveTriangular = I -> (
    myVars = gens ring I;
    getSols := p -> ( --ASSUMES NONZERO
        sols := {};
        if someTerms(p,-1,1) != 1 then sols = {0};
        if #(exponents p) % 2 == 0 then sols = sols | {1};
        return sols;
    );
    recurse := (I,i) -> (
        ---- Returns the optlist solutions for the last n-i polys in I ----
        p := I_i;
        if p==0 then (return recurse(I,i+1));
        varNum := position(first exponents p, a->a!=0);
        theseSols := getSols p;
        theseSols = apply(theseSols,a->(myVars_varNum => a));
        if (i+1)==numgens I then return pack(1,theseSols);
        toReturn := {};
        for sol in theseSols do (
            moreSols := recurse(sub(I,sol),i+1);
            toReturn = (toReturn | (for s in moreSols list (s | {sol})));
        );
        return toReturn;
    );
    return recurse(I,0);
)

testIdeal = choice -> (
    if choice==1 then (
        R = QQ[vars {53..59}];
        I = ideal {x5^2 - 4*x4*x6 + x6^2 + 2*x1*x7 - 2*x7, x3^2 - x2*x6 - x5*x6 - x3, -x3*x4 + x1*x5 - x6*x7 + x4, 4*x2*x4 + x4*x6 - 6*x3*x7 - x7^2 + 2*x7, -7*x2*x4 - 5*x2*x6 - 11*x1*x7 + 4*x5*x7};
    )
    else if choice==2 then (
        R = QQ[vars {53..60}];
        I = ideal {1/2*x1*x2*x4 + x4^2*x7 - x1*x2 - 19*x3*x8 , -2*x2*x3^2 - 1/3*x3^2*x8 - 19/2*x8^3 - 1/8*x4*x7 - 1/2*x3*x8 , 30*x2^2*x4 + 3/2*x5*x6*x7 + 3*x6^2*x8 - 1/2*x5*x7 , 3*x3^2*x4 - x1*x6*x7 + x1*x2 + 2*x4*x8 , 1/2*x3*x5^2 - x4*x7^2 + x4*x6 + 2*x7 , -1/2*x1*x2*x4 - x2^2*x5 + 403/15*x1*x3*x6 - 4*x1*x7^2};
    )
    else if choice==3 then (
        R = QQ[x1,x2,x3,x4];
        I = ideal {x1 + x2 + x3 + x4, x1*x2 + x2*x3 + x1*x4 + x3*x4, x1*x2*x3 + x1*x2*x4 + x1*x3*x4 + x2*x3*x4, x1*x2*x3*x4 - 1};
    )
    else (
        R = QQ[x,y,z];
        I = ideal {x+y^2+z^3, z+x^2+y^3,y+z^2+x^3};
    );
    return I;
)

I = testIdeal 4;
J = symmetryIdeals I;
switchOptionRing = opts -> (
    R = ring J_1;
    return for opt in opts list (
        sub(opt#0,R) => opt#1
    );
)
filterActualPoints = pts -> return select(pts,a -> sub(J_1,switchOptionRing a)==0);
pts = solveTriangular J_0;
pts = filterActualPoints pts;
pts = (for pt in pts list (
    pt = new HashTable from pt;
    apply(myVars,a->pt#a)
))
n := numgens ring I;
transpositions = for pt in pts list (
    m = matrix pack(n,pt);
    flatten entries (m*transpose matrix {toList (1..n)})
)
print transpositions;

--compute a groebner basis, test permutations of variables
factorialMethod = I -> (
  gbI := gb I;
  << "found gb" << endl;
  ringI := ring I;
  varsI := support I;
  polys := first entries generators gbI;
  perms := permutations varsI;
  -- the first element is the trivial permutation, which doesn't need to be checked
  perms = drop(perms,1);
  << "number of perms to check: " << #perms << endl;

  ignoreSet := set {};
  mapList := new MutableList;
  for i in 0..#polys-1 do (
    for j in 0..#perms-1 do (
      if member(j,ignoreSet) then continue;
      if i == 0 then (
        mapList#j = map(ringI,ringI,apply(varsI,perms#j, (k,l) -> k => l));
      );
      if ((mapList#j (polys#i)) % gbI) != 0 then (
        ignoreSet = ignoreSet + set {j};
      );
    );
  );

  << "# perms found: " << #perms - #ignoreSet << endl;
  
  for i in 0..#perms-1 do (
    if member(i,ignoreSet) then continue;
    << perms#i << endl;
  );
)
--elapsedTime factorialMethod testIdeal 1
