function [ InCube ] = get_contact_points(x_ref,R_ref,plug_model,socket_world_model)
%GET_CONTACT_POINTS 
%
%   input ------------------------------------------
%
%       o x_ref: (1 x 3), reference point
%
%       o R_ref: (3 x 3), orientation 
%
%       o plug_model: (N x 3), set of plug_model
%
%       o socket_world_model 
%
%

N = size(plug_model,1);
X = R_ref * plug_model' + repmat(x_ref',1,N);
X = X';

InCube   = is_inside_sw(X,socket_world_model);




end

