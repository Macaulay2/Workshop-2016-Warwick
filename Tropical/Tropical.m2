needsPackage "PolyhedralObjects"
needsPackage "gfanInterface2"

newPackage(
	"gfanInterface2",
	Version => "0.1",
	Date => "May 2016"
	Authors => {
		{Name => "Mike Stillman", Email => "mike@math.cornell.edu", HomePage => ""},
		{Name => "Andrew Hoefel", Email => "andrew.hoefel@mathstat.dal.ca", HomePage =>"http://www.mast.queensu.ca/~ahhoefel/"}
		},
	Headline => "Interface to Anders Jensen's Gfan software",
	Configuration => {
		"path" => "",
		"fig2devpath" => "",
		"keepfiles" => false,
		"verbose" => false,
		"cachePolyhedralOutput" => true,
		"tropicalMax" => false
	},
	DebuggingMode => true
)

needsPackage "PolyhedralObjects"
needsPackage "gfanInterface2"

export {

}

