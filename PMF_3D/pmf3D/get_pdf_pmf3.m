function [ XYZW ] = get_pdf_pmf3( pmf )
%GET_PDF_PMF3 Takes the point mass filter structure and returnes the
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


index           = find(pmf.P >  0);
[Y_I,Z_I,X_I]   = ind2sub(size(pmf.P),index);
XYZW            = zeros(size(index,1),4);
XYZW(:,1:3)     = indices2cartesian(X_I,Y_I,Z_I,pmf.x_ref,[pmf.m,pmf.n,pmf.k],pmf.delta);
XYZW(:,4)       = pmf.P(index);




end

