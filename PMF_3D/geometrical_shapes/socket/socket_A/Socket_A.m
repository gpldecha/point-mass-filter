%% Plot socket A

socket_A = create_socket_A();
close all;
figure;
hold on; grid on;
plot_socket_A(socket_A);
alpha(0.7);
camlight right;
hold on;
axis equal;
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');

%% Socket A


x = [0 0 0]';
R = eye(3,3);


socket_A = create_socket_A();


X = [0.002,0.034,0.01;
    0,0,0.015
    ];


[d,x_proj]    = distance2Edges(X,socket_A.cube);
[d_m,proj_m]  = get_distance_edge_socket_A(X,socket_A);
[d_s,xs_proj] =  distance2surf(X,socket_A.cube);



%% Debug 1

close all;
figure; hold on; grid on;
plot_socket_A(socket_A);

for i=1:size(X,1)
    L = [X(i,:);xs_proj(i,:)];
    plot3(L(:,1),L(:,2),L(:,3),'-or');
    
    L = [X(i,:);proj_m(i,:)];
    plot3(L(:,1),L(:,2),L(:,3),'-ob');
    
end

axis square;
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');

%% Get direction to all features

X = [0.2 0.1 0.0];

[ proj_x,line_seg ] = get_features_socket_A(X,socket_A,1);


%% Debug 2

close all;
figure; hold on; grid on;
plot_socket_A(socket_A);

col = [1 0 0; 0 1 0; 0 0 1];

for i=1:size(proj_x,2)
    proj = proj_x{i};
    for j=1:size(proj,1)
        L = [X;proj(j,:)];
        plot3(L(:,1),L(:,2),L(:,3),'-o');
    end
end


j = 4;
L = [line_seg(j,1:3);line_seg(j,4:6)];
plot3(L(:,1),L(:,2),L(:,3),'-or');


axis equal;
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');





%%

distance2Edges(X,socket_A.cube);