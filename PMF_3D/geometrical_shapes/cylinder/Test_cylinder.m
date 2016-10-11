%% Plot the cylinder

clear all;

cylind = create_cylinder([0 0 0],rpy2r(0,pi/2,0),0.1,1);

close all;
figure(1);
plot_cylinder(cylind);
alpha(0.7);
hold on;
plot_orientation_rot(cylind.x_ref,cylind.Rot_ref,0.1,0.1,[]);

hold on
camlight right;

axis equal;
 grid on; box on;
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');

%% Check projection of points onto cylinder

X = [0.4,-0.3,0;
     0.8,0.3,0.05;
     1.2,0.3,0.05;
     0.2,0.0,0.0
     -0.2,0.0,0.0];
 
proj = project_points_cylinder(X,cylind);
 
close all;
figure(1);
plot_cylinder(cylind);
alpha(0.7);
hold on;
plot_orientation_rot(cylind.x_ref,cylind.Rot_ref,0.1,0.1,[]);
hold on
plot3(X(:,1),X(:,2),X(:,3),'or'); hold on;
plot3(proj(:,1),proj(:,2),proj(:,3),'og');

camlight right;
axis equal;
grid on; box on;
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');

%% Check weather points are inside or outside the cylinder

rr = @(a,b,N) a + (b-a).*rand(N,1);
N  = 1000;
X = [rr(-0.1,1.1,N),rr(-0.3,0.3,N),rr(-0.15,0.15,N)];

I = is_in_cylinder(X,cylind);
col = [0 1 0;
       1 0 0];
   
colors = col(I+1,:);

close all;
figure(1);
plot_cylinder(cylind);
alpha(0.7);
hold on;
plot_orientation_rot(cylind.x_ref,cylind.Rot_ref,0.1,0.1,[]);

hold on

scatter3(X(:,1),X(:,2),X(:,3),10,colors,'filled'); hold on;

camlight right;
axis equal;
grid on; box on;
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');

%% Check projection of points onto cylinder


cylind = create_cylinder([0 0 0],rpy2r(0,pi/2,0),0.1,1);
X = [0.4,-0.3,0;
     0.8,0.3,0.05;
     1.2,0.3,0.05;
     0.2,0.0,0.0
     -0.2,0.0,0.0];
 

rr = @(a,b,N) a + (b-a).*rand(N,1);
N  = 10;
X = [rr(-0.1,1.1,N),rr(-0.3,0.3,N),rr(-0.15,0.15,N)];
 
proj = project_points_cylinder(X,cylind);




close all;
figure(1);
plot_cylinder(cylind);
alpha(0.7);
hold on;
plot_orientation_rot(cylind.x_ref,cylind.Rot_ref,0.1,0.1,[]);

S = 20; hold on;
scatter3(X(:,1),X(:,2),X(:,3),S,[1 0 0],'filled');
scatter3(proj(:,1),proj(:,2),proj(:,3),S,[0 1 0],'filled');

for i=1:size(X,1)
   L = [X(i,:);proj(i,:)];
   plot3(L(:,1),L(:,2),L(:,3),'-b');
end


hold on
camlight right;

axis equal;
 grid on; box on;
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');


