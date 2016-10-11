%% plot Trajectory color coded according to measurement


trajectory                    = get_trajectory('Albert',1,'A');
r                             = trajectory(:,1:3);
q                             = trajectory(:,4:7);
T                             = size(r,1);
t                             = 800;
r                             = r - repmat(r(T,:) - [0.001 0 0],T,1);
u                             = r(2:end,:) - r(1:end-1,:);


%   Measurement functions
get_tip           = @(r)get_peg_tip_positions(r,q(t,:));
hY_inserted       = @(middle_tip_position)peg_inserted(middle_tip_position,wall_socket.socket_A.top_hole_lseg);
hY_contact        = @(middle_tip_position)sw_is_in_contact(middle_tip_position,wall_socket,0.02);
hY_isinside       = @(r)is_inside_sw(r,wall_socket);


edge_type         = 4;
d_edge_f          = @(tip_position)sw_min_dist_edge(tip_position,edges);
d_edge_f2         = @(tip_position)sw_dist_edge(tip_position,edges);

hY_edge           = @(tip_position)sw_edge(tip_position,q2r(q(t,:)),edge_type,d_edge_f,d_edge_f2);

hY_f              = @(tip_positions)measurement_function(tip_positions,hY_contact,hY_edge,hY_inserted);

%%

step       = 1;
t          = t_start;
Ys         = [];

while(t <= T)

    get_tip                 = @(r)get_peg_tip_positions(r,q(t,:));  
    tip_positions           = get_tip(r(t,:));
    
    hY_edge                 = @(tip_position)sw_edge(tip_position,q2r(q(t,:)),edge_type,d_edge_f,d_edge_f2);
    hY_f                    = @(tip_positions)measurement_function(tip_positions,hY_contact,hY_edge,hY_inserted);
    Y                       = hY_f(tip_positions);
    Ys                      = [Ys;Y];
    t = t + step;
end

%%
close all;
figure;hold on; grid on;
plot(Ys(:,3),'-');
plot(Ys(:,4),'-');
plot(Ys(:,5),'-');

%%
theta = zeros(size(Ys,1),3);

one_var = 1/(0.005*0.005);

for i = 1:3
    I = find(Ys(:,i+2) <= 0.005);
    if ~isempty(I)
        theta(I,i) = exp(-0.5 * one_var * (Ys(I,3) - 0.001).^2);
    end
end

%theta = theta ./ repmat((sum(theta,2) + realmin),1,3);

%%
close all;
figure;hold on; grid on;
plot(theta(:,1),'-r');
plot(theta(:,2),'-g');
plot(theta(:,3),'-b');


%%
plot(Ys(:,7),'-o');
legend('left','right','up','down');

color   = [1 0 0;
          0 1 0;
          0 0 1;
          1 0 1
            ];

colors = ones(T,3);      
      
I_left  = find(Ys(:,4) == 1);
I_right = find(Ys(:,5) == 1);
I_up    = find(Ys(:,6) == 1);
I_down  = find(Ys(:,7) == 1);

colors(I_left,:)    = repmat([1 0 0],size(I_left,1),1);
colors(I_right,:)   = repmat([0 1 0],size(I_right,1),1);
colors(I_up,:)      = repmat([0 0 1],size(I_up,1),1);
colors(I_down,:)    = repmat([1 0 1],size(I_down,1),1);


     
      

%%

swall_A = create_socket_wall_A();


close all;
if exist('hp','var')
    hf(1) = figure('Position',hp(1,:));
   campos(cam);
else
    hf(1) = figure;
end
grid on;
plot_socket_wall(swall_A);hold on;

scatter3(r(:,1),r(:,2),r(:,3),5,colors,'filled');

% plot3(X(:,1),X(:,2),X(:,3),'ob');
% 
% for i=1:size(tip_positions,1)
%     plot3(tip_positions(i,1),tip_positions(i,2),tip_positions(i,3),'ok');
%     plot3(tip_positions(i,4),tip_positions(i,5),tip_positions(i,6),'ok');
%     plot3(tip_positions(i,7),tip_positions(i,8),tip_positions(i,9),'ok');
% end
% 
% for i=1:size(edges,1)
%    L = [edges(i,1:3);edges(i,4:6)];
%    plot3(L(:,1),L(:,2),L(:,3),'-','LineWidth',2); 
% end
% 
% for i=1:size(direction,1)
%     L = [position(i,:);position(i,:) + direction(i,:)];
%     plot3(L(:,1),L(:,2),L(:,3),'-ob');
%end

axis equal;


%%
hp(1,:) = get(hf(1),'Position');
cam     = campos;


