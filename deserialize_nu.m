function [z,psi,u] = deserialize_nu(nu,c)

global KC F D H C

z = zeros(D, 1);
psi = zeros(F, 1);
K = KC(c);
u = zeros(K, 1);

for i=1:D
    z(i)=nu(i);
end

for i=1:F
    psi(i)=nu(D+i);
end

u_start = 1;
d=1;
while d<c
    u_start = u_start + KC(d);
    d=d+1;
end

u_end = u_start + KC(c) - 1;

u = nu(D+F+u_start : D+F+u_end);
