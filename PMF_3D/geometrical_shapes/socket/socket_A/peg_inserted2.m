function  Y = peg_inserted2(tip_positions,socket_wall)
%PEG_INSERTED2 Measurement function which returns a binary observation on
% wheather these pegs are inside the plug's socket.
%
%   input ----------------------------------------------------
%
%       o tip_positions: (N x 9), Cartesian position of the peg tips
%
%       o socket_wall: structure of the world
%
%   output ----------------------------------------------------
%
%      o Y: (N x 1), binary 
%
%
%

% (N x 1)
Y = b_in_plug_holes(tip_positions(:,1:3),socket_wall) & b_in_plug_holes(tip_positions(:,4:6),socket_wall) & b_in_plug_holes(tip_positions(:,7:9),socket_wall);


end

function b_in_cylinder = b_in_plug_holes(X,socket_wall)


b_in_cylinder = is_in_cylinder(X,socket_wall.socket_A.holes_cylinder{3}) | is_in_cylinder(X,socket_wall.socket_A.holes_cylinder{2}) | is_in_cylinder(X,socket_wall.socket_A.holes_cylinder{1});

end

