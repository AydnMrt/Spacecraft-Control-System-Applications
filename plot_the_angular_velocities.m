function plot_the_angular_velocities(t_sim,w)

w1 = w(:,1);
w2 = w(:,2);
w3 = w(:,3);

figure
plot(t_sim,w1,"-r","LineWidth",1);
grid on;
xlabel("Time [hour]");
ylabel("\omega_1 [rad/s]");

figure
plot(t_sim,w2,"-b","LineWidth",1);
grid on;
xlabel("Time [hour]");
ylabel("\omega_2 [rad/s]");

figure
plot(t_sim,w3,"-k","LineWidth",1);
grid on;
xlabel("Time [hour]");
ylabel("\omega_3 [rad/s]");

end

