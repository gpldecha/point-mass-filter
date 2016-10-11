%% Socket wall features
clear all;
%%

mode                      = [0.2 0.1 0.0];
socket_wall               = create_socket_wall_A();
[proj_socket,proj_corner] = get_features_socket_A(X,socket_wall,2);
%%
options = [];
options.num_modes    = 5;   % number of modes
options.n            = 2;   % number of features per mode
options.feature_type = 'distance';
F                    = compute_Features(pmf3{1},q(t,:),0,options,socket_wall);

%%

[modes,weights,C,Index,idx,Np]   = get_modes2(pmf3{t},10,0);

[proj_socket,proj_wall,proj_surf,proj_goal,H,d_goal,points] = get_env_features(pmf3{t},mode,q(t,:),socket_wall,options);
reward                                                      = peg_reward_function(pmf3{t},q(t,:));

%%

close all;
hold on; box on; grid on; hold on;
plot_socket_wall(socket_wall);
hold on;
col = [1 0 0; 0 1 0; 0 0 1];

for i=1:size(proj_socket,1)
     L = [X;proj_socket(i,:)];
     plot3(L(:,1),L(:,2),L(:,3),'-ro');
end

for i=1:size(proj_corner,1)
     L = [X;proj_corner(i,:)];
     plot3(L(:,1),L(:,2),L(:,3),'-bo');
end

axis equal;