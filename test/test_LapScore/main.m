%fea = rand(50,70);
load('COIL20.mat')
fea = X;
options = [];
options.Metric = 'Cosine';
options.NeighborMode = 'KNN';
options.k = 5;
options.WeightMode = 'Cosine';
W = constructW(fea,options);

LaplacianScore = LaplacianScore(fea,W);
[junk, index] = sort(-LaplacianScore);

newfea = fea(:,index);
%the features in newfea will be sorted based on their importance.


FeaNumCandi = [10:10:100];% The number of featuers to be selected

for i = 1:length(FeaNumCandi)%��һ��ѡ10�����ڶ���ѡ15����������11��
  newfea_ = newfea(:,1:FeaNumCandi(i));
  [idx_LapScore] = kmeans(newfea_, 20); 
  [FMeasure(i),Accuracy(i)]= Fmeasure(Y',idx_LapScore')
end
plot(FMeasure);hold on;plot(Accuracy);

