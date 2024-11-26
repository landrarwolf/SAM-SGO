%fea = rand(50,70);
%load('COIL20.mat')
function [output1,output2] = main_1LapScore(X,Y,c,~)
fea = X;
options = [];
options.Metric = 'Cosine';
options.NeighborMode = 'KNN';
options.k = 5;
options.WeightMode = 'Cosine';
W = constructW(fea,options);

LapScore = LaplacianScore(fea,W);
[~, index] = sort(-LapScore);

newfea = fea(:,index);
%the features in newfea will be sorted based on their importance.


FeaNumCandi = [10:10:110];% The number of featuers to be selected

FMeasure = ones(1,11);

for i = 1:length(FeaNumCandi)%第一组选10个，第二组选15个。。。共11组
  newfea_ = newfea(:,1:FeaNumCandi(i));
  [idx_LapScore] = kmeans(newfea_, c); 
  [FMeasure(i),Accuracy(i)]= Fmeasure(Y',idx_LapScore');
end

output1 = Accuracy;
output2 = FMeasure;
%plot(FMeasure);hold on;plot(Accuracy);
plot(Accuracy,'DisplayName','LapScore');hold on;
end


