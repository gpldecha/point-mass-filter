function [dist, proj ] = dist2line2D(X,line_seg)
%DIST2LINE  Computes the distance to line segments
%
%   input ---------------------------------------------------------
%
%       o X:    (N x 2), Cartesian position
%   
%       o line:  N x 4, line
%
%               line(1:2): point A
%               line(3:4): point B
%               
%   output --------------------------------------------------------
%
%       o dist: (N x 1), distance of point to line
%
%       o proj: (N x 2), projection of points X onto line segment
%


N = size(X,1);

A       = line_seg(:,1:2); %(N x 2)
B       = line_seg(:,3:4); %(N x 2)
dist_AB = sqrt(sum((B - A).^2,2));

w_AB = B - A;
% (N x 2)

if size(line_seg,1) ~= 1
 vec_AB =    w_AB./repmat(dist_AB,1,2);
else
 vec_AB = repmat(w_AB./dist_AB,N,1);   
end


% (N x 2)

if size(A,1) == 1
    vec_AX =  X - repmat(A,N,1);
else
    vec_AX =  X - A;  
end


%   (N x 2) * (N x 2) 
t       =  sum(vec_AX .* vec_AB,2);
idx     = find(t < 0);
t(idx)  = 0;
idx     = find(t > dist_AB);
if size(dist_AB,1) == 1
    t(idx)  = dist_AB;
else
    t(idx)  = dist_AB(idx);    
end

if size(A,1) == 1
    proj =  repmat(A,N,1) + repmat(t,1,2) .* vec_AB;
else
     proj =  A + repmat(t,1,2) .* vec_AB;   
end

dist =  sqrt(sum((proj - X).^2,2));








end

