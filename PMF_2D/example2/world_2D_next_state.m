function xp = world_2D_next_state(x,u)
% 2D_WORLD_NEXT_STATE Square world, applies motion to the state and gets
% the future point
%
%   input --------------------------------------------------------
%   
%       o x: (N x 2), N states of dimension 2 
%
%       o u: (1 x 2), velocity
%
%
%   output -------------------------------------------------------
%   
%       o xp : (N x 2), next state
%
%
%   comment ------------------------------------------------------
%
%       o The 2d World is a 20 x 16 [m] rectangle, if the any of the futur
%         states enter in contact with the wall, then they are put back in
%         place (inelastic collision
%         The rectangle is centered at (0,0)
%

N  = size(x,1);
u = u(:)';
xp = x + repmat(u,N,1);

% find all points which lie outside the rectangle

idx = find(xp(:,1) > 11);
if ~isempty(idx)
    xp(idx,1) = 10;
end

idx = find(xp(:,1) < -11);
if ~isempty(idx)
    xp(idx,1) = -10;
end

idx = find(xp(:,2) > 11);
if ~isempty(idx)
    xp(idx,2) = 10;
end

idx = find(xp(:,2) < -11);
if ~isempty(idx)
    xp(idx,2) = -10;
end

end

