function h = plot_dist_measurement(gca,Y,position,rot,h)
%PLOT_DIST_MEASUREMENT 
%
%   input -------------------------------------------------
%
%       o Y: (1 x 3), 
%           Y(1):   range
%           Y(2):   angle
%
%       o position: (1 x 2), position from which the measurement was taken.
%
%       o rot:  (2 x 2), rotation frame of reference with respect to world
%


if isempty(Y) && ~isempty(h)
    
        L         = [0 0;0 0];
   
        set(h(1),'XData',L(:,1),'YData',L(:,2));
        set(h(2),'XData',0,'YData',0);
    
elseif ~isempty(Y)
    
    range = Y(1);
    theta = Y(2);
    
    heading = rot(:,1);
    
    %(2 x 1)
    direction = R(theta) * heading;
   
    proj      = position + direction' .* range;
    L         = [position;proj];
    
    if isempty(h)
        hold on;
        h(1) = plot(gca,L(:,1),L(:,2),'-r','LineWidth',1);
        h(2) = scatter(gca,proj(1),proj(2),100,'+','MarkerEdgeColor',[1 0 0]);
        hold off;
        
    else
        
        set(h(1),'XData',L(:,1),'YData',L(:,2));
        set(h(2),'XData',proj(1),'YData',proj(2));
        
    end
    
end


end

function r = R(theta)

    r = [cos(theta) -sin(theta);sin(theta) cos(theta)];

end

