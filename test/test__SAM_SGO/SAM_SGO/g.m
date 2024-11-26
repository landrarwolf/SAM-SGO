function y = g(sigma_,p)
    n = size(p,2);
    for j = 1 : n
        y(j) = (sigma_-p(j))*(sign(sigma_-p(j))+1) / 2;
    end
    y = sum(y) / n - sigma_;
end

%g(3,[2,3,4,5,6])
%p = p(1,:)
%sigma_ = 15925