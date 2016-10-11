function  plot_socket_wall( socket_wall )
%PLOT_SOCKET_WALL
%
%   Plots socket and wall
%
%   input ----------------------------------------------------
%
%       o socket_wall: struct
%              - socket
%              - cube


% PLOT WALL

hold on;

wall_cube = socket_wall.wall; 

% corner = wall_cube.corners;
edges  = wall_cube.edges;
% hold on;
%scatter3(corner(:,1),corner(:,2),corner(:,3),20,'filled','FaceColor',[1 0 0]);
for i=1:size(edges,1),
   X = [edges(i,1:3);edges(i,4:6)];
   plot3(X(:,1),X(:,2),X(:,3),'-k'); 
end

hold off;


% PLOT SOCKET
hold on;
plot_socket_A(socket_wall.socket_A);
hold off;

box on; 

%xlabel('x [m]','Interpreter','Latex','FontSize',16);
%ylabel('y [m]','Interpreter','Latex','FontSize',16);
%zlabel('z [m]','Interpreter','Latex','FontSize',16);
% axis([-0.1 0.5 -0.5 0.5 -0.25 0.5]);
% view(51.50, 20);

end

