function [lpdf, grad] = posterior_nu(nu,mu_nu,sigma_nu,h,theta1,theta2)
global ZZ
nu = [ZZ(h);nu];
dimZ = 1;

[logl,glogl] = logl_nu(nu, mu_nu, sigma_nu, h, theta1, theta2);
[lprior,gprior] = log_prior(nu, mu_nu, sigma_nu,dimZ);



lpdf = logl + lprior;
grad = glogl(dimZ+1:end) + gprior;


end


