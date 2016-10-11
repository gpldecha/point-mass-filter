function [dist,proj_final] = get_projection_dist_sw(X,socket_wall,is_in_sw_f)
%GET_PROJECTION_SW Get closet distance to surface of the socket_wall object
%
%   
%
%   input ----------------------------------------------
%
%       o X: (N x 3), cartesian points
%
%       o socket_wall, structure
%
%

N           = size(X,1);
proj_cyl    = cell(1,4);


% proj_w cell(1,6)
[~,~,proj_w]  = distance2surf(X,socket_wall.wall);
[~,~,proj_s]  = distance2surf(X,socket_wall.socket_A.cube);

proj_c = [proj_w,proj_s];

proj_cyl{1} = get_boundary_points(proj_c,X,is_in_sw_f);
d_ws        = sqrt(sum((X - proj_cyl{1}).^2,2));


proj_cyl{2}    = project_points_cylinder(X,socket_wall.socket_A.holes_cylinder{1});
proj_cyl{3}    = project_points_cylinder(X,socket_wall.socket_A.holes_cylinder{2});
proj_cyl{4}    = project_points_cylinder(X,socket_wall.socket_A.holes_cylinder{3});



d_cyl1       = sqrt(sum((X - proj_cyl{2}).^2,2));
d_cyl2       = sqrt(sum((X - proj_cyl{3}).^2,2));
d_cyl3       = sqrt(sum((X - proj_cyl{4}).^2,2));
[dist,I]     = min([d_ws,d_cyl1,d_cyl2,d_cyl3],[],2);


% I \in [1,2,3,4,5]
% (N x (3 * 5))
%proj    = [proj_ws,proj_cyl1,proj_cyl2,d_cyl3];

% proj    = [proj_cyl1,proj_cyl2,d_cyl3];
% 
% I_s = (I - 1) * 3 + 1;
% I_e = I_s + 2;
% 
% Idx = [I_s,I_s+1,I_s+2];

proj_final = zeros(N,3);
for i=1:N
    proj_final(i,:) = proj_cyl{I(i)}(i,:);
end


end

function proj = get_boundary_points(proj_c,X,is_in_sw_f)
%
%   input ----------------------------------------------
%
%       o proj_c: cell(1,12)
%           - proj_c{1}: (N x 3), projection onto plane 1
%
%       o is_in_sw_f: function handle which checks if the points are inside
%                     the socket wall object or not.
%
%

N   = size(X,1);

bIn  = zeros(N,size(proj_c,2));
proj = zeros(N,3);

for i=1:size(proj_c,2)
    bIn(:,i) = is_in_sw_f(proj_c{i});    
end

for i=1:N
 I = find(bIn(i,:) == 0); % points which are not inside the object 
 
 proj_I = proj_c(I);
 dist   = zeros(1,size(proj_I,2));

 for j=1:size(proj_I,2)
     dist(j) = sqrt(sum((proj_I{j}(i,:) - X(i,:)).^2,2));     
 end
 
 [~,I] = min(dist);
 proj(i,:) = proj_I{I}(i,:);
 
 
end




end


