									*ASSIGNMENT D;

*-------------------------------------------------------------------------------------;
*Question 9: Example 11;
*-------------------------------------------------------------------------------------;

proc iml;
reset nolog;
print "QUESTION 9";

sig =  {100 70 90,
		70 100 80,
		90 80 100};

mu = {66, 66, 66};

mu1 = mu[1:2,];
mu2 = mu[3,];

sig11 = sig[1:2,1:2];
sig12 = sig[1:2,3];
sig21 = sig12`;
sig22 = sig[3,3];

sig11_2 = sig11 - sig12*inv(sig22)*sig21;*Calculating Partial Covariance Matrix;
print sig11_2;

d = inv(sqrt(diag(sig11_2)));
rho12_3 = d*sig11_2*d; *Calculating Partial Correlation Co-effecient;
print rho12_3;

*Q9: Example 12;
ey1_y2_72 = mu1 + sig12*inv(sig22)*(72-mu2); /*Calculating Partial Expected Values*/
ey1_y2_60 = mu1 + sig12*inv(sig22)*(60-mu2);
print ey1_y2_72 ey1_y2_60;

quit;

*-------------------------------------------------------------------------------------;
*Question 10;
*-------------------------------------------------------------------------------------;

proc iml;
reset nolog;
print "QUESTION 10";

sig = { 4 0.5 -0.5 -1 0,
		0.5 6 1 1 -1,
		-0.5 1 4 -1 0,
		-1 1 -1 3 0,
		0 -1 0 0 2};

mu = {2, -1, 3, 4, 0};

/*Calculating Correlation Matrix*/
d = inv(sqrt(diag(sig)));
rho = d*sig*d;
print "QUESTION 10(a):";
print rho [Format=5.3];


/*Calculating Partial Covariances*/
sigB = sig[1,]//sig[3:4,]//sig[2,]//sig[5,];
sigB2 = sigB[,1]||sigB[,3:4]||sigB[,2]||sigB[,5];
sigC = sigB2[2:5,2:5];

sig11 = sigC[1:2,1:2];
sig12 = sigC[1:2,3:4];
sig21 = sig12`;
sig22 = sigC[3:4,3:4];

sig11_2 = sig11 - sig12*inv(sig22)*sig21;

/*Calculating Partial Correlation*/
d2 = inv(sqrt(diag(sig11_2)));
rho34_25 = d2*sig11_2*d2;
print "QUESTION 10(b):";
print rho34_25 [Format=5.3];

/*Calculating Partial Expected Values*/
mu1 = mu[3:4];
mu2 = mu[2]//mu[5];
y2 = {1, 1};
ey1_y2 = mu1 + sig12*inv(sig22)*(y2 - mu2);
print "QUESTION 10(c):";
print ey1_y2 [Format=5.3];

quit;


*-------------------------------------------------------------------------------------;
*Question 12;
*-------------------------------------------------------------------------------------;

proc iml;
reset nolog;
print "QUESTION 12";

call randseed(0);
NN = 10000;
mu = {2 1 1 3};
sig =  {9 -1 2 0,
		-1 7 3 -1,
		2 3 13 3,
		0 -1 3 9};

x = randnormal(NN, mu, sig);

n = nrow(x);
mean=x[:,];
y=x-repeat(mean,n);
s=1/(n-1)#y`*y;
print s [Format=5.3];

prob = j(NN,3,0);

do i=1 to NN;
	if x[i,1]<1 & x[i,2]<1 & x[i,3]<1 & x[i,4]<1 then prob[i,1]=1;
	if x[i,1]<1 & x[i,2]<1 & x[i,3]<1 then prob[i,2]=1;
	if (x[i,1]+x[i,2])>(x[i,3]+x[i,4]) then prob[i,3]=1;
end;
print "QUESTION 12(a):";
q2a = prob[+,1]/NN;
q2b = prob[+,2]/NN;
q2c = prob[+,3]/NN;
print q2a [Format=5.3]; 

print "QUESTION 12(b):";
print q2b [Format=5.3]; 

print "QUESTION 12(c):";
print q2c [Format=5.3];

y1 = x[,1]+x[,2];
y2 = x[,3]+x[,4];
yy = y1||y2;
meanyy = yy[:,];
yz = yy - repeat(meanyy,n);
s2 = 1/(n-1)#yz`*yz;
print "QUESTION 12(d):";
print s2 [Format=5.3];
print "QUESTION 12(e):";
quit;

/*Ceating a dataset and using it
data q2;
call randseed(0);
NN = 10000;
mu = {2 1 1 3};
sig =  {9 -1 2 0,
		-1 7 3 -1,
		2 3 13 3,
		0 -1 3 9};

x = randnormal(NN, mu, sig);
inda = 0; indb = 0; indc = 0;

y1 = x[,1]+x[,2]; 
y2 = x[,3]+x[,4];

if x[,1]<1 & x[,2]<1 & x[,3]<1 & x[,4]<1 then inda=1;
if x[,1]<1 & x[,2]<1 & x[,3]<1 then indb=1;
if y1>y2 then indc = 1;


proc means mean var data=q2;
var inda indb indc x4;
run;

proc corr cov data=q2;
var y1 y2;
run;*/
