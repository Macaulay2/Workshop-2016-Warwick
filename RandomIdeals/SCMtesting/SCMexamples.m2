needsPackage"RandomIdeal"

--viewHelp RandomIdeal 


kk=ZZ/101
S=kk[a..e]
L={3,3,4,6}
m = matrix{{a^3,b^4+c^4,d^5}}
I=randomIdeal(L,m)


R=ZZ
random(R^1,R^4)
random(ZZ)
lista={}
n=20
for i from 0 to n do  lista=lista|{random(ZZ}
for i from 0 to n do  lista=lista|{random 10}
lista

