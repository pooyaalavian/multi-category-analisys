function [pi,gamma, lambda] = deserialize_theta(theta,c)

global KC F D
K = KC(c);
pi = zeros(K,D);
gamma = zeros(K,F);
lambda = zeros(K,K);

theta_pi = theta(1:K*D);
for i=1:K
    for j=1:D
        pi(i,j) = theta_pi((i-1)*D+j);
    end
end

theta_gamma = theta(K*D+1: K*D + K*F);
for i=1:K
    for j=1:F
        gamma(i,j) = theta_gamma((i-1)*F+j);
    end
end

theta_lambda = theta(K*D+K*F+1:end);
for i=1:K
    lambda(i,i)= theta_lambda(i);
end
