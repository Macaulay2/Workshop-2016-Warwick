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

--codim ideal(a^3,b^4+c^4,d^5)
--codim ideal(m)

m = matrix{{a^3,b^4+c^4,d^5}};--codimension 2 or 3?
randomListOfList={};

for i from 1 to 10 do(
                      n=codim ideal(m)+1;--4;--+random (1,len);(is codimension of m +1)
		      randomList=apply (n,i->4+random 2);
		      randomListOfList=randomListOfList|{randomList};
--		      );
ListRandomIdeal=apply(randomListOfList,i->randomIdeal(i,m));
return ListRandomIdeal;
)		 
end 

restart
load "SCMexamples.m2"
RandomI(5)
randomListOfList
ListRandomIdeal
l=RandomI(5);
betti res l_(2)
tally apply(l,i->betti res i)
--cm means that the codimension of the ideal is  equal than the lenght of the resolution 
koszul(gens l_(0))
random 2

--one generator more than the codimension (starting with codimension 4 or 5)

---------------------------------------------------------------------------------------
--From the Package Depth

--=========================================================================--

--isCM = method()
--isCM(Ring) := Boolean => (A) -> (
--     dim(A) == depth(A) -- note we should *not* switch to modules - see depth(Ideal,QuotientRing)
--     )

-----------------------------------------------------------------------------

--isCM(Module) := Boolean => (M) -> (
--     dim(M) == depth(M)
--     )

--=========================================================================--

needsPackage"Depth"
viewHelp Depth
---------------------------------------------------------------------------------------