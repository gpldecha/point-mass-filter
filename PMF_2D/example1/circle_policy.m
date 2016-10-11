function [pos,orient,theta] = circle_policy(radius,theta,C,dt)
%POLICY Given the agents current position and direction, compute the next
%action to take
%
%   input ----------------------------------------------------
%
%       o radius, chosen radius of the circle
%
%       o theta, current theta
%
%       o C: (1 x 2), center of the circle
%
%       o dt, time update
%
%   output ---------------------------------------------------
%
%       o pos: (1 x 2), position of the agent
%
%       o direction: (1 x 2), viewing direction of the agent
%

theta = theta + dt;
if(theta > 2*pi)
    theta = 0;
end


pos(1) = radius  * cos(theta) + C(1);
pos(2) = radius  * sin(theta) + C(2);


tmp = C - pos;
tmp = tmp./norm(tmp);

orient = eye(2,2);
orient(1,1) =  -tmp(2);
orient(2,1) =   tmp(1);
        
%             (2 x 2) * (2 x 1)
orient(:,2) = rot2D(pi/2) * orient(:,1);



end




