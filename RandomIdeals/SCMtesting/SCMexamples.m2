needsPackage"RandomIdeal"

--viewHelp RandomIdeal 

--randomIdeal = method(TypicalValue => Ideal)
--randomIdeal(Sequence,Matrix) := Ideal => (L,B) -> randomIdeal(toList L, B)
--randomIdeal(List,Matrix) := Ideal => (L,B) -> (     
--     -- B is a 1 x n matrix of homogeneous polynomials
--     -- L is a list of degrees
--     trim ideal(B * random(source B, (ring B)^(-L)))
--     )

RandomI=method()
RandomI(ZZ):=(len)->(
    local kk,S,m;
kk=ZZ/101;
S=kk[a..e];
m = matrix{{a^3,b^4+c^4,d^5}};
randomListOfList={};
<<<<<<< HEAD
for i from 1 to 3 do(
                      n=random (1,5);
		      randomList=apply (n,i->random 5);
=======
for i from 1 to 10 do(
                      n=random (1,len);
		      randomList=apply (n,i->random 20);
>>>>>>> 24a0179d72c3bd42dc6c9fc834d59b75d982fe1e
		      randomListOfList=randomListOfList|{randomList};
		      );
ListRandomIdeal=apply(randomListOfList,i->randomIdeal(i,m));
return ListRandomIdeal;
)		 
end 

restart
load "SCMexamples.m2"
randomListOfList
ListRandomIdeal
RandomI(5)
