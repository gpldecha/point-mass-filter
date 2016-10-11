function w = drpy2w(rpy,drpy)
%DRPY2W Converts Euler rates to Angular velocity
%
%   input -----------------------------------------------
%
%       o rpy: (1 x 3), Euler angles, row pitch yaw
%
%       o drpy: (1 x 3), Euler angle rates, drow, dpitch, dyaw 
%
%   output ----------------------------------------------
%
%       o w: (1 x 3), angular velocity
%
%

%   (3 x 3) * (1 x 3)'
w = EulerRateMatrix(rpy)  * drpy';

end

