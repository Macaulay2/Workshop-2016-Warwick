needsPackage "PolyhedralObjects"
needsPackage "gfanInterface2"

newPackage(
    	"Tropical",
	Version => "0.1",
	Date => "May 2016",
	Authors => {
	    	{Name => "", Email => "", HomePage=>""},
	    	{Name => "", Email => "", HomePage=>""}
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




TEST ///
    assert (1==1)
///    	    	
       