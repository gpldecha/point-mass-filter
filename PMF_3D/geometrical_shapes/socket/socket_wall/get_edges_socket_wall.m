function [ edges ] = get_edges_socket_wall(socket_wall)
%GET_EDGES_SOCKET_WALL 



edges_socket = get_edges_from_surf(socket_wall.socket_A.cube,1);
edges_wall   = get_edges_from_surf(socket_wall.wall,1);

edges = [edges_wall;
        edges_socket];


end

