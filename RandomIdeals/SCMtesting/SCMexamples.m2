needsPackage"RandomIdeal"

--viewHelp RandomIdeal 

--kk=ZZ/101;
--S=kk[a..e];
--L={3,3,4,6};
--m = matrix{{a^3,b^4+c^4,d^5}};
--I=randomIdeal(L,m)

f:={
    n=random (1,20);
    randomList=apply (n,i->random 100);
    }
randomListOfList=apply (10,f);
end 

restart
load "SCMexamples.m2"
lista
