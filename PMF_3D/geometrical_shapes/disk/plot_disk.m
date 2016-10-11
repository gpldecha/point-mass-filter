function [handle] = plot_disk(disk)
%PLOT_DISK 
%
%



% if ~exist('handle','var')
    
center = disk.C;
radius = disk.r;
normal = disk.R(:,3);

theta=0:0.01:2*pi;
v=null(normal');
points=repmat(center,1,size(theta,2))+radius*(v(:,1)*cos(theta)+v(:,2)*sin(theta));
handle = plot3(points(1,:),points(2,:),points(3,:),'k-');
%     
% else
%     
%     
% end



end

