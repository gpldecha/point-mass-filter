function [pmf] = pmf3_motion2(pmf,u,k,dt,bConvolve)
% PMF3_MOTION  Point Mass Filter (3D) Motion update
%   input -----------------------------------------
%
%       o pmf struct
%
%       o u: (3 x 1), velocity action
%
%       o k:
%

% make kernel matrix


pmf.x_ref  = pmf.x_ref + u';

if ~exist('bConvolve','var'),bConvolve=false;end

if bConvolve
    
    l         = 3;
    u_vel     = (u .* 10) ./dt; % velocity (m/s) -> (cm/s)
    variance  = k * k * u_vel.^2 + realmin; %(3 x 1)
    one_var   = 1./variance;
    x           = (-l:1:l) * pmf.delta.n;
    K_x       =  -0.5 .* one_var(1) .* x.^2;
    K_y       =  -0.5 .* one_var(2) .* x.^2;
    K_z       =  -0.5 .* one_var(3) .* x.^2;
    
    K_x      = exp(K_x);
    K_y      = exp(K_y);
    K_z      = exp(K_z);
    
    K_x      = K_x./sum(K_x);
    K_y      = K_y./sum(K_y);
    K_z      = K_z./sum(K_z);
    
    if isempty(find([pmf.m,pmf.n,pmf.k] == 1))
        pmf.P     = convn(K_y,K_z,K_x,pmf.P,'same');
    else
        pmf.P     = convn(K_z,K_y,pmf.P,'same');
    end
    pmf.P      = pmf.P ./ sum(pmf.P(:));
    
end


end

