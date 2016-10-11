function cube = create_cube(dim,origin)
%CREATE_CUBE

%p = [x y z];

origin = origin(:)';

lx = dim(1);
ly = dim(2);
lz = dim(3);


% Compute Corners (8 corners)

cube.origin = origin;

cube.corners = zeros(8,3);

cube.corners([1 2 3 4],1) = lx/2;
cube.corners([5 6 7 8],1) = -lx/2; 

cube.corners([1 2 5 6],2) = ly/2;
cube.corners([3 4 7 8],2) = -ly/2;

cube.corners([1 3 5 7],3) = lz/2;
cube.corners([2 4 6 8],3) = -lz/2;

cube.corners = cube.corners + repmat(origin,8,1);


% Compute Edges (12 edges)

cube.edges = zeros(12,6);


cube.edges(1,:) = [cube.corners(1,:) cube.corners(2,:)];
cube.edges(2,:) = [cube.corners(2,:) cube.corners(4,:)];
cube.edges(3,:) = [cube.corners(4,:) cube.corners(3,:)];
cube.edges(4,:) = [cube.corners(3,:) cube.corners(1,:)];

cube.edges(5,:) = [cube.corners(1+4,:) cube.corners(2+4,:)];
cube.edges(6,:) = [cube.corners(2+4,:) cube.corners(4+4,:)];
cube.edges(7,:) = [cube.corners(4+4,:) cube.corners(3+4,:)];
cube.edges(8,:) = [cube.corners(3+4,:) cube.corners(1+4,:)];

cube.edges(9,:)  = [cube.corners(1,:) cube.corners(1+4,:)];
cube.edges(10,:) = [cube.corners(2,:) cube.corners(2+4,:)];
cube.edges(11,:) = [cube.corners(3,:) cube.corners(3+4,:)];
cube.edges(12,:) = [cube.corners(4,:) cube.corners(4+4,:)];

% Compute surfaces (6 surfaces)

cube.surface = zeros(5,3,6);

cube.surface(1:4,:,1) = cube.corners(1:4,:);
cube.surface(1:4,:,2) = cube.corners(5:8,:);
cube.surface(1:4,:,3) = [cube.corners([1,3],:);cube.corners([1+4,3+4],:)];
cube.surface(1:4,:,4) = [cube.corners([2,4],:);cube.corners([2+4,4+4],:)];
cube.surface(1:4,:,5) = [cube.corners([1,2],:);cube.corners([1+4,2+4],:)]; % ++ +-
cube.surface(1:4,:,6) = [cube.corners([3,4],:);cube.corners([3+4,4+4],:)]; % -+ --

% Compute surface normal
for i=1:6
   
    surf_center = mean(cube.surface(1:4,:,i));
    n      = surf_center - origin;
    n      = n./norm(n);
    
    I    = find(abs(n) ~= 1);
    n(I) = 0;
    cube.surface(5,:,i) = n;    
end






end

