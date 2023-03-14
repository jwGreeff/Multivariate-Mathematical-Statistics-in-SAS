															*ASSIGNMENT F;
*------------------------------------------------------------------------------------------------;
*QUESTION 15;
*------------------------------------------------------------------------------------------------;

proc iml;
reset nolog;
print "QUESTION 15";

mu1 = 169.7;
mu2 = 177.8;
var1 = (5.1)*(5.1);
var2 = (6.3)*(6.3);
p12 = 0.68;
o12 = p12/(sqrt(var1*var2));

mu = mu1//mu2;
cov = {26.01	21.8484, 
	  21.8484 39.69};

n=10000;
call randseed(0);
X=RandNormal(n,mu,cov);

/*a*/
a=(x[,1]>x[,2]);
sum1=a[+,];
probA=sum1/n;
print "Q15(a)";
print probA [Format=5.3];

/*b*/
prob = j(n,2,0);
do i=1 to n;
	if x[i,2]<175 then prob[i,1]=1;
	if x[i,2]<175 & x[i,1]>x[i,2] then prob[i,2]=1; 
end;

probB = prob[+,2]/prob[+,1];
print "Q15(b.1)";
print probB [Format=5.3];


/*Alternative for b*/
create height from x [colname = {x1 x2}]; /* now converting the matrix x into a dataset*/
append from x;

use work.height;
read all var{x1 x2}into new where (x2<175); /*now from the dataset, we create a new matrix 
															 consiting of only the rows where x2<175*/
m=nrow(new); /*gets the number of rows in the new matix*/

b=(new[,1]>new[,2]);/*from the new matrix, b will return a 1 if the first col is greater than 
							 the second col(if the wifes height is greater than the husband)*/
sum2=sum(b);
prob2=sum2/m; /*divide with m since that is you new sample size*/
print "Q15(b.2)";
print prob2;
quit;

*------------------------------------------------------------------------------------------------;
*QUESTION 16;
*------------------------------------------------------------------------------------------------;

PROC IMPORT datafile = "D:\Dropbox\Y3S1\WST 311 - MV Statistics\Assessments\Assignments\Datasets in other formats\College.txt"
dbms = dlm
out = College;
getnames = no;
run;

proc iml;
reset nolog;
use College;
read all var{var3 var5 var7} into x;
print "QUESTION 16";
n=nrow(x);
mean=mean(x); 

mleCOV=((n-1)/n)*cov(x);

print mean [Format=5.3], mleCOV [Format=5.3];
quit;



