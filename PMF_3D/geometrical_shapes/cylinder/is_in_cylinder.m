function I = is_in_cylinder(X,cylind)
%IS_IN_CYLINDER Summary Check if points (X) are inside the cylinder
%(cylind)
%   
%   input ------------------------------------------------
%
%       o X: (N x 3), set of 3d cartesian points
%
%       o cylind: cylinder structure
%
%   output ------------------------------------------------
%   
%       o I: (N x 1), binary vector which says if points are in cylinder or
%                     not
%
%

N      = size(X,1);
I      = zeros(N,1);
X_c    = (cylind.Rot_ref' * X' - repmat((cylind.Rot_ref' * cylind.x_ref'),1,N))';

Idx    = find((X_c(:,3) <= cylind.l) & (X_c(:,3) >= 0));

if ~isempty(Idx)
    
   dist  = sqrt(sum(X_c(Idx,1:2).^2,2)); 
   Idx2  = find(dist < cylind.r);
   if ~isempty(Idx2)
      I(Idx(Idx2)) = 1; 
   end
    
end



end

