function [ corners ] = get_corners_from_surf(cube,index)
%GET_EDGES_FROM_SURF Given a surface index (1 -> 6), returnes the
%                    associated edges.
%
%   input --------------------------------------------------------
%   
%       o cube: structure of cube
%
%       o index: (1-6), edge index
%
%   output ------------------------------------------------------
%
%      o edges: (4 x 6), rows are edges, columns are point cooridnates
%           edge(1,1:3): point A
%           edge(1,4:6): point B
%
%

corners = cube.surface(1:4,:,index);


end

