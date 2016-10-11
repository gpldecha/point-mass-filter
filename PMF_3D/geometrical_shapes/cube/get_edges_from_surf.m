function edges = get_edges_from_surf(cube,index )
%GET_EDGES_FROM_SURF Given a surface index (1 -> 6), returnes the
%                    associated edges.
%
%   input --------------------------------------------------------
%   
%       o cube: structure of cube
%
%       o index: (1-6), edge index
%
%   output ------------------------------------------------------
%
%      o edges: (4 x 6), rows are edges, columns are point cooridnates
%           edge(1,1:3): point A
%           edge(1,4:6): point B
%
%

edges   = zeros(4,6);
corners = cube.surface(1:4,:,index);
corners = corners - repmat(cube.origin,4,1);

n       = abs(cube.surface(5,:,index));

index   = [];

if n(1) == 1
    [~,index] = order_corners( corners(:,2:3) );
elseif n(2) == 1
    [~,index] = order_corners( corners(:,[1,3]) );
elseif n(3) == 1
    [~,index] = order_corners( corners(:,1:2) );
else
    disp('error cube has to be aligned with the axis');
end

corners = corners + repmat(cube.origin,4,1);

% in or
corners_n = corners(index,:);

edges(1,:) = [corners_n(1,:),corners_n(2,:)];
edges(2,:) = [corners_n(2,:),corners_n(3,:)];
edges(3,:) = [corners_n(3,:),corners_n(4,:)];
edges(4,:) = [corners_n(4,:),corners_n(1,:)];
   


% for each point find it's neibourgh
% K = inf(4,4);
% for i=1:4
%   for j=1:4
%      K(i,j) = pdist([corners(i,:);corners(j,:)]);      
%   end
% end
% 
% for i=1:4
%    K(i,i) = Inf; 
% end

% K
% 
% % K gives the distance between item point (i) and 
% indexs = [2,3,4];
% 
% edges(1,1:3) = corners(1,:);
% [~,I]        = min(K(1,:));
% edges(1,4:6) = corners(I(1),:);
% indexs(I(1)) = [];
% K(:,I(1))    = Inf;
% 
% 
% for i =2:4
%     
%    edges(i,1:3) = corners(I(1),:);
%    [~,I]        = min(K(i,:));
%    edges(i,4:6) = corners(I(1),:);
%    K(i,I(1))    = Inf;
%    indexs(I(1)) = [];
%     
%     
% end






end

