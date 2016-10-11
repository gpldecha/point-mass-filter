function [v] = qcross(Q,P)
%QCROSS Quaternion Cross Product
%
%
%

v = [cross(Q(1:3),P(1:3)) + Q(4) * P(1:3) + P(4) * Q(1:3),Q(4)*P(4) - (Q(1:3)  * P(1:3)')]';


end

