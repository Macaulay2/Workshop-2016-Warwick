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
  


beginDocumentation()

doc ///
Key  
  MLBundles
Headline 
  routines for working with Mukai-Lazarsfeld bundles
Description
  Text 
     Computes the ML bundle associated to the toric divisor associated to a polytope
///

doc ///
Key  
  MLBundle
  (MLBundle, Polyhedron)
Headline 
  creates Mukai-Lazarsfeld bundle
Usage 
  M = MLBundle(P) 
Inputs  
  P:Polyhedron 
    the polytope corresponding to a polarised toric variety
Outputs 
  M:ToricVectorBundleKlyachko
    the Lazarsfeld-Mukai bundle expressed as a toric vector bundle
Description
  Text 
    The Mukai-Lazarsfeld bundle is the kernel of the evaluation map 
    of the global sections of a globally generated line bundle. On a 
    toric variety, it is a toric vector bundle. Originally, these bundles 
    have been used 
    by Lazarsfeld to find Brill-Noether general curves and by Mukai in the 
    classification of Fano manifolds. Green and Lazarsfeld have established 
    a connection of these bundles with Koszul cohomology groups if the first 
    cohomology of the line bundle is non-zero.  In particular, if the 
    polarisation is very ample, 
    these bundles can be used to compute the Betti numbers of the minimal 
    free resolution of the coordinate ring. 
     
    This constructs the cotangent bundle on projective two space twisted by O(1). 
  Example
    P = convexHull matrix{{0,1,0},{0,0,1}};
    M = MLBundle(P)
    O = cotangentBundle projectiveSpaceFan 2
    O = twist(O,{1,0,0})
    areIsomorphic(O,M)
  Text
    This constructs the Mukai-Lazarsfeld bundle associated to an ample line bundle 
    on the Hirzebruch surface F2. 
  Example      
    P = convexHull matrix{{0,1,0,2},{0,0,1,1}}
    M = MLBundle(P)
    details M
    HH^1 exteriorPower(2,MLBundle(P))
///

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
------------------------------------------------------------------------

uninstallPackage "MLBundles"
restart
needsPackage "MLBundles"
check "MLBundles"
installPackage "MLBundles"
viewHelp
