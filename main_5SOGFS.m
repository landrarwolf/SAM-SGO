%%
%clear;
%function [id] = SOGFS(X,gamma,d,c,k)
% Input
%load('COIL20.mat');% X: dim*num data matrix

function [output1,output2] = main_5SOGFS(X,Y,c,d,gamma)

%gamma = 0.3;% gamma: coefficient of L21
%d = 200;% d: projection dim of W(dim*d)
%c = 20;% c: number of clusters
k = 5;% k: nearest neighobrs

%Output
%id: sorted features by ||w_i||_2


%%
%use SOGFS ѡ��ǰ���ٸ������� h = 200
[ranking] = SOGFS(X',gamma,d,c,k);   %����������

newfea = X(:,ranking);

FeaNumCandi = [10:10:110];% The number of featuers to be selected
%��ʼ��
Accuracy_ = ones(5,length(FeaNumCandi));
Accuracy = ones(1,length(FeaNumCandi));
FMeasure = Accuracy;
FMeasure_ = Accuracy_;
%
for i = 1:length(FeaNumCandi)%��һ��ѡ10�����ڶ���ѡ15����������11��
  newfea_ = newfea(:,1:FeaNumCandi(i));
  for j = 1 : 5
    [idx] = kmeans(newfea_, c);
    [FMeasure_(j,i),Accuracy_(j,i)]= Fmeasure(Y',idx');
  end
    FMeasure(i) = max(FMeasure_(:,i));
    Accuracy(i) = max(Accuracy_(:,i));
end


output1 = Accuracy;
output2 = FMeasure;
%plot(FMeasure);hold on;
plot(Accuracy,'DisplayName','SOGFS');hold on;

end
