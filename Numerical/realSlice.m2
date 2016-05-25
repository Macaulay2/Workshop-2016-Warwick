-- file to prepare the realSice method for inclusion in PHCpack.m2
-- do load "realSlice.m2" in a Macaulay2 session
--
needsPackage("PHCpack")
--
goldenSearch = (F,a,b,tol) -> (
-- Applies the golden section search method
-- to minimize a unimodal function F over [a,b].
-- IN: F, a function in one variable;
--     a, the left bound of the search interval;
--     b, the right bound of the search interval;
--     tol, tolerance on the approximate minimum.
-- OUT: if F is unimodal (it has a unique minimum),
--      then the value x on return approximates
--      the minimum with respect to the tolerance tol.
-- EXAMPLE: myFunction = (x) -> (1-x)*sin((3*x)^3)
--          goldenSearch( myFunction, .4, .7, 1.0e-4)
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
--
print "testing goldenSearch ..."
myF = (x) -> (1-x)*sin((3*x)^3)
minF = goldenSearch(myF, .4, .7, 1.0e-4)
<<  "the minimum: " << minF << " value: " << myF(minF) << endl
--
matrix2slice = (slcmat, w) -> (
-- Given a witness set w and a matrix of coefficients
-- for a set of hyperplanes, uses the ring of w.Equations
-- to return the list representation of the hyperplanes
-- with coefficients in slcmat.
-- IN: slcmat, a matrix of coefficients of hyperplanes;
--     w, a witness set.
-- OUT: a list of linear equations with coefficient
--      from sclmat and variables from w.Equations.
    R2 := ring w.Equations;
    X := transpose (vars(R2) | 1);
    slc := flatten entries (promote(slcmat,R2) * X);
    return slc;
)
-- matrix2slice is a helper function used in sliceCost
sliceCost = (slcmat, w) -> (
-- Returns the norm of the imaginary parts of the solutions
-- that satisfy w.Equations on the slices with coefficient
-- in the matrix slcmat.
-- IN: sclmat, a matrix of coefficients of hyperplanes;
--     w, a witness set.
-- OUT: sum of the squares of the imaginary parts of the coordinates
--      of the witness points on the hyperplanes defined by sclmat.
    slc := matrix2slice(slcmat,w);
    fsols := intersectSlice(w,slc);
    cost := sum ( coordinates(fsols_0) / imaginaryPart / (x->x^2) );
    return cost;
)
--
print "testing sliceCost ..."
R = CC[x,y];
system = {x^2 + (y+2)^2 - 1};
print "making a witness set for a circle ..."
(w, ns) = topWitnessSet(system, 1);
cost = sliceCost(w.Slice, w)
<< "cost: " << cost << endl;
--
realPartMatrix = (m) -> matrix applyTable (entries m, x->1_CC*realPart x)
--
rotationOfSlice = (t,startSlice) -> (
-- Returns a rotation of the coefficients of startSlice
-- about the angle t.
-- IN: t, an angle;
--     startSlice, a matrix with coefficients of the slice.
-- OUT: new slice, rotated from startSlice with angle t.
    c := numColumns(startSlice);
    M1 := id_(CC^c);
    M2 := mutableMatrix M1;
    M2_(0,0) = cos(t);
    M2_(0,1) = -sin(t);
    M2_(1,0) = sin(t);
    M2_(1,1) = cos(t);
    M3 := matrix M2;
    return startSlice*M3;
)
--
discretization1D = (F,a,b,n) -> (
-- Evaluates the function F over n+1 equidistant points
-- in the interval [a,b], including a and b, and returns 
-- the point where F takes the minimal value.
-- IN: F, a function in one variable;
--     a, left bound of the interval [a,b];
--     b, right bound of the interval [a,b];
--     n, number of points in the interval [a,b].
-- OUT: the point in the n equidistant points in [a,b]
--      where F takes its minimal value.
    range := for i to n list a+(b-a)*i/n;
    functionValues := for x in range list F(x);
    minValue := min(functionValues);
    minPos := position(functionValues,a->(a==minValue)); 
    return range_minPos;
)
--
searchSlice1D = method(TypicalValue => WitnessSet, 
  Options => {npoints => 20, delta => 0.1, tol => 1.0e-4})
searchSlice1D(WitnessSet) := o -> (w) -> (
-- Starting from the given one dimensional witness set,
-- applies line search to find a real slice.
-- IN: w, a witness set;
--     npoints (optional), number of points in the discretization;
--     delta (optional), 2*delta is width of search interval;
--     tol (optional), tolerance for the line search method.
-- OUT: a slice where the number of real solutions was maximal.
    startSlice := realPartMatrix(w.Slice);
    costfun := (a) -> sliceCost(rotationOfSlice(a,startSlice), w);
    amin := discretization1D (costfun, 0, 2*pi, o.npoints );
    a := amin - o.delta;
    b := amin + o.delta;
    amin = goldenSearch(costfun, a, b, o.tol);
    slcmin := rotationOfSlice(a, startSlice);
    return matrix2slice(slcmin, w)
)
--
-- computing a real slice for the twisted cubic
print "testing the twisted cubic ..."
R = CC[x,y,z];
system = {z^2-y,y*z-x,y^2-x*z};
(w, ns) = topWitnessSet(system, 1);
slc = searchSlice1D(w);
solsRR = intersectSlice(w,slc)
print "points on the real slice :"
for i to #solsRR-1 do print solsRR_i
