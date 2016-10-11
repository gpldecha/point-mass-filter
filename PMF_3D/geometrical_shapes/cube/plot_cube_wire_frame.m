function h = plot_cube_wire_frame(cube)
%PLOT_CUBE_WIRE_FRAME 
%
%   input ---------------------------------------------------------
%
%       o cube: struct
%

corner = cube.corners;
edges  = cube.edges;
%h(1) = scatter3(corner(:,1),corner(:,2),corner(:,3),20,'filled');
for i=1:size(edges,1)
   X = [edges(i,1:3);edges(i,4:6)];
   h(i) =  plot3(X(:,1),X(:,2),X(:,3),'-k'); 
end


end

