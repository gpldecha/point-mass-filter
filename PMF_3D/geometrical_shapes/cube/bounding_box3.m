function b_inside = bounding_box3(X,origin,xyz)
%BOUNDING_BOX Checks if the points are inside the bounding box or not,
%             The bounding box is assumed to be aligned wit the world's       
%             axis for simplicity
%
%   input -------------------------------------------------------------
%
%       o X: (N x 3)
%
%       o origin: (1 x 3), origin of the bounding box, it's orientation is
%                          assumued to be identitiy.
%
%       o xyz: (3 x 2), limits of the bounding box
%               
%               - xyz(1,1) : lower limit (negative) (x-axis)
%               - xyz(1,2) : upper limit (positive) (x-axis)
%
%

N    = size(X,1);
X_bb = X - repmat(origin,N,1);

% check if is iniside range

b_inside =            (X_bb(:,1) > xyz(1,1) & X_bb(:,1) < xyz(1,2));
b_inside = b_inside & (X_bb(:,2) > xyz(2,1) & X_bb(:,2) < xyz(2,2));
b_inside = b_inside & (X_bb(:,3) > xyz(3,1) & X_bb(:,3) < xyz(3,2));

end

