function [sigma_] = erfen(p)
a = -100000;
b = 100000;
c=0;
while abs(b-a)>1e-10
    if g(c,p)*g(b,p)<0
        a=c;
    else
        b=c; 
    end

c = (a+b)./2;

end
[sigma_] = c;

end

%erfen(p(1,:)) = 16521