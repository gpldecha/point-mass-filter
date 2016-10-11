function pmf = pmf_truncation(pmf)
%PMF_TRUNCATION removes grid points which have a probability below 
%   the average weight by a factor of epsilon
%   
%
%disp('truncation');
% index        = find(pmf.P <= pmf.epsilon/(pmf.N * pmf.delta * pmf.delta));
% pmf.P(index) = 0;
% pmf.P        = sparse(pmf.P);
% pmf.P  = bsxfun(@rdivide,pmf.P,sum(pmf.P(:)));

index        = find(pmf.P < 0.01*max(pmf.P(:)));%pmf.epsilon/(pmf.N *  pmf.delta.m * pmf.delta.n * pmf.delta.k));
%cut_off    = pmf.epsilon/(pmf.N * pmf.delta.m * pmf.delta .n * pmf.delta.k);
%index        = find(pmf.P < cut_off);
%size(index)
if ~isempty(index)
    pmf.P(index) = 0;
    pmf.P        = ndSparse(pmf.P);
    pmf.P        = pmf.P/(sum(pmf.P(:)) + realmin);
    pmf.N        = size(nonzeros(pmf.P),1);
end

end

