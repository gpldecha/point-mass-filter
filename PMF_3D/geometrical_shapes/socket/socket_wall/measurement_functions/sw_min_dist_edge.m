function [distance,direction,position] = sw_min_dist_edge(tip_positions,edges)
%SW_EDGE_CONTACT Checks of the tips are in contact with an edge
%
%   input --------------------------------------------------------
%
%       o tip_positions: (N x 9)
%               tip_positions(:,1:3) :  left    
%               tip_positions(:,4:6) :  middle  
%               tip_positions(:,7:9) :  right 
%
%       o edges: (M x 6), set of M edges
%
%   output -------------------------------------------------------
%
%       o distance: (N x 1), closest distance to edge
%
%       o direction: (N x 3), direction to closest edge
%




[d_t1,proj_t1] = distane2Edges2(tip_positions(:,1:3),edges);  
[d_t2,proj_t2] = distane2Edges2(tip_positions(:,4:6),edges);  
[d_t3,proj_t3] = distane2Edges2(tip_positions(:,7:9),edges);  


proj           = [proj_t1,proj_t2,proj_t3];
[distance,I]   = min([d_t1,d_t2,d_t3],[],2);
Index          = ((I - 1) * 3 + 1);
 
direction      = proj(:,Index:Index + 2) - tip_positions(:,Index:Index + 2);
position       = tip_positions(:,Index:Index + 2);


end

