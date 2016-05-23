needsPackage "Dmodules"

QQ[x, y]

f = y^2 - x^3
g = (x + 1)*(x - y + 2)*(x + 2*y)

A = AnnFs(f)
B = AnnFs(g)
C = newRing(ring B, MonomialOrder => { Weights => {0, 0, 1, 1, 1}, Weights => {0, 0, 0, 0, 1}})
