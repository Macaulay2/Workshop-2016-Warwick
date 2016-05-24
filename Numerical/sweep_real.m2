
--intersectSlice = (w,slcRR) -> (
--    startSys:=join(equations(w),slice(w));
--    targetSys := equations(w) | slcRR;
--    trackPaths(targetSys,startSys,w.Points)
--)

searchSlice = method();
searchSlice (WitnessSet):= w -> (
    costfun := (x) -> sliceCost(matrix {{1_CC,0,0,x}}, w);
    xmin := goldenSearch (costfun, -5.0, 5.0, 0.001);
    slcmin := matrix{{1_CC,0,0,xmin}};
    return matrix2slice(slcmin,w)
)

matrix2slice = (slcmat, w) -> (
    R2 := ring w.Equations;
    X := transpose (vars(R2) | 1);
    slc := flatten entries (promote(slcmat,R2) * X);
    return slc;
)


-- Inputs: slcmat -> Matrix representing the slice
--         w -> Witness set
sliceCost = (slcmat, w) -> (
    slc := matrix2slice(slcmat,w);
    fsols := intersectSlice(w,slc);
    cost := norm ( coordinates(fsols_0) / imaginaryPart );
    return cost;
)

goldenSearch = (F,a,b,tol) -> (
    gr := (sqrt(5) - 1)/2;
    c := b - gr * (b - a);
    d := a + gr * (b - a);
    while abs(c - d) > tol do (
        Fc := F(c);
        Fd := F(d);
        if Fc < Fd then ( b = d;)
        else ( a = c;);
        c = b - gr * (b - a);
        d = a + gr * (b - a);
    );
    return (b + a) / 2;
)

-- Example: rank 3 matrices
R=CC[a,b,c,d];
M=matrix for i to 2 list for j to 3 list random(1,R)+random(0,R);
I=minors(3,M);
f=flatten entries gens I;
(w,ns) = topWitnessSet(f,2);
slcmat = matrix applyTable (entries w.Slice, x->1_CC*realPart x);
R2 := ring w.Equations;
X := transpose (vars(R2) | 1);
slcRR = flatten entries (promote(slcmat,R2) * X);
fsols = intersectSlice(w,slcRR)

-- Example: Line search
myFunction = (x) -> (1-x)*sin((3*x)^3)
goldenSearch( myFunction, .4, .7, .00001)

-- Example: Circle
R = CC[x,y];
system = {x^2 + y^2 - 1};
(w,ns) = topWitnessSet(system, 1);
slc = searchSlice( w );
solsRR = intersectSlice( w, slc );

