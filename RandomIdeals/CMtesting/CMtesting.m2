----------------------------------------------------------------------------
--    	 This file contains some tests that generates random ideals       --
-- and check whether they are CM and satisfying some other conditions     --
-- or not.                                                                -- 
--            Written by Bach Tran, Warwick, May 2016                     --
--                        b.tran@sms.ed.ac.uk                             --
----------------------------------------------------------------------------

needsPackage"RandomIdeal"
needsPackage"Depth"
needsPackage"ResidualIntersections"

-- This function will generate n random Monomial Ideals and check whether those are CM or not, print them out if they are CM, count the number of CM ideals, and finally return the ratio between the number of CM ideals and n.

testCM = method()
testCM(ZZ):=(n) -> (

    local kk;
    local S;
    local L; -- the list of degrees
    --local m; --this is the variable for matrix m in case we use randomIdeal() instead of randomMonomialIdeal()
    local J; -- the list of ideals
    local J2; -- temporary variable
    local i; 
    local cmideal; --the counter
    
    cmideal=0; --set counter to zero
    kk=ZZ/101;
    S=kk[a..f];

    {*L={3,3,4,6};
    m=matrix{{a^3,b^4+c^4,d^5}};
    J=apply(n, J->randomIdeal(L,m));*}

    setRandomSeed(currentTime());
    L={3,3,3,3,3,3};
    J=apply(n, J->randomMonomialIdeal(L, S)); --making a list of n random ideals
    for i from 0 to n-1 do
    (  
	J2=(S^1)/J#(i); --convert J#(i) to a module in order for the function isCM() to work
	if (isCM(J2)==true) then 
	(
	    cmideal=cmideal+1;
	    print J2;
	    );
	);
    cmideal= cmideal/n;	    
    return cmideal;    
    )

-- This function will return the Betti table for a randomly generated monomial ideal I obtained from n, the number of variables, and the list L of degrees if it is CM and 2<codim M<n.

CMBetti = method()
CMBetti (ZZ,List) := (n,L) ->(

    local I;
    local cd; --the codim variable
    local kk;
    local S;
    
    kk=ZZ/1291;
    S=kk[x_1..x_n];


    setRandomSeed(currentTime());
    I=randomMonomialIdeal(L,S);
    
    cd=codim I;
    I=S^1/I;

    if (isCM(I)==true) and (cd>2) and (cd<n) then(
    	return betti res I
	)
    else
    	return null;
    )

LicciTest = method()
LicciTest (ZZ, List) := (n, L) ->(

    local I;
    local kk;
    local S;
    local i;
        
    kk=ZZ/1291;
    S=kk[x_1..x_n];

    setRandomSeed(currentTime());
    I=randomMonomialIdeal(L,S);
    
    if (isLicci(I)==true) then(
    	return betti res I
	)
    else
    	return null;
    )

end



restart
load "CMtesting.m2"
L=for i from 1 to 6 list random(2,8)
tally apply(200,t-> LicciTest(6, L))
--installPackage"RandomIdeal"
