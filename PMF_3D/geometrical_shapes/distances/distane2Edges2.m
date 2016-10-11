function [d,x_proj] = distane2Edges2(X,edges )
%DISTANE2EDGES2 
%
%   input -----------------------------------------------------------
%
%       o X: (N x 3), Cartesian position
%   
%       o edges: (M x 6), set of M edges
%
%   output ---------------------------------------------------------
%
%       o d: (N x 1), distances to closest edge
%
%       o x_proj: (N x 3), projection of X onto cloest edge
%
    
    N = size(X,1);
    
   % x_t_proj: (N x 3 x 12)
   [d_e,x_t_proj] = distance2lign(X,edges);                   
   [d,I]          = min(d_e,[],2);
   x_proj         = zeros(N,3);
   
   for i=1:N
     x_proj(i,:)  = x_t_proj(i,:,I(i));
   end
  
   
  d = d(:);
    

end

