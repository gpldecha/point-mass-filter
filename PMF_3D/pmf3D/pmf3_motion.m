function [pmf,dist_travled] = pmf3_motion(pmf,u,sigma,dist_travled,threashold,bConvolve)
% PMF3_MOTION  Point Mass Filter (3D) Motion update
%   input -----------------------------------------
%
%       o pmf struct
%
%       o u: (3 x 1), velocity action
%
%       o gaussian_kernel: (1 x P)
%
%       o threashold: (1 x 1), after what distance do I add Gaussian Noise
%
%       o dist_travled: 
%


% make kernel matrix

u = u(:);


pmf.x_ref     = pmf.x_ref + u;
dist_travled  = dist_travled + norm(u);


if(dist_travled >= threashold && bConvolve)
    l            = 3;
    x            = (-l:1:l) * pmf.delta.n;
    kernel       = exp(-0.5*(1/(sigma*sigma)) .* x.^2);
    kernel       = kernel./sum(kernel);
    if(sum(isnan(kernel)) ~= 0)
       kernel = zeros(1,length(kernel));
       kernel(l+1) = 1;
    end
    
    if isempty(find([pmf.m,pmf.n,pmf.k] == 1))
        pmf.P     = convn(kernel,kernel,kernel,pmf.P,'same');
    else
        pmf.P     = convn(kernel,kernel,pmf.P,'same');
    end
    pmf.P      = pmf.P ./ sum(pmf.P(:));
    dist_travled = 0;
end


end

