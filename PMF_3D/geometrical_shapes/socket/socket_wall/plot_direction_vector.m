function plot_direction_vector( direction_vector,fraction )
%PLOT_DIRECTION_VECTOR Summary of this function goes here
%   
%   
%   input -------------------------------------------------------------
%
%       o direction_vector: cell(1,3)
%
%       o direction_vector{1}: (N x 9)
%
%           -direction_vector(i,1:3): tip -> surf vector
%           -direction_vector(i,4:6): tip -> edge vector
%           -direction_vector(i,7:9): tip -> tip position
%
%       o fraction (1 x 1)
%
%

N = size(direction_vector{1});

pos_tip_1   = direction_vector{1}(:,7:9);

dist     	= sqrt(sum((pos_tip_1(2:end,:) - pos_tip_1(1:end-1,:)).^2,2));
dist_count  = 0;
dist_sum    = sum(dist);

hold on;


for j=1:3
    surf_j =  direction_vector{j}(1,1:3);
    edge_j =  direction_vector{j}(1,4:6);
    tip_j  = direction_vector{j}(1,7:9);
    plot_tip(tip_j,surf_j,edge_j);
end

for i = 1:size(dist,1)
    
    dist_count = dist_count + dist(i);
    
    if dist_count >= fraction *  dist_sum
        
        for j=1:3           
            surf_j =  direction_vector{j}(i,1:3);
            edge_j =  direction_vector{j}(i,4:6);
            tip_j  = direction_vector{j}(i,7:9);
            plot_tip(tip_j,surf_j,edge_j);
        end
        dist_count = 0;
        
    end
    
    
end

hold off;


hold off;



end


