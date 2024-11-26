function [output] = myplus(pi,sigma_)

global num;
output = (pi-ones(1,num)*sigma_).*[(sign(pi-sigma_)+1) / 2];

end

