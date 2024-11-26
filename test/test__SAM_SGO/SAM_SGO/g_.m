function y = g_(sigma_,p)
    y = sum( (sign(sigma_ - p)+1)/2 )/size(p,2) -1;
end

%g_(3,[2,3,4,5,6])
% 1.5/5-1