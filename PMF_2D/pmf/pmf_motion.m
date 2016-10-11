function [pmf,Dr,Dc] = pmf_motion(pmf,kernel)
%PMF_MOTION Point Mass Filter Motion update
%
%   input -----------------------------------------
%
%       o pmf struct
%
%       o nd: (1 x 2), diagonal elements of the noise covariance
%                   matrix
%
%       o l: number of points in the convolution kernel (should be odd
%       number)
%
%       o detla: distance between points 
%       
warning ('off','all');
kernel = kernel(:);

c = [kernel;zeros(pmf.m-1,1)];
r = zeros(1,pmf.m)';

% c = [kernel_x;zeros(pmf.m-(2*l+1),1)];
% r = zeros(1,pmf.m)';

Dr = toeplitz(c,r)';


% c = [kernel_y;zeros(pmf.n-1,1)];
% r = zeros(1,pmf.n)';

c = [kernel;zeros(pmf.n-1,1)];
r = zeros(1,pmf.n)';

Dc = toeplitz(c,r);

Dc = sparse(Dc);
Dr = sparse(Dr);

m_new  = size(Dc,1);
n_new  = size(Dr,2);
m_diff = m_new - pmf.m; 
n_diff = n_new - pmf.n; 


% pmf.x_ref = pmf.x_ref + u;
pmf.P     = Dc * pmf.P * Dr;

num_rm_m = m_diff/2;
num_rm_n = n_diff/2;

index_rm_m = [(1:num_rm_m),(m_new-num_rm_m)+1:m_new];
index_rm_n = [(1:num_rm_n),(n_new-num_rm_n)+1:n_new];

pmf.P(index_rm_m,:) = [];
pmf.P(:,index_rm_n) = [];

pmf.P  = bsxfun(@rdivide,pmf.P,sum(pmf.P(:)));

pmf.m = size(pmf.P,2);
pmf.n = size(pmf.P,1);

pmf = pmf_truncation(pmf);
warning ('on','all');






end

