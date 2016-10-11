function [ R ] = Ry( theta )
%RY Rotation matrix around the y-axis 
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

R = [cos(theta) 0 sin(theta);
        0       1       0   ;
     -sin(theta) 0  cos(theta)   ];  
end

