-- modeled after randomCanonicalModelOfPlaneCurve

needsPackage "RandomPlaneCurves"
needsPackage "RandomCanonicalCurves"
g = 9
p = 12347
d = g+2-g//3
R = ZZ/p[t_0..t_(g-1)];
setRandomSeed "37862873"

foo' = x' -> (
     x := x';
     y := local x;
     -- x = y;
     foo := 1:null;
     registerFinalizer(foo,"foo");
     S := (coefficientRing R)[x_0..x_2];
     delta:=binomial(d-1,2)-g;
     J:=(random nodalPlaneCurve)(d,delta,S);
     KC:=(gens intersect(saturate(ideal jacobian J +J),(ideal vars S)^(d-3)))_{0..(g-1)};
     SJ:=S/J;
     phi:=map(SJ,R,substitute(KC,SJ));
     I:=ideal mingens ker phi;
     minimalBetti I;
     );

foo = () -> (
     x := local x;
     foo' x)

for i from 1 to 32 do (
     foo();
     << "." << flush;
     )
<< "..." << flush
collectGarbage()
collectGarbage()
collectGarbage()
engineMemory = value Core#"private dictionary"#"engineMemory"
print engineMemory()
