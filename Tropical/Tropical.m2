needsPackage "PolyhedralObjects"
needsPackage "gfanInterface2"

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
	DebuggingMode => true
)

needsPackage "PolyhedralObjects"
needsPackage "gfanInterface2"
needsPackage "SimpleDoc"

export {
  "tropicalCycle",
  "isBalanced",
  "tropicalPrevariety",
  "MaximalCones",
  "Multiplicities"
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
    if #F.MaximalCones != #mult then error("The multiplicity list has the wrong length");
    T := new TropicalCycle from F;
    T.Multiplicities = mult;
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
	"t" => false,
	"tplane" => false,
	"symmetryPrinting" => false,
	"symmetryExploit" => false,
	"restrict" => false,
	"stable" => false
	})
tropicalPrevariety (List) := (L) -> opts -> (
  F:=gfanTropicalIntersection(L, opts);G:=new Fan;
scan(keys F, a-> if a!="Multiplicities" then G#a=F#a); G
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




doc///
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
    Headline
	the intersection of the tropical hypersurfaces of polynomials in L
    Usage
	tropicalPrevariety(L)
    Inputs
	L:List
	    of polynomials
    Outputs
	F:List
	    the intersection of the tropical hypersurfaces of polynomials in L
    Description
	Text
	    This method intersects a list of tropical hypersurfaces. The input is a list of polynomials whose 		    tropicalizations give the hypersurfaces.
        Example
	    QQ[x,y]
	    tropicalPrevariety{x+y+1, x+y}
///









TEST ///
    assert (1==1)
///    	    	
       
