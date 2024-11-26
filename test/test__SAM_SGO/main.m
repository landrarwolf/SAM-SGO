clear
load('COIL20.mat')%1440样本1024维度
beta = 0.6;                       %正则化参数β
gamma = 0.3;                   %正则化参数γ
d = 500;%目标维数d
k = 5;
c = 20;

[ranking] = SAM_SGO(X,beta,gamma,d,k,c);

newfea = X(:,ranking);
FeaNumCandi = [50:100:550];% The number of featuers to be selected
for i = 1:length(FeaNumCandi)%第一组选10个，第二组选15个。。。共11组
  newfea_ = newfea(:,1:FeaNumCandi(i));
  for j = 1 : 50
    [idx] = kmeans(newfea_, 20,'Replicates',5);
    [FMeasure(j,i),Accuracy(j,i)]= Fmeasure(Y',idx');
  end
    FMeasure_(i) = max(FMeasure(:,i));
    Accuracy_(i) = max(Accuracy(:,i));
end

plot(Accuracy_)