function [ds_m,de_m] = get_vec_distances(dir_vec)
%GET_DISTANCE_TO_SURFACE 
%
%
%   input ------------------------------------------------------------
%
%       o dir_vec: cell(1,3)
%
%           dir_vec{tip_1}: (N x 9)
%           dir_vec{tip_2}: (N x 9)
%           dir_vec{tip_3}: (N x 9)
%           
%           (i,1:3), surf vector
%           (i,4:6), edge vector
%           (i,7:9), tip position
%
%   output -----------------------------------------------------------
%
%       o ds_min: (N x 2), minimum distance to surface
%
%       o de_min: (N x 2), minimum distance to edge
%
%           - de_m(:,1): distances
%           - de_m(:,2): index of closest finger
%
%


N = size(dir_vec{1},1);

ds = zeros(N,3);
de = ds;


for j = 1:3
    
    ds(:,j) =  sqrt(sum((dir_vec{j}(:,1:3)).^2,2));
    de(:,j) =  sqrt(sum((dir_vec{j}(:,4:6)).^2,2));
        
end

[ds_min,Is] = min(ds,[],2);
[de_min,Ie] = min(de,[],2);

ds_m = [ds_min,Is];
de_m = [de_min,Ie];


end

