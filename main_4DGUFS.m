%X = rand(50,70);
%load('COIL20.mat');
function [output1,output2] = main_4DGUFS(X,Y,nClass,nSel)
S = dist(X');
S = -S./max(max(S)); % -similarity matrix of data X
%nClass = 20;% -the number of clusters
alpha = 0.5;% -regularization parameter: beta*tr(S'*L)
beta = 0.9;% -regularization parameter: beta*tr(S'*L)
%nSel = 200;% The number of featuers to be selected目标维数（与最后选择特征不同）
[X_Y,L,V,Label] = DGUFS(X',nClass,S,alpha,beta,nSel);
[v,ranking]=sort(X_Y(:,1)+X_Y(:,2),'descend');

newfea = X(:,ranking);
    
FeaNumCandi = (10:10:110);

Accuracy = ones(1,length(FeaNumCandi));
FMeasure = Accuracy;
for i = 1:length(FeaNumCandi)%第一组选10个，第二组选20个。。。
    newfea_ = newfea(:,1:FeaNumCandi(i));
    [idx_MCFS] = kmeans(newfea_, nClass); 
    [FMeasure(i),Accuracy(i)]= Fmeasure(Y',idx_MCFS');
end

output1 = Accuracy;
output2 = FMeasure;
%plot(FMeasure);hold on;plot(Accuracy);
plot(Accuracy,'DisplayName','DGUFS');hold on;
end
