function Y = measurement_function(tip_position,hY_contact,hY_edge,hY_inserted)
%CONTACT_MEASUREMENT_FUNCTION
%
%   input --------------------------------------------------------
%
%         o pos: (N x 3), Cartesian position
%
%         o tip_position: (N x 9), position of tip
%
%         o hY_contact: binary contact function,
%                       input: middle_tip_position, (N x 3)
%
%         o hY_edge:    edge contact function
%           
%
%
%         o hY_inserted: function handle.. gives probability of having inserted
%                        the peg into the socekt.
%
%
%   output -------------------------------------------------------
%
%        o Y (N x 5)
%
%           Y(1): contact surface.
%           Y(2): is inserted in the plug.
%   
%   
%       o bIn:    boolean vector which states if the frame of reference is
%                 inside an object.
%
%   
%   Comment ------------------------------------------------------
%


N                    = size(tip_position,1);
Y                    = zeros(N,2);

Y(:,1)  =  hY_contact(tip_position(:,1:3));
Y(:,2)  =  hY_inserted(tip_position);
Y       =  [Y,hY_edge(tip_position)];


%atan2(norm(cross(a,b)), dot(a,b))

% in the y-z plane


% direction = direction(:,2:3);
% direction = normr(direction);
% Y(:,4:5)  = direction;
% Y(:,4) = acosd(dot(left,direction));
% Y(:,5) = acosd(dot(right,direction));
% Y(:,6) = acosd(dot(up,direction));
% Y(:,7) = acosd(dot(down,direction));


% Y(:,4) = atan2( left(:,2)   - direction(:,1),left(:,1)  - direction(:,2)) * 180/pi;
% Y(:,5) = atan2( right(:,2)  - direction(:,1),right(:,1) - direction(:,2)) * 180/pi;
% Y(:,6) = atan2( up(:,2)     - direction(:,1),up(:,1)    - direction(:,2)) * 180/pi;
% Y(:,7) = atan2( down(:,2)   - direction(:,1),down(:,1)  - direction(:,2)) * 180/pi;



% tmp = Y(:,4);
% Y(find(tmp < pi/4),4)  = 1;
% Y(find(tmp >= pi/4),4) = 0;
% 
% tmp = Y(:,5);
% Y(find(tmp < pi/4),5)  = 1;
% Y(find(tmp >= pi/4),5) = 0;
% 
% tmp = Y(:,6);
% Y(find(tmp < pi/4),6)  = 1;
% Y(find(tmp >= pi/4),6) = 0;
% 
% tmp = Y(:,7);
% Y(find(tmp < pi/4),7)  = 1;
% Y(find(tmp >= pi/4),7) = 0;


% Get contact direction





% direction_vector  = tip_features_func(r);
% 
% 
% dist_sq1 = sqrt(sum((direction_vector{1}(:,1:3)).^2,2));
% dist_sq2 = sqrt(sum((direction_vector{2}(:,1:3)).^2,2));
% dist_sq3 = sqrt(sum((direction_vector{3}(:,1:3)).^2,2));
% 
% Y(:,1) = min([dist_sq1,dist_sq2,dist_sq3],[],2);
% 
% %bIn = bIn | is_inside_sw(direction_vector{2}(:,7:9),w_socket);
% 
% dist_sq1   = sqrt(sum((direction_vector{1}(:,4:6)).^2,2));
% dist_sq2   = sqrt(sum((direction_vector{2}(:,4:6)).^2,2));
% dist_sq3   = sqrt(sum((direction_vector{3}(:,4:6)).^2,2));
% 
% Y(:,2)     = min([dist_sq1,dist_sq2,dist_sq3],[],2);
% 
% 
% 
% Y(:,3)     = hY_in(direction_vector{2}(:,7:9));
% 
% 
% % Change distance into probability of a contact
% 
% tmp = Y(:,1);
% Y(find(tmp > 0.02),1)  = 0;
% 
% Y(find(tmp <= 0.02),1) = 1;
% 
% tmp = Y(:,2);
% Y(find(tmp > 0.01),2)  = 0;

% Y(find(tmp <= 0.01),2) = 1;






    
end

