function [eigvec, eigval, eigval_full] = eig1(A, c, isMax, isSym)
%A:laplacian matrix;c:cluster number;isMax:0
%求特征值&特征向量，并排序
%isMax = 1：从大到小排
%isSym = 1:
if nargin < 2
    c = size(A,1);
    isMax = 1;
    isSym = 1;
elseif c > size(A,1)
    c = size(A,1);
end

if nargin < 3
    isMax = 1;
    isSym = 1;
end

if nargin < 4
    isSym = 1;
end

if isSym == 1
    A = max(A,A');%变成对角阵？
end
[v, d] = eig(A);%v:eigen vector(column);d=eigen value(diagonal matrix)
d = diag(d);
%d = real(d);
if isMax == 0
    [d1, idx] = sort(d);
else
    [d1, idx] = sort(d,'descend');
end

idx1 = idx(1:c);
eigval = d(idx1);
eigvec = v(:,idx1);

eigval_full = d(idx);