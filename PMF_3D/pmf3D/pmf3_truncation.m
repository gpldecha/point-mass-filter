function pmf = pmf3_truncation( pmf )
%PMF3_TRUNCATION removes grid points which have a probability below 
%   the average weight by a factor of epsilon
%   
%

index        = find(pmf.P < 0.5*max(pmf.P(:)));
index        = index(:);

if ~isempty(index)
    if(size(index,1) < nnz(pmf.P))
        pmf.P(index) = 0;
        pmf.P        = ndSparse(pmf.P);
        pmf.P        = pmf.P/(sum(pmf.P(:)) + realmin);
        pmf.N        = size(nonzeros(pmf.P),1);
    end
end

end

