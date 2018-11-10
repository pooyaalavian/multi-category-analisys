function [theta] = serialize_theta(pi,gamma, lambda,c)
%SERIALIZE_THETA Summary of this function goes here
%   Detailed explanation goes here
global KC F D FACTORS_BIN
fb = FACTORS_BIN{c};
K = KC(c);
theta_pi = zeros(K*D,1);
theta_gamma = [];
theta_lambda = zeros(K,1);

for i=1:K
    for j=1:D
        theta_pi((i-1)*D+j) = pi(i,j);
    end
end

for i=1:K
    for j=1:F
        if fb(i,j)
            theta_gamma= [theta_gamma ; gamma(i,j)];
        end
    end
end

for i=1:K
    theta_lambda(i) = lambda(i,i);
end

theta = [theta_pi;theta_gamma; theta_lambda];
