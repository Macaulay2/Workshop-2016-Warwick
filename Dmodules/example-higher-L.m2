restart
load "Kashiwara.m2"
R = QQ[x, y]; f = -(x^9/9 + y^4/4) + 1*x^7*y + 1*x^5*y^2; -- L = 3
R = QQ[x, y]; f = -(x^9/9 + y^4/4) + 1*x^7*y + -7/2*x^5*y^2; -- L= 4
f = reiffen(7,8); -- L = 5
P = Koperator f -- computes one Kashiwara operator
first degree P -- this is an important invariant!
