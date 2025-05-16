function [mat] = crossMat(vec)
    a1 = vec(1);
    a2 = vec(2);
    a3 = vec(3);

    mat = [0 -a3 a2
           a3 0 -a1
          -a2 a1 0];
end

