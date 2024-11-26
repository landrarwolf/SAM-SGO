%%
clear;
%function [id] = SOGFS(X,gamma,d,c,k)
% Input
load('COIL20.mat');% X: dim*num data matrix
gamma = 1000;% gamma: coefficient of L21
d = 500;% d: projection dim of W(dim*d)
c = 20;% c: number of clusters
k = 5;% k: nearest neighobrs

%Output
%id: sorted features by ||w_i||_2


%%
%use SOGFS 选择前两百个优特征 h = 200
[ranking] = SOGFS(X',gamma,d,c,k);   %特征的排序

newfea = X(:,ranking);

FeaNumCandi = [50:50:250];% The number of featuers to be selected


for i = 1:length(FeaNumCandi)%第一组选10个，第二组选15个。。。共11组
  newfea_ = newfea(:,1:FeaNumCandi(i));
  for j = 1 : 50
    [idx] = kmeans(newfea_, 20,'Replicates',5);
    [FMeasure(j,i),Accuracy(j,i)]= Fmeasure(Y',idx');
  end
    FMeasure_(i) = max(FMeasure(:,i));
    Accuracy_(i) = max(Accuracy(:,i));
end
%plot(FMeasure);hold on;
plot(Accuracy_);
