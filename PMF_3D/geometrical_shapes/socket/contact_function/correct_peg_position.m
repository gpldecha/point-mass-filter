function [x_new,R_new,corr_vec] = correct_peg_position(x_ref,R_ref,socket_wall)
% CORRECT_PEG_POSITION Checks that the tip of the pegs and the
%  frame of reference are not inside any objects.
%
%
%   input --------------------------------------
%
%       o x_ref: (1 x 3), frame of reference of the peg model
%
%       o R_ref: (3 x 3), orientation matrix
%
%       o peg_model: (N x 3), set of car
%


tip_position    = get_peg_tip_positions(x_ref,R_ref);
tips            = [tip_position(1,1:3);
    tip_position(1,4:6);
    tip_position(1,7:9)];

x_new        = x_ref;
R_new        = R_ref;



% Check if tips are inside wall
bInWall             = is_inside_w(tips,socket_wall);
[b_inside,~,b_in_cylinder] = is_inside_socket(tips,socket_wall);

bIn = xor(bInWall,b_in_cylinder);

% if bInWall
%     disp('bInWall: true');
% end
% if b_inside
%     disp('b_inside: true');
% end
% if b_in_cylinder
%     disp('b_in_cylinder');
% end

I = find(bIn == 1);
if ~isempty(I)
    [d,proj]     = distance2surf(tips,socket_wall.wall,1);
    [~,idx]      = max(d(I));
    corr_vec     = proj(I(idx),:) - tips(I(idx),:);
    x_new        = x_new + corr_vec;
end

I = find(b_inside);
if ~isempty(I)
    [d,proj]     = distance2surf(tips,socket_wall.socket_A.cube,1);
    [~,idx]      = max(d(I));
    corr_vec     = proj(I(idx),:) - tips(I(idx),:);
    x_new        = x_new + corr_vec;
end




% Check if frame of reference is inside wall
bInWall      = is_inside_w(x_new,socket_wall);
I            = find(bInWall == 1);
if ~isempty(I)
    [~,proj]     = distance2surf(x_new,socket_wall.wall,1);
    corr_vec     = proj - x_new;
    n            = corr_vec./norm(corr_vec);
    x_new        = x_new + corr_vec + 0.015 .* n;
end


% Check if frame of reference is inside socket
bInSocket = is_inside_socket(x_new,socket_wall);


I         = find(bInSocket);
if ~isempty(I)
    [~,proj]     = distance2surf(x_new,socket_wall.socket_A.cube,1);
    corr_vec     = proj - x_new;
    x_new        = x_new + corr_vec;
end








end