--find all tangent lines to I
S = QQ[u..w,x..z]
I = ideal(x^2+y^2+z^2-1, y*z+x)
f = u^2+v^2+w^2-1
g = v*w+u
ff = diff(u,f)*(x-u)+ diff(v,f)*(y-v)+diff(w,f)*(z-w)
gg = diff(u,g)*(x-u)+diff(v,g)*(y-v)+diff(w,g)*(z-w)
J = ideal(f,g, ff, gg)
degree I

--get rid of variables u,v,w
eliminate({u,v,w}, J)
# terms((flatten entries gens oo)#0)

--second example
S = QQ[u..w, x..z]
f = 2*u^2+8*u*v-3*u*w+4*v^2-v*w+ 6*w^2 + 2*u+5*v-3*w-1
g = 7*u^2+18*u*v+5*u*w+7*v^2-9*v*w-3*w^2 + 20*u+16*v-9*w-12
ff = diff(u,f)*(x-u)+ diff(v,f)*(y-v)+diff(w,f)*(z-w)
gg = diff(u,g)*(x-u)+diff(v,g)*(y-v)+diff(w,g)*(z-w)
J = ideal(f,g, ff, gg)
degree I
K = eliminate({u,v,w}, J)
p = (flatten entries gens K)#0
# terms p

-- genus 0 example
S = QQ[x..z,t]
I = ideal(x-t^4-t, y-t^4+t^3, z-t^4+1)
J = eliminate({t},I)
degree I

--tangential surface
R = QQ[x..z, u..w]
J = substitute(J, R)
L = flatten entries mingens J
M = apply(L, i -> substitute(i, {x=>u, y=>v, z=>w}))
K = ideal M
N = apply(M, i-> diff(u,i)*(x-u)+ diff(v,i)*(y-v)+diff(w,i)*(z-w))
P = K+ideal(N)
degree P
Q = eliminate({u,v,w},P)
degree Q
-# terms((flatten entries gens Q)#0)

--genus 0 example 2
S = QQ[x..z,t]
I = ideal(x-t^4+6*t^2-7*t, y-t^4-t^3-t^2-t-1, z-4*t^4-2*t^2+7)
J = eliminate({t},I)
flatten entries gens J
numgens J

degree I

--tangential surface
R = QQ[x..z, u..w]
J = substitute(J, R)
L = flatten entries mingens J
M = apply(L, i -> substitute(i, {x=>u, y=>v, z=>w}))
N = apply(M, i-> diff(u,i)*(x-u)+ diff(v,i)*(y-v)+diff(w,i)*(z-w))
P = ideal(M)+ideal(N)
degree P
Q = eliminate({u,v,w},P)
degree Q
(flatten entries gens Q)#0
# terms((flatten entries gens Q)#0)

--genus 0 example 3
S = QQ[x..z,t]
I = ideal(x-2*t^4+3*t^3-3*t^2+t-8, y-t^4-t^3-t^2-t-1, z-4*t^4+17*t^3-2*t^2+t+7)
J = eliminate({t},I)
degree I

--tangential surface
R = QQ[x..z, u..w]
J = substitute(J, R)
L = flatten entries mingens J
M = apply(L, i -> substitute(i, {x=>u, y=>v, z=>w}))
N = apply(M, i-> diff(u,i)*(x-u)+ diff(v,i)*(y-v)+diff(w,i)*(z-w))
P = ideal(M)+ideal(N)
degree P
Q = eliminate({u,v,w},P)
degree Q
# terms((flatten entries gens Q)#0)



---
S = QQ[x..z,t]
I = ideal(x-t^4-2, y-t^4+t^2+t^3+t, z-1+t^4)
J = eliminate({t},I)
degree I

--tangential surface
R = QQ[x..z, u..w]
J = substitute(J, R)
L = flatten entries mingens J
M = apply(L, i -> substitute(i, {x=>u, y=>v, z=>w}))
N = apply(M, i-> diff(u,i)*(x-u)+ diff(v,i)*(y-v)+diff(w,i)*(z-w))
P = ideal(M)+ideal(N)
degree P
Q = eliminate({u,v,w},P)
degree Q
# terms((flatten entries gens Q)#0)


--genus 2, degree 5
restart
loadPackage "RandomSpaceCurves"
kk = ZZ/32003
S = kk[x_0..x_3]
I = (random spaceCurve)(5,2,S)
toString I

R = QQ[x_0..x_3, u_0..u_3]
I = substitute(I, R)
L = flatten entries mingens I
M = apply(L, i -> substitute(i, {x_0=>u_0, x_1=>u_1, x_2=>u_2, x_3=>u_3}))
N = apply(M, i-> diff(u_0,i)*(x_0-u_0)+ diff(u_1,i)*(x_1-u_1)+diff(u_2,i)*(x_2-u_2)+ diff(u_3,i)*(x_3-u_3))
P = ideal(M)+ideal(N)
degree P
Q = eliminate({u_0, u_1, u_2, u_3},P)
degree Q
# terms((flatten entries gens Q)#0)
