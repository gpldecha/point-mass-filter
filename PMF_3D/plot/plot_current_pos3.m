function [h_p,h_q] = plot_current_pos3(r,q,scale,width,handle_p,handle_q )
%PLOT_CURRENT_POS (3D)
%
%   input ---------------------------------------------------------
%
%       o r: (3 x 1)
%
%       o q: (4 x 1)
%
%       
%
h_q = [];

tip = get_peg_tip_positions(r,q2r(q));


if(isempty(handle_p))

    h_p(1) = plot3(r(1),r(2),r(3),'-ok','markers',10,'LineWidth',2);
    h_p(2) = scatter3(r(1),r(2),r(3),20,'k','fill');
    h_p(3) = plot3(tip(1),tip(2),tip(3),'ok','markers',5,'MarkerFaceColor',[0 0 0]);
    h_p(4) = plot3(tip(4),tip(5),tip(6),'ok','markers',5,'MarkerFaceColor',[0 0 0]);
    h_p(5) = plot3(tip(7),tip(8),tip(9),'ok','markers',5,'MarkerFaceColor',[0 0 0]);

    
    h_q    = plot_orientation_up(r,q,scale,width,handle_q);

    
else
    
    set(handle_p(1),'XData',r(1),'YData',r(2),'ZData',r(3));
    set(handle_p(2),'XData',r(1),'YData',r(2),'ZData',r(3));

    set(handle_p(3),'XData',tip(1),'YData',tip(2),'ZData',tip(3));
    set(handle_p(4),'XData',tip(4),'YData',tip(5),'ZData',tip(6));
    set(handle_p(5),'XData',tip(7),'YData',tip(8),'ZData',tip(9));

    plot_orientation_up(r,q,scale,width,handle_q);

end


end


function h = plot_orientation_up(r,q,scale,width,handle)

R = q2r(q);
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


end


