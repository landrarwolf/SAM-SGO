function [S] = f3(X)
%�н����Һ���cosine function
global num
X = X';

D = pdist(X, 'cosine');%X��������֮����н�����
S = ones(num,num) - squareform(D);

end
