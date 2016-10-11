function proj = project_points_cylinder(X,cylind)
% PROJECT_POINTS_CYLINDER, project a set of points onto a a cylinder
%   
%   input ------------------------------------------------
%
%       o X: (N x 3), set of 3d cartesian points
%
%       o cylind: cylinder structure
%
%   output ------------------------------------------------
%   
%       o proj: (N x 3), set of points projected onto the cylinders surface
%
%

N    = size(X,1);
proj = zeros(N,3);

%  X in the framce of refrence of the cylinder
X_c         = (cylind.Rot_ref' * X' - repmat((cylind.Rot_ref' * cylind.x_ref'),1,N))';
proj(:,3)   = X_c(:,3);
I           = find(proj(:,3) > cylind.l);
if ~isempty(I)
   proj(I,3)= cylind.l; 
end

I           = find(proj(:,3) < 0);
if ~isempty(I)
   proj(I,3)= 0; 
end

% vec = -X_c(:,1:2);
% (N x 2) vector pointing from cylinder origin to point
vec = normr(X_c(:,1:2));

%     (N x 2) * (2 x 1) = (N x 1)
% angle       = vec *  [1,0]';
% angle       = acos(angle);

% (N x 3), projected points in the cylinders frame of reference
r = cylind.r;
% proj(:,1:2) = [ r .* cos(angle), r .* sin(angle)];
proj(:,1:2) = vec .* r;
proj        = (cylind.Rot_ref * proj' + repmat(cylind.x_ref',1,N))';




end