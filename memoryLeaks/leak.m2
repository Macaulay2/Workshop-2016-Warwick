engineMemory = value Core#"private dictionary"#"engineMemory"
needsPackage "RandomCanonicalCurves"
ps = () -> run ( "ps u " | toString processID () )
leak = c -> (
    setRandomSeed "37862873";
    g := 9;
    p := 12347;
    numEx := 40;
    T := ZZ/p[t_0..t_(g-1)];
    for i from 1 to 100 do (
        IC := (random canonicalCurve)(g,T);
        minimalBetti IC;
	-- registerFinalizer (IC.cache.quotient,"--");
        if c then IC.cache.quotient = null;
        << "." << flush;);
    collectGarbage();
    print engineMemory();
    )
ps()
leak true
ps()
leak false
ps()
