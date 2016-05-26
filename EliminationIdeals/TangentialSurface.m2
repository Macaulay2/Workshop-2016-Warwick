TangentialSurface=method()
TangentialSurface(Ideal):=(J)->(
    l=flatten entries gens J;
    n=length l;
    F=apply(l,i-> sub(diff(x,i),{x=>u,y=>v,z=>w})*(x-u)+sub(diff(y,i),{x=>u,y=>v,z=>w})*(y-v)+sub(diff(z,i),{x=>u,y=>v,z=>w})*(z-w));
    G=apply(l,i-> sub(i,{x=>u,y=>v,z=>w}));
    Surface=ideal F+ideal G;
    TangentialSurface=eliminate({u,v,w},Surface);
    return TangentialSurface;
    )

rationalCurve=method() 
rationalCurve(ZZ):=(d)->(--d is the degree of the curve
    	local R,Ss;
	R=kk[t];
    	t1=sum apply(d+1,i->random(i,R));
	t2=sum apply(d+1,i->random(i,R));
	t3=sum apply(d+1,i->random(i,R));
	S=kk[t,x,y,z,u,v,w];
	t1=substitute(t1,S);
	t2=substitute(t2,S);
	t3=substitute(t3,S);
	T=eliminate({t},ideal(x-t1,y-t2,z-t3));
return T;
)

curve=method() 
curve(ZZ,ZZ,PolynomialRing):=(d,g,Ss)->( --d is the degree of the curve    	    	    	   
		       --g is the genus of the curve
      local J,R,B;
      J=(random spaceCurve)(d,g,Ss);
      R=kk[t,x,y,z,u,v,w];
      J=substitute(J,R);
      J=substitute(J,{t=>1});
return J;
)

end

restart
load "TangentialSurface.m2"
--------------rational curve--------------------------------
kk=QQ;
A=kk[t,x,y,z];
J=rationalCurve(4);
elapsedTime Surf=TangentialSurface(J);
<<endl<<endl<<"degree tangential surface "<<degree Surf<<endl<<endl;
--------------random curve-----------------------------------
restart
needsPackage "RandomSpaceCurves"
load "TangentialSurface.m2"
kk=ZZ/20011;
A=kk[t,x,y,z];
J=curve(6,1,A);
elapsedTime Surf=TangentialSurface(J);
<<endl<<endl<<"degree tangential surface "<<degree Surf<<endl<<endl;
-------------------------------------------------------------
-------------------------------------------------------------















--------------------------------------------------------------
R=kk[X,x,y,z,u,v,w];
J=substitute(J,R);
J=substitute(J,{X=>1}); 
--J=eliminate (X,J);
l=flatten entries gens J;
<<"Curve "<<netList l<<endl<<endl;
<<"Degree "<<degree J<<endl<<endl;
<<"codimension "<<codim J<<endl<<endl;
--I=ideal(-42*w^2-84*w*y-9*y^2-34*w*z-18*y*z-4*z^2-47*w-35*y-22*z-6,-63*w^3-70*w^2*y-28*w*y^2-55*y^3-37*w^2*z+5*w*y*z-70*y^2*z-25*w*z^2+27*y*z^2+8*z^3-81*w
     --^2+17*w*y-62*y^2-30*w*z-50*y*z+5*z^2-37*w-60*y-34*z-49,-21*w^3-33*w^2*y+11*w*y^2-47*y^3+25*w^2*z+44*w*y*z-61*y^2*z+65*w*z^2+32*y*z^2+26*z^3+20*w^2+67*w
     --*y-11*y^2+58*w*z+10*y*z+24*z^2+4*w-31*y-4*z-10)
n=length l;
m=codim J;
-------------------------------------------
------Verify smoothness condition----------
JJ=J+minors(m,jacobian J);
gens gb JJ --it is smooth if and only if JJ is the unit ideal
-------------------------------------------
-------------------------------------------
------ replace the for by apply------------
------ create two list L and M and --------
------ then Surface = ideal L+ideal M------
-------------------------------------------
-------------------------------------------
idealList={};
for i from 0 to n-1 do(
    app=sub(diff(x,l#i),{x=>u,y=>v,z=>w})*(x-u)+sub(diff(y,l#i),{x=>u,y=>v,z=>w})*(y-v)+sub(diff(z,l#i),{x=>u,y=>v,z=>w})*(z-w);
    app1=sub(l#i,{x=>u,y=>v,z=>w});
    idealList=idealList|{app}|{app1};
    );
Surface=ideal idealList;
codim Surface
degree Surface
toString Surface
TangentialSurface=eliminate({u,v,w},Surface);
<<TangentialSurface<<endl<<endl;
<<"degree tangential surface "<<degree TangentialSurface<<endl<<endl;
<<"codimension tangential surface "<<codim TangentialSurface<<endl<<endl;
--length terms TangentialSurface_(0)
end

--------------------------------------------------------
--rational curve of degree 5 
S=QQ[x,y,z,t];
I=ideal(x-t^5+2,y-t^4-3*t,z-t^3+7*t^2);
J=eliminate({t},I);
S=QQ[x..z,u..w];
J=substitute(J,S)
l=flatten entries gens J;
<<"Curve "<<netList l<<endl<<endl;
<<"Degree "<<degree J<<endl<<endl;
<<"codimension "<<codim J<<endl<<endl;
n=length l;
m=codim J;
-------------------------------------------
------Verify smoothness condition----------
JJ=J+minors(m,jacobian J);
gens gb JJ --it is smooth if and only if JJ is the unit ideal
-------------------------------------------
-------------------------------------------
------ replace the for by apply------------
------ create two list L and M and --------
------ then Surface = ideal L+ideal M------
-------------------------------------------
-------------------------------------------
idealList={};
for i from 0 to n-1 do(
    app=sub(diff(x,l#i),{x=>u,y=>v,z=>w})*(x-u)+sub(diff(y,l#i),{x=>u,y=>v,z=>w})*(y-v)+sub(diff(z,l#i),{x=>u,y=>v,z=>w})*(z-w);
    app1=sub(l#i,{x=>u,y=>v,z=>w});
    idealList=idealList|{app}|{app1};
    );
Surface=ideal idealList;
codim Surface
degree Surface
toString Surface
TangentialSurface=eliminate({u,v,w},Surface);
<<TangentialSurface<<endl<<endl;
<<"degree tangential surface "<<degree TangentialSurface<<endl<<endl;
<<"codimension tangential surface "<<codim TangentialSurface<<endl<<endl;
length terms TangentialSurface_(0)
end 

restart
load "degree5.m2"
J
