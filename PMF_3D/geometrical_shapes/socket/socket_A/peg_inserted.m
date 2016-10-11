function Y = peg_inserted(middle_tip_position,line_segment)
%PEG_INSERTED Measurement function which returns the probability that 
%    the peg has been inserted into the socket.
%
%   input ------------------------------------------------------
%   
%       o middle_tip_position: (N x 3)
%
%       o line_segment: (1 x 6)
%
%            line_segment(1:3), start position
%            line_segment(4:6), end   position
%
%
%   output -----------------------------------------------------
%
%       o Y: (1 x 1) \in [0,..,1]
%
%

% Get position of peg tip for pet which is in the middle

N = size(middle_tip_position,1);


% (N x 3)
%peg_positions           = get_peg_tip_positions(r,q);
%tip_mid                 = peg_positions(:,4:6);
end_point               = line_segment(4:6);

%[dist_segment,proj]     = distance2lign(tip_mid,line_segment);

% in centimeters
Y          = sqrt(sum((repmat(end_point,N,1) - middle_tip_position).^2,2));
tmp        = Y .* 100;

Y(find(tmp >= 2)) = 0;
Y(find(tmp <= 2)) = 1;


%Y          = exp(-0.5 * Y);





end

