function q_res = quat_multip(p,q)

    p4 = p(4);
    q4 = q(4);

    p_vec = p(1:3);
    q_vec = q(1:3);

    q_res_vec = p4*q_vec + q4*p_vec + cross(p_vec,q_vec);
    q_res_scaler = p4*q4 - dot(q_vec,p_vec);

    q_res = [q_res_vec; q_res_scaler];
end

