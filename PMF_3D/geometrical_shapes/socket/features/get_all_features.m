function [proj_socket,proj_corner,X,H,orient_goal] = get_all_features(modes,XYZW,q,swall,n )
%GET_ALL_FEATURES Summary of this function goes here
%   Detailed explanation goes here



Mu      = sum(XYZW(:,1:3) .* repmat(XYZW(:,4),1,3),1);
p       = XYZW(XYZW(:,4)>0,4);
H       = sum(-(p.*(log2(p))));

X       = [Mu;modes];

K = size(modes,1);

proj_socket = cell(K+1,1);
proj_corner = cell(K+1,1);

[p_socket,p_corner] = get_features_socket_A(Mu,swall,n);
proj_socket{1} = p_socket;
proj_corner{1} = p_corner;

for i = 1:size(modes,1)
    [p_socket,p_corner] = get_features_socket_A(modes(i,:),swall,n);
    proj_socket{i+1} = p_socket;
    proj_corner{i+1} = p_corner;
end

R             = q2r(q);
orient_goal  = dot(R(:,2),[0 0 1]');


end

