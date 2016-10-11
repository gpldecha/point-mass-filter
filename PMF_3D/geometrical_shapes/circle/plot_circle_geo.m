function [ handle ] = plot_circle_geo(center,normal,radius )
%PLOT_CIRCLE Summary of this function goes here
%   Detailed explanation goes here

theta=0:0.01:2*pi;
v=null(normal);
points=repmat(center',1,size(theta,2))+radius*(v(:,1)*cos(theta)+v(:,2)*sin(theta));
handle = plot3(points(1,:),points(2,:),points(3,:),'k-');



end

