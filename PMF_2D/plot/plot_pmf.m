function [handle] = plot_pmf(axis_handle,pmf,handle_in,pmf_plot_options)
%PLOT_PMF 
%   
%   Plot the Point Mass Filter
%
%
%   input --------------------------------------------
%       
%       o axis_handle 
%
%       o pmf : structure    
%
%       o handle_in
%
%       o pmf_plot_options
%
%   output --------------------------------------------
%
%       o handle
%
%% Process Input values

if ~exist('pmf_plot_options','var')
   pmf_plot_options.plot_type    = 'scatter';
   pmf_plot_options.colormap     = generate_colormap(256,1);
end

plot_type    = pmf_plot_options.plot_type;
color_map    = pmf_plot_options.colormap;

d = pmf.delta;
n = pmf.n;
m = pmf.m;

handle =  [];


% find the values of all points which have a non-zero probability
index           = find(pmf.P > 0);
[X_I,Y_I]       = ind2sub(size(pmf.P),index);

% Given the reference frame of the PMF compute the coordinates of all points
X               = (X_I-1) * d - m*d/2 + d/2 + pmf.x_ref(1);
Y               = (Y_I-1) * d - n*d/2 + d/2 + pmf.x_ref(2);

% rescale the probabilities to lie between [0,1] for visualisation purposes
max_value       = max(pmf.P(index));
w               = rescale(pmf.P(index),0,max_value,0,1);

xs              = linspace(-12,12,50);

[xi,yi]         = meshgrid(xs,xs);
zi              = griddata(X,Y,w,xi,yi);


if(isempty(handle_in))
    
    if strcmp(plot_type,'scatter')
        handle = scatter(axis_handle,xi(:),yi(:),15,zi(:),'filled');
    elseif strcmp(plot_type,'pcolor')
        handle  = pcolor(axis_handle,xi,yi,zi); shading interp;
    elseif strcmp(pmf_plot_options,'contourf')
        [~,handle] = contourf(axis_handle,xi,yi,zi,5);
    else
       error(['no such plot options: ' plot_type]); 
    end
    
    caxis([0 1]);
    colormap(color_map);
    colorbar;
else

    if strcmp(plot_type,'scatter')
        set(handle_in,'XData',xi(:),'YData',yi(:),'CData',zi(:));
    elseif strcmp(plot_type,'pcolor')
        set(handle_in,'XData',xi,'YData',yi,'CData',zi);
    elseif strcmp(plot_type,'contourf')
        set(handle_in,'XData',xi,'YData',yi,'ZData',zi);
    else
       error(['no such plot options: ' plot_type]); 
    end
    
end



end


function  RGB = generate_colormap(n,corder)

    
    ColorOrder = [0         0.4470    0.7410;
        0.8500    0.3250    0.0980;
        0.9290    0.6940    0.1250;
        0.4940    0.1840    0.5560;
        0.4660    0.6740    0.1880;
        0.3010    0.7450    0.9330;
        0.6350    0.0780    0.1840];  
    RGBs = cell(size(ColorOrder,1),1);
    for i=1:size(ColorOrder,1)
        
        rgb       = ColorOrder(i,:);
        R         = linspace(1,rgb(1),n);  %// Red from 1 to 0
        G         = linspace(1,rgb(2),n);
        B         = linspace(1,rgb(3),n);  %// Blue from 0 to 1
        RGBs{i}   = [R(:), G(:), B(:)];
        
    end
    
    RGB = RGBs{corder};
    
end

