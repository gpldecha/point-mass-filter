function pmf = pmf3_create(x_ref,delta,min_delta_n,length,m,n,k,No,N1,epsilon )
%CREATE_PMF3D
%
%   creat a 3D Point Mass Filter Grid
%
%   input ----------------------------------------------------
%   
%       o ref:   (3 x 1), point of reference of the grid
%       
%       o delta: (1 x 1), resolution
%       
%       o n : number of grid points for  y
%       
%       o m:  number of gird points for  x
%
%       o k:  number of gird points for  z
%



%pmf.P       = ones(m,n,k);
pmf.P           = ndSparse.build([],[],[n k m]);
pmf.delta       = delta;
pmf.min_delta_n = min_delta_n;
pmf.epsilon     = epsilon;
pmf.m           = m;
pmf.n           = n;
pmf.k           = k;    
pmf.length      = length;
pmf.x_ref       = x_ref;
pmf.No          = No;
pmf.N           = 0;
pmf.N1          = N1;


end

