function [ pmf ] = initialise_pmf_3D_gaussian(pmf,Mu,Var)
%INITIALISE_PMF_3D_GAUSSIAN 
%
%
%
% 
% n = pmf.n;
% m = pmf.m;
% k = pmf.k;
% 
% % pmf.P = ones(m,n,k);
% % pmf.P = pmf.P/sum(pmf.P(:));
% 
% dm = pmf.delta.m;
% dn = pmf.delta.n;
% dk = pmf.delta.k;
% 
% % index       = find(pmf.P >  0);
% % [X,Y,Z]     = ind2sub(size(pmf.P),index);
% % 
% % X = (X-1) * dm - (m*dm)/2 + pmf.x_ref(1);
% % Y = (Y-1) * dn - (n*dn)/2 + pmf.x_ref(2);
% % Z = (Z-1) * dk - (k*dk)/2 + pmf.x_ref(3);
% 
% xs = 0:dm:(dm*m);
% ys = 0:dn:(dn*n);
% zs = 0:dk:(dk*k);
% 
% xs = xs([1:m]);
% ys = ys([1:n]);
% zs = zs([1:k]);
%  
% xs = xs - (n*dn)/2;% + pmf.x_ref(2);
% zs = zs - (m*dm)/2;% + pmf.x_ref(1);
% ys = ys - (k*dk)/2;%

index           = find(pmf.P >=  0);
[Y_I,Z_I,X_I]   = ind2sub(size(pmf.P),index);
X               = indices2cartesian(X_I,Y_I,Z_I,pmf.x_ref,[pmf.m,pmf.n,pmf.k],pmf.delta);  
X               = X - repmat(Mu,size(X,1),1);
% 
w = exp(-0.5 * 1/Var *(X(:,1).^2 + X(:,2).^2 + X(:,3).^2));
pmf.P(index) = w;

%pmf.P = ndSparse(w);
pmf.P = pmf.P / sum(pmf.P(:));

pmf.N = nnz(pmf.P);


end

