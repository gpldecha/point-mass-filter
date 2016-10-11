function [ proj_pts,I ] = project_points_onto_surfaces(X,socket_wall)
%PROJECT_POINTS_ONTO_SURFACES 


[~, proj_surf_wall,~,I]    = distance2surf(X,socket_wall.wall);

n = zeros(size(I,1),3);

proj_pts = [];

for i=1:size(I,1)
    n(i,:) = socket_wall.wall.surface(end,:,I(i));
    
    tmp = proj_surf_wall(i,:);
    tmp(n(i,:) ~= 0) = [];
    proj_pts = [proj_pts;tmp];
    
end



end

