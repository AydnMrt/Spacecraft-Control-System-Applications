%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% EXAMPLES 7.2

clear all;
close all;
clc;

J2 = [6400  -76.4    -25.6;
     -76.4   4730      -40;
     -25.6    -40     8160 ];

q0 = (sqrt(2)/2)*[1 0 0 1]';

w0 = [0.01 0.01 0.01]';

hw0_B = [0 0 0]';

qc = [0 0 0 1]';

W4 = [1 -1 0  0; 
      1  1 1  1;
      0  0 1 -1];

W4 = (1/sqrt(2))*W4;

WN = [1 0 0 1/sqrt(3);
      0 1 0 1/sqrt(3);
      0 0 1 1/sqrt(3)];

W4_inv = pinv(W4);

WN_inv = pinv(WN);

inv_qc = inv_q(qc);

kp = 10;
kd = 150;
Cd = diag([kd kd kd]);

%% Analysis Time

sim("mdl_example_7_2.slx");

t_sim_s = out.t_simulink;
t_sim_min = t_sim_s/60;

%% Quaternion Analysis

quat_res = out.q;

figure
subplot(4,1,1);
plot(t_sim_min, quat_res(:,1), "-r","LineWidth", 1);
title("Quaternion Errors")
grid on;
ylim([-0.4 0.8]);
ylabel("\deltaq1");

subplot(4,1,2);
plot(t_sim_min, quat_res(:,2), "-b","LineWidth", 1);
grid on;
ylim([-0.04 0.02]);
ylabel("\deltaq2");

subplot(4,1,3);
plot(t_sim_min, quat_res(:,3), "-g","LineWidth", 1);
grid on;
ylim([-0.1 0.2]);
ylabel("\deltaq3");

subplot(4,1,4);
plot(t_sim_min, quat_res(:,4), "-k","LineWidth", 1);
grid on;
ylim([0.6 1.2]);
xlabel("Time (min)");
ylabel("\deltaq4");

%%

%% Reaction Wheels Momentum in the Body Frame

hw_B = out.hw_B;

figure
subplot(3,1,1);
plot(t_sim_min, hw_B(:,1), "-r","LineWidth", 1);
grid on;
ylim([0 240]);
ylabel("h_1 (Nms)");

subplot(3,1,2);
plot(t_sim_min, hw_B(:,2), "-b","LineWidth", 1);
grid on;
ylim([-120 40]);
ylabel("h_2 (Nms)");

subplot(3,1,3);
plot(t_sim_min, hw_B(:,3), "-g","LineWidth", 1);
grid on;
ylim([0 120]);
xlabel("Time (min)");
ylabel("h_3 (Nms)");

%% 

%% Reaction Wheels Momentum for Pyramid Configuration

hw_W_pramid = out.hw_W_pramid;

figure
plot(t_sim_min, hw_W_pramid(:,1), "-r","LineWidth", 1);
hold on;
plot(t_sim_min, hw_W_pramid(:,2), "--b","LineWidth", 1);
plot(t_sim_min, hw_W_pramid(:,3), "-.g","LineWidth", 1);
plot(t_sim_min, hw_W_pramid(:,4), ":k","LineWidth", 1);
grid on;
ylim([-200 150]);
xlabel("Time (min)");
ylabel("Wheel Momenta (Nms)");
title("Reaction Wheels Momentum for Pyramid Configuration");
legend(["1" "2" "3" "4"]);


%% 

%% Reaction Wheels Momentum for NASA Configuration

hw_W_NASA = out.hw_W_Nasa;

figure
plot(t_sim_min, hw_W_NASA(:,1), "-r","LineWidth", 1);
hold on;
plot(t_sim_min, hw_W_NASA(:,2), "--b","LineWidth", 1);
plot(t_sim_min, hw_W_NASA(:,3), "-.g","LineWidth", 1);
plot(t_sim_min, hw_W_NASA(:,4), ":k","LineWidth", 1);
grid on;
ylim([-150 200]);
xlabel("Time (min)");
ylabel("Wheel Momenta (Nms)");
title("Reaction Wheels Momentum for NASA Configuration");
legend(["1" "2" "3" "4"]);
