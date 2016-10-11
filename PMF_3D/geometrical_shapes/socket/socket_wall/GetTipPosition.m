%% Get tip position

trajectory    = get_trajectory('Albert',1,'A');
r             = trajectory(:,1:3);
q             = trajectory(:,4:7);


X = [0.3, -0.2, 0.1;
    0.3, -0.1, 0.1;
    0.3,  0.0, 0.1;
    0.3,  0.1, 0.1;
    0.3,  0.2, 0.1
];

% X = [0.3,  0.0, 0.1];


tip_positions = get_peg_tip_positions(X,q(1,:));


%%

close all;
figure; grid on;
plot_socket_wall(create_socket_wall_A);hold on;

plot3(tip_positions(:,1),tip_positions(:,2),tip_positions(:,3),'or');
plot3(tip_positions(:,4),tip_positions(:,5),tip_positions(:,6),'og');
plot3(tip_positions(:,7),tip_positions(:,8),tip_positions(:,9),'ob');
plot3(X(:,1),X(:,2),X(:,3),'ok');


