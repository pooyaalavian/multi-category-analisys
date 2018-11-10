function [pi,gamma, lambda] = deserialize_theta(theta,c)

global KC F D FACTORS_BIN
K = KC(c);
fb = FACTORS_BIN{c};
nkf = sum(sum(fb));
pi = zeros(K,D);
gamma = zeros(K,F);
lambda = zeros(K,K);

theta_pi = theta(1:K*D);
for i=1:K
    for j=1:D
        pi(i,j) = theta_pi((i-1)*D+j);
    end
end

theta_gamma = theta(K*D+1: K*D + nkf);
iterator = 1;
for i=1:K
    for j=1:F
        if fb(i,j)
            gamma(i,j) = theta_gamma(iterator);
            iterator = iterator + 1;
        end
    end
end

theta_lambda = theta(K*D+nkf+1:end);
for i=1:K
    lambda(i,i)= theta_lambda(i);
end
