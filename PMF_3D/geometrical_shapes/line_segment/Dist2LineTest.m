%% Dist 2 line test


line_seg = [-5,-5,5,5];
X    = [-3 2;
        -5 10;
        -7 -10;
        10  4];

[dist, proj] = dist2line2D(X,line_seg);



%% figure
close all;
figure; hold on;
plot([line_seg(1);line_seg(3)],[line_seg(2);line_seg(4)],'-ok','MarkerFaceColor',[0 0 0]);

for i=1:size(proj,1)
    
    L = [X(i,1),X(i,2);proj(i,1),proj(i,2)];
    plot(L(:,1),L(:,2),'-or','MarkerFaceColor',[1 0 0]);

end

axis equal;





