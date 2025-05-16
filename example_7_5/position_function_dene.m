%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Example 3.7

clear all;
close all;
clc;

r0 = [7000 -12124 0];
v0 = [2.6679 4.6210 0];

% r0 = [-6045 -3490 2500];   % km
% v0 = [-3.457 6.618 2.533]; % km/s

t = 3600;

global mu;
mu = 398600; 

coe = coe_from_sv(r0,v0,mu);


TA = coe(6);
a = coe(end);
e = coe(2);

E_orbit = 2*atan(tan(TA/2)/sqrt((1+e)/(1-e)));
M0_rad = E_orbit - e*sin(E_orbit);

T = 2*pi*a^(3/2)/sqrt(mu);

n = 2*pi/T;

M_deg = rad2deg(n*3600);

M_deg = M_deg + rad2deg(M0_rad);

[ta_sat_rad, E_rad] = calc_true_anomaly(M_deg, rad2deg(e));

coe(6) = ta_sat_rad;

[r,~] = sv_from_coe(coe,mu)

 





