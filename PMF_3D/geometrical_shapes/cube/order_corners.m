function [corners_n,index ] = order_corners( corners )
%ORDER_CORNERS Summary of this function goes here
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

   
index = zeros(4,1);         
        
for i=1:4
    dist  = sqrt(sum((corners_n - repmat(corners(i,:),4,1)).^2,2));    
    [~,I] = min(dist);
    index(i) = I(1);
end
         
         
         

end

