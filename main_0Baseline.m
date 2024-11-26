%fea = rand(50,70);
%load('COIL20.mat')
function [output1,output2] = main_0Baseline(X,Y,c,~)


FMeasure_= ones(1,5);
Accuracy_= FMeasure_;
for i = 1 : 5
    [idx_Baseline] = kmeans(X, c); 
    [FMeasure_(i),Accuracy_(i)]= Fmeasure(Y',idx_Baseline');
end

	FMeasure = max(FMeasure_(i));
    Accuracy = max(Accuracy_(i));

output1 = Accuracy;
output2 = FMeasure;
Accuracy = Accuracy*ones(1,11);
%plot(FMeasure);hold on;plot(Accuracy);
plot((1:1:11),Accuracy,'DisplayName','Baseline');hold on;
end


