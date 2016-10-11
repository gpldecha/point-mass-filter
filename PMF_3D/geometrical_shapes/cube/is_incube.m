function [bInCube,proj] = is_incube(X,cube)
%IS_INCUBE Checks whether a point is in a cube and returns
% the closest surface normal.
%
%   input -----------------------------------------------------------------
%
%       o X: (N x 3), N sample points to check if they are in the cube
%
%       o cube: structure
%   
%   output ----------------------------------------------------------------
%   
%       o bInCube: (N x 1), Bool
%
%

N = size(X,1);

n = squeeze(cube.surface(5,:,:)); % 3 x 6

distance = zeros(N,6);
proj = zeros(N,3,6);

bInCube = zeros(N,1);

for i=1:6  
    v = (X - repmat(cube.surface(1,:,i),N,1)); % (N x 3)
    distance(:,i) = v * n(:,i);  % (N x 3) * (3 x 1) = (N x 1)
    p = X - (distance(:,i) * n(:,i)');% (N x 3) - (N x 1) * (1 x 3) = (N x 3)
    proj(:,:,i) = p;
end

distance = sign(distance);

J = find(sum(distance,2) == -6);
J = J(:);

if ~isempty(J)
    bInCube(J,:) = ones(size(J,1),1);
end



end

