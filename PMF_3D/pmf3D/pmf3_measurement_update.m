function [pmf,hY,pos,L] = pmf3_measurement_update(pmf,Y,hY_f,likelihood_f,hY_isinside,get_tip,socket_wall)
%PMF3_MEASUREMENT_UPDATE Summary of this function goes here
% 
%
%   input --------------------------------------------------------
%
%       o pmf: point mass filter  structure
%
%       o Y: (K x 1), actual measurement
%
%       o hY_func, function handle expected measurement function 
%
%       o lik_func, function handle to likelihood function
%
%   Comments -----------------------------------------------------
%
%       o hY = hY_funct(pos)
%            
%       o  L = lik_func(hY,{Y})
%             - Y: (generic) , acctual measurement comming from the agents
%                              sensors.. set in anonymous function
%
%             - hY: (generic), expected measurement, computed from the
%                             measurement function
%           
%


I             = find(pmf.P > 0);

if ~isempty(I)
    [Y_I,Z_I,X_I]   = ind2sub(size(pmf.P),I);
    
    pos           = indices2cartesian(X_I,Y_I,Z_I,pmf.x_ref,[pmf.m,pmf.n,pmf.k],pmf.delta);
    
    bIn           = hY_isinside(pos);
    tip_pos       = get_tip(pos);
    hY            = hY_f(tip_pos);
    L             = likelihood_f(Y,hY,bIn);
    
        
    
   % bInWall          = is_inside_w(tip_pos(:,1:3),socket_wall);
   % L(bIn) = 0;
%[b_inside,~,b_in_cylinder] = is_inside_socket(tips,socket_wall);
    
    
    pmf.P(I) = pmf.P(I) .* L;% reshape(L,[m n k]);
    if sum(pmf.P(I)) == 0
     %   disp('sum(pmf.P(I)) == 0');
    end
    
    pmf.P    = pmf.P / (sum(pmf.P(:)) + realmin);
    
    
    pmf.N = size(nonzeros(pmf.P),1);
    
else
    
    disp('measurement update I is empty');
    
end



end

