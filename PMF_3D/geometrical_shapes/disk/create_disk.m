function [ disk ] = create_disk(C,R,r)
%CREATE_DISK 
%
%   input ------------------------------------------------------
%
%       o C: (1 x 3), center of disk
%
%       o R: (3 x 3), orientation of disk
%
%       o r: (1 x 1), radius
%
%   output ----------------------------------------------------
%
%       o disk: dist structure
%

disk.C = C;
disk.R = R;
disk.r = r;



end

