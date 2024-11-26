%X = rand(50,70);
load('COIL20.mat');

S = dist(X');
S = -S./max(max(S)); % -similarity matrix of data X
nClass = 20;% -the number of clusters
alpha = 0.5;% -regularization parameter: beta*tr(S'*L)
beta = 0.9;% -regularization parameter: beta*tr(S'*L)
nSel = 900;% The number of featuers to be selected目标维数（与最后选择特征不同）
[X_Y,L,V,Label] = DGUFS(X',nClass,S,alpha,beta,nSel);
[v,ranking]=sort(X_Y(:,1)+X_Y(:,2),'descend');

newfea = X(:,ranking);
    
FeaNumCandi = [10:10:200];

for i = 1:length(FeaNumCandi)%第一组选50个，第二组选60个。。。
    newfea_ = newfea(:,1:FeaNumCandi(i));
    [idx_MCFS] = kmeans(newfea_, 20); 
     [FMeasure(i),Accuracy(i)]= Fmeasure(Y',idx_MCFS')
end
plot(FMeasure);hold on;plot(Accuracy);
