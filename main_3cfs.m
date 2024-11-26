%X = rand(50,70);
%load('COIL20.mat');
function [output1,output2] = main_3cfs(X,Y,c,~)
ranking = cfs(X);

newfea = X(:,ranking);

FeaNumCandi = (10:10:110);% The number of featuers to be selected


Accuracy = ones(1,length(FeaNumCandi));
FMeasure = Accuracy;

for i = 1:length(FeaNumCandi)%��һ��ѡ10�����ڶ���ѡ15����������11��
  newfea_ = newfea(:,1:FeaNumCandi(i));
  [idx_cfs] = kmeans(newfea_, c); 
  [FMeasure(i),Accuracy(i)]= Fmeasure(Y',idx_cfs');
end

output1 = Accuracy;
output2 = FMeasure;
%plot(FMeasure);hold on;plot(Accuracy);
plot(Accuracy,'DisplayName','cfs');hold on
end