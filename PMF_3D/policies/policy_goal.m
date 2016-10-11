function u = policy_goal(x,T)
%   POLICY_GOAL 
%
%   input -----------------------------------------------------------------
%
%       o x : (3 x 1), current position of end-effector
%
%       o T : (3 x 1), target point
%
%   output ----------------------------------------------------------------
%
%       o u : (3 x 1), linear velocity
%

u = T(:)-x;
u = u./norm(u);

end