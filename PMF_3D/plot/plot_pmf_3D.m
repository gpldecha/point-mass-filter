function handle = plot_pmf_3D(axis_handle,pmf,handle_in)
%PLOT_PMF_3D 
%   
%   Plot the Point Mass Filter ((3D)
%
%
%   input --------------------------------------------
%       
%       o bUpdate, if False draw and save axies handle, if True
%                  redraw the plot 
%


handle = 0;

dm = pmf.delta.m;
dn = pmf.delta.n;
dk = pmf.delta.k;

n = pmf.n;
m = pmf.m;
k = pmf.k;
    
index           = find(pmf.P >  0);
%[X_I,Y_I,Z_I]   = ind2sub(size(pmf.P),index);
[Y_I,Z_I,X_I]   = ind2sub(size(pmf.P),index);
pos             = indices2cartesian(X_I,Y_I,Z_I,pmf.x_ref,[pmf.m,pmf.n,pmf.k],pmf.delta);


max_value = max(pmf.P(index));
w         = rescale(pmf.P(index),0,max_value,0,1);

if(~exist('handle_in','var'))
    hold on;
    handle = scatter3(axis_handle,pos(:,1),pos(:,2),pos(:,3),5,w,'filled');
    caxis([0 1]);
    colormap('jet');
else
    set(handle_in,'XData',pos(:,1),'YData',pos(:,2),'ZData',pos(:,3),'CData',w);
end

end

