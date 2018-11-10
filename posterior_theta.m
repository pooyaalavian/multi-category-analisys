function [lpdf, grad] = posterior_theta(theta,mu_theta,sigma_theta,c,nu)

[logl,glogl] = logl_theta(theta,mu_theta,sigma_theta,c,nu);
[lprior,gprior] = log_prior(theta,mu_theta,sigma_theta);

lpdf = logl + lprior;
grad = glogl + gprior;


end


