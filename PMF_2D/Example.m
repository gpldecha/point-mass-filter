%% Point Mass Filter 2D example 

clear all;

%% Initialise parameters of the agent

% Initialise Agent's position and size
agent_position                  = [0, 0];
agent_radius                    = 1;

% initialise the agent's sensor which is noise
sensor_noise                    = diag([0.5 0.5]);
% one feature is present in the world, and it is a wall represented by a
% line
wall_feature                    = [10,-2,10,2];
agent_sensor_f                  = @(pos,rot)dist_measurement_function(pos,rot,wall_feature,sensor_noise);


%% Initialise Point Mass Filter

pmf_options.No                  = 1200;
pmf_options.N1                  = 1500;
pmf_options.eps                 = 0.001;
pmf_options.delta               = 0.5;
pmf_options.m                   = 100;
pmf_options.n                   = 100;
pmf_options.ref                 = agent_position;

pmf_options.motion_noise        = (0.9).^2;
pmf_options.kernel_size         = 8;
pmf_options.theta_dist_travel   = 1;

pmf_options.likelihood_f        = @(Y,hY)likelihood_dist(Y,hY,sensor_noise);
pmf_options.initialisation_f    = @(pmf)initialise_pmf2_gauss(pmf,10);
pmf_options.measurement_f       = @(pos,rot)dist_measurement_function(pos,rot,wall_feature,[]);


pmf_obj                         = PMF2(pmf_options);


%% Initialise policy

C                                   = [0 0];
max_iterations                      = 500;
iter                                = 0;
theta                               = 0 - pi/1;
[agent_position,agent_orient,theta] = circle_policy(8,theta,C,-pi/100);

disp('first time step initialisation');

pmf_options.ref                     = agent_position;
pmf_obj.reset(pmf_options);


%% Initial Plot

close all;

% Plot agent, wall and [point mass filter]

if exist('hp','var'), hf(1) = figure('Position',hp(1,:)); else hf(1) = figure; end
pmf_h                       = plot_pmf(gca,pmf_obj.pmf,[]);
h_a1                        = plot_round_agent(gca,agent_position,agent_orient,agent_radius,[],[]);
hold on;
wall                        = [wall_feature([1,3])',wall_feature([2,4])'];
plot(wall(:,1),wall(:,2),'-k','LineWidth',2);

title('Point Mass Filter');
xlim([-15 15]);
ylim([-15 15]);
xlabel('x-axis');
ylabel('y-axis');
box on;


% Plot agent, wall and [likelihood]

if exist('hp','var'), hf(2) = figure('Position',hp(2,:)); else hf(2) = figure; end 

Y                           = agent_sensor_f(agent_position,agent_orient);

h_lik                       = plot_likelihood(gca,Y,agent_orient,pmf_obj.likelihood_f,pmf_obj.measurement_f,[]);
h_a2                        = plot_round_agent(gca,agent_position,agent_orient,agent_radius,[],[]);
hold on;
plot(wall(:,1),wall(:,2),'-k','LineWidth',2);
hyp                         = plot_dist_measurement(gca,Y,agent_position,agent_orient,[]);   
 
title('Likelihood');
xlim([-15 15]);
ylim([-15 15]);
xlabel('x-axis');
ylabel('y-axis');
box on;


%% Simulation loop

agent_position_temp = agent_position;

while(iter < max_iterations)
    
    [agent_position,agent_orient,theta] = circle_policy(8,theta,C,-pi/10);
    
     % action
     u =  agent_position - agent_position_temp;

     % motion update
     pmf_obj.motion_update(u);
        
     % sensor measurement
     Y = agent_sensor_f(agent_position,agent_orient);
     
     % measurement update
     pmf_obj.measurement_update(Y,agent_orient);
              
     agent_position_temp = agent_position;
     
     % Ploting
     hyp  = plot_dist_measurement(gca,Y,agent_position,agent_orient,hyp);   
     h_a1 = plot_round_agent(gca,agent_position,agent_orient,agent_radius,[],h_a1);
     h_a2 = plot_round_agent(gca,agent_position,agent_orient,agent_radius,[],h_a2);
     
     plot_pmf(gca,pmf_obj.pmf,pmf_h);
     
     gca2 = findobj(hf(2),'type','axes');hold on;
    h_lik = plot_likelihood(gca2,Y,agent_orient,pmf_obj.likelihood_f,pmf_obj.measurement_f,h_lik);
    
    
    iter = iter + 1;
    pause(0.5);
end


%% Get handles; if you want to keep new figures in the same position after you closed them.

hp(1,:) = get(hf(1),'Position');
hp(2,:) = get(hf(2),'Position');





