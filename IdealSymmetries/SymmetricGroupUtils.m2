convertToCycles = method()
converterToCycles (BasicList,ZZ) := (groupElement,n) -> (
    toReturn := new MutableList from 1..n;
    for cycle in groupElement do (
        for i in 0..#cycle-1 do (
            toReturn#((cycle#i)-1) = (cycle#((i+1) % #cycle))-1;
        );
    );
    return toList toReturn;
)

--print converterToCycles ({{1,2},{3,4}},4);
--print converterToCycles ({{1},{2,3,4}},5);
--print converterToCycles ({{2,3,4}},6);
