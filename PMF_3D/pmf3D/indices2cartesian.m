function [xyz] = indices2cartesian(X_I,Y_I,Z_I,x_ref,dim,delta)
%INDICES Given 

dm      = delta.m;
dn      = delta.n;
dk      = delta.k;

m       = dim(1);
n       = dim(2);
k       = dim(3);

% Not, in this case x -> (3), y -> (1), z -> (2)

x_pos   = (X_I-1) * dm - m*dm/2 + dm/2 + x_ref(1);
y_pos   = (Y_I-1) * dn - n*dn/2 + dn/2 + x_ref(2);
z_pos   = (Z_I-1) * dk - k*dk/2 + dk/2 + x_ref(3);

% y_pos   = (X_I-1) * dm - (m-1)*dm/2 + x_ref(1);
% x_pos   = (Y_I-1) * dn - (n-1)*dn/2 + x_ref(2);
% z_pos   = (Z_I-1) * dk - (k-1)*dk/2 + x_ref(3);

xyz     = [x_pos,y_pos,z_pos];


end

