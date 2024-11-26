% clear
% load('COIL20.mat')%1440样本1024维度
function [output1,output2] = main_6SAM_SGO(X,Y,c,d,beta,gamma)
%beta = 0.6;                       %正则化参数β
%gamma = 0.3;                   %正则化参数γ
%d = 200;%目标维数d
k = 5;
%c = 20;

[ranking] = SAM_SGO(X,beta,gamma,d,k,c);

newfea = X(:,ranking);


FeaNumCandi = [10:10:110];% The number of featuers to be selected
%初始化
Accuracy_ = ones(50,length(FeaNumCandi));
Accuracy = ones(1,length(FeaNumCandi));
FMeasure = Accuracy;
FMeasure_ = Accuracy_;
%
for i = 1:length(FeaNumCandi)%第一组选10个，第二组选15个。。。共11组
  newfea_ = newfea(:,1:FeaNumCandi(i));
  for j = 1 : 50
    [idx] = kmeans(newfea_, c,'Replicates',5);
    [FMeasure_(j,i),Accuracy_(j,i)]= Fmeasure(Y',idx');
  end
    FMeasure(i) = max(FMeasure_(:,i));
    Accuracy(i) = max(Accuracy_(:,i));
end

output1 = Accuracy;
output2 = FMeasure;

plot(Accuracy,'DisplayName','SAM-SGO');hold on;

end