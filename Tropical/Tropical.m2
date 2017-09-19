polymakeOkay := try replace( "polymake version ", "", first lines get "!polymake --version 2>&1") >= "3.0" else false;

optArgs = new OptionTable from if (version#"VERSION" > "1.10") then {OptionalComponentsPresent => polymakeOkay} else {}

newPackage(
    	"Tropical",
	Version => "0.1",
	Date => "May 2016",
	Authors => {
   		{Name => "Carlos Amendola", Email => "", HomePage=>""},
	    	{Name => "Kathlen Kohn", Email => "", HomePage=>""},
  		{Name => "Sara Lamboglia", Email => "", HomePage=>""},
	    	{Name => "Diane Maclagan", Email => "D.Maclagan@warwick.ac.uk", HomePage=>"http://homepages.warwick.ac.uk/staff/D.Maclagan/"},
   		{Name => "Benjamin Smith", Email => "", HomePage=>""},
   		{Name => "Jeff Sommars", Email => "", HomePage=>""},
    		{Name => "Paolo Tripoli", Email => "", HomePage=>""},
   		{Name => "Magda Zajaczkowska", Email => "", HomePage=>""}
		},
	Headline => "A package for doing computations in tropical geometry",
	Configuration => {
		"path" => "",
		"fig2devpath" => "",
		"keepfiles" => false,
		"cachePolyhedralOutput" => true,
		"tropicalMax" => false
	},
        PackageExports => {"gfanInterface2","EliminationMatrices","Binomials"},
	DebuggingMode => true,
	AuxiliaryFiles => true,
	CacheExampleOutput => true,
	optArgs
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
  "multiplicities",
  "IsHomogeneous"
}



if polymakeOkay then << "-- polymake is installed\n" else << "-- polymake not present\n"


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

 
tropicalPrevariety (List) := o -> L -> (gfanopt:=(new OptionTable) ++ {"tropicalbasistest" => false,"tplane" => false,"symmetryPrinting" => false,"symmetryExploit" => false,"restrict" => false,"stable" => false};
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
      
      if M!={{}} then(
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
     ConeOfVariety= L|matrix ConeOfVariety;
     -- each cone has to contain also the lineality space since we are not quotienting by it
     -- ConeOfVariety = matrix ConeOfVariety ;
      --add the cone to the list of cones
      	  ConesOfVariety=append(ConesOfVariety,ConeOfVariety);
	  i=i+1;
	);
    )
    else 
    (ConesOfVariety={L};
	) ;   
    ConesOfVariety
    )

--input:rays,maximal cones and lineality space 
--output:list of matrices
-- note that ConesOfVariety is a local variable also in findMultiplicities
findMultiplicity=(M,I)->(
--compute vector w in relative interior in order to get the initial ideal in_w(I) with w in the maximal cone M
    w:=flatten entries(sum(numColumns M, j->M_{j}));
--weight the ring according to this w , we are using leadTerm and max convention since the input fan has not been changed to min convention yet
    R:=newRing(ring I, MonomialOrder=>{Weights=>w},Global=>false);
    J:=sub(I,R);
    K:=ideal(leadTerm(1,J));
--you saturate since you don't want the components outside the torus
    InitialIdeal:= saturate(sub(K,ring I),ideal product gens ring I);
--this is the the basis of the lattice associated to the toric ideal we are going to compute
    Basis:= (maxCol( generators kernel transpose M))_0;
    --this is where we use  Binomials package
    toricIdeal:=saturate(latticeBasisIdeal(ring InitialIdeal,Basis),ideal product gens ring I);
    m:=(degree(InitialIdeal)/degree (toricIdeal));
--return multiplicity m as integer, since it lives currently in QQ
--if m is an integer (as it should be), then the following command parses it to ZZ
--otherwise, an errow will be returned "rational number is not an integer"
    lift(m,ZZ) 
    )    

--input Matrix whose columns are the generators of the cone and the ideal of the variety
--output a list of one number that is the multiplicity
--maths behind it look at exercise 34 chapter 3 Tropical book and [Stu96]
--(Grobner basis and Convex Polytopes ) 
findMultiplicities=(I,T)->(
	ConesOfVariety:={};
	M:={};
	ConesOfVariety=computeCones( rays T,maxCones T, linSpace T);
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


tropicalVariety = method(TypicalValue => TropicalCycle,  Options => {
	ComputeMultiplicities => true,
	Prime => true,
	IsHomogeneous=>false
	})



--Main function to call for tropicalVariety.  Makes no assumption on ideal
--WARNING:  There is a bug here in the way the new polynomial ring is dealt with.
-- it seems to work if we've define the new ring globally, but not inside the package.
tropicalVariety (Ideal) := o -> (I) ->(
    local F;
    local T;
    Homog:=isHomogeneous I;
    if o.IsHomogeneous==false or Homog==false then 
    (	 if Homog==false then(
	 --First homogenize
    	R:=ring I;
--	KK:=coefficientRing R;
    	AA:= symbol AA;
    	S:= first flattenRing( R[getSymbol "AA", Join=>false]);
	J:=substitute(I,S);
	J=homogenize(J,S_0);
	J=saturate(J,S_0);
	--we transform I in J so that the procedure continues as in the homogeneous case
	I=J;
	)
	);
    
    if (o.Prime== true)
		then (
		    F= gfanTropicalTraverse( gfanTropicalStartingCone I);
		    --check if resultung fan is empty
		    if (instance(F,String)) then return F; 
		    T=tropicalCycle(F_0,F_1))
		else
		--If ideal not prime, use gfanTropicalBruteForce to ensure disconnected parts are not missed at expense of multiplicities
		    (if o.ComputeMultiplicities==false 
		     then (
			   F= gfanTropicalBruteForce gfanBuchberger I;
			   --check if resulting fan is empty
			   if (instance(F,String)) then return F; 
			   mult := {};
			   i:=0;
			   
			   while(i<#maxCones (F))do(
			       mult=append(mult,{});
			       i=i+1);
			   T=tropicalCycle(F,mult)
			   --note that the output of gfanTropicalBruteForce is a fan and an empty list of multiplicities this is why we have to add the right number of empty multiplicities
	    	    	   )
		     else (
			 F= gfanTropicalBruteForce gfanBuchberger I;
			 --check if resulting fan is empty
			 if (instance(F,String)) then return F; 
			 T=tropicalCycle(F,findMultiplicities(I,F))
			 )  );
    if   o.IsHomogeneous==false or Homog==false then 
	( if Homog==false then(
	    newRays:=dehomogenise(rays T);
	newLinSpace:=gens gb dehomogenise(linealitySpace T);
	TProperties := {newRays,
			newLinSpace,
			maxCones T,
			dim(T)-1,
			isPure fan T,
			isSimplicial T,
			fVector T};
	UFan:=fanFromGfan(TProperties);
	U:= tropicalCycle(UFan,multiplicities(T));
	-- we always want the output to be called T so we change U in T
	T=U;
	)
	);
	if (Tropical#Options#Configuration#"tropicalMax" == true) then return  T  else return minmaxSwitch T

	
)
--auxiliary function to quotient out the lineality space (1,1,...1) introduced by the homogenisation
dehomogenise=(M) -> (
	vectorList:= entries transpose M;
	dehomog:= new List;
	for L in vectorList do (
		newL := apply(#L-1,i->(L#(i+1)-L#0));
		gcdL := gcd(newL);
		if gcdL==0 then continue;
		newL = newL/gcdL;
		newL = apply(newL,i->(lift(i,ZZ)));
		dehomog = append(dehomog,newL);
	);
	if dehomog=={} then map(ZZ^(#entries(M)-1),ZZ^0,0)
	else transpose matrix dehomog
)

--Check if a list of polynomials is a tropical basis for the ideal they generate

--Current Strategy is using 'gfan'
isTropicalBasis = method(TypicalValue => Boolean,  Options => {
	Strategy=> "gfan"
	})

isTropicalBasis (List) := o -> L -> (
	if (o.Strategy=="gfan") then (
	    gfanopt:=(new OptionTable) ++ {"tropicalbasistest" => true,"tplane" => false,"symmetryPrinting" => false,"symmetryExploit" => false,"restrict" => false,"stable" => false}; 

if not all(L, a-> isHomogeneous a) then error "Not implemented for non homogeneous polynomials yet";
 	    return gfanTropicalIntersection(L, gfanopt) 
	)
	)


stableIntersection = method(TypicalValue =>
TropicalCycle, Options => {Strategy=>"atint"})

stableIntersection (TropicalCycle, TropicalCycle) := o -> (F,G) -> (
--TODOS:
--0) export strategies
--1) what to do if polymake is not installed
--2) how to deal with min vs max?
--3) how to add lineality space?
--4) gfan strategy outputs only a fan, not a tropical cycle
--5) test cases
--6) make tropical an immutable hash table
    if (o.Strategy=="atint") then (
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
	(polyfan, mult) := gfanParsePolyhedralFan(result);
--now we still need to transform things back to our format:
--1) adjust the rays
	R := rays polyfan;
	row := (entries R)#0;
	ind := -1;
	scan(#row, i -> if ((row#i)==1) then ind = i);
	R = submatrix'(R, {0} , {ind});
--2)adjust the maximal cones
	C := maxCones polyfan;
	C = apply(C, c -> delete(ind, c));
	C = apply(C, c -> apply(c, n -> if (n > ind) then (n-1) else (n) ));
--3)adjust lineality space
	L := linSpace polyfan;
	L = submatrix'(L, {0} , );
	L = L|(transpose matrix {apply(numgens target L , i -> 1)});
	return tropicalCycle (fan(R,L,C),mult);
    )
    else if (o.Strategy=="gfan") then (
	F1 := F#"Fan";	
	m1 := F#"Multiplicities";
	F2 := G#"Fan";	
	m2 := G#"Multiplicities";
	return gfanStableIntersection(F1,m1,F2,m2);
    ) 
    else (
	return "Strategy unknown: Choose 'atint' or 'gfan'";
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
	    This uses Anders Jensen's package gfan, Michael Joswig's
	    package Polymake, and also internal M2 computations.
///


doc ///
    Key 
    	TropicalCycle
    Headline
    	a Type for working with tropical cycles
    Description
		Text
			This is the main type for tropical cycles. A TropicalCycle
			consists of a Fan with an extra HashKey Multiplicities,
			which is the list of multiplicities on the maximal cones
			listed in the order that the maximal cones appear in the
			MaxCones list. A TropicalCycle
			is saved as a hash table which contains the Fan and the
			Multiplicities.
	   
///	   






doc ///
    Key
	tropicalCycle
	(tropicalCycle, Fan, List)
    Headline
    	constructs a TropicalCycle from a Fan and a list with multiplicities
    Usage
    	tropicalCycle(F,mult)
    Inputs
    	F:Fan
		mult:List 
    Outputs
    	T:TropicalCycle
    Description
		Text
			This function creates a tropical cycle from a fan and a list of multiplicities.
			The multiplicities must be given in the same order as the maximal cones
			appear in the MaximalCones list.
		Example
			F = fan {posHull matrix {{1},{0},{0}}, posHull matrix {{0},{1},{0}}, posHull matrix {{0},{0},{1}}, posHull matrix {{-1},{-1},{-1}}} 
			mult = {1,2,-3,1}
			tropicalCycle(F, mult)
///

doc///
    Key
	isBalanced
	(isBalanced, TropicalCycle)
    Headline
		checks whether a tropical cycle is balanced
    Usage
    	isBalanced T
    Inputs
		T:TropicalCycle
    Outputs
    	B:Boolean
    Description
		Text
			This function checks if a tropical cycle is balanced.
		Example
			QQ[x,y,z]
			V = tropicalVariety(ideal(x+y+z))
			-- isBalanced V
			F = fan {posHull matrix {{1},{0},{0}}, posHull matrix {{0},{1},{0}}, posHull matrix {{0},{0},{1}}, posHull matrix {{-1},{-1},{-1}}} 
			mult = {1,2,-3,1}
			-- isBalanced (tropicalCycle(F, mult))
///


doc///
	Key
		tropicalPrevariety
		(tropicalPrevariety, List)
		[tropicalPrevariety, Strategy]
	Headline
		the intersection of the tropical hypersurfaces
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
			This method intersects the tropical hypersurfaces
			coming from the tropicalizations of the polynomials in the list L.
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
      [tropicalVariety, ComputeMultiplicities]
      [tropicalVariety, Prime]
      [tropicalVariety, IsHomogeneous]

    Headline
      the tropical variety associated to an ideal
    Usage
      tropicalVariety(I)
      tropicalVariety(I,ComputeMultiplicities=>true)
      tropicalVariety(I,Prime=>true)
      tropicalVariety(I,IsHomogeneous=>false)
    Inputs
      I:Ideal
        of polynomials
      IsHomogeneous=>Boolean
        that ensures whether the ideal is already homogeneous   
      ComputeMultiplicities =>Boolean
        that confirms whether the multiplicities will be computed
      Prime=>Boolean
        that ensures whether the ideal is already prime
    Outputs
        F:TropicalCycle
    Description 
       Text
         This method takes an ideal and computes the tropical variety
         associated to it.  By default the ideal is assumed to be
         prime.  If this is not the case the default answer will not
         necessarily give the correct answer.  In this case use the
         optional argument Prime=>false.  By default the
         tropicalVariety command computes multiplicities but setting
         computeMultiplicities=>false turns this off.  This only saves
         time if Prime is set to false.  The ideal I is not assumed to
         be homogeneous.  The optional argument IsHomogeneous=>true
         allows the user to assert that the ideal is homogeneous.
      Example
       QQ[x,y];
       I=ideal(x+y+1);
       T=tropicalVariety(I)
       rays(T)
       maxCones(T)
       linealitySpace T
       fVector fan T
       QQ[x,y,z,w];
       I=intersect(ideal(x+y+z+w),ideal(x-y,y-z));
       T= tropicalVariety(I,Prime=>false);
       rays(T)
       maxCones(T)
       multiplicities(T)
       linealitySpace T

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
	checks if a list of polynomials is a tropical basis for the ideal they generate
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
	    isTropicalBasis({x+y+z,2*x+3*y-z})
	    isTropicalBasis(flatten entries gens Grassmannian (1,4,QQ[a..l]))
///


doc///
    Key
	multiplicities
	(multiplicities, TropicalCycle)
    Headline
		returns the list of multiplicities on maximal cones in a tropical cycle
    Usage
    	multiplicities(T)
    Inputs
		T:TropicalCycle
    Outputs
    	L:List
    Description
		Text
			This method returns the list of multiplicities on maximal cones in a tropical cycle. 
		Example
			QQ[x,y,z]
			V = tropicalVariety(ideal(x+y+z));
			multiplicities V	    
///

doc///
    Key
	ComputeMultiplicities
    Headline
		option to compute the multiplicities in case they ideal is not prime
    Usage
    	tropicalVariety(I,ComputeMultiplicities=>true)
    Description
		Text
			This option allows to compute the multiplicities in case the ideal I is not prime. In fact the output of gfan 
			does not include them and hence they are computed separately by this package. By default the ideal is assumed to be prime.
		Example
			QQ[x,y,z];
			I=ideal(x^2-y^2);
			isPrime I
			T=tropicalVariety(I,Prime=>false,ComputeMultiplicities=>true);
			rays T
			maxCones T
			multiplicities T
///

doc///
    Key
	Prime
    Headline
		option to declare if the input   ideal is prime
    Usage
    	tropicalVariety(I,Prime=>false)
    
    Description
		Text
			By default the ideal is assumed to be prime. If the ideal is not prime then the internal  procedure to compute the tropicalization is different.
			It is used gfan_tropicalbrute force instead of gfan_tropicaltraverse. 
		Example
			QQ[x,y,z];
			I=ideal(x^2+y^2-2*x*y);
			isPrime I
			T=tropicalVariety(I,Prime=>false)	    
///


doc///
    Key
	IsHomogeneous
    Headline
		option to declare if the input  ideal is homogeneous
    Usage
    	tropicalVariety(I,IsHomogeneous=>true)
    
    Description
		Text
			If the option is used than  homogeneity of the ideal  is not tested. By default the ideal is always assumed not homogeneous and a test is performed before
			applying the function tropicalVariety.
		Example
		          QQ[x,y];
			  I=ideal(x+y+1);
			  T=tropicalVariety (I,IsHomogeneous=>false)
			
				    
///



doc///
    Key
	(fan,TropicalCycle)
    Headline
	    outputs the fan assocated to the tropical cycle
    Usage
    	fan(T)
    Inputs
	T:TropicalCycle
	         
    Outputs
	F:Fan
	    the fan associated to the  tropical cycle T
    
    Description
		Text
		        This function outputs the fan associated to the tropical cycle T.	
		Example
			QQ[x,y,z]
			T=tropicalVariety (ideal(x+3*y+3));
			fan T
			
			    
///
doc///
    Key
	(maxCones,TropicalCycle)
    Headline
	computes the maximal cone of a tropical cycle	
    Usage
    	maxCones(T)
    Inputs
	T:TropicalCycle
	         
    Outputs
        L:List
	    
    
    Description
		Text
		        This function computes the maximal cones of the fan associated to the tropical cycle.
			
		Example
			QQ[x,y,z,w]
			I=ideal(x^2-y*z+w^2,w^3-y^3*x+z^3);
			--T=tropicalVariety I;
			--maxCones T
			    
///
doc///
    Key
	(isPure,TropicalCycle)
    Headline
	checks whether  a tropical cycle is pure
    Usage
    	isPure(T)
    Inputs
	T:TropicalCycle
	         
    Outputs
	B:Boolean
	    
    
    Description
		Text
		        This function checks whether the fan associated to the tropical cycle is pure, i.e. if the maximal cones have all the same dimension.	
		Example
		        F=fan ({posHull(matrix{{1,2,3},{0,2,0}}),posHull(matrix{{0},{1}})});
			T=tropicalCycle (F,{1,2});
			isPure T
			    
///
doc///
    Key
	(isSimplicial,TropicalCycle)
    Headline
		checks whether a tropical cycle is simplicial
    Usage
    	isSimplicial(T)
    Inputs
	T:TropicalCycle
	         
    Outputs
	B:Boolean
	    
    
    Description
		Text
		       This function checks if the fan associated to the tropical cycle T is simplicial, i.e. if for each cone the rays generating  it are linearly independent.
		Example
		       F=fan ({posHull(matrix{{1,2,3},{0,2,0}}),posHull(matrix{{0},{1}})});
		       T=tropicalCycle (F,{1,2});
		       isSimplicial T
		      
			    
///
doc///
    Key
	(rays,TropicalCycle)
    Headline
	computes the rays of a tropical cycle	
    Usage
    	rays(T)
    Inputs
	T:TropicalCycle
	         
    Outputs
	M:Matrix
	    
    
    Description
		Text
		        This function computes the rays of the fan associated to the tropical cycle. These are the columns of
		        the output matrix.	
		Example
		        QQ[x,y,z,w]
			I=ideal(x^2-y*z+w^2,w^3-y^3*x+z^3);
			T=tropicalVariety I;
			rays T
			    
///
doc///
    Key
	(dim,TropicalCycle)
    Headline
		computes the dimension of a tropical cycle
    Usage
    	dim(T)
    Inputs
	T:TropicalCycle
	         
    Outputs
	k:ZZ
	    the dimension of the tropical cycle T
    
    Description
		Text
	                This function computes the dimension of the fan associated to the tropical cycle T.
		Example
			QQ[x,y,z,w]
			I=ideal(x^2-y*z+w^2,w^3-y^3*x+z^3);
			--T=tropicalVariety I;
			--dim T
			    
///

doc///
    Key
	(fVector,TropicalCycle)
    Headline
		computes the fVector of  a  tropical cycle
    Usage
    	fVector(T)
    Inputs
	T:TropicalCycle
	         
    Outputs
	L:List
	    the fVector of the fan associated to the  tropical cycle T
    
    Description
		Text
		       This function computes the fVector of the fan associated to the tropical cycle T.	
		Example
			QQ[x,y,z]
			T=tropicalVariety (ideal(x+3*y+3));
			fVector T
			    
///

doc///
    Key
	(ambDim,TropicalCycle)
    Headline
		computes the dimension of the ambient space of a tropical cycle
    Usage
    	ambDim(T)
    Inputs
	T:TropicalCycle
	          
    Outputs
	n:ZZ
	    the dimension of the tropicalCycle T
    
    Description
		Text
		        This function computes the dimension of the space where the tropical cycle is contained.	
		Example
			QQ[x,y,z]
			T=tropicalVariety(ideal(x+y+z));
			ambDim T
			    
///
doc///
    Key
	(cones,ZZ,TropicalCycle)
    Headline
		computes the cones of a tropical cycle
    Usage
    	cones(k,T)
    Inputs
	k:ZZ
	T:TropicalCycle
	         
    Outputs
	L:List
	    the cones of codimension k in T
    
    Description
		Text
		        This function computes the cone of codimension k of the fan associated to the tropical cycle T.	
		Example
			QQ[x,y,z,w,t]
			I=ideal(x^2-y*z+w^2,w^3-y^3*x+z^3,t-w+x);
			--T=tropicalVariety I;
			--cones(2,T)

///

doc///
    Key
	(linealitySpace,TropicalCycle)
    Headline
	computes the lineality space of a  tropical cycle
    Usage
    	linealitySpace(T)
    Inputs
	T:TropicalCycle
	         
    Outputs
	M:Matrix
	    
    
    Description
		Text
		        This function computes the lineality space of the fan associated to the tropical cycle T. The generators of the lineality space are the columns of the 
		        output  matrix
		Example
		        QQ[x,y,z];
			I=ideal(x-y);
			T=tropicalVariety I;
			L=linealitySpace T
			    
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
assert((rays T)==( matrix{{0,0,0},{1,-1,0},{0,-1,1}}))
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
assert(sort(maxCones T)==( sort({{0,1},{0,2},{1,2}})))
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
assert((fVector T)==( {1, 3, 3}))
F:=fan(map(ZZ^3,ZZ^0,0),matrix{{1},{1},{1}},{{}})
T#"Multiplicities" ={1};
T#"Fan" = F;
assert((fVector T)==({1}))
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
TEST///
T:=new TropicalCycle
F:=fan(matrix{{0,0,0},{1,0,-1},{0,1,-1}},matrix{{1},{1},{1}},{{0,1},{0,2},{1,2}})
T#"Multiplicities" ={1,1,1};
T#"Fan" = F;
assert((fan T)==(F))
F:=fan(map(ZZ^3,ZZ^0,0),matrix{{1},{1},{1}},{{}})
T#"Multiplicities" ={1};
T#"Fan" = F;
assert((fan T)==(F))
///

--cones
TEST///
T:=new TropicalCycle
F:=fan(matrix{{0,0,0},{1,0,-1},{0,1,-1}},matrix{{1},{1},{1}},{{0,1},{0,2},{1,2}})
T#"Multiplicities" ={1,1,1};
T#"Fan" = F;
assert((cones(1,T))==({{}}))
assert((cones(2,T))==({{0},{1},{2}}))
assert((cones(3,T))==({{0,1},{0,2},{1,2}}))
F:=fan(map(ZZ^3,ZZ^0,0),matrix{{1},{1},{1}},{{}})
T#"Multiplicities" ={1};
T#"Fan" = F;
assert((cones(1,T))==({{}}))
///





   
-----------------------
--isBalanced
-----------------------
if polymakeOkay then (
--if Tropical.Options.OptionalComponentsPresent then (
--TEST///
--The following two tests are commented until their functions can work in a computer without polymake
    --assert(isBalanced tropicalVariety (ideal {6*x^2+3*x*y+8*y^2+x*z+6*y*z+3*z^2+2*x*t+5*z*t+3*t^2,5*x^2+x*y+8*y^2+x*z+4*y*z+9*z^2+5*x*t+8*y*t+z*t}, true)) 

    --assert(R:=QQ[x,y,z,t]; I=ideal(x+y+z+t); J=ideal(4*x+y-2*z+5*t); 
--	     stableIntersection(tropicalVariety(I, true),tropicalVariety(J, true))==tropicalVariety(ideal (I, J), true))
   -- assert(R:=QQ[x,y,z]; rays(tropicalVariety(ideal(x+y+1)))==matrix{{-3,3,0},{-3,0,3},{-2,1,1}})
--///
--)
)  


-----------------------
--tropicalPrevariety
-----------------------

TEST///
QQ[x,y,z,w]
F:=tropicalPrevariety({x+y+z+w,x^2+y*z})
assert((rays F) == matrix {{1,1,-1},{5,-3,-1},{-3,5,-1},{-3,-3,3}})
///



-----------------------
--stableIntersection
-----------------------


if polymakeOkay then (
--if Tropical.Options.OptionalComponentsPresent then (
--The following two tests are commented until their functions can work in a computer without polymake
--R:=QQ[x,y,z,t];
--I=ideal(x+y+z+t); 
--J=ideal(4*x+y-2*z+5*t); 
--assert(stableIntersection(tropicalVariety(I, true),tropicalVariety(J, true))==tropicalVariety(ideal (I, J), true))
--)
)  

-----------------------
--tropicalVariety
-----------------------


TEST///
QQ[x,y,z,w]
I=ideal(x^2+y^2+z^2)
T:=tropicalVariety(I)
assert ((rays T)==(matrix {{2, -1, -1},{-1, 2, -1}, {-1, -1, 2}, {0, 0, 0}}))
assert((linealitySpace T)==( matrix {{1, 0}, {1, 0}, {1, 0}, {0, 1}}))
assert((multiplicities T)==( {2,2,2}))
assert((maxCones T)==( {{0},{1},{2}}))
I=ideal(x^2+x*z)
T=tropicalVariety (I,Prime=>false)
assert ((rays T)==(0 ))
assert((linealitySpace T)==( matrix {{0, 1, 0}, {1, 0, 0}, {0, 1, 0}, {0, 0, 1}}))
assert((maxCones T)==( {{}}))
assert((multiplicities T)==( {1}))
T=tropicalVariety (I,Prime=>false,ComputeMultiplicities=>false)
assert ((rays T)==(0))
assert((linealitySpace T)==( matrix {{0, 1, 0}, {1, 0, 0}, {0, 1, 0}, {0, 0, 1}}))
assert((maxCones T)==( {{}}))
assert((multiplicities T)==( {{}}))
QQ[x,y,z]
I=ideal(x*y-y+1)
T=tropicalVariety(I,IsHomogeneous=>true)
assert ((rays T)== (matrix {{-1, 0, 3}, {1, -3, 0}, {0, -1, 1}}))
assert((linealitySpace T)==( matrix {{0}, {0}, {1}} ))
assert((maxCones T)==( {{1}, {0}, {2}}))
assert((multiplicities T)==( {1, 1, 1}))


///



    




-----------------------
--findMultiplicities
--findMultiplicity
--computeCones
-----------------------





-----------------------
--isPure
-----------------------
TEST///
T:=new TropicalCycle
F:=fan(matrix{{0,0,0},{1,0,-1},{0,1,-1}},matrix{{1},{1},{1}},{{0,1},{0,2},{1,2}})
T#"Multiplicities" ={1,1,1};
T#"Fan" = F;
assert(isPure(T)==(true))
F:=fan(matrix{{0,0,0},{1,0,-1},{0,1,-1}},matrix{{1},{1},{1}},{{0},{1,2}})
T#"Multiplicities" ={1,1};
T#"Fan" = F;
assert(isPure(T)==(false))
///



-----------------------
--isSimplicial
-----------------------
TEST///
T:=new TropicalCycle
F:=fan(matrix{{0,0,0},{1,0,-1},{0,1,-1}},matrix{{1},{1},{1}},{{0,1},{0,2},{1,2}})
T#"Multiplicities" ={1,1,1};
T#"Fan" = F;
assert(isSimplicial(T)==(true))
F:=fan(matrix{{0,0,0,0},{1,0,-1,2},{0,1,-1,1}},matrix{{1},{1},{1}},{{0,1,2},{0,1,3},{0,2,3},{1,2,3}});
T#"Multiplicities" ={1,1,1,1};
T#"Fan" = F;
assert(isSimplicial(T)==(false))
///




-----------------------
--convertToPolymake
-----------------------










end

    
    
    
 	    	
