function [ pmf ] = initialise_pmf2_square(pmf)
%INITIALISE_PMF2_SQUARE 


d = pmf.delta;
n = pmf.n;
m = pmf.m;

pmf.P = ndSparse(ones(m,n));
pmf.P = pmf.P/sum(pmf.P(:));


end

