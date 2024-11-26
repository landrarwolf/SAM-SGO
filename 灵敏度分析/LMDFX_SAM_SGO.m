% clear
% load('COIL20.mat')%1440����1024ά��
function [output] = LMDFX_SAM_SGO(X,Y,c,d,beta,gamma)
%beta = 0.6;                       %���򻯲�����
%gamma = 0.3;                   %���򻯲�����
%d = 200;%Ŀ��ά��d
k = 5;
%c = 20;

[ranking] = SAM_SGO(X,beta,gamma,d,k,c);

newfea = X(:,ranking);


FeaNumCandi = [10:10:110];% The number of featuers to be selected

for i = 1:length(FeaNumCandi)
  newfea_ = newfea(:,1:FeaNumCandi(i));
  for j = 1 : 10
    [idx] = kmeans(newfea_, c,'Replicates',5);
    [~,Accuracy_(j,i)]= Fmeasure(Y',idx');
  end
    Accuracy(i) = max(Accuracy_(:,i));
end

output = Accuracy;

end