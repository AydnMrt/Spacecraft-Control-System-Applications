function qout = q_from_dcm(Q_Xx)
        
    qout = [0;0;0;1];

    Q11 = Q_Xx(1,1);
    Q22 = Q_Xx(2,2);
    Q33 = Q_Xx(3,3);

    q4 = 0.5*sqrt(1 + Q11 + Q22 + Q33);

    if q4 == 0.0
        fprintf("q4 can not be zero for this transformation.");
        return;
    end

    Q23 = Q_Xx(2,3);
    Q32 = Q_Xx(3,2);

    q1 = (Q23 - Q32)/(4*q4);

    Q31 = Q_Xx(3,1);
    Q13 = Q_Xx(1,3);

    q2 = (Q31 - Q13)/(4*q4);

    Q12 = Q_Xx(1,2);
    Q21 = Q_Xx(2,1);

    q3 = (Q12 - Q21)/(4*q4);

    qout = [q1;q2;q3;q4];
end


