function [ b_inside,b_in_c,b_in_cylinder] = is_inside_socket(X,socket_wall)
%IS_INSIDE_SOCKET Summary of this function goes here
%   Detailed explanation goes here


origin_scoket   = socket_wall.socket_A.origin;
xyz_socket      = get_cube_xyz(socket_wall.socket_A.cube);

b_in_c    = bounding_box3(X,origin_scoket,xyz_socket);

b_in_cylinder = is_in_cylinder(X,socket_wall.socket_A.holes_cylinder{3}) | is_in_cylinder(X,socket_wall.socket_A.holes_cylinder{2}) | is_in_cylinder(X,socket_wall.socket_A.holes_cylinder{1});

b_inside  = b_in_c & not(b_in_cylinder);



end

