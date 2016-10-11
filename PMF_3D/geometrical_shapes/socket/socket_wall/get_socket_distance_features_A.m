function [dist_s,dist_e,proj_s,proj_e,is_in] = get_socket_distance_features_A(X,socket_wall,b_only_wall)
%GET_SOCKET_DISTANCE_FEATURES 
%
%   input -----------------------------------------------------------
%
%       o X: (N x 3), Cartesian points
%
%       o socket_wall: struct
%              - socket_A
%              - wall
%
%   output ----------------------------------------------------------
%
%       o dist_s: (N x 1), shortest distance to surface
%
%       o dist_e: (N x 1), shortest distance to edge
%
%       o proj_s: (N x 3), position of projected X onto surface
%
%       o proj_e: (N x 3), position of projected X onto edge
%
%       o is_in:  (N x 1), boolean vector: 0 -> not inside the object
%                                           1 -> inside the object


if ~exist('b_only_wall','var'),b_only_wall = false; end;

b_only_socket = false;

N         = size(X,1);
proj_surf = cell(1,2);
proj_edge = cell(1,2);
proj_s    = zeros(N,3);
proj_e    = zeros(N,3);
is_in     = [];

if(b_only_wall)
    
%    disp('Wall');
        
    [dist_surf_wall, proj_surf_wall]    = distance2surf(X,socket_wall.wall);
    [dist_edge_wall,proj_edge_wall]     = distance2Edges(X,socket_wall.wall);

    proj_s = proj_surf_wall;
    proj_e = proj_edge_wall;
    
    dist_s = dist_surf_wall;
    dist_e = dist_edge_wall;
    
elseif(b_only_socket)
    
    
%    disp('Socket');
    
    [dist_surf_socket,proj_surf_socket] = distance2surf(X,socket_wall.socket_A.cube);
    [dist_edge_socket,proj_edge_socket] = get_distance_edge_socket_A(X,socket_wall.socket_A);


    proj_s = proj_surf_socket;
    dist_s = dist_surf_socket;
      
    dist_e = dist_edge_socket;
    proj_e = proj_edge_socket;

else

%disp('Socket and Wall');
    
[dist_surf_wall, proj_surf_wall]    = distance2surf(X,socket_wall.wall);
[dist_surf_socket,proj_surf_socket] = distance2surf(X,socket_wall.socket_A.cube);

bInWall                             = is_incube(X,socket_wall.wall);
bInSocket                           = is_incube(X,socket_wall.socket_A.cube);

is_in = bInWall | bInSocket;


proj_surf{1} = proj_surf_wall;
proj_surf{2} = proj_surf_socket;

[dist_edge_wall,proj_edge_wall]     = distance2Edges(X,socket_wall.wall);
[dist_edge_socket,proj_edge_socket] = get_distance_edge_socket_A(X,socket_wall.socket_A);

proj_edge{1}                        = proj_edge_wall;
proj_edge{2} = proj_edge_socket;

%           (N x 2)
dist_surf  = [dist_surf_wall,dist_surf_socket];
dist_edge  = [dist_edge_wall,dist_edge_socket];

[dist_s,I]  = min(dist_surf,[],2);
[dist_e,I2] = min(dist_edge,[],2);


for i = 1:N
    proj_s(i,:)  = proj_surf{I(i)}(i,:);
    proj_e(i,:)  = proj_edge{I2(i)}(i,:);
end


end

end

