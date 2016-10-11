function d = distance2plan(X,cube )
%DISTANCE2PLAN 

    N = size(X,1);
    d = zeros(N,6);
    for i=5:6
       d(:,i) = distance2planSegment(X,cube.surf(1:4,:,i),cube.surf(5,:,i));
    end
    

end

