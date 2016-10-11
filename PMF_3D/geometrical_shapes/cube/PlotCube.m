%% Check if cube_create function works properly

close all;
figure; hold on;grid on;

sock_w=1;
sock_h=1;
sock_pos = [0.1 -sock_w/2 -sock_w/2];

socket_cube = create_cube([sock_h,sock_w,sock_w],sock_pos);
corner = socket_cube.corners;
edges  = socket_cube.edges;
surf   = socket_cube.surface;
scatter3(corner(:,1),corner(:,2),corner(:,3),20,'filled');
for i=1:size(edges,1)
   X = [edges(i,1:3);edges(i,4:6)];
   plot3(X(:,1),X(:,2),X(:,3),'-r'); 
end

for i=1:6
   
    X_center = mean(surf(1:4,:,i));
    n        = surf(5,:,i);
    X_end    = n + X_center;
    X        = [X_center;X_end];
    plot3(X(:,1),X(:,2),X(:,3),'-g');
    
end

box on; 

xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
axis equal;

%%
socket_cube = create_cube([sock_h,sock_w,sock_w],sock_pos);

edges = get_edges_from_surf(socket_cube,4);
close all;
figure; hold on; box on; grid on;
for i=1:4
   L = [edges(i,1:3);edges(i,4:6)];
   plot3(L(:,1),L(:,2),L(:,3),'-','LineWidth',2);  
end
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
axis equal;

%%

corners = get_corners_from_surf(socket_cube,3);
corners
figure;
scatter3(corners(:,1),corners(:,2),corners(:,3),20,'filled');
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
axis equal;

%% Check if function is_incube works

mu = [0 0 0];
Sigma = [1 0 0; 
         0 1 0;
         0 0 1]; 
R = chol(Sigma);
z = repmat(mu,1000,1) + randn(1000,3)*R;

bIn = is_incube(z,socket_cube);

z_in  = z(find(bIn==1),:);
z_out = z(find(bIn==0),:); 


close all;
figure; hold on;grid on;

for i=1:size(edges,1)
   X = [edges(i,1:3);edges(i,4:6)];
   plot3(X(:,1),X(:,2),X(:,3),'-r'); 
end

for i=1:6
   
    X_center = mean(surf(1:4,:,i));
    n        = surf(5,:,i);
    X_end    = n + X_center;
    X        = [X_center;X_end];
    plot3(X(:,1),X(:,2),X(:,3),'-g');
    
end

plot3(z_in(:,1),z_in(:,2),z_in(:,3),'or');
%plot3(z_out(:,1),z_out(:,2),z_out(:,3),'ob');


box on; 

xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');

hold off;



