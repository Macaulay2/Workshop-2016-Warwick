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
        PackageExports => {"PolyhedralObjects","gfanInterface2"},
	DebuggingMode => true
)

export {
  "TropicalCycle",
  "tropicalCycle",
  "isBalanced",
  "tropicalPrevariety",
  "computeMultiplicities",
  "Prime",
  "stableIntersection",
  "tropicalVariety",
  "isTropicalBasis",
  "convertToPolymake",
  "getRays",
  "getCones",
  "getDim",
  "getFVector",
  "getLinealitySpace",
  "getMaximalCones",
  "getPure",
  "getSimplicial"
}

--???check syntax - idea is that this is where we should define local symbols
--protect Maclagan




------------------------------------------------------------------------------
-- CODE
------------------------------------------------------------------------------

--Setting up the data type TropicalCycle

TropicalCycle = new Type of Fan
TropicalCycle.synonym = "tropical cycle"
TropicalCycle.GlobalAssignHook = globalAssignFunction
TropicalCycle.GlobalReleaseHook = globalReleaseFunction


--basic operations on a tropical cycle

--TODO make this a method
tropicalCycle = (F,mult)->(
    if #F#"MaximalCones" != #mult then error("The multiplicity list has the wrong length");
    T := new TropicalCycle from F;
    T#"Multiplicities" = mult;
    return T
)    


isBalanced = F->(
	filename := temporaryFileName();
	filename << "use application 'tropical';" << endl << "my $c = "|convertToPolymake(F) << endl << "print is_balanced($c);" << endl << "use strict;" << endl << "my $filename = '" << filename << "';" << endl << "open(my $fh, '>', $filename);" << endl << "print $fh is_balanced($c);" << endl << "close $fh;" << endl << close;
	runstring := "polymake "|filename;
	run runstring;
	result := get filename;
	if (result=="1") then return true else return false;    
)

isWellDefined TropicalCycle := Boolean =>
 F ->(
 -- Check that the fan is pure, and then call isBalanced   
       if F#"Pure" then return(isBalanced(F)) else return(false);
)      




--Computing a tropical prevariety

tropicalPrevariety = method(TypicalValue => Fan,  Options => {
--in the future, more strategies not dependent on "gfan" will be available
	Strategy=> "gfan"
	})

 
tropicalPrevariety (List) := o -> L -> (gfanopt:=(new OptionTable) ++ {"t" => false,"tplane" => false,"symmetryPrinting" => false,"symmetryExploit" => false,"restrict" => false,"stable" => false};
--using strategy gfan
    if (o.Strategy=="gfan") then (
    	F:=gfanTropicalIntersection(L, gfanopt); G:=new Fan;
--remove the key "Multiplicities" since it does not make sense for a prevariety (in contrast to TropicalCycle)
    	scan(keys F, a-> if a!="Multiplicities" then G#a=F#a); G)
    else error "options not valid"
)

--Computing a tropical variety

tropicalVariety = method(TypicalValue => TropicalCycle,  Options => {
	computeMultiplicities => true,
	Prime => true
	})
tropicalVariety (Ideal,Boolean) := opt -> (I,IsHomogIdeal)  -> (
    	if IsHomogIdeal==false then print "0"
--Once tropicalVariety(I) is finished, send there to homogenize
	else
		--If ideal is prime, use following algorithm for speed
	       (if (opt.computeMultiplicities==true and opt.Prime== true)
		then (F:= gfanTropicalTraverse( gfanTropicalStartingCone I);
	            tropicalCycle(F,F#"Multiplicities"))
		else
		--If ideal not prime, use gfanTropicalBruteForce to ensure disconnected parts are not missed at expense of multiplicities
		    (if opt.computeMultiplicities==false 
		     then gfanTropicalBruteForce gfanBuchberger I
		--Cannot currently compute multiplicities for non-prime ideals
		     else print  " Cannot compute multiplicities if ideal not prime"  )))


--Main function to call for tropicalVariety.  Makes no assumption on ideal
tropicalVariety (Ideal) := o -> (I) ->(
    if isHomogeneous(I) then return(tropicalVariety(I,true,o))
    else (
	--First homogenize
    	R:=ring I;
	KK:=coefficientRing R;
--Next line needs to be fixed - AA is a "safe" variable	
    	AA:= local AA;
	S:=KK(monoid[gens R | {AA}]);
	I=substitute(I,S);
	J:=homogenize(I,AA);
	J=saturate(J,AA);
	--Then compute tropical variety of homogenized ideal calling the other function
	T:=tropicalVariety(J,true);
    	--Then remove lineality space
    	return(T);
    )
)    

--Check if a list of polynomials is a tropical basis for the ideal they generate

--Current Strategy is using 'gfan'
isTropicalBasis = method(TypicalValue => Boolean,  Options => {
	Strategy=> "gfan"
	})

isTropicalBasis (List) := o -> L -> (
	if (o.Strategy=="gfan") then (
	    gfanopt:=(new OptionTable) ++ {"t" => true,"tplane" => false,"symmetryPrinting" => false,"symmetryExploit" => false,"restrict" => false,"stable" => false}; if not all(L, a-> isHomogeneous a) then error "Not implemented for non homogeneous polynomials yet";
 	    F:=gfanTropicalIntersection(L, gfanopt); 
--Under current version of 'gfan', the information is only kept in #GfanFileHeader, checking the first 13 characters.
	    if (toString substring(0,13, toString F#"GfanFileHeader")=="The following") then false
	    else (
		if (toString substring(0,13, toString F#"GfanFileHeader")=="_application ") then true
--In case something has changed in 'gfan' or 'gfanInterface'
	        else error "Algorithm fail"
		)
	)
	else error "options not valid"
	)


stableIntersection = method(TypicalValue =>
TropicalCycle, Options => {Strategy=>"atint"})

stableIntersection (TropicalCycle, TropicalCycle) := o -> (F,G) -> (
	filename := temporaryFileName();
	filename << "$c = "|convertToPolymake(F) << endl << "print is_balanced($c);" << endl << close;
	return filename;
)    

convertToPolymake = (T) ->(
	str := "new Cycle<";
	if Tropical#Options#Configuration#"tropicalMax" then str=str|"Max" else str=str|"Min";
	str = str|">(PROJECTIVE_VERTICES=>[[1";
	rays := T#"Rays";
	ray := rays#0;
	rayDimension := #ray;
	scan (rayDimension,i -> str = str|",0");
	str = str|"]";
	numberOfRays := #rays;
	scan (numberOfRays,i -> (
		ray = rays#i;
		str = str|",[0";
		scan (rayDimension,j -> str = str|","|ray#j);
		str = str|"]";
	));
	str = str|"],MAXIMAL_POLYTOPES=>[";
	maxCones := T#"MaximalCones";
	numberOfMaxCones := #maxCones;
	cone := maxCones#0;
	scan (numberOfMaxCones,i -> (
		cone = maxCones#i;
		str = str|"[0";
		scan (#cone,j -> str = str|","|(cone#j+1));
		str = str|"],";
	));
--delete last comma
	str = substring(0,#str-1,str);
	str = str|"],WEIGHTS=>[";
	mult := T#"Multiplicities";
	scan (numberOfMaxCones,i -> str = str|mult#i|",");
	str = substring(0,#str-1,str);
	str = str | "]);";
	return str
)





--functions to get stuff from fans and tropical cycles



getRays = method(TypicalValue => List)

getRays (Fan) :=  F -> ( F#"Rays")

--getRays (TropicalCycle):= C->( getRays(C#"Fan"))


getCones = method(TypicalValue => List)

getCones (Fan) :=  F -> ( F#"Cones")

--getCones (TropicalCycle):= C->( getCones(C#"Fan"))


getDim = method(TypicalValue => ZZ)

getDim (Fan) :=  F -> ( F#"Dim")

--getDim (tropicalCycle):= C->( getDim(C#"Fan"))


getFVector = method(TypicalValue => List)

getFVector (Fan) :=  F -> ( F#"FVector")

--getFVector (TropicalCycle):= C->( getFVector(C#"Fan"))





getLinealitySpace = method(TypicalValue => List)

getLinealitySpace (Fan) :=  F -> ( F#"LinealitySpace")

--getLinealitySpace (TropicalCycle):= C->( getLinealitySpace(C#"Fan"))




getMaximalCones = method(TypicalValue => List)

getMaximalCones (Fan) :=  F -> ( F#"MaximalCones")

--getMaximalCones (TropicalCycle):= C->( getMaximalCones(C#"Fan"))



getPure = method(TypicalValue => Boolean)

getPure (Fan) :=  F -> ( F#"Pure")

--getPure (TropicalCycle):= C->( getPure(C#"Fan"))



getSimplicial = method(TypicalValue => List)

getSimplicial (Fan) :=  F -> ( F#"Simplicial")

--getSimplicial (TropicalCycle):= C->( getSimplicial(C#"Fan"))




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
	(isWellDefined,TropicalCycle)
    Headline
	whether a tropical cycle is well defined.
    Usage
    	isWellDefined T
    Inputs
	T:TropicalCycle
    Outputs
    	B:Boolean
    Description
	Text
    	    A TropicalCycle is well defined if the underlying Fan is
    	    pure, and the multiplicity function makes the fan
    	    balanced.
      	Example
	    1+1	    
///

doc ///
    Key
	tropicalCycle
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
	    This method intersects a list of tropical hypersurfaces. The input is a list of polynomials whose 		    tropicalizations give the hypersurfaces.
        Example
	    QQ[x,y]
	    tropicalPrevariety{x+y+1, x+y}
            tropicalPrevariety({x+y+1,x+y},Strategy => "gfan")
///



doc///
    Key
      tropicalVariety    
      (tropicalVariety, Ideal)
      (tropicalVariety, Ideal, Boolean)
      [tropicalVariety, computeMultiplicities]
      [tropicalVariety, Prime]

    Headline
      the tropical variety associated to an ideal
    Usage
      tropicalVariety(I)
      tropicalVariety(I,IsHomogIdeal)
      tropicalVariety(I,computeMultiplicities=>true)
      tropicalVariety(I,Prime=>true)
    Inputs
      I:Ideal
        of polynomials
      IsHomogIdeal:Boolean
        a boolean that ensures whether the ideal is already homogeneous   
      computeMultiplicities =>Boolean
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
         By default it computes multiplicities but setting computeMultiplicities=>false
         turns this off.
	 The ideal I is not assumed to be homogeneous but with tropicalVariety(I,true)
	 the user can confirm it is homogeneous to the function does not check it.
	 
	 
      Example
       QQ[x,y,z]
       --I=ideal(x+y+1) 
       --tropicalVariety(I)
       --tropicalVariety(I,computeMultiplicities=>false)  
       J=ideal(x+y+z)
       tropicalVariety(J,true)
       tropicalVariety(J,true,computeMultiplicities=>false)
       K=ideal(x^2+y^2+z*y,(z+y)*(z^2+x^2))
       isPrime K
       tropicalVariety(K,true,Prime=>false)

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
	[tropicalPrevariety, Strategy]
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
	    isTropicalBasis({x+y+z,2*x+3*y-z})
	    isTropicalBasis(flatten entries gens Grassmannian (1,4,QQ[a..l]))
///


doc///
    Key
	getRays
	(getRays, Fan)
        getCones
	(getCones, Fan)
	getDim
	(getDim, Fan)
        getFVector
	(getFVector, Fan)
	getLinealitySpace
	(getLinealitySpace, Fan)
        getMaximalCones
	(getMaximalCones, Fan)
	getPure
	(getPure, Fan)
        getSimplicial
	(getSimplicial, Fan)
///



TEST ///
    assert (1+1==2)
    assert(isTropicalBasis (flatten entries gens Grassmannian(1,4,QQ[a..l] ))==true)
    assert(R:=QQ[x,y,z]; not isTropicalBasis({x+y+z,2*x+3*y-z}))
--Ther following two are commented until their functions can work in a computer without polymake
    --assert(isBalanced tropicalVariety (ideal {6*x^2+3*x*y+8*y^2+x*z+6*y*z+3*z^2+2*x*t+5*z*t+3*t^2,5*x^2+x*y+8*y^2+x*z+4*y*z+9*z^2+5*x*t+8*y*t+z*t}, true)) 
    --assert(R:=QQ[x,y,z,t]; I=ideal(x+y+z+t); J=ideal(4*x+y-2*z+5*t); 
	     stableIntersection(tropicalVariety(I, true),tropicalVariety(J, true))==tropicalVariety(ideal (I, J), true))
///    	    	
       
