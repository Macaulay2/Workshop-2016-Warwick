PartString = method();
PartString (List) := Partition -> (
  Partition = replace(",","",toString(Partition));
  substring(Partition, 1, #Partition - 2);
)

createNautyString = method(TypicalValue => List)
createNautyString (List) := Polys -> (
  n := #(Polys#0#0);
  SystemAsLists := new MutableList from for i in 0..n list MutableList;
  Monomials := new MutableList;
  Polynomials := new MutableList;
  Variables := 1..n-1;
  NewNodeRef := n+1;
  TermToNode := new MutableHashTable;
  SystemNode = NewNodeRef;

  for i in 0..#Polys - 1 do {
    PolyNode := NewNodeRef;
    Polynomials = Polynomials|{NewNodeRef};
    SystemAsLists = SystemAsLists|{{SystemNode}};
    NewNodeRef = NewNodeRef + 1;
    for j in 0..#(Polys#i) - 1 do {
      MonomialNode = NewNodeRef;
      Monomials = Monomials|{MonomialNode};
      SystemAsLists#PolyNode = append(SystemAsLists#PolyNode,MonomialNode);
      SystemAsLists = append(SystemAsLists, new MutableList);
      NewNodeRef = NewNodeRef + 1;
      for k in 0..#(Polys#i#j) - 1 do {
        if Polys#i#j#k != 0 then {
          if TermToNode#?{Polys#i#j#k,k} == false then {
            TermToNode#{Polys#i#j#k,k} = NewNodeRef;
            SystemAsLists = append(SystemAsLists, new MutableList);
            SystemAsLists#k = append(SystemAsLists#k, NewNodeRef);
            NewNodeRef = NewNodeRef + 1;
          }
          SystemAsLists#MonomialNode = append(SystemAsLists#MonomialNode, TermToNode#{Polys#i#j#k,k})
        }
      }
    }
  }
  PartList := new MutableList from {new MutableList};
  ExponentsToPartition := keys TermToNode;
  ExponentsToPartition = sort(ExponentsToPartition);
  CurrentPower := ExponentsToPartition#0#0;
  PowerString := toString CurrentPower | " ";
  for i in 0..#ExponentsToPartition - 1 do {
    PossiblyNewPower = ExponentsToPartition#i#0;
    if CurrentPower != PossiblyNewPower then {
      CurrentPower = PossiblyNewPower;
      PowerString = PowerString | toString CurrentPower | " ";
    }
  }
  if #ExponentsToPartition > 0 then {
    MinValue = ExponentsToPartition#0#0;
  }
  for Key in ExponentsToPartition do {
    if Key#0 != MinValue then {
      PartList = append(PartList, new MutableList);
      MinValue = Key#0;
    }
    PartList#-1 = append(PartList#-1, TermToNode#Key);
  }


  ReturnString := "c -a -m n=" + toString(#Polys) + " g ";
  for Poly in Polys do {
    for Term in Poly do {
      ReturnString = ReturnString | toString(Term) + " ";
    }
    ReturnString = ReturnString | " ";
  }
  ReturnString = substring(ReturnString, 0, #ReturnString - 1) | ". f = [ 0 | " | toString(SystemNode) | " | ";
  ReturnString = ReturnString | PartString(Variables) | " | " | PartString(Monomials);
  ReturnString = ReturnString | " | " | PartString(PolyPart) | " | ";
  for Part in PowerList do {
    ReturnString = ReturnString | PartString(Part) | " | ";
  }
  ReturnString = ReturnString | "] x @ b";
)



MakeConstIntoVar := Polys -> (
    --This is a helper function to add the constant term into each monomial list.
    --Converting this makes the parsing easier later on.
    Polys = new MutableList from Polys;
    for i in 0..#Polys -1 do (
        Polys#i = new MutableList from Polys#i;
        for j in 0..#(Polys#i)-1 do (
            IsConstant := true;
            for Term in Polys#i#j do (
                if Term != 0 then (
                    IsConstant = false;
                    break;
                );
            );
            if IsConstant then Polys#i#j = {1}|Polys#i#j
            else Polys#i#j = {0}|Polys#i#j;
        );
    );
    return Polys
)

