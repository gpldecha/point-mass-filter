function [d,proj] = distance2corners(x_t,corners )
%DISTANCE2CORNERS
%   Computes the distance to all corners
%
%   input -----------------------------------------------------------------
%
%       o x_t: (N x 3), where N, is the number of Samples
%
%       o corners: (K x 3), where K, is the number of corners
%   output ---------------------------------------------------------------
%
%       o d: (N x K), distance "euclidean" to each corner
%
%


N = size(x_t,1);
K = size(corners,1);

d = zeros(N,K);


for i=1:N
    d(i,:) = sqrt(sum( (repmat(x_t(i,:),K,1) - corners).^2 ,2)) ;
end

proj = corners;


end

