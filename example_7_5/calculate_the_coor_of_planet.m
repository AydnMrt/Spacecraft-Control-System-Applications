function r_planet = calculate_the_coor_of_planet(planet_st, true_anomaly_array_deg, a_km, E_rad, e_rad)

true_anomaly_rad = deg2rad(true_anomaly_array_deg);

omega_rad = deg2rad(planet_st.omega_deg);
w_rad     = deg2rad(planet_st.w_deg);
i_rad     = deg2rad(planet_st.i_deg);

R3_omega = [ cos(omega_rad), sin(omega_rad), 0.0;
            -sin(omega_rad), cos(omega_rad), 0.0;
                  0       ,       0        , 1.0];

R3_w     = [ cos(w_rad), sin(w_rad), 0.0;
            -sin(w_rad), cos(w_rad), 0.0;
                0.0    ,       0.0 , 1.0];

R1_i =  [      1.0     ,     0.0     ,      0.0 ;
               0.0     ,   cos(i_rad), sin(i_rad); 
               0.0     ,  -sin(i_rad), cos(i_rad)]; 

if nargin == 3
    ksi_km = a_km.*cos(true_anomaly_rad);
    ita_km = a_km.*sin(true_anomaly_rad);
else
    ksi_km = a_km.*(cos(E_rad)-e_rad);
    ita_km = (a_km*sqrt(1-e_rad^2)).*sin(E_rad);
end

r_planet_elliptic = [ksi_km(1,:); ita_km(1,:); zeros(1,size(ksi_km,2))];

r_planet = R3_omega*R1_i*R3_w*r_planet_elliptic;

end

