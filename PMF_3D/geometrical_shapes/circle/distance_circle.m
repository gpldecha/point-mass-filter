function [distances,K] = distance_circle(X,C,R,r)
%DISTANCE_CIRCLE
%
%   input ------------------------------------------ 
%   
%       o X: (N x 3), set of Cartesian points
%
%       o C: (3 x 1), position of the circle                     
%       
%       o R: (3 x 3), orientation of the circle
%
%       o radius: (1 x 1)
%
%   output ----------------------------------------
%
%       o distances: (N x 1)
%
%       o K: (N x 3), projections
%


U         = R(:,1);
V         = R(:,2);
invR      = R';

N = size(X,1);

% (3 x N)  = (3 x 3) * (3 x N) - (3 x 3) * (3 x N)


P_c = invR * X' - invR * repmat(C,1,N);

denom = sqrt(P_c(1,:) .* P_c(1,:) + P_c(2,:) .* P_c(2,:));

% (1 x N)                            (3 x 1)
% (3 x N) *                          (3 x N)
comp_1 = repmat(P_c(1,:) ./ denom,3,1) .* repmat(U,1,N);
comp_2 = repmat(P_c(2,:) ./ denom,3,1) .* repmat(V,1,N);

%    (3 x N)
K = repmat(C,1,N) + r .* (comp_1 + comp_2);

% (N x 3)
K = K';

distances = sqrt(sum((K - X).^2,2));

distances = distances(:);


end

