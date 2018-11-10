function [sp,sg, sl] = deserialize_theta_s(s_theta,c)
global KC F D FACTORS_BIN
K = KC(c);
fb = FACTORS_BIN{c};
nkf = sum(sum(fb));


%   KD x KD     kd x kf         kd x  k
%   kf x kd     KF x KF         kf x  k
%   k  x kd     k  x kf         K  x  K

sp = s_theta(         1: K*D,            1:K*D);
sg = s_theta(K*D+1     : K*D + nkf, K*D+1 : K*D + nkf);
sl = s_theta(K*D+nkf+1 : end,   K*D+nkf+1 : end);
