%% Check circle distances


% Circle
center = [0,0,0];
R       = rpy2r(0,pi/2,0);
normal  = R(:,3)';
radius  = 0.5;


% Test Point
X = [0.3,0.2,0.4;
    -0.3,-0.2,0.4
    -0.2,0.3,0.2];


% Compute distance and projection
[distances,K] = distance_circle(X,center',R,radius);

close all;
figure; hold on; grid on;
plot_circle(center,normal,radius );
plot3(X(:,1),X(:,2),X(:,3),'ob');
plot3(K(:,1),K(:,2),K(:,3),'ob');

L = [X(1,:);K(1,:)];
plot3(L(:,1),L(:,2),L(:,3),'-k');

L = [X(2,:);K(2,:)];
plot3(L(:,1),L(:,2),L(:,3),'-k');


title('distance to circle test');
axis equal; box on;
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
