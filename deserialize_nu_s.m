function [spsi, su1, su2] = deserialize_nu_s( s_nu)
global KC F D
K1 = KC(1);
K2 = KC(2);

% make sure it is the same as serializer
ignore_z = 1;


if ignore_z
    %   F  x F      f  x k1     f  x k2
    %   k1 x f      K1 x K1     k1 x k2
    %   k2 x f      k2 x k1     K2 x K2

    spsi = s_nu(1:F,             1:F);
    su1  = s_nu(F+1:F+K1,      F+1:F+K1);
    su2  = s_nu(F+K1+1:end, F+K1+1:end);

else
    %   D  x D      d  x f      d  x k1     d  x k2
    %   f  x d      F  x F      f  x k1     f  x k2
    %   k1 x d      k1 x f      K1 x K1     k1 x k2
    %   k2 x d      k2 x f      k2 x k1     K2 x K2

    spsi = s_nu(D+1:D+F,           D+1:D+F);
    su1  = s_nu(D+F+1:D+F+K1,    D+F+1:D+F+K1);
    su2  = s_nu(D+F+K1+1:end, D+F+K1+1:end);
    
    
    
end