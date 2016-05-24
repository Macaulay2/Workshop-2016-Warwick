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



--Computing a tropical variety
opts= {
	Multiplicities=> true,
	Prime=> true
	}
tropicalVariety := opts >> o -> I -> (
	if (o.Multiplicities==true and o.Prime== true)
	then  gfanTropicalTraverse gfanTropicalStartingCone I
	else
	(if o.Multiplicities==false 
		then gfanTropicalBruteForce gfanBuchberger I
		else print  " Cannot compute multiplicities if ideal not prime"  ))







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
	    A TropicalCycle is well defined if the underlying Fan is pure, and the multiplicity function makes the fan balanced.
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



doc ///
     Key 
        tropicalVariety,
     Headline
        Computes the variety of an ideal
     Usage 
        F=tropicalVariety(I)
     Inputs 
          I:Ideal an homogeneous ideal
          
     Outputs 
          F:Fan
     Description
        Text       
      This function takes an ideal and computes its tropical variety. Multiplicities are computed by default but may be excluded to decrease computation time
     Example  
			QQ[x,y,z]
      		I=ideal(x+y+z)
			F=tropicalVariety (I)
			I=ideal(x^2+y^2+z*y,z*x+y^2)
			F=tropicalVariety(I,Multiplicities=>False)
			I=ideal(x^2+y^2+z*y,(z+y)*(z^2+x^2))
			F=tropicalVariety(I,Prime=>False)
      Text      
      In order to compute the multiplicities the ideal has to be prime
     
///





TEST ///
    assert (1==1)
///    	    	
       
