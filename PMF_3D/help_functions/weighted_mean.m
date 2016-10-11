function Mu = weighted_mean(XYZW)
 Mu   = sum(XYZW(:,1:3) .* repmat(XYZW(:,4),1,3),1);
end