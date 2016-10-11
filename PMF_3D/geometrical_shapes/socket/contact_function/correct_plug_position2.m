function [x_new,R_new,X_target ] = correct_plug_position2(x_ref,R_ref,peg_model,socket_wall)
%CORRECT_PLUG_POSITION2 
%
%
%   input ---------------------------------------------------------
%
%       o x_ref: (1 x 3), frame of refrence of the peg model
%
%       o R_ref: (3 x 3), rotation of the peg model
%
%       o tip_position: (1 x 9), tip position
%
%
%       o I: (N x 1), binary set of points which indicate which points of
%                     the meash are in contact with the world
%
%       o socket_wall, structure containing the world
%
%
%

% I = get_contact_points(x_ref,R_ref,peg_model,socket_wall);
% I = find(bInCube == 1);


%     
% tips  = get_peg_tip_positions(x_ref,q_ref);
% tips  = [tips(1,1:3);
%         tips(1,4:6);
%         tips(1,7:9)];   

N   = size(peg_model,1);

X_w = (R_ref * peg_model' + repmat(x_ref',1,N))';
    
bInCube        = is_inside_sw(X_w,socket_wall);
I              = find(bInCube == 1);
x_new          = x_ref;
R_new          = R_ref;


% if not empty then a peg is inside the wall
if ~isempty(I)
    
    % optimisation such to minimise contacts of the full mesh
    

    
    is_inside_f       = @(X)is_inside_sw(X,socket_wall);
    get_dist_f        = @(X)get_projection_dist_sw(X,socket_wall,is_inside_f);
    
    X_inside          = X_w(I,:);
    [X_dist,X_target] = get_dist_f(X_inside);
    
  %  fun                = @(theta)distance_to_contact2(theta,R_ref,I,peg_model,X_target,size(X_inside,1),is_inside_f);
    fun                = @(theta)distance_to_contact_full_model(theta,R_ref,peg_model,get_dist_f,is_inside_f);

   
   [rx,ry,rz]         = r2rpy(R_ref);
   theta              = [x_ref,rx,ry,rz];
%   theta              = x_ref;
   
%    disp(['check function: ' num2str(fun(theta))]);
   
   options   = optimset('Display','off','TolFun',1e-04,'TolFun',1e-04,'MaxIter',50);
   theta_new = fminsearch(fun,theta,options);
   
   disp('function value after optimisation');
   %fun                = @(theta)distance_to_contact2(theta,R_ref,X_inside,size(X_inside,1),dist_no_contact_f,is_inside_f,true);

  % fun(theta_new)
   
   x_new = theta_new(1:3);
   if(size(theta_new,2) == 6)
      R_new = rpy2r(theta(4),theta(5),theta(6));
   end
   
   
%     wall_cube      = socket_wall.wall;
%     R_ref          = q2r(q_ref);
%     [rx,ry,rz]     = r2rpy(R_ref);
%     theta     = [x_ref,rx,ry,rz];
%     [~,proj] = distance2surf(tips,wall_cube,1);
%     
%     fun       = @(theta)distance_to_contact(theta,proj,rx,ry,rz,wall_cube);
%     fun(theta)
%     options = optimset('Display','iter');
%     theta_new = fminsearch(fun,theta,options);
%     x_new = theta_new(1:3);
%    % R_new = R_ref;
%     R_new  = rpy2r(theta(4),theta(5),theta(6));
    
    
    
%     [d,proj]     = distance2surf(tips,wall_cube,1);
%     [~,idx]      = max(d(I));
%     corr_vec     = proj(I(idx),:) - tips(I(idx),:);
%     tips         = tips + repmat(corr_vec,3,1);
%     ref_position = ref_position + corr_vec;
%     tip_position(1,1:3) = tips(1,:);
%     tip_position(1,4:6) = tips(2,:);
%     tip_position(1,7:9) = tips(3,:);
end

end

function y = distance_to_contact(theta,target,rx,ry,rz,wall_cube)
%   Objective function to minimise such to have no contacts
%
%   input ----------------------------------------------
%
%       o theta: ( 6 x 1 )
%           theta(1:3), x y z, 
%           theta(4:6), row pitch yaw
%
%       o d: (N x 3), contact points
%
%
r   = theta(1:3);
q   = rpy2q(theta(4),theta(5),theta(6));
%q   = rpy2q(rx,ry,rz);


tips  = get_peg_tip_positions(r,q);
tips  = [tips(1,1:3);
        tips(1,4:6);
        tips(1,7:9)];

%[~,proj] = distance2surf(tips,wall_cube,1);

y        = sum( sqrt(sum((target - tips).^2,2))   );



end

function y = distance_to_contact2(theta,R,I,peg_model,X_target,N,is_inside_f)
%
%   input -------------------------------------------
%
%       o theta: (1 x 3) or (1 x 6), frame of reference parameters of the
%                                    peg. To be optimised over.
%


r  = theta(1:3);
%R  = rpy2r(theta(4),theta(5),theta(6));
%R   = rpy2r(rx,ry,theta(6));

%     (3 x 3) * (3 x N) + (3 x N)
X_w = (R * peg_model(I,:)' + repmat(r',1,N))';

% check if X_w is inside the object or not
I2  = is_inside_f(X_w);
I3  = find(I2 == 1);

if ~isempty(I3)
    dists = sqrt(sum((X_w(I3,:) - X_target(I3,:)).^2,2));
    y     = sum(dists); 
else
   y = 0; 
end


end

function y = distance_to_contact_full_model(theta,R,peg_model,get_dist_f,is_inside_f)


r   = theta(1:3);
%R   = rpy2r(theta(4),theta(5),theta(6));

X_w = (R * peg_model' + repmat(r',1,size(peg_model,1)))';

I2  = is_inside_f(X_w);
I3  = find(I2 == 1);

if ~isempty(I3)
   % dists = sqrt(sum((X_w(I3,:) - X_target(I3,:)).^2,2));
    y     = sum(get_dist_f(X_w(I3,:))); 
else
   y = 0; 
end


end



