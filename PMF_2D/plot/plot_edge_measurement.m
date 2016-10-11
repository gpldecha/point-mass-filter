function [ handle ] = plot_edge_measurement(edge_dir,edge_pos,handle)
%PLOT_MEASUREMENT

L = [edge_pos;edge_pos+edge_dir];
hold on;   
if ~exist('handle','var')
    handle = plot3(L(:,1),L(:,2),L(:,3),'-ob');
else
    set(handle,'XData',L(:,1),'YData',L(:,2),'ZData',L(:,3));
end
hold off;

end

