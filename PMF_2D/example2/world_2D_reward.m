function [r,f] = world_2D_reward( x )
%WORLD_2D_REWARD 
%
%   input ---------------------------------------------
%
%       o x: (2 x 1), current state 
%
%
%   comment ------------------------------------------
%
%      o Return a reward of 100 if the agent reaches the 1 by 1 box
%        centered at the middle of the 2d world and returns 0 otherwise.
%
%

%% Point reward

% if norm(x) < 0.1
%    r = 100;
%    f = true;
% else
%    r = 0;
%    f = false;
% end




%% Box reward

if (x(1) <= 1 &&  x(1) >= -1 && x(2) <= 1 && x(2) >= -1)
   r = 100;
   f = true;
else
   r = 0;
   f = false;
end



end

