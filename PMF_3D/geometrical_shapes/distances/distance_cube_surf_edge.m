function [d_s,xs_proj,d_e,xe_proj] = distance_cube_surf_edge(X,cube)
% distance_cube_features
%
%   input -----------------------------------------------------------------
%
%       o X: (N x D), Cartesian coordinates of robot/agents location
%
%       o cube: struct
%
%
%   output ----------------------------------------------------------------
%
%   
%


[d_s,xs_proj] =  distance2surf(X,cube);
[d_e,xe_proj] =  distance2Edges(X,cube);



end


