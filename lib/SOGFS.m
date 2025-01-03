function [id] = SOGFS(X,gamma,d,c,k)
% Input
% X: dim*num data matrix
% gamma: coefficient of L21
% d: projection dim of W(dim*d)
% c: number of clusters
% k: nearest neighobrs

%Output
%id: sorted features by ||w_i||_2

% Ref: Feiping Nie, Wei Zhu, and Xuelong Li. Unsupervised Feature Selection with Structured Graph Optimization. AAAI 2016.

num = size(X,2);%行为样本数
dim = size(X,1);%列为维数

X0 = X';
mX0 = mean(X0);
X1 = X0 - ones(num,1)*mX0;
scal = 1./sqrt(sum(X1.*X1)+eps);
scalMat = sparse(diag(scal));%变为稀疏矩阵
X = X1*scalMat;
X = X';

distX = L2_distance_1(X,X);
[distX1, idx] = sort(distX,2);
A = zeros(num);
rr = zeros(num,1);
for i = 1:num
    di = distX1(i,2:k+2);
    rr(i) = 0.5*(k*di(k+1)-sum(di(1:k)));
    id = idx(i,2:k+2);
    A(i,id) = (di(k+1)-di)/(k*di(k+1)-sum(di(1:k))+eps);
end
r = mean(rr);
lambda = r;

A0 = (A+A')/2;
D0 = diag(sum(A0));
L0 = D0 - A0;
[F, ~, evs]=eig1(L0, c, 0);

[W] = InterationW(L0,X,gamma,dim,d);
NITER = 10;
for iter = 1:NITER
    distf = L2_distance_1(F',F');
    distx = L2_distance_1(W'*X,W'*X);
    if iter>5
        [~, idx] = sort(distx,2);%???
    end
    A = zeros(num);
    for i=1:num
        idxa0 = idx(i,2:k+1);
        dfi = distf(i,idxa0);
        dxi = distx(i,idxa0);
        ad = -(dxi+lambda*dfi)/(2*r);
        A(i,idxa0) = EProjSimplex_new(ad);
    end
    
    A = (A+A')/2;
    D = diag(sum(A));
    L = D-A;
    
    [W] = InterationW(L,X,gamma,dim,d);
    F_old = F;
    [F, ~, ev]=eig1(L, c, 0);
    evs(:,iter+1) = ev;
    
    fn1 = sum(ev(1:c));
    fn2 = sum(ev(1:c+1));
    if fn1 > 0.000000001
        lambda = 2*lambda;
    elseif fn2 < 0.00000000001
        lambda = lambda/2;  F = F_old;
    elseif iter>1
        break;
    end
end

sqW = (W.^2);
sumW = sum(sqW,2);
[~,id] = sort(sumW,'descend');


