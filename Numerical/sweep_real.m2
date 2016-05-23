R1=CC[a,b,c,d]
M=matrix for i to 2 list for j to 3 list random(1,R)+random(0,R)
I=minors(3,M)
f=flatten entries gens I
(w,ns) = topWitnessSet(f,2)

eqn = w.Equations;
R2 = ring eqn;
startSys=join(equations(w),slice(w))
targetSys=join(equations(w),for i to 1 list sum for j to 5 list realPart(w.Slice_(i,j))*1_CC*(R2_j))
fsols = trackPaths(targetSys,startSys,w.Points)