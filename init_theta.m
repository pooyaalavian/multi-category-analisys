function [theta, mu_theta, sigma_theta] = init_theta(c)

global C KC F D FACTORS_BIN
K = KC(c);
fb = FACTORS_BIN{c};
nkf = sum(sum(fb));

pi    = zeros(K,D);
mu_pi = zeros(K,D);
s_pi  = 10*eye(K*D);

gamma    = zeros(K,F);
mu_gamma = zeros(K,F);
s_gamma  = 10*eye(nkf);

lambda    = zeros(K,K);
mu_lambda = zeros(K,K);
s_lambda  = eye(K);

theta = serialize_theta(pi, gamma, lambda,c);
theta = theta + rand(size(theta));
mu_theta = serialize_theta(mu_pi, mu_gamma, mu_lambda,c);
sigma_theta = serialize_theta_s(s_pi, s_gamma, s_lambda,c);

end

