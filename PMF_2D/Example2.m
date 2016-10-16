%% Point Mass Filter 2D Example 2

clear all;

%% Initialise parameters of the agent and world

agent_position                      = [5, 0];
agent_orient                        = rot2D(pi/2);
agent_radius                        = 1;

% setup agent's sensor
world                               = create_2D_world();
range_var                           = (1)^2;
sensor_noise                        = (1).^2;
agent_sensor_f                      = @(pos,rot)square_world_measurement_function(pos,rot,world,range_var);

%% Initialise Point Mass Filter

pmf_options.No                      = 800;
pmf_options.N1                      = 5000;
pmf_options.eps                     = 0.001;
pmf_options.delta                   = 0.5;
pmf_options.m                       = floor(24/pmf_options.delta);
pmf_options.n                       = floor(24/pmf_options.delta);
pmf_options.ref                     = [0 0];

pmf_options.motion_noise            = (0.9).^2;
pmf_options.kernel_size             = 7;
pmf_options.theta_dist_travel       = 3;

pmf_options.initialisation_f        = @(pmf)initialise_pmf2_square(pmf);
pmf_options.likelihood_f            = @(Y,hY)pmf_gaussian_likelihood(Y,hY,sensor_noise);
pmf_options.measurement_f           = @(pos,rot)square_world_measurement_function(pos,rot,world,range_var);

pmf_obj                             = PMF2(pmf_options);


% Plot
options.pmf_obj                     = pmf_obj;
options.x                           = agent_position;
options.agent_orient                = agent_orient;
options.agent_radius                = agent_radius;
options.Y                           = agent_sensor_f(agent_position,[]);
options.XYW                         = get_pdf_pmf2(pmf_obj.pmf);
options.pmf_plot_options.bDiscrete  = true;
options.pmf_plot_options.plot_type  = 'contourf';

close all;
if ~exist('hp','var'),
    [handles]                       = plot_2d_world_bel(options,[],[]);
else
    [handles]                       = plot_2d_world_bel(options,[],hp);
end


%% Get handles; if you want to keep new figures in the same position after you closed them.


disp('Running 2D box search Simulation');

hp(1,:) = get(handles.hf(1),'Position');

%% Simulation loop


bRunSim = true;
x       = agent_position;
it      = 0;
bHuman  = true;

while(bRunSim)
    
    % ---------------------  Policy (human input) --------------------
    
    waitforbuttonpress;
    val=double(get(handles.plot1.hf,'CurrentCharacter'));
    if val == 29
        disp('left');
        u = [1 0];
    elseif val == 28
        u = [-1 0];
        disp('right');
    elseif val == 30
        disp('up');
        u = [0 1];
    elseif val == 31
        disp('down');
        u = [0 -1];
    elseif val == 27
        disp('stop simulation');
        u = [0 0];
        bRunSim = false;
    else
        disp('no action');
    end
    
    
    % ---------------------  Motion -----------------------------------
    xp        = world_2D_next_state(x,u);
    
    u_true    = xp - x;
    
    pmf_obj.motion_update(u_true);

    % ---------------------  Measurement ------------------------------
    
    Y     = agent_sensor_f(xp,[]);
    pmf_obj.measurement_update(Y,[]);
    
    
    options.x           = xp;
    options.agent_orient = u./norm(u);
    handles = plot_2d_world_bel(options,handles);
    
    if(it >= 100),bRunSim = false; end
    if flag, bRunSim = false;      end
    x             = xp;
    it            = it + 1;

    
end


