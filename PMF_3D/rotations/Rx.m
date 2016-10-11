function R = Rx( theta )
%RX Rotation matrix around the x-axis 
%
%   input ------------------------------------
%       
%       o theta: (1 x 1), angle to rotate around x (in radians)
%
%   output ----------------------------------
%   
%       o R: (3 x 3), rotation matrix
%
%

R = [1       0           0;
     0   cos(theta) -sin(theta);
     0   sin(theta)  cos(theta)];
    
end

