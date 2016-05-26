needsPackage "EdgeIdeals"
needsPackage "BinomialEdgeIdeals"


--Random edge ideal
--Uses EdgeIdeals package

randomEdgeIdeal = method();
randomEdgeIdeal(ZZ,ZZ) := (n,t) -> (
	    (G = randomGraph(QQ[x_1..x_n], t),I = edgeIdeal(G))
	    )

--test
randomEdgeIdeal(8, 5)

--Random binomial edge ideal
--n is number of vertices, t is number of edges of the graph

randomBinomialEdgeIdeal = method();
randomBinomialEdgeIdeal(ZZ,ZZ) := (n, t) -> ( 
    G := randomGraph(QQ[x_1..x_n], t); 
    E := apply(edges G, i -> apply(i, j -> index j+1));
    return (binomialEdgeIdeal(E), G)
    )


--test
TEST///
restart
load "RandomGraphIdeals.m2"
(randomBinomialEdgeIdeal(7, 4))_0 
(ideal(x_6*y_7-x_7*y_6,-x_6*y_1+x_1*y_6,-x_3*y_5+x_5*y_3,-x_5*y_4+x_4*y_5)
    ,new Graph from {ring => QQ[x_1, x_2, x_3, x_4, x_5, x_6, x_7], vertices =>
     {x_1, x_2, x_3, x_4, x_5, x_6, x_7}, edges => {{x_6, x_7}, {x_1, x_6}, {x_3, x_5}, {x_4, x_5}}})

///

--Random toric edge ideal 
--n is number of variables, t is number of edges of the graph

randomToricEdgeIdeal = method();
randomToricEdgeIdeal(ZZ,ZZ) := (n, t) -> (
    R = QQ[x_1..x_n];
    S = QQ[e_1..e_t];
    G = randomGraph(R,t);
    E = apply(edges G, product);
    (ker map(R,S,E), G)
    )

--test
randomToricEdgeIdeal(6,10)

--Documentation
doc ///
   Key
    randomEdgeIdeal
   Headline
    Creates an edge ideal from a random graph with n vertices and t edges.
   Usage
    I = randomEdgeIdeal(n,t)
    (randomEdgeIdeal, ZZ, ZZ)
   Inputs
    n:ZZ
     number of vertices
    t:ZZ
     number of edges
   Outputs
    I:Ideal
     a random edge ideal
    G:Graph
     the graph underlying I
   Description
    Text
     This method returns the edge ideal {\tt I} of a random graph {\tt G} which has n vertices and t edges.
    Example
     randomEdgeIdeal(7, 4) 
   SeeAlso
    randomGraph
    edgeIdeal
///

doc ///
   Key
    randomBinomialEdgeIdeal
   Headline
    Creates a binomial edge ideal from a random graph with n vertices and t edges.
   Usage
    I = randomBinomialEdgeIdeal(n,t)
    (randomBinomialEdgeIdeal, ZZ, ZZ)
   Inputs
    n:ZZ
     number of vertices
    t:ZZ
     number of edges
   Outputs
    I:Ideal
     a random binomial edge ideal
    G:Graph
     the graph underlying I
   Description
    Text
     This method returns the binomial edge ideal {\tt I} of a random graph {\tt G} which has n vertices and t edges.
    Example
     randomBinomialEdgeIdeal(7, 4) 
   SeeAlso
    randomGraph
    binomialEdgeIdeal
    randomToricEdgeIdeal
///

doc ///
   Key
    randomToricEdgeIdeal
   Headline
    Creates a toric edge ideal from a random graph with n vertices and t edges.
   Usage
    I = randomToricEdgeIdeal(n,t)
    (randomToricEdgeIdeal, ZZ, ZZ)
   Inputs
    n:ZZ
     number of vertices
    t:ZZ
     number of edges
   Outputs
    I:Ideal
     a random toric edge ideal
    G:Graph
     the graph underlying I
   Description
    Text
     This method returns the toric edge ideal {\tt I} of a random graph {\tt G} which has n vertices and t edges.  {\tt I} is the kernel of the homomorphism from QQ[x_1..x_n] to QQ/101[e_1..e_t] which sends each vertex in the graph {\tt G} to the product of its endpoints.
    Example
     randomToricEdgeIdeal(6,10) 
   SeeAlso
    randomGraph
    randomBinomialEdgeIdeal
///