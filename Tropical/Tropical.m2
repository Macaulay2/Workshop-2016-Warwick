--TODO: min/max
--TODO: implement (unstable) intersection
--TODO: implement different strategies
--TODO: implement valuation fields
--TODO: check what happens for empty fan
--TODO: quotient out by (1,1,...,1)
newPackage(
    	"Tropical",
	Version => "0.1",
	Date => "May 2016",
	Authors => {
   		{Name => "Carlos Amendola", Email => "", HomePage=>""},
	    	{Name => "Kathlen Kohn", Email => "", HomePage=>""},
  		{Name => "Sara Lamboglia", Email => "", HomePage=>""},
	    	{Name => "Diane Maclagan", Email => "", HomePage=>""},
   		{Name => "Benjamin Smith", Email => "", HomePage=>""},
   		{Name => "Jeff Sommars", Email => "", HomePage=>""},
    		{Name => "Paolo Tripoli", Email => "", HomePage=>""}
		},
	Headline => "Interface to Anders Jensen's Gfan software",
	Configuration => {
		"path" => "",
		"fig2devpath" => "",
		"keepfiles" => false,
		"cachePolyhedralOutput" => true,
		"tropicalMax" => false
	},
        PackageExports => {"gfanInterface2","EliminationMatrices","Binomials"},
	DebuggingMode => true
)

export {
  "TropicalCycle",
  "tropicalCycle",
  "isBalanced",
  "tropicalPrevariety",
  "ComputeMultiplicities",
  "Prime",
  "stableIntersection",
  "tropicalVariety",
  "isTropicalBasis",
  "multiplicities"
}






------------------------------------------------------------------------------
-- CODE
------------------------------------------------------------------------------

--Setting up the data type TropicalCycle

TropicalCycle = new Type of MutableHashTable
TropicalCycle.synonym = "tropical cycle"
TropicalCycle.GlobalAssignHook = globalAssignFunction
TropicalCycle.GlobalReleaseHook = globalReleaseFunction


--basic operations on a tropical cycle

tropicalCycle = method(TypicalValue => TropicalCycle)

tropicalCycle (Fan, List) := (F,mult)->(
    if #maxCones(F) != #mult then error("The multiplicity list has the wrong length");
    T := new TropicalCycle;
    T#"Multiplicities" = mult;
    T#"Fan" = F;
    return T
)    





--functions to switch to min-convention

minmaxSwitch = method ()

minmaxSwitch (Fan) := F -> fanFromGfan({- rays F, linSpace F, maxCones F ,dim F,isPure F,isSimplicial F,fVector F});

minmaxSwitch (TropicalCycle) := T -> tropicalCycle(minmaxSwitch fan T, multiplicities T);







isBalanced = method(TypicalValue => Boolean)

isBalanced (TropicalCycle):= T->(
-- parse object into a polymake script, run polymake and get result back from the same file (which got overwritten by polymake)
	filename := temporaryFileName();
	filename << "use application 'tropical';" << endl << "my $c = "|convertToPolymake(T) << endl << "print is_balanced($c);" << endl << "use strict;" << endl << "my $filename = '" << filename << "';" << endl << "open(my $fh, '>', $filename);" << endl << "print $fh is_balanced($c);" << endl << "close $fh;" << endl << close;
	runstring := "polymake "|filename;
	run runstring;
	result := get filename;
	if (result=="1") then return true;
	return false;
)







--Computing a tropical prevariety

tropicalPrevariety = method(TypicalValue => Fan,  Options => {
--in the future, more strategies not dependent on "gfan" will be available
	Strategy=> "gfan"
	})

 
tropicalPrevariety (List) := o -> L -> (gfanopt:=(new OptionTable) ++ {"t" => false,"tplane" => false,"symmetryPrinting" => false,"symmetryExploit" => false,"restrict" => false,"stable" => false};
--using strategy gfan
    if (o.Strategy=="gfan") then (
    	F:= gfanTropicalIntersection(L, gfanopt); 
--gives only the fan and not the fan plus multiplicities which are wrongly computed in gfan
	if (Tropical#Options#Configuration#"tropicalMax" == true) then return F_0 else return minmaxSwitch (F_0))
    else error "options not valid"
)

--Computing a tropical variety


computeCones=(R,M,L)->(
      ConesOfVariety:={};
      i:=0;
      ConeOfVariety:={};
     --this i is going through the maximal cones
      while(i<#M) do(
	  ConeOfVariety={};
	  j:=0;
     --this j is going through the rays inside the maximal cone you are in
	  while(j<#M_i) do(
	      --creates a list of rays
	      ConeOfVariety=append(ConeOfVariety, R_(M_i_j));
	  j=j+1);
      -- creates a matrix whose rows are the rays of the cone
     ConeOfVariety= ConeOfVariety|L;
     -- each cone has to contain also the lineality space since we are not quotienting by it
      ConeOfVariety = matrix ConeOfVariety ;
      --add the cone to the list of cones
      	  ConesOfVariety=append(ConesOfVariety,ConeOfVariety);
	  i=i+1;
	);
    ConesOfVariety
    )

--input:rays,maximal cones and 
--lineality space so you put maximalCones and rays so the 
--inputs are two lists
--output:list of matrices
-- note that ConesOfVariety is a local variable also in findMultiplicities
findMultiplicity=(M,I)->(
--compute vector w in relative interior in order to get the initial ideal in_w(I) with w in the maximal cone M
    n:=numRows M - 1;
    w:=flatten entries(sum(0..n, j->M^{j}));
--weight the ring according to this w , we are using leadTerm that is why we consider -sum of rays
    R:=newRing(ring I, MonomialOrder=>{Weights=>w},Global=>false);
    J:=sub(I,R);
    K:=ideal(leadTerm(1,J));
    InitialIdeal:= saturate(sub(K,ring I),ideal product gens ring I);
--this is the the basis of the lattice associated to the toric ideal we are going to compute
    Basis:= (maxCol( generators kernel M))_0;
    --this is where we use  Binomials package
    toricIdeal:=saturate(latticeBasisIdeal(ring InitialIdeal,Basis),ideal product gens ring I);
    m:=degree(InitialIdeal)/degree (toricIdeal);
--return multiplicity m as integer, since it lives currently in QQ
--if m is an integer (as it should be), then the following command parses it to ZZ
--otherwise, an errow will be returned "rational number is not an integer"
    lift(m,ZZ) 
    )    

--input Matrix whose rows are the generators of the cone and the ideal of the variety
--output a list of one number that is the multiplicity
--maths behind it look at exercise 34 chapter 3 Tropical book and [Stu96]
--(Grobner basis and Convex Polytopes ) 
findMultiplicities=(I,T)->(
	ConesOfVariety:={};
	M:={};
	ConesOfVariety=computeCones(entries transpose rays T,maxCones T, entries transpose linSpace T);
      --creates a list with matrices that correspond to the maximal cones
	i:=0;
	while(i<#ConesOfVariety)do(
       --for each cone computes the multiplicity and adds this to a list of multiplicities
	    M=append(M,findMultiplicity(ConesOfVariety_i,I));
	    i=i+1;
	    );
	--call the function tropicalCycle to create a new tropical variety with multiplicities
	M
)
--input: the ideal of the variety and the tropical variety computed by gfanbruteforce
--output: list with the multiplicities to add to the tropicalCycle 


--TODO: check multiplicity computation in the case that the variety has no rays but only lineality space
--(see example for ideal K in tropicalVariety) 
tropicalVariety = method(TypicalValue => TropicalCycle,  Options => {
	ComputeMultiplicities => true,
	Prime => true
	})
tropicalVariety (Ideal,Boolean) := opt -> (I,IsHomogIdeal)  -> (
    	if IsHomogIdeal==false then print "0"
--Once tropicalVariety(I) is finished, send there to homogenize
	else
		local F;
		--If ideal is prime, use following algorithm for speed
	       (if (opt.Prime== true)
		then (
		    F= gfanTropicalTraverse( gfanTropicalStartingCone I);
	            if (Tropical#Options#Configuration#"tropicalMax" == true) then return tropicalCycle(F) else return minmaxSwitch tropicalCycle (F))
		else
		--If ideal not prime, use gfanTropicalBruteForce to ensure disconnected parts are not missed at expense of multiplicities
		    (if opt.ComputeMultiplicities==false 
		     then (F= gfanTropicalBruteForce gfanBuchberger I;
			   mult := {};
			   i:=0;
			   
			   while(i<#maxCones (F_0))do(
			       mult=append(mult,{});
			       i=i+1);
			   --note that the output of gfanTropicalBruteForce is a fan and an empty list of multiplicities 
			   if (Tropical#Options#Configuration#"tropicalMax" == true) then return  tropicalCycle(F_0,mult) else return minmaxSwitch tropicalCycle(F_0,mult)
	    	    	   )
		     else (F= gfanTropicalBruteForce gfanBuchberger I;
			 if (Tropical#Options#Configuration#"tropicalMax" == true) then return tropicalCycle(F_0,findMultiplicities(I,F_0)) else return minmaxSwitch tropicalCycle(F_0,findMultiplicities(I,F_0))
			 )  )))


--Main function to call for tropicalVariety.  Makes no assumption on ideal
--WARNING:  There is a bug here in the way the new polynomial ring is dealt with.
-- it seems to work if we've define the new ring globally, but not inside the package.
tropicalVariety (Ideal) := o -> (I) ->(
    if isHomogeneous(I) then return(tropicalVariety(I,true,o))
    else (
	--First homogenize
    	R:=ring I;
--	KK:=coefficientRing R;
    	AA:= symbol AA;
    	S:= first flattenRing( R[getSymbol "AA", Join=>false]);
	J:=substitute(I,S);
	J=homogenize(J,S_0);
	J=saturate(J,S_0);
	--Then compute tropical variety of homogenized ideal calling
        --the other function
--I'm worried about the use S here - this might be broken.
	--use S;
	T:=tropicalVariety(J,true);
	TProperties := {dehomogenise(rays T),
			dehomogenise(linealitySpace T),
			maxCones T,
			dim(T)-1,
			isPure T,
			isSimplicial T,
			fVector T};
	UFan:=fanFromGfan(TProperties);
	U:= tropicalCycle(UFan,multiplicities(T));
	return(U);
	)
)

{* Old tropicalVariety code
    	--Then remove lineality space
	--The following lines will need to be changed once the
	--Polyhedra package has been updated (hopefully summer 2016)
    	Trays:=entries transpose rays(T);
	--Add a multiple of the all-ones vector to each ray to make the first
	-- coordinate zero, drop the first coordinate, and divide by the 
	-- gcd.
	newTrays := apply(Trays, v->(
	    newv := apply(#v-1,i->(v#(i+1)-v#0));
	    gcdv := gcd(newv);
	    newv = newv/gcdv;
	    newv = apply(newv,i->(lift(i,ZZ)))
       	    ));
    	--The next line in particular should be replaced by a constructor.
    	(fan(T))#cache#"Rays" = newTrays;
	(fan(T))#cache#"computedDimension" = dim(T)-1;
	(fan(T))#cache#"ambientDimension" = (fan(T))#cache#"ambientDimension"-1;
	--For the next one, if we want to remember the lineality space
	--we should instead quotient by the all ones vector
	--remove(T,"LinealitySpace");
	--remove(T,"OrthLinealitySpace");
	--remove(T,"LinealityDim");
	--return(T);
*}

dehomogenise=(M) -> (
	vectorList:= entries transpose M;
	dehomog:= apply(vectorList, L->(
		newL := apply(#L-1,i->(L#(i+1)-L#0));
		gcdL := gcd(newL);
		newL = newL/gcdL;
		newL = apply(newL,i->(lift(i,ZZ)))
	));
	transpose matrix dehomog
)

--Check if a list of polynomials is a tropical basis for the ideal they generate

--Current Strategy is using 'gfan'
isTropicalBasis = method(TypicalValue => Boolean,  Options => {
	Strategy=> "gfan"
	})

isTropicalBasis (List) := o -> L -> (
	if (o.Strategy=="gfan") then (
	    gfanopt:=(new OptionTable) ++ {"t" => true,"tplane" => false,"symmetryPrinting" => false,"symmetryExploit" => false,"restrict" => false,"stable" => false}; if not all(L, a-> isHomogeneous a) then error "Not implemented for non homogeneous polynomials yet";
 	    return gfanTropicalIntersection(L, gfanopt); 
	)
	)


stableIntersection = method(TypicalValue =>
TropicalCycle, Options => {Strategy=>"atint"})

stableIntersection (TropicalCycle, TropicalCycle) := o -> (F,G) -> (
    if (o.Strategy=="atint") then (
-- does not work yet! Problems with intersection in atint (polymake)
-- TODO: rewrite complety after Polyhedra is done and gfanInterface2 got adapted to Polyhedra
	filename := temporaryFileName();
	--ugly declaration of helping strings
	openingStr := "\"_type SymmetricFan\\n\\nAMBIENT_DIM\\n\";";
	dimStr := "\"\\n\\nDIM\\n\";";
	linDimStr := "\"\\n\\nLINEALITY_DIM\\n\";";
	raysStr := "\"\\n\\nRAYS\\n\";";
	nRaysStr := "\"\\nN_RAYS\\n\";";
	linSpaceStr := "\"\\n\\nLINEALITY_SPACE\\n\";";
	orthLinStr := "\"\\n\\nORTH_LINEALITY_SPACE\\n\";";
	fStr := "\"\\n\\nF_VECTOR\\n\";";
	simpStr := "\"\\n\\nSIMPLICIAL\\n\";";
	pureStr := "\"\\n\\nPURE\\n\";";
	coneStr := "\"\\n\\nCONES\\n\";";
	maxConeStr := "\"MAXIMAL_CONES\\n\";";
	weightStr := "\"\\nMULTIPLICITIES\\n\";";
	filename << "use application 'tropical';" << "my $c = "|convertToPolymake(F) << "my $d = "|convertToPolymake(G) << "my $i = intersect($c,$d);" << "use strict;" << "my $filename = '" << filename << "';" << "open(my $fh, '>', $filename);" << "print $fh " << openingStr << "print $fh $i->AMBIENT_DIM;" << "print $fh " << dimStr << "print $fh $i->DIM;" << "print $fh " << linDimStr << "print $fh $i->LINEALITY_DIM;" << "print $fh " << raysStr << "print $fh $i->RAYS;" << "print $fh " << nRaysStr << "print $fh $i->N_RAYS;" << "print $fh " << linSpaceStr << "print $fh $i->LINEALITY_SPACE;" << "print $fh " << orthLinStr << "print $fh $i->ORTH_LINEALITY_SPACE;" << "print $fh " << fStr << "print $fh $i->F_VECTOR;" << "print $fh " << simpStr << "print $fh $i->SIMPLICIAL;" << "print $fh " << pureStr << "print $fh $i->PURE;" << "print $fh " << coneStr << "my $cones = $i->CONES;" << "$cones =~ s/['\\>','\\<']//g;" << "print $fh $cones;" << "print $fh " << maxConeStr << "print $fh $i->MAXIMAL_CONES;" << "print $fh " << weightStr << "print $fh $i->WEIGHTS;" << "close $fh;" << close;
	runstring := "polymake "|filename;
	run runstring;
	result := get filename;
 	gfanParsePolyhedralFan (result, "TropicalMinConventionApplies"=>not Tropical#Options#Configuration#"tropicalMax")
    );
)    

--parseFanFromGfanToPolyhedraFormat = method(TypicalValue => Fan)
--parseFanFromGfanToPolyhedraFormat PolyhedralObject := P -> (
--	oldR := P#"Rays";
--	local newR;
--	if (#oldR > 0) then newR = transpose matrix oldR else newR = matrix{{}};
--	oldL := P#"LinealitySpace";
--	local newL;
--	if (#oldL > 0) then newL = transpose matrix oldL else newL = matrix{{}};
--	F := fan(newR,newL,P#"MaximalCones");
--	F
--)

convertToPolymake = (T) ->(
-- converts a tropical cycle into a string, which is a constructor of a tropical cycle in polymake
--
	F := fan(T);
--check if given cycle is empty
	if (dim(F) < 0) then (return "new Cycle<Min>(PROJECTIVE_VERTICES=>[],MAXIMAL_POLYTOPES=>[],WEIGHTS=>[]);";) else (
--if not empty, check if min- or max-convention is used
	str := "new Cycle<";
	if Tropical#Options#Configuration#"tropicalMax" then str=str|"Max" else str=str|"Min";
	rs := entries transpose rays T;
	numberOfRays := #rs;
	ambientDim := ambDim F;
--convert to polymake convention of rays: 1) add origin of the form (1,0,...,0)
	str = str|">(PROJECTIVE_VERTICES=>[[1";
	local ray;
	scan (ambientDim,i -> str = str|",0");
	str = str|"]";
--2) add every ray with a leading 0
	scan (numberOfRays,i -> (
		ray = rs#i;
		str = str|",[0";
		scan (ambientDim,j -> str = str|","|ray#j);
		str = str|"]";
	));
--every cone must now also be spanned by the origin
	str = str|"],MAXIMAL_POLYTOPES=>[";
	maxCs := maxCones(F);
	numberOfMaxCones := #maxCs;
	local cone;
	scan (numberOfMaxCones,i -> (
		cone = maxCs#i;
		str = str|"[0";
		scan (#cone,j -> str = str|","|(cone#j+1));
		str = str|"],";
	));
--delete last comma
	str = substring(0,#str-1,str);
	str = str|"],WEIGHTS=>[";
--the multiplicities stay unchanged
	mult := multiplicities(T);
	scan (numberOfMaxCones,i -> str = str|mult#i|",");
	str = substring(0,#str-1,str);
	str = str | "]);";
	return str;
	)
)





--functions to get stuff from fans and tropical cycles


rays TropicalCycle:= T->( rays fan T)


cones (ZZ,TropicalCycle):= (i,T)->( cones(i,fan T))


dim TropicalCycle:= T->( dim fan T)


ambDim TropicalCycle:= T->( ambDim fan T)


fVector TropicalCycle:= T->( fVector fan T)


fan TropicalCycle := T -> (T#"Fan")


linealitySpace (TropicalCycle):= T->( linSpace fan T)


maxCones (TropicalCycle):= T->( maxCones fan T)


multiplicities = method(TypicalValue => List)

multiplicities (TropicalCycle) := T -> (T#"Multiplicities")


isPure TropicalCycle := Boolean => T->( isPure(fan(T)))


isSimplicial TropicalCycle:= Boolean => T->( isSimplicial(fan(T)))




------------------------------------------------------------------------------
-- DOCUMENTATION
------------------------------------------------------------------------------
beginDocumentation()
doc ///
    Key
    	Tropical
    Headline
    	the main M2 package for tropical computations
    Description
    	Text
	    This is the main M2 package for all tropical computations.
///


doc ///
    Key 
    	TropicalCycle
    Headline
    	a Type for working with tropical cycles
    Description
    	Text
    	   This is the main type for tropical cycles.  A TropicalCycle
    	   consists of a Fan with an extra HashKey Multiplicities,
	   which is the list of multiplicities on the maximal cones,
	   listed in the order that the maximal cones appear in the
	   MaximalCones list.
///	   






doc ///
    Key
	tropicalCycle
	(tropicalCycle, Fan, List)
    Headline
    	constructs a TropicalCycle from a Fan and a multiplicity function
    Usage
    	tropicalCycle(F,mult)
    Inputs
    	F:Fan 
    Outputs
    	T:TropicalCycle
    Description
	Text
	    A TropicalCycle consists of a Fan with an extra HashKey
	    Multiplicities, which is the list of multiplicities on the
	    maximal cones, listed in the order that the maximal cones
	    appear in the MaximalCones list.  This function takes a
	    Fan (which does not have a list of multiplicties) and adds
	    the Multiplicities key.
      	Example
	    1+1	    
///

doc///
    Key
	isBalanced
	(isBalanced, TropicalCycle)
    Headline
	whether a tropical cycle is balanced
    Usage
    	isBalanced T
    Inputs
	T:TropicalCycle
    Outputs
    	B:Boolean
    Description
	Text
	    A TropicalCycle is balanced if the underlying Fan,
	    together with the multiplicity function makes the fan
	    balanced.  See, for example, ???addTropicalBook Section
	    3.4, for the mathematical definitions. 
        Example
	    1+1	    
///


doc///
  Key
    tropicalPrevariety
    (tropicalPrevariety, List)
    [tropicalPrevariety, Strategy]
  Headline
    the intersection of the tropical hypersurfaces of polynomials in L
  Usage
    tropicalPrevariety(L)
    tropicalPrevariety(L,Strategy=>S)
  Inputs
    L:List
      of polynomials        
    Strategy=>String
      Strategy (currently only "gfan")
  Outputs
    F:Fan
      the intersection of the tropical hypersurfaces of polynomials in L
  Description
    Text
      This method intersects a list of tropical hypersurfaces. The input is a
      list of polynomials whose tropicalizations give the hypersurfaces.
    Example
      QQ[x_1,x_2,x_3,x_4]
      L={x_1+x_2+x_3+x_4,x_1*x_2+x_2*x_3+x_3*x_4+x_4*x_1,x_1*x_2*x_3+x_2*x_3*x_4+x_3*x_4*x_1+x_4*x_1*x_2,x_1*x_2*x_3*x_4-1}
      tropicalPrevariety L
      QQ[x,y]
      tropicalPrevariety({x+y+1,x+y},Strategy => "gfan")
///



doc///
    Key
      tropicalVariety    
      (tropicalVariety, Ideal)
      (tropicalVariety, Ideal, Boolean)
      [tropicalVariety, ComputeMultiplicities]
      [tropicalVariety, Prime]

    Headline
      the tropical variety associated to an ideal
    Usage
      tropicalVariety(I)
      tropicalVariety(I,IsHomogIdeal)
      tropicalVariety(I,ComputeMultiplicities=>true)
      tropicalVariety(I,Prime=>true)
    Inputs
      I:Ideal
        of polynomials
      IsHomogIdeal:Boolean
        a boolean that ensures whether the ideal is already homogeneous   
      ComputeMultiplicities =>Boolean
        a boolean that confirms whether the multiplicities will be computed
      Prime=>Boolean
        a boolean that ensures whether the ideal is already prime
    Outputs
        F:TropicalCycle
    Description 
       Text
         This method takes an ideal and computes the tropical variety associated to it. 
         By default the ideal is assumed to be prime, however inputting a non prime ideal  will not give all tropical variety.
         In this case use optional inputs Prime=>false.
         By default it computes multiplicities but setting ComputeMultiplicities=>false
         turns this off.
	 The ideal I is not assumed to be homogeneous but with tropicalVariety(I,true)
	 the user can confirm it is homogeneous to the function does not check it.
	 
	 
      Example
       QQ[x,y,z]
       --I=ideal(x+y+1) 
       --tropicalVariety(I)
       --tropicalVariety(I,ComputeMultiplicities=>false)  
       J=ideal(x+y+z)
      -- tropicalVariety(J,true)
--       tropicalVariety(J,true,ComputeMultiplicities=>false)
       K=ideal(x^2+y^2+z*y,(z+y)*(z^2+x^2))
       isPrime K
--       tropicalVariety(K,true,Prime=>false)

///


doc///
    Key
	stableIntersection
	(stableIntersection,TropicalCycle,TropicalCycle)
    Headline
    	computes the stable intersection of two tropical varieties
    Usage
	stableIntersection(F,G)
    Inputs
	F:TropicalCycle
	  a tropical cycle
  	G:TropicalCycle
  	  another tropical cycle
    Outputs
        T:TropicalCycle
	  a tropical cycle
    Description 
    	Text
	    This computes the stable intersection of two tropical
	    cycles.  For details on the definition of stable
	    intersection, see, for example, Section 3.6 of TROPICALBOOK.
	Example
    	    1+1
///


doc///
    Key
	isTropicalBasis
	(isTropicalBasis, List)
	[isTropicalBasis, Strategy]
    Headline
	check if a list of polynomials is a tropical basis for the ideal they generate
    Usage
	isTropicalBasis(L)
	isTropicalBasis(L,Strategy=>S)
    Inputs
	L:List
	    of polynomials        
	Strategy=>String
	    Strategy (currently only "gfan")
    Outputs
	F:Boolean
	    whether the list of polynomials is a tropical basis for the ideal it generates
    Description
	Text
	    This method checks if the intersection of the tropical hypersurfaces associated to the polynomials in the list equals the tropicalization of the variety corresponding to the ideal they generate.  
        Example
	    QQ[x,y,z]
--	    isTropicalBasis({x+y+z,2*x+3*y-z})
--	    isTropicalBasis(flatten entries gens Grassmannian (1,4,QQ[a..l]))
///


doc///
    Key
	(rays, TropicalCycle)
        (cones, ZZ, TropicalCycle)
	(dim, TropicalCycle)
	(ambDim, TropicalCycle)
        (fVector, TropicalCycle)
	(linealitySpace, TropicalCycle)
        (maxCones, TropicalCycle)
	multiplicities
	(multiplicities, TropicalCycle)
///



----- TESTS -----

-----------------------
--tropicalCycle
-----------------------
TEST ///

F:=fan(matrix{{0,0,0},{1,0,-1},{0,1,-1}},matrix{{1},{1},{1}},{{0,1},{0,2},{1,2}})
assert((tropicalCycle(F,{1,1,1}))#"Fan"== F)
assert((tropicalCycle(F,{1,1,1}))#"Multiplicities"== {1,1,1})

///

-----------------------
--isTropicalBasis
-----------------------
 
TEST ///
assert(isTropicalBasis (flatten entries gens Grassmannian(1,4,QQ[a..l]))==true)
R:=QQ[x,y,z]
assert( not isTropicalBasis({x+y+z,2*x+3*y-z}))
///


-----------------------
--getters
-----------------------

--rays


TEST///
T:=new TropicalCycle
F:=fan(matrix{{0,0,0},{1,0,-1},{0,1,-1}},matrix{{1},{1},{1}},{{0,1},{0,2},{1,2}})
T#"Multiplicities" ={1,1,1};
T#"Fan" = F;
assert((rays T)==( matrix{{0,0,0},{1,0,-1},{0,1,-1}}))
F:=fan(map(ZZ^3,ZZ^0,0),matrix{{1},{1},{1}},{{}})
T#"Multiplicities" ={1};
T#"Fan" = F;
assert((rays(T))==(matrix {{}, {}, {}}))
///

--maxCones
TEST///
T:=new TropicalCycle
F:=fan(matrix{{0,0,0},{1,0,-1},{0,1,-1}},matrix{{1},{1},{1}},{{0,1},{0,2},{1,2}})
T#"Multiplicities" ={1,1,1};
T#"Fan" = F;
assert((maxCones T)==( {{0,1},{0,2},{1,2}}))
F:=fan(map(ZZ^3,ZZ^0,0),matrix{{1},{1},{1}},{{}})
T#"Multiplicities" ={1};
T#"Fan" = F;
assert((maxCones(T))==({{}}))
///



--dim
TEST///
T:=new TropicalCycle
F:=fan(matrix{{0,0,0},{1,0,-1},{0,1,-1}},matrix{{1},{1},{1}},{{0,1},{0,2},{1,2}})
T#"Multiplicities" ={1,1,1};
T#"Fan" = F;
assert((dim T)==( 3))
F:=fan(map(ZZ^3,ZZ^0,0),matrix{{1},{1},{1}},{{}})
T#"Multiplicities" ={1};
T#"Fan" = F;
assert((dim T)==(1))
///

--ambDim

TEST///
T:=new TropicalCycle
F:=fan(matrix{{0,0,0},{1,0,-1},{0,1,-1}},matrix{{1},{1},{1}},{{0,1},{0,2},{1,2}})
T#"Multiplicities" ={1,1,1};
T#"Fan" = F;
assert((ambDim T)==( 3))
F:=fan(map(ZZ^3,ZZ^0,0),matrix{{1},{1},{1}},{{}})
T#"Multiplicities" ={1};
T#"Fan" = F;
assert((ambDim T)==(3))
///


--fVector
TEST///
T:=new TropicalCycle
F:=fan(matrix{{0,0,0},{1,0,-1},{0,1,-1}},matrix{{1},{1},{1}},{{0,1},{0,2},{1,2}})
T#"Multiplicities" ={1,1,1};
T#"Fan" = F;
assert((fVector T)==( {3, 3, 1, 0}))
F:=fan(map(ZZ^3,ZZ^0,0),matrix{{1},{1},{1}},{{}})
T#"Multiplicities" ={1};
T#"Fan" = F;
assert((fVector T)==({1, 0}))
///



--linealitySpace
TEST///
T:=new TropicalCycle
F:=fan(matrix{{0,0,0},{1,0,-1},{0,1,-1}},matrix{{1},{1},{1}},{{0,1},{0,2},{1,2}})
T#"Multiplicities" ={1,1,1};
T#"Fan" = F;
assert((linealitySpace T)==( matrix{{1},{1},{1}}))
F:=fan(matrix{{1,0,-1},{0,1,-1}},map(ZZ^2,ZZ^0,0),{{0,1},{0,2},{1,2}})
T#"Multiplicities" ={1,1,1};
T#"Fan" = F;
assert((linealitySpace T)==(0))
///

--multiplicities
TEST///
T:=new TropicalCycle
F:=fan(matrix{{0,0,0},{1,0,-1},{0,1,-1}},matrix{{1},{1},{1}},{{0,1},{0,2},{1,2}})
T#"Multiplicities" ={1,1,1};
T#"Fan" = F;
assert((multiplicities T)==( {1,1,1}))
F:=fan(map(ZZ^3,ZZ^0,0),matrix{{1},{1},{1}},{{}})
T#"Multiplicities" ={1};
T#"Fan" = F;
assert((multiplicities T)==({1}))
///


--fan
--cones






   
-----------------------
--isBalanced
-----------------------
--TEST///
--The following two tests are commented until their functions can work in a computer without polymake
    --assert(isBalanced tropicalVariety (ideal {6*x^2+3*x*y+8*y^2+x*z+6*y*z+3*z^2+2*x*t+5*z*t+3*t^2,5*x^2+x*y+8*y^2+x*z+4*y*z+9*z^2+5*x*t+8*y*t+z*t}, true)) 

    --assert(R:=QQ[x,y,z,t]; I=ideal(x+y+z+t); J=ideal(4*x+y-2*z+5*t); 
--	     stableIntersection(tropicalVariety(I, true),tropicalVariety(J, true))==tropicalVariety(ideal (I, J), true))
   -- assert(R:=QQ[x,y,z]; rays(tropicalVariety(ideal(x+y+1)))==matrix{{-3,3,0},{-3,0,3},{-2,1,1}})
--///    	    	



-----------------------
--tropicalPrevariety
-----------------------

TEST///
QQ[x,y,z,w]
F:=tropicalPrevariety({x+y+z+w,x^2+y*z})

///



-----------------------
--stableIntersection
-----------------------


--The following two tests are commented until their functions can work in a computer without polymake
--R:=QQ[x,y,z,t];
--I=ideal(x+y+z+t); 
--J=ideal(4*x+y-2*z+5*t); 
--assert(stableIntersection(tropicalVariety(I, true),tropicalVariety(J, true))==tropicalVariety(ideal (I, J), true))
  

-----------------------
--tropicalVariety
-----------------------





    




-----------------------
--findMultiplicities
--findMultiplicity
--computeCones
-----------------------





-----------------------
--isPure
-----------------------




-----------------------
--isSimplicial
-----------------------





-----------------------
--convertToPolymake
-----------------------










end

    
    
    
 	    	
