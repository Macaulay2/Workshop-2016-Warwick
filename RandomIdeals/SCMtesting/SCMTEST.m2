needsPackage"RandomIdeal"
needsPackage"ResidualIntersections"

--viewHelp RandomIdeal 

--randomIdeal = method(TypicalValue => Ideal)
--randomIdeal(Sequence,Matrix) := Ideal => (L,B) -> randomIdeal(toList L, B)
--randomIdeal(List,Matrix) := Ideal => (L,B) -> (     
--     -- B is a 1 x n matrix of homogeneous polynomials
--     -- L is a list of degrees
--     trim ideal(B * random(source B, (ring B)^(-L)))
--     )

RandomI=method()
RandomI(ZZ):=(len)->( --len is the length of the list of random ideals
                      local kk,S,M,m;
		      kk=ZZ/101;
		      --S=kk[a..e];
		      --M = matrix{{a^3,b^4+c^4,d^5}}; --codimension 3 ideal
		      S=kk[a..d];
		      M = matrix{{a^3,b^4+c^4,d^5,c^2+b*c}};--codimension 4 ideal
		      --S=kk[a..e];
		      --M = matrix{{a^3,b^4+c^4,d^5}}; --codimension 3 ideal
		      IM=ideal M;
		      if(codim IM==length res IM) then <<"Starting from a CM ideal of codimension "<< m
		      else <<"Starting from a non CM ideal of codimension "<< m <<endl;
		      if (isStonglyCM==true) then <<"Starting from a SCM ideal of codimension "<< m
		      else <<"Starting from a non SCM ideal of codimension "<< m <<endl;
randomListOfList={};

for i from 1 to len do(
                      n=m+1;--(is codimension of M+1)
		      randomList=apply (n,i->codim IM+1+random 2);
		      --randomList=apply (n,i-> random(m+1,m+4));
		      randomListOfList=randomListOfList|{randomList};
		      );
ListRandomIdeal=apply(randomListOfList,i->randomIdeal(i,M));
return ListRandomIdeal;
)

CMtest=method()
CMtest(List,ZZ):=(L,len)->(
ListRandomCM={};
for j from 0 to len-1 do (
                       -- if (isCM(S^1/ListRandomIdeal_(j))==true) then ListRandomCM=ListRandomCM|{ListRandomIdeal_(j)}
			--else print "not this one";
			if (codim L_(j)==length res L_(j)) then(
			    	    	    	    	    	ListRandomCM=ListRandomCM|{L_(j)};
								<< "CM:you got one!"<<endl;
								)
							    else <<"CM:not this one"<<endl;
			);
return ListRandomCM;
)
end 

restart
load "SCMTEST.m2"
l=RandomI(50);
lCM=CMtest(l,50);
"CMList"<<toString lCM;
betti res l_(2)
tally apply(l,i->betti res i)
--cm means that the codimension of the ideal is equal than the lenght of the resolution 
koszul(gens l_(0))

--one generator more than the codimension (starting with codimension 4 or 5)

length(l)

---------------------------------------------------------------------------------------
--From the Package ResidualIntersections

--=========================================================================--

--isStronglyCM = method()
--isStronglyCM(Ideal) := I -> (
--    d := dim I;
--    all(koszulDepth I,i -> i==d)
--    )

--=========================================================================--

needsPackage"Depth"
viewHelp Depth
---------------------------------------------------------------------------------------
restart

S = ZZ/101[a..e]
M = matrix{{a^3,b^4+c^4,d^5,c^2+b*c}};--codimension 4 ideal
isHomogeneous M
setRandomSeed 0
codim ideal N
tally apply(10, j->(
	N = M*random(source M, S^{5:-5});
time betti (res(coker N, FastNonminimal => true), Minimize => true)))
