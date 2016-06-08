makeMapRing = thisRing -> (
    n := numgens thisRing;
    SSS := coefficientRing R [c_(1,1)..c_(n,n),MonomialOrder => Lex][gens R];
    S := coefficientRing R [gens R,c_(1,1)..c_(n,n)];
    --S := coefficientRing R [gens R,c_(1,1)..c_(n,n),MonomialOrder => Lex];
    --S := ZZ/2 [gens R,c_(1,1)..c_(n,n)];
    m := matrix (for i in 1..n list (
        for j in 1..n list c_(i,j)
        ));
    combo := first entries transpose (m*(transpose matrix {(gens S)_{0..n-1}}));
    return {for i in 0..n-1 list S_i => combo_i, S,SSS};
);

R = QQ[x,y,z];
I = ideal {x+y^2+z^3, z+x^2+y^3,y+z^2+x^3};
n := numgens R;
qwer = makeMapRing R;
m := (for i in 1..n list (
    for j in 1..n list c_(i,j)
    ));
relationsOnC = flatten for row in m list (
    {sum row - 1,row_0*row_1,row_1*row_2,row_0*row_2}
    );
--addedOn = substitute(I,qwer_1)+asd;
--eliminate ({x,y,z},addedOn)
newI = substitute(I,qwer_1)+ideal relationsOnC;
firstPoly = substitute(substitute(I_0,qwer_1),qwer_0);
modded = firstPoly % newI;
o145 = first entries gens gb ideal flatten entries (coefficients substitute(modded,qwer_2))_1;
coeffLocus = ideal relationsOnC + substitute(ideal o145,qwer_1)
needsPackage "NumericalAlgebraicGeometry";
--solveSystem first entries gens coeffLocus


