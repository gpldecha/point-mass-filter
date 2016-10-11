%% Socket_B test

socket_B = create_socket_B();
surfaces = create_surface();

%% Plot Socket_B

figure; hold on; grid on; box on;
plot_socket_B(socket_B);
plot3(surfaces(:,1),surfaces(:,2),surfaces(:,3),'ok');
axis equal;