restart
R = QQ[x,y,a,b,c]
I=ideal(y*a+a^2+3*x*c-a*c, 
    -3*x*y+y*a-3*y*b+a*b, 
    -3*x*y+x*a-3*x*c+a*c, 
    y^2+y*a+x*c+a*c,
    x*y-b*c,
    x^2+x*a+y*b+a*b )
codim I
degree I
C = res I
betti oo
C.dd
first decompose I == I
singI = I + minors(codim I, jacobian I);
codim singI -- codim 5, therefore non-singular

eliminate(I, {x, y})
trim(I + ideal(a,b,x,y)) -- (0,0,0,0,1) is a point on the curve.

A = R/I
J = ideal(a,b,x,y)
presentation module J
X = Proj A
Linverse = sheaf module J
L = gens Hom(J, A)
L1 = lift(L, R)
--      {-1} | a -3y+a   |
--      {-1} | b x+a     |
--      {-1} | x -y-a    |
--      {-1} | y 3y-a+4c |

minors(2,L1) == I
L' = map(A^4,,L)


L = sheaf Hom(J, A)
HH^0(L)
HH^0(Linverse(1))
HH^0(OO_X(1))
