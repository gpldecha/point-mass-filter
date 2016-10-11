function [ dist,proj ] = distance2walls(X,world,wall_id)
% distance2walls
%   input ---------------------------------
%
%       o X     : (N x 2)
%
%       o world : struct 
%   
%   comment -------------------------------
%
%      Walls are alligned with the axis
%
%

if ~exist('wall_id','var')

wall_segments = [world.outer_walls;
                world.inner_walls];
            
else
    
    if strcmp(wall_id,'outer')
        wall_segments = world.outer_walls;
    else
        wall_segments = world.inner_walls;
    end
    
    
end

M     = size(wall_segments,1);
N     = size(X,1);
dists = zeros(N,M);

for i=1:M
   % (N x 1) 
   d  = dist2line2D(X,wall_segments(i,:));
   dists(:,i) = d;
end

[~,I] = min(dists,[],2);

[dist,proj]  = dist2line2D(X,wall_segments(I,:));

end

