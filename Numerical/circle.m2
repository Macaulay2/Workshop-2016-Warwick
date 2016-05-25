-- our first script
needsPackage("PHCpack")
R = CC[x,y];
system = {x^2 + y^2 - 1};
(w,ns) = topWitnessSet(system, 1);

-- Start System
I = w.Equations;
Q = ring I;
X = transpose matrix {gens Q | {1_CC}};
slc = (promote(w.Slice,Q) * X)_(0,0);
F = (flatten entries gens I) | {slc};

-- Target System (Real)
slcRR = matrix {{1_CC,0,0,0}};
slcRR = (promote(slcRR,Q) * X)_(0,0);
G = (flatten entries gens I) | {slcRR};

solsRR = trackPaths(G,F,w.Points)
print solsRR
