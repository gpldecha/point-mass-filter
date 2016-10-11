function pmf = pmf_adapte(pmf)
%PMF_ADAPTE Adapts the resolution of the pmf according to the lower and
% upper threashold No and N1.
%
%   input -----------------------------------------------------------------
%
%       o pmf, struct
%

m = pmf.m;
n = pmf.n;

if pmf.N < pmf.No         % interpolate
    
    disp('interpolate');
%   P_new = zeros(2*m+1,2*n+1);    
    P_new = zeros(2*m,2*n);
    
    I     = find(pmf.P ~= 0);
    [X,Y] = ind2sub(size(pmf.P),I);
    X_ = 2*X-1;
    Y_ = 2*Y-1;
    
    P_new(X_,Y_) = pmf.P(X,Y);
    
    pmf.P        = P_new;
    pmf.m        = size(P_new,1);
    pmf.n        = size(P_new,2);
    pmf.delta    = pmf.delta/2;
    pmf.N        = pmf.n * pmf.m;
    pmf          = pmf_motion(pmf,[0 0]',[1 1],3);
    
elseif pmf.N > pmf.N1     % decimate
    
    disp('decimate');
    
    pmf.P        = pmf.P(1:2:m,1:2:n);
    pmf.m        = size(pmf.P,1);
    pmf.n        = size(pmf.P,2);
    pmf.delta    = 2 * pmf.delta;
    pmf.N        = pmf.n * pmf.m;
    
end



end

