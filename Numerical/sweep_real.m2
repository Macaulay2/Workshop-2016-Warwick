
--intersectSlice = (w,slcRR) -> (
--    startSys:=join(equations(w),slice(w));
--    targetSys := equations(w) | slcRR;
--    trackPaths(targetSys,startSys,w.Points)
--)

searchSliceTranslate = w -> (
    tol := 0.0001;
    costfun := (x) -> sliceCost(matrix {{1_CC,0,0,x}}, w);
    xmin := goldenSearch (costfun, -5.0, 5.0, tol);
    slcmin := matrix{{1_CC,0,0,xmin}};
    return matrix2slice(slcmin,w)
)

searchSliceRotation = (w) -> (
    npoints := 20;
    delta := 0.1;
    tol := 0.0001;
    startSlice := realPartMatrix(w.Slice);
    costfun := (a) -> sliceCost(rotationOfSlice(a,startSlice), w);
    amin := discretization1D (costfun, 0, 2*pi, npoints );
    a := amin - delta;
    b := amin + delta;
    amin = goldenSearch (costfun, a, b, tol);
    slcmin := rotationOfSlice(a,startSlice);
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
    cost := sum ( coordinates(fsols_0) / imaginaryPart / (x->x^2) );
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

rotationOfSlice=(t,startSlice)-> (
    c:=numColumns(startSlice);
    M1:=id_(CC^c);
    M2:=mutableMatrix M1;
    M2_(0,0)=cos(t);
    M2_(0,1)=-sin(t);
    M2_(1,0)=sin(t);
    M2_(1,1)=cos(t);
    M3:=matrix M2;
    return startSlice*M3;
    )

discretization1D=(F,a,b,n) -> (
    range:=for i to n-1 list a+(b-a)*i/n;
    functionValues := for x in range list F(x);
    minValue:=min(functionValues);
    minPos:=position(functionValues,a->(a==minValue)); 
    return range_minPos;
)

discretization=(F,n,startSlice,w) -> (
    angles:=for i to n-1 list 2*pi*i/n;
    functionValues:={};
    for i to n-1 do (
	   newSlice:=rotationOfSlice(angles#i,startSlice);
	   functionValues=append(functionValues,sliceCost(newSlice,w));
    );
    minValue:=min(functionValues);
    minPosition:=position(functionValues,a->(a==minValue)); 
    return rotationOfSlice(angles#minPosition,startSlice);
)

realPartMatrix = (m) -> matrix applyTable (entries m, x->1_CC*realPart x)

-- Example: rank 3 matrices
R=CC[a,b,c,d];
M=matrix for i to 2 list for j to 3 list random(1,R)+random(0,R);
I=minors(3,M);
f=flatten entries gens I;
(w,ns) = topWitnessSet(f,2);

-- slcmat = matrix applyTable (entries w.Slice, x->1_CC*realPart x);
slcmat = realPartMatrix(w.Slice);
R2 := ring w.Equations;
X := transpose (vars(R2) | 1);
slcRR = flatten entries (promote(slcmat,R2) * X);
fsols = intersectSlice(w,slcRR)

-- Example: Line search
myFunction = (x) -> (1-x)*sin((3*x)^3)
goldenSearch( myFunction, .4, .7, .00001)

-- Example: Circle
R = CC[x,y];
system = {x^2 + (y+2)^2 - 1};
(w,ns) = topWitnessSet(system, 1);
slc = searchSliceTranslate( w );
solsRR = intersectSlice( w, slc );

slc = searchSliceRotation( w );
solsRR = intersectSlice( w, slc );

--Example: Twisted cubic
R=CC[x,y,z]
system={z^2-y,y*z-x,y^2-x*z}
(w,ns) = topWitnessSet(system, 1);
slc=searchSliceRotation(w);
solsRR = intersectSlice(w,slc)

--Example: Rational normal curve in dimension four
R=CC[x,y,z,u];
system={z^2-y*u,y*z-x*u,x*z-u,y^2-u,x*y-z,x^2-y};
(w,ns) = topWitnessSet(system,1);
slc=searchSliceRotation(w);
solsRR = intersectSlice(w,slc)

--Example:Hypersurface in dimension three
R=CC[x,y,z];
system={x^2+y^2+z^2};
(w,ns) = topWitnessSet(system,2);
slc=searchSliceRotation(w);
solsRR = intersectSlice(w,slc)

--Testing intersectSlice function
startSlice=realPartMatrix(w.Slice);
slcmat=rotationOfSlice(0.5,startSlice);
slc=matrix2slice(slcmat,w);
sol=intersectSlice(w,slc)