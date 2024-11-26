function [D] = f4(X)
%绝对值倒数法

global num
X = X';

D = pdist(X, 'cityblock');

D = 1./(squareform(D) + ones(num,num));


end

