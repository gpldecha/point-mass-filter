function [d,proj,proj_c,I] = distance2surf(X,cube,index)
%DISTANCE2SURF Summary of this function goes here
%
%   input -----------------------------------------
%
%       o X: (N x 3)
%

N       = size(X,1);
proj    = zeros(N,3);

if exist('index','var')
    
     [dist,x_t_proj] = distance2planSegment(X,cube.surface(1:4,:,index),cube.surface(5,:,index));
    
     d    = dist;
     proj = x_t_proj;
    
else
    
    d       = zeros(N,6);
    proj_c  = cell(1,6);

    for i=1:6
        [dist,x_t_proj] = distance2planSegment(X,cube.surface(1:4,:,i),cube.surface(5,:,i));
        proj_c{i}       = x_t_proj; % (N x 3)
        d(:,i) = dist;
    end
    
    % d (N x 6), distance of a point to each plane
    
    [d,I] = min(d,[],2);
    for i=1:N
        proj(i,:) = proj_c{I(i)}(i,:);
    end
    
end


end

