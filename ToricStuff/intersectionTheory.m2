-- -*- coding: utf-8 -*-
--------------------------------------------------------------------------------
-- Copyright 2009, 2010  Diane Maclagan and Gregory G. Smith
--
-- This program is free software: you can redistribute it and/or modify it under
-- the terms of the GNU General Public License as published by the Free Software
-- Foundation, either version 3 of the License, or (at your option) any later
-- version.
--
-- This program is distributed in the hope that it will be useful, but WITHOUT
-- ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
-- FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
-- details.
--
-- You should have received a copy of the GNU General Public License along with
-- this program.  If not, see <http://www.gnu.org/licenses/>.
--------------------------------------------------------------------------------
--needsPackage "Polyhedra"
--needsPackage "NormalToricVarieties"
newPackage(
  "IntersectionTheory",
  Version => "0.2",
  Date => "4 November 2010",
  Authors => {{
      Name => "Diane Maclagan", 
      Email => "D.Maclagan@warwick.ac.uk", 
      HomePage => "http://www.warwick.ac.uk/staff/D.Maclagan/"},
    {
      Name => "Gregory G. Smith", 
      Email => "ggsmith@mast.queensu.ca", 
      HomePage => "http://www.mast.queensu.ca/~ggsmith"}},
  Headline => "normal toric varieties",
  DebuggingMode => true
  )

export { 
  "chowHomology",
  "chowCohomology",
  "chowRing",
  "AA",
  "nefCycles",
  "effectiveCycles"
  }

--------------------------------------------------------------------------------
-- CODE
--------------------------------------------------------------------------------
needsPackage "NormalToricVarieties"
needsPackage "FourierMotzkin"

chowHomology = method()
chowHomology (ZZ,Sequence) := (i,X) -> chowHomology prepend(i,X)
chowHomology (ZZ,NormalToricVariety) := (i,X) -> HH^i(X,OO_X)

chowCohomology = method()
chowCohomology (ZZ,Sequence) := (i,X) -> chowCohomology prepend(i,X)
chowCohomology (ZZ,NormalToricVariety) := (i,X) -> HH^i(X,OO_X)

chowRing = method()
chowRing NormalToricVariety := Ring => X -> (
     kk := QQ;
     if isSimplicial X then (
     	  S := ring X;
     	  n := numgens S;
	  t := getSymbol "t";
     	  R := kk(monoid [t_0 .. t_(n-1)]);
     	  phi := map(R,S,gens R);
     	  M := phi dual monomialIdeal X;
     	  L := ideal(vars R * (matrix rays X) ** R);
     	  R/(M+L))
     else error "not yet implemented")

args = method()
args(Thing,Sequence) := (i,args) -> prepend(i,args)
args(Thing,Thing) := identity
args(Thing,Thing,Sequence) := (i,j,args) -> prepend(i,prepend(j,args))
args(Thing,Thing,Thing) := identity

AA = new ScriptedFunctor from {
     subscript => (
	  i -> new ScriptedFunctor from {
	       argument => X -> chowHomology args (i,X)
	       }
	  ),
     superscript => (
	  j -> new ScriptedFunctor from {
	       argument => X -> chowCohomology args (j,X)
	       }
	  ),
     argument => (
	  args -> chowRing args
	  )
     }

nefCycles = method()
nefCycles NormalToricVariety := List => X -> (
     A := AA X;
     d := dim X;
     pt := product(first max X, j -> A_j);
     reverse for i to d-1 list (
	  G := first entries basis(i,A);
	  C := for s in orbits(X,i) list product(s, j -> A_j);
	  H := matrix table(G,C, (g,c) -> (g*c // pt));
	  H = sub(transpose matrix unique entries transpose H, ZZ);
	  - (fourierMotzkin H)#0))

effectiveCycles = method()
effectiveCycles NormalToricVariety := List => X -> (
     A := AA X;
     d := dim X;
     E := for i from 1 to d list (
       G := basis(i,A);
       C := for s in orbits(X,d-i) list 1_A*product(s, j -> A_j);
       transpose matrix apply(C, 
	 c -> first entries transpose sub((coefficients(c, 
	       Monomials => G))#1,ZZ)));
     for e in E list (fourierMotzkin fourierMotzkin e)#0)
		    


end;
--------------------------------------------------------------------------------
-- EXAMPLES
--------------------------------------------------------------------------------
restart
needsPackage "NormalToricVarieties";
uninstallPackage "IntersectionTheory"
installPackage "IntersectionTheory"
help isSimplicial

restart
needsPackage "IntersectionTheory";
needsPackage "NormalToricVarieties";
restart
needsPackage "NormalToricVarieties";
needsPackage "IntersectionTheory";

X = kleinschmidt(4,{0,1});
dim X
orbits X
nefCycles X
effectiveCycles X
nef X
A = AA X
for i from 1 to dim X list ( basis(i,A))
max X

Y = hirzebruchSurface 2;
AA Y
for i from 1 to dim Y list ( basis(i,AA Y))

ToricCycle = new Type of HashTable
ToricCycle.synonym = "torus-invariant algebraic cycle"

expression ToricCycle := V -> (
  S := support V;
  local E;
  local E';
  local j;
  negative := false;
  if S === {} then return expression 0
  else (
    j = first S;
    c := V#j;
    if c < 0 then negative = true;
    c = abs(c);
    if c === 1 then E = Subscript{"D", j} 
    else E = Product{c, Subscript{"D", j}};
    if negative === true then (
      negative = false;
      E = Minus E);
    for i from 1 to #S-1 do (
      j = S#i;
      c = D#(S#i);
      if c < 0 then negative = true;
      c = abs(c);
      if c === 1 then E' = Subscript{"D", j} 
      else E' = Product{c, Subscript{"D", j}};
      if negative === true then (
	negative = false;
	E' = Minus E');
      E = E + E');
    return E))
net ToricDivisor := D -> net expression D
ToricDivisor#{Standard,AfterPrint} = ToricDivisor#{Standard,AfterNoPrint} =D ->(
  << endl;				  -- double space
  << concatenate(interpreterDepth:"o") << lineNumber << " : ToricDivisor on ";
  << variety D << endl;)

normalToricVariety ToricCycle := NormalToricVariety => opts -> V -> V.variety
variety ToricCycle := NormalToricVariety => V -> normalToricVariety V
support ToricCycle := List => V -> (
  select(toList(0..D.number-1), i -> D#i =!= 0))



S = ring X;

B = unique apply(subsets((ideal X)_*,3), s -> product s);
L = select(subsets(orbits(X,2),3), s -> (
	  m := S_(s#0#0)*S_(s#0#1)*S_(s#1#0)*S_(s#1#1)*S_(s#2#0)*S_(s#2#1);
	  member(m,B)))

I = ideal AA X
S = ring I
numgens S

R2 = {{1,0,0},{0,1,0},{0,0,1},{0,-1,2},{0,0,-1},{-1,1,-1},{-1,0,-1},{-1,-1,0}};
S2 = {{0,1,2},{0,2,3},{0,3,4},{0,4,5},{0,1,5},{1,2,7},{2,3,7},{3,4,7},{4,5,6},{4,6,7},{5,6,7},{1,5,7}};  
X2 = normalToricVariety(R2,S2); 
nefCycles X2
nef X2
dim X2

nefCycles = method()
nefCycles NormalToricVariety := List => X -> (
     A := AA X;
     d := dim X;
     pt := product(first max X, j -> A_j);
     reverse for i to d-1 list (
	  G := first entries basis(i,A);
	  C := for s in orbits(X,i) list product(s, j -> A_j);
	  H := matrix table(G,C, (g,c) -> (g*c // pt));
	  H = sub(transpose matrix unique entries transpose H, ZZ);
	  - (fourierMotzkin H)#0))


R = QQ[vars(0..numgens S-1)];
RfromS = map(R,S,gens R);
SfromR = maps(S,R,gens S);
(M,L) = gfan RfromS I
for m in M do << endl << apply(standardPairs monomialIdeal m, p -> p#0) << endl;
for l in L do << endl << #l << " | " << l << endl;
#L
B
ideal X

help member	  

A = AA X
basis(2,A)
binomial(6,2)
binomial(3,2)
#orbits(X,3)
orbits(X,4)

primaryDecomposition ideal X

for i to dim X list hilbertFunction(i,A)
P = presentation A
S = ring P;
D = toDual(4,P)
fromDual D

f = first first entries D
D1 =  contract(vars S, f)
transpose D1
rank transpose (coefficients(D1, Monomials => basis(3,S)))#1


X = kleinschmidt(4,{1,5,9});
degrees ring X
nefCycles X
effectiveCycles X
orbits(X,2)


X = kleinschmidt(4,{5,9});
#rays X
degrees ring X
nefCycles X
effectiveCycles X

A_2^2

A = AA X
basis(2,A)
binomial(6,2)
binomial(3,2)
orbits(X,2)


X = smoothFanoToricVariety(4,34);
nefCycles X
effectiveCycles X
primaryDecomposition ideal X
ideal X


--------------------------------------------------------------------------------

X = kleinschmidt(4,{5,9});
AA X
transpose matrix rays X
methods kleinschmidt
code(kleinschmidt, ZZ, List)
transpose matrix degrees ring X
nef X

kleinschmidt (ZZ,List) := NormalToricVariety => (d,a) -> (
     if d < 0 then (
	  error "-- expected a nonnegative integer");
     r := #a;
     s := d-r+1;
     e := entries id_(ZZ^d);
     if r >= d then (
	  error "-- list is too long"); 
     V := {sum(r, i -> -e#i)} | apply(r, i -> e#i);
     V = V | apply(s-1, j -> e#(r+j));
     V = V | {sum(r, i -> a#i*e#i) - sum(s-1, j -> e#(r+j))};
     L := toList(0..r+s);
     F := flatten table(toList(0..r),toList(r+1..r+s), 
	  (i,j) -> select(L, k -> i =!= k and j =!= k));
     M := {{0,1}} | apply(r, i -> { -a#i,1}) |  apply(s, i -> {1,0});
     X := normalToricVariety(V,F, WeilToClass => transpose matrix M);
     return X)

weilToClass X
rays X
matrix {{-5,1},{-9,1},{0,1},{1,0},{1,0},{1,0}}

X = kleinschmidt(3,{5,9});
AA X
orbits X

--------------------------------------------------------------------------------
restart
loadPackage "NormalToricVarieties"
X = kleinschmidt(3,{0,1});
rays X
degrees ring X

Rho = {{1,0

fanoPlane