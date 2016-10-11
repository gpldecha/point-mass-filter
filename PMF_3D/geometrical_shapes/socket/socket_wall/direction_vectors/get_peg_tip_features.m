function [ direction_vector ] = get_peg_tip_features(r,q,dist_func)
%GET_PET_TIP_FEATURES
%
% input ---------------------------------------------------------------
%
%       o r: (N x 3), Cartesian Position
%
%       o q: (N x 4), Quaternion
%
%       o dist_func, function handle 
%
%   output ------------------------------------------------------------
%
%       o direction_vector: cell(1,3)
%
%           -direction_vector{1}: (N x 9)
%                   (1 -> 3): direction surface
%                   (4 -> 6): direction edge
%                   (7 -> 9): position of peg tip
%                   (10)     : boolean is inside the object or not
%


direction_vector = cell(1,3);

%  (N x 9)
peg_positions = get_peg_tip_positions(r,q);

N = size(peg_positions,1);


X1 = peg_positions(:,1:3);

[~,~,proj_s,proj_e,b_in]        = dist_func(X1);
direction_vector{1}        = zeros(N,9);
direction_vector{1}(:,1:3) = proj_s - X1;
direction_vector{1}(:,4:6) = proj_e - X1;
direction_vector{1}(:,7:9) = X1;
direction_vector{1}(:,10)  = b_in;

X2 = peg_positions(:,4:6);

[~,~,proj_s,proj_e,b_in]        = dist_func(X2);
direction_vector{2}        = zeros(N,9);
direction_vector{2}(:,1:3) = proj_s - X2;
direction_vector{2}(:,4:6) = proj_e - X2;
direction_vector{2}(:,7:9) = X2;
direction_vector{2}(:,10)  = b_in;

X3 = peg_positions(:,7:9);

[~,~,proj_s,proj_e,b_in]        = dist_func(X3);
direction_vector{3}        = zeros(N,9);
direction_vector{3}(:,1:3) = proj_s - X3;
direction_vector{3}(:,4:6) = proj_e - X3;
direction_vector{3}(:,7:9) = X3;
direction_vector{3}(:,10)  = b_in;




end

