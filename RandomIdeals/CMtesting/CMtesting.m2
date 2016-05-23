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
    L={3,4,5,6};
    m=matrix{{a*b,b*c^2,c^2*a,d^2}};
    J=apply(n, J->randomIdeal(L,m));
    for i from 0 to n-1 do
    (  
	J2=(S^1)/J#(i);
    	--print J2;
	--print isCM(J2);
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
load "CMtesting.m2"
--installPackage"RandomIdeal"
testCM(10)


