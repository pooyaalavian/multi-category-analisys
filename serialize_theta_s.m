function [s_theta] = serialize_theta_s(sp,sg, sl,c)
global KC F D FACTORS_BIN
K = KC(c);
fb = FACTORS_BIN{c};
nkf = sum(sum(fb));


%   KD x KD     kd x kf         kd x  k
%   kf x kd     KF x KF         kf x  k
%   k  x kd     k  x kf         K  x  K



s_theta = [
    sp,             zeros(K*D, nkf),  zeros(K*D, K);
    zeros(nkf, K*D),             sg,  zeros(nkf, K);
    zeros(K, K*D),    zeros(K, nkf),             sl;
];

