function [d,proj] = distance2planSegment(x_t,corners,n )
%DISTANCE2PLANSEGMENT 
%
%   input -----------------------------------------------------------------
%
%       o x_t: ( N x 3 ), cartesian points
%
%       o corners: (4 x 3), set of 4 corner points defining the Surface
%         segment.
%       
%       o n: (3 x 1), normal of the plan
%
%   output-----------------------------------------------------------------
%
%       o d: (N x 1)
%
%       o proj: (N x 3)
%
%
N = size(x_t,1); % number of points

d = zeros(N,1);



p = corners(1,:);
  
%                      (N x 1)         * (3 x 1)
%        (N x 3) - ((N x 3) - (N x 3)) * (3 x 1)


d        = ((x_t - repmat(p,N,1)) *  n' );
x_t_proj = x_t - d * n; % project all points onto the plane
proj     = x_t_proj;



I           = find(n == 0);
x_t_red     = x_t_proj(:,I);
corners_red = corners(:,I);

T           = mean(corners_red);
corners_red = corners_red - repmat(T,4,1);
x_t_red_c   = x_t_red     - repmat(T,N,1);


corners_red = order_rec_corners(corners_red);


in = inpolygon(x_t_red_c(:,1),x_t_red_c(:,2),corners_red(:,1),corners_red(:,2));



% if in distance = simply distance of projection
% if not, find shortest distance to every edge
I = find(in == 0);
if ~isempty(I)
       
    edges = [corners(1,:) corners(2,:);
             corners(2,:) corners(3,:);
             corners(3,:) corners(4,:);
             corners(4,:) corners(1,:)];
         
     [d2e,proj_e] = distance2lign(x_t(I,:),edges);
        
        
    [d_edge,index] = min(d2e,[],2);
     d(I,:)        = d_edge; % all points which were outside polygon set minimum edge distance
     

    
     % x_t_proj (N,3,K), distance to K line segment (K = 4)
     % N = size(I,1) in this case
    
    for i=1:size(I,1)
         proj(I(i),:) = proj_e(i,:,index(i));
    end
    
    
%    [~,I2] = min(d2e');
%    x_t_proj = proj(:,:,3);
end

d = abs(d);

end

function corners_n = order_rec_corners(corners)
%
%   input ---------------------------
%
%      o corners (4 x 2)
%


pos_x_corner = corners(find(corners(:,1) > 0),:);
neg_x_corner = corners(find(corners(:,1) < 0),:);


if(pos_x_corner(1,2) > 0)
    pos_x_pos_y_c =  pos_x_corner(1,:);
    pos_x_neg_y_c =  pos_x_corner(2,:);
else
    pos_x_pos_y_c =  pos_x_corner(2,:);
    pos_x_neg_y_c =  pos_x_corner(1,:);
end

if(neg_x_corner(1,2) < 0)
    neg_x_neg_y_c =  neg_x_corner(1,:);
    neg_x_pos_y_c =  neg_x_corner(2,:);
else
    neg_x_neg_y_c =  neg_x_corner(2,:);
    neg_x_pos_y_c =  neg_x_corner(1,:);
end

corners_n = [pos_x_pos_y_c;
             pos_x_neg_y_c;
             neg_x_neg_y_c;
             neg_x_pos_y_c];



end

