function [Mu, Sigma] = extract_theta(data,c)

Mu = mean(data)';

global KC D F FACTORS_BIN
fb = FACTORS_BIN{c};
K = KC(c);
nkf = sum(sum(fb));

%   KD x KD     kd x kf         kd x  k
%   kf x kd     KF x KF         kf x  k
%   k  x kd     k  x kf         K  x  K

sp = cov(data(:, 1:K*D));
sg = cov(data(:, K*D+1: K*D+nkf));
sl = cov(data(:, K*D+nkf+1:end));


Sigma = [
    sp,             zeros(K*D, nkf),  zeros(K*D, K);
    zeros(nkf, K*D),             sg,  zeros(nkf, K);
    zeros(K, K*D),    zeros(K, nkf),             sl;
];

end

