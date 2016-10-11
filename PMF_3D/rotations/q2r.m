function R = q2r(q)
%   Q2R: Convert quaternion to rotation matrix
%
%
% qw = q( 4 );
% qx = q( 1 );
% qy = q( 2 );
% qz = q( 3 );

qw = q( 1 );
qx = q( 2 );
qy = q( 3 );
qz = q( 4 );


Rxx = 1 - 2*(qy^2 + qz^2);
Rxy = 2*(qx*qy - qz*qw);
Rxz = 2*(qx*qz + qy*qw);

Ryx = 2*(qx*qy + qz*qw);
Ryy = 1 - 2*(qx^2 + qz^2);
Ryz = 2*(qy*qz - qx*qw );

Rzx = 2*(qx*qz - qy*qw );
Rzy = 2*(qy*qz + qx*qw );
Rzz = 1 - 2 *(qx^2 + qy^2);

R = [ 
    Rxx,    Rxy,    Rxz;
    Ryx,    Ryy,    Ryz;
    Rzx,    Rzy,    Rzz];

end

