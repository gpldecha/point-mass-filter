function [ corr_vec,proj] = correct_plug_position(tip_position,socket_wall)
%CORRECT_PLUG_POSITION
%
%   input ---------------------------------------------------------
%
%       o tip_position: (1 x 9)
%
%       o ref_position: (1 x 3)
%
%       o socket_wall: socket structure
%
%

tips = [tip_position(1,1:3);
        tip_position(1,4:6);
        tip_position(1,7:9)];

corr_vec = zeros(1,3);


bInCube        = is_inside_w(tips,socket_wall);
I              = find(bInCube == 1);

if ~isempty(I)
    
    [d,proj]     = distance2surf(tips,socket_wall.wall,1);
    [~,idx]      = max(d(I));
    corr_vec     = proj(I(idx),:) - tips(I(idx),:);
end

end

