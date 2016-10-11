function  plot_line_segment( line_segments )
%PLOT_LINE_SEGMENT 
%
%   input ---------------------------------------------------
%
%       o line_segments (N x 6)
%


N = size(line_segments,1);

A = [];
B = [];

hold on;

for i=1:N
   
    A = line_segments(i,1:3);
    B = line_segments(i,4:6);
    
    L = [A;B];
    
     plot3(L(:,1),L(:,2),L(:,3),'-');
     plot3(A(1),A(2),A(3),'ok','MarkerFaceColor',[0 1 0]);
     plot3(B(1),B(2),B(3),'ok','MarkerFaceColor',[1 0 0]);
    
end

hold off;


end

