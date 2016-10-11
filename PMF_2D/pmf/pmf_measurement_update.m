function [pmf] = pmf_measurement_update(pmf,hY_func,lik_func)
%PMF_MEASUREMENT_UPDATE 
%
%   input --------------------------------------------------------
%
%       o pmf: point mass filter  structure
%

%       o hY_func, function handle expected measurement function 
%
%       o lik_func, function handle to likelihood function
%
%   Comments -----------------------------------------------------
%
%       o hY = hY_funct(pos)
%               pos: (N x 2)
%           
%
%       o  L = lik_func(hY,{Y})
%             - Y: (1 x M), acctual measurement comming from the agents
%                           sensors.. set in anonymous function
%
%             - hY: (1 x M), expected measurement, computed from the
%                            measurement function
%           
%

I     = find(pmf.P ~= 0);
[x_pos,y_pos] = ind2sub(size(pmf.P),I);

d = pmf.delta;
n = pmf.n;
m = pmf.m;

x_pos   = x_pos - (n*d) + pmf.x_ref(1);
y_pos   = y_pos - (m*d) + pmf.x_ref(2);
pos = [x_pos,y_pos];

hY  = hY_func(pos);
L   = lik_func(hY);

pmf.P(I) = pmf.P(I) .* L;
pmf.P    = pmf.P / sum(pmf.P(:));


end

