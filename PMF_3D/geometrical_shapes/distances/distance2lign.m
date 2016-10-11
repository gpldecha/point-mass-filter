function [d,x_t_proj] = distance2lign(x_t,line_segments)
%   Computes the distance to lign segments
%
%   input -----------------------------------------------------------------
%
%       o x_t: (N x 3)
%
%       o line_segments: (K x 3 * 2)
%            line_segments(1,1:3): point1       
%            line_segments(1,4:6): point2
%
%   output ----------------------------------------------------------------
%   
%       o d: (N x K), distances to each K line segements for N samples.
%
%       o x_t_proj (N,3,K)
%


N = size(x_t,1); % number of points
K = size(line_segments,1); % number of lign segments
d = zeros(N,K);
x_t_proj = zeros(N,3,K);

v_p1Top2 = (line_segments(:,1:3) - line_segments(:,4:6)); % (K x 3)

for k=1:K % for each line segment
   
     % disp(['k(' num2str(k) ')']);
      
      p1 = line_segments(k,4:6);
      
      % project them all
      % (N x 3) * (3 x 1)
      %           (N x 3) - (N x 3)  * (1 x 3)
      lambda =  (x_t - repmat(p1,N,1)) * v_p1Top2(k,:)'/(  norm(v_p1Top2(k,:)).^2)  ;
      
      % project points x_t onto the line segment (N x 3)  + lambda * (N x 3)    
      x_t_proj(:,:,k) = repmat(p1,N,1) + repmat(lambda,1,3) .* repmat(v_p1Top2(k,:),N,1);
      
      
      I = (1:N);
      J1 = find(lambda < 0); % find all points which are outside the lign segment
      J2 = find(lambda > 1);
      
      J1 = J1(:);
      J1 = J1';
      J2 = J2(:);
      J2 = J2';
      
      I(intersect(I,[J1 J2])) = [];
      
     % disp(['size(J1): ' num2str(size(J1))]);
      % disp(['size(J2): ' num2str(size(J2))]);

      
      
      if ~isempty(I)
          v0 = sqrt(sum((x_t_proj(I,:,k) - x_t(I,:)).^2,2));
          d(I,k) = v0;
      end
      
      if ~isempty(J1)
        %  size( repmat(line_segments(k,4:6),size(J1,2),1))
        %  size(x_t_proj(J1,:,k))
          
         x_t_proj(J1,:,k) =  repmat(line_segments(k,4:6),size(J1,2),1);
         d(J1,k) = sqrt(sum(  (x_t(J1,:) - x_t_proj(J1,:,k)  ).^2,2)); 
      end
      
      if ~isempty(J2)
         x_t_proj(J2,:,k) =  repmat(line_segments(k,1:3),size(J2,2),1);
         d(J2,k) =  sqrt(sum((x_t(J2,:) - x_t_proj(J2,:,k)).^2,2));
      end
  
end



end

