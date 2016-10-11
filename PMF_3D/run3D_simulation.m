function [hf] = run3D_simulation(simulation_options,policy_options,pmf3_obj)
%RUN3D_PEG_SOKCET_SIMULATION

%% Get simulation options
if ~isfield(simulation_options,'max_steps');       simulation_options.max_steps       = -1;              end
if ~isfield(simulation_options,'max_dist_target'); simulation_options.max_dist_target = -1;              end
if isfield(simulation_options,'hp'),               hp = simulation_options.hp;                           end
if isfield(simulation_options,'cam'),              cam = simulation_options.cam;                         end


start_positions         = simulation_options.start_positions;
Hz                      = simulation_options.Hz;

%% Get policy options
if ~isfield(policy_options,'T');               policy_options.T                 = [0, 0, 0];       end
%%

vel_filter      = policy_options.vel_filter;

if vel_filter.bUse, action_filter = @(u,utmp)policy_mvavrg(u,utmp,policy_options.vel_filter.w); end


%% stop condition type

% 1 = stop after insertion has been succesfull.
% 2 = stop once the socket has been found.

stop_criteria_one   = 1;

%% initialise world, policy and Point Mass Filter

socket_wall         = create_socket_wall_A();
pmf3_obj.initialise([0.4,0,0.09],[0 0 0 1], socket_wall);


policy              = @(x)policy_goal(x,policy_options.T);

x                   = start_positions.x;
q                   = start_positions.q;

XYZW                = get_pdf_pmf3(pmf3_obj.pmf);
F                   = get_features(XYZW);


%% Plot World and Point Mass Filter

close all;
if exist('hp','var'), hf(1) = figure('Position',hp(1,:)); campos(cam); else hf(1) = figure; end

grid on; plot_socket_wall(socket_wall); hold on;
[h_p,h_q]       = plot_current_pos3(x,q,0.05,2,[],[]); hold on;
h_pmf           = plot_pmf_3D(gca,pmf3_obj.pmf);
h_bel_x         = scatter3(F(1),F(2),F(3),20,[0 1 1],'filled');
view(49,36);
axis equal;

bRun       = true;
t          = 1;
dx         = zeros(3,1);
dxtmp      = dx;

while(bRun)
    
    % ---------------------  Policy ---------------------------------------
    
    XYZW            = get_pdf_pmf3(pmf3_obj.pmf);
    F               = get_features(XYZW);
    
    k               = (1 - exp(-norm(F(1:3))));
    vel             = rescale(k,0,1,0.0002,0.005);
    
    u               =  policy(F(1:3));
    u               = u./( norm(u) + realmin);
    dx              = u' .* vel;
    dq              = [0 0 0 0];
    
    
    if vel_filter.bUse
        dx = action_filter(dx,dxtmp);
        dx = dx .* vel;
    end
    
    
    % ---------------------  Motion -----------------------------------
    % Physical world interation, get the actual displacemnt (collision)
    [xp,xq,dx,dq] = peg_world_next_state(x,q,dx,dq,socket_wall);
    
    % Update the filter according to the action discplacement
    pmf3_obj.motion_update(dx);
    
    
    % ---------------------  Measurement ------------------------------
    pmf3_obj.correct_x_ref(xp);
    
  
    
    Y = pmf3_obj.sense(xp,q);
    
    
    pmf3_obj.measurement_update(Y);
    pmf3_obj.adapt_mnk(x);
    
    
    %% Update plot
    
    plot_current_pos3(xp,xq,0.05,2,h_p,h_q);
    plot_pmf_3D(gca,pmf3_obj.pmf,h_pmf);
    set(h_bel_x,'XData',F(1),'YData',F(2),'ZData',F(3));
    
    pause(1/Hz);
    
    %% Check stoppping criteria
    
    if stop_criteria_one == 1
        if norm(policy_options.T(:)-xp(:)) < 0.001
            disp('arrived at goal!');
            bRun = false;
        end
    elseif stop_criteria_one == 2
        if abs(F(2)-policy_options.T(2)) < 0.05 && abs(F(3)-policy_options.T(3)) < 0.04 && abs(xp(2)-policy_options.T(2)) < 0.05 && abs(xp(3)-policy_options.T(3)) < 0.05 && F(4) < -8
            disp('arrived at goal!');
            bRun = false;
        end
    else
        error(['no such stopping criteria defined: ' num2str(stop_criteria)]);
    end
    
    dxtmp       = dx;
    x           = xp;
    q           = xq;
    t           = t + 1;
    
end

disp('Finished Run...');






end

