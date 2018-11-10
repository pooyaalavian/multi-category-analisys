function [logl, grad] = logl_theta(theta, mu_theta, sigma_theta, c, nu)

global C KC JC D F H FACTORS_BIN DATA ITEMS

K = KC(c);
ITM = ITEMS{c};

[pi,gm,tau] = deserialize_theta(theta,c);
la = exp(tau);
%[z,psi,u]  = deserialize_nu(nu,c);

ndata = size(DATA,1);

logl = 0;g_pi = zeros(K,D); g_gm = zeros(K,F); g_la=zeros(K,K);

for d=1:ndata
    % check if data belongs to this category
    if DATA(d,2) ~= c
        continue
    end
    % calculate log-likelihood
    X = ITM(DATA(d,3),:)';
    h = DATA(d,1);
    [z,psi,u]  = deserialize_nu(nu{h},c);
    logl = logl + (pi*z + gm*psi + la*u)' * X;
    
    % calculate denominator
      den = 1;
     for j=1:JC(c)
         xx = ITM(j,:)';
         den = den + exp( (pi*z + gm*psi + la*u)' * xx );
     end
     logl = logl - log(den);
    
     
     % nd of calculate denominator

    % calculate grad_PI
    for i=1:K
        for j=1:D
            num=0;
            for jj=1:JC(c)
                 xx = ITM(jj,:)';
                 num = num + z(j)*xx(i)*exp( (pi*z + gm*psi + la*u)' * xx );
             end
            g_pi(i,j) = g_pi(i,j) + z(j)*X(i) - (num)/den;
            
        end
    end
    
    
    
    %calculate grad_GAMMA
    for i=1:K
        for j=1:F
            num=0;
            for jj=1:JC(c)
                 xx = ITM(jj,:)';
                 num = num + psi(j)*xx(i)*exp( (pi*z + gm*psi + la*u)' * xx );
             end
            g_gm(i,j) = g_gm(i,j) + psi(j)*X(i) - num/den;
        end
    end
    
    %calculate grad_LAMBDA
    for i=1:K
        num=0;
        for jj=1:JC(c)
             xx = ITM(jj,:)';
             num = num + u(i)*xx(i)*exp( (pi*z + gm*psi + la*u)' * xx );
         end
        g_la(i,i) = g_la(i,i) + u(i)*X(i) - num/den;
    end
    
end

% CLEAN UP GAMMA BASED ON FACTORS_BIN
% FB = FACTORS_BIN{c};
% for i=1:K
%     for j=1:F
%         g_gm(i,j) = FB(i,j)*g_gm(i,j);
%     end
% end

% revert lambda to tau space
% g_tau = log(g_la);
g_tau = g_la * la;

grad = serialize_theta(g_pi, g_gm, g_tau, c);


end

