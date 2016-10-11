function peg_positions = get_peg_tip_positions(r,R,index)
%GET_PEG_TIP_POSITIONS Given the trajectories position and orientation
% compute the end position of the the three tips of the peg model
%
%   input ---------------------------------------------------------------
%
%       o r: (N x 3), Cartesian position of the frame of reference of the
%                      peg.
%
%       o R: (3 x 3), Rotation matrix 
%
%       o index: (1 x 1), index of peg tip to compute position
%
%
%   output -------------------------------------------------------------
%
%       o peg_positions: (N x 9), Cartesian position of the three peg tips
%
%
%

model =      [0.015   0.01   -0.001;    % left      tip
              0.015   0.0     0.004;    % middle    tip
              0.015  -0.01   -0.001];   % right     tip


if exist('index','var')
    
    N             = size(r,1);  

    peg_positions = R * repmat(model(index,:),N,1)' + r';
    peg_positions = peg_positions';
   
    
else
    
    N = size(r,1);
    peg_positions = zeros(N,3*3);

    peg_positions(:,1:3) = (R * repmat(model(1,:),N,1)'  + r')';
    peg_positions(:,4:6) = (R * repmat(model(2,:),N,1)'  + r')';
    peg_positions(:,7:9) = (R * repmat(model(3,:),N,1)'  + r')';
    
    
end
          



end

