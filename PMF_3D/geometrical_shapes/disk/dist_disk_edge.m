function [Q,K] = dist_disk_edge(X,disk)
% DIST_DIST_EDGE
%
%   input -------------------------------------------------
%
%       o X: (N x 3), set of N Cartesian Points
%
%       o disk: structure
%
%

invR = disk.R';
invC = -invR * disk.C;
N    = size(X,1);
U    = disk.R(:,1);
V    = disk.R(:,2);
n    = disk.R(:,3);
 % (N x 3) =  (3 x 3) * (N x 3)' + (3 x 1)

    P_c =  (invR * X' + repmat(invC,1,N))';
  %     (N x 3) - (N x 3) - (3 x 1)'
  %     (N x 3) - (3 x 1) * (N x 3) * (3 x 1);
  %     (N x 3) - (1 x 3) * (3 x N) * (3 x 1)
  %     (N x 3) - (N x 1) * (1 x 3)
   Q   = X - (n' * (X - repmat(disk.C,1,N))')' * n';
    

   %(N x 1)
   q_u =  P_c(:,1)./( sqrt(P_c(:,1) .* P_c(:,1) + P_c(:,2) .* P_c(:,2)) ); 
   q_v =  P_c(:,2)./( sqrt(P_c(:,1) .* P_c(:,1) + P_c(:,2) .* P_c(:,2)) ); 

   
    %    (3 x 1) + (1 x 1) * ((N x 1) * (3 x 1) + (N x 1) * (3 x 1) )
    %    (3 x 1) + (1 x 1) * ((N x 1) * (1 x 3) + (N x 1) * (1 x 3) )
    %    (3 x 1) + (1 x 1) * (N x 3)

    K   = repmat(disk.C',N,1) + disk.r .* (q_u * U' + q_v * V');

%    dist_edge       = arma::norm(K - P_w,2);
%    dist_surface    = arma::norm(Q - P_w,2);


end