function cylinder = create_cylinder(x_ref,Rot_ref,r,l)
% CREATE_CYLINDER Creates a cylinder structure which contains all of it's
% parameters.
%   
%   input ---------------------------------------------------
%
%       o x_ref (1 x 3), Cartesian frame of reference of the cylinder which we take
%                        to be the at the top of the cylinder.
%
%       o Rot_ref (3 x 3), Orientation of the cylinder
%
%       o r: radius of the cylinder
%
%       o l: length of the cylinder 
%
%   output ---------------------------------------------------
%
%       o cylinder: structure
%

cylinder.x_ref   = x_ref;
cylinder.Rot_ref = Rot_ref;
cylinder.r       = r;
cylinder.l       = l;


end

