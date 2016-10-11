function q = rpy2q(rpy)
%R2Q Rotation matrix to Quaternion
%
%  input ---------------------------------------
%
%   o r: (3 x 3)
%
%   output -------------------------------------
%
%   o q: (1 x 4)
%
%   
% Inputs
% bank,pitch,azimuth = Euler angles (rad) in 1,2,and 3 axis
%
% Outputs
% q0,q1,q2,q3 = quaternions with q0 being the "scalar" value
% rx , ry & rz should be in radians
% rx, ry, rz are rotation around x,y & z axis
% order of rotations should be passed in 'order' parameter as string e.g. 'xyz' or
% 'xzy' etc.
% Quaterion is expressed as Q=[w x y z]
% w is scalar component of quaternion
% x,y,z are vector components of quaternion. For example q=w+xi+yj+zk



theta1 = rpy(3);
theta2 = rpy(2);
theta3 = rpy(1);

t1 = theta1/2;
t2 = theta2/2;
t3 = theta3/2;

q0 = cos(t1)*cos(t2)*cos(t3)+sin(t1)*sin(t2)*sin(t3);
q1 = cos(t1)*cos(t2)*sin(t3)-sin(t1)*sin(t2)*cos(t3);
q2 = cos(t1)*sin(t2)*cos(t3)+sin(t1)*cos(t2)*sin(t3);
q3 = sin(t1)*cos(t2)*cos(t3)-cos(t1)*sin(t2)*sin(t3);

q =  [q0,q1,q2,q3];

% rx = rpy(1);
% ry = rpy(2);
% rz = rpy(3);
% Qx=[cos(rx/2) sin(rx/2)  0          0];
% Qy=[cos(ry/2) 0          sin(ry/2)  0];
% Qz=[cos(rz/2) 0          0          sin(rz/2)];
% 
% if(strcmpi(order,'xyz')==1)  
% %    disp('order is x-->y-->z');
%     Q1=quaternionmul(Qy,Qz);  
%     Q2=quaternionmul(Qx,Q1);  
%     
% elseif(strcmpi(order,'xzy')==1)  
%  %   disp('order is x-->z-->y');
%     Q1=quaternionmul(Qz,Qy);  
%     Q2=quaternionmul(Qx,Q1);
%     
% elseif(strcmpi(order,'yxz')==1)
%   %  disp('order is y-->x-->z');
%     Q1=quaternionmul(Qx,Qz);  
%     Q2=quaternionmul(Qy,Q1);
%     
% elseif(strcmpi(order,'yzx')==1)
%    % disp('order is y-->z-->x');
%     Q1=quaternionmul(Qz,Qx);  
%     Q2=quaternionmul(Qy,Q1);
%     
% elseif(strcmpi(order,'zxy')==1)
%     %disp('order is z-->x-->y');
%     Q1=quaternionmul(Qx,Qy);  
%     Q2=quaternionmul(Qz,Q1);
%     
% elseif(strcmpi(order,'zyx')==1) % same as matlab quatdemo
%     %disp('order is z-->y-->x');
%     Q1=quaternionmul(Qy,Qx);  
%     Q2=quaternionmul(Qz,Q1); 
% else
%     %disp('could not recognized')    
% end
% 
%     w=Q2(1,1);
%     x=Q2(1,2);
%     y=Q2(1,3);
%     z=Q2(1,4);
%     
%     q = [w,x,y,z];

end

function QMR=quaternionmul(Q0,Q1)
% Q0 and Q1 shoud be in this order
% Q0=[w0 x0 y0 z0] % w0 is scalar part, x0,y0,z0 are vector part
% Q1=[w1 x1 y1 z1] % w1 is scalar part, x1,y1,z1 are vector part
% Multiplication is not commutative in that the products Q0Q1 and Q1Q0 are
% not necessarily equal.
w0=Q0(1); x0=Q0(2); y0=Q0(3); z0=Q0(4); 
w1=Q1(1); x1=Q1(2); y1=Q1(3); z1=Q1(4); 

wr=(w0.*w1 - x0.*x1 - y0.*y1 - z0.*z1);
xr=(w0.*x1 + x0.*w1 + y0.*z1 - z0.*y1);
yr=(w0.*y1 - x0.*z1 + y0.*w1 + z0.*x1);
zr=(w0.*z1 + x0.*y1 - y0.*x1 + z0.*w1);

QMR=[wr xr yr zr]; % wr is scalar part, xr, yr, zr are vector part

% % % --------------------------------
% % % Author: Dr. Murtaza Khan
% % % Email : drkhanmurtaza@gmail.com
% % % --------------------------------

% Technical Reference: Ken Shoemake, "Animating Rotations with Quaternion Curves"
end
