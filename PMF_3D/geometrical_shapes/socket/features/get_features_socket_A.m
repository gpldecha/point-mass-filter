function [proj_socket,proj_wall,proj_surf] = get_features_socket_A(X,swall_A,n)
%GET_FEATURES_SOCKET_A Summary of this function goes here
%
%   input -----------------------------------------------------
%
%       o X: (N x 1), Cartesian position
%
%       o q: (1 x 4), Quaternion orientation
%
%       o p: (M x 1), probability density function
%
%       o socket_A: structure
%
%       o n: number of features \in [1,..,4]
%
%
%   output -----------------------------------------------------
%
%      proj_socket(1:n     ,:), (closet   edge of socket)  
%      proj_socket((n+1):n ,:), (closet corner of socket)
%
%      proj_corner(1:n     ,:), (closet   edge of table)  
%      proj_corner((n+1):n ,:), (closet corner of table)
%
%      t = 4*n + 1;
%      proj_x(t,:), (zeros) (direction to goal)         
%
%
%

corners               = swall_A.socket_A.cube.corners(1:4,:);
proj_socket           = get_features_square(X,corners,n);

[dist_surf_1,proj_surf_1] = distance2planSegment(X,corners,[1,0,0]);


corners               = swall_A.wall.corners(1:4,:);
proj_wall             = get_features_square(X,corners,n);

[dist_surf_2,proj_surf_2] = distance2planSegment(X,corners,[1,0,0]);

if dist_surf_1 < dist_surf_2
    proj_surf = proj_surf_1;
else
    proj_surf = proj_surf_2;
end

end

