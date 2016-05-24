needsPackage"RandomIdeal"
<<<<<<< HEAD
--loadPackage"Depth"
=======
needsPackage"Depth"
>>>>>>> 470bc933c9dfbe19d2ea5ae05d3b613d0d0ccc93

--viewHelp RandomIdeal 

--randomIdeal = method(TypicalValue => Ideal)
--randomIdeal(Sequence,Matrix) := Ideal => (L,B) -> randomIdeal(toList L, B)
--randomIdeal(List,Matrix) := Ideal => (L,B) -> (     
--     -- B is a 1 x n matrix of homogeneous polynomials
--     -- L is a list of degrees
--     trim ideal(B * random(source B, (ring B)^(-L)))
--     )

RandomI=method()
<<<<<<< HEAD
RandomI(ZZ):=(len)->(
    local kk,S,m;
kk=ZZ/101;
S=kk[a..g];

--codim ideal(a^3,b^4+c^4,d^5)
--codim ideal(m)

m = matrix{{a^3,b^4+c^4,d^5+g^3}};--codimension 2 or 3?
randomListOfList={};

 --n=codim ideal(m)+1
-- randomList=apply (n,i->4+random 2)-
--randomListOfList=randomListOfList|{randomList}
--for i from 0 to length ListRandomIdeal do ListRandomIdeal=apply(randomListOfList,i->randomIdeal(i,m));

--length ListRandomIdeal
--length res ListRandomIdeal_(0) 


for i from 0 to len-1 do(
                      n=codim ideal(m)+1;--(is codimension of m +1)
		      randomList=apply (n,i->4+random 2);
		      randomListOfList=randomListOfList|{randomList};
                      );
ListRandomIdeal=apply(randomListOfList,i->randomIdeal(i,m));


listRandomCm=0;
for i from 0 to length(ListRandomIdeal)-1 do 
(if length res (ListRandomIdeal_(i))==codim (ListRandomIdeal_(i)) then listRandomCm=listRandomCm+1);
    
  --  i=15;
-- length res (ListRandomIdeal_(i))==codim (ListRandomIdeal_(i))   
-- (if length res (ListRandomIdeal_(i))==codim (ListRandomIdeal_(i)) then listRandomCm=listRandomCm+1)
-- listRandomCm
  --  isCM(S^1/(ListRandomIdeal_(i)))==true 

--listRandomIdeal

--return ListRandomIdeal;
--return listRandomCm;
return listRandomCm;


--i=5
--length res (ListRandomIdeal_(i))==codim (ListRandomIdeal_(i))

-- isCM(S^1/(ListRandomIdeal_(i)))==true


=======
RandomI(ZZ):=(len)->( --len is the length of the list of random ideals
                      local kk,S,M,m;
		      kk=ZZ/101;
		      S=kk[a..g];
		      --S=kk[a..e];
		      --m = matrix{{a^3,b^4+c^4,d^5); --codimension 3 ideal
		      M = matrix{{a^3,b^4+c^4,d^5,e^2+b*g}};--codimension 4 ideal
		      m=codim(ideal M);
		      print m;
randomListOfList={};

for i from 1 to len do(
                      n=m+1;--(is codimension of M+1)
		      --randomList=apply (n,i->4+random 2);
		      randomList=apply (n,i-> random(m+1,m+4));
		      randomListOfList=randomListOfList|{randomList};
		      );
ListRandomIdeal=apply(randomListOfList,i->randomIdeal(i,M));
ListRandomCM={};
for j from 0 to len-1 do (
                       -- if (isCM(S^1/ListRandomIdeal_(j))==true) then ListRandomCM=ListRandomCM|{ListRandomIdeal_(j)}
			--else print "not this one";
			if (codim ListRandomIdeal_(j)==length res ListRandomIdeal_(j)) then
			(ListRandomCM=ListRandomCM|{ListRandomIdeal_(j)};
			    print "you got one!");
			);
return ListRandomCM;
>>>>>>> 470bc933c9dfbe19d2ea5ae05d3b613d0d0ccc93
)		 
end 

restart
load "SCMexamples.m2"
<<<<<<< HEAD
RandomI(10)
randomListOfList
isCM(ListRandomIdeal_(0))
l=RandomI(5);

=======
l=RandomI(100);
length l
>>>>>>> 470bc933c9dfbe19d2ea5ae05d3b613d0d0ccc93
betti res l_(2)
tally apply(l,i->betti res i)
--cm means that the codimension of the ideal is equal than the lenght of the resolution 
koszul(gens l_(0))

--one generator more than the codimension (starting with codimension 4 or 5)

length(l)

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