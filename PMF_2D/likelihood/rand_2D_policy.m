function [u] = rand_2D_policy(action_list)
%RAND_POLICY

u = action_list(randi([1,size(action_list,1)]),:);

end

