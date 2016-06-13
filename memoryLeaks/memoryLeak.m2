--23.05.2016
-- we want to explore possible memory leaks in the "res(, FastNonminimal)" command

loadPackage"RandomCanonicalCurves"

leak1 = () -> (
    setRandomSeed "37862873";
    g := 9;
    p := 12347;
    numEx := 100;
    T := ZZ/p[t_0..t_(g-1)];
    i := 0;
    L := {};
    while  (i < numEx) do (
        IC := (random canonicalCurve)(g,T);
        --L=L|{betti(res(IC,FastNonminimal=>true),Minimize=>true)};
        betti(res(IC,FastNonminimal=>true),Minimize=>true);
        IC = symbol IC;
        print(i);
        i=i+1;
        )
    )

leak2 = () -> (
    setRandomSeed "37862873";
    g := 9;
    p := 12347;
    numEx := 400;
    T := ZZ/p[t_0..t_(g-1)];
    i := 0;
    I1 := null;
    for i from 1 to 50 do elapsedTime I1 = (random canonicalCurve)(g,T);
    while  (i < numEx) do (
        IC := ideal(I1_*);
        betti(res(IC,FastNonminimal=>true),Minimize=>true);
        IC=symbol IC;
        print(i);
        i=i+1;
        )
    )

doOne = (g,T) -> (
    IC := (random canonicalCurve)(g,T);
    res(IC,FastNonminimal=>true);
    )
leak3 = () -> (
    setRandomSeed "37862873";
    g := 9;
    p := 12347;
    numEx := 100;
    T := ZZ/p[t_0..t_(g-1)];
    i := 0;
    L := {};
    while  (i < numEx) do (
        doOne(g,T);
        print(i);
        i=i+1;
        )
    )

leak4 = () -> (
    setRandomSeed "37862873";
    g := 9;
    p := 12347;
    numEx := 100;
    T := ZZ/p[t_0..t_(g-1)];
    i := 0;
    L := {};
    while  (i < numEx) do (
        IC := (random canonicalCurve)(g,T);
        --L=L|{betti(res(IC,FastNonminimal=>true),Minimize=>true)};
        --gbTrace=1;
        minimalBetti IC;
        gbTrace=0;
        IC = symbol IC;
        print(i);
        i=i+1;
        )
    )

leak5 = () -> (
    setRandomSeed "37862873";
    g := 9;
    p := 12347;
    numEx := 100;
    T := ZZ/p[t_0..t_(g-1)];
    i := 0;
    L := {};
    while  (i < numEx) do (
        IC := (random canonicalCurve)(g,T);
        res(IC, FastNonminimal=>true);
        IC = symbol IC;
        print(i);
        i=i+1;
        )
    )

leak6 = () -> (
    setRandomSeed "37862873";
    g := 9;
    p := 12347;
    numEx := 1000;
    T := ZZ/p[t_0..t_(g-1)];
    i := 0;
    I1 := null;
    for i from 1 to 1 do elapsedTime I1 = (random canonicalCurve)(g,T);
    --gbTrace=3;
    while  (i < numEx) do (
        IC := ideal(I1_*);
        minimalBetti IC;
        IC=symbol IC;
        print(i);
        i=i+1;
        )
    )

leak7 = () -> (
    setRandomSeed "37862873";
    g := 9;
    p := 12347;
    numEx := 100;
    T := ZZ/p[t_0..t_(g-1)];
    i := 0;
    I1 := null;
    for i from 1 to 1 do elapsedTime I1 = (random canonicalCurve)(g,T);
    while  (i < numEx) do (
        IC := ideal(I1_*);
        I2 := (random canonicalCurve)(g,T);
        --gbTrace=3;
        minimalBetti IC;
        gbTrace=0;
        IC=symbol IC;
        print(i);
        i=i+1;
        )
    )

leak8 = () -> (
    setRandomSeed "37862873";
    g := 9;
    p := 12347;
    numEx := 1000;
    T := ZZ/p[t_0..t_(g-1)];
    i := 0;
    while  (i < numEx) do (
        IC := randomPureBinomialIdeal({4,4,4,4},T);
        --gbTrace=3;
        minimalBetti IC;
        gbTrace=0;
        IC=symbol IC;
        print(i);
        i=i+1;
        )
    )
end
restart
needsPackage "RandomIdeal"
load "~/warwick/memoryLeaks/memoryLeak.m2"
-- notes are from 12 June 2016
leak8() -- (313.5 - 79.3)/100 MB = 234 KB per iteration, (1000 iterations)
leak7() -- (110.5 - 79.3)/100 MB = 312 KB per iteration.  Basically ALL resolutions are being collected.
leak6() -- (333.1 - 79.3)/1000 MB = 254 KB per iteration.  Basically ALL resolutions are being collected.
leak4() -- (347.8 - 79.3)/100 MB = 2.68 MB per iteration.  Collects about 80/100 of the resolutions.

leak3() -- (647.2 - 79.3)/100 MB = 5.68 MB per iteration.  Collects 56/100.
leak1() -- (630.5 - 79.3)/100 MB = 5.5 MB per iteration. Collects 57/100.
leak2() -- (169.3 - 79.3)/400 MB = 225 KB per iteration. Collects 400/400.
leak5() -- (584.3 - 79.3)/100 MB = 5.05 MB per iteration. Collects 61/100

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

while  (i < numEx) do (
    IC=(random canonicalCurve)(g,T);
    --L=L|{betti(res(IC,FastNonminimal=>true),Minimize=>true)};
    << betti(res(IC,FastNonminimal=>true),Minimize=>true) << endl;
    IC=symbol IC;
    print(i);
    i=i+1;
    )

while  (i < numEx) do (
    IC=(random canonicalCurve)(g,T);
    --L=L|{betti(res(IC,FastNonminimal=>true),Minimize=>true)};
    << betti(res(IC)) << endl;
    IC=symbol IC;
    print(i);
    i=i+1;
    )

I1 = (random canonicalCurve)(g,T);
gbTrace=0
while  (i < numEx) do (
    IC=ideal(I1_*);
    --L=L|{betti(res(IC,FastNonminimal=>true),Minimize=>true)};
    << betti(res(IC,FastNonminimal=>true),Minimize=>true) << endl;
    IC=symbol IC;
    print(i);
    i=i+1;
    )

while  (i < numEx) do (
    IC=(random canonicalCurve)(g,T);
    IC=symbol IC;
    print(i);
    i=i+1;
    )

while  (i < numEx) do (
    IC=(random canonicalCurve)(g,T);
    --L=L|{betti(res(IC,FastNonminimal=>true),Minimize=>true)};
    res(IC,FastNonminimal=>true);
    IC=symbol IC;
    collectGarbage();
    print(i);
    i=i+1;
    )
    

