# Numerical Algebraic Geometry
Collaboration area for the Numerical Algebraic Geometry group
at the Macaulay2 workshop at the University of Warwick, May 23-26, 2016.

**members**

* Diego Cifuentes
* Kaie Kubjas
* Anna Seigal
* Jan Verschelde

**files**

- phc: current version of the executable program for Mac OS X
- PHCpack.m2: latest development version of Macaulay2 package
- PHCpack/PHCpackDoc.me: latest documentation of PHCpack.m2
- sweep_real.m2: functions to search for real witness points 

**searching for a real slice**

* Given a complex variety X of degree d,
  we want to find a real slice.
  A real slice is a linear space of complementary dimension,
  represented by a set of hyperplanes H, 
  such that X intersected with H consists of d real points.

* For example, for a circle in the plane, the problem
  is to find a line that cuts the circle in two real points.
  A real slice may not always exist.

* Varieties in numerical algebraic geometry are represented by witness sets.
  Witness sets may be regarded as an alternative to Groebner basis.
  One can answer many questions about the variety with a witness set.
  Path tracking gives us sample points on the variety.

* Our problem can be reformulated as an optimization problem.
  The cost function we minimize is the norm of the imaginary
  parts of the solutions on the slice.
  Line search methods provide a heuristic method for this problem.
