%% Plot socket and wall

swall_A = create_socket_wall_A();
close all;
figure; grid on; 
plot_socket_wall(swall_A);
axis equal;

%% Check function is_inside_socket

socket_A = create_socket_A();

rr = @(a,b,N) a + (b-a) .* rand(N,1);
N  = 1000;
X  = [rr(-0.02,0,N),rr(-0.04,0.04,N),rr(-0.01,0.01,N)];


I = is_inside_socket(X,swall_A) + 1;

color = [0 1 0;
         1 0 0];

close all;
figure;hold on;
plot_socket_A(socket_A);hold on;
scatter3(X(:,1),X(:,2),X(:,3),15,color(I,:));
axis equal;
box on; grid on;
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');

%% Check function is_inside socket_wall (both socket and wall combined)

rr = @(a,b,N) a + (b-a) .* rand(N,1);
N  = 1000;
X  = [rr(-0.02,0.002,N),rr(-0.04,0.04,N),rr(-0.01,0.01,N)];

I = is_inside_sw(X,swall_A) + 1;
close all;
figure; grid on; 
plot_socket_wall(swall_A);hold on;
scatter3(X(:,1),X(:,2),X(:,3),15,color(I,:));
axis equal;
box on; grid on;
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');

%% Test get_projection_dist_sw
clear all;
peg_model   = get_peg_model();
socket_wall = create_socket_wall_A();
%%
x_ref      = [0.004 -0.1 0];
R_ref      = rpy2r(0,0,pi);


plot_peg_f = @(r,R,handle,I)plot_peg_model(r,R,peg_model,handle,I);
%X = [0.2,-0.1,0];
X = (R_ref * peg_model' + repmat(x_ref',1,size(peg_model,1)))';

[dist,proj] = get_projection_dist_sw(X,socket_wall);
%[dist,proj]  = distance2surf(X,socket_wall.wall);



close all;
figure; grid on; 
plot_socket_wall(socket_wall);hold on;

plot_peg_f(x_ref',R_ref,[],[]);

hold on;
scatter3(proj(:,1),proj(:,2),proj(:,3),50,[0 1 0],'filled');
%scatter3(X(:,1),X(:,2),X(:,3),50,[1 0 0],'filled');


axis equal;
box on; grid on;
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');

%% New Socket wall representation




swall_A = create_socket_wall_A();
figure; grid on; 
plot_socket_wall(swall_A);
axis equal;




%% test point 2


trajectory    = get_trajectory('Albert',1,'A');
r             = trajectory(:,1:3);
q             = trajectory(:,4:7);
tip_positions = get_peg_tip_positions(r(1,:),q(1,:));

%%

pos_tip_1 = tip_positions(:,1:3);
pos_tip_2 = tip_positions(:,4:6);
pos_tip_3 = tip_positions(:,7:9);
X = [pos_tip_1];


%%
t = 850;

swall_A = create_socket_wall_A();
edges   = get_edges_socket_wall(swall_A);


pos = X;%[0.018,0,-0.1];

corr_f = @(tip_positions,ref_position)correct_plug_position(tip_positions,ref_position,swall_A);

tip_positions     = get_peg_tip_positions(pos,q(1,:));

[tip_positions,pos,proj_c] = corr_f(tip_positions,pos);

edge_type         = 2;
d_edge_f          = @(tip_position)sw_min_dist_edge(tip_position,edges);
hY_edge           = @(tip_position)sw_edge(tip_position,q2r(q(t,:)),edge_type,d_edge_f);

[Y,proj]          = hY_edge(tip_positions);


close all;
if exist('hp','var')
    hf(1) = figure('Position',hp(1,:));
   campos(cam);
else
    hf(1) = figure;
end

hold on; box on; grid on; hold on;
% for i=1:8
%    L = [edges(i,1:3);edges(i,4:6)]; 
%    plot3(L(:,1),L(:,2),L(:,3),'-','LineWidth',2); 
% end
plot_socket_wall(swall_A);
hold on;

disp(['angle: ' num2str(Y(2) * 180/pi)]);

% plot projection

%plot3(proj(:,1),proj(:,2),proj(:,3),'or');

% plot current position

[h_p,h_q] = plot_current_pos3(pos,q(t,:),0.05,2,[],[]);hold on;
plot3(proj_c(:,1),proj_c(:,2),proj_c(:,3),'ok');


%axis equal;

%%
hp(1,:) = get(hf(1),'Position');
cam     = campos;

%%

wall_w      = 0.8;
wall_h      = 0.03;
wall_l      = 0.4;

wall_origin  = [-wall_h/2 0 0];

vec = [-0.0050         0         0];

wall_origin = wall_origin + vec;

cube      = create_cube([wall_h,wall_w,wall_l],wall_origin);

%%

i =6;
[dist,x_t_proj] = distance2planSegment(X,cube.surface(1:4,:,i),cube.surface(5,:,i));



%%

[dist_s, proj_s,proj_c]    = distance2surf(X,swall_A.wall);
proj_c = cell2mat(proj_c');

%%

swall_A = create_socket_wall_A();

edges           = get_edges_socket_wall(wall_socket);
get_tip         = @(r)get_peg_tip_positions(r,q(1,:));

hY_edge         = @(tip_position)sw_min_dist_edge(tip_position,edges);

tip_positions   = get_tip(X);

[distance,direction,position] = hY_edge(tip_positions);

close all;
figure; grid on;
plot_socket_wall(swall_A);hold on;
plot3(X(:,1),X(:,2),X(:,3),'ob');

for i=1:size(tip_positions,1)
    plot3(tip_positions(i,1),tip_positions(i,2),tip_positions(i,3),'ok');
    plot3(tip_positions(i,4),tip_positions(i,5),tip_positions(i,6),'ok');
    plot3(tip_positions(i,7),tip_positions(i,8),tip_positions(i,9),'ok');
end

for i=1:size(edges,1)
   L = [edges(i,1:3);edges(i,4:6)];
   plot3(L(:,1),L(:,2),L(:,3),'-','LineWidth',2); 
end

for i=1:size(direction,1)
    L = [position(i,:);position(i,:) + direction(i,:)];
    plot3(L(:,1),L(:,2),L(:,3),'-ob');
end




axis equal;
%%
plot3(X(:,1),X(:,2),X(:,3),'ob');
plot3(proj_s(:,1),proj_s(:,2),proj_s(:,3),'*k');
plot3(proj_c(:,1),proj_c(:,2),proj_c(:,3),'*k');

% plot3(proj_e(:,1),proj_e(:,2),proj_e(:,3),'*g');
% 
% plot3(x_t_proj(1),x_t_proj(2),x_t_proj(3),'*k');


