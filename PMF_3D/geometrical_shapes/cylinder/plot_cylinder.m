function [ handle ] = plot_cylinder(cylind,handle)
%PLOT_CYLINDER 
%
%    input ----------------------------------------------
%
%       o cylinder: structure containing the parameters of the cylinder
%
%       o handle: handle to cylinder plot object
%
%


if ~exist('handle','var')
    
    
r       = [cylind.r cylind.r];
l       = cylind.l;
n       = 20;
[X,Y,Z] = cylinder(r,n);
Z       = Z .* l;
points = [X(:) Y(:) Z(:)];
N      = size(points,1);
points = (cylind.Rot_ref * points' + repmat(cylind.x_ref',1,N))'; 

X = reshape(points(:,1),2,21);
Y = reshape(points(:,2),2,21);
Z = reshape(points(:,3),2,21);

handle = surf(X,Y,Z);hold on;
set(handle,'EdgeColor','None','FaceColor', [0.5 0.5 0.5], 'FaceLighting', 'phong');
    
    
else
    
end



end

