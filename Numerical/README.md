# Numerical Algebraic Geometry
Collaboration area for the Numerical Algebraic Geometry group
at the Macaulay2 workshop at the University of Warwick, May 23-26, 2016.

**members**

* [Diego Cifuentes](http://www.mit.edu/~diegcif/)
* [Kaie Kubjas](http://www.kaiekubjas.com/)
* [Anna Seigal](https://math.berkeley.edu/~seigal/)
* [Jan Verschelde](http://www.math.uic.edu/~jan/)

**files**

- phc: current version of the executable program for Mac OS X
- PHCpack.m2: latest development version of Macaulay2 package
- PHCpack/PHCpackDoc.m2: the latest documentation of PHCpack.m2
- circle.m2: our first script
- sweep_real.m2: functions to search for a real slice
- realSlice.m2: functions with documentation interleaved with tests
- realSlice2D.m2 : to prepare for two dimensional witness sets

**searching for a real slice**

* Given a complex variety X of degree d,
  we want to find a real slice.
  A real slice is a linear space of complementary dimension,
  represented by a set of hyperplanes H, 
  such that X intersected with H consists of d real points.

* For example, for a circle in the plane, the problem
  is to find a line that cuts the circle in two real points.

* A real slice may not always exist.

* Varieties in numerical algebraic geometry are represented by witness sets.
  Witness sets may be regarded as an alternative to Groebner bases.
  One can answer many questions about the variety with a witness set.
  Path tracking gives sample points on the variety.

* Our problem can be reformulated as an optimization problem.
  The cost function we minimize is the norm of the imaginary
  parts of the coordinates of the solutions on the slice.
  Line search methods provide a heuristic method for this problem.
