function socket_A = create_socket_A(socket_zy_pos)
% CREATE_SOCKET_A
%
%   input --------------------------------------------
%   
%   
%

if ~exist('socket_zy_pos','var'), socket_zy_pos = zeros(1,2); end


 dim   = [0.01,0.085,0.085];
origin = [-dim(1)/2,0,0];
 
socket_A.cube = create_cube(dim,origin + [0,socket_zy_pos(:)']);

socket_A.origin = origin;

socket_origin = [0 0 0] + [0,socket_zy_pos(:)'];

socket_A.ring.center       = socket_origin + [0.002 0 0];
socket_A.ring.R            = rpy2r([0,pi/2,0]);
socket_A.ring.r            = 0.0225;


socket_A.left_hole.center  = socket_origin + [0,-0.01,0];
socket_A.left_hole.R       = rpy2r([0,pi/2,0]);
socket_A.left_hole.r       = 0.0025;

socket_A.right_hole        = socket_A.left_hole;
socket_A.right_hole.center = socket_origin + [0,0.01,0];

socket_A.top_hole          = socket_A.left_hole;
socket_A.top_hole.center   = socket_origin + [0,0,0.005];

line_seg_length            = [0.015 0 0];

socket_A.holes_cylinder    = cell(1,3);
C                          = socket_A.left_hole.center;
C(1)                       = C(1) - 0.02;
socket_A.holes_cylinder{1} = create_cylinder(C,socket_A.left_hole.R,socket_A.left_hole.r,0.02);
C                          = socket_A.right_hole.center;
C(1)                       = C(1) - 0.02;
socket_A.holes_cylinder{2} = create_cylinder(C,socket_A.right_hole.R,socket_A.right_hole.r,0.02);
C                          = socket_A.top_hole.center;
C(1)                       = C(1) - 0.02;
socket_A.holes_cylinder{3} = create_cylinder(C,socket_A.top_hole.R,socket_A.top_hole.r,0.02);


socket_A.top_hole_lseg = [socket_A.top_hole.center, socket_A.top_hole.center - line_seg_length];

end

