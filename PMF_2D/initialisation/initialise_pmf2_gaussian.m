function [ pmf ] = initialise_pmf2_gaussian( pmf,var )
%INITIALISE_PMF2_GAUSSIAN Summary of this function goes here
%   Detailed explanation goes here


n = pmf.n;
m = pmf.m;
d = pmf.delta;

xs = 0:d:(d*m);
ys = 0:d:(d*n);

xs = xs([1:m]);
ys = ys([1:n]);
 
xs = xs - (m*d)/2;% + pmf.x_ref(1);
ys = ys - (n*d)/2;% + pmf.x_ref(2);

[X,Y] = meshgrid(xs,ys);

w = exp(-0.5 * 1/var *(X.^2 + Y.^2));
w = reshape(w,[n m]);

pmf.P = ndSparse(w);
pmf.P = pmf.P / sum(pmf.P(:));
pmf.N = nnz(pmf.P);

end

