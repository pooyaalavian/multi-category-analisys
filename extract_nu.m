function [Mu, Sigma] = extract_nu(data,h)



global KC F D ZZ
K1 = KC(1);
K2 = KC(2);

Mu = [ZZ(h),mean(data)]';

ignore_z = 1;


if ignore_z
    %   F  x F      f  x k1     f  x k2
    %   k1 x f      K1 x K1     k1 x k2
    %   k2 x f      k2 x k1     K2 x K2
    spsi = cov(data(:, 1:F));
    su1  = cov(data(:, F+1:F+K1));
    su2  = cov(data(:, F+K1+1:end));
    Sigma = [
        spsi,             zeros(F, K1),  zeros(F, K2);
        zeros(K1, F),              su1,  zeros(K1,K2);
        zeros(K2, F),    zeros(K2, K1),           su2;
    ];
    zr = zeros(1,size(Sigma,1));
    Sigma = [
        0,    zr;
        zr',  Sigma;
    ];

else
    %   D  x D      d  x f      d  x k1     d  x k2
    %   f  x d      F  x F      f  x k1     f  x k2
    %   k1 x d      k1 x f      K1 x K1     k1 x k2
    %   k2 x d      k2 x f      k2 x k1     K2 x K2
    spsi = cov(data(:, D+1:D+F));
    su1  = cov(data(:, D+F+1:D+F+K1));
    su2  = cov(data(:, D+F+K1+1:end));
    
    Sigma = [
        zeros(D, D),  zeros(D,F),    zeros(D, K1),  zeros(D, K2); 
        zeros(F, D),  spsi,          zeros(F, K1),  zeros(F, K2);
        zeros(K1,D),  zeros(K1, F),           su1,  zeros(K1,K2);
        zeros(K2,D),  zeros(K2, F),  zeros(K2,K1),           su2;
    ];
    
        
end

end

