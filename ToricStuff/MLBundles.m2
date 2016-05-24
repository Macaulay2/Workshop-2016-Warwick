-- -*- coding: utf-8 -*-
newPackage(
	"MLBundles",
    	Version => "0.1", 
    	Date => "May 23, 2016",
    	Authors => {
	     {Name => "Milena Hering", Email => "m.hering@ed.ac.uk"},
	      {Name => "Florent Martin", Email => "florent.martin@ur.de"}  
	     },
    	Headline => "routines for working with toric Lazarsfeld-Mukai bundles",
	AuxiliaryFiles => false, -- set to true if package comes with auxiliary files
<<<<<<< HEAD
	PackageExports => {"ToricVectorBundles", "Polyhedra"},  -- loads and exports
=======
	PackageExports => {"ToricVectorBundles"},  -- loads and exports
>>>>>>> 5524cf5e60749a425861f74822002b57d087cac0
--	PackageImports => {"ToricVectorBundles"},  -- packages loaded for internal calculations
    	DebuggingMode => true		 -- set to true only during development
    	)

-- Any symbols or functions that the user is to have access to
-- must be placed in one of the following two lists
<<<<<<< HEAD
export {
    "firstFunction", 
    "MLBundle"
    }
exportMutable {}

MLBundle = method ();
MLBundle Polyhedron := P -> ( 
    L := transpose matrix ((latticePoints P)/entries/flatten); -- matrix of lattice points in columns
    B := transpose matrix ((rays normalFan P)/entries/flatten);
    C := (transpose L)*B;
    F := normalFan P;
    E := toricVectorBundle(rank source L,F);
    E = addFiltration(E, apply(rank source C, i-> transpose matrix (C_i)));
    f := matrix {apply(rank source L, i-> 1/1)};
    return ker(E,f)
    )

=======
export {"firstFunction", "secondFunction", "MyOption"}
exportMutable {}

>>>>>>> 5524cf5e60749a425861f74822002b57d087cac0
firstFunction = method(TypicalValue => String)
firstFunction ZZ := String => n -> (
	if n == 1
	then "Hello, World!"
	else "D'oh!"	
	)
   
<<<<<<< HEAD


beginDocumentation()
document { 
	Key => MLBundles,
=======
-- A function with an optional argument
secondFunction = method(
     TypicalValue => ZZ,
     Options => {MyOption => 0}
     )
secondFunction(ZZ,ZZ) := o -> (m,n) -> (
     if not instance(o.MyOption,ZZ)
     then error "The optional MyOption argument must be an integer";
     m + n + o.MyOption
     )
secondFunction(ZZ,List) := o -> (m,n) -> (
     if not instance(o.MyOption,ZZ)
     then error "The optional MyOption argument must be an integer";
     m + #n + o.MyOption
     )

beginDocumentation()
document { 
	Key => PackageTemplate,
>>>>>>> 5524cf5e60749a425861f74822002b57d087cac0
	Headline => "an example Macaulay2 package",
	EM "PackageTemplate", " is an example package which can
	be used as a template for user packages."
	}
document {
	Key => {firstFunction, (firstFunction,ZZ)},
	Headline => "a silly first function",
	Usage => "firstFunction n",
	Inputs => {
		"n" => ZZ => {}
		},
	Outputs => {
		String => {}
		},
<<<<<<< HEAD
	"This function is provided by the package ", TO MLBundles, ".",
=======
	"This function is provided by the package ", TO PackageTemplate, ".",
>>>>>>> 5524cf5e60749a425861f74822002b57d087cac0
	EXAMPLE {
		"firstFunction 1",
		"firstFunction 0"
		}
	}
<<<<<<< HEAD


-- testing the cotangent bundle on P2
TEST ///
P = convexHull matrix{{0,1,0},{0,0,1}};
M = MLBundle(P);
O = cotangentBundle projectiveSpaceFan 2;
O = twist(O,{1,0,0});
assert areIsomorphic(O,M)
///

-- testing the number of equations 
TEST ///
P = convexHull matrix{{0,1,0,2},{0,0,1,1}};
M = MLBundle(P);
M2 = exteriorPower(2,MLBundle(P))
S=ZZ/101[x,y,z]
L = apply (latticePoints P, i -> (flatten entries i)|{1})
R = ZZ/101[vars(0..#L-1)];
I= kernel map (S, R, apply (L, v -> S_v))
assert (rank source mingens I == rank  HH^1 M2)
///

=======
document {
	Key => secondFunction,
	Headline => "a silly second function",
	"This function is provided by the package ", TO PackageTemplate, "."
	}
document {
	Key => (secondFunction,ZZ,ZZ),
	Headline => "a silly second function",
	Usage => "secondFunction(m,n)",
	Inputs => {
	     "m" => {},
	     "n" => {}
	     },
	Outputs => {
	     {"The sum of ", TT "m", ", and ", TT "n", 
	     ", and "}
	},
	EXAMPLE {
		"secondFunction(1,3)",
		"secondFunction(23213123,445326264, MyOption=>213)"
		}
	}
document {
     Key => MyOption,
     Headline => "optional argument specifying a level",
     TT "MyOption", " -- an optional argument used to specify a level",
     PARA{},
     "This symbol is provided by the package ", TO PackageTemplate, "."
     }
document {
     Key => [secondFunction,MyOption],
     Headline => "add level to result",
     Usage => "secondFunction(...,MyOption=>n)",
     Inputs => {
	  "n" => ZZ => "the level to use"
	  },
     Consequences => {
	  {"The value ", TT "n", " is added to the result"}
	  },
     "Any more description can go ", BOLD "here", ".",
     EXAMPLE {
	  "secondFunction(4,6,MyOption=>3)"
	  },
     SeeAlso => {
	  "firstFunction"
	  }
     }
TEST ///
  assert(firstFunction 1 === "Hello, World!")
  assert(secondFunction(1,3) === 4)
  assert(secondFunction(1,3,MyOption=>5) === 9)
///
>>>>>>> 5524cf5e60749a425861f74822002b57d087cac0
  
       
end

-- Here place M2 code that you find useful while developing this
-- package.  None of it will be executed when the file is loaded,
-- because loading stops when the symbol "end" is encountered.

installPackage "PackageTemplate"
installPackage("PackageTemplate", RemakeAllDocumentation=>true)
check PackageTemplate

restart
needsPackage "MLBundles"
loadPackage "ToricVectorBundles"
loadPackage "NormalToricVarieties"
<<<<<<< HEAD
 
 
------------------------------------------------------------------------
restart
needsPackage "MLBundles"
check "MLBundles"
=======
>>>>>>> 5524cf5e60749a425861f74822002b57d087cac0
