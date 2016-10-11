function socket_B = create_socket_B()
%CREATE_SOCKET_B
%


 dim   = [0.01,0.085,0.085];
origin = [-dim(1)/2,0,0];


socket_B.cube   = create_cube(dim,origin);
socket_B.origin = origin;

socket_origin   = [0 0 0];

C =  socket_origin + [0.002 0 0];
C = C(:);
R = rpy2r(pi/2,0,pi/2);
r = 0.0225;
socket_B.disk   = create_disk(C,R,r);


end

