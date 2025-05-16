function B_ECI = calc_magVec_ECI_2(satPos_XYZ,datetime_t0,T_orbit,dt_sim)

    % Calculate the magnetic field vectors
    travel_date_0 = datetime_t0;
    travel_dates = travel_date_0 : dt_sim : travel_date_0 + seconds(T_orbit); 
    travel_date_vec = datevec(travel_dates);
    
    N_pos = size(satPos_XYZ,2);
    satPos_lla = zeros(N_pos,3);
    
    for i = 1 : N_pos
        satPos_lla(i,:) = eci2lla(satPos_XYZ(:,i)', travel_date_vec(i,:));
    end
    
    sat_lat_deg = satPos_lla(:,1);
    sat_lon_deg = satPos_lla(:,2);
    sat_alt_m   = satPos_lla(:,3);
   
    travel_year = decyear(travel_dates);
    
    % IGRF manyetik alanı (NED bileşenleri)
    [B_ned, ~, ~, ~, ~] = igrfmagm(sat_alt_m, sat_lat_deg, sat_lon_deg, travel_year',"11");
    
    wgs84 = wgs84Ellipsoid('meter');
    
    [B_ecef_X, B_ecef_Y, B_ecef_Z] = ned2ecef(B_ned(:,1), B_ned(:,2), B_ned(:,3), sat_lat_deg, sat_lon_deg, sat_alt_m, wgs84, "degrees");
    B_ecef = [B_ecef_X, B_ecef_Y, B_ecef_Z];
    
    % B_ECI = zeros(N_pos,3);
    % B_ecef = zeros(N_pos,3);
    for i = 1 : N_pos
        % R = ned2ecef_custom(sat_lat_deg(i),sat_lon_deg(i));
        % B_ecef(i,:) = (R*B_ned(i,:)')';
        B_ECI(i,:) = ecef2eci(travel_date_vec(i,:), B_ecef(i,:));
    end
end

