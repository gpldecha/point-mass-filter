function L = likelihood_contact(Y,hY,Sigma,bIn)
%LIKELIHOOD_CONTACT Summary of this function goes here
%   Detailed explanation goes here
%
%   Comment --------------------------------------
%       

N     = size(hY,1);
D     = size(hY,2);

Data  = repmat(Y,N,1) - hY;
Mu    = zeros(D,1);

[nbData,nbVar] = size(Data);

Data = Data - repmat(Mu',nbData,1);
prob = sum((Data*inv(Sigma)).*Data, 2);
L = exp(-0.5*prob) / sqrt((2*pi)^nbVar * (abs(det(Sigma))+realmin));

%L = ones(N,1);

if ~isempty(bIn)
    L(bIn) = 0; 
end

% I = find(Y(:,3) == 1);
% if ~isempty(I)
%    L(I) = 0; 
% end

%L     = L./sum(L(:));



end

function prob = rbf(Data,Mu,Sigma)

[nbVar,nbData] = size(Data);

Data = Data' - repmat(Mu,nbData,1);
prob = sum((Data*inv(Sigma)).*Data, 2);
prob = exp(-0.5*prob);

end