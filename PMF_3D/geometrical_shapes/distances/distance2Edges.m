function [d,x_proj,x_t_proj] = distance2Edges(X,cube)
%
%   input -----------------------------------------------------------
%
%       o X: (N x 3), Cartesian position
%   
%       o cube: struct
%
%   output ---------------------------------------------------------
%
%       o d: (N x 1), distances to closest edge
%
%       o x_proj: (N x 3), projection of X onto cloest edge
%
    
    N = size(X,1);
   % d = ones(N,1) .* inf;
    
   % x_t_proj: (N x 3 x 12)
   [d_e,x_t_proj] = distance2lign(X,cube.edges);
                    
   [d,I]= min(d_e,[],2);
   
   x_proj = zeros(N,3);
   
   for i=1:N
     x_proj(i,:) = x_t_proj(i,:,I(i));
   end
  
   
  d = d(:);
    
            

end