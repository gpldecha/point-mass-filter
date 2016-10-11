function h = plot_orientation(r,q,scale,width,axes_h)
%
%   input --------------------------------------
%
%       o r: (1 x 3)
%       o q: (1 x 4)
%

R = q2r(q);
Rx = R(:,1);
Ry = R(:,2);
Rz = R(:,3);
Rx = Rx./norm(Rx) * scale;
Ry = Ry./norm(Ry) * scale;
Rz = Rz./norm(Rz) * scale;

if ~exist('width','var'), width = 1;end

hold on;

if ~exist('axes_h','var')
    
    h(1) = quiver3(r(1),r(2),r(3),Rx(1),Rx(2),Rx(3),'-r','filled','linewidth',width);
    h(2) = quiver3(r(1),r(2),r(3),Ry(1),Ry(2),Ry(3),'-g','filled','linewidth',width);
    h(3) = quiver3(r(1),r(2),r(3),Rz(1),Rz(2),Rz(3),'-b','filled','linewidth',width);
    
else
    
    h(1) = quiver3(axes_h,r(1),r(2),r(3),Rx(1),Rx(2),Rx(3),'-r','filled','linewidth',width);
    h(2) = quiver3(axes_h,r(1),r(2),r(3),Ry(1),Ry(2),Ry(3),'-g','filled','linewidth',width);
    h(3) = quiver3(axes_h,r(1),r(2),r(3),Rz(1),Rz(2),Rz(3),'-b','filled','linewidth',width); 
    
end

hold off;


end

