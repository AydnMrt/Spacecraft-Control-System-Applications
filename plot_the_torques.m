function plot_the_torques(t_sim,T)

T1 = T(:,1);
T2 = T(:,2);
T3 = T(:,3);

figure
plot(t_sim,T1,"-r","LineWidth",1);
grid on;
xlabel("Time [hour]");
ylabel("T_1 [N.m]");

figure
plot(t_sim,T2,"-b","LineWidth",1);
grid on;
xlabel("Time [hour]");
ylabel("T_2 [N.m]");

figure
plot(t_sim, T3,"-k","LineWidth",1);
grid on;
xlabel("Time [hour]");
ylabel("T_3 [N.m]");

end

