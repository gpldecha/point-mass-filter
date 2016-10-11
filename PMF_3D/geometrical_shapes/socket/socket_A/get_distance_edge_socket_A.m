function [d_m,proj] = get_distance_edge_socket_A(X,socket_A)
%GET_DISTANCE_EDGE_SOCKET_A
%
%   input -----------------------------------------------------
%
%       o X: (N x 3)
%
%


% d:    (N x 1)
% proj: (N x 3)

[d,x_proj] = distance2Edges(X,socket_A.cube);

C  = socket_A.ring.center';
R  = socket_A.ring.R;
r  = socket_A.ring.r;

[d_rr,K_rr] = distance_circle(X,C,R,r);

C  = socket_A.left_hole.center';
R  = socket_A.left_hole.R;
r  = socket_A.left_hole.r;

[d_l,K_l] = distance_circle(X,C,R,r);

C  = socket_A.right_hole.center';
R  = socket_A.right_hole.R;
r  = socket_A.right_hole.r;

[d_r,K_r] = distance_circle(X,C,R,r);

C  = socket_A.top_hole.center';
R  = socket_A.top_hole.R;
r  = socket_A.top_hole.r;

[d_t,K_t] = distance_circle(X,C,R,r);

% (N x 5)
d_all       = [d,d_rr,d_l,d_r,d_t];



% ( N x 3 * 5)
proj_x    = cell(1,5);
proj_x{1} = x_proj; % (N x 3)
proj_x{2} = K_rr;   % (N x 3)
proj_x{3} = K_l;    % (N x 3)
proj_x{4} = K_r;    % (N x 3)
proj_x{5} = K_t;    % (N x 3)


[d_m,I] = min(d_all,[],2);

proj    = zeros(size(X,1),3);




% I: (N x 1)
for i = 1:size(X,1)
    
    tmp = proj_x{I(i)}(i,:);
    
   proj(i,:) = tmp;
    
end











end

