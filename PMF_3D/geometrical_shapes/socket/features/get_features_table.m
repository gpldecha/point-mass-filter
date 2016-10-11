function [ proj_x ] = get_features_table(X,table,n)
%GET_FEATURES_TABLE Summary of this function goes here
%
%   input -----------------------------------------------------
%
%       o X: (N x 3)
%
%       o socket_A: structure
%
%       o n: number of features \in [1,..,4]
%
%

corners   = table.corners(1:4,:);
proj_x    = get_features_square(X,corners,n);

end

