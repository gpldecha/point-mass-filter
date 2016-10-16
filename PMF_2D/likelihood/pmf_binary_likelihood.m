function [ L ] = pmf_binary_likelihood(Y,hY)
%PMF_DISCRETE_LIKELIHOOD 
%
%   input -----------------------------------------------------------
%
%       o Y  : (1 x 1), 
%
%               Y = -1      not in free space
%               Y =  1      contact
%               Y =  0      no contact
%
%       o hY : (N x 1), expected senations (same values as Y)
%
%   output -----------------------------------------------------------
%
%       o L  : (N x 1), likelihood
%
%

N     = size(hY,1);

% if Y == -1
%     error('pmf_binary_likelihood.m          Y = -1');
% end    
    

L           = zeros(N,1);
L(Y == hY)  = 1;
%L(hY == -1) = 0;

end

