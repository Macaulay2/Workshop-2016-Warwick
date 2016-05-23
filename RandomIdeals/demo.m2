--creating a method
--Ctrl+X Ctrl+F creates a file
--Ctrl+X Ctrl+S saves a file
needsPackage"RandomIdeal"
needsPackage"Depth"

testCM = method()
testCM(ZZ):=(n) -> (
    local kk;
    local S;
    local L;
    local m;
    local J;
    local J2;
    local i;
    local cmideal;
    
    cmideal=0;
    kk=ZZ/101;
    S=kk[a..e];
    L={3,3,4,6};
    m=matrix{{a^3,b^4+c^4,d^5}};
    J=apply(n, J->randomIdeal(L,m));
    for i from 0 to n-1 do
    (  
	J2=(S^1)/J#(i);
	if isCM(J2)==true then 
	(
	    cmideal=cmideal+1;
	    print J2;
	    );
	);	    
    return cmideal;    
    )
end

restart
load "demo.m2"
--installPackage"RandomIdeal"
testCM(10)


