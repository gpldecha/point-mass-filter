function [indices] = cartesian2indices(X,Y,Z,x_ref,dim,delta)
%CARTESIAN2INDICES Summary of this function goes here

N       = size(X,1);
indices = zeros(N,3);

dm      = delta.m;
dn      = delta.n;
dk      = delta.k;

m       = dim(1);
n       = dim(2);
k       = dim(3);

indices(:,1)  = (X - x_ref(1) - dm/2 + m*dm/2)./dm + 1;
indices(:,2)  = (Y - x_ref(2) - dn/2 + n*dn/2)./dn + 1;
indices(:,3)  = (Z - x_ref(3) - dk/2 + k*dk/2)./dk + 1;

indices      = floor(indices);

end

