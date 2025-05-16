%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Example 7.5 Initial Script

clear all;
close all;
clc;

J5 = [6400  -76.4    -25.6;
     -76.4   4730      -40;
     -25.6    -40     8160 ];

j_min = 4726.01952; % [kg-m^2]

r0 = [1029.7743 6699.3469 3.7896]'; % [km]

v0 = [-6.2119 0.9524 4.3946]'; % [km/s]

epoch_time = datetime(2011,5,10,4,56,36.9191);

q0 = (sqrt(2)/2)*[1 0 0 1]';

w0 = [0.01 0.01 0.01]'; % rad/s

global mu;
mu = 398600;

% Inclination Calculation
coe_sat = coe_from_sv(r0, v0, mu);
inc = coe_sat(4);
a_orbit = coe_sat(end);
T_orbit = 2*pi*(a_orbit^1.5)/sqrt(mu);
T_sim = 180*60;

% Time Settings
dt = 1; % second
datetime_dt = seconds(dt);

t_pos = 0 : dt : T_sim;

datetime_t_pos = seconds(t_pos);

datetime_sim = epoch_time + seconds(t_pos);

N = size(t_pos,2);
sat_pos = zeros(N,3);

% One Period Position Vectors
sat_pos(1,:) = r0';
for i = 2 : N
    [sat_pos(i,:), ~] = rv_from_r0v0(r0,v0, t_pos(i));
end

% Generate Magnetic Field Vectors
sat_pos = sat_pos*1e3;
B_eci = calc_magVec_ECI_2(sat_pos', epoch_time, T_sim, datetime_dt); % nano Tesla

B_eci_T = B_eci*1e-9; % Tesla

%% Analysis of Outputs

out = sim("mdl_example_7_5.slx");
t_sim_min = out.t_simulink/60;

%% Angular Velocities in the Body Frame

w_B_deg_s = rad2deg(out.w);

figure
subplot(3,1,1);
plot(t_sim_min, w_B_deg_s(:,1), "-r","LineWidth", 1);
title("Angular Velocities");
grid on;
ylim([-0.6 0.6]);
ylabel("w_1 (rad/s)");

subplot(3,1,2);
plot(t_sim_min, w_B_deg_s(:,2), "-b","LineWidth", 1);
grid on;
ylim([-0.3 0.9]);
ylabel("w_2 (rad/s)");

subplot(3,1,3);
plot(t_sim_min, w_B_deg_s(:,3), "-g","LineWidth", 1);
grid on;
ylim([-0.3 0.6]);
xlabel("Time (min)");
ylabel("w_3 (rad/s)");

%% 

%% Applied Torque

L_magneTorque = out.L_magneTorque;

figure
subplot(3,1,1);
plot(t_sim_min, L_magneTorque(:,1), "-r","LineWidth", 1);
title("Control Torques");
grid on;
ylabel("L_1 (Nm)");

subplot(3,1,2);
plot(t_sim_min, L_magneTorque(:,2), "-b","LineWidth", 1);
grid on;
ylabel("L_2 (Nm)");

subplot(3,1,3);
plot(t_sim_min, L_magneTorque(:,3), "-g","LineWidth", 1);
grid on;
xlabel("Time (min)");
ylabel("L_3 (Nm)");





