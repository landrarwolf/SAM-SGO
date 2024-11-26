function [S] = f3(X)
%夹角余弦函数cosine function
global num
X = X';

D = pdist(X, 'cosine');%X：行与行之间求夹角余弦
S = ones(num,num) - squareform(D);

end
