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
  "convertToPolymake"
}

------------------------------------------------------------------------------
-- CODE
------------------------------------------------------------------------------

--Setting up the data type TropicalCycle

TropicalCycle = new Type of Fan
TropicalCycle.synonym = "tropical cycle"
TropicalCycle.GlobalAssignHook = globalAssignFunction
TropicalCycle.GlobalReleaseHook = globalReleaseFunction


--basic operations on a toric cycle


tropicalCycle = (F,mult)->(
    if #F#"MaximalCones" != #mult then error("The multiplicity list has the wrong length");
    T := new TropicalCycle from F;
    T#"Multiplicities" = mult;
    return T
)    


isBalanced = F->(
    
)

isWellDefined TropicalCycle := Boolean =>
 F ->(
 -- Check that the fan is pure, and then call isBalanced   
)        





--Computing a tropical prevariety
tropicalPrevariety = method(TypicalValue => List,  Options => {
	Strategy=> "gfan"
	})

tropicalPrevariety (List) := o -> L -> (gfanopt:=(new OptionTable) ++ {"t" => false,"tplane" => false,"symmetryPrinting" => false,"symmetryExploit" => false,"restrict" => false,"stable" => false};
if (o.Strategy=="gfan") then (
  F:=gfanTropicalIntersection(L, gfanopt); G:=new Fan;
scan(keys F, a-> if a!="Multiplicities" then G#a=F#a); G)
else error "options not valid"
)
--Computing a tropical variety

tropicalVariety = method(TypicalValue => TropicalCycle,  Options => {
	computeMultiplicities => true,
	Prime => true
	})
tropicalVariety (Ideal,Boolean) := o -> (I,b)  -> (
    	if b==false then print "0"
	else
	       (if (o.computeMultiplicities==true and o.Prime== true)
		then (F:= gfanTropicalTraverse( gfanTropicalStartingCone I);
	            tropicalCycle(F,F#"Multiplicities"))
		else
		    (if o.computeMultiplicities==false 
		     then gfanTropicalBruteForce gfanBuchberger I
		     else print  " Cannot compute multiplicities if ideal not prime"  )))


stableIntersection = method(TypicalValue =>
TropicalCycle, Options => {Strategy=>"atint"})

stableIntersection (TropicalCycle, TropicalCycle) := (F,G) -> (
)    

convertToPolymake = (T) ->(
	str := "new Cycle<Min>";
--	str := tropicalMax;
	return str
) 
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
	F:List
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
	[tropicalVariety, computeMultiplicities]
	[tropicalVariety, Prime]

    Headline
	the tropical variety associated to an ideal
    Usage
	tropicalVariety(I)
	tropicalVariety(I,computeMultiplicities=>true)
	tropicalVariety(I,Prime=>true)
    Inputs
	I:Ideal
	    of polynomials
	computeMultiplicities =>Boolean
	Prime=>Boolean
    Outputs
        F:TropicalCycle
    Description 
    	Text
	   This method takes an ideal and computes the tropical variety associated to it. 
	   By default the ideal is assumed to be prime, however inputting a non prime ideal  will not give all tropical variety.
	   In this case use optional inputs Prime=>false.
	   By default it computes multiplicities but setting computeMultiplicities=>false
	   turns this off to decrease computation time.
	Example
	   QQ[x,y,z]
	   I=ideal(x+y+z)
	   tropicalVariety(I)
	   tropicalVariety(I,computeMultiplicities=>false)
	   J=ideal(x^2+y^2+z*y,(z+y)*(z^2+x^2))
	   isPrime J
           tropicalVariety(J,Prime=>false)

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






TEST ///
    assert (1+1==2)
///    	    	
       
