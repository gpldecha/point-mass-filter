function [xp,xq,dx,dq] = peg_world_next_state(x,q,dx,dq,socket_wall)
% PEG_WORLD_NEXT_STATE Computes the next state after applying action u in
% state x
%
%   input----------------------------------------------------------------
%
%       o x  : (1 x 3), Cartesian position of the end-effector
%
%       o q  : (1 x 4), Quaternion orientation of the end-effector
%
%       o dx : (1 x 3), Linear velocity 
%
%       o dq : (1 x 4), Quaternion rate
%
%       o socket_world : struct
%
%   output -------------------------------------------------------------
%          
%       o xp : (1 x 3), next state
%
%       o xq : (1 x 4), next state
%

x  = x(:)';
dx = dx(:)';
q  = q(:)';
dq = dq(:)';

if (size(x,1) ~= size(dx,1)) || (size(x,2) ~= size(dx,2)) 
   disp('There will be an error dx and x do not match!');
   x
   dx
end

xp  = x + dx;
xq  = q + dq;

xp  = correct_peg_position(xp,q2r(xq),socket_wall);

dx  = xp - x;
dq  = xq - q;




end

