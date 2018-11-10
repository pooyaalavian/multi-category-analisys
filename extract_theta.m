function [Mu, Sigma] = extract_theta(data,c)

Mu = mean(data)';

global KC D F
K = KC(c);

%   KD x KD     kd x kf         kd x  k
%   kf x kd     KF x KF         kf x  k
%   k  x kd     k  x kf         K  x  K

sp = cov(data(:, 1:K*D));
sg = cov(data(:, K*D+1: K*D+K*F));
sl = cov(data(:, K*D+K*F+1:end));


Sigma = [
    sp,             zeros(K*D, K*F),  zeros(K*D, K);
    zeros(K*F, K*D),             sg,  zeros(K*F, K);
    zeros(K, K*D),    zeros(K, K*F),             sl;
];

end

