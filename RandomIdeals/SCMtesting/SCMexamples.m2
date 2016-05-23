needsPackage"RandomIdeal"

--viewHelp RandomIdeal 

kk=ZZ/101;
S=kk[a..e];
m = matrix{{a^3,b^4+c^4,d^5}};
randomListOfList={};
for i from 1 to 3 do(
                      n=random (1,5);
		      randomList=apply (n,i->random 5);
		      randomListOfList=randomListOfList|{randomList};
		      );
ListRandomIdeal=apply(randomListOfList,i->randomIdeal(i,m));		 

end 

restart
load "SCMexamples.m2"
randomListOfList
ListRandomIdeal