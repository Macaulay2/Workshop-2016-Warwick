
intersectSlice = (w,slcRR) -> (
    eqn := w.Equations;
    R2 := ring eqn;
    X := transpose (vars(R2) | 1);
    startSys:=join(equations(w),slice(w));
    --targetSys:=join(equations(w),for i to 1 list sum for j to 5 list realPart(w.Slice_(i,j))*1_CC*(R2_j))
    targetSys := equations(w) | slcRR;
    trackPaths(targetSys,startSys,w.Points)
)

myFunction = (x) -> (1-x)*sin((3*x)^3)

gradientDescent = (F) -> (
    minvalue = ???
)

-- Example
R=CC[a,b,c,d];
M=matrix for i to 2 list for j to 3 list random(1,R)+random(0,R);
I=minors(3,M);
f=flatten entries gens I;
(w,ns) = topWitnessSet(f,2);
slcmat = matrix applyTable (entries w.Slice, x->1_CC*realPart x);
slcRR = flatten entries (promote(slcmat,R2) * X);
fsols = intersectSlice(w,slcRR)
