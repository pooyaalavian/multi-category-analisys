function [logl, grad] = logl_nu(nu,mu_nu,sigma_nu,h,theta1, theta2)

global C KC D F H FACTORS_BIN DATA ITEMS

% K = KC(c);
% ITM = ITEMS{c};

[pi1,gm1,tau1] = deserialize_theta(theta1,1);
[pi2,gm2,tau2] = deserialize_theta(theta2,2);
la1 = exp(tau1);
la2 = exp(tau2);
[z,psi,u1]  = deserialize_nu(nu,1);
[~, ~ ,u2]  = deserialize_nu(nu,2);

ndata = numel(DATA,1);

logl = 0;g_z = zeros(D,1); g_psi = zeros(F,1); g_u1=zeros(KC(1),1); g_u2=zeros(KC(2),1);

for d=1:ndata
    % check if data belongs to this category
    if DATA(d,1) ~= h
        continue
    end
    % calculate log-likelihood
    c = DATA(d,2);
    j = DATA(d,3);
    X = ITEMS{c}(j,:)';
    if c==1
        logl = logl + (pi1*z + gm1*psi + la1*u1)' * X;
    else
        logl = logl + (pi2*z + gm2*psi + la2*u2)' * X;
    end

    % calculate grad_Z
    
    % CONSTANT, DERIVATIVE = 0
    
    %calcu0late grad_PSI
    if c==1
        g_psi = g_psi + gm1'*X;
    else
        g_psi = g_psi + gm2'*X;
    end

    
    %calculate grad_u1
    if c==1
        g_u1 = g_u1 + la1*X;
    else 
        g_u2 = g_u2 + la2*X;
    end
end


grad = serialize_nu(g_z,g_psi,g_u1,g_u2);


end

