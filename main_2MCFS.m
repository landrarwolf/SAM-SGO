%fea = rand(50,70);%data matrix. Each row vector of data is a sample vector.                   
%load('COIL20.mat');

function [output1,output2] = main_2MCFS(X,Y,c,d)

fea = X;

options = [];
options.k = 5; %For unsupervised feature selection, you should tune
             %this parameter k, the default k is 5.
             %The parameter for k-NN graph (Default is 5)
options.nUseEigenfunction = d;  %You should tune this parameter.
%Indicate how many eigen functions will be used.
%The number of selected features d;200

FeaNumCandi = [10:10:110];% The number of featuers to be selected

[FeaIndex,FeaNumCandi] = MCFS_p(fea,FeaNumCandi,options);



for i = 1:length(FeaNumCandi)%第一组选10个，第二组选15个。。。共11组
  SelectFeaIdx = FeaIndex{i};  
  feaNew = fea(:,SelectFeaIdx);
  [idx_MCFS] = kmeans(feaNew, c); 
  [FMeasure(i),Accuracy(i)]= Fmeasure(Y',idx_MCFS');
end

output1 = Accuracy;
output2 = FMeasure;
%plot(FMeasure);hold on;plot(Accuracy);
plot(Accuracy,'DisplayName','MCFS');hold on;
end
