%X = rand(50,70);
load('COIL20.mat');

ranking = cfs(X);

newfea = X(:,ranking);

FeaNumCandi = [10:10:100];% The number of featuers to be selected


for i = 1:length(FeaNumCandi)%��һ��ѡ10�����ڶ���ѡ15����������11��
  newfea_ = newfea(:,1:FeaNumCandi(i));
  [idx_cfs] = kmeans(newfea_, 20); 

  [FMeasure(i),Accuracy(i)]= Fmeasure(Y',idx_cfs')
end
plot(FMeasure);hold on;plot(Accuracy);