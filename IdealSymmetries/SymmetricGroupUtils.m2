convertToCycles = method()
convertToCycles (BasicList,ZZ) := (groupElement,n) -> (
    -- Converts a list of lists representing a symmetric group
    -- element sigma in cycle notation, to a list x such that 
    -- sigma sends i to x#i
    toReturn := new MutableList from 0..n-1;
    for cycle in groupElement do (
        for i in 0..#cycle-1 do (
            toReturn#((cycle#i)-1) = (cycle#((i+1) % #cycle))-1;
        );
    );
    return toList toReturn;
)

--print convertToCycles({{1,2},{3,4}},4);
--print convertToCycles({{1},{2,3,4}},5);
--print convertToCycles({{2,3,4}},6);
