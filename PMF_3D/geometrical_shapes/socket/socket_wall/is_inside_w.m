function [ b_inside ] = is_inside_w(X,socket_wall)
%IS_INSIDE_W check if point is inside wall
%
%
%   input ----------------------------------------------------------
%
%       o X: (N x 3), positions
%
%      o socket_A: [1x1 struct]
%           wall: [1x1 struct]
%           wall_w: 0.8000
%           wall_h: 0.0200
%           wall_l: 0.4000
%
%
%   output --------------------------------------------------------
%
%       o b_in: (N x 1), binary vector
%


origin_wall   = socket_wall.wall.origin;
xyz_wall      = get_cube_xyz(socket_wall.wall);


b_inside   = bounding_box3(X,origin_wall,xyz_wall);


end

