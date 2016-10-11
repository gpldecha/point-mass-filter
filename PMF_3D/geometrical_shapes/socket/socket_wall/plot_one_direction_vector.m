function [ handle ] = plot_one_direction_vector(direction_vector,index,handle )
%PLOT_ONE_DIRECTION_VECTOR 
%
%   
%   input -------------------------------------------------------------
%
%       o direction_vector: cell(1,3)
%
%       o direction_vector{1}: (1 x 9)
%
%           -direction_vector(i,1:3): tip -> surf vector
%           -direction_vector(i,4:6): tip -> edge vector
%           -direction_vector(i,7:9): tip -> tip position
%
%


if isempty(handle)
    
    handle = cell(1,3);
    
    for j=1:3
        surf_j =  direction_vector{j}(index,1:3);
        edge_j =  direction_vector{j}(index,4:6);
        tip_j  = direction_vector{j}(index,7:9);
        handle{j} = plot_tip(tip_j,surf_j,edge_j,[]);
    end
    
else
    
    for j=1:3
        surf_j =  direction_vector{j}(index,1:3);
        edge_j =  direction_vector{j}(index,4:6);
        tip_j  = direction_vector{j}(index,7:9);
        plot_tip(tip_j,surf_j,edge_j,handle{j});
    end
    
end



end

