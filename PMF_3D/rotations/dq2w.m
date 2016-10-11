function w = dq2w(q,dq)
%DQ2W Converts Quaterion rates to angular velocity
%
%   input ---------------------------------------
%
%       o q: (1 x 4), N Quaternions
%
%       o dq: (1 x 4), N Quaternion rates
%
%   output -------------------------------------
%
%       o w: (1 x 3), N angular velocities
%   
%

% W = [-qx  qw -qz  qy;
%      -qy  qz  qw -qx;
%      -qz -qy  qx  qw];
 
qw = q( 1 );
qx = q( 2 );
qy = q( 3 );
qz = q( 4 );

W = [-qx  qw -qz  qy;
     -qy  qz  qw -qx;
     -qz -qy  qx  qw];


 w = 2 * W * dq';


end

