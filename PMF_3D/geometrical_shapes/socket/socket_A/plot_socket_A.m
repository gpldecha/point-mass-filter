function plot_socket_A(socket_A)

plot_cube_wire_frame(socket_A.cube);
plot_circle_geo(socket_A.ring.center,socket_A.ring.R(:,3)',socket_A.ring.r);
plot_circle_geo(socket_A.left_hole.center,socket_A.left_hole.R(:,3)',socket_A.left_hole.r);
plot_circle_geo(socket_A.right_hole.center,socket_A.right_hole.R(:,3)',socket_A.right_hole.r);
plot_circle_geo(socket_A.top_hole.center,socket_A.top_hole.R(:,3)',socket_A.top_hole.r);

plot_cylinder(socket_A.holes_cylinder{1});
plot_cylinder(socket_A.holes_cylinder{2});
plot_cylinder(socket_A.holes_cylinder{3});



end