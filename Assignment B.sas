*WST ASSIGNMENT B;

******************************************************************************************************;
*QUESTION 4;
******************************************************************************************************;

proc iml;
reset nolog;
print "QUESTION 4";
x = {x1, x2, x3, x4};
A = {1 2};
B = {1 -2, 
		2 -1};
mu = {4, 3, 2, 1};
sig = {3 0 2 2, 
		0 1 1 0, 
		2 1 7 -2, 
		2 0 -2 4};
part = {x1,x2} // {x3,x4};

*(a);
E_X2=mu[3:4,1];
print E_X2;

*(b);
E_AX2=A*E_X2;
print E_AX2;

*(c);
COV_X2=sig[3:4,3:4];
print COV_X2;

*(d);
COV_AX2=A*COV_X2*A`;
print COV_AX2;

*(e);
COV_X1X2=sig[1:2,3:4];
print COV_X1X2;

*(f);
COV_AX1BX2=A*COV_X1X2*B`;
print COV_AX1BX2;
quit;

******************************************************************************************************;
*QUESTION 5;
******************************************************************************************************;

proc iml;
reset nolog;
print "QUESTION 5";

seed = j(300,1000,0);
d = normal(seed);
avg = d[+,]/nrow(d);
avg2 = avg[,+]/ncol(avg);

print "Average of averages: " avg2 " theoretical average: 0" ;

dev = avg`-j(nrow(avg`),1,avg2);
s = dev`*dev/(nrow(dev)-1);

print "Standard deviation: " (sqrt(s))
"theoretical value is: " (1/sqrt(nrow(d))),
"since sample size is: " (nrow(d));

quit;
