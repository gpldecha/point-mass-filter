function [ Y ] = square_world_binary_measurement(X,world,range)
%SQUARE_WORLD_BINARY_MEASUREMENT 
%
%   input -------------------------------------------------------------
%
%       o X     : (N x 2), set of N 2D Cartesian position
%
%       o world : world structure
%
%       o range: (1 x 1), sensing range
%
%   output ------------------------------------------------------------
%
%       o Y : (N x 1)
%
%            Y(1) : binary : contact/no-contact
%

N           = size(X,1);

dist_outer  =  distance2walls(X,world,'outer');
dist_inner  =  distance2walls(X,world,'innter');
dist_wall   = min([dist_outer,dist_inner],[],2);

bIsValid    = is_free_space(X,world);


Y                       = zeros(N,1);
Y(dist_wall<=range)     = 1;
Y(bIsValid == 0)        =  -1;

end

