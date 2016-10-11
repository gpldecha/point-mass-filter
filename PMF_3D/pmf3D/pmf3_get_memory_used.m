function [memory] = pmf3_get_memory_used(pmf)
%PMF3_GET_MEMORY_USED Computes the amount of memory currently used by the
% point mass filter. The implementation of pmf is based on matlabs sparse
% matrix. The matlab sparse matrix data structure stores the indices of all
% columns indices, even if filled with zeros. The rows are sparse.
%
%   input ----------------------------------------------------
%
%       o pmf, point mass filter (3D) data structure
%
%   output ---------------------------------------------------
%
%       o memory: (1 x 1), memory of sparse data matrix in bytes
%
%           N      = number of columns
%           K      = number of nonzero elements
%           memory = 8 x (N + 1) + 16 x K  (for a 2d sparse matrix)
%
%

m = pmf.m; % x
n = pmf.n; % y (columns)
k = pmf.k; % z


K = pmf.N; % number of nonzero elements

memory = 8 * (n*k + 1) + 16 * K;



end

