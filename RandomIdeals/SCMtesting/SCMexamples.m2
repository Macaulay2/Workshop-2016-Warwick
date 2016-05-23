needsPackage"RandomIdeal"

--viewHelp RandomIdeal 

--kk=ZZ/101;
--S=kk[a..e];
--L={3,3,4,6};
--m = matrix{{a^3,b^4+c^4,d^5}};
--I=randomIdeal(L,m)

<<<<<<< HEAD
f:={
    n=random (1,20);
    randomList=apply (n,i->random 100);
    }
randomListOfList=apply (10,f);
end 

restart
load "SCMexamples.m2"
=======
kk=ZZ/101;
S=kk[a..e];
L={3,3,4,6};
m = matrix{{a^3,b^4+c^4,d^5}};
I=randomIdeal(L,m);



R=ZZ;
random(R^1,R^4);
random(ZZ);
lista={};
n=20;
for i from 0 to n do  lista=lista|{random(ZZ)};
lista

lista={};
for i from 0 to n do  lista=lista|{random 10};
>>>>>>> df2a37ff33a6645aa8033a28dd3e9a421abcee8b
lista
