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
	PackageExports => {"ToricVectorBundles", "Polyhedra"},  -- loads and exports
--	PackageImports => {"ToricVectorBundles"},  -- packages loaded for internal calculations
    	DebuggingMode => true		 -- set to true only during development
    	)

-- Any symbols or functions that the user is to have access to
-- must be placed in one of the following two lists
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

firstFunction = method(TypicalValue => String)
firstFunction ZZ := String => n -> (
	if n == 1
	then "Hello, World!"
	else "D'oh!"	
	)
   


beginDocumentation()
document { 
	Key => MLBundles,
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
	"This function is provided by the package ", TO MLBundles, ".",
	EXAMPLE {
		"firstFunction 1",
		"firstFunction 0"
		}
	}


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
 
 
------------------------------------------------------------------------
restart
needsPackage "MLBundles"
check "MLBundles"
