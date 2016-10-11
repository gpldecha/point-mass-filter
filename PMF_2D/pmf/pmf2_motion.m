function [ pmf,bConvolve] = pmf2_motion(pmf,u,kernel,dist_travel,theta_dist_travel)
%PMF2_MOTION Summary of this function goes here
%   Detailed explanation goes here


pmf.x_ref = pmf.x_ref + u;
bConvolve = false;


%disp(['dist_travel: ' num2str(dist_travel)]);

if exist('dist_travel','var')
    
    if dist_travel >= theta_dist_travel
       
        disp('convolve');
        pmf.P     = convn(kernel,pmf.P,'same');
        bConvolve = true;
    end
    
else
        pmf.P     = convn(kernel,pmf.P,'same');
end

pmf.P = pmf.P ./ sum(pmf.P(:));

end

