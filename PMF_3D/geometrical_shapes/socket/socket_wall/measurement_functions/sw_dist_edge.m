function [distances,proj] = sw_dist_edge(tip_positions,edges)
%SW_DIST_EDGE
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
%       o distances: (N x 3),  distance to closest edge
%
%       o direction: (N x 9), direction to closest edge
%


[d_t1,proj_t1] = distane2Edges2(tip_positions(:,1:3),edges);  
[d_t2,proj_t2] = distane2Edges2(tip_positions(:,4:6),edges);  
[d_t3,proj_t3] = distane2Edges2(tip_positions(:,7:9),edges);  

distances      = [d_t1,d_t2,d_t3];
proj           = [proj_t1,proj_t2,proj_t3];

end

