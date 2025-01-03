function [W] = InterationW(L,X,gamma,dim,m)
%L: laplacian matrix
%X: data matrix(dim*num)
%gamma: coefficient of L21
%dim: dimension of X
%m: projection dimension of W

INTER_W = 100;
Q = eye(dim);
xlx= X*L*X';
xlx = (xlx+xlx')/2;
p=1; % L_2p
for i = 1:INTER_W
    tempXLXQ = (xlx+gamma*Q);
    [vec,val] = eig(tempXLXQ); 	%求特征值组成对角阵val，特征向量列组成矩阵vec
    [~,di] = sort(diag(val));
    W = vec(:,di(1:m));			%对W重新排列，取前m项，组成投影矩阵
    tempQ = 0.5*p * (sqrt(sum(W.^2,2)+eps)).^(p-2);	%求Qii
    Q = diag(tempQ);								%组合成Q

    w1(i) = trace(W'*X*L*X'*W); % log Tr(WXLXW)
    w2(i) = gamma*sum(sqrt(sum(W.^2,2)));% gama*||W||_21
    WResult(i) = w1(i)+w2(i);			 % 目标函数值

    if i > 1 && abs(WResult(i-1)-WResult(i)) < 0.000001
        break;
    end
    
end
% WResult = WResult';
end