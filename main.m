clear all
global C KC JC H F D FACTORS_BIN ITEMS DATA ZZ
C = 2;      % N CATS
KC = [2,2]; % N ATTS in each CAT
JC = [2,2]; % N SKUS in each CAT
H = 10;     % N CUSTOMERS
F = 2;      % N FACTORS
D = 1;      % N DEMO variables
FACTORS_BIN =cell(C,1); % binary variable determining which elements are non-zero
FACTORS_BIN{1} = [ 1,1; 1,0;];
FACTORS_BIN{2} = [ 1,1; 0,1;];

ITEMS = cell(C,1);
ITEMS{1} = [1,0; 0,1;];
ITEMS{2} = [1,1; 0,1;];


%READ FROM FILE 
[DATA,ZZ] = load_data();


[t1,mu_t1,s_t1]=init_theta(1);
[t2,mu_t2,s_t2]=init_theta(2);

nu = cell(H,1);
m_nu = cell(H,1);
s_nu = cell(H,1);
for h=1:H
    [nu{h},m_nu{h},s_nu{h}] = init_nu(h,ZZ);
end


%%
tic;
for rep = 1:100
    % THETA 1
    toc;
    disp(['REP ',num2str(rep),':']);
    disp('===> Starting THETA 1...');
    logpdf_theta1 = @(theta)posterior_theta(theta,mu_t1,s_t1,1,nu);
    smp = hmcSampler(logpdf_theta1, t1);
    samples = drawSamples(smp,'NumSamples',200);
    [mu_t1, s_t1] = extract_theta(samples,1);
    %t1 = mu_t1;
    t1 = mvnrnd(mu_t1,s_t1)';
%     toc;
    % THETA 2
    disp('===> Starting THETA 2...');
    logpdf_theta2 = @(theta)posterior_theta(theta,mu_t2,s_t2,2,nu);
    smp = hmcSampler(logpdf_theta2, t2);
    samples = drawSamples(smp,'NumSamples',200);
    [mu_t2, s_t2] = extract_theta(samples,2);
    %t2=mu_t2;
    t2 = mvnrnd(mu_t2,s_t2)';
%     toc;
    % h = 1,...H
    for h=1:H
        disp(['===> Starting NU ',num2str(h),'...']);
        logpdf_nu = @(xxx)posterior_nu(xxx,m_nu{h},s_nu{h},h,t1,t2);
        smp = hmcSampler(logpdf_nu, nu{h}(2:end));
        samples = drawSamples(smp,'NumSamples',200);
        [m_nu{h}, s_nu{h}] = extract_nu(samples,h);
        %nu{h} = m_nu{h};
        nu{h} = mvnrnd(m_nu{h},s_nu{h})';
%         toc;
    end
    
end





%%

if 0
    means = [1;-3;1];
    standevs = [1;2;1];
    logpdf = @(theta)normalDistGrad(theta,means,standevs);
    startpoint = randn(3,1);
    smp = hmcSampler(logpdf,startpoint);
end
%function [lpdf,glpdf] = normalDistGrad(X,Mu,Sigma)
%Z = (X - Mu)./Sigma;
%lpdf = sum(-log(Sigma) - .5*log(2*pi) - .5*(Z.^2));
%glpdf = -Z./Sigma;
%end
