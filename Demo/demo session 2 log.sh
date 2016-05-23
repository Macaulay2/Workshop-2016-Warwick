
+ M2 --no-readline --print-width 108
Macaulay2, version 1.9
with packages: ConwayPolynomials, Elimination, IntegralClosure, LLLBases, PrimaryDecomposition, ReesAlgebra,
               TangentCone

i1 : loadPackage "Foo"
stdio:1:1:(3): error: file not found on path: "Foo.m2"

i2 : loadPackage "ResidualIntersections"
stdio:2:1:(3): error: file not found on path: "ResidualIntersections.m2"

i3 : path

o3 = {./, Library/Application Support/Macaulay2/code/, Library/Application
     -------------------------------------------------------------------------------------------------------
     Support/Macaulay2/local/share/Macaulay2/, Library/Application
     -------------------------------------------------------------------------------------------------------
     Support/Macaulay2/local/common/share/Macaulay2/, /Applications/Macaulay2-1.9/share/Macaulay2/}

o3 : List

i4 : path = prepend ( "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/", path )

o4 = {/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/, ./, Library/Application Support/Macaulay2/code/,
     -------------------------------------------------------------------------------------------------------
     Library/Application Support/Macaulay2/local/share/Macaulay2/, Library/Application
     -------------------------------------------------------------------------------------------------------
     Support/Macaulay2/local/common/share/Macaulay2/, /Applications/Macaulay2-1.9/share/Macaulay2/}

o4 : List

i5 : loadPackage "ResidualIntersections"
/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2:311:1:(3):[7]: error: unrecognized keyword, line 7 of string: "Definition: If I \\subset S is an ideal in a polynomial ring (or Gorenstein ring) and"; expected: CannedExample Code Example Pre Text
/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2:311:1:(3):[7]: --entering debugger (type help to see debugger commands)
/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2:311:1-311:1: --source code:
doc ///

ii6 : 

i7 : applicationDirectory()

o7 = /Users/dan/Library/Application Support/Macaulay2/

i8 : restart
Macaulay2, version 1.9
with packages: ConwayPolynomials, Elimination, IntegralClosure, LLLBases, PrimaryDecomposition, ReesAlgebra,
               TangentCone

i1 : path

o1 = {/Users/dan/Library/Application Support/Macaulay2/, ./, Library/Application Support/Macaulay2/code/,
     -------------------------------------------------------------------------------------------------------
     Library/Application Support/Macaulay2/local/share/Macaulay2/, Library/Application
     -------------------------------------------------------------------------------------------------------
     Support/Macaulay2/local/common/share/Macaulay2/, /Applications/Macaulay2-1.9/share/Macaulay2/}

o1 : List

i2 : restart
Macaulay2, version 1.9
with packages: ConwayPolynomials, Elimination, IntegralClosure, LLLBases, PrimaryDecomposition, ReesAlgebra,
               TangentCone

i1 : path

o1 = {/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/, ./, Library/Application Support/Macaulay2/code/,
     -------------------------------------------------------------------------------------------------------
     Library/Application Support/Macaulay2/local/share/Macaulay2/, Library/Application
     -------------------------------------------------------------------------------------------------------
     Support/Macaulay2/local/common/share/Macaulay2/, /Applications/Macaulay2-1.9/share/Macaulay2/}

o1 : List

i2 : {}|{}

o2 = {}

o2 : List

i3 : restart
Macaulay2, version 1.9
with packages: ConwayPolynomials, Elimination, IntegralClosure, LLLBases, PrimaryDecomposition, ReesAlgebra,
               TangentCone

i1 : path

o1 = {/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/, ./, Library/Application Support/Macaulay2/code/,
     -------------------------------------------------------------------------------------------------------
     Library/Application Support/Macaulay2/local/share/Macaulay2/, Library/Application
     -------------------------------------------------------------------------------------------------------
     Support/Macaulay2/local/common/share/Macaulay2/, /Applications/Macaulay2-1.9/share/Macaulay2/}

o1 : List

i2 : options loadPackage 

o2 = OptionTable{Configuration => {}       }
                 DebuggingMode => null
                 FileName => null
                 LoadDocumentation => false
                 Reload => null

o2 : OptionTable

i3 : loadPackage ( "Foo", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2" )
/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2:311:1:(3):[7]: error: unrecognized keyword, line 7 of string: "Definition: If I \\subset S is an ideal in a polynomial ring (or Gorenstein ring) and"; expected: CannedExample Code Example Pre Text
/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2:311:1:(3):[7]: --entering debugger (type help to see debugger commands)
/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2:311:1-311:1: --source code:
doc ///

ii4 : restart
Macaulay2, version 1.9
with packages: ConwayPolynomials, Elimination, IntegralClosure, LLLBases, PrimaryDecomposition, ReesAlgebra,
               TangentCone

i1 : loadPackage ( "Foo", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2" )
stdio:1:1:(3): error: the file /private/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2 did not define a package called Foo

i2 : loadPackage ( "ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2" )

o2 = ResidualIntersections

o2 : Package

i3 : loadPackage ( "ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2" )

o3 = ResidualIntersections

o3 : Package

i4 : notify = true

o4 = true

i5 : loadPackage ( "ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2" )
--database not present: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/ResidualIntersections/cache/rawdocumentation-dcba-8.db
--package "ResidualIntersections" loaded
--loaded /tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2

o5 = ResidualIntersections

o5 : Package

i6 : loadPackage ( "ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2" )
--database not present: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/ResidualIntersections/cache/rawdocumentation-dcba-8.db
--package "ResidualIntersections" loaded
--loaded /tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2

o6 = ResidualIntersections

o6 : Package

i7 : needsPackage ( "ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2" )

o7 = ResidualIntersections

o7 : Package

i8 : restart
Macaulay2, version 1.9
with packages: ConwayPolynomials, Elimination, IntegralClosure, LLLBases, PrimaryDecomposition, ReesAlgebra,
               TangentCone

i1 : needsPackage ( "ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2" )

o1 = ResidualIntersections

o1 : Package

i2 : restart
Macaulay2, version 1.9
with packages: ConwayPolynomials, Elimination, IntegralClosure, LLLBases, PrimaryDecomposition, ReesAlgebra,
               TangentCone

i1 : notify = true

o1 = true

i2 : needsPackage ( "ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2" )
--database not present: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/ResidualIntersections/cache/rawdocumentation-dcba-8.db
--package "ResidualIntersections" loaded
--loaded /tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2

o2 = ResidualIntersections

o2 : Package

i3 : needsPackage ( "ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2" )

o3 = ResidualIntersections

o3 : Package

i4 : installPackage "ResidualIntersections"
--database not present: Library/Application Support/Macaulay2/local/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Macaulay2Doc/cache/rawdocumentation-dcba-8.db
--beginDocumentation: reading the rest of Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc.m2
--loading the Macaulay2 documentation from Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc1.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc2.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc3.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc4.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc5.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc6.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc7.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc8.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc9.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc10.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc11.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc12.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc13.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc14.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/changes.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/overviewA.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/overviewB.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/overviewC.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/overview2.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/overview3.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/overview4.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/macaulay.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc_packages.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/AdjointIdeal/cache/rawdocumentation-dcba-8.db
--loading configuration for package "MapleInterface" from file /Users/dan/Library/Application Support/Macaulay2/init-MapleInterface.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/MapleInterface/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/MapleInterface.m2
--package "MapleInterface" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/MapleInterface.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/AdjointIdeal.m2
--package "AdjointIdeal" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/AdjointIdeal.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/AnalyzeSheafOnP1/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/AnalyzeSheafOnP1.m2
--package "AnalyzeSheafOnP1" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/AnalyzeSheafOnP1.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/BeginningMacaulay2/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/BeginningMacaulay2.m2
--package "BeginningMacaulay2" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/BeginningMacaulay2.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Benchmark/cache/rawdocumentation-dcba-8.db
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/XML/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/XML.m2
--package "XML" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/XML.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Benchmark.m2
--package "Benchmark" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Benchmark.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/NAGtypes/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/NAGtypes.m2
--package "NAGtypes" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NAGtypes.m2
--loading configuration for package "Bertini" from file /Users/dan/Library/Application Support/Macaulay2/init-Bertini.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Bertini/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Bertini.m2
--package "Bertini" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Bertini.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/BoijSoederberg/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/BoijSoederberg.m2
--package "BoijSoederberg" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/BoijSoederberg.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/BGG/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/BGG.m2
--package "BGG" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/BGG.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/BIBasis/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/BIBasis.m2
--package "BIBasis" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/BIBasis.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/BinomialEdgeIdeals/cache/rawdocumentation-dcba-8.db
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/SimplicialComplexes/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/SimplicialComplexes.m2
--package "SimplicialComplexes" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/SimplicialComplexes.m2
--loading configuration for package "Graphs" from file /Users/dan/Library/Application Support/Macaulay2/init-Graphs.m2
--opened database: Library/Application Support/Macaulay2/local/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Graphs/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of Library/Application Support/Macaulay2/local/share/Macaulay2/Graphs.m2
--package "Graphs" loaded
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Graphs.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Binomials/cache/rawdocumentation-dcba-8.db
--loading configuration for package "FourTiTwo" from file /Users/dan/Library/Application Support/Macaulay2/init-FourTiTwo.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/FourTiTwo/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/FourTiTwo.m2
--package "FourTiTwo" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/FourTiTwo.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Cyclotomic/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Cyclotomic.m2
--package "Cyclotomic" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Cyclotomic.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Binomials.m2
--package "Binomials" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Binomials.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/BinomialEdgeIdeals.m2
--package "BinomialEdgeIdeals" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/BinomialEdgeIdeals.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Schubert2/cache/rawdocumentation-dcba-8.db
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/SchurRings/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/SchurRings.m2
--package "SchurRings" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/SchurRings.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/PushForward/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/PushForward.m2
--package "PushForward" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/PushForward.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Schubert2.m2
--package "Schubert2" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Schubert2.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Book3264Examples/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Book3264Examples.m2
--package "Book3264Examples" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Book3264Examples.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/BooleanGB/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/BooleanGB.m2
--package "BooleanGB" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/BooleanGB.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Browse/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Browse.m2
--package "Browse" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Browse.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Bruns/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Bruns.m2
--package "Bruns" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Bruns.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/ChainComplexExtras/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/ChainComplexExtras.m2
--package "ChainComplexExtras" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/ChainComplexExtras.m2
--loading configuration for package "CharacteristicClasses" from file /Users/dan/Library/Application Support/Macaulay2/init-CharacteristicClasses.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/CharacteristicClasses/cache/rawdocumentation-dcba-8.db
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Polyhedra/cache/rawdocumentation-dcba-8.db
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/FourierMotzkin/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/FourierMotzkin.m2
--package "FourierMotzkin" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/FourierMotzkin.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Polyhedra.m2
--package "Polyhedra" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Polyhedra.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/NormalToricVarieties/cache/rawdocumentation-dcba-8.db
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Normaliz/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Normaliz.m2
--package "Normaliz" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Normaliz.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/NormalToricVarieties.m2
--package "NormalToricVarieties" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NormalToricVarieties.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/CharacteristicClasses.m2
--package "CharacteristicClasses" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/CharacteristicClasses.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/CodepthThree/cache/rawdocumentation-dcba-8.db
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/LocalRings/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/LocalRings.m2
--package "LocalRings" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/LocalRings.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/CodepthThree.m2
--package "CodepthThree" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/CodepthThree.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/MCMApproximations/cache/rawdocumentation-dcba-8.db
--package "MCMApproximations" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/MCMApproximations.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/CompleteIntersectionResolutions/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/CompleteIntersectionResolutions.m2
--package "CompleteIntersectionResolutions" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/CompleteIntersectionResolutions.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/LieTypes/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/LieTypes.m2
--package "LieTypes" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/LieTypes.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/ConformalBlocks/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/ConformalBlocks.m2
--package "ConformalBlocks" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/ConformalBlocks.m2
--loading configuration for package "ConvexInterface" from file /Users/dan/Library/Application Support/Macaulay2/init-ConvexInterface.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/ConvexInterface/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/ConvexInterface.m2
--package "ConvexInterface" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/ConvexInterface.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Cremona/cache/rawdocumentation-dcba-8.db
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Parametrization/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Parametrization.m2
--package "Parametrization" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Parametrization.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Cremona.m2
--package "Cremona" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Cremona.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Depth/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Depth.m2
--package "Depth" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Depth.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/DGAlgebras/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/DGAlgebras.m2
--package "DGAlgebras" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/DGAlgebras.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Divisor/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Divisor.m2
--package "Divisor" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Divisor.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Dmodules/cache/rawdocumentation-dcba-8.db
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/Dbasic.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/Gbw.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/Dsystems.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/switch.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/newRings.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/Dresolution.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/Drestriction.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/Sparsemat.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/Dlocalize.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/WeylClosure.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/Ddual.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/DHom.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/DeRham.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/DiffOps.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/bFunction.ideal.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/globalBFunction.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/annFs.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/bFunction.module.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/localCohom.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/paramBpoly.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/makeCyclic.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/stafford.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/CC.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/localBFunction.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/multiplierIdeals.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/Dloadfile.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/./Dmodules/Dmodules.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules/Dmodules.m2
--package "Dmodules" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Dmodules.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/EdgeIdeals/cache/rawdocumentation-dcba-8.db
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/GenericInitialIdeal/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/GenericInitialIdeal.m2
--package "GenericInitialIdeal" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/GenericInitialIdeal.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/EdgeIdeals.m2
--package "EdgeIdeals" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/EdgeIdeals.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/EliminationMatrices/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/EliminationMatrices.m2
--package "EliminationMatrices" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/EliminationMatrices.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/EllipticCurves/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/EllipticCurves.m2
--package "EllipticCurves" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/EllipticCurves.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/EllipticIntegrals/cache/rawdocumentation-dcba-8.db
--package "EllipticIntegrals" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/EllipticIntegrals.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/EnumerationCurves/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/EnumerationCurves.m2
--package "EnumerationCurves" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/EnumerationCurves.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/FiniteFittingIdeals/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/FiniteFittingIdeals.m2
--package "FiniteFittingIdeals" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/FiniteFittingIdeals.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/FirstPackage/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/FirstPackage.m2
--package "FirstPackage" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/FirstPackage.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/FormalGroupLaws/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/FormalGroupLaws.m2
--package "FormalGroupLaws" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/FormalGroupLaws.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Polymake/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Polymake.m2
--package "Polymake" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Polymake.m2
--loading configuration for package "gfanInterface" from file /Users/dan/Library/Application Support/Macaulay2/init-gfanInterface.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/gfanInterface/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/gfanInterface.m2
--package "gfanInterface" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/gfanInterface.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/GraphicalModels/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/GraphicalModels.m2
--package "GraphicalModels" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/GraphicalModels.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Graphics/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Graphics.m2
--package "Graphics" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Graphics.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/HigherCIOperators/cache/rawdocumentation-dcba-8.db
--package "HigherCIOperators" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/HigherCIOperators.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/WeylGroups/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/WeylGroups.m2
--package "WeylGroups" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/WeylGroups.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/HighestWeights/cache/rawdocumentation-dcba-8.db
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/HighestWeights/freudenthal.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/HighestWeights/main.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/HighestWeights.m2
--package "HighestWeights" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/HighestWeights.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/HodgeIntegrals/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/HodgeIntegrals.m2
--package "HodgeIntegrals" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/HodgeIntegrals.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/HyperplaneArrangements/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/HyperplaneArrangements.m2
--package "HyperplaneArrangements" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/HyperplaneArrangements.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/InvariantRing/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/InvariantRing.m2
--package "InvariantRing" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/InvariantRing.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/InvolutiveBases/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/InvolutiveBases.m2
--package "InvolutiveBases" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/InvolutiveBases.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Kronecker/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Kronecker.m2
--package "Kronecker" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Kronecker.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/KustinMiller/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/KustinMiller.m2
--package "KustinMiller" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/KustinMiller.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/LatticePolytopes/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/LatticePolytopes.m2
--package "LatticePolytopes" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/LatticePolytopes.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/LexIdeals/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/LexIdeals.m2
--package "LexIdeals" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/LexIdeals.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/M0nbar/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/M0nbar.m2
--package "M0nbar" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/M0nbar.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Markov/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Markov.m2
--package "Markov" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Markov.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/MinimalPrimes/cache/rawdocumentation-dcba-8.db
warning!  This package is experimental.  The interface will change, and although
  it passes its tests, it has not been fully debugged yet!
  In particular, in small characteristic, it *sometimes* might miss a component
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/MinimalPrimes/quickGB.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/MinimalPrimes/factorTower.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/MinimalPrimes/tests.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/MinimalPrimes.m2
--package "MinimalPrimes" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/MinimalPrimes.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Miura/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Miura.m2
--package "Miura" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Miura.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/ModuleDeformations/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/ModuleDeformations.m2
--package "ModuleDeformations" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/ModuleDeformations.m2
--loading configuration for package "MonomialAlgebras" from file /Users/dan/Library/Application Support/Macaulay2/init-MonomialAlgebras.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/MonomialAlgebras/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/MonomialAlgebras.m2
--package "MonomialAlgebras" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/MonomialAlgebras.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/MultiplierIdeals/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/MultiplierIdeals.m2
--package "MultiplierIdeals" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/MultiplierIdeals.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/MultiplierIdealsDim2/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/MultiplierIdealsDim2.m2
--package "MultiplierIdealsDim2" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/MultiplierIdealsDim2.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/MultipolynomialResultants/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/MultipolynomialResultants.m2
--package "MultipolynomialResultants" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/MultipolynomialResultants.m2
--loading configuration for package "Nauty" from file /Users/dan/Library/Application Support/Macaulay2/init-Nauty.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Nauty/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Nauty.m2
--package "Nauty" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Nauty.m2
--loading configuration for package "NautyGraphs" from file /Users/dan/Library/Application Support/Macaulay2/init-NautyGraphs.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/NautyGraphs/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/NautyGraphs.m2
--package "NautyGraphs" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NautyGraphs.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/NoetherNormalization/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/NoetherNormalization.m2
--package "NoetherNormalization" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NoetherNormalization.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/NumericalHilbert/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/NumericalHilbert.m2
--package "NumericalHilbert" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalHilbert.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/SLPexpressions/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/SLPexpressions.m2
--package "SLPexpressions" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/SLPexpressions.m2
--loading configuration for package "NumericalAlgebraicGeometry" from file /Users/dan/Library/Application Support/Macaulay2/init-NumericalAlgebraicGeometry.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/NumericalAlgebraicGeometry/cache/rawdocumentation-dcba-8.db
--loading configuration for package "PHCpack" from file /Users/dan/Library/Application Support/Macaulay2/init-PHCpack.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/PHCpack/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/PHCpack.m2
--package "PHCpack" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/PHCpack.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry/PHCpack/PHCpack.interface.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry/Bertini/Bertini.interface.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry/extraNAGtypes.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry/track.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry/refine.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry/BSS-certified.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry/0-dim-methods.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry/witness-set.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry/intersection.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry/decomposition.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry/positive-dim-methods.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry/deflation.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry/SLP.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry/npd.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/./NumericalAlgebraicGeometry/polynomial-space.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry/polynomial-space.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry.m2
--package "NumericalAlgebraicGeometry" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalAlgebraicGeometry.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/NumericalSchubertCalculus/cache/rawdocumentation-dcba-8.db
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalSchubertCalculus/PHCpack-LRhomotopies.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalSchubertCalculus/pieri.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalSchubertCalculus/service-functions.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalSchubertCalculus/galois.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalSchubertCalculus/LR-resolveNode.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalSchubertCalculus/LR-makePolynomials.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalSchubertCalculus/LR-ParameterHomotopy.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/NumericalSchubertCalculus.m2
--package "NumericalSchubertCalculus" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/NumericalSchubertCalculus.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/OpenMath/cache/rawdocumentation-dcba-8.db
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/OMattr.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/OMelts.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/OMrefs.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/base.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/expr.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/finitefield.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/arith1.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/field3.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/field4.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/fieldname1.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/finfield1.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/fns1.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/integer1.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/integer2.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/linalg1.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/linalg2.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/list1.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/logic1.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/nums1.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/polygb1.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/polygb2.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/polyd1.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/polyd2.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/polynomial4.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/relation1.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/scscp1.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/scscp2.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/set1.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/setname1.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/setname2.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath/cds/scscp_transient_1.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath.m2
--package "OpenMath" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/OpenMath.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/PackageTemplate/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/PackageTemplate.m2
--package "PackageTemplate" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/PackageTemplate.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Permanents/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Permanents.m2
--package "Permanents" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Permanents.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/PieriMaps/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/PieriMaps.m2
--package "PieriMaps" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/PieriMaps.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Points/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Points.m2
--package "Points" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Points.m2
--loading configuration for package "Posets" from file /Users/dan/Library/Application Support/Macaulay2/init-Posets.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Posets/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Posets.m2
--package "Posets" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Posets.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/QthPower/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/QthPower.m2
--package "QthPower" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/QthPower.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/QuillenSuslin/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/QuillenSuslin.m2
--package "QuillenSuslin" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/QuillenSuslin.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/RandomObjects/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/RandomObjects.m2
--package "RandomObjects" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/RandomObjects.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/RandomCanonicalCurves/cache/rawdocumentation-dcba-8.db
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/RandomSpaceCurves/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/RandomSpaceCurves.m2
--package "RandomSpaceCurves" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/RandomSpaceCurves.m2
--opened database: Library/Application Support/Macaulay2/local/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/RandomPlaneCurves/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of Library/Application Support/Macaulay2/local/share/Macaulay2/RandomPlaneCurves.m2
--package "RandomPlaneCurves" loaded
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/RandomPlaneCurves.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/RandomGenus14Curves/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/RandomGenus14Curves.m2
--package "RandomGenus14Curves" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/RandomGenus14Curves.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/RandomCanonicalCurves.m2
--package "RandomCanonicalCurves" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/RandomCanonicalCurves.m2
--opened database: Library/Application Support/Macaulay2/local/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/RandomCurves/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of Library/Application Support/Macaulay2/local/share/Macaulay2/RandomCurves.m2
--package "RandomCurves" loaded
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/RandomCurves.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/RandomIdeal/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/RandomIdeal.m2
--package "RandomIdeal" loaded
--loaded /tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/RandomIdeal.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/RationalPoints/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/RationalPoints.m2
--package "RationalPoints" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/RationalPoints.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Regularity/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Regularity.m2
--package "Regularity" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Regularity.m2
--loading configuration for package "RunExternalM2" from file /Users/dan/Library/Application Support/Macaulay2/init-RunExternalM2.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/RunExternalM2/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/RunExternalM2.m2
--package "RunExternalM2" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/RunExternalM2.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/SchurFunctors/cache/rawdocumentation-dcba-8.db
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/SymmetricPolynomials/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/SymmetricPolynomials.m2
--package "SymmetricPolynomials" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/SymmetricPolynomials.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/SchurFunctors.m2
--package "SchurFunctors" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/SchurFunctors.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/SCSCP/cache/rawdocumentation-dcba-8.db
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/SCSCP/remobjs.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/SCSCP/client.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/SCSCP/server.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/SCSCP/expr.m2
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/./SCSCP/docs.m2
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/SCSCP/docs.m2
--package "SCSCP" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/SCSCP.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Serialization/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Serialization.m2
--package "Serialization" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Serialization.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/SimplicialDecomposability/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/SimplicialDecomposability.m2
--package "SimplicialDecomposability" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/SimplicialDecomposability.m2
--loading configuration for package "SRdeformations" from file /Users/dan/Library/Application Support/Macaulay2/init-SRdeformations.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/SRdeformations/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/SRdeformations.m2
--package "SRdeformations" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/SRdeformations.m2
--loading configuration for package "StatePolytope" from file /Users/dan/Library/Application Support/Macaulay2/init-StatePolytope.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/StatePolytope/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/StatePolytope.m2
--package "StatePolytope" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/StatePolytope.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Style/cache/rawdocumentation-dcba-8.db
--package "Style" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Style.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/TateOnProducts/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/TateOnProducts.m2
--package "TateOnProducts" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/TateOnProducts.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/TensorComplexes/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/TensorComplexes.m2
--package "TensorComplexes" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/TensorComplexes.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/ToricTopology/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/ToricTopology.m2
--package "ToricTopology" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/ToricTopology.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/ToricVectorBundles/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/ToricVectorBundles.m2
--package "ToricVectorBundles" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/ToricVectorBundles.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Triplets/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Triplets.m2
--package "Triplets" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Triplets.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/Units/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/Units.m2
--package "Units" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/Units.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/VectorFields/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/VectorFields.m2
--package "VectorFields" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/VectorFields.m2
--loading configuration for package "VersalDeformations" from file /Users/dan/Library/Application Support/Macaulay2/init-VersalDeformations.m2
--opened database: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/VersalDeformations/cache/rawdocumentation-dcba-8.db
--beginDocumentation: using documentation database, skipping the rest of /Applications/Macaulay2-1.9/share/Macaulay2/VersalDeformations.m2
--package "VersalDeformations" loaded
--loaded /Applications/Macaulay2-1.9/share/Macaulay2/VersalDeformations.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/overview_packages.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc_doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/overview_doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc_ideals.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/overview_modules.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc_mutablematrices.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc_ringmaps.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc_assignment.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/ov_top.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/ov_getting_started.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/ov_ideals.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/ov_ringmaps.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/ov_matrices.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/ov_language.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/ov_files.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/threads.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc_lists.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/doc_strings.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/operators/dotdot.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/sublists-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/monomorderings.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/groebner.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/antipode-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/symbol-percent-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/symbol-underscore-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/LU-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/cpuTime-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/independentSets-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/primaryDecomposition-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/diagonalMatrix-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/dismiss-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/monomials-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/reduceHilbert-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/GF-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/Grassmannian-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/Hom-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/SVD-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/addEndFunction-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/addStartFunction-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/all-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/ambient-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/ann-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/any-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/append-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/apply-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/applyKeys-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/applyPairs-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/applyValues-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/apropos-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/atan-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/basis-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/betti-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/between-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/binomial-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/ceiling-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/chainComplex-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/char-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/characters-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/check-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/class-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/endPackage-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/clean-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/codim-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/coefficientRing-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/coefficient-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/coefficients-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/cohomology-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/HH-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/coimage-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/cokernel-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/comodule-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/compositions-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/compress-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/cos-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/cotangentSheaf-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/decompose-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/degree-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/degreeLength-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/degrees-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/degreesRing-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/denominator-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/det-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/permanents-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/dim-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/eigenvalues-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/eigenvectors-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/elements-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/entries-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/euler-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/examples-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/fileExists-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/fileTime-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/findFiles-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/findSynonyms-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/flattenRing-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/floor-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/forceGB-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/frac-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/fromDual-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/gb-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/gbRemove-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/gbSnapshot-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/genera-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/generators-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/genericMatrix-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/genericSkewMatrix-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/genericSymmetricMatrix-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/genus-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/getNonUnit-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/graphIdeal-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/graphRing-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/hilbertFunction-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/hilbertPolynomial-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/hilbertSeries-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/homology-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/ideal-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/index-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/indices-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/installAssignmentMethod-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/installHilbertFunction-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/installPackage-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/uninstallPackage-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/intersect-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/irreducibleCharacteristicSeries-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isAffineRing-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isCommutative-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isDirectory-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isField-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isFreeModule-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isGlobalSymbol-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isHomogeneous-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isIdeal-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isInjective-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isModule-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isMonomialIdeal-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isPolynomialRing-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isPrime-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isQuotientModule-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isQuotientRing-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isRegularFile-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isRing-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isSkewCommutative-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isSquareFree-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isSubmodule-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isSubset-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isUnit-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/isWellDefined-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/kernel-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/koszul-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/lift-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/liftable-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/map-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/nextPrime-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/replace-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/match-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/regex-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/mathML-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/matrix-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/member-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/method-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/mingens-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/minimalPresentation-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/minors-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/monoid-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/monomialIdeal-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/net-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/nonminimalBetti-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/nonminimalResolution-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/numerator-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/numgens-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/part-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/partition-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/pdim-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/peek-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/pfaffians-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/pivots-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/poincare-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/poincareN-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/prepend-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/presentation-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/promote-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/pseudoRemainder-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/pushForward-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/pushForward1-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/quotient-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/radical-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/rank-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/readDirectory-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/readlink-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/realpath-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/recursionDepth-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/registerFinalizer-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/regularity-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/removeDirectory-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/removeLowestDimension-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/ring-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/rsort-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/saturate-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/schreyerOrder-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/select-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/showTex-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/sin-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/sinh-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/solve-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/someTerms-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/sort-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/sortColumns-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/source-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/standardPairs-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/submatrixByDegrees-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/subquotient-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/support-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/symmetricAlgebra-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/syz-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/tan-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/tangentSheaf-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/tanh-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/target-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/tensor-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/terms-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/tex-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/texMath-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/toDual-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/toExternalString-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/toField-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/toString-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/top-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/topCoefficients-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/transpose-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/trim-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/truncate-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/uniform-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/use-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/variety-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/vars-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/wedgeProduct-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions/weightRange-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/functions.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/variables/commandLine-doc.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/variables.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/M2-Singular-Book.m2
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc/loads.m2
--package "Macaulay2Doc" loaded
--loaded Library/Application Support/Macaulay2/local/share/Macaulay2/Macaulay2Doc.m2
--database not present: /Applications/Macaulay2-1.9/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/ResidualIntersections/cache/rawdocumentation-dcba-8.db
--package "ResidualIntersections" loaded
--loaded /tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2
--installing package ResidualIntersections in Library/Application Support/Macaulay2/local/
--using package sources found in /tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/
--storing raw documentation in Library/Application Support/Macaulay2/local/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/ResidualIntersections/cache/rawdocumentation-dcba-8.db
--running tests that are functions
--making example result files in Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/
--making example results for maxGs in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_max__Gs.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/2-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/1_max__Gs.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_max__Gs.errors" 2>&1
--making example results for koszulDepth in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_koszul__Depth.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/3-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/1_koszul__Depth.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_koszul__Depth.errors" 2>&1
--making example results for isLicci in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_is__Licci.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/4-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/1_is__Licci.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_is__Licci.errors" 2>&1
--making example results for depthsOfPowers in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_depths__Of__Powers.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/5-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/1_depths__Of__Powers.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_depths__Of__Powers.errors" 2>&1
--making example results for isStronglyCM in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_is__Strongly__C__M.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/6-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/1_is__Strongly__C__M.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_is__Strongly__C__M.errors" 2>&1
--making example results for genericArtinNagata in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_generic__Artin__Nagata.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/7-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/1_generic__Artin__Nagata.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_generic__Artin__Nagata.errors" 2>&1
--making example results for numgensByCodim in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_numgens__By__Codim.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/8-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/1_numgens__By__Codim.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_numgens__By__Codim.errors" 2>&1
--making example results for residualCodims in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_residual__Codims.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/9-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/1_residual__Codims.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_residual__Codims.errors" 2>&1
--making example results for hasSlidingDepth in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_has__Sliding__Depth.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/10-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/1_has__Sliding__Depth.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_has__Sliding__Depth.errors" 2>&1
--processing documentation nodes...
--assembling table of contents
--making info file in Library/Application Support/Macaulay2/local/share/info/ResidualIntersections.info.tmp
--completed info file moved to Library/Application Support/Macaulay2/local/share/info/ResidualIntersections.info
--making empty html pages in Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/html/
--making html pages in Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/html/
--warning: tag has no documentation: ResidualIntersections :: isLicci(..., Verbose => ...), key [isLicci,Verbose]
--making 'ResidualIntersections : Index' in Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/html/master.html
--making  ResidualIntersections : Table of Contents' in Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/html/toc.html
--file created: Library/Application Support/Macaulay2/local/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/ResidualIntersections/.installed
--installed package ResidualIntersections in Library/Application Support/Macaulay2/local/
--making index of installed packages in /Users/dan/Library/Application Support/Macaulay2/index.html

i5 : uninstallAllPackages (0
     

i5 : uninstallAllPackages ()
-- uninstalling package Graphs
-- uninstalling package Macaulay2Doc
-- uninstalling package RandomCurves
-- uninstalling package RandomPlaneCurves
-- uninstalling package ResidualIntersections

i6 : restart
Macaulay2, version 1.9
with packages: ConwayPolynomials, Elimination, IntegralClosure, LLLBases, PrimaryDecomposition, ReesAlgebra,
               TangentCone

i1 : installPackage "ResidualIntersections"
--installing package ResidualIntersections in Library/Application Support/Macaulay2/local/
--using package sources found in /tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/
--storing raw documentation in Library/Application Support/Macaulay2/local/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/ResidualIntersections/cache/rawdocumentation-dcba-8.db
--running tests that are functions
--making example result files in Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/
--making example results for maxGs in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_max__Gs.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/1-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/0_max__Gs.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_max__Gs.errors" 2>&1
--making example results for koszulDepth in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_koszul__Depth.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/2-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/0_koszul__Depth.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_koszul__Depth.errors" 2>&1
--making example results for isLicci in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_is__Licci.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/3-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/0_is__Licci.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_is__Licci.errors" 2>&1
--making example results for depthsOfPowers in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_depths__Of__Powers.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/4-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/0_depths__Of__Powers.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_depths__Of__Powers.errors" 2>&1
--making example results for isStronglyCM in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_is__Strongly__C__M.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/5-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/0_is__Strongly__C__M.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_is__Strongly__C__M.errors" 2>&1
--making example results for genericArtinNagata in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_generic__Artin__Nagata.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/6-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/0_generic__Artin__Nagata.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_generic__Artin__Nagata.errors" 2>&1
--making example results for numgensByCodim in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_numgens__By__Codim.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/7-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/0_numgens__By__Codim.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_numgens__By__Codim.errors" 2>&1
--making example results for residualCodims in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_residual__Codims.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/8-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/0_residual__Codims.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_residual__Codims.errors" 2>&1
--making example results for hasSlidingDepth in file Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_has__Sliding__Depth.out
ulimit -t 700; ulimit -m 850000; ulimit -v 850000; ulimit -s 8192; cd /var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/9-rundir/; /Applications/Macaulay2-1.9/bin/M2-binary --silent --print-width 77 --stop --int --no-readline --no-randomize -e 'needsPackage("ResidualIntersections", FileName => "/tmp/demo/Workshop-2016-Warwick-2/RandomIdeals/ResidualIntersections.m2")' <"/var/folders/46/9b86vqxj4hjcngvy7kd7sb140000gn/T/M2-99082-0/0_has__Sliding__Depth.m2" >>"/Users/dan/Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/example-output/_has__Sliding__Depth.errors" 2>&1
--processing documentation nodes...
--assembling table of contents
--making info file in Library/Application Support/Macaulay2/local/share/info/ResidualIntersections.info.tmp
--completed info file moved to Library/Application Support/Macaulay2/local/share/info/ResidualIntersections.info
--making empty html pages in Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/html/
--making html pages in Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/html/
--warning: tag has no documentation: ResidualIntersections :: isLicci(..., Verbose => ...), key [isLicci,Verbose]
--making 'ResidualIntersections : Index' in Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/html/master.html
--making  ResidualIntersections : Table of Contents' in Library/Application Support/Macaulay2/local/share/doc/Macaulay2/ResidualIntersections/html/toc.html
--file created: Library/Application Support/Macaulay2/local/lib/Macaulay2/x86_64-Darwin-MacOS-10.11.3/ResidualIntersections/.installed
--installed package ResidualIntersections in Library/Application Support/Macaulay2/local/

i2 : sin 3

o2 = .141120008059867

o2 : RR (of precision 53)

i3 : sin

o3 = sin

o3 : CompiledFunction

i4 : ?sin

  * Usage:sin x
  * Inputs:
      * x, a real number
  * Outputs:
      * a real number, the sine of x

Ways to use sin
===============

  * sin(CC), see "sin" -- compute the sine
  * sin(QQ), see "sin" -- compute the sine
  * sin(RR), see "sin" -- compute the sine
  * sin(ZZ), see "sin" -- compute the sine

i5 : 