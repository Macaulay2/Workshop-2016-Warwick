needsPackage"RandomIdeal"

--viewHelp RandomIdeal 

--kk=ZZ/101;
--S=kk[a..e];
--L={3,3,4,6};
--m = matrix{{a^3,b^4+c^4,d^5}};
--I=randomIdeal(L,m)

randomListOfList={};
for i from 1 to 10 do(
                      n=random (1,20);
		      randomList=apply (n,i->random 100);
		      randomListOfList=randomListOfList|{randomList};
		      );

end 

restart
load "SCMexamples.m2"
randomListOfList
