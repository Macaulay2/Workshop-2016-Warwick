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

v = 8;
S = ZZ/32003[x_1..x_v];
licciGraphs = {};
for e in v-1..binomial(v,2) do (
    print e;
    listGraphs = generateGraphs(S,e, OnlyConnected => true);
    time for G in listGraphs do (
    	I = monomialIdeal simplicialComplex apply(edges G, E-> product E);
    	if hilbertFunction(1,I)==v and isLicci I then (print edges G; licciGraphs = append(licciGraphs,G));
))

-- RESULTS: exactly 4 licci graphs on 5 vertices; no licci graph on 6,7 vertices (v = 7 took about 10 hours)  
-- The 4 graphs are
--
-- {{x , x }, {x , x }, {x , x }, {x , x }, {x , x }}
--    1   4     2   4     1   5     2   5     3   5
-- {{x , x }, {x , x }, {x , x }, {x , x }, {x , x }, {x , x }}
--    1   4     2   4     3   4     1   5     2   5     3   5
-- {{x , x }, {x , x }, {x , x }, {x , x }, {x , x }}
--    1   3     1   4     2   4     2   5     3   5
-- {{x , x }, {x , x }, {x , x }, {x , x }, {x , x }, {x , x }, {x , x }}
--    1   3     2   3     1   4     2   4     1   5     2   5     3   5
