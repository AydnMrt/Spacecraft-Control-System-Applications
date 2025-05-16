%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Homework-2 Solution

clear all;
close all;
clc;

% Simulation Parameters
dt = 1e-1;         % 0.1 sec
tf_sim = 10*60*60; % Simulation Time (seconds)

% System Parameters

a = 40;             % sail side length [meter]
l = 2 ;             % gimballed rod length [meter]
b = 0.5;            % Gimball Mechanism Height [meter]
As = 1400;          % Sail Area [m^2]
sigma = 1.816;      % Thrust Coefficient
ms = 40;            % Sail Subsystem Mass [kg]
mp = 116;           % Payload Mass [kg]
mr = 4;             % Gimballed Rod Mass [kg]
mt = ms + mp + mr;  % total mass [kg]

% Astronomic Constants
c_light = 3*1e8;     % Light Velocity
sl = 3.84*1e26;      % solar luminosity (Işınım Gücü)[Watt]
r_s = 149597871*1e3; % 1 AU [meter]

W = sl/(4*pi*r_s^2);
P = W/c_light;

system_parameters = [a; l; b; As; sigma; ms; mp; mr; mt; P];

% Case-1 Parameters
w0_c1 = [0 5 5]'*1e-4;          % [rad/s]
teta0_c1 = deg2rad([0 10 10]'); % Euler Angles 3-2-1 [degree]

q0_c1 = angle2quat(teta0_c1(3),teta0_c1(2),teta0_c1(1),'ZYX');

tetad_c1 = [0 0 0]';           % Desired Euler Angles 3-2-1 [degree]
qd_c1 = angle2quat(tetad_c1(3),tetad_c1(2),tetad_c1(1),'ZYX');

% Case-2 Parameters
w0_c2 = [0 0 0]';               % [rad/s]

teta0_c2 = deg2rad([0 30 30]'); % Euler Angles 3-2-1 [degree]
q0_c2 = angle2quat(teta0_c2(3),teta0_c2(2),teta0_c2(1),'ZYX');

tetad_c2 = deg2rad([0 20 20]'); % Desired Euler Angles
qd_c2 = angle2quat(tetad_c2(3),tetad_c2(2),tetad_c2(1),'ZYX'); % [q4 q1 q2 q3] 

% Controller Coefficients
Kp = 9.9*1e-3;  % [Nm]
Kd = 2.2;       % [Nm/(rad.s)]    

controller_coeffs = [Kp;Kd];

% Calculation of Sun Vector in the Orbital Frame for Case - 1
sb0 = [cosd(45) 0 0]'; % Sun Vector in the Body Frame

eps = q0_c1(2:4)';
nu  = q0_c1(1);
I3x3 = eye(3);

eps_cross_mat = crossMat(eps);
Cbo = (1-2*(eps')*eps)*I3x3 + 2*eps*eps' - 2*nu*eps_cross_mat;

so_c1 = Cbo'*sb0; % sun vector in the orbit frame

% Calculation of Sun Vector in the Orbital Frame for Case - 2
eps = q0_c2(2:4)';
nu  = q0_c2(1);

eps_cross_mat = crossMat(eps);
Cbo = (1-2*(eps')*eps)*I3x3 + 2*eps*eps' - 2*nu*eps_cross_mat;

so_c2 = Cbo'*sb0; % sun vector in the orbit frame for case-2

%% Run Simulation

sim_outs = sim("sol_mdl.slx");

%% Transient Time Calculation

% Read the simulation outputs
teta_c1     = sim_outs.euler_angles_c1_deg;
teta_c2     = sim_outs.euler_angles_c2_deg;
w_c1        = sim_outs.ang_vel_c1_rads;
w_c2        = sim_outs.ang_vel_c2_rads;
T_c1        = sim_outs.actual_torque_c1;
T_c2        = sim_outs.actual_torque_c2;
t_sim_sec   = sim_outs.t_sim;
t_sim_hours = t_sim_sec/(60*60);

teta_err_c1 = tetad_c1' - fliplr(teta_c1(:,:));
teta_err_c2 = rad2deg(tetad_c2)' - fliplr(teta_c2(:,:));

%% Plotting
%% Plot for the Case - 1 

% Plot the Angles
plot_the_angles(t_sim_hours,teta_c1);

% Plot the angular velocities
plot_the_angular_velocities(t_sim_hours,w_c1);

% Plot the applied torques
plot_the_torques(t_sim_hours,T_c1);

%% Plot for the Case - 2

% Plot the Angles
plot_the_angles(t_sim_hours,teta_c2);

% Plot the angular velocities
plot_the_angular_velocities(t_sim_hours,w_c2);

% Plot the applied torques
plot_the_torques(t_sim_hours,T_c2);

%% Transient Time Calculation
%% Calculation for the Case - 1
error_ratio = 1/100;

format longG

% w2 rad/s Transient Time for the case - 1
w2_c1 = w_c2(:,2);
w2_max_c1 = max(abs(w2_c1));
w2_threshold_c1 = w2_max_c1*error_ratio;
t_transient_w2_c1_sec = find_transient_time(w2_threshold_c1,t_sim_sec,w2_c1)
t_transient_w2_c1_hour = t_transient_w2_c1_sec/(60*60)

% w3 rad/s Transient Time for the case - 1
w3_c1 = w_c2(:,3);
w3_max_c1 = max(abs(w3_c1));
w3_threshold_c1 = w3_max_c1*error_ratio;
t_transient_w3_c1_sec = find_transient_time(w3_threshold_c1,t_sim_sec,w3_c1)
t_transient_w3_c1_hour = t_transient_w3_c1_sec/(60*60)

% teta_2 degree Transient time for the case - 1
teta2_err_c1 = teta_err_c1(:,2);
teta2_err_c1_max = max(abs(teta2_err_c1));
teta2_err_c1_thr = teta2_err_c1_max*error_ratio;
t_transient_t2err_c1_sec = find_transient_time(teta2_err_c1_thr,t_sim_sec,teta2_err_c1)
t_transient_t2err_c1_hour = t_transient_t2err_c1_sec/(60*60)

% teta_3 degree Transient time for the case - 1
teta3_err_c1 = teta_err_c1(:,3);
teta3_err_c1_max = max(abs(teta3_err_c1));
teta3_err_c1_thr = teta3_err_c1_max*error_ratio;
t_transient_t3err_c1_sec = find_transient_time(teta3_err_c1_thr,t_sim_sec,teta3_err_c1)
t_transient_t3err_c1_hour = t_transient_t3err_c1_sec/(60*60)

%% Calculation for the Case - 2

% w2 rad/s Transient Time for the case - 2
w2_c2 = w_c2(:,2);
w2_max_c2 = max(abs(w2_c2));
w2_threshold_c2 = w2_max_c2*error_ratio;
t_transient_w2_c2_sec = find_transient_time(w2_threshold_c2, t_sim_sec, w2_c2)
t_transient_w2_c2_hour = t_transient_w2_c2_sec/(60*60)

% w3 rad/s Transient Time for the case - 2
w3_c2 = w_c2(:,3);
w3_max_c2 = max(abs(w3_c2));
w3_threshold_c2 = w3_max_c2*error_ratio;
t_transient_w3_c2_sec = find_transient_time(w3_threshold_c2,t_sim_sec,w3_c2)
t_transient_w3_c2_hour = t_transient_w3_c2_sec/(60*60)

% teta_2 degree Transient time for the case - 2
teta2_err_c2 = teta_err_c2(:,2);
teta2_err_c2_max = max(abs(teta2_err_c2));
teta2_err_c2_thr = teta2_err_c2_max*error_ratio;
t_transient_t2err_c2_sec = find_transient_time(teta2_err_c2_thr,t_sim_sec,teta2_err_c2)
t_transient_t2err_c2_hour = t_transient_t2err_c2_sec/(60*60)

% teta_3 degree Transient time for the case - 2
teta3_err_c2 = teta_err_c2(:,3);
teta3_err_c2_max = max(abs(teta3_err_c2));
teta3_err_c2_thr = teta3_err_c2_max*error_ratio;
t_transient_t3err_c2_sec = find_transient_time(teta3_err_c2_thr,t_sim_sec,teta3_err_c2)
t_transient_t3err_c2_hour = t_transient_t3err_c2_sec/(60*60)

