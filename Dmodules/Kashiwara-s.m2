restart
needsPackage "Dmodules"

-------------------
-- experiments...
-------------------
R = QQ[x]; f = x^2-1
R = QQ[x,y]; f = (x + 1)*(x - y + 2)*(x + 2*y)
R = QQ[x,y]; f = poly "xy(x+y2)(x2+y)"
A = AnnFs(f) 
n = numgens R
G = gbw(A,toList(n:0) | toList(n:1) | {1}) 

W = ring G
W' = (coefficientRing W)[take(gens W,n)][drop(gens W,n)];
toW' = map(W',W)
G' = toW' G
netList G'_*
