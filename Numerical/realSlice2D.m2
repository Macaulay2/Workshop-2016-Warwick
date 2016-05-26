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
-- generalization to two dimensional witness sets starts here
--
rotationMatrix2D = (c,i,j,t)-> (
-- Returns a general rotation matrix in dimension c,
-- involving variables i and j and angle t.
-- IN: c, dimension of the matrix;
--     i, first variable involved in the rotation matrix;
--     j, second variable involved in the rotation matrix;
--     t, angle in the rotation matrix.
-- OUT: a rotation matrix of dimension c about angle t,
--      which involves variables i and j.
    M1 := id_(CC^c);
    M2 := mutableMatrix M1;
    M2_(i,i) = cos(t);
    M2_(i,j) = -sin(t);
    M2_(j,i) = sin(t);
    M2_(j,j) = cos(t);
    M3 := matrix M2;
    return M3
)

changeOfSlice2D = (t1,t2,startSlice)-> (
-- Applies a rotation matrix using angles t1 and t2 on startSlice.
-- IN: t1, first angle for the first hyperplane in startSlice;
--     t2, second angle for the second hyperplane in startSlice;
--     startSlice, coefficients of two hyperplanes.
-- OUT: coefficients of a rotated startSlice.
    c := numColumns(startSlice);
    rotMatrix1 := rotationMatrix2D(c,0,1,t1);
    rotMatrix2 := rotationMatrix2D(c,1,2,t2);
    row1 := startSlice^{0}*rotMatrix1;
    row2 := startSlice^{1}*rotMatrix2;
    return row1||row2;
)

discretization2D = (F,a1,b1,a2,b2,n) -> (
-- Returns the slice with the largest number of real roots.
    range1 := for i to n-1 list a1+(b1-a1)*i/n;
    range2 := for i to n-1 list a2+(b2-a2)*i/n;
    functionValues := flatten for x in range1 list for y in range2 list F(x,y);
    minValue := min(functionValues);
    posInList := position(functionValues,a->(a==minValue));
    minPos := (posInList//n,posInList%n); 
    return (range1_(minPos#0),range2_(minPos#1));
)

alternatingMinimization = (F,a1,b1,a2,b2,tol) -> (
-- Applies the method of alternating minimization.
    cOld := a1;
    dOld := a2;
    c:=a1+random(RR)*(b1-a1);
    d:=a2+random(RR)*(b2-a2);
    while abs(c - cOld) > tol and abs(d - dOld) > tol do (
	Fc:=(y)->F(c,y);
	dOld=d;
	d=goldenSearch(Fc,a2,b2,tol);
	Fd:=(x)->F(x,d);
	cOld=c;
	c=goldenSearch(Fd,a1,b1,tol);
	);
    return (c,d);
)

print "testing alternatingMinimization ..."
myF = (x,y) -> x^2 + y^2
minF = alternatingMinimization(myF,-1,1,-1,1,1.0e-4)
print "the output of alternatingMinimization :"
print minF

realSlice2D = (w) -> (
    npoints := 10;
    delta := 0.1;
    tol := 0.0001;
    startSlice := realPartMatrix(w.Slice);
    costfun := (a,b) -> sliceCost(changeOfSlice2D(a,b,startSlice), w);
    (min1,min2) := discretization2D (costfun, 0, 2*pi,0,2*pi, npoints );
    a1 := min1-delta;
    b1 := min1+delta;
    a2 := min2-delta;
    b2 := min2+delta;
    (min1,min2) = alternatingMinimization(costfun,a1,b1,a2,b2,tol);
    slcmin := changeOfSlice2D(min1,min2,startSlice);
    return matrix2slice(slcmin,w)
)

print "testing realSlice2D ..."
R = CC[x,y,z];
system = {z-x^2 - y^2};
(w, ns) = topWitnessSet(system, 2);
slc = realSlice2D(w);
solsRR = intersectSlice(w,slc)
print "points on the real slice :"
for i to #solsRR-1 do print solsRR_i
