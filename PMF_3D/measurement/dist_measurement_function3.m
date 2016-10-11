function Y = dist_measurement_function3(pos,dist_func)
%DIST_MEASUREMENT_FUNCTION3 
%
%   input --------------------------------------------------------
%
%         o pos:   (N x 2), Cartesian position
%
%         o rot:   (2 x 2), rotation matrix
%
%         o dist_func: function handle
%
%
%   Comment ------------------------------------------------------
%
%       Y = dist_func
%       [dist_s,dist_e,proj_s,proj_e] = get_socket_distance_features_A(X,socket_wall)
%

[dist_s,dist_e,proj_s,proj_e]  = dist_func(pos);
Y                              = [dist_s,dist_e,proj_s,proj_e];


end

