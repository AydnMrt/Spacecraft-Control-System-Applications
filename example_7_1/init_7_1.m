%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% EXAMPLES 7.1

clear all;
close all;
clc;

J1 = [10000    0     0;
          0 9000     0;
          0    0 12000 ];

q0 = [0.6853 0.6953 0.1531 0.1531]'; % initial quaternion vector
 
w0 = [deg2rad(0.5300) deg2rad(0.5300) deg2rad(0.05300)]'; % initial angular velocity

qc = [0 0 0 1]'; % desired quaternion vector

kp = 50;
kd = 500;
Cd = diag([kd kd kd]);

%% Run the simulink model

sim("mdl_7_1.slx");
t_sim_sec = out.t_simulink;

%% Quaternion Analysis

quat_res = out.q;

figure
subplot(4,1,1);
plot(t_sim_sec, quat_res(:,1), "-r","LineWidth", 1);
title("Quaternion Errors");
grid on;
ylim([-0.2 0.8]);
xlabel("Time (sec)");
ylabel("\deltaq1");

subplot(4,1,2);
plot(t_sim_sec, quat_res(:,2), "-b","LineWidth", 1);
grid on;
ylim([-0.2 0.8]);
xlabel("Time (sec)");
ylabel("\deltaq2");

subplot(4,1,3);
plot(t_sim_sec, quat_res(:,3), "-g","LineWidth", 1);
grid on;
ylim([-0.2 0.2]);
xlabel("Time (sec)");
ylabel("\deltaq3");

subplot(4,1,4);
plot(t_sim_sec, quat_res(:,4), "-k","LineWidth", 1);
grid on;
ylim([0 1.2]);
xlabel("Time (sec)");
ylabel("\deltaq4");

%% Control Torque Analysis

L_in = out.u_control;

figure
subplot(3,1,1);
plot(t_sim_sec, L_in(:,1), "-r","LineWidth", 1);
title("Control Torques");
grid on;
ylim([-40 20]);
ylabel("L_1 (Nm)");

subplot(3,1,2);
plot(t_sim_sec, L_in(:,2), "-b","LineWidth", 1);
grid on;
ylim([-40 20]);
ylabel("L_2 (Nm)");

subplot(3,1,3);
plot(t_sim_sec, L_in(:,3), "-g","LineWidth", 1);
grid on;
ylim([-10 5]);
xlabel("Time (sec)");
ylabel("L_3 (Nm)");






