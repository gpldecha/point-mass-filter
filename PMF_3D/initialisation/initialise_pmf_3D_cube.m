function [pmf,particle_agent_id] = initialise_pmf_3D_cube(pmf,pos_agent)
%INITIALISE_PMF_3D_PDF
%
%   Initialise the point mass filter in its frame of reference
%
%   input ------------------------------------------------------
%
%       o pmf: point mass filter struct
%
%       o pos_agent: (3 x 1)
%

n = pmf.n; % y
m = pmf.m; % x
k = pmf.k; % z

bInitiTest = false;

pmf.P = ndSparse(ones(n,k,m));
%pmf.P = ndSparse(zeros(n,k,m));
particle_agent_id=1;

if(bInitiTest)
    
   n1 = 0.2*n;
   k2 = 0.2*k;
    
   pmf.P(1:n1,:,:)       = 0;
   pmf.P((n-n1):n,:,:)   = 0;
   pmf.P(:,1:k2,:)       = 0;
   pmf.P(:,(k-k2):k,:)   = 0;

end


pmf.P = pmf.P/sum(pmf.P(:));


if exist('pos_agent','var')
    
    index           = find(pmf.P >=  0);
%    [X_I,Y_I,Z_I]   = ind2sub(size(pmf.P),index);
    [Y_I,Z_I,X_I]   = ind2sub(size(pmf.P),index);


    hpos            = indices2cartesian(X_I,Y_I,Z_I,pmf.x_ref,[pmf.m,pmf.n,pmf.k],pmf.delta);   
    dist            = sqrt(sum((hpos - repmat(pos_agent,size(hpos,1),1)).^2,2));
    [~,I]           = min(dist);
    
    hpos_min          = hpos(I(1),:);
    pmf.x_ref         = pmf.x_ref + (pos_agent - hpos_min)';
    particle_agent_id = I(1);
    
end

% idx = cartesian2indices(pmf.x_ref(1),pmf.x_ref(2),pmf.x_ref(3),pmf.x_ref,[pmf.m,pmf.n,pmf.k],pmf.delta);
% pmf.P(idx) = 1;
pmf.P = pmf.P/sum(pmf.P(:));

pmf.N = nnz(pmf.P);


end

