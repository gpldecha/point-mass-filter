function [ xyz ] = get_cube_xyz(cube)
%GET_CUBE_XYZ Gets the x,y,z-axis limits of the cube (in its own frame of
% reference
%
%   input ---------------------------------------------------------------
%
%       o cube: cube structure
%        
%               - corners: [8x3 double]
%               - edges:   [12x6 double]
%               - surface: [5x3x6 double]
%       
%
%   output -------------------------------------------------------------
%
%       o xyz: (3 x 2), upper and lower range limits of the cube
%
%           xyz(:,1) : lower limit
%           xyz(:,2) : upper limit
%
%

corners = cube.corners - repmat(cube.origin,8,1);

xyz      = zeros(3,2);
xyz(:,1) = min(corners,[],1)';
xyz(:,2) = max(corners,[],1)';


end

