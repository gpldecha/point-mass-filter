function b_in_contact = sw_is_in_contact(middle_tip_position,socket_wall,delta)
%SW_IS_IN_CONTACT Checks of the peg is in contact with a surface or not 
%           
%   input ------------------------------------------------------------
%
%       o middle_tip_position
%
%      (legacy) o r: (N x 3), Cartesian position of the frame of reference of the
%                     peg handle.
%
%      (legacy) o q: (1 x 4), Quaternion orientation of the frame of reference.
%                     There is only 1, because all N points have the same 
%                     orientation.
%
%       o socket_wall, struct
%
%           socket_A: [1x1 struct]
%           wall:     [1x1 struct]
%           wall_w: 0.8000
%           wall_h: 0.0200
%           wall_l: 0.4000
%
%       o delta, the amount to extend the boundary of the actual wall
%
%

% (N x 3)
%tip_mid_pos   = get_peg_tip_positions(r,q,2);

xyz_wall        = get_cube_xyz(socket_wall.wall);
xyz_socket      = get_cube_xyz(socket_wall.socket_A.cube);

origin_wall     = socket_wall.wall.origin;
origin_socket   = socket_wall.socket_A.cube.origin;

xyz_wall(:,1)   = xyz_wall(:,1) - delta;
xyz_wall(:,2)   = xyz_wall(:,2) + delta;

xyz_socket(1,2) = xyz_socket(1,2) + delta;

b_in_contact    = bounding_box3(middle_tip_position,origin_wall,xyz_wall) | bounding_box3(middle_tip_position,origin_socket,xyz_socket);


end

