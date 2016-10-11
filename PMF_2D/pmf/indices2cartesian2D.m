function [ xy ] = indices2cartesian2D(X_I,Y_I,x_ref,m,n,d)
%INDICES2CARTESIAN2D Summary of this function goes here
%   Detailed explanation goes here

% Not, in this case x -> (3), y -> (1), z -> (2)

x_pos   = (X_I-1) * d - m*d/2 + d/2 + x_ref(1);
y_pos   = (Y_I-1) * d - n*d/2 + d/2 + x_ref(2);

% y_pos   = (X_I-1) * dm - (m-1)*dm/2 + x_ref(1);
% x_pos   = (Y_I-1) * dn - (n-1)*dn/2 + x_ref(2);
% z_pos   = (Z_I-1) * dk - (k-1)*dk/2 + x_ref(3);

xy     = [x_pos,y_pos];


end

