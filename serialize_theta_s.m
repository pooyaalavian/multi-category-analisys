function [s_theta] = serialize_theta_s(sp,sg, sl,c)
global KC F D
K = KC(c);


%   KD x KD     kd x kf         kd x  k
%   kf x kd     KF x KF         kf x  k
%   k  x kd     k  x kf         K  x  K



s_theta = [
    sp,             zeros(K*D, K*F),  zeros(K*D, K);
    zeros(K*F, K*D),             sg,  zeros(K*F, K);
    zeros(K, K*D),    zeros(K, K*F),             sl;
];

