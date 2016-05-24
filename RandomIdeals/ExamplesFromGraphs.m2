restart;

needsPackage"SimplicialComplexes"
needsPackage"Nauty"
needsPackage"RandomIdeal"
needsPackage"ResidualIntersections"

-- A goal of this project is to find interesting classes of square-free monomial ideals from the point of view of residual intersection theory.
-- In particular, we wish to study properties that are stronger than Cohen-Macaulay: e.g. licci, strongly CM, conditions on depths of powers, etc.
-- Thus we look for examples among shellable simplicial complexes.

-- We start from graphs, i.e. 1-dim simplicial complexes; they are trivially shellable.
-- (Note: the Stanley-Reisner ideal of a graph is different from its edge ideal)
-- We use the package "Nauty", which generates all non-isomoprhic (connected) graphs on prescribed sets of vertices or variables.

-- Routine 1: fixed the number of vertices v, it checks all graphs at once. It discards ideals I containing variables.

v = 5;
S = ZZ/32003[x_1..x_v];
licciGraphs = {};
listGraphs = generateGraphs(S, OnlyConnected => true);
time for G in listGraphs do (
    I = monomialIdeal simplicialComplex apply(edges G, E-> product E);
    if hilbertFunction(1,I)==v and isLicci I then (print edges G; licciGraphs = append(licciGraphs,G));
)    

-- Routine 2: fixed the number of vertices v, it proceeds by the number of edges e and prints intermediate results.
-- It discards ideals I containing variables.

v = 7;
S = ZZ/32003[x_1..x_v];
licciGraphs = {};
for e in v..binomial(v,2) do (
    print e;
    listGraphs = generateGraphs(S,e, OnlyConnected => true);
    time for G in listGraphs do (
    	I = monomialIdeal simplicialComplex apply(edges G, E-> product E);
    	if hilbertFunction(1,I)==v and isLicci I then (print edges G; licciGraphs = append(licciGraphs,G));
))

-- RESULTS: exactly 4 licci graphs on 5 vertices; no licci graph on 6 vertices
-- no licci graph on 7 vertices and e  = 7..11 edges 



-- Routine 3: uses randomShellableIdeal to produce examples of 3-dim simplicial complexes.

v = 5;
S = ZZ/32003[x_1..x_v];
for k in v..binomial(v,3) do ( print k; count = 0; time while count<15 do ( 
	I=randomShellableIdeal(S,2,k); if hilbertFunction(1,I)==v then (count = count+1; if isLicci(I) then print gens I);
))


