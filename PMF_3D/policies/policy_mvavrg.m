function [ s ] = policy_mvavrg(u,utmp,alpha)
%policy_mvavrg Exponential Moving Average
%
%   input -----------------------------------------------------------------
%
%       o u : (3 x 1), linear velocity
%
%       o utmp : (3 x 1), linear velocity of previous time step
%
%
%       o alpha : (1 x 1), exponential decay weight
%
%
%   output ----------------------------------------------------------------
%
%       o s : (3 x 1), moving average
%
%
u    = u(:);
utmp = utmp(:);


if sum(utmp)==0
    s = u;
else
    utmp = utmp ./ (norm(utmp) + realmin);
    u    = u ./ (norm(u) + realmin);

    
    s = alpha * u + (1 - alpha) * utmp;
end

s = s ./ (norm(s) + realmin);


end

