function [sp,sg, sl] = deserialize_theta_s(s_theta,c)
global KC F D
K = KC(c);


%   KD x KD     kd x kf         kd x  k
%   kf x kd     KF x KF         kf x  k
%   k  x kd     k  x kf         K  x  K

sp = s_theta(         1: K*D,            1:K*D);
sg = s_theta(K*D+1     : K*D + K*F, K*D+1 : K*D + K*F);
sl = s_theta(K*(D+F)+1 : end,   K*(D+F)+1 : end);
