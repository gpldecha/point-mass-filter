function Y = square_world_measurement_function(X,rot,world,range_var,noise_cov)
%2D_WORLD_MEASUREMENT_FUNCTION 
%
%   input -------------------------------------------------------------
%
%       o X : (N x 2), set of N 2D Cartesian position
%
%       o rot: 
%
%   output ------------------------------------------------------------
%
%       o Y : (N x 1)
%
%          % - Y(N,1) : binary, at the goal or not
%
%           - Y(N,1) : probability of being in conact with wall (in certain
%                      range).
%
%         

dist_outer =  distance2walls(X,world,'outer');
dist_inner =  distance2walls(X,world,'innter');


dist_wall = min([dist_outer,dist_inner],[],2);

if exist('noise_cov','var')
   dist_wall = dist_wall + normrnd(0,sqrt(noise_cov),N,1);
end

bIsValid = is_free_space(X,world);


Y = exp(-0.5 .* (1/range_var) .* dist_wall);

idx1 = find(dist_wall <= 0.5);
idx2 = find(dist_wall >  0.5);
Y(idx1) = 1;
Y(idx2) = 0;

idx = find(bIsValid == 0);
Y(idx)  =  -1;




end



