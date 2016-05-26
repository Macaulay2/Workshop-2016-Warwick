restart
load "Kashiwara.m2"
R = QQ[x, y]; f = x*y*(x+y^2)*(x^2+y);
R = QQ[x, y, z]; f5 = 1/4*(x^4 + y^4 + z^4) - x*y*z;
P = Koperator f -- computes one Kashiwara operator
first degree P -- this is an important invariant!
