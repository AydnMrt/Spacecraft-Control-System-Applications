function [nu_rad, E_rad_out] = calc_true_anomaly(M_deg,ecc_deg)

M_deg = rem(M_deg + 360 , 360);
E_deg = M_deg;
tol   = 1e-8;

max_iter = 10;

size_in = size(M_deg,2);

for i = 1 : size_in
    E_deg_loop = E_deg(i);
    M_deg_loop = M_deg(i);
    ecc_deg_loop = ecc_deg(i);
    for j = 1 : max_iter 
        new_E_deg = M_deg_loop + ecc_deg_loop.*sind(E_deg_loop);
        err = rem(new_E_deg - E_deg_loop, 360);
        E_deg_loop = new_E_deg;
        if abs(err) < tol
            break;
        end
    end

    E_deg(i) = rem(E_deg(i) + 360 , 360);

    ecc_rad(i) = deg2rad(ecc_deg(i));
    E_rad(i) = deg2rad(E_deg(i));
end

% True Anomaly Calculation
nu_rad = atan2(sqrt(1-ecc_rad^2).*sin(E_rad),cos(E_rad)-ecc_rad);
nu_rad = rem(nu_rad + 2*pi,2*pi);

E_rad_out = E_rad(i);

end

