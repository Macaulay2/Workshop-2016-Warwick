--*- coding: utf-8 -*-
---------------------------------------------------------------------------
-- 
-- PURPOSE: Computations with convex polyhedra
-- PROGRAMMER : Nathan Ilten, Josephine Yu, Qingchun Ren
-- UPDATE HISTORY : August 2012
---------------------------------------------------------------------------
newPackage("PolyhedralObjects",
Headline => "A package with types for Polyhedra2, gfanInterface2, and PolymakeInterface",
Version => ".1",
Date => "August 5, 2011",
Authors => {
{Name => "Nathan Ilten",
HomePage => "http://math.berkeley.edu/~nilten",
Email => "nilten@math.berkeley.edu"},
{Name => "Qingchun Ren"},
{Name => "Josephine Yu"}
},
DebuggingMode => true
)
---------------------------------------------------------------------------
-- COPYRIGHT NOTICE:
-- 
-- Copyright 2012 Nathan Ilten, Josephine Yu, and Qingchun Ren
-- Some parts copyright 2010 Rene Birkner
-- 
-- 
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
-- 
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
-- GNU General Public License for more details.
-- 
-- You should have received a copy of the GNU General Public License
-- along with this program. If not, see <http://www.gnu.org/licenses/>.
-- 
---------------------------------------------------------------------------
export {
"PolyhedralObject",
"Cone",
"Fan",
"Polyhedron",
"PolyhedralComplex",
"Multiplicities",
"MaximalCones"
}
-- Defining the new type PolyhedralObject
PolyhedralObject = new Type of MutableHashTable
globalAssignment PolyhedralObject
-- Defining the new type Polyhedron
Polyhedron = new Type of PolyhedralObject
Polyhedron.synonym = "convex polyhedron"
globalAssignment Polyhedron
-- Defining the new type Cone
Cone = new Type of PolyhedralObject
Cone.synonym = "convex rational cone"
globalAssignment Cone
-- Defining the new type Fan
Fan = new Type of PolyhedralObject
globalAssignment Fan
-- Defining the new type PolyhedralComplex
PolyhedralComplex = new Type of PolyhedralObject
globalAssignment PolyhedralObject
net PolyhedralObject :=
P -> (
goodkeys := select(keys P, k -> not match("Gfan", toString k) and not match("Polymake", toString k));
stack apply(goodkeys, k -> (net k) | " => " | (net P#k))
)
beginDocumentation()
