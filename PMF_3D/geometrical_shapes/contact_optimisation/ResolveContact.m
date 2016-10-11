%% Resolve contact
clear all;
peg_model   = get_peg_model();
socket_wall = create_socket_wall_A();

%% Frame of reference of the peg model

x_ref       = [0.012 -0.03 0];
R_ref         = rpy2r(0,0,pi);

%% Resolve contact

x_new = [];
R_new = [];

%%

[x_new,R_new,X_target] = correct_plug_position2(x_ref,R_ref,peg_model,socket_wall);

%[x_new,R_new,X_target] = correct_plug_position2(x_new,R_new,peg_model,socket_wall);

%%
N                 = size(peg_model,1);
is_inside_f       = @(X)is_inside_sw(X,socket_wall);
get_dist_f        = @(X)get_projection_dist_sw(X,socket_wall,is_inside_f);
X_w               = (R_ref * peg_model' + repmat(x_ref',1,N))';

[~,X_target] = get_dist_f(X_w);



%% Plot Socket Wall world and peg


% tips  = get_peg_tip_positions(x_pos,q_ref);
% tips  = [tips(1,1:3);
%         tips(1,4:6);
%         tips(1,7:9)];
% 
% 
% 
plot_peg_f    = @(r,R,handle,I,color)plot_peg_model(r,R,peg_model,handle,I,color);
get_contact_f = @(r,R)get_contact_points(r,R,peg_model,socket_wall);
I             = get_contact_f(x_ref,R_ref);



close all;
if exist('hp','var')
    hf(1) = figure('Position',hp(1,:));
   campos(cam);
   else
    hf(1) = figure;
end

box on;
plot_socket_wall(socket_wall);hold on;
  
%hpeg = plot_peg_f(x_pos',rot,[],I);
%  plot3(tips(:,1),tips(:,2),tips(:,3),'og');
%  
plot_peg_model(x_ref,R_ref,peg_model,[],[],[0 0 1]);


if ~isempty(x_new)
    I2            = get_contact_f(x_new,R_new);
     plot_peg_model(x_new,R_new,peg_model,[],I2);    
end
hold on;
scatter3(X_target(:,1),X_target(:,2),X_target(:,3),50,[0 1 0],'filled');

 grid on;
 xlabel('x-axis');
 ylabel('y-axis');
 zlabel('z-axis');
 axis equal;
 
%%
hp(1,:) = get(hf(1),'Position');
cam     = campos;


%% Optimisation to correct position


is_inside_f = @(X)is_inside_sw(X,socket_wall);
get_dist_f  = @(X)get_projection_dist_sw(X,socket_wall,is_inside_f);
X           = [-0.005,0,0.00001;
               -0.003,0,0.003];

rr = @(a,b,N) a + (b-a).*rand(N,1);
N  = 50;
X = [rr(-0.01,0,N),rr(-0.01,0.01,N),rr(-0.01,0.01,N)];

[~,X_target] = get_dist_f(X);

%%

close all;
figure(1);
grid on;
plot_socket_wall(socket_wall);hold on;

scatter3(X(:,1),X(:,2),X(:,3),20,[1 0 0],'filled');hold on;
scatter3(X_target(:,1),X_target(:,2),X_target(:,3),20,[0 1 0],'filled');hold on;

for i=1:size(X,1)
    hold on;
    L = [X(i,:);X_target(i,:)];
    plot3(L(:,1),L(:,2),L(:,3),'-b');
    
end


xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
axis equal;



