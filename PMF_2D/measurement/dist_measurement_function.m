function Y = dist_measurement_function(pos,rot,line_seg,Sigma)
%DIST_MEASUREMENT_FUNCTION
%
%   input ----------------------------------------------------
%
%         o pos:   (N x 2), Cartesian position
%
%         o rot:   (2 x 2), rotation matrix
%
%         o line_seg: line segment (1 x 4)
%
%         o Sigma: (2 x 2), measurement noise;
%
%   output ---------------------------------------------------
%
%         o Y: (N x 2), range and angle vector
%

%       proj: (N x 2)

N = size(pos,1);
Y = zeros(N,2);

[~, proj] = dist2line2D(pos,line_seg);

if ~isempty(Sigma)
   proj        = proj + mvnrnd([0,0],Sigma,N);    
end

%         (2 x 2) (2 x N) - (2 x 2) * (N x 2)
proj_afr = (rot' * proj' -rot' * pos')';

Y(:,1)      = sqrt(sum((pos - proj).^2,2)) + realmin;
%      (2 x 2) (2 x N)
Y(:,2)     =  atan2(proj_afr(:,2),proj_afr(:,1));


end



