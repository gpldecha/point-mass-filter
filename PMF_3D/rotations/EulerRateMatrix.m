function  E = EulerRateMatrix( rpy )
%EULERRATEMATRIX Computes the Euler Rate Matrix
%
%
%   input -----------------------------------------------
%
%       o rpy: (1 x 3), Euler angles, row pitch yaw
%
%   output ----------------------------------------------
%
%       o E: (3 x 3), Euler rate matrix
%
%
E = [(Rz(rpy(3))' * Ry(rpy(2))') * [1 0 0]',Rz(rpy(3))' * [0 1 0]',[0 0 1]'];


end

