function R = rpy2r(rpy)
%RPY2R row, pitch, yaw to rotation Matrix
%
%
R = Rz(rpy(3)) * Ry(rpy(2)) * Rx(rpy(1));

end

