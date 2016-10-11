function h = plot_orientation_rot(r,R,scale,width,handle)

Rx = R(:,1);
Ry = R(:,2);
Rz = R(:,3);
Rx = Rx./norm(Rx) * scale;
Ry = Ry./norm(Ry) * scale;
Rz = Rz./norm(Rz) * scale;

hold on;

if isempty(handle)
    
    h(1) = quiver3(r(1),r(2),r(3),Rx(1),Rx(2),Rx(3),'-r','filled','linewidth',width);
    h(2) = quiver3(r(1),r(2),r(3),Ry(1),Ry(2),Ry(3),'-g','filled','linewidth',width);
    h(3) = quiver3(r(1),r(2),r(3),Rz(1),Rz(2),Rz(3),'-b','filled','linewidth',width);
    
else
    
    set(handle(1),'xdata',r(1),'ydata',r(2),'zdata',r(3),'udata',Rx(1),'vdata',Rx(2),'wdata',Rx(3));
    set(handle(2),'xdata',r(1),'ydata',r(2),'zdata',r(3),'udata',Ry(1),'vdata',Ry(2),'wdata',Ry(3));
    set(handle(3),'xdata',r(1),'ydata',r(2),'zdata',r(3),'udata',Rz(1),'vdata',Rz(2),'wdata',Rz(3));

    
end

hold off;

end
