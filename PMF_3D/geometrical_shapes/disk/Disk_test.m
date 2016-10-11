%% Test Disk
disk = create_disk([0 0 0]',eye(3,3),2);

%% Chosen data points

X = [-0.5,0,1;
      0.5,0,1;
      0,1,1];

[Q,K] = dist_disk_edge(X,disk); 
  

%% Plot
close all;
figure; hold on; box on; grid on;
plot_disk(disk);
plot_orientation(disk.C,[0 0 0 1],0.5);hold on;
plot3(X(:,1),X(:,2),X(:,3),'ok');
plot3(Q(:,1),Q(:,2),Q(:,3),'og');
plot3(K(:,1),K(:,2),K(:,3),'or');

axis equal;
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');