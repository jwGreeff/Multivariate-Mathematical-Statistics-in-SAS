*ASSIGNMENT C;
proc iml;
pi = constant('pi'); *Need this for the density function;

*We define;
mu = {5 5}; 
sigma = {4 4, 4 6};
p = nrow(sigma);*Dim of the denisty functino, therefore 2 observations;
x = expandgrid(-20:120,-20:120);*Grid/list of values to pluf into the density function, x:=matrix;
x=x/10;
xx=x||j(nrow(x),1,0);*add an empty column next to it;

do j=1 to nrow(xx); *for every single step of the way;
	*MVND Function;
	xx[j,3]=(det(2#pi#sigma))##(-1/2)#exp(-((xx[j,1:2]-mu)*inv(sigma)*(xx[j,1:2]-mu)`)/2);
end;
*xx contains col 1 and 2 = grid and col 3 value of f_xy;
create vall from xx; *Output xx into a dataset so you can use it outside IML;
append from xx;

call eigen(val,vec,sigma);
print val vec;
quit;

*to show the plot;
proc g3d data=vall;
title 'Bivariate Normal Density';
*cols in xx;
	plot col1*col2=col3
		/ grid
		tilt=45 rotate=35;
run;
quit;
