function [Y,proj] = sw_edge(tip_positions,rot,type,sw_min_dist_edge_f,sw_dist_edge_f)
%SW_EDGE 
%
%
%   input --------------------------------------------
%
%       o tip_positions: (N x 9)
%               tip_positions(:,1:3) :  left    
%               tip_positions(:,4:6) :  middle  
%               tip_positions(:,7:9) :  right 
%
%       o rot: (3 x 3), orientation matrix of he peg's position
%       
%
%       o type: (1 x 1)
%              - 1: contact/no contact
%              - 2: direction vector
%              - 3: left, right, up, down contact
%
%
%       o sw_min_dist_edge_f: function handle
%              - [distance,direction,position] = sw_min_dist_edge(tip_positions) 
%       
%
%



switch type
    
    case 1 % Simple binary edge contact or not
       [distance,direction,pos] =  sw_min_dist_edge_f(tip_positions);
        Y  =  distance;
        Y(find(distance > 0.01),1)  = 0;
        Y(find(distance <= 0.01),1) = 1;        
        
    case 2 % return the direction of contact
              
        [distance,direction,pos]    =  sw_min_dist_edge_f(tip_positions);
        Y                           = zeros(size(distance,1),3);
        Y(:,1)                      = distance;
        Y(find(distance > 0.01),1)  = 0;
        Y(find(distance <= 0.01),1) = 1; 
        
        proj = pos + direction;
        Rot  = rot(1:3,1:3);
        proj_afr   = (Rot' * proj' -Rot' * pos')';
%         %              
%         Y(:,2)     = atan2(proj_afr(:,3),proj_afr(:,2)); % z and y
%         Y(:,3)     = atan2(proj_afr(:,1),proj_afr(:,2)); % x and y
        
    case 3
       [distance,direction,pos] =  sw_min_dist_edge_f(tip_positions);
        Y                       = zeros(size(distance,1),5);
        Y(:,1)                  = distance;
        I2                      = find(distance <= 0.01);
               
        if ~isempty(I2)
            Y(I2,1)                 = 1;
            
            M                       = size(I2,2);
                        
            left                    = repmat([-1  0],M,1);
            right                   = repmat([1 0],M,1);
            up                      = repmat([0  1],M,1);
            down                    = repmat([0 -1],M,1);
            
            direction               = normr(direction(I2,2:3));
            Y_left                  = acos(dot(left,direction));
            Y_right                 = acos(dot(right,direction));
            Y_up                    = acos(dot(up,direction));
            Y_down                  = acos(dot(down,direction));
            
            I3   = find(Y_left <= pi/4);   
            I4   = find(Y_left >  pi/4);
            Y_left(I3) = 1;
            Y_left(I4) = 0;
            Y(I2,2)    = Y_left;     
            
            
            I3   = find(Y_right <= pi/4);   
            I4   = find(Y_right >  pi/4);
            Y_right(I3) = 1;
            Y_right(I4) = 0;
            Y(I2,3)    = Y_right;
            
            I3   = find(Y_up <= pi/4);
            I4   = find(Y_up >  pi/4);
            Y_up(I3) = 1;
            Y_up(I4) = 0;
            Y(I2,4)    = Y_up;
            
            I3   = find(Y_down <= pi/4);
            I4   = find(Y_down >  pi/4);
            Y_down(I3) = 1;
            Y_down(I4) = 0;
            Y(I2,5)    = Y_down;
            
                       
        end

    case 4
        
        % (N x 9)

        [dist,proj]   = sw_dist_edge_f(tip_positions);
        theta = zeros(size(dist,1),3);
        
        for i = 1:3
            I = find(dist(:,i) <= 0.01);
            if ~isempty(I)
                theta(I,i) = dist(I,i);
            end
        end
        
      %  [~,I]           = min(dist,[],2);
      %  Index           = ((I - 1) * 3 + 1);
       % direction       = proj(:,Index:Index + 2) - tip_positions(:,Index:Index + 2);
       % contact_point   = 
        Y               = theta;%,direction];
        
    otherwise
        
        disp(['measurement_functions type: ' num2str(type) ' is not implemented']);
        Y = NaN;
        
end



end

