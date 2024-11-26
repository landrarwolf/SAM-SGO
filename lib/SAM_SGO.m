%clear
%
%input: data X, measure function fq , and parameters��,��
%load('COIL20.mat')%1440����1024ά��
function [ranking] = SAM_SGO(X,beta,gamma,d,k,c)
X = X';
global num
num = size(X,2);                %��Ϊ������ 1440
dim = size(X,1);                %��Ϊά�� 1024


%%
%Initialization
Alpha = [1,1,1,1];   r = 4;      %4������

%beta = 0.6;                       %���򻯲�����
%gamma = 0.3;                   %���򻯲�����

%dim original dimension 
% d  projection dimension
%d = 200;%Ŀ��ά��d
%k = 5;
%c = 20;

p = ones(num,num);
%


%%
fX{1} = f1(X);              % Gaussian Function
[fX{2},lambda] = f2(k,X);   % ���ڸ�������(Nie, Wang, and Huang 2014)������Ӧȷ�����ƶȾ���S
fX{3} = f3(X);              % Cosine Function
fX{4} = f4(X);              % ����ֵ������

A = fX{3};
%%
%��ʼ������˹����
A0 = (A+A')/2;          %A�������ƾ���S��A0��W
D0 = diag(sum(A0));
L0 = D0 - A0;           %L = D - W
%��ʼF
    %c = ?
	[F, ~, evs]=eig1(L0, c, 0);
%��ʼW
    %d = ?
    [W] = InterationW(L0,X,gamma/2/beta,dim,d);


%ѭ����ʼ
NITER = 50;
for iter = 1:NITER
    %%
    %B : �̶�W��F����S��alpha(q)��ht��
    %��E_W��N_F
    E_W = L2_distance_1(W'*X,W'*X);%W1024*500;X1024*1440
    N_F = L2_distance_1(F',F');

    %��A_alpha
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

    A = (A+A')/2;       %��A�������ƾ���S����A��������˹�е�W
    D = diag(sum(A));   %��Խ���D
    L = D-A;            %Ls = Ds - (s+sT)/2



    %A.2 : �̶�S����ͶӰ����W
    %Ŀ��ά d = ?
    [W] = InterationW(L,X,gamma/2/beta,dim,d);
    F_old = F; 
   
    %A.1 : �̶�S����F��������˹����L��ǰc����С����ֵ��Ӧ������������
    %��Ҫ��c����ͨ������������������F��������num*c c = 20
    [F, ~, ev]=eig1(L, c, 0);
    evs(:,iter+1) = ev;    
    
    
%����Ƿ�����������
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
%����
sqW = (W.^2);
sumW = sum(sqW,2);
[~,ranking] = sort(sumW,'descend');

end
%%
%test
% load('COIL20.mat')%1440����1024ά��
% 
% newfea = X(:,ranking);
% 
% FeaNumCandi = [50:50:250];% The number of featuers to be selected
% 
% 
% for i = 1:length(FeaNumCandi)%��һ��ѡ10�����ڶ���ѡ15����������11��
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



