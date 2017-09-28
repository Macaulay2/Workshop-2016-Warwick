load "./SymmetricGroupUtils.m2"

createPartitionString = method()
createPartitionString (BasicList) := partition -> (
  partition = replace(",","",toString(toList partition));
  substring(partition, 1, #partition - 2)
)

createDreadnautString = method(TypicalValue => BasicList)
createDreadnautString (BasicList, BasicList) := (polys, coefficients) -> (
	n := #(polys#0#0);
	systemAsLists := new MutableList from for i in 0..n list new MutableList;
	coeffToMonomialNode := new MutableHashTable;
	polynomials := new MutableList;
	variables := toList(1..n-1);
	newNodeIndex := n;
	systemNode := newNodeIndex;
	newNodeIndex = newNodeIndex+1;
	termToNode := new MutableHashTable;

	-- The big idea here is that we're doing a depth first traversal of the
	-- polynomial graph. Node 0 is the constant node, 1 through n are the 
	-- variable nodes, and n+1 is the system node.
	for i in 0..#polys - 1 do (
		polyNode := newNodeIndex;
		polynomials = append(polynomials,newNodeIndex);
		systemAsLists = append(systemAsLists,{systemNode});
		newNodeIndex = newNodeIndex + 1;
		for j in 0..#(polys#i) - 1 do (
			monomialNode := newNodeIndex;
			if coeffToMonomialNode#?(coefficients#i#j) then (
				coeffToMonomialNode#(coefficients#i#j) = coeffToMonomialNode#(coefficients#i#j)|{monomialNode};
			) else (
				coeffToMonomialNode#(coefficients#i#j) = {monomialNode};
			);
			systemAsLists#polyNode = append(systemAsLists#polyNode,monomialNode);
			systemAsLists = append(systemAsLists, new MutableList);
			newNodeIndex = newNodeIndex + 1;
			for k in 0..#(polys#i#j) - 1 do (
				if polys#i#j#k != 0 then (
					if termToNode#?{polys#i#j#k,k} == false then (
						termToNode#{polys#i#j#k,k} = newNodeIndex;
						systemAsLists = append(systemAsLists, new MutableList);
						systemAsLists#k = append(systemAsLists#k, newNodeIndex);
						newNodeIndex = newNodeIndex + 1;
					);
					systemAsLists#monomialNode = append(systemAsLists#monomialNode, termToNode#{polys#i#j#k,k})
				);
			);
		);
	);

	-- Here we set up partitioning identical exponents together.
	partitionList := new MutableList from {new MutableList};
	exponentsToPartition := keys termToNode;
	exponentsToPartition = sort(exponentsToPartition);
	if #exponentsToPartition > 0 then (
		minValue := exponentsToPartition#0#0;
	);
	for key in exponentsToPartition do (
		if key#0 != minValue then (
			partitionList = append(partitionList, new MutableList);
			minValue = key#0;
		);
		partitionList#-1 = append(partitionList#-1, termToNode#key);
	);

	-- Now we create the string that will be fed into dreadnaut.
	returnString := "c +a -m n=" | toString(#systemAsLists) | " g ";
	for poly in systemAsLists do (
		for term in poly do (
			returnString = returnString | toString(term) | " ";
		);
		returnString = returnString | ";";
	);
	returnString = substring(returnString, 0, #returnString - 1) | ". f = [ 0 | " | toString(systemNode) | " | ";
	returnString = returnString | createPartitionString(variables) | " | "; 
	for nodesWithSameCoefficient in values coeffToMonomialNode do (
		returnString = returnString | createPartitionString(nodesWithSameCoefficient) | " | ";
	);
	returnString = returnString | createPartitionString(polynomials) | " | ";
	for partition in partitionList do (
		returnString = returnString | createPartitionString(partition) | " | ";
	);
	return returnString | "] x @ b";
)

makeConstIntoVar := polys -> (
	--This is a helper function to add the constant term into each monomial list.
	--Converting this makes the parsing easier later on.
	polys = new MutableList from polys;
	for i in 0..#polys-1 do (
		polys#i = new MutableList from polys#i;
		for j in 0..#(polys#i)-1 do (
			isConstant := true;
			for term in polys#i#j do (
				if term != 0 then (
					isConstant = false;
					break;
				);
			);
			if isConstant then
				polys#i#j = {1}|polys#i#j
			else
				polys#i#j = {0}|polys#i#j;
		);
	);
	return polys
)

findDreadnautStrs = method()
findDreadnautStrs (List) := (polys) -> (
	coefficientList := new MutableList from for i in 0..#polys - 1 list new MutableList;
	termList := new MutableList from for i in 0..#polys - 1 list new MutableList;
	for i from 0 to #polys - 1 do (
		for term in listForm polys#i do (
			termList#i = append(termList#i,term#0);
			coefficientList#i = append(coefficientList#i,term#1);
		);
	);
	numberOfVariables := #(termList#0#0);

	polysAsLists := makeConstIntoVar(termList);
	callDreadnaut(createDreadnautString(polysAsLists, coefficientList))
);

findSymmetry = method()
findSymmetry Ideal := thisIdeal -> findSymmetry first entries gens thisIdeal
findSymmetry List := polys-> (
	-- This is the main function. It is called on a list of polynomials and 
	-- returns a list of generators of the symmetry group.
	dreadnautStrs := findDreadnautStrs(polys);
	permutations := new MutableList;
	i := 1;
	while i < #dreadnautStrs do (
		dreadnautStr := dreadnautStrs#i;
		if class regex("orbits", dreadnautStr) === class {} then
			break;

		if dreadnautStr#0 == "(" then (
			newPermutationStr := dreadnautStr;
			for j from i + 1 to #dreadnautStrs - 1 do (
				testDreadnautStr := dreadnautStrs#j;
				if testDreadnautStr#0 != " " then (
					i = j;
					break;
				);
				if testDreadnautStr#0 == " " then (
					newPermutationStr = newPermutationStr | substring(testDreadnautStr,3,#testDreadnautStr);
				);
			);
			possiblePermutation := parsePermutationStr(newPermutationStr, numberOfVariables);
			if #possiblePermutation != 0 then (
				permutations = append(permutations, possiblePermutation);
			);
		);
	);
	permutations = toList permutations;
	return apply(permutations,a -> cycleToWordNotation(a,numberOfVariables));
)

getCanonicalString = method()
getCanonicalString (Ideal) := (I) -> (
	if numgens ring I != #support I then (
		error "All variables in the ideal must be used.";
	);
	Polys := first entries gens I;
	dreadnautStrs := findDreadnautStrs(Polys);
	dreadnautStr := concatenate(for i in 0..(#dreadnautStrs)*2 - 1 list (if i % 2 == 1 then 1 else dreadnautStrs#(i//2)));
	secondsLocation := regex(":", dreadnautStr);
	substring(secondsLocation#0#0+secondsLocation#0#1,dreadnautStr)
);

idealsAreIdentical = method()
idealsAreIdentical (Ideal, Ideal) := (I, J) -> (
	getCanonicalString(I) == getCanonicalString(J)
);

parsePermutationStr = method()
parsePermutationStr (String, ZZ) := (permutationStr, numberOfVariables) -> (
	-- This function takes in a permutation string and the number of variables
	-- and returns a list of permutations of variables.
	permutationStr = substring(permutationStr,1,#permutationStr - 2);
	permutationStr = replace("[(]","", permutationStr);
	splitCycles := separate(")", permutationStr);
	toReturn := new MutableList;
	for cycle in splitCycles do (
		splitCycle := separate(" ", cycle);
		intCycle := new MutableList;
		for termStr in splitCycle do (
			intCycle = append(intCycle, value termStr);
		);
		isCycleVarPermutation := true;
		for term in intCycle do (
			if term > numberOfVariables then (
				isCycleVarPermutation = false;
				break;
			);
		);
		if isCycleVarPermutation then (
			toReturn = append(toReturn, toList intCycle);
		);
	);
	toReturn = toList toReturn;
	return toReturn;
)

dreadnautPath = prefixDirectory | currentLayout#"programs" | "dreadnaut";
callDreadnaut = method()
callDreadnaut String := List => ourGraph -> (
	infn := temporaryFileName();
	erfn := temporaryFileName();
	o := openOut infn;
	o << ourGraph << endl;
	close o;
	r := lines try get openIn ("!" | dreadnautPath | " <" | infn | " 2>" | erfn)
	else (
		-- nauty errored, harvest the error
		e := last separate(":", first lines get openIn erfn);
		removeFile infn;
		removeFile erfn;
		-- special cases
		if e == " not found" then error("callDreadnaut: nauty could not be found on the path [" | dreadnautPath | "].");
		if e == "#q -V] [--keys] [-constraints -v] [ifile [ofile]]" then e = "invalid filter";
		error("callDreadnaut: nauty terminated with the error [", e, "].");
	);
	removeFile infn;
	removeFile erfn;
	return r;
)
