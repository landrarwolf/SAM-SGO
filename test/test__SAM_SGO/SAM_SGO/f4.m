function [D] = f4(X)
%����ֵ������

global num
X = X';

D = pdist(X, 'cityblock');

D = 1./(squareform(D) + ones(num,num));


end

