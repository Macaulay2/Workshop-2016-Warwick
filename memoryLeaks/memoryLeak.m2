--23.05.2016
-- we want to explore possible memory leaks in the "res(, FastNonminimal)" command
restart
loadPackage"RandomCanonicalCurves"

--initialization:
g=9;
p=12347;
numEx=100;
T=ZZ/p[t_0..t_(g-1)]
--
i=0;
L={};
while  (i < numEx) do (
    IC=(random canonicalCurve)(g,T);
    --L=L|{betti(res(IC,FastNonminimal=>true),Minimize=>true)};
    betti(res(IC,FastNonminimal=>true),Minimize=>true);
    IC=symbol IC;
    print(i);
    i=i+1;
    )
    

