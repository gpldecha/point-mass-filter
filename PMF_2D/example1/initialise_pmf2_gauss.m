function [ pmf ] = initialise_pmf2_gauss(pmf,var)
%INITIALISE_PMF
%
%   Initialise the point mass filter in its frame of reference
%
%   input ------------------------------------------------------
%
%       o pmf: point mass filter struct
%   
%       o Mu: (2 x 1), Mean prior
%
%       o Sigma: (2 x 2), Covariance prior
%
%


d = pmf.delta;
n = pmf.n;
m = pmf.m;

xs = 0:d:(d*n);
ys = 0:d:(d*m);

xs = xs([1:m]);
ys = ys([1:n]);

 
xs = xs - (n*d)/2;
ys = ys - (n*d)/2;
  
[X,Y] = meshgrid(xs,ys);

pmf.P = exp(-0.5 * 1/var *(X.^2 + Y.^2));
pmf.P = pmf.P/sum(pmf.P(:));
pmf.P = ndSparse(pmf.P);


end

