function [ proj_x ] = get_features_square(X,corner,n)
%GET_FEATURES_SQUARE Summary of this function goes here
%
%   input -----------------------------------------------------
%
%       o corner: (N x 3)
%
%       o n: number of features \in [1,..,4]
%

if n <= 0,n = 1;end
if n > 4, n = 4;end



line_seg = [     corner(1,:),corner(2,:);
                 corner(1,:),corner(3,:);
                 corner(3,:),corner(4,:);
                 corner(4,:),corner(2,:)];

[se_d,se_proj] = distance2lign(X,line_seg);
      se_proj  = squeeze(se_proj)';
[sc_d,sc_proj] = distance2corners(X,corner);

[~,I]          = sort(se_d,'ascend');
se_proj        = se_proj(I,:); 

[~,I]          = sort(sc_d,'ascend');
sc_proj        = sc_proj(I,:); 

% ( N x 3 * 5)
proj_x = [se_proj(1:n,:);
          sc_proj(1:n,:)];
end

