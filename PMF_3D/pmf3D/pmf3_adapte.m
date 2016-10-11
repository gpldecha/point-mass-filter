function [pmf,b_interpolated] = pmf3_adapte(pmf)
%PMF3_ADAPTE Adapts the resolution of the pmf according to the lower and
% upper threashold No and N1.
%
%   input -----------------------------------------------------------------
%
%       o pmf, struct
%

m = pmf.m;
n = pmf.n;
k = pmf.k;
b_interpolated = false;

if (pmf.N < pmf.No) && (pmf.delta.n > pmf.min_delta_n)       % interpolate
    
    %disp('--> interpolate');
    b_interpolated = true;
    I       = find(pmf.P ~= 0);
    %[X,Y,Z] = ind2sub(size(pmf.P),I);
    [Y,Z,X] = ind2sub(size(pmf.P),I);
         W  = nonzeros(pmf.P);
  
     % get the lengths of each dimension
     l_y = max(Y) - min(Y);
     l_z = max(Z) - min(Z);
     l_x = max(X) - min(X);
     
     %  Compute how many new rows and colums
            
         
    % new indicies
    X_ = 2*X-1;
    Y_ = 2*Y-1;
    Z_ = 2*Z-1;
    % values
    % pmf.P = ndSparse.build([X_,Y_,Z_],W,[(2*m)-1,(2*n)-1,(k*2)-1]);
    pmf.P = ndSparse.build([Y_,Z_,X_],W,[(2*n)-1,(k*2)-1,(2*m)-1]);
    
    pmf.n        = size(pmf.P,1);
    pmf.k        = size(pmf.P,2);
    pmf.m        = size(pmf.P,3);
    
%     pmf.m        = size(pmf.P,1);
%     pmf.n        = size(pmf.P,2);
%     pmf.k        = size(pmf.P,3);
    pmf.delta.m  = pmf.delta.m/2;
    pmf.delta.n  = pmf.delta.n/2;
    pmf.delta.k  = pmf.delta.k/2;
    
    % Interpolation
    kernel = [0.5,0.5];
    
    if isempty(find([pmf.m,pmf.n,pmf.k] == 1))
        pmf.P = convn(kernel,kernel,kernel,pmf.P,'same');
    else
        pmf.P = convn(kernel,kernel,pmf.P,'same');
    end
 
    pmf.P        = pmf.P ./ sum(pmf.P(:));
    pmf.N        = nnz(pmf.P);
    
elseif pmf.N > pmf.N1     % decimate
    
   % disp('--> decimate');
    
    pmf.P        = pmf.P(1:2:n,1:2:k,1:2:m);
    pmf.n        = size(pmf.P,1);
    pmf.k        = size(pmf.P,2);
    pmf.m        = size(pmf.P,3);
    pmf.delta.m  = 2 * pmf.delta.m;
    pmf.delta.n  = 2 * pmf.delta.n;
    pmf.delta.k  = 2 * pmf.delta.k;
    pmf.N        = nnz(pmf.P);
     
end



end



