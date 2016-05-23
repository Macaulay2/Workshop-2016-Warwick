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
  "tropicalPrevariety"
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


tropicalCycle = F->(
    
)    


isBalanced = F->(
    
)

isWellDefined = F ->(
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
  gfanTropicalIntersection(L, opts)
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

o
    Description
	Text
	    This method intersects a list of tropical hypersurfaces. The input is a list of polynomials whose 		    tropicalizations give the hypersurfaces.
        Example
	    QQ[x,y]
	    tropicalPrevariety{x+y+1, x+y}
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
       
