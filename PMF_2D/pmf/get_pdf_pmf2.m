function [ XYW ] = get_pdf_pmf2( pmf )
%GET_PDF_PMF2 Takes the point mass filter structure and returnes the
% probability density function.
%
%   input ----------------------------------------------------------
%
%       o pmf: struct of the point mass filter
%
%      
%  output ---------------------------------------------------------- 
%
%      o XYZW: (N x 4) 
%
%           XYZW(:,1:3), cartesian position
%
%           XYZW(:,4), probability associated with the xyz 
%
%


index       = find(pmf.P >  0);
[X_I,Y_I]   = ind2sub(size(pmf.P),index);
XYW         = zeros(size(index,1),3);
XYW(:,1:2)  = indices2cartesian2D(X_I,Y_I,pmf.x_ref,pmf.m,pmf.n,pmf.delta);
XYW(:,3)    = pmf.P(index);

end

