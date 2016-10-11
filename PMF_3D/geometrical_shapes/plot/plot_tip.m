function handle = plot_tip(tip,surf,edge,handle)

    Ls = [tip;tip + surf];
    Le = [tip;tip + edge];


if isempty(handle)
    
    handle(1) = plot3(tip(1),tip(2),tip(3),'o','MarkerFaceColor',[0 0 0],'MarkerEdgeColor',[0 0 0],'MarkerSize',2);
    handle(2) = plot3(Ls(:,1),Ls(:,2),Ls(:,3),'-r');
    handle(3) = plot3(Le(:,1),Le(:,2),Le(:,3),'-b');
    
else
   
    set(handle(1),'XData',tip(1),'YData',tip(2),'ZData',tip(3));
    set(handle(2),'XData',Ls(:,1),'YData',Ls(:,2),'ZData',Ls(:,3));
    set(handle(3),'XData',Le(:,1),'YData',Le(:,2),'ZData',Le(:,3));
    
end


end
