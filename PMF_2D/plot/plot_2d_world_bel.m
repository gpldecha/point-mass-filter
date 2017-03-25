function [handles] = plot_2d_world_bel(options,handles,hp)
%PLOT_2D_WORLD_BEL Summary of this function goes here
%   Detailed explanation goes here
%
%
%% Synthesis input

if ~isfield(options,'bPlotAgent'),           options.bPlotAgent              = true;        end
if ~isfield(options,'pmf_plot_options'),     options.pmf_plot_options        =  [];         end

if ~isfield(options.pmf_plot_options,'bDiscrete'), options.pmf_plot_options.bDiscrete = false; end 



%% Set variables

pmf_obj             = options.pmf_obj;
x                   = options.x;
agent_orient        = options.agent_orient;
agent_radius        = options.agent_radius;
bPlotAgent          = options.bPlotAgent;
pmf_plot_options    = options.pmf_plot_options;
bDiscrete           = options.pmf_plot_options.bDiscrete;

%% Plot

if isempty(handles)
    
    
    %% First Plot
    
    
    
    if ~isempty(hp),hf = figure('Position',hp(1,:)); else hf = figure;end
    box on;  hold on;
    
    % ---- Plot Belief --- %
    
    pmf_h           = plot_pmf(gca,pmf_obj.pmf,[],pmf_plot_options);
    
    % ---- Plot Agent --- %
    if bPlotAgent
        h_a        = plot_round_agent(gca,x,agent_orient,agent_radius,[],[],bDiscrete);
    else
        h_a        = [];
    end
    hold on;
    
    
    % ---- Plot Wolrd --- %
    rectangle('Position',[-10 -10 20 20]);
    rectangle('Position',[-1 -1 2 2],'FaceColor',[1 0 0],'EdgeColor','k','LineWidth',2);
    axis([-15 15 -15 15]);
    axis square;
    
    handles.plot1.hf    = hf;
    handles.plot1.h_a   = h_a;
    handles.plot1.pmf_h = pmf_h;
    
    
else
    %% REPLOT (Updating plot during simulations)
    
    %% First plot
    
    hf    = handles.plot1.hf;
    h_a   = handles.plot1.h_a;
    pmf_h = handles.plot1.pmf_h;
    gca1  = findobj(hf,'type','axes');hold on;
    
    plot_pmf(gca1,pmf_obj.pmf,pmf_h,pmf_plot_options);
    
    if bPlotAgent
        plot_round_agent(gca1,x,agent_orient,agent_radius,[],h_a,bDiscrete);
    end
    
    if bDiscrete
        
        rectangle('Position',[-10 -10 20 20]);
        rectangle('Position',[-1 -1 2 2],'FaceColor',[1 0 0],'EdgeColor','k','LineWidth',2);
        axis([-15 15 -15 15]);
        axis square;
        
        handles.plot1.hf    = hf;
        handles.plot1.h_a   = h_a;
        handles.plot1.pmf_h = pmf_h;
        
    end
    
    
end

end

