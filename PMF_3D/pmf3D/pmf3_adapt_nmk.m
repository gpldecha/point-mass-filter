function [ pmf,boundary,bb,idx_limit] = pmf3_adapt_nmk(pmf,r,frac,margin)
%PMF3_ADAPT_NMK
%
%   As the pmf filter evolves other time the spread of the density will
%   decreases. When the spread decreases the amount of rows and columns of
%   the pmf filter can be reduced.
%   
%   
%   input --------------------------------------------------------------
%
%       o r: (1 x 3), true position of end-reference
%
%       o frac: (1 x 1), fraction after which to recompute n, m and k
%       
%       o b_frac: (1 x 1), percentage to retain for boarders
%
%

% compute current lengths

r = r(:);

I       = find(pmf.P ~= 0);

if isempty(I)
    return
end
    
[Y,Z,X] = ind2sub(size(pmf.P),I);

max_X = max(X);
min_X = min(X);

max_Y = max(Y);
min_Y = min(Y);

max_Z = max(Z);
min_Z = min(Z);

% bounding box length of probablitly mass
l_x = (max_X - min_X + 1) * pmf.delta.m;
l_y = (max_Y - min_Y + 1) * pmf.delta.n;
l_z = (max_Z - min_Z + 1) * pmf.delta.k;


boundary_max = indices2cartesian(pmf.m,pmf.n,pmf.k,pmf.x_ref,[pmf.m,pmf.n,pmf.k],pmf.delta);
boundary_min = indices2cartesian(1,1,1,pmf.x_ref,[pmf.m,pmf.n,pmf.k],pmf.delta);
boundary     = [boundary_max;boundary_min];
% 
bb  = [r + ones(3,1) .* 0.1/2,r - ones(3,1) .* 0.1/2];
bb  = bb';

idx_limit = cartesian2indices(bb(:,1),bb(:,2),bb(:,3),pmf.x_ref,[pmf.m,pmf.n,pmf.k],pmf.delta);
idx_limit = ceil(idx_limit);




bUpdate   = false;
%bUpdate_k = false;

theta_m = pmf.length.m - frac * pmf.length.m;
theta_n = pmf.length.n - frac * pmf.length.n;
theta_k = pmf.length.k - frac * pmf.length.k;


if isempty(find([pmf.m,pmf.n,pmf.k] == 1))
   bUpdate = (l_x < theta_m) || (l_y < theta_n) || (l_z < theta_k );
else
   bUpdate = (l_y < theta_n) || (l_z < theta_k );
end

% bUpdate_n = (l_y < theta_n);
bUpdate_k = (l_z < theta_k);




if(pmf.length.n <= 0.2)
    bUpdate = false; 
end

if(pmf.length.k <= 0.2)
     bUpdate_k = false; 
end


if bUpdate
    
   % disp('adapt nkm');
    
    ref_prior = indices2cartesian(X(1),Y(1),Z(1),pmf.x_ref,[pmf.m,pmf.n,pmf.k],pmf.delta); 
    
    x_margin = 0; %margin;floor(b_frac .* (max_X+1));
    y_margin = margin;%floor(b_frac .* (max_Y+1));
    z_margin = margin;%floor(b_frac .* (max_Z+1));
    delta_Y  = 0;
%  
%     if min_Y > idx_limit(2,2)
%        min_Y = idx_limit(2,2); 
%     end
%     if min_Z > idx_limit(2,3)
%        min_Z = idx_limit(2,3); 
%     end
%     
%     if max_Y < idx_limit(1,2)
%         delta_Y = idx_limit(1,2) - max_Y;
%     end
    
    
    X_    = X - min_X + 1 + x_margin;
    Y_    = Y - min_Y + 1 + y_margin;
    Z_    = Z - min_Z + 1 + z_margin;
    
    
    max_X_ = max(X_);
    max_Y_ = max(Y_);
    max_Z_ = max(Z_);
    
    m     = max_X_ + x_margin;
    n     = max_Y_ + y_margin;
    k     = max_Z_ + z_margin;
        
    W     = nonzeros(pmf.P);
    
    pmf.P = ndSparse.build([Y_,Z_,X_],W,[n,k,m]);    
    
    pmf.n        = n;
    pmf.k        = k;
    pmf.m        = m;
    
    pmf.length.m = pmf.m * pmf.delta.m;
    pmf.length.n = pmf.n * pmf.delta.n;
    pmf.length.k = pmf.k * pmf.delta.k;

    
    ref_post = indices2cartesian(X_(1),Y_(1),Z_(1),pmf.x_ref,[pmf.m,pmf.n,pmf.k],pmf.delta); 

    pmf.x_ref = pmf.x_ref + (ref_prior - ref_post)';

   
    
else
   
    if bUpdate_k
        
       % disp('adapt k');
        ref_prior = indices2cartesian(X(1),Y(1),Z(1),pmf.x_ref,[pmf.m,pmf.n,pmf.k],pmf.delta);
        z_margin = margin;%floor(b_frac .* (max_Z+1));
        
        Z_    = Z - min_Z + 1 + z_margin;
        max_Z_ = max(Z_);
        k     = max_Z_ + z_margin;
        W     = nonzeros(pmf.P);
        
        pmf.P = ndSparse.build([Y,Z_,X],W,[pmf.n,k,pmf.m]);
        
        pmf.k        = k;
        pmf.length.k = pmf.k * pmf.delta.k;
        
        ref_post = indices2cartesian(X(1),Y(1),Z_(1),pmf.x_ref,[pmf.m,pmf.n,pmf.k],pmf.delta);
        pmf.x_ref = pmf.x_ref + (ref_prior - ref_post)';
    end


    
    
end







end

