function [ pmf ] = create_pmf(x_ref,delta,m,n,No,N1,epsilon)
%CREATE_GRID 
%
%   Creates a Point Mass Filter struct, containing the values of the grid
%   points, P and all parameters. 
%
%   input ----------------------------------------------------
%   
%       o ref:     (2 x 1), point of reference of the grid.
%
%       o delta:   (1 x 1), resolution of the grid, distance between the points.
%          
%       o m :      (1 x 1), number of points along dimension x
%
%       o n :      (1 x 1), number of points along dimension y
%
%       o N0:      (1 x 1), lower bound on total number of points in P.
%
%       o N1:      (1 x 1), upper bound on total number of points in P.
%
%       o epsilon: (1 x 1), 
%
%   output --------------------------------------------------
%
%       o pmf : struct
%
%

pmf.P       = ndSparse(ones(m,n)); 
pmf.delta   = delta;
pmf.epsilon = epsilon;
pmf.m       = m;
pmf.n       = n;
pmf.N       = m*n;
pmf.No      = No;
pmf.N1      = N1;
pmf.x_ref   = x_ref;

pmf.No      = No;
pmf.N1      = N1;



end

