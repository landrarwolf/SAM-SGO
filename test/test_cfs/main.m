%X = rand(50,70);
load('COIL20.mat');

ranking = cfs(X);

newfea = X(:,ranking);

FeaNumCandi = [10:10:100];% The number of featuers to be selected


for i = 1:length(FeaNumCandi)%第一组选10个，第二组选15个。。。共11组
  newfea_ = newfea(:,1:FeaNumCandi(i));
  [idx_cfs] = kmeans(newfea_, 20); 

  [FMeasure(i),Accuracy(i)]= Fmeasure(Y',idx_cfs')
end
plot(FMeasure);hold on;plot(Accuracy);