function [socket_wall_A] = create_socket_wall_A(bSmall,socket_zy_pos)
%CREATE_SOCKET_WALL_A 


if ~exist('socket_zy_pos','var'), socket_zy_pos = [0,0]; end

socket_wall_A.socket_A = create_socket_A(socket_zy_pos);





wall_w      = 0.8;
if ~exist('bSmall','var')
        wall_h      = 0.4;%0.02
else
    if bSmall == true
        wall_h      = 0.02;
    else
        wall_h      = 0.4;
    end
end
wall_l      = 0.4;
wall_origin  = [-wall_h/2,0,0];

wall_origin = wall_origin + socket_wall_A.socket_A.origin;

socket_wall_A.wall      = create_cube([wall_h,wall_w,wall_l],wall_origin);
socket_wall_A.wall_w    = wall_w;
socket_wall_A.wall_h    = wall_h;
socket_wall_A.wall_l    = wall_l;


end

