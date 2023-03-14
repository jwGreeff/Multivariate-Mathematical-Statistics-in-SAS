															*ASSIGNMENT E;

*---------------------------------------------------------------------------------------------------------------;
*Question 14;
*---------------------------------------------------------------------------------------------------------------;

PROC IMPORT datafile = "D:\Dropbox\Y3S1\WST 311 - MV Statistics\Assessments\Assignments\Datasets in other formats\FatherSons.txt"
dbms = TAB replace
out = FatherSons;
run;

proc iml;
reset nolog;
use FatherSons;
read all var{x1 x2 x3} into x;

print "QUESTION 14";
/*n = nrow(x);*/
/*print n;*/

cov = cov(x);
print cov;

/*a*/
print "QUESTION 14(a)";
cor12 = cov[1, 2]/sqrt(cov[1, 1]*cov[2, 2]); /*mle of correlation is just the a12/sqrt(a11*a22)*/
print cor12 [Format=5.3];

/*b*/
sig11 = cov[1:2, 1:2];
sig12 = cov[1:2, 3];
sig21 = sig12`;
sig22 = cov[3, 3];
	
covb = sig11 - sig12*inv(sig22)*sig12`; /*getting covariance of x1,x2 given x3*/
corb = covb[1, 2]/sqrt(covb[1, 1]*covb[2, 2]);
print "QUESTION 14(b)";
print corb [Format=5.3];

/*c*/
csig11 = cov[1, 1];
csig12T = cov[1, 2:3];
csig22 = cov[2:3, 2:3];
	
RSq = ((csig12T*inv(csig22)*csig12T`)/csig11);
R = sqrt(Rsq);
print "QUESTION 14(c)";
print R [Format=5.3];
	
/*d*/
mean = mean(x);
print mean;
mu1 = mean[1:2];
mu2 = mean[3];
x3 = 72;

EV = mu1 + sig12*inv(sig22)*(x3-mu2);
print "QUESTION 14(d)";
print EV;
quit;
