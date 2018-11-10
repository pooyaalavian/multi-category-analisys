function [nu] = serialize_nu(z,psi,u1, u2)

global KC F D H C

ignore_z = 0;

if ignore_z
    nu = [psi;u1;u2];
else
    nu = [z;psi;u1;u2];
end

