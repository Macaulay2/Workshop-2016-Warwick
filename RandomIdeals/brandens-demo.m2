-- creating a method
restart
demoMethod = method()
demoMethod (ZZ,String) := (n,text) -> (
     	    local var1;
	    local var2;
	    var1 = n+n;
	    var2 = "Hello there ";
	    var2 = var2|text;
	    var1 = apply( var1, l -> l+1 );
--	    apply({0,1,2,3}, l -> l+1 )  -- same as above
	    return (var1, var2);
    )

powerList = method()
powerList(Ideal,ZZ) := (J, n) -> (
    local L;
    local R;
    
    R = ring J;
    L = apply(n+1, l-> pdim((R^1)/(J^l))); -- R^1 is a module   
    
    return L;    
    )
end

-- ctrl+x f creates a file
-- ctrl+x s saves the file

installPackage"RandomIdeal" -- hit F11
viewHelp RandomIdeal -- hit F11

load "brandens-demo.m2"
demoMethod(3,"any name")

-- user

restart
load "brandens-demo.m2"
R = ZZ/101[x,y,z]
I = ideal"x3,xy,zyx2"
powerList (I, 20) -- want this
--This was a good turorial..