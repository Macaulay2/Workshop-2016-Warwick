
+ M2 --no-readline --print-width 108
Macaulay2, version 1.9
with packages: ConwayPolynomials, Elimination, IntegralClosure, LLLBases, PrimaryDecomposition, ReesAlgebra,
               TangentCone

i1 : loadPackage "CompleteIntersectionResolutions"

o1 = CompleteIntersectionResolutions

o1 : Package

i2 : viewHelp CompleteIntersectionResolutions

i3 : loadPackage "SimpleDoc"
/Applications/Macaulay2-1.9/share/Macaulay2/SimpleDoc.m2:2:1:(3):[7]: error: package SimpleDoc not reloaded; try Reload => true
/Applications/Macaulay2-1.9/share/Macaulay2/SimpleDoc.m2:2:1:(3):[7]: --entering debugger (type help to see debugger commands)
/Applications/Macaulay2-1.9/share/Macaulay2/SimpleDoc.m2:2:1-16:26: --source code:
newPackage(
        "SimpleDoc",
        Version => "1.1", 
        Date => "December 1, 2009",
        AuxiliaryFiles=>true,
        Authors => {
             {Name => "Dan Grayson", 
                  Email => "dan@math.uiuc.edu", 
                  HomePage => "http://www.math.uiuc.edu/~grayson/"},
             {Name => "Mike Stillman", 
                  Email => "mike@math.cornell.edu", 
                  HomePage => "http://www.math.cornell.edu/~mike/"}},
        Headline => "a simple documentation function",
        DebuggingMode => false
        )

ii4 : restart
Macaulay2, version 1.9
with packages: ConwayPolynomials, Elimination, IntegralClosure, LLLBases, PrimaryDecomposition, ReesAlgebra,
               TangentCone

i1 : needsPackage "SimpleDoc"

o1 = SimpleDoc

o1 : Package

i2 : viewHelp SimpleDoc

i3 : f = x => 2*x
stdio:3:11:(3): error: no method for binary operator * applied to objects:
--            2 (of class ZZ)
--      *     x (of class Symbol)

i4 : f = x -> 2*x

o4 = f

o4 : FunctionClosure

i5 : f 5

o5 = 10

i6 : g = method()

o6 = g

o6 : MethodFunction

i7 : g List := x -> x|x

o7 = {*Function[stdio:7:13-7:18]*}

o7 : FunctionClosure

i8 : g ZZ := x -> 2*x

o8 = {*Function[stdio:8:11-8:16]*}

o8 : FunctionClosure

i9 : g 5

o9 = 10

i10 : g {a,b,c}

o10 = {a, b, c, a, b, c}

o10 : List

i11 : g 5.
stdio:11:1:(3): error: no method found for applying g to:
     argument   :  5 (of class RR)

i12 : g set {a,b,c}
stdio:12:1:(3): error: no method found for applying g to:
     argument   :  set {a, b, c} (of class Set)

i13 : ancestors Set

o13 = {Set, Tally, HashTable, Thing}

o13 : List

i14 : ancestors List

o14 = {List, VisibleList, BasicList, Thing}

o14 : List

i15 : g [a,b,c]
stdio:15:1:(3): error: no method found for applying g to:
     argument   :  [a, b, c] (of class Array)

i16 : g VisibleList := x -> x|x

o16 = {*Function[stdio:16:20-16:25]*}

o16 : FunctionClosure

i17 : g [a,b,c]

o17 = [a, b, c, a, b, c]

o17 : Array

i18 : showStructure 

o18 = Thing : BasicList : Command
                          Constant
                          DocumentTag
                          Eliminate
                          Expression : Adjacent
                                       AssociativeExpression : Equation
                                                               Product
                                                               Sum
                                       BinaryOperation
                                       Divide
                                       FunctionApplication
                                       Holder : OneExpression
                                                ZeroExpression
                                       MatrixExpression
                                       Minus
                                       NonAssociativeProduct
                                       Parenthesize
                                       Power
                                       RowExpression
                                       SparseMonomialVectorExpression
                                       SparseVectorExpression
                                       Subscript
                                       Superscript
                                       Table
                          FilePosition
                          ForestNode
                          Hybrid
                          IndeterminateNumber
                          IndexedVariable
                          InfiniteNumber
                          LowerBound
                          Manipulator
                          MutableList : Bag
                          Option
                          Partition
                          ProductOrder
                          PushforwardComputation
                          RingElement
                          SumOfTwists
                          Time
                          TreeNode
                          URL
                          Vector
                          VisibleList : Array
                                        List : VerticalList
                                        Sequence
              Boolean
              CompiledFunctionBody
              Database
              Dictionary : GlobalDictionary
                           LocalDictionary
              File
              Function : CompiledFunction
                         CompiledFunctionClosure : MethodFunction
                         FunctionClosure : CacheFunction
                                           MethodFunctionWithOptions
              FunctionBody
              HashTable : CoherentSheaf
                          Ideal : MonomialIdeal
                          ImmutableType : Module
                          ModuleMap : Matrix
                          MonoidElement
                          MutableHashTable : CacheTable
                                             Descent
                                             GradedModule : ChainComplex
                                             GradedModuleMap : ChainComplexMap
                                             GroebnerBasis
                                             IndexedVariableTable
                                             Package
                                             Resolution
                                             ScriptedFunctor
                                             Type : HeaderType
                                                    Monoid : OrderedMonoid : GeneralOrderedMonoid
                                                    Ring : EngineRing : FractionField
                                                                        GaloisField
                                                                        InexactField : ComplexField
                                                                                       RealField
                                                                        PolynomialRing
                                                                        QuotientRing
                                                    RingFamily : InexactFieldFamily
                                                    SelfInitializingType
                                                    WrapperType
                                             Variety : AffineVariety
                                                       ProjectiveVariety
                          MutableMatrix
                          OptionTable : GroebnerBasisOptions
                          ProjectiveHilbertPolynomial
                          RingMap
                          SheafOfRings
                          Tally : Set
                                  VirtualTally : BettiTally
              Net : String
              NetFile
              Nothing : InexactNumber
                                     *
              Number : InexactNumber : CC
                                       RR
                       QQ
                       ZZ
              Pseudocode
              Symbol : Keyword
              SymbolBody
              Task

o18 : Descent

i19 : 