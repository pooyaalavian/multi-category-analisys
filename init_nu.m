function [nu, mu_nu, sigma_nu] = init_nu(h,zs)

global C KC F D H
K1 = KC(1);
K2 = KC(2);

z    = zs(h);
mu_z = zs(h);
s_z  = zeros(D,D);

psi    = zeros(F,1);
mu_psi = zeros(F,1);
s_psi  = eye(F);

u1    = zeros(K1,1);
mu_u1 = zeros(K1,1);
s_u1  = eye(K1);

u2    = zeros(K2,1);
mu_u2 = zeros(K2,1);
s_u2  = eye(K2);



nu       = serialize_nu(z, psi, u1, u2);
%randomize nu's
nn = numel(nu)-1;
nu = [nu(1) ; nu(2:end)+rand(nn,1)];

mu_nu    = serialize_nu(mu_z, mu_psi, mu_u1,mu_u2);
sigma_nu = serialize_nu_s(s_psi, s_u1, s_u2);

end
