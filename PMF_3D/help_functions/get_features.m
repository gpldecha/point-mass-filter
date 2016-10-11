function [F] = get_features(XYZW)
%GET_FEACTURES Get featrues from a point cloud.
%
%   input -----------------------------------------------------------------
%
%       o XYZW  : (N x 4), point cloud
%
%   output ----------------------------------------------------------------
%
%       o F : (D x 1), returned feature
%
%

mean_w   = weighted_mean(XYZW);
Sigma_w  = (repmat(XYZW(:,4),1,3) .* (XYZW(:,1:3) - repmat(mean_w,size(XYZW,1),1)))' * (XYZW(:,1:3) - repmat(mean_w,size(XYZW,1),1));
Sigma    = Sigma_w + eye(3,3) .* 1e-05;
H        = 0.5 * log( 4.9822e+03 * det(Sigma));
F        = [mean_w(:);H];


    




end

