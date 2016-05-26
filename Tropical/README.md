gfanInterface2.m2: brainstorming ideas
======================================
- add missing documentation
- prefix bug (x_1, x_10)
- ease of use
- polyhedral interface
- add missing commands
- Polymake commands (how do we best integrate Polymake with gfan?)
- customize gfan install


How do we want to separate gfanInterface2 from gfanInterface? Do we want to have a Tropical.m2? YES!

Tropical.m2 ought to have:
==========================
- tropical number min/max
- stableIntersection (make ourselves? interface with Singular?)
- aTint interface


Missing documentation from gfanInterface2.m2
- polymakeConeToCone
- polymakeFanToFan
- gfanFunctions
- gfanTropicalHyperSurfaceReconstruction
- gfanTropicalHyperSurfaceReconstruction(Fan), key: (gfanTropicalHyperSurfaceReconstruction,Fan)
- markedPolynomialList(List), key: (markedPolynomialList,List)
- gfanVersion



Polymake functions to interface:
Material from 
https://polymake.org/release_docs/2.12/tropical.html
TropicalHypersurface
TropicalPolytopes

Mid-Tuesday status:
Diane and Kathlen:
- defined new Type TropicalCycle
- outline of methods
- To do:  * documentation for tropicalCycle.  HALF-DONE.  Needs example.
     	  * isWellDefined code and documentation.  DOCUMENTATION DONE except for an example.
	  * isBalanced code and documentation.  DOCUMENTATION DONE except for an example.
	  * Add skeleton for stableIntersection

Carlos and Paolo
- defined and documented method tropicalPrevariety, 
- deleted multiplicities from fan output
- added strategy choice
- To do:  
          * add valuations
          * define function isTropicalBasis
	  * define function stableIntersection
	  * FIX isTropicalBasis: it needs a homogeneous ideal


Sara and Ben
- set up tropicalVariety
To do: 
	- check if it runs 
	- documentation
	- check if it is prime
	-homogeneous and not homogeneous
	-multiplicities in the case of brute force
	-tropicalCycle output


Answered questions:
==========================
tropicalVariety:
- testing if an ideal is homogeneous is not expensive so it could be used in tropicalVariety
- homogenize computes only the homogenization of the generators

TESTS:
- include the examples in the tests as easy tests
- include "boundary" examples like empty fan 

stableIntersection:
- use directly polymake without calling the interface with Polymake since it is not stable yet

PREFIX BUGS
- Jeff and Nathan are working on it

	  
