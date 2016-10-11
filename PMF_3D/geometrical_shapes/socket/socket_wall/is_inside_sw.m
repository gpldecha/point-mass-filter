function [b_inside] = is_inside_sw(X,socket_wall)
%IS_INSIDE_SW Summary of this function goes here
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

[~,b_in_c,b_in_cylinder] = is_inside_socket(X,socket_wall);
b_in_w                   = is_inside_w(X,socket_wall);

b_inside = b_in_c | b_in_w;
b_inside = xor(b_inside,b_in_cylinder);


end

