function [q_conj] = conj_quat(q)
    q_conj = [-q(1:3);q(4)];
end


