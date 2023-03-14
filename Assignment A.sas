*WST ASSIGNMENT A;

******************************************************************************************************;
*QUESTION 1;
******************************************************************************************************;
data cfcs;
set '...'; *set to location of cfcs.sas7bdat file;
run;

*(a);
proc corr cov data=cfcs;
var q8 q10;
run;

*(b);
proc corr data=cfcs;
var q8 q10;
run;

*(c)(i);
proc means mean std data=cfcs;
var q8;
where ((gender=1) and (age<=25));
run;

*(c)(ii);
proc means mean std data=cfcs;
var q8;
where ((gender=1) and (age>25));
run;

*(c)(iii);
proc means mean std data=cfcs;
var q8;
where ((gender=2) and (age<=25));
run;

*(c)(iv);
proc means mean std data=cfcs;
var q8;
where ((gender=2) and (age>25));
run;

******************************************************************************************************;
*QUESTION 2;
******************************************************************************************************;
proc iml;
covMat = {50 36 18,
			36 36 0,
			18 0 72};

b = {2, 2, -1};
c = {1, -1, 3};
d = {1, 0, 1};

*(a);
varbx = b`*covMat*b;
print varbx;

*(b);
varcx = c`*covMat*c;
print varcx;

*(c);
covbc = b`*covMat*c;
print covbc;

*(d);
corbc = covbc/sqrt(varbx*varcx);
print corbc;

*(e);
AA = b` // c`;
covaax = AA*covMat*AA`;
print covaax;

*(f);
*i;
BB = b||c||d;
covbbx = BB`*covMat*BB;
print covbbx;
*ii;
lincov = d`*covMat*b;
print lincov;

*(g);
call eigen(lambda, H, covMat);
print lambda, H;

sigHalf = H*(sqrt(diag(lambda)))*H`;
print sigHalf;

det = det(covMat);
trace = trace(covMat);
print det, trace;
quit;

******************************************************************************************************;
*QUESTION 3;
******************************************************************************************************;

*set datafile = to location of Iris.xls file;
PROC IMPORT datafile = "..."
dbms = xls replace
out = setosa;
run;

proc iml;
reset nolog;
use setosa;

read all var{PW PL SW SL} into x; *x is a nx4 matrix;

n = nrow(x); *n= nr of rows in matrix x;
print n;
j1 = j(n,1,1); *150x1 column vector filled with 1's;

xbar=(1/n)#x`*j1;
print xbar;

S = (1/(n-1))#x`*(I(n)-(1/n)#j1*j1`)*x;
print S;

D=inv(sqrt(diag(S)));
R=D*S*D;
print R;

quit;
