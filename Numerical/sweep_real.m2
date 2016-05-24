
--intersectSlice = (w,slcRR) -> (
--    startSys:=join(equations(w),slice(w));
--    targetSys := equations(w) | slcRR;
--    trackPaths(targetSys,startSys,w.Points)
--)

myFunction = (x) -> (1-x)*sin((3*x)^3)

goldenSearch = (F,a,b,tol) -> (
    gr := 1.6180339887498948;
    c := b - gr * (b - a);
    d := a + gr * (b - a);
    while abs(c - d) > tol do (
        print c;
        Fc := F(c);
        Fd := F(d);
        if Fc < Fd then (
            b = d;)
        else (
            a = c;);
        c = b - gr * (b - a);
        d = a + gr * (b - a);
    );
    return (b + a) / 2
)

-- Example
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
