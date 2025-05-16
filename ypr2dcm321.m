function [Q_Xx, R_1_psi, R_2_teta, R_3_fi] = ypr2dcm321(yaw,pitch,roll,str_unit)
    
    if str_unit == "degree"
        yaw   = deg2rad(yaw);
        pitch = deg2rad(pitch);
        roll = deg2rad(roll);
    end

    fi = yaw;
    teta = pitch;
    psi = roll;    

    R_3_fi = [ cos(fi), sin(fi), 0.0; 
              -sin(fi), cos(fi), 0.0;
                     0,       0, 1.0];

    R_2_teta = [cos(teta), 0.0, -sin(teta); 
                        0,   1,          0;
                sin(teta),   0,   cos(teta)];

    R_1_psi = [  1.0,       0.0,      0.0; 
                 0.0,  cos(psi), sin(psi);
                 0.0, -sin(psi), cos(psi)];


    Q_Xx = R_1_psi*R_2_teta*R_3_fi; % sol tarafa yazılır
end

