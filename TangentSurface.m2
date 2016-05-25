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
# terms((flatten entries gens Q)#0)

--genus 0 example 2
S = QQ[x..z,t]
I = ideal(x-t^4+6*t^2-7*t, y-t^4-t^3-t^2-t-1, z-4*t^4-2*t^2+7)
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
# terms((flatten entries gens Q)#0)

--genus 0 example 3
S = QQ[x..z,t]
I = ideal(x-, y-t^4-t^3-t^2-t-1, z-4*t^4-2*t^2+7)
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
# terms((flatten entries gens Q)#0)

