*ASSIGNMENT C;
*Question 8;

data normal;
/* 
Consider X={X,Y}; 
mu={5,5};
sigma={4 0, 0 6};

BUT SINCE WE ARE WORKING WITH DATA AND NOT PROC IML...
*/

mu1=5;
mu2=5;

sig11=4;
sig12=0;
sig21=0;
sig22=6;

pi=constant('pi');

do x=-3 to 13 by 0.1;
	do y=-3 to 13 by 0.1;
		p = sig12/sqrt(sig11*sig22);
		fc = -(1/(2*(1-p**2)));
		f1 = (x-mu1)**2/sig11;
		f2 = (y-mu2)**2/sig22;
		f3 = (-2*p*(x-mu1)*(y-mu2))/sqrt(sig11*sig22);
		fxy = exp(fc*(f1+f3+f2))/(2*pi*sqrt(sig11*sig22)*sqrt(1-p**2));
		output;
	end;
end;

/* Question 8(a) */
proc g3d data=normal;
plot x*y=fxy / side
tilt=45 rotate=35;
run;

/* Question 8(b) - see notes */

/* Question 8(c) */
data q8c;
set normal;
vol=fxy*0.1*0.1;

proc means data=q8c sum maxdec=3;
var vol;
run;

/* Question 8(d) */
data q8d;
set normal;
if 1.99999999999 <x<2.0000000001;

proc gplot data=q8d;
plot fxy*y; /* Also try y*fxy */
run;

/* Question 8(e) */
data q8e;
set q8d;
area=fxy*0.1;

proc means data=q8e sum maxdec=3;
var area;
run;
