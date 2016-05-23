newPackage(
	"Tropical",
	Version => "0.1",
	Date => "May 2016",
	Headline => "Tropical",
	Configuration => {
		"path" => "",
		"fig2devpath" => "",
		"keepfiles" => false,
		"verbose" => true,
		"cachePolyhedralOutput" => true,
		"tropicalMax" => false
	},
	DebuggingMode => true
)

needsPackage "PolyhedralObjects"
needsPackage "gfanInterface2"

export {
  "tropicalIntersection"
}

tropicalIntersection = method(TypicalValue => List,  Options => {
	"t" => false,
	"tplane" => false,
	"symmetryPrinting" => false,
	"symmetryExploit" => false,
	"restrict" => false,
	"stable" => false
	})
tropicalIntersection (List) := (L) -> opts -> (
  gfanTropicalIntersection(L, opts)
)
