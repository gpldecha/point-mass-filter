function handle= plot_likelihood(handle_axes,Y,agent_orient,lik_func,hy_func,handle)
%PLOT_LIKELIHOOD Summary of this function goes here
%   Detailed explanation goes here
%
%   % input ---------------------------------------------------------------
%
%       o current axis handle (gca)    
%
%       o lik_func: likelihood function
%
%       o hy_func:  measurement function
%
%       o handle: handle to previous plot of this function (for simulation)
%
%   Comments -----------------------------------------------------
%
%       o  L = lik_func(X), give state vector X: (N x 2)
%                           evaluates the likelihood, L: (N x 1)

xs      = linspace(-12,12,60);
[x,y]   = meshgrid(xs,xs);


pos    = [x(:),y(:)];

if ~isempty(agent_orient)
    hY      =  hy_func(pos,agent_orient);
else
    hY      =  hy_func(pos);
end

L       =  lik_func(Y,hY);


L       = reshape(L,size(x));

if isempty(handle)
    
    handle  = pcolor(handle_axes,x,y,L); shading interp;
    cmap    = flipud(colormap(gray));
    colormap(cmap);
    %colorbar
    
else
    
    set(handle,'CData',L);
        
end

end

