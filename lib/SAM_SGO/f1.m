function [W] = f1(X)
global num
X = X';
%X=[2*randn(n,1) randn(n,1)];
X=X-repmat(mean(X), [num,1]);
x2=sum(X.^2,2);
W=exp(-(repmat(x2,1,num)+repmat(x2',num,1)-2*X*X'));
end
