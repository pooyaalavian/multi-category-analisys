function [s_nu] = serialize_nu_s( spsi, su1, su2)
global KC F D
K1 = KC(1);
K2 = KC(2);


ignore_z = 0;


if ignore_z
    %   F  x F      f  x k1     f  x k2
    %   k1 x f      K1 x K1     k1 x k2
    %   k2 x f      k2 x k1     K2 x K2

    s_nu = [
        spsi,             zeros(F, K1),  zeros(F, K2);
        zeros(K1, F),              su1,  zeros(K1,K2);
        zeros(K2, F),    zeros(K2, K1),           su2;
    ];

else
    %   D  x D      d  x f      d  x k1     d  x k2
    %   f  x d      F  x F      f  x k1     f  x k2
    %   k1 x d      k1 x f      K1 x K1     k1 x k2
    %   k2 x d      k2 x f      k2 x k1     K2 x K2

    s_nu = [
        zeros(D, D),  zeros(D,F),    zeros(D, K1),  zeros(D, K2); 
        zeros(F, D),  spsi,          zeros(F, K1),  zeros(F, K2);
        zeros(K1,D),  zeros(K1, F),           su1,  zeros(K1,K2);
        zeros(K2,D),  zeros(K2, F),  zeros(K2,K1),           su2;
    ];
    
    
    
end