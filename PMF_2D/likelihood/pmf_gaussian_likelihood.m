function [ L ] = pmf_gaussian_likelihood(Y,hY,Sigma)
% GAUSSIAN_LIKELIHOOD
%
%   input ------------------------------------------------------
%
%       o Y: (1 x 3), actual measurement
%           Y(1:2): projected point
%
%       o Sigma: (2 x 2), measuremenet noise (variance)
%

N     = size(hY,1);

diff  = repmat(Y,N,1) - hY;
L     = rbf(diff',zeros(1,size(Sigma,1)),Sigma);%gaussPDF(diff', [0 0], Sigma);
%L     = L./sum(L(:));

end

function prob = rbf(Data,Mu,Sigma)

[nbVar,nbData] = size(Data);

Data = Data' - repmat(Mu,nbData,1);
prob = sum((Data*inv(Sigma)).*Data, 2);
prob = exp(-0.5*prob);

end

