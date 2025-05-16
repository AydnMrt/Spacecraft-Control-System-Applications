function [delta_t,t1,t2] = calc_duration_between_ta(orbit_st,ta_1,ta_2)
    
    grav_param_sun = 1.3271283864171489E+11; % [km^3/s^2]

    % The durations calculated for two true anomaly
    e = orbit_st.e_rad;
    E_orbit_1 = 2*atan(tan(ta_1/2)/sqrt((1+e)/(1-e)));
    M_1_rad_s = E_orbit_1 - e*sin(E_orbit_1);

    E_orbit_2 = 2*atan(tan(ta_2/2)/sqrt((1+e)/(1-e)));
    M_2_rad_s = E_orbit_2 - e*sin(E_orbit_2);

    % Calculation Period of Orbit
    a_km = orbit_st.a_km;

    T_ellips = 2*pi*(a_km^(3/2))/sqrt(grav_param_sun);

    n = 2*pi/T_ellips;

    % for t_0 = 0
    t1 = M_1_rad_s/n;
    t2 = M_2_rad_s/n;
    delta_t = t2 - t1;

end

