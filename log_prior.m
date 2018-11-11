function [lpdf,grad] = log_prior(x, mu_x, sigma_x,remove_from_top)
if nargin < 4
  remove_from_top = 0;
end

if remove_from_top > 0 
    x = x(remove_from_top+1:end,:);
    mu_x=mu_x(remove_from_top+1:end,:);
    sigma_x = sigma_x(remove_from_top+1:end,remove_from_top+1:end);
end


Z = (x - mu_x)' * ((sigma_x)\(x - mu_x));

lpdf = -0.5*log(det(sigma_x)) - 0.5*length(x)*log(2*3.1415) - 0.5 * Z;

%y = mvnpdf(x,mu_x,sigma_x);

%lpdf = log(y);



%grad = (mu_x - x)' / (sigma_x);
%grad = grad';
%grad = -inv(sigma_x) * (x-mu_x);


grad = (mu_x - x)' / (sigma_x);

grad = grad';

x=56;