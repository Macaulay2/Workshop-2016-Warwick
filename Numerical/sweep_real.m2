needsPackage "PHCpack"

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

realSlice1Dnew = (w) -> (
    npoints := 20;
    tol := 0.0001;
    startSlice := realPartMatrix(w.Slice);
    costfun := (a) -> sliceCost(rotationOfSlice(a,startSlice), w);
    amin = lineSearch (costfun, 0, 2*pi, tol, npoints);
    slcmin := rotationOfSlice(amin,startSlice);
    return matrix2slice(slcmin,w)
)

--search for a 2-dimensional slice
searchSlice2D=(w) -> (
    npoints := 10;
    delta := 0.1;
    tol := 0.0001;
    startSlice := realPartMatrix(w.Slice);
    costfun := (a,b) -> sliceCost(changeOfSlice2D(a,b,startSlice), w);
    (min1,min2) := discretization2D (costfun, 0, 2*pi,0,2*pi, npoints );
    a1:=min1-delta;
    b1:=min1+delta;
    a2:=min2-delta;
    b2:=min2+delta;
    (min1,min2)=alternatingMinimization(costfun,a1,b1,a2,b2,tol);
    slcmin:=changeOfSlice2D(min1,min2,startSlice);
    return matrix2slice(slcmin,w)
    )

searchSlice2D2=(w) -> (
    npoints := 5;
    delta := 0.1;
    tol := 0.0001;
    startSlice := realPartMatrix(w.Slice);
    costfun := (a,b) -> sliceCost(changeOfSlice2D(a,b,startSlice), w);
    (min1,min2)=alternatingMinimization2(costfun,0,2*pi,0,2*pi,tol, npoints);
    slcmin:=changeOfSlice2D(min1,min2,startSlice);
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

--alternating minimization
alternatingMinimization = (F,a1,b1,a2,b2,tol) -> (
    cOld:=a1;
    dOld:=a2;
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

alternatingMinimization2 = (F,a1,b1,a2,b2,tol,npoints) -> (
    cOld:=a1;
    dOld:=a2;
    c:=a1+random(RR)*(b1-a1);
    d:=a2+random(RR)*(b2-a2);
    while abs(c - cOld) > tol and abs(d - dOld) > tol do (
	Fc:=(y)->F(c,y);
	dOld=d;
	d=lineSearch(Fc,a2,b2,tol,npoints);
	Fd:=(x)->F(x,d);
	cOld=c;
	c=lineSearch(Fd,a1,b1,tol,npoints);
	);
    return (c,d);
    )

lineSearch = (F,a,b,tol,npoints) -> (
    delta := (b-a)/(2*npoints);
    xmin := discretization1D (F, a, b, npoints );
    a = max( xmin - delta, a);
    b = min( xmin + delta, b);
    xmin = goldenSearch (F, a, b, tol);
    return xmin;
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

changeOfSlice2D=(t1,t2,startSlice)-> (
    c:=numColumns(startSlice);
    rotMatrix1:=rotationMatrix2D(c,0,1,t1);
    rotMatrix2:=rotationMatrix2D(c,1,2,t2);
    row1:=startSlice^{0}*rotMatrix1;
    row2:=startSlice^{1}*rotMatrix2;
    return row1||row2;
    )

rotationMatrix2D=(c,i,j,t)-> (
    M1:=id_(CC^c);
    M2:=mutableMatrix M1;
    M2_(i,i)=cos(t);
    M2_(i,j)=-sin(t);
    M2_(j,i)=sin(t);
    M2_(j,j)=cos(t);
    M3:=matrix M2;
    return M3
    )

discretization1D=(F,a,b,n) -> (
    range:=for i to n-1 list a+(b-a)*i/n;
    functionValues := for x in range list F(x);
    minValue:=min(functionValues);
    minPos:=position(functionValues,a->(a==minValue)); 
    return range_minPos;
)

discretization2D=(F,a1,b1,a2,b2,n) -> (
    range1:=for i to n-1 list a1+(b1-a1)*i/n;
    range2:=for i to n-1 list a2+(b2-a2)*i/n;
    functionValues := flatten for x in range1 list for y in range2 list F(x,y);
    minValue:=min(functionValues);
    posInList:=position(functionValues,a->(a==minValue));
    minPos:=(posInList//n,posInList%n); 
    return (range1_(minPos#0),range2_(minPos#1));
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

sphericalCoordinates = (angles) -> (
    for i to #angles list (
        xi := product for j to i-1 list sin(angles_j);
        if i<#angles then xi = xi*cos(angles_i);
        xi
    )
)

orthUnitVect1D = (angles1) -> (
    x1 := sphericalCoordinates(angles1);
    x2 := matrix {{1},{0}};
    angles1 = angles1 / (x-> -(pi/2-x));
    R1 := rotationMatrix2D(2,0,1,angles1_0);
    x1 = transpose matrix {x1};
    Rx2 := R1*x2;
    X := x1|Rx2;
    return X;
)

orthUnitVect = (angles1,angles2) -> (
    x1 := {cos(angles1_0)*sin(angles1_1), sin(angles1_0)*sin(angles1_1), cos(angles1_1)};
    --x1 := sphericalCoordinates(angles1);
    x2 := sphericalCoordinates(angles2);
    angles1 = angles1 / (x-> -(pi/2-x));
    angles2 = angles1 / (x-> -(pi/2-x));
    R1 := rotationMatrix2D(3,0,1,angles1_0);
    R2 := rotationMatrix2D(3,1,2,angles1_1);
    x1 = transpose matrix {x1};
    x2 = transpose matrix {append(x2, 0)};
    Rx2 := R1*R2*x2;
    X := x1|Rx2;
    return X;
)

R = orthUnitVect( {1.23,2.37}, {-.42} );
r = (transpose R) * R;
print r;

end -----------------------------------------------------------------

-- Example: rank 3 matrices
R=CC[x,y,z,u];
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

slc = realSlice1Dnew( w );
solsRR = intersectSlice( w, slc );

--Example: Twisted cubic
R=CC[x,y,z]
system={z^2-y,y*z-x,y^2-x*z}
(w,ns) = topWitnessSet(system, 1);
slc=realSlice1Dnew(w);
solsRR = intersectSlice(w,slc)

--Example: Rational normal curve in dimension four
R=CC[x,y,z,u];
system={z^2-y*u,y*z-x*u,x*z-u,y^2-u,x*y-z,x^2-y};
(w,ns) = topWitnessSet(system,1);
slc=realSlice1Dnew(w);
solsRR = intersectSlice(w,slc)

--Example:Hypersurface in dimension three
load "sweep_real.m2"
R=CC[x,y,z];
system={x^2+y^2-z};
(w,ns) = topWitnessSet(system,2);
slc=searchSlice2D(w);
solsRR = intersectSlice(w,slc)

--Testing intersectSlice function
startSlice=realPartMatrix(w.Slice);
slcmat=rotationOfSlice(0.5,startSlice);
slc=matrix2slice(slcmat,w);
sol=intersectSlice(w,slc)

--Testing AM
myFunction=(x,y)->sin(x)*sin(y)
