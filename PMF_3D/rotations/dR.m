function [dRk,dRk2] = dR(w,T)
%DR computes the Rodrigues' rotation formula
%
%   input --------------------------------------------------------------
%
%       o w: (1 x 3), angular velocity
%
%       o T: (1 x 1), period
%
%

L = T * w;
L = L(:);

theta = norm(L);
k     = L./norm(L);

K = [0     -k(3)   k(2);
     k(3)     0   -k(1);
    -k(2)   k(1)     0];

dRk = cos(theta) .* eye(3,3) + sin(theta) .* K + (1 - cos(theta)) .* k * k';

wx = w(1);
wy = w(2);
wz = w(3);



dRk2 = zeros(3,3);


dRk2(1,1) = cos(theta) + wx^2 * (1-cos(theta));
dRk2(1,2) =  wx*wy*(1 -cos(theta)) - wz * sin(theta);
dRk2(1,3) =  wy*sin(theta) + wx*wz * (1 - cos(theta));

dRk2(2,1) =  wz*sin(theta) + wx*wy * (1 - cos(theta));
dRk2(2,2) =     cos(theta) + wy^2  * (1 - cos(theta));
dRk2(2,3) = -wx*sin(theta) + wy*wz * (1 - cos(theta));

dRk2(3,1) = -wy*sin(theta) + wx*wz * (1 - cos(theta));
dRk2(3,2) =  wx*sin(theta) + wy*wz * (1 - cos(theta));
dRk2(3,3) =     cos(theta) + wz^2  * (1 - cos(theta));



end

