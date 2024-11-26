% clear
% load('COIL20.mat')%1440����1024ά��
function [output1,output2] = main_6SAM_SGO(X,Y,c,d,beta,gamma)
%beta = 0.6;                       %���򻯲�����
%gamma = 0.3;                   %���򻯲�����
%d = 200;%Ŀ��ά��d
k = 5;
%c = 20;

[ranking] = SAM_SGO(X,beta,gamma,d,k,c);

newfea = X(:,ranking);


FeaNumCandi = [10:10:110];% The number of featuers to be selected
%��ʼ��
Accuracy_ = ones(50,length(FeaNumCandi));
Accuracy = ones(1,length(FeaNumCandi));
FMeasure = Accuracy;
FMeasure_ = Accuracy_;
%
for i = 1:length(FeaNumCandi)%��һ��ѡ10�����ڶ���ѡ15����������11��
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