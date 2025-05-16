function [q_1] = inv_q(q)   
    conj_q = conj_quat(q);
    q_1 = conj_q/(norm(q)^2);
end

