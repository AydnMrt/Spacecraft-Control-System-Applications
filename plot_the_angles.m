function plot_the_angles(t_sim,teta)

% Plot the angular positions
teta_x = teta(:,3);
teta_y = teta(:,2);
teta_z = teta(:,1);

figure
plot(t_sim,teta_x,"-r","LineWidth",1);
grid on;
xlabel("Time [hour]");
ylabel("\theta_1 [degree]");

figure
plot(t_sim,teta_y,"-b","LineWidth",1);
grid on;
xlabel("Time [hour]");
ylabel("\theta_2 [degree]");

figure
plot(t_sim,teta_z,"-k","LineWidth",1);
grid on;
xlabel("Time [hour]");
ylabel("\theta_3 [degree]");

end

