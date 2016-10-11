function euler_anlge = q2rpy( q )
%Q2RPY quaternion to row, pitch, yaw angles
%
%   row, pitch, yaw
%
%

qw  = q(1);
qx  = q(2);
qy  = q(3);
qz  = q(4);


euler_anlge = zeros(3,1);

euler_anlge(1)  =   atan2(  2 * (qw * qx + qy * qz)    ,   1 - 2 * (qx^2 + qy^2)    );
euler_anlge(2)  =   asin(   2 * (qw * qy - qz * qx)   ); 
euler_anlge(3)  =   atan2(  2 * (qw * qz + qx * qy)    ,   1 - 2  * (qy^2 + qz^2 )  );


end

