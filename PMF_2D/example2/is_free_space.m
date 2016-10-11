function [ bIsIn ] = is_free_space(X,world)
%IS_FREE_SPACE Checks wether a cartesian point is in free or occuppied
% space
%
%   input ---------------------------------------------------------
%   
%       o X     : (N x 2), set of 2D cartesian points.
%       
%       o world : world structure.
%
%
%

N = size(X,1);

bIsIn = ones(N,1);

dx                    = world.outer_dx;                
b_outside_square1     = find(X(:,1) < -dx); % 1 if outside, 0
b_outside_square2     = find(X(:,1) >  dx);
b_outside_square3     = find(X(:,2) < -dx);
b_outside_square4     = find(X(:,2) >  dx);

bIsIn(b_outside_square1) = 0;
bIsIn(b_outside_square2) = 0;
bIsIn(b_outside_square3) = 0;
bIsIn(b_outside_square4) = 0;


dx                    = world.inner_dx - 0.2 * world.inner_dx ;                             
b_inside_small_square = find(X(:,1) < dx & X(:,1) > -dx & X(:,2) < dx & X(:,2) > -dx);

bIsIn(b_inside_small_square) = 0;



end

