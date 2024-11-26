%clear
%
%input: data X, measure function fq , and parametersβ,γ
%load('COIL20.mat')%1440样本1024维度
function [ranking] = SAM_SGO(X,beta,gamma,d,k,c)
X = X';
global num
num = size(X,2);                %列为样本数 1440
dim = size(X,1);                %行为维数 1024


%%
%Initialization
Alpha = [1,1,1,1];   r = 4;      %4个方程

%beta = 0.6;                       %正则化参数β
%gamma = 0.3;                   %正则化参数γ

%dim original dimension 
% d  projection dimension
%d = 200;%目标维数d
%k = 5;
%c = 20;

p = ones(num,num);
%


%%
fX{1} = f1(X);              % Gaussian Function
[fX{2},lambda] = f2(k,X);   % 基于概率邻域(Nie, Wang, and Huang 2014)，自适应确定相似度矩阵S
fX{3} = f3(X);              % Cosine Function
fX{4} = f4(X);              % 绝对值倒数法

A = fX{3};
%%
%初始拉普拉斯矩阵
A0 = (A+A')/2;          %A就是相似矩阵S，A0是W
D0 = diag(sum(A0));
L0 = D0 - A0;           %L = D - W
%初始F
    %c = ?
	[F, ~, evs]=eig1(L0, c, 0);
%初始W
    %d = ?
    [W] = InterationW(L0,X,gamma/2/beta,dim,d);


%循环开始
NITER = 50;
for iter = 1:NITER
    %%
    %B : 固定W、F，得S和alpha(q)【ht】
    %得E_W和N_F
    E_W = L2_distance_1(W'*X,W'*X);%W1024*500;X1024*1440
    N_F = L2_distance_1(F',F');

    %得A_alpha
    A_alpha = alpha_f(Alpha,fX)/sum(Alpha)  -  (beta * E_W + lambda * N_F) / 2 / sum(Alpha);

    for i = 1 : num
        %update pi
        p(i,:) = A_alpha(i,:) + 1/num * ones(1,num) -ones(1,num) * A_alpha(i,:)' / num * ones(1,num) ;
        %update sigma_
        [sigma_] = newton(p(i,:));
        %update S use sigma_:
        A(i,:) = myplus(p(i,:),sigma_);
    end

    %update alpha(q)
    for q = 1 : r %r = 4
        Alpha(q) = 1 / sum(sum(2*(fX{q} - A).^2));
    end

    A = (A+A')/2;       %旧A就是相似矩阵S，新A是拉普拉斯中的W
    D = diag(sum(A));   %求对角阵D
    L = D-A;            %Ls = Ds - (s+sT)/2



    %A.2 : 固定S，得投影矩阵W
    %目标维 d = ?
    [W] = InterationW(L,X,gamma/2/beta,dim,d);
    F_old = F; 
   
    %A.1 : 固定S，得F（拉普拉斯矩阵L的前c个最小特征值对应的特征向量）
    %若要求c个连通分量（聚类数），则F∈样本行num*c c = 20
    [F, ~, ev]=eig1(L, c, 0);
    evs(:,iter+1) = ev;    
    
    
%检测是否能跳出迭代
    fn1 = sum(ev(1:c));
    fn2 = sum(ev(1:c+1));
    if fn1 > 0.000000001
        lambda = 2*lambda;
    elseif fn2 < 0.00000000001
        lambda = lambda/2;
        F = F_old;
    elseif iter>1
        break;
    end


end

%%
%排序
sqW = (W.^2);
sumW = sum(sqW,2);
[~,ranking] = sort(sumW,'descend');

end
%%
%test
% load('COIL20.mat')%1440样本1024维度
% 
% newfea = X(:,ranking);
% 
% FeaNumCandi = [50:50:250];% The number of featuers to be selected
% 
% 
% for i = 1:length(FeaNumCandi)%第一组选10个，第二组选15个。。。共11组
%   newfea_ = newfea(:,1:FeaNumCandi(i));
%   for j = 1 : 50
%     [idx] = kmeans(newfea_, 20,'Replicates',5);
%     [FMeasure(j,i),Accuracy(j,i)]= Fmeasure(Y',idx');
%   end
%     FMeasure_(i) = max(FMeasure(:,i));
%     Accuracy_(i) = max(Accuracy(:,i));
% end
% %plot(FMeasure);hold on;
% plot(Accuracy_);



