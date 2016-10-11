%% Run 3D peg-in-hole policy (chosen start position)

clear all;

%% Initialise parameters of the agent and world

agents_position                                 = [0.45,  0.0,  0.15];
agents_orientation                              = [0 0 0 1];

%% Initialise Point Mass Filter

pmf_options                                     = [];

pmf_options.motion_noise                        = (0.1).^2;
pmf_options.measurement_noise                   = (0.01).^2;
pmf_options.dist_travel_theta                   = 0.02;
pmf_options.edge_Y_type                         = 1;

pmf3_obj                                        = PMF3(pmf_options);


%% ---- Simulation Options ----


simulation_options                              = [];
simulation_options.Hz                           = 50;
simulation_options.max_steps                    = simulation_options.Hz * 1 * 70; % (70 seconds)
simulation_options.max_dist_target              = 1.5;
simulation_options.bPrint                       = false;
simulation_options.start_positions.x            = agents_position;
simulation_options.start_positions.q            = agents_orientation;


%% ---- Policy Options Q-GMM learned from Greedy data -----

policy_options.vel_filter.bUse                  = true;
policy_options.vel_filter.w                     = 0.1;


%% number of repetitions
disp(' Start Simulation ');

        
hf = run3D_simulation(simulation_options,policy_options,pmf3_obj);



